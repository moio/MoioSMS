package 
{
    import mx.modules.*;
    import mx.resources.*;

    private class ResourceModuleInfo extends Object
    {
        public var resourceModule:IResourceModule;
        public var errorHandler:Function;
        public var readyHandler:Function;
        public var moduleInfo:IModuleInfo;

        private function ResourceModuleInfo(param1:IModuleInfo, param2:Function, param3:Function)
        {
            this.moduleInfo = param1;
            this.readyHandler = param2;
            this.errorHandler = param3;
            return;
        }// end function

    }
}
