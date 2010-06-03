package mx.events
{
    import flash.events.*;
    import mx.effects.*;

    public class EffectEvent extends Event
    {
        public var effectInstance:IEffectInstance;
        public static const EFFECT_START:String = "effectStart";
        static const VERSION:String = "3.2.0.3958";
        public static const EFFECT_END:String = "effectEnd";

        public function EffectEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:IEffectInstance = null)
        {
            super(param1, param2, param3);
            this.effectInstance = param4;
            return;
        }// end function

        override public function clone() : Event
        {
            return new EffectEvent(type, bubbles, cancelable, effectInstance);
        }// end function

    }
}
