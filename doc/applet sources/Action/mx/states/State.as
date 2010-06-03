package mx.states
{
    import flash.events.*;
    import mx.events.*;

    public class State extends EventDispatcher
    {
        public var basedOn:String;
        private var initialized:Boolean = false;
        public var overrides:Array;
        public var name:String;
        static const VERSION:String = "3.2.0.3958";

        public function State()
        {
            overrides = [];
            return;
        }// end function

        function initialize() : void
        {
            var _loc_1:int = 0;
            if (!initialized)
            {
                initialized = true;
                _loc_1 = 0;
                while (_loc_1 < overrides.length)
                {
                    
                    IOverride(overrides[_loc_1]).initialize();
                    _loc_1++;
                }
            }
            return;
        }// end function

        function dispatchExitState() : void
        {
            dispatchEvent(new FlexEvent(FlexEvent.EXIT_STATE));
            return;
        }// end function

        function dispatchEnterState() : void
        {
            dispatchEvent(new FlexEvent(FlexEvent.ENTER_STATE));
            return;
        }// end function

    }
}
