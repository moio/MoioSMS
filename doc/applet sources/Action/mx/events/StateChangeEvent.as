package mx.events
{
    import flash.events.*;

    public class StateChangeEvent extends Event
    {
        public var newState:String;
        public var oldState:String;
        public static const CURRENT_STATE_CHANGING:String = "currentStateChanging";
        public static const CURRENT_STATE_CHANGE:String = "currentStateChange";
        static const VERSION:String = "3.2.0.3958";

        public function StateChangeEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:String = null, param5:String = null)
        {
            super(param1, param2, param3);
            this.oldState = param4;
            this.newState = param5;
            return;
        }// end function

        override public function clone() : Event
        {
            return new StateChangeEvent(type, bubbles, cancelable, oldState, newState);
        }// end function

    }
}
