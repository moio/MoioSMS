package mx.skins.halo
{
    import flash.filters.*;
    import mx.core.*;
    import mx.graphics.*;
    import mx.skins.*;

    public class ToolTipBorder extends RectangularBorder
    {
        private var _borderMetrics:EdgeMetrics;
        private var dropShadow:RectangularDropShadow;
        static const VERSION:String = "3.2.0.3958";

        public function ToolTipBorder()
        {
            return;
        }// end function

        override public function get borderMetrics() : EdgeMetrics
        {
            if (_borderMetrics)
            {
                return _borderMetrics;
            }
            var _loc_1:* = getStyle("borderStyle");
            switch(_loc_1)
            {
                case "errorTipRight":
                {
                    _borderMetrics = new EdgeMetrics(15, 1, 3, 3);
                    break;
                }
                case "errorTipAbove":
                {
                    _borderMetrics = new EdgeMetrics(3, 1, 3, 15);
                    break;
                }
                case "errorTipBelow":
                {
                    _borderMetrics = new EdgeMetrics(3, 13, 3, 3);
                    break;
                }
                default:
                {
                    _borderMetrics = new EdgeMetrics(3, 1, 3, 3);
                    break;
                    break;
                }
            }
            return _borderMetrics;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("borderStyle");
            var _loc_4:* = getStyle("backgroundColor");
            var _loc_5:* = getStyle("backgroundAlpha");
            var _loc_6:* = getStyle("borderColor");
            var _loc_7:* = getStyle("cornerRadius");
            var _loc_8:* = getStyle("shadowColor");
            var _loc_9:Number = 0.1;
            var _loc_10:* = graphics;
            graphics.clear();
            filters = [];
            switch(_loc_3)
            {
                case "toolTip":
                {
                    drawRoundRect(3, 1, param1 - 6, param2 - 4, _loc_7, _loc_4, _loc_5);
                    if (!dropShadow)
                    {
                        dropShadow = new RectangularDropShadow();
                    }
                    dropShadow.distance = 3;
                    dropShadow.angle = 90;
                    dropShadow.color = 0;
                    dropShadow.alpha = 0.4;
                    dropShadow.tlRadius = _loc_7 + 2;
                    dropShadow.trRadius = _loc_7 + 2;
                    dropShadow.blRadius = _loc_7 + 2;
                    dropShadow.brRadius = _loc_7 + 2;
                    dropShadow.drawShadow(graphics, 3, 0, param1 - 6, param2 - 4);
                    break;
                }
                case "errorTipRight":
                {
                    drawRoundRect(11, 0, param1 - 11, param2 - 2, 3, _loc_6, _loc_5);
                    _loc_10.beginFill(_loc_6, _loc_5);
                    _loc_10.moveTo(11, 7);
                    _loc_10.lineTo(0, 13);
                    _loc_10.lineTo(11, 19);
                    _loc_10.moveTo(11, 7);
                    _loc_10.endFill();
                    filters = [new DropShadowFilter(2, 90, 0, 0.4)];
                    break;
                }
                case "errorTipAbove":
                {
                    drawRoundRect(0, 0, param1, param2 - 13, 3, _loc_6, _loc_5);
                    _loc_10.beginFill(_loc_6, _loc_5);
                    _loc_10.moveTo(9, param2 - 13);
                    _loc_10.lineTo(15, param2 - 2);
                    _loc_10.lineTo(21, param2 - 13);
                    _loc_10.moveTo(9, param2 - 13);
                    _loc_10.endFill();
                    filters = [new DropShadowFilter(2, 90, 0, 0.4)];
                    break;
                }
                case "errorTipBelow":
                {
                    drawRoundRect(0, 11, param1, param2 - 13, 3, _loc_6, _loc_5);
                    _loc_10.beginFill(_loc_6, _loc_5);
                    _loc_10.moveTo(9, 11);
                    _loc_10.lineTo(15, 0);
                    _loc_10.lineTo(21, 11);
                    _loc_10.moveTo(10, 11);
                    _loc_10.endFill();
                    filters = [new DropShadowFilter(2, 90, 0, 0.4)];
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            if (param1 == "borderStyle" || param1 == "styleName" || param1 == null)
            {
                _borderMetrics = null;
            }
            invalidateDisplayList();
            return;
        }// end function

    }
}
