package mx.events
{
    import flash.events.*;

    public class ValidationResultEvent extends Event
    {
        public var results:Array;
        public var field:String;
        public static const INVALID:String = "invalid";
        static const VERSION:String = "3.2.0.3958";
        public static const VALID:String = "valid";

        public function ValidationResultEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:String = null, param5:Array = null)
        {
            super(param1, param2, param3);
            this.field = param4;
            this.results = param5;
            return;
        }// end function

        public function get message() : String
        {
            var _loc_1:String = "";
            var _loc_2:* = results.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (results[_loc_3].isError)
                {
                    _loc_1 = _loc_1 + (_loc_1 == "" ? ("") : ("\n"));
                    _loc_1 = _loc_1 + results[_loc_3].errorMessage;
                }
                _loc_3++;
            }
            return _loc_1;
        }// end function

        override public function clone() : Event
        {
            return new ValidationResultEvent(type, bubbles, cancelable, field, results);
        }// end function

    }
}
