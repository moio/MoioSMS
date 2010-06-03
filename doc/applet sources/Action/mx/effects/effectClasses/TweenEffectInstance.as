package mx.effects.effectClasses
{
    import mx.core.*;
    import mx.effects.*;
    import mx.events.*;

    public class TweenEffectInstance extends EffectInstance
    {
        private var _seekTime:Number = 0;
        public var easingFunction:Function;
        public var tween:Tween;
        var needToLayout:Boolean = false;
        static const VERSION:String = "3.2.0.3958";

        public function TweenEffectInstance(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function stop() : void
        {
            super.stop();
            if (tween)
            {
                tween.stop();
            }
            return;
        }// end function

        function applyTweenStartValues() : void
        {
            if (duration > 0)
            {
                onTweenUpdate(tween.getCurrentValue(0));
            }
            return;
        }// end function

        override public function get playheadTime() : Number
        {
            if (tween)
            {
                return tween.playheadTime + super.playheadTime;
            }
            return 0;
        }// end function

        protected function createTween(param1:Object, param2:Object, param3:Object, param4:Number = -1, param5:Number = -1) : Tween
        {
            var _loc_6:* = new Tween(param1, param2, param3, param4, param5);
            new Tween(param1, param2, param3, param4, param5).addEventListener(TweenEvent.TWEEN_START, tweenEventHandler);
            _loc_6.addEventListener(TweenEvent.TWEEN_UPDATE, tweenEventHandler);
            _loc_6.addEventListener(TweenEvent.TWEEN_END, tweenEventHandler);
            if (easingFunction != null)
            {
                _loc_6.easingFunction = easingFunction;
            }
            if (_seekTime > 0)
            {
                _loc_6.seek(_seekTime);
            }
            _loc_6.playReversed = playReversed;
            return _loc_6;
        }// end function

        private function tweenEventHandler(event:TweenEvent) : void
        {
            dispatchEvent(event);
            return;
        }// end function

        override public function end() : void
        {
            stopRepeat = true;
            if (delayTimer)
            {
                delayTimer.reset();
            }
            if (tween)
            {
                tween.endTween();
                tween = null;
            }
            return;
        }// end function

        override public function reverse() : void
        {
            super.reverse();
            if (tween)
            {
                tween.reverse();
            }
            super.playReversed = !playReversed;
            return;
        }// end function

        override function set playReversed(param1:Boolean) : void
        {
            super.playReversed = param1;
            if (tween)
            {
                tween.playReversed = param1;
            }
            return;
        }// end function

        override public function resume() : void
        {
            super.resume();
            if (tween)
            {
                tween.resume();
            }
            return;
        }// end function

        public function onTweenEnd(param1:Object) : void
        {
            onTweenUpdate(param1);
            tween = null;
            if (needToLayout)
            {
                UIComponentGlobals.layoutManager.validateNow();
            }
            finishRepeat();
            return;
        }// end function

        public function onTweenUpdate(param1:Object) : void
        {
            return;
        }// end function

        override public function pause() : void
        {
            super.pause();
            if (tween)
            {
                tween.pause();
            }
            return;
        }// end function

        public function seek(param1:Number) : void
        {
            if (tween)
            {
                tween.seek(param1);
            }
            else
            {
                _seekTime = param1;
            }
            return;
        }// end function

    }
}
