package mx.events
{
    import flash.events.*;
    import flash.geom.*;

    public class FlexNativeWindowBoundsEvent extends NativeWindowBoundsEvent
    {
        public static const WINDOW_MOVE:String = "windowMove";
        public static const WINDOW_RESIZE:String = "windowResize";

        public function FlexNativeWindowBoundsEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Rectangle = null, param5:Rectangle = null)
        {
            super(param1, param2, param3, param4, param5);
            return;
        }// end function

        override public function clone() : Event
        {
            return new FlexNativeWindowBoundsEvent(type, bubbles, cancelable, beforeBounds, afterBounds);
        }// end function

    }
}
