package mx.events
{
    import flash.events.*;

    public class MoveEvent extends Event
    {
        public var oldX:Number;
        public var oldY:Number;
        static const VERSION:String = "3.2.0.3958";
        public static const MOVE:String = "move";

        public function MoveEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Number = 1.#QNAN, param5:Number = 1.#QNAN)
        {
            super(param1, param2, param3);
            this.oldX = param4;
            this.oldY = param5;
            return;
        }// end function

        override public function clone() : Event
        {
            return new MoveEvent(type, bubbles, cancelable, oldX, oldY);
        }// end function

    }
}
