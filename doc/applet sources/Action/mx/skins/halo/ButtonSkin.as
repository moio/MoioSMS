package mx.skins.halo
{
    import flash.display.*;
    import mx.core.*;
    import mx.skins.*;
    import mx.styles.*;
    import mx.utils.*;

    public class ButtonSkin extends Border
    {
        static const VERSION:String = "3.2.0.3958";
        private static var cache:Object = {};

        public function ButtonSkin()
        {
            return;
        }// end function

        override public function get measuredWidth() : Number
        {
            return UIComponent.DEFAULT_MEASURED_MIN_WIDTH;
        }// end function

        override public function get measuredHeight() : Number
        {
            return UIComponent.DEFAULT_MEASURED_MIN_HEIGHT;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_16:Number = NaN;
            var _loc_17:Array = null;
            var _loc_18:Array = null;
            var _loc_19:Array = null;
            var _loc_20:Array = null;
            var _loc_21:Array = null;
            var _loc_22:Array = null;
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("borderColor");
            var _loc_4:* = getStyle("cornerRadius");
            var _loc_5:* = getStyle("fillAlphas");
            var _loc_6:* = getStyle("fillColors");
            StyleManager.getColorNames(_loc_6);
            var _loc_7:* = getStyle("highlightAlphas");
            var _loc_8:* = getStyle("themeColor");
            var _loc_9:* = calcDerivedStyles(_loc_8, _loc_6[0], _loc_6[1]);
            var _loc_10:* = ColorUtil.adjustBrightness2(_loc_3, -50);
            var _loc_11:* = ColorUtil.adjustBrightness2(_loc_8, -25);
            var _loc_12:Boolean = false;
            if (parent is IButton)
            {
                _loc_12 = IButton(parent).emphasized;
            }
            var _loc_13:* = Math.max(0, _loc_4);
            var _loc_14:* = Math.max(0, _loc_4--);
            var _loc_15:* = Math.max(0, _loc_4 - 2);
            graphics.clear();
            switch(name)
            {
                case "selectedUpSkin":
                case "selectedOverSkin":
                {
                    drawRoundRect(0, 0, param1, param2, _loc_13, [_loc_8, _loc_11], 1, verticalGradientMatrix(0, 0, param1, param2));
                    drawRoundRect(1, 1, param1 - 2, param2 - 2, _loc_14, [_loc_6[1], _loc_6[1]], 1, verticalGradientMatrix(0, 0, param1 - 2, param2 - 2));
                    break;
                }
                case "upSkin":
                {
                    _loc_17 = [_loc_6[0], _loc_6[1]];
                    _loc_18 = [_loc_5[0], _loc_5[1]];
                    if (_loc_12)
                    {
                        drawRoundRect(0, 0, param1, param2, _loc_13, [_loc_8, _loc_11], 1, verticalGradientMatrix(0, 0, param1, param2), GradientType.LINEAR, null, {x:2, y:2, w:param1 - 4, h:param2 - 4, r:_loc_4 - 2});
                        drawRoundRect(2, 2, param1 - 4, param2 - 4, _loc_15, _loc_17, _loc_18, verticalGradientMatrix(2, 2, param1 - 2, param2 - 2));
                        drawRoundRect(2, 2, param1 - 4, (param2 - 4) / 2, {tl:_loc_15, tr:_loc_15, bl:0, br:0}, [16777215, 16777215], _loc_7, verticalGradientMatrix(1, 1, param1 - 2, (param2 - 2) / 2));
                    }
                    else
                    {
                        drawRoundRect(0, 0, param1, param2, _loc_13, [_loc_3, _loc_10], 1, verticalGradientMatrix(0, 0, param1, param2), GradientType.LINEAR, null, {x:1, y:1, w:param1 - 2, h:param2 - 2, r:_loc_4--});
                        drawRoundRect(1, 1, param1 - 2, param2 - 2, _loc_14, _loc_17, _loc_18, verticalGradientMatrix(1, 1, param1 - 2, param2 - 2));
                        drawRoundRect(1, 1, param1 - 2, (param2 - 2) / 2, {tl:_loc_14, tr:_loc_14, bl:0, br:0}, [16777215, 16777215], _loc_7, verticalGradientMatrix(1, 1, param1 - 2, (param2 - 2) / 2));
                    }
                    break;
                }
                case "overSkin":
                {
                    if (_loc_6.length > 2)
                    {
                        _loc_19 = [_loc_6[2], _loc_6[3]];
                    }
                    else
                    {
                        _loc_19 = [_loc_6[0], _loc_6[1]];
                    }
                    if (_loc_5.length > 2)
                    {
                        _loc_20 = [_loc_5[2], _loc_5[3]];
                    }
                    else
                    {
                        _loc_20 = [_loc_5[0], _loc_5[1]];
                    }
                    drawRoundRect(0, 0, param1, param2, _loc_13, [_loc_8, _loc_11], 1, verticalGradientMatrix(0, 0, param1, param2), GradientType.LINEAR, null, {x:1, y:1, w:param1 - 2, h:param2 - 2, r:_loc_4--});
                    drawRoundRect(1, 1, param1 - 2, param2 - 2, _loc_14, _loc_19, _loc_20, verticalGradientMatrix(1, 1, param1 - 2, param2 - 2));
                    drawRoundRect(1, 1, param1 - 2, (param2 - 2) / 2, {tl:_loc_14, tr:_loc_14, bl:0, br:0}, [16777215, 16777215], _loc_7, verticalGradientMatrix(1, 1, param1 - 2, (param2 - 2) / 2));
                    break;
                }
                case "downSkin":
                case "selectedDownSkin":
                {
                    drawRoundRect(0, 0, param1, param2, _loc_13, [_loc_8, _loc_11], 1, verticalGradientMatrix(0, 0, param1, param2));
                    drawRoundRect(1, 1, param1 - 2, param2 - 2, _loc_14, [_loc_9.fillColorPress1, _loc_9.fillColorPress2], 1, verticalGradientMatrix(1, 1, param1 - 2, param2 - 2));
                    drawRoundRect(2, 2, param1 - 4, (param2 - 4) / 2, {tl:_loc_15, tr:_loc_15, bl:0, br:0}, [16777215, 16777215], _loc_7, verticalGradientMatrix(1, 1, param1 - 2, (param2 - 2) / 2));
                    break;
                }
                case "disabledSkin":
                case "selectedDisabledSkin":
                {
                    _loc_21 = [_loc_6[0], _loc_6[1]];
                    _loc_22 = [Math.max(0, _loc_5[0] - 0.15), Math.max(0, _loc_5[1] - 0.15)];
                    drawRoundRect(0, 0, param1, param2, _loc_13, [_loc_3, _loc_10], 0.5, verticalGradientMatrix(0, 0, param1, param2), GradientType.LINEAR, null, {x:1, y:1, w:param1 - 2, h:param2 - 2, r:_loc_4--});
                    drawRoundRect(1, 1, param1 - 2, param2 - 2, _loc_14, _loc_21, _loc_22, verticalGradientMatrix(1, 1, param1 - 2, param2 - 2));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private static function calcDerivedStyles(param1:uint, param2:uint, param3:uint) : Object
        {
            var _loc_5:Object = null;
            var _loc_4:* = HaloColors.getCacheKey(param1, param2, param3);
            if (!cache[_loc_4])
            {
                var _loc_6:* = {};
                cache[_loc_4] = {};
                _loc_5 = _loc_6;
                HaloColors.addHaloColors(_loc_5, param1, param2, param3);
            }
            return cache[_loc_4];
        }// end function

    }
}
