package mx.events
{
    import flash.events.*;

    public class TweenEvent extends Event
    {
        public var value:Object;
        public static const TWEEN_END:String = "tweenEnd";
        static const VERSION:String = "3.2.0.3958";
        public static const TWEEN_UPDATE:String = "tweenUpdate";
        public static const TWEEN_START:String = "tweenStart";

        public function TweenEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Object = null)
        {
            super(param1, param2, param3);
            this.value = param4;
            return;
        }// end function

        override public function clone() : Event
        {
            return new TweenEvent(type, bubbles, cancelable, value);
        }// end function

    }
}
