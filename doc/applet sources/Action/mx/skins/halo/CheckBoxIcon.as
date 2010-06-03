package mx.skins.halo
{
    import flash.display.*;
    import mx.skins.*;
    import mx.styles.*;
    import mx.utils.*;

    public class CheckBoxIcon extends Border
    {
        static const VERSION:String = "3.2.0.3958";
        private static var cache:Object = {};

        public function CheckBoxIcon()
        {
            return;
        }// end function

        override public function get measuredWidth() : Number
        {
            return 14;
        }// end function

        override public function get measuredHeight() : Number
        {
            return 14;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_13:Array = null;
            var _loc_14:Array = null;
            var _loc_15:Array = null;
            var _loc_16:Array = null;
            var _loc_17:Array = null;
            var _loc_18:Array = null;
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("borderColor");
            var _loc_4:* = getStyle("iconColor");
            var _loc_5:* = getStyle("fillAlphas");
            var _loc_6:* = getStyle("fillColors");
            StyleManager.getColorNames(_loc_6);
            var _loc_7:* = getStyle("highlightAlphas");
            var _loc_8:* = getStyle("themeColor");
            var _loc_9:* = calcDerivedStyles(_loc_8, _loc_3, _loc_6[0], _loc_6[1]);
            var _loc_10:* = ColorUtil.adjustBrightness2(_loc_3, -50);
            var _loc_11:* = ColorUtil.adjustBrightness2(_loc_8, -25);
            var _loc_12:Boolean = false;
            var _loc_19:* = graphics;
            graphics.clear();
            switch(name)
            {
                case "upIcon":
                {
                    _loc_13 = [_loc_6[0], _loc_6[1]];
                    _loc_14 = [_loc_5[0], _loc_5[1]];
                    drawRoundRect(0, 0, param1, param2, 0, [_loc_3, _loc_10], 1, verticalGradientMatrix(0, 0, param1, param2), GradientType.LINEAR, null, {x:1, y:1, w:param1 - 2, h:param2 - 2, r:0});
                    drawRoundRect(1, 1, param1 - 2, param2 - 2, 0, _loc_13, _loc_14, verticalGradientMatrix(1, 1, param1 - 2, param2 - 2));
                    drawRoundRect(1, 1, param1 - 2, (param2 - 2) / 2, 0, [16777215, 16777215], _loc_7, verticalGradientMatrix(1, 1, param1 - 2, (param2 - 2) / 2));
                    break;
                }
                case "overIcon":
                {
                    if (_loc_6.length > 2)
                    {
                        _loc_15 = [_loc_6[2], _loc_6[3]];
                    }
                    else
                    {
                        _loc_15 = [_loc_6[0], _loc_6[1]];
                    }
                    if (_loc_5.length > 2)
                    {
                        _loc_16 = [_loc_5[2], _loc_5[3]];
                    }
                    else
                    {
                        _loc_16 = [_loc_5[0], _loc_5[1]];
                    }
                    drawRoundRect(0, 0, param1, param2, 0, [_loc_8, _loc_11], 1, verticalGradientMatrix(0, 0, param1, param2), GradientType.LINEAR, null, {x:1, y:1, w:param1 - 2, h:param2 - 2, r:0});
                    drawRoundRect(1, 1, param1 - 2, param2 - 2, 0, _loc_15, _loc_16, verticalGradientMatrix(1, 1, param1 - 2, param2 - 2));
                    drawRoundRect(1, 1, param1 - 2, (param2 - 2) / 2, 0, [16777215, 16777215], _loc_7, verticalGradientMatrix(1, 1, param1 - 2, (param2 - 2) / 2));
                    break;
                }
                case "downIcon":
                {
                    drawRoundRect(0, 0, param1, param2, 0, [_loc_8, _loc_11], 1, verticalGradientMatrix(0, 0, param1, param2));
                    drawRoundRect(1, 1, param1 - 2, param2 - 2, 0, [_loc_9.fillColorPress1, _loc_9.fillColorPress2], 1, verticalGradientMatrix(1, 1, param1 - 2, param2 - 2));
                    drawRoundRect(1, 1, param1 - 2, (param2 - 2) / 2, 0, [16777215, 16777215], _loc_7, verticalGradientMatrix(1, 1, param1 - 2, (param2 - 2) / 2));
                    break;
                }
                case "disabledIcon":
                {
                    _loc_17 = [_loc_6[0], _loc_6[1]];
                    _loc_18 = [Math.max(0, _loc_5[0] - 0.15), Math.max(0, _loc_5[1] - 0.15)];
                    drawRoundRect(0, 0, param1, param2, 0, [_loc_3, _loc_10], 0.5, verticalGradientMatrix(0, 0, param1, param2), GradientType.LINEAR, null, {x:1, y:1, w:param1 - 2, h:param2 - 2, r:0});
                    drawRoundRect(1, 1, param1 - 2, param2 - 2, 0, _loc_17, _loc_18, verticalGradientMatrix(1, 1, param1 - 2, param2 - 2));
                    break;
                }
                case "selectedUpIcon":
                {
                    _loc_12 = true;
                    _loc_13 = [_loc_6[0], _loc_6[1]];
                    _loc_14 = [_loc_5[0], _loc_5[1]];
                    drawRoundRect(0, 0, param1, param2, 0, [_loc_3, _loc_10], 1, verticalGradientMatrix(0, 0, param1, param2), GradientType.LINEAR, null, {x:1, y:1, w:param1 - 2, h:param2 - 2, r:0});
                    drawRoundRect(1, 1, param1 - 2, param2 - 2, 0, _loc_13, _loc_14, verticalGradientMatrix(1, 1, param1 - 2, param2 - 2));
                    drawRoundRect(1, 1, param1 - 2, (param2 - 2) / 2, 0, [16777215, 16777215], _loc_7, verticalGradientMatrix(1, 1, param1 - 2, (param2 - 2) / 2));
                    break;
                }
                case "selectedOverIcon":
                {
                    _loc_12 = true;
                    if (_loc_6.length > 2)
                    {
                        _loc_15 = [_loc_6[2], _loc_6[3]];
                    }
                    else
                    {
                        _loc_15 = [_loc_6[0], _loc_6[1]];
                    }
                    if (_loc_5.length > 2)
                    {
                        _loc_16 = [_loc_5[2], _loc_5[3]];
                    }
                    else
                    {
                        _loc_16 = [_loc_5[0], _loc_5[1]];
                    }
                    drawRoundRect(0, 0, param1, param2, 0, [_loc_8, _loc_11], 1, verticalGradientMatrix(0, 0, param1, param2), GradientType.LINEAR, null, {x:1, y:1, w:param1 - 2, h:param2 - 2, r:0});
                    drawRoundRect(1, 1, param1 - 2, param2 - 2, 0, _loc_15, _loc_16, verticalGradientMatrix(1, 1, param1 - 2, param2 - 2));
                    drawRoundRect(1, 1, param1 - 2, (param2 - 2) / 2, 0, [16777215, 16777215], _loc_7, verticalGradientMatrix(1, 1, param1 - 2, (param2 - 2) / 2));
                    break;
                }
                case "selectedDownIcon":
                {
                    _loc_12 = true;
                    drawRoundRect(0, 0, param1, param2, 0, [_loc_8, _loc_11], 1, verticalGradientMatrix(0, 0, param1, param2));
                    drawRoundRect(1, 1, param1 - 2, param2 - 2, 0, [_loc_9.fillColorPress1, _loc_9.fillColorPress2], 1, verticalGradientMatrix(1, 1, param1 - 2, param2 - 2));
                    drawRoundRect(1, 1, param1 - 2, (param2 - 2) / 2, 0, [16777215, 16777215], _loc_7, verticalGradientMatrix(1, 1, param1 - 2, (param2 - 2) / 2));
                    break;
                }
                case "selectedDisabledIcon":
                {
                    _loc_12 = true;
                    _loc_4 = getStyle("disabledIconColor");
                    _loc_17 = [_loc_6[0], _loc_6[1]];
                    _loc_18 = [Math.max(0, _loc_5[0] - 0.15), Math.max(0, _loc_5[1] - 0.15)];
                    drawRoundRect(0, 0, param1, param2, 0, [_loc_3, _loc_10], 0.5, verticalGradientMatrix(0, 0, param1, param2), GradientType.LINEAR, null, {x:1, y:1, w:param1 - 2, h:param2 - 2, r:0});
                    drawRoundRect(1, 1, param1 - 2, param2 - 2, 0, _loc_17, _loc_18, verticalGradientMatrix(1, 1, param1 - 2, param2 - 2));
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_12)
            {
                _loc_19.beginFill(_loc_4);
                _loc_19.moveTo(3, 5);
                _loc_19.lineTo(5, 10);
                _loc_19.lineTo(7, 10);
                _loc_19.lineTo(12, 2);
                _loc_19.lineTo(13, 1);
                _loc_19.lineTo(11, 1);
                _loc_19.lineTo(6.5, 7);
                _loc_19.lineTo(5, 5);
                _loc_19.lineTo(3, 5);
                _loc_19.endFill();
            }
            return;
        }// end function

        private static function calcDerivedStyles(param1:uint, param2:uint, param3:uint, param4:uint) : Object
        {
            var _loc_6:Object = null;
            var _loc_5:* = HaloColors.getCacheKey(param1, param2, param3, param4);
            if (!cache[_loc_5])
            {
                var _loc_7:* = {};
                cache[_loc_5] = {};
                _loc_6 = _loc_7;
                HaloColors.addHaloColors(_loc_6, param1, param3, param4);
                _loc_6.borderColorDrk1 = ColorUtil.adjustBrightness2(param2, -50);
            }
            return cache[_loc_5];
        }// end function

    }
}
