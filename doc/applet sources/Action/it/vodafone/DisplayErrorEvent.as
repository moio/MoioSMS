package it.vodafone
{
    import flash.events.*;

    public class DisplayErrorEvent extends Event
    {
        public var _messaggio:String;
        public var _option:int;
        public static var RETRY_EVENT:int = 2;
        public static const ERROR_EVENT:String = "error_event";
        public static var CLOSE_EVENT:int = 3;

        public function DisplayErrorEvent(param1:String, param2:int = 0)
        {
            super(ERROR_EVENT, true);
            this._messaggio = param1;
            this._option = param2;
            return;
        }// end function

    }
}
