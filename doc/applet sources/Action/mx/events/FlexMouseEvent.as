package mx.events
{
    import flash.display.*;
    import flash.events.*;

    public class FlexMouseEvent extends MouseEvent
    {
        public static const MOUSE_DOWN_OUTSIDE:String = "mouseDownOutside";
        public static const MOUSE_WHEEL_OUTSIDE:String = "mouseWheelOutside";
        static const VERSION:String = "3.2.0.3958";

        public function FlexMouseEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Number = 0, param5:Number = 0, param6:InteractiveObject = null, param7:Boolean = false, param8:Boolean = false, param9:Boolean = false, param10:Boolean = false, param11:int = 0)
        {
            super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
            return;
        }// end function

        override public function clone() : Event
        {
            return new FlexMouseEvent(type, bubbles, cancelable, localX, localY, relatedObject, ctrlKey, altKey, shiftKey, buttonDown, delta);
        }// end function

    }
}
