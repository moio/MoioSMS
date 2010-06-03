package mx.events
{
    import flash.events.*;

    public class SWFBridgeEvent extends Event
    {
        public var data:Object;
        public static const BRIDGE_FOCUS_MANAGER_ACTIVATE:String = "bridgeFocusManagerActivate";
        public static const BRIDGE_WINDOW_ACTIVATE:String = "bridgeWindowActivate";
        public static const BRIDGE_WINDOW_DEACTIVATE:String = "brdigeWindowDeactivate";
        static const VERSION:String = "3.2.0.3958";
        public static const BRIDGE_NEW_APPLICATION:String = "bridgeNewApplication";
        public static const BRIDGE_APPLICATION_UNLOADING:String = "bridgeApplicationUnloading";
        public static const BRIDGE_APPLICATION_ACTIVATE:String = "bridgeApplicationActivate";

        public function SWFBridgeEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Object = null)
        {
            super(param1, param2, param3);
            this.data = param4;
            return;
        }// end function

        override public function clone() : Event
        {
            return new SWFBridgeEvent(type, bubbles, cancelable, data);
        }// end function

        public static function marshal(event:Event) : SWFBridgeEvent
        {
            var _loc_2:* = event;
            return new SWFBridgeEvent(_loc_2.type, _loc_2.bubbles, _loc_2.cancelable, _loc_2.data);
        }// end function

    }
}
