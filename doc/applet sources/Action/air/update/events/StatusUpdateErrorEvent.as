package air.update.events
{
    import flash.events.*;

    public class StatusUpdateErrorEvent extends ErrorEvent
    {
        public var subErrorID:int = 0;
        public static const UPDATE_ERROR:String = "updateError";

        public function StatusUpdateErrorEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:String = "", param5:int = 0, param6:int = 0)
        {
            super(param1, param2, param3, param4, param5);
            this.subErrorID = param6;
            return;
        }// end function

        override public function toString() : String
        {
            return "[StatusUpdateErrorEvent (type=" + type + " text=" + text + " id=" + errorID + " + subErrorID=" + subErrorID + ")]";
        }// end function

        override public function clone() : Event
        {
            return new StatusUpdateErrorEvent(type, bubbles, cancelable, text, errorID, subErrorID);
        }// end function

    }
}
