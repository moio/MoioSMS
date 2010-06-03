package mx.effects.effectClasses
{
    import flash.events.*;
    import mx.effects.*;
    import mx.events.*;

    public class CompositeEffectInstance extends EffectInstance
    {
        var childSets:Array;
        var activeEffectQueue:Array;
        private var _playheadTime:Number = 0;
        var timerTween:Tween;
        var endEffectCalled:Boolean;
        static const VERSION:String = "3.2.0.3958";

        public function CompositeEffectInstance(param1:Object)
        {
            activeEffectQueue = [];
            childSets = [];
            super(param1);
            return;
        }// end function

        override public function get playheadTime() : Number
        {
            return _playheadTime + super.playheadTime;
        }// end function

        override function get actualDuration() : Number
        {
            var _loc_1:* = NaN;
            if (repeatCount > 0)
            {
                _loc_1 = durationWithoutRepeat * repeatCount + (repeatDelay * repeatCount)-- + startDelay;
            }
            return _loc_1;
        }// end function

        override public function play() : void
        {
            timerTween = new Tween(this, 0, 0, durationWithoutRepeat);
            super.play();
            return;
        }// end function

        override public function finishEffect() : void
        {
            activeEffectQueue = null;
            super.finishEffect();
            return;
        }// end function

        function hasRotateInstance() : Boolean
        {
            var _loc_1:int = 0;
            var _loc_2:CompositeEffectInstance = null;
            if (childSets)
            {
                _loc_1 = 0;
                while (_loc_1 < childSets.length)
                {
                    
                    if (childSets[_loc_1].length > 0)
                    {
                        _loc_2 = childSets[_loc_1][0] as CompositeEffectInstance;
                        if (childSets[_loc_1][0] is RotateInstance || _loc_2 && _loc_2.hasRotateInstance())
                        {
                            return true;
                        }
                    }
                    _loc_1++;
                }
            }
            return false;
        }// end function

        function get durationWithoutRepeat() : Number
        {
            return 0;
        }// end function

        override public function initEffect(event:Event) : void
        {
            var _loc_4:Array = null;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            super.initEffect(event);
            var _loc_2:* = childSets.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = childSets[_loc_3];
                _loc_5 = _loc_4.length;
                _loc_6 = 0;
                while (_loc_6 < _loc_5)
                {
                    
                    _loc_4[_loc_6].initEffect(event);
                    _loc_6++;
                }
                _loc_3++;
            }
            return;
        }// end function

        override public function stop() : void
        {
            super.stop();
            if (timerTween)
            {
                timerTween.stop();
            }
            return;
        }// end function

        override public function reverse() : void
        {
            super.reverse();
            super.playReversed = !playReversed;
            if (timerTween)
            {
                timerTween.reverse();
            }
            return;
        }// end function

        public function addChildSet(param1:Array) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            if (param1)
            {
                _loc_2 = param1.length;
                if (_loc_2 > 0)
                {
                    if (!childSets)
                    {
                        childSets = [param1];
                    }
                    else
                    {
                        childSets.push(param1);
                    }
                    _loc_3 = 0;
                    while (_loc_3 < _loc_2)
                    {
                        
                        param1[_loc_3].addEventListener(EffectEvent.EFFECT_END, effectEndHandler);
                        param1[_loc_3].parentCompositeEffectInstance = this;
                        _loc_3++;
                    }
                }
            }
            return;
        }// end function

        protected function onEffectEnd(param1:IEffectInstance) : void
        {
            return;
        }// end function

        override function playWithNoDuration() : void
        {
            super.playWithNoDuration();
            end();
            return;
        }// end function

        public function onTweenUpdate(param1:Object) : void
        {
            _playheadTime = timerTween ? (timerTween.playheadTime) : (_playheadTime);
            return;
        }// end function

        override public function pause() : void
        {
            super.pause();
            if (timerTween)
            {
                timerTween.pause();
            }
            return;
        }// end function

        function effectEndHandler(event:EffectEvent) : void
        {
            onEffectEnd(event.effectInstance);
            return;
        }// end function

        override public function resume() : void
        {
            super.resume();
            if (timerTween)
            {
                timerTween.resume();
            }
            return;
        }// end function

        public function onTweenEnd(param1:Object) : void
        {
            _playheadTime = timerTween ? (timerTween.playheadTime) : (_playheadTime);
            return;
        }// end function

    }
}
