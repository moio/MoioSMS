package mx.events
{
    import flash.events.*;

    public class ScrollEvent extends Event
    {
        public var detail:String;
        public var delta:Number;
        public var position:Number;
        public var direction:String;
        static const VERSION:String = "3.2.0.3958";
        public static const SCROLL:String = "scroll";

        public function ScrollEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:String = null, param5:Number = 1.#QNAN, param6:String = null, param7:Number = 1.#QNAN)
        {
            super(param1, param2, param3);
            this.detail = param4;
            this.position = param5;
            this.direction = param6;
            this.delta = param7;
            return;
        }// end function

        override public function clone() : Event
        {
            return new ScrollEvent(type, bubbles, cancelable, detail, position, direction, delta);
        }// end function

    }
}
