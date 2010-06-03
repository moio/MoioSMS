package mx.core
{
    import flash.events.*;
    import mx.events.*;
    import mx.resources.*;

    public class ResourceModuleRSLItem extends RSLItem
    {
        static const VERSION:String = "3.2.0.3958";

        public function ResourceModuleRSLItem(param1:String)
        {
            super(param1);
            return;
        }// end function

        private function resourceErrorHandler(event:ResourceEvent) : void
        {
            var _loc_2:* = new IOErrorEvent(IOErrorEvent.IO_ERROR);
            _loc_2.text = event.errorText;
            super.itemErrorHandler(_loc_2);
            return;
        }// end function

        override public function load(param1:Function, param2:Function, param3:Function, param4:Function, param5:Function) : void
        {
            chainedProgressHandler = param1;
            chainedCompleteHandler = param2;
            chainedIOErrorHandler = param3;
            chainedSecurityErrorHandler = param4;
            chainedRSLErrorHandler = param5;
            var _loc_6:* = ResourceManager.getInstance();
            var _loc_7:* = ResourceManager.getInstance().loadResourceModule(url);
            ResourceManager.getInstance().loadResourceModule(url).addEventListener(ResourceEvent.PROGRESS, itemProgressHandler);
            _loc_7.addEventListener(ResourceEvent.COMPLETE, itemCompleteHandler);
            _loc_7.addEventListener(ResourceEvent.ERROR, resourceErrorHandler);
            return;
        }// end function

    }
}
