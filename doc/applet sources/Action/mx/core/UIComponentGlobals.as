package mx.core
{
    import flash.display.*;
    import flash.geom.*;
    import mx.managers.*;

    public class UIComponentGlobals extends Object
    {
        static var callLaterSuspendCount:int = 0;
        static var layoutManager:ILayoutManager;
        static var nextFocusObject:InteractiveObject;
        static var designTime:Boolean = false;
        static var tempMatrix:Matrix = new Matrix();
        static var callLaterDispatcherCount:int = 0;
        private static var _catchCallLaterExceptions:Boolean = false;

        public function UIComponentGlobals()
        {
            return;
        }// end function

        public static function set catchCallLaterExceptions(param1:Boolean) : void
        {
            _catchCallLaterExceptions = param1;
            return;
        }// end function

        public static function get designMode() : Boolean
        {
            return designTime;
        }// end function

        public static function set designMode(param1:Boolean) : void
        {
            designTime = param1;
            return;
        }// end function

        public static function get catchCallLaterExceptions() : Boolean
        {
            return _catchCallLaterExceptions;
        }// end function

    }
}
