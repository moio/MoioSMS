package mx.utils
{
    import flash.display.*;

    public class GraphicsUtil extends Object
    {
        static const VERSION:String = "3.2.0.3958";

        public function GraphicsUtil()
        {
            return;
        }// end function

        public static function drawRoundRectComplex(param1:Graphics, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number) : void
        {
            var _loc_10:* = param2 + param4;
            var _loc_11:* = param3 + param5;
            var _loc_12:* = param4 < param5 ? (param4 * 2) : (param5 * 2);
            param6 = param6 < _loc_12 ? (param6) : (_loc_12);
            param7 = param7 < _loc_12 ? (param7) : (_loc_12);
            param8 = param8 < _loc_12 ? (param8) : (_loc_12);
            param9 = param9 < _loc_12 ? (param9) : (_loc_12);
            var _loc_13:* = param9 * 0.292893;
            var _loc_14:* = param9 * 0.585786;
            param1.moveTo(_loc_10, _loc_11 - param9);
            param1.curveTo(_loc_10, _loc_11 - _loc_14, _loc_10 - _loc_13, _loc_11 - _loc_13);
            param1.curveTo(_loc_10 - _loc_14, _loc_11, _loc_10 - param9, _loc_11);
            _loc_13 = param8 * 0.292893;
            _loc_14 = param8 * 0.585786;
            param1.lineTo(param2 + param8, _loc_11);
            param1.curveTo(param2 + _loc_14, _loc_11, param2 + _loc_13, _loc_11 - _loc_13);
            param1.curveTo(param2, _loc_11 - _loc_14, param2, _loc_11 - param8);
            _loc_13 = param6 * 0.292893;
            _loc_14 = param6 * 0.585786;
            param1.lineTo(param2, param3 + param6);
            param1.curveTo(param2, param3 + _loc_14, param2 + _loc_13, param3 + _loc_13);
            param1.curveTo(param2 + _loc_14, param3, param2 + param6, param3);
            _loc_13 = param7 * 0.292893;
            _loc_14 = param7 * 0.585786;
            param1.lineTo(_loc_10 - param7, param3);
            param1.curveTo(_loc_10 - _loc_14, param3, _loc_10 - _loc_13, param3 + _loc_13);
            param1.curveTo(_loc_10, param3 + _loc_14, _loc_10, param3 + param7);
            param1.lineTo(_loc_10, _loc_11 - param9);
            return;
        }// end function

    }
}
