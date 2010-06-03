package mx.events
{
    import flash.events.*;

    public class EventListenerRequest extends SWFBridgeRequest
    {
        private var _priority:int;
        private var _useWeakReference:Boolean;
        private var _eventType:String;
        private var _useCapture:Boolean;
        public static const REMOVE_EVENT_LISTENER_REQUEST:String = "removeEventListenerRequest";
        public static const ADD_EVENT_LISTENER_REQUEST:String = "addEventListenerRequest";
        static const VERSION:String = "3.2.0.3958";

        public function EventListenerRequest(param1:String, param2:Boolean = false, param3:Boolean = true, param4:String = null, param5:Boolean = false, param6:int = 0, param7:Boolean = false)
        {
            super(param1, false, false);
            _eventType = param4;
            _useCapture = param5;
            _priority = param6;
            _useWeakReference = param7;
            return;
        }// end function

        public function get priority() : int
        {
            return _priority;
        }// end function

        public function get useWeakReference() : Boolean
        {
            return _useWeakReference;
        }// end function

        public function get eventType() : String
        {
            return _eventType;
        }// end function

        override public function clone() : Event
        {
            return new EventListenerRequest(type, bubbles, cancelable, eventType, useCapture, priority, useWeakReference);
        }// end function

        public function get useCapture() : Boolean
        {
            return _useCapture;
        }// end function

        public static function marshal(event:Event) : EventListenerRequest
        {
            var _loc_2:* = event;
            return new EventListenerRequest(_loc_2.type, _loc_2.bubbles, _loc_2.cancelable, _loc_2.eventType, _loc_2.useCapture, _loc_2.priority, _loc_2.useWeakReference);
        }// end function

    }
}
