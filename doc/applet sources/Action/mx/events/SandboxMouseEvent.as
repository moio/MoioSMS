package mx.events
{
    import flash.events.*;

    public class SandboxMouseEvent extends Event
    {
        public var buttonDown:Boolean;
        public var altKey:Boolean;
        public var ctrlKey:Boolean;
        public var shiftKey:Boolean;
        public static const CLICK_SOMEWHERE:String = "clickSomewhere";
        public static const MOUSE_UP_SOMEWHERE:String = "mouseUpSomewhere";
        public static const DOUBLE_CLICK_SOMEWHERE:String = "coubleClickSomewhere";
        public static const MOUSE_WHEEL_SOMEWHERE:String = "mouseWheelSomewhere";
        public static const MOUSE_DOWN_SOMEWHERE:String = "mouseDownSomewhere";
        static const VERSION:String = "3.2.0.3958";
        public static const MOUSE_MOVE_SOMEWHERE:String = "mouseMoveSomewhere";

        public function SandboxMouseEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false, param7:Boolean = false)
        {
            super(param1, param2, param3);
            this.ctrlKey = param4;
            this.altKey = param5;
            this.shiftKey = param6;
            this.buttonDown = param7;
            return;
        }// end function

        override public function clone() : Event
        {
            return new SandboxMouseEvent(type, bubbles, cancelable, ctrlKey, altKey, shiftKey, buttonDown);
        }// end function

        public static function marshal(event:Event) : SandboxMouseEvent
        {
            var _loc_2:* = event;
            return new SandboxMouseEvent(_loc_2.type, _loc_2.bubbles, _loc_2.cancelable, _loc_2.ctrlKey, _loc_2.altKey, _loc_2.shiftKey, _loc_2.buttonDown);
        }// end function

    }
}
