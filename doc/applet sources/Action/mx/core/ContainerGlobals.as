package mx.core
{
    import flash.display.*;

    public class ContainerGlobals extends Object
    {
        public static var focusedContainer:InteractiveObject;

        public function ContainerGlobals()
        {
            return;
        }// end function

        public static function checkFocus(param1:InteractiveObject, param2:InteractiveObject) : void
        {
            var _loc_6:IFocusManager = null;
            var _loc_7:IButton = null;
            var _loc_3:* = param2;
            var _loc_4:* = param2;
            var _loc_5:IUIComponent = null;
            if (param2 != null && param1 == param2)
            {
                return;
            }
            while (_loc_4)
            {
                
                if (_loc_4.parent)
                {
                    _loc_3 = _loc_4.parent;
                }
                else
                {
                    _loc_3 = null;
                }
                if (_loc_4 is IUIComponent)
                {
                    _loc_5 = IUIComponent(_loc_4);
                }
                _loc_4 = _loc_3;
                if (_loc_4 && _loc_4 is IContainer && IContainer(_loc_4).defaultButton)
                {
                    break;
                }
            }
            if (ContainerGlobals.focusedContainer != _loc_4 || ContainerGlobals.focusedContainer == null && _loc_4 == null)
            {
                if (!_loc_4)
                {
                    _loc_4 = InteractiveObject(_loc_5);
                }
                if (_loc_4 && _loc_4 is IContainer)
                {
                    _loc_6 = IContainer(_loc_4).focusManager;
                    if (!_loc_6)
                    {
                        return;
                    }
                    _loc_7 = IContainer(_loc_4).defaultButton as IButton;
                    if (_loc_7)
                    {
                        ContainerGlobals.focusedContainer = InteractiveObject(_loc_4);
                        _loc_6.mx.managers:IFocusManager::defaultButton = _loc_7 as IButton;
                    }
                    else
                    {
                        ContainerGlobals.focusedContainer = InteractiveObject(_loc_4);
                        _loc_6.mx.managers:IFocusManager::defaultButton = null;
                    }
                }
            }
            return;
        }// end function

    }
}
