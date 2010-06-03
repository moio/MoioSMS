package air.update.events
{
    import flash.events.*;

    public class StatusUpdateEvent extends UpdateEvent
    {
        public var details:Array;
        public var version:String = "";
        public var available:Boolean = false;
        public static const UPDATE_STATUS:String = "updateStatus";

        public function StatusUpdateEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false, param5:String = "", param6:Array = null)
        {
            details = [];
            super(param1, param2, param3);
            this.available = param4;
            this.version = param5;
            this.details = param6 == null ? ([]) : (param6);
            return;
        }// end function

        override public function toString() : String
        {
            return "[StatusUpdateEvent (type=" + type + " available=" + available + " version=" + version + " details=" + details + " )]";
        }// end function

        override public function clone() : Event
        {
            return new StatusUpdateEvent(type, bubbles, cancelable, available, version, details);
        }// end function

    }
}
