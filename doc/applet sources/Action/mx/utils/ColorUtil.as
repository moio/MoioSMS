package mx.utils
{

    public class ColorUtil extends Object
    {
        static const VERSION:String = "3.2.0.3958";

        public function ColorUtil()
        {
            return;
        }// end function

        public static function adjustBrightness2(param1:uint, param2:Number) : uint
        {
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            if (param2 == 0)
            {
                return param1;
            }
            if (param2 < 0)
            {
                param2 = (100 + param2) / 100;
                _loc_3 = (param1 >> 16 & 255) * param2;
                _loc_4 = (param1 >> 8 & 255) * param2;
                _loc_5 = (param1 & 255) * param2;
            }
            else
            {
                param2 = param2 / 100;
                _loc_3 = param1 >> 16 & 255;
                _loc_4 = param1 >> 8 & 255;
                _loc_5 = param1 & 255;
                _loc_3 = _loc_3 + (255 - _loc_3) * param2;
                _loc_4 = _loc_4 + (255 - _loc_4) * param2;
                _loc_5 = _loc_5 + (255 - _loc_5) * param2;
                _loc_3 = Math.min(_loc_3, 255);
                _loc_4 = Math.min(_loc_4, 255);
                _loc_5 = Math.min(_loc_5, 255);
            }
            return _loc_3 << 16 | _loc_4 << 8 | _loc_5;
        }// end function

        public static function rgbMultiply(param1:uint, param2:uint) : uint
        {
            var _loc_3:* = param1 >> 16 & 255;
            var _loc_4:* = param1 >> 8 & 255;
            var _loc_5:* = param1 & 255;
            var _loc_6:* = param2 >> 16 & 255;
            var _loc_7:* = param2 >> 8 & 255;
            var _loc_8:* = param2 & 255;
            return _loc_3 * _loc_6 / 255 << 16 | _loc_4 * _loc_7 / 255 << 8 | _loc_5 * _loc_8 / 255;
        }// end function

        public static function adjustBrightness(param1:uint, param2:Number) : uint
        {
            var _loc_3:* = Math.max(Math.min((param1 >> 16 & 255) + param2, 255), 0);
            var _loc_4:* = Math.max(Math.min((param1 >> 8 & 255) + param2, 255), 0);
            var _loc_5:* = Math.max(Math.min((param1 & 255) + param2, 255), 0);
            return _loc_3 << 16 | _loc_4 << 8 | _loc_5;
        }// end function

    }
}
