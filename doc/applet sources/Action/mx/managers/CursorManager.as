package mx.managers
{
    import mx.core.*;

    public class CursorManager extends Object
    {
        private static var _impl:ICursorManager;
        static const VERSION:String = "3.2.0.3958";
        public static const NO_CURSOR:int = 0;
        private static var implClassDependency:CursorManagerImpl;

        public function CursorManager()
        {
            return;
        }// end function

        public static function set currentCursorYOffset(param1:Number) : void
        {
            impl.currentCursorYOffset = param1;
            return;
        }// end function

        static function registerToUseBusyCursor(param1:Object) : void
        {
            impl.registerToUseBusyCursor(param1);
            return;
        }// end function

        public static function get currentCursorID() : int
        {
            return impl.currentCursorID;
        }// end function

        public static function getInstance() : ICursorManager
        {
            return impl;
        }// end function

        public static function removeBusyCursor() : void
        {
            impl.removeBusyCursor();
            return;
        }// end function

        public static function setCursor(param1:Class, param2:int = 2, param3:Number = 0, param4:Number = 0) : int
        {
            return impl.setCursor(param1, param2, param3, param4);
        }// end function

        public static function set currentCursorID(param1:int) : void
        {
            impl.currentCursorID = param1;
            return;
        }// end function

        static function unRegisterToUseBusyCursor(param1:Object) : void
        {
            impl.unRegisterToUseBusyCursor(param1);
            return;
        }// end function

        private static function get impl() : ICursorManager
        {
            if (!_impl)
            {
                _impl = ICursorManager(Singleton.getInstance("mx.managers::ICursorManager"));
            }
            return _impl;
        }// end function

        public static function removeAllCursors() : void
        {
            impl.removeAllCursors();
            return;
        }// end function

        public static function setBusyCursor() : void
        {
            impl.setBusyCursor();
            return;
        }// end function

        public static function showCursor() : void
        {
            impl.showCursor();
            return;
        }// end function

        public static function hideCursor() : void
        {
            impl.hideCursor();
            return;
        }// end function

        public static function removeCursor(param1:int) : void
        {
            impl.removeCursor(param1);
            return;
        }// end function

        public static function get currentCursorXOffset() : Number
        {
            return impl.currentCursorXOffset;
        }// end function

        public static function get currentCursorYOffset() : Number
        {
            return impl.currentCursorYOffset;
        }// end function

        public static function set currentCursorXOffset(param1:Number) : void
        {
            impl.currentCursorXOffset = param1;
            return;
        }// end function

    }
}
