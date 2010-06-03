package mx.resources
{
    import flash.system.*;
    import mx.core.*;
    import mx.utils.*;

    public class ResourceBundle extends Object implements IResourceBundle
    {
        var _locale:String;
        private var _content:Object;
        var _bundleName:String;
        static const VERSION:String = "3.2.0.3958";
        static var backupApplicationDomain:ApplicationDomain;
        static var locale:String;

        public function ResourceBundle(param1:String = null, param2:String = null)
        {
            _content = {};
            mx_internal::_locale = param1;
            mx_internal::_bundleName = param2;
            _content = getContent();
            return;
        }// end function

        protected function getContent() : Object
        {
            return {};
        }// end function

        public function getString(param1:String) : String
        {
            return String(_getObject(param1));
        }// end function

        public function get content() : Object
        {
            return _content;
        }// end function

        public function getBoolean(param1:String, param2:Boolean = true) : Boolean
        {
            var _loc_3:* = _getObject(param1).toLowerCase();
            if (_loc_3 == "false")
            {
                return false;
            }
            if (_loc_3 == "true")
            {
                return true;
            }
            return param2;
        }// end function

        public function getStringArray(param1:String) : Array
        {
            var _loc_2:* = _getObject(param1).split(",");
            var _loc_3:* = _loc_2.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_2[_loc_4] = StringUtil.trim(_loc_2[_loc_4]);
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public function getObject(param1:String) : Object
        {
            return _getObject(param1);
        }// end function

        private function _getObject(param1:String) : Object
        {
            var _loc_2:* = content[param1];
            if (!_loc_2)
            {
                throw new Error("Key " + param1 + " was not found in resource bundle " + bundleName);
            }
            return _loc_2;
        }// end function

        public function get locale() : String
        {
            return mx_internal::_locale;
        }// end function

        public function get bundleName() : String
        {
            return mx_internal::_bundleName;
        }// end function

        public function getNumber(param1:String) : Number
        {
            return Number(_getObject(param1));
        }// end function

        private static function getClassByName(param1:String, param2:ApplicationDomain) : Class
        {
            var _loc_3:Class = null;
            if (param2.hasDefinition(param1))
            {
                _loc_3 = param2.getDefinition(param1) as Class;
            }
            return _loc_3;
        }// end function

        public static function getResourceBundle(param1:String, param2:ApplicationDomain = null) : ResourceBundle
        {
            var _loc_3:String = null;
            var _loc_4:Class = null;
            var _loc_5:Object = null;
            var _loc_6:ResourceBundle = null;
            if (!param2)
            {
                param2 = ApplicationDomain.currentDomain;
            }
            _loc_3 = mx_internal::locale + "$" + param1 + "_properties";
            _loc_4 = getClassByName(_loc_3, param2);
            if (!_loc_4)
            {
                _loc_3 = param1 + "_properties";
                _loc_4 = getClassByName(_loc_3, param2);
            }
            if (!_loc_4)
            {
                _loc_3 = param1;
                _loc_4 = getClassByName(_loc_3, param2);
            }
            if (!_loc_4 && mx_internal::backupApplicationDomain)
            {
                _loc_3 = param1 + "_properties";
                _loc_4 = getClassByName(_loc_3, mx_internal::backupApplicationDomain);
                if (!_loc_4)
                {
                    _loc_3 = param1;
                    _loc_4 = getClassByName(_loc_3, mx_internal::backupApplicationDomain);
                }
            }
            if (_loc_4)
            {
                _loc_5 = new _loc_4;
                if (_loc_5 is ResourceBundle)
                {
                    _loc_6 = this.this(_loc_5);
                    return _loc_6;
                }
            }
            throw new Error("Could not find resource bundle " + param1);
        }// end function

    }
}
