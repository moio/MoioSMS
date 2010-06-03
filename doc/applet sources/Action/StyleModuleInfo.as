package 
{
    import mx.modules.*;
    import mx.styles.*;

    private class StyleModuleInfo extends Object
    {
        public var errorHandler:Function;
        public var readyHandler:Function;
        public var module:IModuleInfo;
        public var styleModule:IStyleModule;

        private function StyleModuleInfo(param1:IModuleInfo, param2:Function, param3:Function)
        {
            this.module = param1;
            this.readyHandler = param2;
            this.errorHandler = param3;
            return;
        }// end function

    }
}
