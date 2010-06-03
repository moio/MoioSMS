package mx.events
{
    import flash.events.*;

    public class AIREvent extends Event
    {
        public static const WINDOW_ACTIVATE:String = "windowActivate";
        public static const APPLICATION_DEACTIVATE:String = "applicationDeactivate";
        public static const WINDOW_COMPLETE:String = "windowComplete";
        public static const APPLICATION_ACTIVATE:String = "applicationActivate";
        public static const WINDOW_DEACTIVATE:String = "windowDeactivate";
        static const VERSION:String = "3.2.0.3958";

        public function AIREvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            return new AIREvent(type, bubbles, cancelable);
        }// end function

    }
}
