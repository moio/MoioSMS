package mx.events
{
    import flash.events.*;
    import flash.net.*;

    public class RSLEvent extends ProgressEvent
    {
        public var errorText:String;
        public var rslIndex:int;
        public var rslTotal:int;
        public var url:URLRequest;
        public static const RSL_PROGRESS:String = "rslProgress";
        public static const RSL_ERROR:String = "rslError";
        static const VERSION:String = "3.2.0.3958";
        public static const RSL_COMPLETE:String = "rslComplete";

        public function RSLEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:int = -1, param5:int = -1, param6:int = -1, param7:int = -1, param8:URLRequest = null, param9:String = null)
        {
            super(param1, param2, param3, param4, param5);
            this.rslIndex = param6;
            this.rslTotal = param7;
            this.url = param8;
            this.errorText = param9;
            return;
        }// end function

        override public function clone() : Event
        {
            return new RSLEvent(type, bubbles, cancelable, bytesLoaded, bytesTotal, rslIndex, rslTotal, url, errorText);
        }// end function

    }
}
