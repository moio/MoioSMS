package mx.skins.halo
{
    import flash.display.*;
    import mx.controls.scrollClasses.*;
    import mx.core.*;
    import mx.skins.*;
    import mx.styles.*;
    import mx.utils.*;

    public class ScrollArrowSkin extends Border
    {
        static const VERSION:String = "3.2.0.3958";
        private static var cache:Object = {};

        public function ScrollArrowSkin()
        {
            return;
        }// end function

        override public function get measuredWidth() : Number
        {
            return ScrollBar.THICKNESS;
        }// end function

        override public function get measuredHeight() : Number
        {
            return ScrollBar.THICKNESS;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_13:Array = null;
            var _loc_15:Array = null;
            var _loc_16:Array = null;
            var _loc_17:Array = null;
            var _loc_18:Array = null;
            var _loc_19:Array = null;
            var _loc_20:Array = null;
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("backgroundColor");
            var _loc_4:* = getStyle("borderColor");
            var _loc_5:* = getStyle("fillAlphas");
            var _loc_6:* = getStyle("fillColors");
            StyleManager.getColorNames(_loc_6);
            var _loc_7:* = getStyle("highlightAlphas");
            var _loc_8:* = getStyle("themeColor");
            var _loc_9:* = name.charAt(0) == "u";
            var _loc_10:* = getStyle("iconColor");
            var _loc_11:* = calcDerivedStyles(_loc_8, _loc_4, _loc_6[0], _loc_6[1]);
            if (parent && parent.parent)
            {
            }
            var _loc_12:* = parent.parent.rotation != 0;
            if (_loc_9 && !_loc_12)
            {
                _loc_13 = [_loc_4, _loc_11.borderColorDrk1];
            }
            else
            {
                _loc_13 = [_loc_11.borderColorDrk1, _loc_11.borderColorDrk2];
            }
            var _loc_14:* = graphics;
            graphics.clear();
            if (isNaN(_loc_3))
            {
                _loc_3 = 16777215;
            }
            if (FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0 || name.indexOf("Disabled") == -1)
            {
                drawRoundRect(0, 0, param1, param2, 0, _loc_3, 1);
            }
            switch(name)
            {
                case "upArrowUpSkin":
                {
                    if (!_loc_12)
                    {
                        drawRoundRect(1, param2 - 4, param1 - 2, 8, 0, [_loc_11.borderColorDrk1, _loc_11.borderColorDrk1], [1, 0], verticalGradientMatrix(1, param2 - 4, param1 - 2, 8), GradientType.LINEAR, null, {x:1, y:param2 - 4, w:param1 - 2, h:4, r:0});
                    }
                }
                case "downArrowUpSkin":
                {
                    _loc_15 = [_loc_6[0], _loc_6[1]];
                    _loc_16 = [_loc_5[0], _loc_5[1]];
                    drawRoundRect(0, 0, param1, param2, 0, _loc_13, 1, _loc_12 ? (horizontalGradientMatrix(0, 0, param1, param2)) : (verticalGradientMatrix(0, 0, param1, param2)), GradientType.LINEAR, null, {x:1, y:1, w:param1 - 2, h:param2 - 2, r:0});
                    drawRoundRect(1, 1, param1 - 2, param2 - 2, 0, _loc_15, _loc_16, _loc_12 ? (horizontalGradientMatrix(0, 0, param1 - 2, param2 - 2)) : (verticalGradientMatrix(0, 0, param1 - 2, param2 - 2 / 2)));
                    drawRoundRect(1, 1, param1 - 2, param2 - 2 / 2, 0, [16777215, 16777215], _loc_7, _loc_12 ? (horizontalGradientMatrix(0, 0, param1 - 2, param2 - 2)) : (verticalGradientMatrix(0, 0, param1 - 2, param2 - 2 / 2)));
                    break;
                }
                case "upArrowOverSkin":
                {
                    if (!_loc_12)
                    {
                        drawRoundRect(1, param2 - 4, param1 - 2, 8, 0, [_loc_11.borderColorDrk1, _loc_11.borderColorDrk1], [1, 0], verticalGradientMatrix(1, param2 - 4, param1 - 2, 8), GradientType.LINEAR, null, {x:1, y:param2 - 4, w:param1 - 2, h:4, r:0});
                    }
                }
                case "downArrowOverSkin":
                {
                    if (_loc_6.length > 2)
                    {
                        _loc_17 = [_loc_6[2], _loc_6[3]];
                    }
                    else
                    {
                        _loc_17 = [_loc_6[0], _loc_6[1]];
                    }
                    if (_loc_5.length > 2)
                    {
                        _loc_18 = [_loc_5[2], _loc_5[3]];
                    }
                    else
                    {
                        _loc_18 = [_loc_5[0], _loc_5[1]];
                    }
                    drawRoundRect(0, 0, param1, param2, 0, 16777215, 1);
                    drawRoundRect(0, 0, param1, param2, 0, [_loc_8, _loc_11.themeColDrk1], 1, _loc_12 ? (horizontalGradientMatrix(0, 0, param1, param2)) : (verticalGradientMatrix(0, 0, param1, param2)), GradientType.LINEAR, null, {x:1, y:1, w:param1 - 2, h:param2 - 2, r:0});
                    drawRoundRect(1, 1, param1 - 2, param2 - 2, 0, _loc_17, _loc_18, _loc_12 ? (horizontalGradientMatrix(0, 0, param1 - 2, param2 - 2)) : (verticalGradientMatrix(0, 0, param1 - 2, param2 - 2)));
                    drawRoundRect(1, 1, param1 - 2, param2 - 2 / 2, 0, [16777215, 16777215], _loc_7, _loc_12 ? (horizontalGradientMatrix(0, 0, param1 - 2, param2 - 2)) : (verticalGradientMatrix(0, 0, param1 - 2, param2 - 2 / 2)));
                    break;
                }
                case "upArrowDownSkin":
                {
                    if (!_loc_12)
                    {
                        drawRoundRect(1, param2 - 4, param1 - 2, 8, 0, [_loc_11.borderColorDrk1, _loc_11.borderColorDrk1], [1, 0], _loc_12 ? (horizontalGradientMatrix(1, param2 - 4, param1 - 2, 8)) : (verticalGradientMatrix(1, param2 - 4, param1 - 2, 8)), GradientType.LINEAR, null, {x:1, y:param2 - 4, w:param1 - 2, h:4, r:0});
                    }
                }
                case "downArrowDownSkin":
                {
                    drawRoundRect(0, 0, param1, param2, 0, [_loc_8, _loc_11.themeColDrk1], 1, _loc_12 ? (horizontalGradientMatrix(0, 0, param1, param2)) : (verticalGradientMatrix(0, 0, param1, param2)), GradientType.LINEAR, null, {x:1, y:1, w:param1 - 2, h:param2 - 2, r:0});
                    drawRoundRect(1, 1, param1 - 2, param2 - 2, 0, [_loc_11.fillColorPress1, _loc_11.fillColorPress2], 1, _loc_12 ? (horizontalGradientMatrix(0, 0, param1 - 2, param2 - 2)) : (verticalGradientMatrix(0, 0, param1 - 2, param2 - 2)));
                    drawRoundRect(1, 1, param1 - 2, param2 - 2 / 2, 0, [16777215, 16777215], _loc_7, _loc_12 ? (horizontalGradientMatrix(0, 0, param1 - 2, param2 - 2)) : (verticalGradientMatrix(0, 0, param1 - 2, param2 - 2 / 2)));
                    break;
                }
                case "upArrowDisabledSkin":
                {
                    if (FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0)
                    {
                        if (!_loc_12)
                        {
                            drawRoundRect(1, param2 - 4, param1 - 2, 8, 0, [_loc_11.borderColorDrk1, _loc_11.borderColorDrk1], [0.5, 0], verticalGradientMatrix(1, param2 - 4, param1 - 2, 8), GradientType.LINEAR, null, {x:1, y:param2 - 4, w:param1 - 2, h:4, r:0});
                        }
                    }
                }
                case "downArrowDisabledSkin":
                {
                    if (FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0)
                    {
                        _loc_19 = [_loc_6[0], _loc_6[1]];
                        _loc_20 = [_loc_5[0] - 0.15, _loc_5[1] - 0.15];
                        drawRoundRect(0, 0, param1, param2, 0, _loc_13, 0.5, _loc_12 ? (horizontalGradientMatrix(0, 0, param1, param2)) : (verticalGradientMatrix(0, 0, param1, param2)), GradientType.LINEAR, null, {x:1, y:1, w:param1 - 2, h:param2 - 2, r:0});
                        drawRoundRect(1, 1, param1 - 2, param2 - 2, 0, _loc_19, _loc_20, _loc_12 ? (horizontalGradientMatrix(0, 0, param1 - 2, param2 - 2)) : (verticalGradientMatrix(0, 0, param1 - 2, param2 - 2 / 2)));
                        _loc_10 = getStyle("disabledIconColor");
                    }
                    else
                    {
                        drawRoundRect(0, 0, param1, param2, 0, 16777215, 0);
                        return;
                    }
                    break;
                }
                default:
                {
                    drawRoundRect(0, 0, param1, param2, 0, 16777215, 0);
                    return;
                    break;
                }
            }
            _loc_14.beginFill(_loc_10);
            if (_loc_9)
            {
                _loc_14.moveTo(param1 / 2, 6);
                _loc_14.lineTo(param1 - 5, param2 - 6);
                _loc_14.lineTo(5, param2 - 6);
                _loc_14.lineTo(param1 / 2, 6);
            }
            else
            {
                _loc_14.moveTo(param1 / 2, param2 - 6);
                _loc_14.lineTo(param1 - 5, 6);
                _loc_14.lineTo(5, 6);
                _loc_14.lineTo(param1 / 2, param2 - 6);
            }
            _loc_14.endFill();
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
                _loc_6.borderColorDrk1 = ColorUtil.adjustBrightness2(param2, -25);
                _loc_6.borderColorDrk2 = ColorUtil.adjustBrightness2(param2, -50);
            }
            return cache[_loc_5];
        }// end function

    }
}
