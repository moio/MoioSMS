package mx.events
{
    import flash.events.*;
    import mx.modules.*;

    public class ModuleEvent extends ProgressEvent
    {
        public var errorText:String;
        private var _module:IModuleInfo;
        public static const READY:String = "ready";
        public static const ERROR:String = "error";
        public static const PROGRESS:String = "progress";
        static const VERSION:String = "3.2.0.3958";
        public static const SETUP:String = "setup";
        public static const UNLOAD:String = "unload";

        public function ModuleEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:uint = 0, param5:uint = 0, param6:String = null, param7:IModuleInfo = null)
        {
            super(param1, param2, param3, param4, param5);
            this.errorText = param6;
            this._module = param7;
            return;
        }// end function

        public function get module() : IModuleInfo
        {
            if (_module)
            {
                return _module;
            }
            return target as IModuleInfo;
        }// end function

        override public function clone() : Event
        {
            return new ModuleEvent(type, bubbles, cancelable, bytesLoaded, bytesTotal, errorText, module);
        }// end function

    }
}
