package mx.skins.halo
{
    import flash.display.*;
    import mx.skins.*;
    import mx.styles.*;
    import mx.utils.*;

    public class ScrollThumbSkin extends Border
    {
        static const VERSION:String = "3.2.0.3958";
        private static var cache:Object = {};

        public function ScrollThumbSkin()
        {
            return;
        }// end function

        override public function get measuredWidth() : Number
        {
            return 16;
        }// end function

        override public function get measuredHeight() : Number
        {
            return 10;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_17:Array = null;
            var _loc_18:Array = null;
            var _loc_19:Array = null;
            var _loc_20:Array = null;
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("backgroundColor");
            var _loc_4:* = getStyle("borderColor");
            var _loc_5:* = getStyle("cornerRadius");
            var _loc_6:* = getStyle("fillAlphas");
            var _loc_7:* = getStyle("fillColors");
            StyleManager.getColorNames(_loc_7);
            var _loc_8:* = getStyle("highlightAlphas");
            var _loc_9:* = getStyle("themeColor");
            var _loc_10:uint = 7305079;
            var _loc_11:* = calcDerivedStyles(_loc_9, _loc_4, _loc_7[0], _loc_7[1]);
            var _loc_12:* = Math.max(_loc_5--, 0);
            var _loc_13:Object = {tl:0, tr:_loc_12, bl:0, br:_loc_12};
            _loc_12 = Math.max(_loc_12--, 0);
            var _loc_14:Object = {tl:0, tr:_loc_12, bl:0, br:_loc_12};
            if (parent && parent.parent)
            {
            }
            var _loc_15:* = parent.parent.rotation != 0;
            if (isNaN(_loc_3))
            {
                _loc_3 = 16777215;
            }
            graphics.clear();
            drawRoundRect(1, 0, param1 - 3, param2, _loc_13, _loc_3, 1);
            switch(name)
            {
                case "thumbUpSkin":
                default:
                {
                    _loc_17 = [_loc_7[0], _loc_7[1]];
                    _loc_18 = [_loc_6[0], _loc_6[1]];
                    drawRoundRect(0, 0, param1, param2, 0, 16777215, 0);
                    if (_loc_15)
                    {
                        drawRoundRect(1, 0, param1 - 2, param2, _loc_5, [_loc_11.borderColorDrk1, _loc_11.borderColorDrk1], [1, 0], horizontalGradientMatrix(2, 0, param1, param2), GradientType.LINEAR, null, {x:1, y:1, w:param1 - 4, h:param2 - 2, r:_loc_14});
                    }
                    else
                    {
                        drawRoundRect(1, param2 - _loc_12, param1 - 3, _loc_12 + 4, {tl:0, tr:0, bl:0, br:_loc_12}, [_loc_11.borderColorDrk1, _loc_11.borderColorDrk1], [1, 0], _loc_15 ? (horizontalGradientMatrix(0, param2 - 4, param1 - 3, 8)) : (verticalGradientMatrix(0, param2 - 4, param1 - 3, 8)), GradientType.LINEAR, null, {x:1, y:param2 - _loc_12, w:param1 - 4, h:_loc_12, r:{tl:0, tr:0, bl:0, br:_loc_12--}});
                    }
                    drawRoundRect(1, 0, param1 - 3, param2, _loc_13, [_loc_4, _loc_11.borderColorDrk1], 1, _loc_15 ? (horizontalGradientMatrix(0, 0, param1, param2)) : (verticalGradientMatrix(0, 0, param1, param2)), GradientType.LINEAR, null, {x:1, y:1, w:param1 - 4, h:param2 - 2, r:_loc_14});
                    drawRoundRect(1, 1, param1 - 4, param2 - 2, _loc_14, _loc_17, _loc_18, _loc_15 ? (horizontalGradientMatrix(1, 0, param1 - 2, param2 - 2)) : (verticalGradientMatrix(1, 0, param1 - 2, param2 - 2)));
                    if (_loc_15)
                    {
                        drawRoundRect(1, 0, (param1 - 4) / 2, param2 - 2, 0, [16777215, 16777215], _loc_8, horizontalGradientMatrix(1, 1, param1 - 4, (param2 - 2) / 2));
                    }
                    else
                    {
                        drawRoundRect(1, 1, param1 - 4, (param2 - 2) / 2, _loc_14, [16777215, 16777215], _loc_8, _loc_15 ? (horizontalGradientMatrix(1, 0, (param1 - 4) / 2, param2 - 2)) : (verticalGradientMatrix(1, 1, param1 - 4, (param2 - 2) / 2)));
                    }
                    break;
                }
                case "thumbDownSkin":
                {
                    if (_loc_7.length > 2)
                    {
                        _loc_19 = [_loc_7[2], _loc_7[3]];
                    }
                    else
                    {
                        _loc_19 = [_loc_7[0], _loc_7[1]];
                    }
                    if (_loc_6.length > 2)
                    {
                        _loc_20 = [_loc_6[2], _loc_6[3]];
                    }
                    else
                    {
                        _loc_20 = [_loc_6[0], _loc_6[1]];
                    }
                    drawRoundRect(0, 0, param1, param2, 0, 16777215, 0);
                    if (_loc_15)
                    {
                        drawRoundRect(1, 0, param1 - 2, param2, _loc_5, [_loc_11.borderColorDrk1, _loc_11.borderColorDrk1], [1, 0], horizontalGradientMatrix(2, 0, param1, param2), GradientType.LINEAR, null, {x:1, y:1, w:param1 - 4, h:param2 - 2, r:_loc_14});
                    }
                    else
                    {
                        drawRoundRect(1, param2 - _loc_12, param1 - 3, _loc_12 + 4, {tl:0, tr:0, bl:0, br:_loc_12}, [_loc_11.borderColorDrk1, _loc_11.borderColorDrk1], [1, 0], _loc_15 ? (horizontalGradientMatrix(0, param2 - 4, param1 - 3, 8)) : (verticalGradientMatrix(0, param2 - 4, param1 - 3, 8)), GradientType.LINEAR, null, {x:1, y:param2 - _loc_12, w:param1 - 4, h:_loc_12, r:{tl:0, tr:0, bl:0, br:_loc_12--}});
                    }
                    drawRoundRect(1, 0, param1 - 3, param2, _loc_13, [_loc_9, _loc_11.themeColDrk1], 1, _loc_15 ? (horizontalGradientMatrix(1, 0, param1, param2)) : (verticalGradientMatrix(0, 0, param1, param2)), GradientType.LINEAR, null, {x:1, y:1, w:param1 - 4, h:param2 - 2, r:_loc_14});
                    drawRoundRect(1, 1, param1 - 4, param2 - 2, _loc_14, _loc_19, _loc_20, _loc_15 ? (horizontalGradientMatrix(1, 0, param1, param2)) : (verticalGradientMatrix(1, 0, param1, param2)));
                    break;
                }
                case "thumbDisabledSkin":
                {
                    if (_loc_15)
                    {
                        drawRoundRect(1, 0, param1 - 2, param2, _loc_13, [_loc_11.borderColorDrk1, _loc_11.borderColorDrk1], [1, 0], horizontalGradientMatrix(2, 0, param1, param2), GradientType.LINEAR, null, {x:1, y:1, w:param1 - 4, h:param2 - 2, r:_loc_14});
                    }
                    else
                    {
                        drawRoundRect(1, param2 - _loc_12, param1 - 3, _loc_12 + 4, {tl:0, tr:0, bl:0, br:_loc_12}, [_loc_11.borderColorDrk1, _loc_11.borderColorDrk1], [1, 0], _loc_15 ? (horizontalGradientMatrix(0, param2 - 4, param1 - 3, 8)) : (verticalGradientMatrix(0, param2 - 4, param1 - 3, 8)), GradientType.LINEAR, null, {x:1, y:param2 - _loc_12, w:param1 - 4, h:_loc_12, r:{tl:0, tr:0, bl:0, br:_loc_12--}});
                    }
                    drawRoundRect(1, 0, param1 - 3, param2, _loc_13, [_loc_9, _loc_11.themeColDrk2], 1, _loc_15 ? (horizontalGradientMatrix(1, 0, param1, param2)) : (verticalGradientMatrix(0, 0, param1, param2)), GradientType.LINEAR, null, {x:1, y:1, w:param1 - 4, h:param2 - 2, r:_loc_14});
                    drawRoundRect(1, 1, param1 - 4, param2 - 2, _loc_14, [_loc_11.fillColorPress1, _loc_11.fillColorPress2], 1, _loc_15 ? (horizontalGradientMatrix(1, 0, param1, param2)) : (verticalGradientMatrix(1, 0, param1, param2)));
                    break;
                }
                case :
                {
                    drawRoundRect(0, 0, param1, param2, 0, 16777215, 0);
                    drawRoundRect(1, 0, param1 - 3, param2, _loc_13, 10066329, 0.5);
                    drawRoundRect(1, 1, param1 - 4, param2 - 2, _loc_14, 16777215, 0.5);
                    break;
                    break;
                }
            }
            var _loc_16:* = Math.floor(param1 / 2 - 4);
            drawRoundRect(_loc_16, Math.floor(param2 / 2 - 4), 5, 1, 0, 0, 0.4);
            drawRoundRect(_loc_16, Math.floor(param2 / 2 - 2), 5, 1, 0, 0, 0.4);
            drawRoundRect(_loc_16, Math.floor(param2 / 2), 5, 1, 0, 0, 0.4);
            drawRoundRect(_loc_16, Math.floor(param2 / 2 + 2), 5, 1, 0, 0, 0.4);
            drawRoundRect(_loc_16, Math.floor(param2 / 2 + 4), 5, 1, 0, 0, 0.4);
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
