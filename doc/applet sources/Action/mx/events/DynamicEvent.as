package mx.events
{
    import flash.events.*;

    dynamic public class DynamicEvent extends Event
    {
        static const VERSION:String = "3.2.0.3958";

        public function DynamicEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_2:String = null;
            var _loc_1:* = new DynamicEvent(type, bubbles, cancelable);
            for (_loc_2 in this)
            {
                
                _loc_1[_loc_2] = this[_loc_2];
            }
            return _loc_1;
        }// end function

    }
}
