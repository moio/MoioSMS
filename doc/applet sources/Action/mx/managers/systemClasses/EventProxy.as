package mx.managers.systemClasses
{
    import flash.events.*;
    import mx.events.*;
    import mx.managers.*;
    import mx.utils.*;

    public class EventProxy extends EventDispatcher
    {
        private var systemManager:ISystemManager;

        public function EventProxy(param1:ISystemManager)
        {
            this.systemManager = param1;
            return;
        }// end function

        public function marshalListener(event:Event) : void
        {
            var _loc_2:MouseEvent = null;
            var _loc_3:SandboxMouseEvent = null;
            if (event is MouseEvent)
            {
                _loc_2 = event as MouseEvent;
                _loc_3 = new SandboxMouseEvent(EventUtil.mouseEventMap[event.type], false, false, _loc_2.ctrlKey, _loc_2.altKey, _loc_2.shiftKey, _loc_2.buttonDown);
                systemManager.dispatchEventFromSWFBridges(_loc_3, null, true, true);
            }
            return;
        }// end function

    }
}
