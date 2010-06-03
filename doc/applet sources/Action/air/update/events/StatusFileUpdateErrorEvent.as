package air.update.events
{
    import flash.events.*;

    public class StatusFileUpdateErrorEvent extends ErrorEvent
    {
        public static const FILE_UPDATE_ERROR:String = "fileUpdateError";

        public function StatusFileUpdateErrorEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:String = "", param5:int = 0)
        {
            super(param1, param2, param3, param4, param5);
            return;
        }// end function

        override public function toString() : String
        {
            return "[StatusFileUpdateErrorEvent (type=" + type + " text=" + text + " id=" + errorID + ")]";
        }// end function

        override public function clone() : Event
        {
            return new StatusFileUpdateErrorEvent(type, bubbles, cancelable, text, errorID);
        }// end function

    }
}
