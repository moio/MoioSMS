package mx.skins.halo
{
    import mx.utils.*;

    public class HaloColors extends Object
    {
        private static var cache:Object = {};
        static const VERSION:String = "3.2.0.3958";

        public function HaloColors()
        {
            return;
        }// end function

        public static function getCacheKey(... args) : String
        {
            return args.join(",");
        }// end function

        public static function addHaloColors(param1:Object, param2:uint, param3:uint, param4:uint) : void
        {
            var _loc_5:* = getCacheKey(param2, param3, param4);
            var _loc_6:* = cache[_loc_5];
            if (!cache[_loc_5])
            {
                var _loc_7:* = {};
                cache[_loc_5] = {};
                _loc_6 = _loc_7;
                _loc_6.themeColLgt = ColorUtil.adjustBrightness(param2, 100);
                _loc_6.themeColDrk1 = ColorUtil.adjustBrightness(param2, -75);
                _loc_6.themeColDrk2 = ColorUtil.adjustBrightness(param2, -25);
                _loc_6.fillColorBright1 = ColorUtil.adjustBrightness2(param3, 15);
                _loc_6.fillColorBright2 = ColorUtil.adjustBrightness2(param4, 15);
                _loc_6.fillColorPress1 = ColorUtil.adjustBrightness2(param2, 85);
                _loc_6.fillColorPress2 = ColorUtil.adjustBrightness2(param2, 60);
                _loc_6.bevelHighlight1 = ColorUtil.adjustBrightness2(param3, 40);
                _loc_6.bevelHighlight2 = ColorUtil.adjustBrightness2(param4, 40);
            }
            param1.themeColLgt = _loc_6.themeColLgt;
            param1.themeColDrk1 = _loc_6.themeColDrk1;
            param1.themeColDrk2 = _loc_6.themeColDrk2;
            param1.fillColorBright1 = _loc_6.fillColorBright1;
            param1.fillColorBright2 = _loc_6.fillColorBright2;
            param1.fillColorPress1 = _loc_6.fillColorPress1;
            param1.fillColorPress2 = _loc_6.fillColorPress2;
            param1.bevelHighlight1 = _loc_6.bevelHighlight1;
            param1.bevelHighlight2 = _loc_6.bevelHighlight2;
            return;
        }// end function

    }
}
