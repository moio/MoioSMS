package mx.effects.effectClasses
{
    import mx.core.*;
    import mx.effects.*;

    public class SequenceInstance extends CompositeEffectInstance
    {
        private var startTime:Number = 0;
        private var currentInstanceDuration:Number = 0;
        private var currentSetIndex:int = -1;
        private var currentSet:Array;
        private var activeChildCount:Number;
        static const VERSION:String = "3.2.0.3958";

        public function SequenceInstance(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function stop() : void
        {
            var _loc_1:Array = null;
            var _loc_2:Array = null;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:Array = null;
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            var _loc_10:IEffectInstance = null;
            if (activeEffectQueue && activeEffectQueue.length > 0)
            {
                _loc_1 = activeEffectQueue.concat();
                activeEffectQueue = null;
                _loc_2 = _loc_1[currentSetIndex];
                _loc_3 = _loc_2.length;
                _loc_4 = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    _loc_2[_loc_4].stop();
                    _loc_4++;
                }
                _loc_5 = _loc_1.length;
                _loc_6 = currentSetIndex + 1;
                while (_loc_6 < _loc_5)
                {
                    
                    _loc_7 = _loc_1[_loc_6];
                    _loc_8 = _loc_7.length;
                    _loc_9 = 0;
                    while (_loc_9 < _loc_8)
                    {
                        
                        _loc_10 = _loc_7[_loc_9];
                        _loc_10.effect.deleteInstance(_loc_10);
                        _loc_9++;
                    }
                    _loc_6++;
                }
            }
            super.stop();
            return;
        }// end function

        private function playNextChildSet(param1:Number = 0) : Boolean
        {
            var _loc_2:EffectInstance = null;
            if (!playReversed)
            {
                if (!activeEffectQueue || currentSetIndex++ >= activeEffectQueue.length--)
                {
                    return false;
                }
            }
            else if (currentSetIndex-- <= 0)
            {
                return false;
            }
            var _loc_3:* = activeEffectQueue[currentSetIndex];
            currentSet = [];
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                _loc_2 = _loc_3[_loc_4];
                currentSet.push(_loc_2);
                _loc_2.playReversed = playReversed;
                if (_loc_2.suspendBackgroundProcessing)
                {
                    UIComponent.suspendBackgroundProcessing();
                }
                _loc_2.startEffect();
                _loc_4++;
            }
            currentInstanceDuration = currentInstanceDuration + _loc_2.actualDuration;
            return true;
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
                _loc_1 = _loc_1 + _loc_4[0].actualDuration;
                _loc_3++;
            }
            return _loc_1;
        }// end function

        override public function end() : void
        {
            var _loc_1:Array = null;
            var _loc_2:Array = null;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:Array = null;
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            endEffectCalled = true;
            if (activeEffectQueue && activeEffectQueue.length > 0)
            {
                _loc_1 = activeEffectQueue.concat();
                activeEffectQueue = null;
                _loc_2 = _loc_1[currentSetIndex];
                _loc_3 = _loc_2.length;
                _loc_4 = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    _loc_2[_loc_4].end();
                    _loc_4++;
                }
                _loc_5 = _loc_1.length;
                _loc_6 = currentSetIndex + 1;
                while (_loc_6 < _loc_5)
                {
                    
                    _loc_7 = _loc_1[_loc_6];
                    _loc_8 = _loc_7.length;
                    _loc_9 = 0;
                    while (_loc_9 < _loc_8)
                    {
                        
                        EffectInstance(_loc_7[_loc_9]).playWithNoDuration();
                        _loc_9++;
                    }
                    _loc_6++;
                }
            }
            super.end();
            return;
        }// end function

        override public function reverse() : void
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            super.reverse();
            if (currentSet && currentSet.length > 0)
            {
                _loc_1 = currentSet.length;
                _loc_2 = 0;
                while (_loc_2 < _loc_1)
                {
                    
                    currentSet[_loc_2].reverse();
                    _loc_2++;
                }
            }
            return;
        }// end function

        override protected function onEffectEnd(param1:IEffectInstance) : void
        {
            if (Object(param1).suspendBackgroundProcessing)
            {
                UIComponent.resumeBackgroundProcessing();
            }
            if (endEffectCalled)
            {
                return;
            }
            var _loc_2:int = 0;
            while (_loc_2 < currentSet.length)
            {
                
                if (param1 == currentSet[_loc_2])
                {
                    currentSet.splice(_loc_2, 1);
                    break;
                }
                _loc_2++;
            }
            if (currentSet.length == 0)
            {
                if (playNextChildSet() == false)
                {
                    finishRepeat();
                }
            }
            return;
        }// end function

        override public function resume() : void
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            super.resume();
            if (currentSet && currentSet.length > 0)
            {
                _loc_1 = currentSet.length;
                _loc_2 = 0;
                while (_loc_2 < _loc_1)
                {
                    
                    currentSet[_loc_2].resume();
                    _loc_2++;
                }
            }
            return;
        }// end function

        override public function play() : void
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:Array = null;
            activeEffectQueue = [];
            currentSetIndex = playReversed ? (childSets.length) : (-1);
            _loc_1 = childSets.length;
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_5 = childSets[_loc_2];
                activeEffectQueue.push(_loc_5);
                _loc_2++;
            }
            super.play();
            startTime = Tween.intervalTime;
            if (activeEffectQueue.length == 0)
            {
                finishRepeat();
                return;
            }
            playNextChildSet();
            return;
        }// end function

        override public function pause() : void
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            super.pause();
            if (currentSet && currentSet.length > 0)
            {
                _loc_1 = currentSet.length;
                _loc_2 = 0;
                while (_loc_2 < _loc_1)
                {
                    
                    currentSet[_loc_2].pause();
                    _loc_2++;
                }
            }
            return;
        }// end function

    }
}
