package mx.events
{
    import flash.events.*;

    public class ResizeEvent extends Event
    {
        public var oldHeight:Number;
        public var oldWidth:Number;
        static const VERSION:String = "3.2.0.3958";
        public static const RESIZE:String = "resize";

        public function ResizeEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Number = 1.#QNAN, param5:Number = 1.#QNAN)
        {
            super(param1, param2, param3);
            this.oldWidth = param4;
            this.oldHeight = param5;
            return;
        }// end function

        override public function clone() : Event
        {
            return new ResizeEvent(type, bubbles, cancelable, oldWidth, oldHeight);
        }// end function

    }
}
