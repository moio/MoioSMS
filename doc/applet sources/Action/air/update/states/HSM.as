package air.update.states
{
    import flash.errors.*;
    import flash.events.*;
    import flash.utils.*;

    public class HSM extends EventDispatcher
    {
        private var asyncTimer:Timer;
        private var _hsmState:Function;

        public function HSM(param1:Function) : void
        {
            _hsmState = param1;
            return;
        }// end function

        public function init() : void
        {
            try
            {
                _hsmState(new HSMEvent(HSMEvent.ENTER));
            }
            catch (e:Error)
            {
                _hsmState(new ErrorEvent(ErrorEvent.ERROR, false, false, e.message, e.errorID));
            }
            return;
        }// end function

        protected function get stateHSM() : Function
        {
            return _hsmState;
        }// end function

        protected function transition(param1:Function) : void
        {
            var state:* = param1;
            asyncTimer = null;
            try
            {
                _hsmState(new HSMEvent(HSMEvent.EXIT));
                _hsmState = state;
                _hsmState(new HSMEvent(HSMEvent.ENTER));
            }
            catch (e:Error)
            {
                _hsmState(new ErrorEvent(ErrorEvent.ERROR, false, false, "Unhandled exception " + e.name + ": " + e.message, e.errorID));
            }
            return;
        }// end function

        protected function transitionAsync(param1:Function) : void
        {
            var state:* = param1;
            if (asyncTimer)
            {
                throw new IllegalOperationError("async transition already queued");
            }
            asyncTimer = new Timer(0, 1);
            asyncTimer.addEventListener(TimerEvent.TIMER, function (event:Event) : void
            {
                transition(state);
                return;
            }// end function
            );
            asyncTimer.start();
            return;
        }// end function

        public function dispatch(event:Event) : void
        {
            var event:* = event;
            try
            {
                _hsmState(event);
            }
            catch (e:Error)
            {
                _hsmState(new ErrorEvent(ErrorEvent.ERROR, false, false, e.message, e.errorID));
            }
            return;
        }// end function

    }
}
