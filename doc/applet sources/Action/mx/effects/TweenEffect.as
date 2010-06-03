package mx.effects
{
    import flash.events.*;
    import mx.effects.effectClasses.*;
    import mx.events.*;

    public class TweenEffect extends Effect
    {
        public var easingFunction:Function = null;
        static const VERSION:String = "3.2.0.3958";

        public function TweenEffect(param1:Object = null)
        {
            super(param1);
            instanceClass = TweenEffectInstance;
            return;
        }// end function

        protected function tweenEventHandler(event:TweenEvent) : void
        {
            dispatchEvent(event);
            return;
        }// end function

        override protected function initInstance(param1:IEffectInstance) : void
        {
            super.initInstance(param1);
            TweenEffectInstance(param1).easingFunction = easingFunction;
            EventDispatcher(param1).addEventListener(TweenEvent.TWEEN_START, tweenEventHandler);
            EventDispatcher(param1).addEventListener(TweenEvent.TWEEN_UPDATE, tweenEventHandler);
            EventDispatcher(param1).addEventListener(TweenEvent.TWEEN_END, tweenEventHandler);
            return;
        }// end function

    }
}
