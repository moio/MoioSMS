package mx.core
{
    import mx.resources.*;

    public class FlexVersion extends Object
    {
        private static var compatibilityVersionChanged:Boolean = false;
        public static const VERSION_2_0_1:uint = 33554433;
        private static var _compatibilityErrorFunction:Function;
        public static const CURRENT_VERSION:uint = 50331648;
        public static const VERSION_3_0:uint = 50331648;
        public static const VERSION_2_0:uint = 33554432;
        private static var _compatibilityVersion:uint = 50331648;
        public static const VERSION_ALREADY_READ:String = "versionAlreadyRead";
        public static const VERSION_ALREADY_SET:String = "versionAlreadySet";
        static const VERSION:String = "3.2.0.3958";
        private static var compatibilityVersionRead:Boolean = false;

        public function FlexVersion()
        {
            return;
        }// end function

        static function changeCompatibilityVersionString(param1:String) : void
        {
            var _loc_2:* = param1.split(".");
            var _loc_3:* = parseInt(_loc_2[0]);
            var _loc_4:* = parseInt(_loc_2[1]);
            var _loc_5:* = parseInt(_loc_2[2]);
            _compatibilityVersion = (_loc_3 << 24) + (_loc_4 << 16) + _loc_5;
            return;
        }// end function

        public static function set compatibilityVersion(param1:uint) : void
        {
            var _loc_2:String = null;
            if (param1 == _compatibilityVersion)
            {
                return;
            }
            if (compatibilityVersionChanged)
            {
                if (compatibilityErrorFunction == null)
                {
                    _loc_2 = ResourceManager.getInstance().getString("core", VERSION_ALREADY_SET);
                    throw new Error(_loc_2);
                }
                compatibilityErrorFunction(param1, VERSION_ALREADY_SET);
            }
            if (compatibilityVersionRead)
            {
                if (compatibilityErrorFunction == null)
                {
                    _loc_2 = ResourceManager.getInstance().getString("core", VERSION_ALREADY_READ);
                    throw new Error(_loc_2);
                }
                compatibilityErrorFunction(param1, VERSION_ALREADY_READ);
            }
            _compatibilityVersion = param1;
            compatibilityVersionChanged = true;
            return;
        }// end function

        public static function get compatibilityVersion() : uint
        {
            compatibilityVersionRead = true;
            return _compatibilityVersion;
        }// end function

        public static function set compatibilityErrorFunction(param1:Function) : void
        {
            _compatibilityErrorFunction = param1;
            return;
        }// end function

        public static function set compatibilityVersionString(param1:String) : void
        {
            var _loc_2:* = param1.split(".");
            var _loc_3:* = parseInt(_loc_2[0]);
            var _loc_4:* = parseInt(_loc_2[1]);
            var _loc_5:* = parseInt(_loc_2[2]);
            compatibilityVersion = (_loc_3 << 24) + (_loc_4 << 16) + _loc_5;
            return;
        }// end function

        public static function get compatibilityErrorFunction() : Function
        {
            return _compatibilityErrorFunction;
        }// end function

        public static function get compatibilityVersionString() : String
        {
            var _loc_1:* = compatibilityVersion >> 24 & 255;
            var _loc_2:* = compatibilityVersion >> 16 & 255;
            var _loc_3:* = compatibilityVersion & 65535;
            return _loc_1.toString() + "." + _loc_2.toString() + "." + _loc_3.toString();
        }// end function

    }
}
