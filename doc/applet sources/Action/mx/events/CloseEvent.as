package mx.events
{
    import flash.events.*;

    public class CloseEvent extends Event
    {
        public var detail:int;
        static const VERSION:String = "3.2.0.3958";
        public static const CLOSE:String = "close";

        public function CloseEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:int = -1)
        {
            super(param1, param2, param3);
            this.detail = param4;
            return;
        }// end function

        override public function clone() : Event
        {
            return new CloseEvent(type, bubbles, cancelable, detail);
        }// end function

    }
}
