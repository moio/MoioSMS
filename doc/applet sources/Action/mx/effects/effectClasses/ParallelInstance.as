package mx.effects.effectClasses
{
    import flash.events.*;
    import flash.utils.*;
    import mx.core.*;
    import mx.effects.*;

    public class ParallelInstance extends CompositeEffectInstance
    {
        private var timer:Timer;
        private var isReversed:Boolean = false;
        private var replayEffectQueue:Array;
        private var doneEffectQueue:Array;
        static const VERSION:String = "3.2.0.3958";

        public function ParallelInstance(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function stop() : void
        {
            var _loc_1:Array = null;
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            stopTimer();
            if (activeEffectQueue)
            {
                _loc_1 = activeEffectQueue.concat();
                activeEffectQueue = null;
                _loc_2 = _loc_1.length;
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    if (_loc_1[_loc_3])
                    {
                        _loc_1[_loc_3].stop();
                    }
                    _loc_3++;
                }
            }
            super.stop();
            return;
        }// end function

        private function startTimer() : void
        {
            if (!timer)
            {
                timer = new Timer(10);
                timer.addEventListener(TimerEvent.TIMER, timerHandler);
            }
            timer.start();
            return;
        }// end function

        override function get durationWithoutRepeat() : Number
        {
            var _loc_4:Array = null;
            var _loc_1:Number = 0;
            var _loc_2:* = childSets.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = childSets[_loc_3];
                _loc_1 = Math.max(_loc_4[0].actualDuration, _loc_1);
                _loc_3++;
            }
            return _loc_1;
        }// end function

        private function timerHandler(event:TimerEvent) : void
        {
            var _loc_5:EffectInstance = null;
            var _loc_2:* = durationWithoutRepeat - playheadTime;
            var _loc_3:* = replayEffectQueue.length;
            if (_loc_3 == 0)
            {
                stopTimer();
                return;
            }
            while (_loc_4-- >= 0)
            {
                
                _loc_5 = replayEffectQueue[_loc_3--];
                if (_loc_2 <= _loc_5.actualDuration)
                {
                    activeEffectQueue.push(_loc_5);
                    replayEffectQueue.splice(_loc_4, 1);
                    _loc_5.playReversed = playReversed;
                    _loc_5.startEffect();
                }
            }
            return;
        }// end function

        private function stopTimer() : void
        {
            if (timer)
            {
                timer.reset();
            }
            return;
        }// end function

        override public function addChildSet(param1:Array) : void
        {
            var _loc_2:CompositeEffectInstance = null;
            super.addChildSet(param1);
            if (param1.length > 0)
            {
                _loc_2 = param1[0] as CompositeEffectInstance;
                if (param1[0] is RotateInstance || _loc_2 != null && _loc_2.hasRotateInstance())
                {
                    childSets.pop();
                    childSets.unshift(param1);
                }
            }
            return;
        }// end function

        override public function reverse() : void
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            super.reverse();
            if (isReversed)
            {
                _loc_1 = activeEffectQueue.length;
                _loc_2 = 0;
                while (_loc_2 < _loc_1)
                {
                    
                    activeEffectQueue[_loc_2].reverse();
                    _loc_2++;
                }
                stopTimer();
            }
            else
            {
                replayEffectQueue = doneEffectQueue.splice(0);
                _loc_1 = activeEffectQueue.length;
                _loc_2 = 0;
                while (_loc_2 < _loc_1)
                {
                    
                    activeEffectQueue[_loc_2].reverse();
                    _loc_2++;
                }
                startTimer();
            }
            isReversed = !isReversed;
            return;
        }// end function

        override public function end() : void
        {
            var _loc_1:Array = null;
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            endEffectCalled = true;
            stopTimer();
            if (activeEffectQueue)
            {
                _loc_1 = activeEffectQueue.concat();
                activeEffectQueue = null;
                _loc_2 = _loc_1.length;
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    if (_loc_1[_loc_3])
                    {
                        _loc_1[_loc_3].end();
                    }
                    _loc_3++;
                }
            }
            super.end();
            return;
        }// end function

        override protected function onEffectEnd(param1:IEffectInstance) : void
        {
            if (Object(param1).suspendBackgroundProcessing)
            {
                UIComponent.resumeBackgroundProcessing();
            }
            if (endEffectCalled || activeEffectQueue == null)
            {
                return;
            }
            var _loc_2:* = activeEffectQueue.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (param1 == activeEffectQueue[_loc_3])
                {
                    doneEffectQueue.push(param1);
                    activeEffectQueue.splice(_loc_3, 1);
                    break;
                }
                _loc_3++;
            }
            if (_loc_2 == 1)
            {
                finishRepeat();
            }
            return;
        }// end function

        override public function resume() : void
        {
            super.resume();
            var _loc_1:* = activeEffectQueue.length;
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1)
            {
                
                activeEffectQueue[_loc_2].resume();
                _loc_2++;
            }
            return;
        }// end function

        override public function play() : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:Array = null;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:EffectInstance = null;
            var _loc_8:Array = null;
            doneEffectQueue = [];
            activeEffectQueue = [];
            replayEffectQueue = [];
            var _loc_1:Boolean = false;
            super.play();
            _loc_2 = childSets.length;
            _loc_3 = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = childSets[_loc_3];
                _loc_5 = _loc_4.length;
                _loc_6 = 0;
                while (_loc_6 < _loc_5 && activeEffectQueue != null)
                {
                    
                    _loc_7 = _loc_4[_loc_6];
                    if (playReversed && _loc_7.actualDuration < durationWithoutRepeat)
                    {
                        replayEffectQueue.push(_loc_7);
                        startTimer();
                    }
                    else
                    {
                        _loc_7.playReversed = playReversed;
                        activeEffectQueue.push(_loc_7);
                    }
                    if (_loc_7.suspendBackgroundProcessing)
                    {
                        UIComponent.suspendBackgroundProcessing();
                    }
                    _loc_6++;
                }
                _loc_3++;
            }
            if (activeEffectQueue.length > 0)
            {
                _loc_8 = activeEffectQueue.slice(0);
                _loc_3 = 0;
                while (_loc_3 < _loc_8.length)
                {
                    
                    _loc_8[_loc_3].startEffect();
                    _loc_3++;
                }
            }
            return;
        }// end function

        override public function pause() : void
        {
            super.pause();
            var _loc_1:* = activeEffectQueue.length;
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1)
            {
                
                activeEffectQueue[_loc_2].pause();
                _loc_2++;
            }
            return;
        }// end function

    }
}
