package mx.events
{
    import flash.events.*;

    public class InterManagerRequest extends Event
    {
        public var value:Object;
        public var name:String;
        public static const TOOLTIP_MANAGER_REQUEST:String = "tooltipManagerRequest";
        public static const SYSTEM_MANAGER_REQUEST:String = "systemManagerRequest";
        public static const INIT_MANAGER_REQUEST:String = "initManagerRequest";
        public static const DRAG_MANAGER_REQUEST:String = "dragManagerRequest";
        public static const CURSOR_MANAGER_REQUEST:String = "cursorManagerRequest";
        static const VERSION:String = "3.2.0.3958";

        public function InterManagerRequest(param1:String, param2:Boolean = false, param3:Boolean = false, param4:String = null, param5:Object = null)
        {
            super(param1, param2, param3);
            this.name = param4;
            this.value = param5;
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new InterManagerRequest(type, bubbles, cancelable, name, value);
            return _loc_1;
        }// end function

    }
}
