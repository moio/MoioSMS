package mx.managers
{
    import flash.display.*;
    import mx.core.*;

    public class PopUpManager extends Object
    {
        private static var implClassDependency:PopUpManagerImpl;
        private static var _impl:IPopUpManager;
        static const VERSION:String = "3.2.0.3958";

        public function PopUpManager()
        {
            return;
        }// end function

        private static function get impl() : IPopUpManager
        {
            if (!_impl)
            {
                _impl = IPopUpManager(Singleton.getInstance("mx.managers::IPopUpManager"));
            }
            return _impl;
        }// end function

        public static function removePopUp(param1:IFlexDisplayObject) : void
        {
            impl.removePopUp(param1);
            return;
        }// end function

        public static function addPopUp(param1:IFlexDisplayObject, param2:DisplayObject, param3:Boolean = false, param4:String = null) : void
        {
            impl.addPopUp(param1, param2, param3, param4);
            return;
        }// end function

        public static function centerPopUp(param1:IFlexDisplayObject) : void
        {
            impl.centerPopUp(param1);
            return;
        }// end function

        public static function bringToFront(param1:IFlexDisplayObject) : void
        {
            impl.bringToFront(param1);
            return;
        }// end function

        public static function createPopUp(param1:DisplayObject, param2:Class, param3:Boolean = false, param4:String = null) : IFlexDisplayObject
        {
            return impl.createPopUp(param1, param2, param3, param4);
        }// end function

    }
}
