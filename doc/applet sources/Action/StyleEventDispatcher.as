package 
{
    import flash.events.*;
    import mx.events.*;
    import mx.modules.*;

    private class StyleEventDispatcher extends EventDispatcher
    {

        private function StyleEventDispatcher(param1:IModuleInfo)
        {
            param1.addEventListener(ModuleEvent.ERROR, moduleInfo_errorHandler, false, 0, true);
            param1.addEventListener(ModuleEvent.PROGRESS, moduleInfo_progressHandler, false, 0, true);
            param1.addEventListener(ModuleEvent.READY, moduleInfo_readyHandler, false, 0, true);
            return;
        }// end function

        private function moduleInfo_progressHandler(event:ModuleEvent) : void
        {
            var _loc_2:* = new StyleEvent(StyleEvent.PROGRESS, event.bubbles, event.cancelable);
            _loc_2.bytesLoaded = event.bytesLoaded;
            _loc_2.bytesTotal = event.bytesTotal;
            dispatchEvent(_loc_2);
            return;
        }// end function

        private function moduleInfo_readyHandler(event:ModuleEvent) : void
        {
            var _loc_2:* = new StyleEvent(StyleEvent.COMPLETE);
            dispatchEvent(_loc_2);
            return;
        }// end function

        private function moduleInfo_errorHandler(event:ModuleEvent) : void
        {
            var _loc_2:* = new StyleEvent(StyleEvent.ERROR, event.bubbles, event.cancelable);
            _loc_2.bytesLoaded = event.bytesLoaded;
            _loc_2.bytesTotal = event.bytesTotal;
            _loc_2.errorText = event.errorText;
            dispatchEvent(_loc_2);
            return;
        }// end function

    }
}
