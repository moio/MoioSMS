package air.update.utils
{
    import flash.desktop.*;

    public class VersionUtils extends Object
    {
        private static const SPECIALS:Array = ["alpha", "beta", "rc"];

        public function VersionUtils()
        {
            return;
        }// end function

        public static function isNewerVersion(param1:String, param2:String) : Boolean
        {
            var _loc_9:String = null;
            var _loc_10:String = null;
            var _loc_11:Boolean = false;
            var _loc_12:Boolean = false;
            var _loc_13:uint = 0;
            var _loc_14:uint = 0;
            var _loc_15:int = 0;
            var _loc_16:int = 0;
            var _loc_17:String = null;
            var _loc_18:String = null;
            var _loc_3:* = param1.replace(/[+\-_ ]/g, ".").replace(/\.(\.)+/g, ".").replace(/([^\d\.])([^\D\.])/g, "$1.$2").replace(/([^\D\.])([^\d\.])/g, "$1.$2");
            var _loc_4:* = param2.replace(/[+\-_ ]/g, ".").replace(/\.(\.)+/g, ".").replace(/([^\d\.])([^\D\.])/g, "$1.$2").replace(/([^\D\.])([^\d\.])/g, "$1.$2");
            var _loc_5:* = _loc_3.split(".");
            var _loc_6:* = _loc_4.split(".");
            var _loc_7:* = Math.min(_loc_5.length, _loc_6.length);
            var _loc_8:int = 0;
            while (_loc_8 < _loc_7)
            {
                
                _loc_9 = _loc_5[_loc_8];
                _loc_10 = _loc_6[_loc_8];
                _loc_11 = StringUtils.isDigit(_loc_9.charAt(0));
                _loc_12 = StringUtils.isDigit(_loc_10.charAt(0));
                if (_loc_11 && _loc_12)
                {
                    _loc_13 = uint(_loc_9);
                    _loc_14 = uint(_loc_10);
                    if (_loc_14 != _loc_13)
                    {
                        return _loc_14 > _loc_13;
                    }
                }
                else if (!_loc_11 && !_loc_12)
                {
                    _loc_15 = SPECIALS.indexOf(_loc_9.toLowerCase());
                    _loc_16 = SPECIALS.indexOf(_loc_10.toLowerCase());
                    if (_loc_15 != -1 && _loc_16 != -1)
                    {
                        if (_loc_15 != _loc_16)
                        {
                            return _loc_16 > _loc_15;
                        }
                    }
                    else
                    {
                        _loc_17 = _loc_9.toLowerCase();
                        _loc_18 = _loc_10.toLowerCase();
                        if (_loc_18 != _loc_17)
                        {
                            return _loc_18 > _loc_17;
                        }
                    }
                }
                else
                {
                    if (_loc_11)
                    {
                        return false;
                    }
                    return true;
                }
                _loc_8++;
            }
            if (_loc_5.length == _loc_6.length)
            {
                return false;
            }
            if (_loc_5.length > _loc_6.length)
            {
                if (StringUtils.isDigit(_loc_5[_loc_7].charAt(0)))
                {
                    return false;
                }
                return true;
            }
            if (StringUtils.isDigit(_loc_6[_loc_7].charAt(0)))
            {
                return true;
            }
            return false;
        }// end function

        public static function getApplicationVersion() : String
        {
            var _loc_1:* = NativeApplication.nativeApplication.applicationDescriptor;
            var _loc_2:* = _loc_1.namespace();
            return _loc_2::version;
        }// end function

        public static function getApplicationID() : String
        {
            return NativeApplication.nativeApplication.applicationID;
        }// end function

    }
}
