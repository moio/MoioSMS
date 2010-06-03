package mx.binding
{

    public class BindingManager extends Object
    {
        static var debugDestinationStrings:Object = {};
        static const VERSION:String = "3.2.0.3958";

        public function BindingManager()
        {
            return;
        }// end function

        public static function executeBindings(param1:Object, param2:String, param3:Object) : void
        {
            var _loc_4:String = null;
            if (!param2 || param2 == "")
            {
                return;
            }
            if (param1 && param1 is IBindingClient || param1.hasOwnProperty("_bindingsByDestination") && param1._bindingsByDestination && param1._bindingsBeginWithWord[getFirstWord(param2)])
            {
                for (_loc_4 in param1._bindingsByDestination)
                {
                    
                    if (_loc_4.charAt(0) == param2.charAt(0))
                    {
                        if (_loc_4.indexOf(param2 + ".") == 0 || _loc_4.indexOf(param2 + "[") == 0 || _loc_4 == param2)
                        {
                            param1._bindingsByDestination[_loc_4].execute(param3);
                        }
                    }
                }
            }
            return;
        }// end function

        public static function addBinding(param1:Object, param2:String, param3:Binding) : void
        {
            if (!param1._bindingsByDestination)
            {
                param1._bindingsByDestination = {};
                param1._bindingsBeginWithWord = {};
            }
            param1._bindingsByDestination[param2] = param3;
            param1._bindingsBeginWithWord[getFirstWord(param2)] = true;
            return;
        }// end function

        public static function debugBinding(param1:String) : void
        {
            debugDestinationStrings[param1] = true;
            return;
        }// end function

        private static function getFirstWord(param1:String) : String
        {
            var _loc_2:* = param1.indexOf(".");
            var _loc_3:* = param1.indexOf("[");
            if (_loc_2 == _loc_3)
            {
                return param1;
            }
            var _loc_4:* = Math.min(_loc_2, _loc_3);
            if (Math.min(_loc_2, _loc_3) == -1)
            {
                _loc_4 = Math.max(_loc_2, _loc_3);
            }
            return param1.substr(0, _loc_4);
        }// end function

        public static function setEnabled(param1:Object, param2:Boolean) : void
        {
            var _loc_3:Array = null;
            var _loc_4:uint = 0;
            var _loc_5:Binding = null;
            if (param1 is IBindingClient && param1._bindings)
            {
                _loc_3 = param1._bindings as Array;
                _loc_4 = 0;
                while (_loc_4++ < _loc_3.length)
                {
                    
                    _loc_5 = _loc_3[_loc_4];
                    _loc_5.isEnabled = param2;
                }
            }
            return;
        }// end function

    }
}
