package mx.skins.halo
{
    import flash.display.*;
    import flash.utils.*;
    import mx.core.*;

    public class PanelSkin extends HaloBorder
    {
        private var oldControlBarHeight:Number;
        protected var _panelBorderMetrics:EdgeMetrics;
        private var oldHeaderHeight:Number;
        static const VERSION:String = "3.2.0.3958";
        private static var panels:Object = {};

        public function PanelSkin()
        {
            return;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            super.styleChanged(param1);
            if (param1 == null || param1 == "styleName" || param1 == "borderStyle" || param1 == "borderThickness" || param1 == "borderThicknessTop" || param1 == "borderThicknessBottom" || param1 == "borderThicknessLeft" || param1 == "borderThicknessRight" || param1 == "borderSides")
            {
                _panelBorderMetrics = null;
            }
            invalidateDisplayList();
            return;
        }// end function

        override function drawBorder(param1:Number, param2:Number) : void
        {
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_6:Number = NaN;
            var _loc_7:Graphics = null;
            var _loc_8:IContainer = null;
            var _loc_9:EdgeMetrics = null;
            super.drawBorder(param1, param2);
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                return;
            }
            var _loc_3:* = getStyle("borderStyle");
            if (_loc_3 == "default")
            {
                _loc_4 = getStyle("backgroundAlpha");
                _loc_5 = getStyle("borderAlpha");
                backgroundAlphaName = "borderAlpha";
                radiusObj = null;
                radius = getStyle("cornerRadius");
                bRoundedCorners = getStyle("roundedBottomCorners").toString().toLowerCase() == "true";
                _loc_6 = bRoundedCorners ? (radius) : (0);
                _loc_7 = graphics;
                drawDropShadow(0, 0, param1, param2, radius, radius, _loc_6, _loc_6);
                if (!bRoundedCorners)
                {
                    radiusObj = {};
                }
                _loc_8 = parent as IContainer;
                if (_loc_8)
                {
                    _loc_9 = _loc_8.viewMetrics;
                    backgroundHole = {x:_loc_9.left, y:_loc_9.top, w:Math.max(0, param1 - _loc_9.left - _loc_9.right), h:Math.max(0, param2 - _loc_9.top - _loc_9.bottom), r:0};
                    if (backgroundHole.w > 0 && backgroundHole.h > 0)
                    {
                        if (_loc_4 != _loc_5)
                        {
                            drawDropShadow(backgroundHole.x, backgroundHole.y, backgroundHole.w, backgroundHole.h, 0, 0, 0, 0);
                        }
                        _loc_7.beginFill(Number(backgroundColor), _loc_4);
                        _loc_7.drawRect(backgroundHole.x, backgroundHole.y, backgroundHole.w, backgroundHole.h);
                        _loc_7.endFill();
                    }
                }
                backgroundColor = getStyle("borderColor");
            }
            return;
        }// end function

        override public function get borderMetrics() : EdgeMetrics
        {
            var _loc_4:Number = NaN;
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                return super.borderMetrics;
            }
            var _loc_1:* = isPanel(parent);
            var _loc_2:* = _loc_1 ? (Object(parent)._controlBar) : (null);
            var _loc_3:* = _loc_1 ? (Object(parent).getHeaderHeightProxy()) : (NaN);
            if (_loc_2 && _loc_2.includeInLayout)
            {
                _loc_4 = _loc_2.getExplicitOrMeasuredHeight();
            }
            if (_loc_4 != oldControlBarHeight && isNaN(oldControlBarHeight) && !isNaN(_loc_4))
            {
                _panelBorderMetrics = null;
            }
            if (_loc_3 != oldHeaderHeight && isNaN(_loc_3) && !isNaN(oldHeaderHeight))
            {
                _panelBorderMetrics = null;
            }
            if (_panelBorderMetrics)
            {
                return _panelBorderMetrics;
            }
            var _loc_5:* = super.borderMetrics;
            var _loc_6:* = new EdgeMetrics(0, 0, 0, 0);
            var _loc_7:* = getStyle("borderThickness");
            var _loc_8:* = getStyle("borderThicknessLeft");
            var _loc_9:* = getStyle("borderThicknessTop");
            var _loc_10:* = getStyle("borderThicknessRight");
            var _loc_11:* = getStyle("borderThicknessBottom");
            _loc_6.left = _loc_5.left + (isNaN(_loc_8) ? (_loc_7) : (_loc_8));
            _loc_6.top = _loc_5.top + (isNaN(_loc_9) ? (_loc_7) : (_loc_9));
            _loc_6.right = _loc_5.bottom + (isNaN(_loc_10) ? (_loc_7) : (_loc_10));
            if (_loc_2)
            {
            }
            _loc_6.bottom = _loc_5.bottom + (isNaN(_loc_11) ? (if (!_loc_2) goto 46, !isNaN(_loc_9) ? (_loc_9) : (isNaN(_loc_8) ? (_loc_7) : (_loc_8))) : (_loc_11));
            oldHeaderHeight = _loc_3;
            if (!isNaN(_loc_3))
            {
                _loc_6.top = _loc_6.top + _loc_3;
            }
            oldControlBarHeight = _loc_4;
            if (!isNaN(_loc_4))
            {
                _loc_6.bottom = _loc_6.bottom + _loc_4;
            }
            _panelBorderMetrics = _loc_6;
            return _panelBorderMetrics;
        }// end function

        override function drawBackground(param1:Number, param2:Number) : void
        {
            var _loc_3:Array = null;
            var _loc_4:Number = NaN;
            super.drawBackground(param1, param2);
            if (getStyle("headerColors") == null && getStyle("borderStyle") == "default")
            {
                _loc_3 = getStyle("highlightAlphas");
                _loc_4 = _loc_3 ? (_loc_3[0]) : (0.3);
                drawRoundRect(0, 0, param1, param2, {tl:radius, tr:radius, bl:0, br:0}, 16777215, _loc_4, null, GradientType.LINEAR, null, {x:0, y:1, w:param1, h:param2--, r:{tl:radius, tr:radius, bl:0, br:0}});
            }
            return;
        }// end function

        override function getBackgroundColorMetrics() : EdgeMetrics
        {
            if (getStyle("borderStyle") == "default")
            {
                return EdgeMetrics.EMPTY;
            }
            return super.borderMetrics;
        }// end function

        private static function isPanel(param1:Object) : Boolean
        {
            var s:String;
            var x:XML;
            var parent:* = param1;
            s = getQualifiedClassName(parent);
            if (panels[s] == 1)
            {
                return true;
            }
            if (panels[s] == 0)
            {
                return false;
            }
            if (s == "mx.containers::Panel")
            {
                return true;
            }
            x = describeType(parent);
            var _loc_4:int = 0;
            var _loc_5:* = x.extendsClass;
            var _loc_3:* = new XMLList("");
            for each (_loc_6 in _loc_5)
            {
                
                var _loc_7:* = _loc_5[_loc_4];
                with (_loc_5[_loc_4])
                {
                    if (@type == "mx.containers::Panel")
                    {
                        _loc_3[_loc_4] = _loc_6;
                    }
                }
            }
            var xmllist:* = _loc_3;
            if (xmllist.length() == 0)
            {
                panels[s] = 0;
                return false;
            }
            panels[s] = 1;
            return true;
        }// end function

    }
}
