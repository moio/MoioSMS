package mx.skins.halo
{
    import flash.display.*;
    import mx.core.*;
    import mx.graphics.*;
    import mx.skins.*;
    import mx.styles.*;
    import mx.utils.*;

    public class HaloBorder extends RectangularBorder
    {
        var radiusObj:Object;
        var backgroundHole:Object;
        var radius:Number;
        var bRoundedCorners:Boolean;
        var backgroundColor:Object;
        private var dropShadow:RectangularDropShadow;
        protected var _borderMetrics:EdgeMetrics;
        var backgroundAlphaName:String;
        static const VERSION:String = "3.2.0.3958";
        private static var BORDER_WIDTHS:Object = {none:0, solid:1, inset:2, outset:2, alert:3, dropdown:2, menuBorder:1, comboNonEdit:2};

        public function HaloBorder()
        {
            BORDER_WIDTHS["default"] = 3;
            return;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            if (param1 == null || param1 == "styleName" || param1 == "borderStyle" || param1 == "borderThickness" || param1 == "borderSides")
            {
                _borderMetrics = null;
            }
            invalidateDisplayList();
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            if (isNaN(param1) || isNaN(param2))
            {
                return;
            }
            super.updateDisplayList(param1, param2);
            backgroundColor = getBackgroundColor();
            bRoundedCorners = false;
            backgroundAlphaName = "backgroundAlpha";
            backgroundHole = null;
            radius = 0;
            radiusObj = null;
            drawBorder(param1, param2);
            drawBackground(param1, param2);
            return;
        }// end function

        function drawBorder(param1:Number, param2:Number) : void
        {
            var _loc_5:Number = NaN;
            var _loc_6:uint = 0;
            var _loc_7:uint = 0;
            var _loc_8:String = null;
            var _loc_9:Number = NaN;
            var _loc_10:uint = 0;
            var _loc_11:Boolean = false;
            var _loc_12:uint = 0;
            var _loc_13:Array = null;
            var _loc_14:Array = null;
            var _loc_15:uint = 0;
            var _loc_16:uint = 0;
            var _loc_17:uint = 0;
            var _loc_18:uint = 0;
            var _loc_19:Boolean = false;
            var _loc_20:Object = null;
            var _loc_22:Number = NaN;
            var _loc_23:Number = NaN;
            var _loc_24:Number = NaN;
            var _loc_25:Object = null;
            var _loc_27:Number = NaN;
            var _loc_28:Number = NaN;
            var _loc_29:IContainer = null;
            var _loc_30:EdgeMetrics = null;
            var _loc_31:Boolean = false;
            var _loc_32:Number = NaN;
            var _loc_33:Array = null;
            var _loc_34:uint = 0;
            var _loc_35:Boolean = false;
            var _loc_36:Number = NaN;
            var _loc_3:* = getStyle("borderStyle");
            var _loc_4:* = getStyle("highlightAlphas");
            var _loc_21:Boolean = false;
            var _loc_26:* = graphics;
            graphics.clear();
            if (_loc_3)
            {
                switch(_loc_3)
                {
                    case "none":
                    {
                        break;
                    }
                    case "inset":
                    {
                        _loc_7 = getStyle("borderColor");
                        _loc_22 = ColorUtil.adjustBrightness2(_loc_7, -40);
                        _loc_23 = ColorUtil.adjustBrightness2(_loc_7, 25);
                        _loc_24 = ColorUtil.adjustBrightness2(_loc_7, 40);
                        _loc_25 = backgroundColor;
                        if (_loc_25 === null || _loc_25 === "")
                        {
                            _loc_25 = _loc_7;
                        }
                        draw3dBorder(_loc_23, _loc_22, _loc_24, Number(_loc_25), Number(_loc_25), Number(_loc_25));
                        break;
                    }
                    case "outset":
                    {
                        _loc_7 = getStyle("borderColor");
                        _loc_22 = ColorUtil.adjustBrightness2(_loc_7, -40);
                        _loc_23 = ColorUtil.adjustBrightness2(_loc_7, -25);
                        _loc_24 = ColorUtil.adjustBrightness2(_loc_7, 40);
                        _loc_25 = backgroundColor;
                        if (_loc_25 === null || _loc_25 === "")
                        {
                            _loc_25 = _loc_7;
                        }
                        draw3dBorder(_loc_23, _loc_24, _loc_22, Number(_loc_25), Number(_loc_25), Number(_loc_25));
                        break;
                    }
                    case "alert":
                    case "default":
                    {
                        if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
                        {
                            _loc_27 = getStyle("backgroundAlpha");
                            _loc_5 = getStyle("borderAlpha");
                            backgroundAlphaName = "borderAlpha";
                            radius = getStyle("cornerRadius");
                            bRoundedCorners = getStyle("roundedBottomCorners").toString().toLowerCase() == "true";
                            _loc_28 = bRoundedCorners ? (radius) : (0);
                            drawDropShadow(0, 0, param1, param2, radius, radius, _loc_28, _loc_28);
                            if (!bRoundedCorners)
                            {
                                radiusObj = {};
                            }
                            _loc_29 = parent as IContainer;
                            if (_loc_29)
                            {
                                _loc_30 = _loc_29.viewMetrics;
                                backgroundHole = {x:_loc_30.left, y:_loc_30.top, w:Math.max(0, param1 - _loc_30.left - _loc_30.right), h:Math.max(0, param2 - _loc_30.top - _loc_30.bottom), r:0};
                                if (backgroundHole.w > 0 && backgroundHole.h > 0)
                                {
                                    if (_loc_27 != _loc_5)
                                    {
                                        drawDropShadow(backgroundHole.x, backgroundHole.y, backgroundHole.w, backgroundHole.h, 0, 0, 0, 0);
                                    }
                                    _loc_26.beginFill(Number(backgroundColor), _loc_27);
                                    _loc_26.drawRect(backgroundHole.x, backgroundHole.y, backgroundHole.w, backgroundHole.h);
                                    _loc_26.endFill();
                                }
                            }
                            backgroundColor = getStyle("borderColor");
                        }
                        break;
                    }
                    case "dropdown":
                    {
                        _loc_12 = getStyle("dropdownBorderColor");
                        drawDropShadow(0, 0, param1, param2, 4, 0, 0, 4);
                        drawRoundRect(0, 0, param1, param2, {tl:4, tr:0, br:0, bl:4}, 5068126, 1);
                        drawRoundRect(0, 0, param1, param2, {tl:4, tr:0, br:0, bl:4}, [16777215, 16777215], [0.7, 0], verticalGradientMatrix(0, 0, param1, param2));
                        drawRoundRect(1, 1, param1--, param2 - 2, {tl:3, tr:0, br:0, bl:3}, 16777215, 1);
                        drawRoundRect(1, 2, param1--, param2 - 3, {tl:3, tr:0, br:0, bl:3}, [15658734, 16777215], 1, verticalGradientMatrix(0, 0, param1--, param2 - 3));
                        if (!isNaN(_loc_12))
                        {
                            drawRoundRect(0, 0, param1 + 1, param2, {tl:4, tr:0, br:0, bl:4}, _loc_12, 0.5);
                            drawRoundRect(1, 1, param1--, param2 - 2, {tl:3, tr:0, br:0, bl:3}, 16777215, 1);
                            drawRoundRect(1, 2, param1--, param2 - 3, {tl:3, tr:0, br:0, bl:3}, [15658734, 16777215], 1, verticalGradientMatrix(0, 0, param1--, param2 - 3));
                        }
                        backgroundColor = null;
                        break;
                    }
                    case "menuBorder":
                    {
                        _loc_7 = getStyle("borderColor");
                        drawRoundRect(0, 0, param1, param2, 0, _loc_7, 1);
                        drawDropShadow(1, 1, param1 - 2, param2 - 2, 0, 0, 0, 0);
                        break;
                    }
                    case "comboNonEdit":
                    {
                        break;
                    }
                    case "controlBar":
                    {
                        if (param1 == 0 || param2 == 0)
                        {
                            backgroundColor = null;
                            break;
                        }
                        _loc_14 = getStyle("footerColors");
                        _loc_31 = _loc_14 != null;
                        _loc_32 = getStyle("borderAlpha");
                        if (_loc_31)
                        {
                            _loc_26.lineStyle(0, _loc_14.length > 0 ? (_loc_14[1]) : (_loc_14[0]), _loc_32);
                            _loc_26.moveTo(0, 0);
                            _loc_26.lineTo(param1, 0);
                            _loc_26.lineStyle(0, 0, 0);
                            if (parent && parent.parent && parent.parent is IStyleClient)
                            {
                                radius = IStyleClient(parent.parent).getStyle("cornerRadius");
                                _loc_32 = IStyleClient(parent.parent).getStyle("borderAlpha");
                            }
                            if (isNaN(radius))
                            {
                                radius = 0;
                            }
                            if (IStyleClient(parent.parent).getStyle("roundedBottomCorners").toString().toLowerCase() != "true")
                            {
                                radius = 0;
                            }
                            drawRoundRect(0, 1, param1, param2--, {tl:0, tr:0, bl:radius, br:radius}, _loc_14, _loc_32, verticalGradientMatrix(0, 0, param1, param2));
                            if (_loc_14.length > 1 && _loc_14[0] != _loc_14[1])
                            {
                                drawRoundRect(0, 1, param1, param2--, {tl:0, tr:0, bl:radius, br:radius}, [16777215, 16777215], _loc_4, verticalGradientMatrix(0, 0, param1, param2));
                                drawRoundRect(1, 2, param1 - 2, param2 - 3, {tl:0, tr:0, bl:radius--, br:radius--}, _loc_14, _loc_32, verticalGradientMatrix(0, 0, param1, param2));
                            }
                        }
                        backgroundColor = null;
                        break;
                    }
                    case "applicationControlBar":
                    {
                        _loc_13 = getStyle("fillColors");
                        _loc_5 = getStyle("backgroundAlpha");
                        _loc_4 = getStyle("highlightAlphas");
                        _loc_33 = getStyle("fillAlphas");
                        _loc_11 = getStyle("docked");
                        _loc_34 = uint(backgroundColor);
                        radius = getStyle("cornerRadius");
                        if (!radius)
                        {
                            radius = 0;
                        }
                        drawDropShadow(0, 1, param1, param2--, radius, radius, radius, radius);
                        if (backgroundColor !== null && StyleManager.isValidStyleValue(backgroundColor))
                        {
                            drawRoundRect(0, 1, param1, param2--, radius, _loc_34, _loc_5, verticalGradientMatrix(0, 0, param1, param2));
                        }
                        drawRoundRect(0, 1, param1, param2--, radius, _loc_13, _loc_33, verticalGradientMatrix(0, 0, param1, param2));
                        drawRoundRect(0, 1, param1, (param2 / 2)--, {tl:radius, tr:radius, bl:0, br:0}, [16777215, 16777215], _loc_4, verticalGradientMatrix(0, 0, param1, (param2 / 2)--));
                        drawRoundRect(0, 1, param1, param2--, {tl:radius, tr:radius, bl:0, br:0}, 16777215, 0.3, null, GradientType.LINEAR, null, {x:0, y:2, w:param1, h:param2 - 2, r:{tl:radius, tr:radius, bl:0, br:0}});
                        backgroundColor = null;
                        break;
                    }
                    default:
                    {
                        _loc_7 = getStyle("borderColor");
                        _loc_9 = getStyle("borderThickness");
                        _loc_8 = getStyle("borderSides");
                        _loc_35 = true;
                        radius = getStyle("cornerRadius");
                        bRoundedCorners = getStyle("roundedBottomCorners").toString().toLowerCase() == "true";
                        _loc_36 = Math.max(radius - _loc_9, 0);
                        _loc_20 = {x:_loc_9, y:_loc_9, w:param1 - _loc_9 * 2, h:param2 - _loc_9 * 2, r:_loc_36};
                        if (!bRoundedCorners)
                        {
                            radiusObj = {tl:radius, tr:radius, bl:0, br:0};
                            _loc_20.r = {tl:_loc_36, tr:_loc_36, bl:0, br:0};
                        }
                        if (_loc_8 != "left top right bottom")
                        {
                            _loc_20.r = {tl:_loc_36, tr:_loc_36, bl:bRoundedCorners ? (_loc_36) : (0), br:bRoundedCorners ? (_loc_36) : (0)};
                            radiusObj = {tl:radius, tr:radius, bl:bRoundedCorners ? (radius) : (0), br:bRoundedCorners ? (radius) : (0)};
                            _loc_8 = _loc_8.toLowerCase();
                            if (_loc_8.indexOf("left") == -1)
                            {
                                _loc_20.x = 0;
                                _loc_20.w = _loc_20.w + _loc_9;
                                _loc_20.r.tl = 0;
                                _loc_20.r.bl = 0;
                                radiusObj.tl = 0;
                                radiusObj.bl = 0;
                                _loc_35 = false;
                            }
                            if (_loc_8.indexOf("top") == -1)
                            {
                                _loc_20.y = 0;
                                _loc_20.h = _loc_20.h + _loc_9;
                                _loc_20.r.tl = 0;
                                _loc_20.r.tr = 0;
                                radiusObj.tl = 0;
                                radiusObj.tr = 0;
                                _loc_35 = false;
                            }
                            if (_loc_8.indexOf("right") == -1)
                            {
                                _loc_20.w = _loc_20.w + _loc_9;
                                _loc_20.r.tr = 0;
                                _loc_20.r.br = 0;
                                radiusObj.tr = 0;
                                radiusObj.br = 0;
                                _loc_35 = false;
                            }
                            if (_loc_8.indexOf("bottom") == -1)
                            {
                                _loc_20.h = _loc_20.h + _loc_9;
                                _loc_20.r.bl = 0;
                                _loc_20.r.br = 0;
                                radiusObj.bl = 0;
                                radiusObj.br = 0;
                                _loc_35 = false;
                            }
                        }
                        if (radius == 0 && _loc_35)
                        {
                            drawDropShadow(0, 0, param1, param2, 0, 0, 0, 0);
                            _loc_26.beginFill(_loc_7);
                            _loc_26.drawRect(0, 0, param1, param2);
                            _loc_26.drawRect(_loc_9, _loc_9, param1 - 2 * _loc_9, param2 - 2 * _loc_9);
                            _loc_26.endFill();
                        }
                        else if (radiusObj)
                        {
                            drawDropShadow(0, 0, param1, param2, radiusObj.tl, radiusObj.tr, radiusObj.br, radiusObj.bl);
                            drawRoundRect(0, 0, param1, param2, radiusObj, _loc_7, 1, null, null, null, _loc_20);
                            radiusObj.tl = Math.max(radius - _loc_9, 0);
                            radiusObj.tr = Math.max(radius - _loc_9, 0);
                            radiusObj.bl = bRoundedCorners ? (Math.max(radius - _loc_9, 0)) : (0);
                            radiusObj.br = bRoundedCorners ? (Math.max(radius - _loc_9, 0)) : (0);
                        }
                        else
                        {
                            drawDropShadow(0, 0, param1, param2, radius, radius, radius, radius);
                            drawRoundRect(0, 0, param1, param2, radius, _loc_7, 1, null, null, null, _loc_20);
                            radius = Math.max(getStyle("cornerRadius") - _loc_9, 0);
                        }
                        break;
                    }
                }
            }
            return;
        }// end function

        function drawBackground(param1:Number, param2:Number) : void
        {
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_6:EdgeMetrics = null;
            var _loc_7:Graphics = null;
            var _loc_8:Number = NaN;
            var _loc_9:Number = NaN;
            var _loc_10:Array = null;
            var _loc_11:Number = NaN;
            if (backgroundColor !== null && backgroundColor !== "" || getStyle("mouseShield") || getStyle("mouseShieldChildren"))
            {
                _loc_4 = Number(backgroundColor);
                _loc_5 = 1;
                _loc_6 = getBackgroundColorMetrics();
                _loc_7 = graphics;
                if (isNaN(_loc_4) || backgroundColor === "" || backgroundColor === null)
                {
                    _loc_5 = 0;
                    _loc_4 = 16777215;
                }
                else
                {
                    _loc_5 = getStyle(backgroundAlphaName);
                }
                if (radius != 0 || backgroundHole)
                {
                    _loc_8 = _loc_6.bottom;
                    if (radiusObj)
                    {
                        _loc_9 = bRoundedCorners ? (radius) : (0);
                        radiusObj = {tl:radius, tr:radius, bl:_loc_9, br:_loc_9};
                        drawRoundRect(_loc_6.left, _loc_6.top, width - (_loc_6.left + _loc_6.right), height - (_loc_6.top + _loc_8), radiusObj, _loc_4, _loc_5, null, GradientType.LINEAR, null, backgroundHole);
                    }
                    else
                    {
                        drawRoundRect(_loc_6.left, _loc_6.top, width - (_loc_6.left + _loc_6.right), height - (_loc_6.top + _loc_8), radius, _loc_4, _loc_5, null, GradientType.LINEAR, null, backgroundHole);
                    }
                }
                else
                {
                    _loc_7.beginFill(_loc_4, _loc_5);
                    _loc_7.drawRect(_loc_6.left, _loc_6.top, param1 - _loc_6.right - _loc_6.left, param2 - _loc_6.bottom - _loc_6.top);
                    _loc_7.endFill();
                }
            }
            var _loc_3:* = getStyle("borderStyle");
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0 && _loc_3 == "alert" || _loc_3 == "default" && getStyle("headerColors") == null)
            {
                _loc_10 = getStyle("highlightAlphas");
                _loc_11 = _loc_10 ? (_loc_10[0]) : (0.3);
                drawRoundRect(0, 0, param1, param2, {tl:radius, tr:radius, bl:0, br:0}, 16777215, _loc_11, null, GradientType.LINEAR, null, {x:0, y:1, w:param1, h:param2--, r:{tl:radius, tr:radius, bl:0, br:0}});
            }
            return;
        }// end function

        function drawDropShadow(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : void
        {
            var _loc_11:Number = NaN;
            var _loc_12:Boolean = false;
            if (getStyle("dropShadowEnabled") == false || getStyle("dropShadowEnabled") == "false" || param3 == 0 || param4 == 0)
            {
                return;
            }
            var _loc_9:* = getStyle("shadowDistance");
            var _loc_10:* = getStyle("shadowDirection");
            if (getStyle("borderStyle") == "applicationControlBar")
            {
                _loc_12 = getStyle("docked");
                _loc_11 = _loc_12 ? (90) : (getDropShadowAngle(_loc_9, _loc_10));
                _loc_9 = Math.abs(_loc_9);
            }
            else
            {
                _loc_11 = getDropShadowAngle(_loc_9, _loc_10);
                _loc_9 = Math.abs(_loc_9) + 2;
            }
            if (!dropShadow)
            {
                dropShadow = new RectangularDropShadow();
            }
            dropShadow.distance = _loc_9;
            dropShadow.angle = _loc_11;
            dropShadow.color = getStyle("dropShadowColor");
            dropShadow.alpha = 0.4;
            dropShadow.tlRadius = param5;
            dropShadow.trRadius = param6;
            dropShadow.blRadius = param8;
            dropShadow.brRadius = param7;
            dropShadow.drawShadow(graphics, param1, param2, param3, param4);
            return;
        }// end function

        function getBackgroundColor() : Object
        {
            var _loc_2:Object = null;
            var _loc_1:* = parent as IUIComponent;
            if (_loc_1 && !_loc_1.enabled)
            {
                _loc_2 = getStyle("backgroundDisabledColor");
                if (_loc_2 !== null && StyleManager.isValidStyleValue(_loc_2))
                {
                    return _loc_2;
                }
            }
            return getStyle("backgroundColor");
        }// end function

        function draw3dBorder(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void
        {
            var _loc_7:* = width;
            var _loc_8:* = height;
            drawDropShadow(0, 0, width, height, 0, 0, 0, 0);
            var _loc_9:* = graphics;
            graphics.beginFill(param1);
            _loc_9.drawRect(0, 0, _loc_7, _loc_8);
            _loc_9.drawRect(1, 0, _loc_7 - 2, _loc_8);
            _loc_9.endFill();
            _loc_9.beginFill(param2);
            _loc_9.drawRect(1, 0, _loc_7 - 2, 1);
            _loc_9.endFill();
            _loc_9.beginFill(param3);
            _loc_9.drawRect(1, _loc_8--, _loc_7 - 2, 1);
            _loc_9.endFill();
            _loc_9.beginFill(param4);
            _loc_9.drawRect(1, 1, _loc_7 - 2, 1);
            _loc_9.endFill();
            _loc_9.beginFill(param5);
            _loc_9.drawRect(1, _loc_8 - 2, _loc_7 - 2, 1);
            _loc_9.endFill();
            _loc_9.beginFill(param6);
            _loc_9.drawRect(1, 2, _loc_7 - 2, _loc_8 - 4);
            _loc_9.drawRect(2, 2, _loc_7 - 4, _loc_8 - 4);
            _loc_9.endFill();
            return;
        }// end function

        function getBackgroundColorMetrics() : EdgeMetrics
        {
            return borderMetrics;
        }// end function

        function getDropShadowAngle(param1:Number, param2:String) : Number
        {
            if (param2 == "left")
            {
                return param1 >= 0 ? (135) : (225);
            }
            else
            {
                if (param2 == "right")
                {
                    return param1 >= 0 ? (45) : (315);
                }
                else
                {
                    return param1 >= 0 ? (90) : (270);
                }
            }
        }// end function

        override public function get borderMetrics() : EdgeMetrics
        {
            var _loc_1:Number = NaN;
            var _loc_3:String = null;
            if (_borderMetrics)
            {
                return _borderMetrics;
            }
            var _loc_2:* = getStyle("borderStyle");
            if (_loc_2 == "default" || _loc_2 == "alert")
            {
                if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
                {
                    _borderMetrics = new EdgeMetrics(0, 0, 0, 0);
                }
                else
                {
                    return EdgeMetrics.EMPTY;
                }
            }
            else if (_loc_2 == "controlBar" || _loc_2 == "applicationControlBar")
            {
                _borderMetrics = new EdgeMetrics(1, 1, 1, 1);
            }
            else if (_loc_2 == "solid")
            {
                _loc_1 = getStyle("borderThickness");
                if (isNaN(_loc_1))
                {
                    _loc_1 = 0;
                }
                _borderMetrics = new EdgeMetrics(_loc_1, _loc_1, _loc_1, _loc_1);
                _loc_3 = getStyle("borderSides");
                if (_loc_3 != "left top right bottom")
                {
                    if (_loc_3.indexOf("left") == -1)
                    {
                        _borderMetrics.left = 0;
                    }
                    if (_loc_3.indexOf("top") == -1)
                    {
                        _borderMetrics.top = 0;
                    }
                    if (_loc_3.indexOf("right") == -1)
                    {
                        _borderMetrics.right = 0;
                    }
                    if (_loc_3.indexOf("bottom") == -1)
                    {
                        _borderMetrics.bottom = 0;
                    }
                }
            }
            else
            {
                _loc_1 = BORDER_WIDTHS[_loc_2];
                if (isNaN(_loc_1))
                {
                    _loc_1 = 0;
                }
                _borderMetrics = new EdgeMetrics(_loc_1, _loc_1, _loc_1, _loc_1);
            }
            return _borderMetrics;
        }// end function

    }
}
