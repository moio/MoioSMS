package mx.graphics
{
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import mx.core.*;
    import mx.utils.*;

    public class RectangularDropShadow extends Object
    {
        private var leftShadow:BitmapData;
        private var _tlRadius:Number = 0;
        private var _trRadius:Number = 0;
        private var _angle:Number = 45;
        private var topShadow:BitmapData;
        private var _distance:Number = 4;
        private var rightShadow:BitmapData;
        private var _alpha:Number = 0.4;
        private var shadow:BitmapData;
        private var _brRadius:Number = 0;
        private var _blRadius:Number = 0;
        private var _color:int = 0;
        private var bottomShadow:BitmapData;
        private var changed:Boolean = true;
        static const VERSION:String = "3.2.0.3958";

        public function RectangularDropShadow()
        {
            return;
        }// end function

        public function get blRadius() : Number
        {
            return _blRadius;
        }// end function

        public function set brRadius(param1:Number) : void
        {
            if (_brRadius != param1)
            {
                _brRadius = param1;
                changed = true;
            }
            return;
        }// end function

        public function set color(param1:int) : void
        {
            if (_color != param1)
            {
                _color = param1;
                changed = true;
            }
            return;
        }// end function

        public function drawShadow(param1:Graphics, param2:Number, param3:Number, param4:Number, param5:Number) : void
        {
            var _loc_15:Number = NaN;
            var _loc_16:Number = NaN;
            var _loc_17:Number = NaN;
            var _loc_18:Number = NaN;
            var _loc_19:Number = NaN;
            var _loc_20:Number = NaN;
            var _loc_21:Number = NaN;
            var _loc_22:Number = NaN;
            if (changed)
            {
                createShadowBitmaps();
                changed = false;
            }
            param4 = Math.ceil(param4);
            param5 = Math.ceil(param5);
            var _loc_6:* = leftShadow ? (leftShadow.width) : (0);
            var _loc_7:* = rightShadow ? (rightShadow.width) : (0);
            var _loc_8:* = topShadow ? (topShadow.height) : (0);
            var _loc_9:* = bottomShadow ? (bottomShadow.height) : (0);
            var _loc_10:* = _loc_6 + _loc_7;
            var _loc_11:* = _loc_8 + _loc_9;
            var _loc_12:* = (param5 + _loc_11) / 2;
            var _loc_13:* = (param4 + _loc_10) / 2;
            var _loc_14:* = new Matrix();
            if (leftShadow || topShadow)
            {
                _loc_15 = Math.min(tlRadius + _loc_10, _loc_13);
                _loc_16 = Math.min(tlRadius + _loc_11, _loc_12);
                _loc_14.tx = param2 - _loc_6;
                _loc_14.ty = param3 - _loc_8;
                param1.beginBitmapFill(shadow, _loc_14);
                param1.drawRect(param2 - _loc_6, param3 - _loc_8, _loc_15, _loc_16);
                param1.endFill();
            }
            if (rightShadow || topShadow)
            {
                _loc_17 = Math.min(trRadius + _loc_10, _loc_13);
                _loc_18 = Math.min(trRadius + _loc_11, _loc_12);
                _loc_14.tx = param2 + param4 + _loc_7 - shadow.width;
                _loc_14.ty = param3 - _loc_8;
                param1.beginBitmapFill(shadow, _loc_14);
                param1.drawRect(param2 + param4 + _loc_7 - _loc_17, param3 - _loc_8, _loc_17, _loc_18);
                param1.endFill();
            }
            if (leftShadow || bottomShadow)
            {
                _loc_19 = Math.min(blRadius + _loc_10, _loc_13);
                _loc_20 = Math.min(blRadius + _loc_11, _loc_12);
                _loc_14.tx = param2 - _loc_6;
                _loc_14.ty = param3 + param5 + _loc_9 - shadow.height;
                param1.beginBitmapFill(shadow, _loc_14);
                param1.drawRect(param2 - _loc_6, param3 + param5 + _loc_9 - _loc_20, _loc_19, _loc_20);
                param1.endFill();
            }
            if (rightShadow || bottomShadow)
            {
                _loc_21 = Math.min(brRadius + _loc_10, _loc_13);
                _loc_22 = Math.min(brRadius + _loc_11, _loc_12);
                _loc_14.tx = param2 + param4 + _loc_7 - shadow.width;
                _loc_14.ty = param3 + param5 + _loc_9 - shadow.height;
                param1.beginBitmapFill(shadow, _loc_14);
                param1.drawRect(param2 + param4 + _loc_7 - _loc_21, param3 + param5 + _loc_9 - _loc_22, _loc_21, _loc_22);
                param1.endFill();
            }
            if (leftShadow)
            {
                _loc_14.tx = param2 - _loc_6;
                _loc_14.ty = 0;
                param1.beginBitmapFill(leftShadow, _loc_14);
                param1.drawRect(param2 - _loc_6, param3 - _loc_8 + _loc_16, _loc_6, param5 + _loc_8 + _loc_9 - _loc_16 - _loc_20);
                param1.endFill();
            }
            if (rightShadow)
            {
                _loc_14.tx = param2 + param4;
                _loc_14.ty = 0;
                param1.beginBitmapFill(rightShadow, _loc_14);
                param1.drawRect(param2 + param4, param3 - _loc_8 + _loc_18, _loc_7, param5 + _loc_8 + _loc_9 - _loc_18 - _loc_22);
                param1.endFill();
            }
            if (topShadow)
            {
                _loc_14.tx = 0;
                _loc_14.ty = param3 - _loc_8;
                param1.beginBitmapFill(topShadow, _loc_14);
                param1.drawRect(param2 - _loc_6 + _loc_15, param3 - _loc_8, param4 + _loc_6 + _loc_7 - _loc_15 - _loc_17, _loc_8);
                param1.endFill();
            }
            if (bottomShadow)
            {
                _loc_14.tx = 0;
                _loc_14.ty = param3 + param5;
                param1.beginBitmapFill(bottomShadow, _loc_14);
                param1.drawRect(param2 - _loc_6 + _loc_19, param3 + param5, param4 + _loc_6 + _loc_7 - _loc_19 - _loc_21, _loc_9);
                param1.endFill();
            }
            return;
        }// end function

        public function get brRadius() : Number
        {
            return _brRadius;
        }// end function

        public function get angle() : Number
        {
            return _angle;
        }// end function

        private function createShadowBitmaps() : void
        {
            var _loc_1:* = Math.max(tlRadius, blRadius) + 2 * distance + Math.max(trRadius, brRadius);
            var _loc_2:* = Math.max(tlRadius, trRadius) + 2 * distance + Math.max(blRadius, brRadius);
            if (_loc_1 < 0 || _loc_2 < 0)
            {
                return;
            }
            var _loc_3:* = new FlexShape();
            var _loc_4:* = _loc_3.graphics;
            _loc_3.graphics.beginFill(16777215);
            GraphicsUtil.drawRoundRectComplex(_loc_4, 0, 0, _loc_1, _loc_2, tlRadius, trRadius, blRadius, brRadius);
            _loc_4.endFill();
            var _loc_5:* = new BitmapData(_loc_1, _loc_2, true, 0);
            new BitmapData(_loc_1, _loc_2, true, 0).draw(_loc_3, new Matrix());
            var _loc_6:* = new DropShadowFilter(distance, angle, color, alpha);
            new DropShadowFilter(distance, angle, color, alpha).knockout = true;
            var _loc_7:* = new Rectangle(0, 0, _loc_1, _loc_2);
            var _loc_8:* = _loc_5.generateFilterRect(_loc_7, _loc_6);
            var _loc_9:* = _loc_7.left - _loc_8.left;
            var _loc_10:* = _loc_8.right - _loc_7.right;
            var _loc_11:* = _loc_7.top - _loc_8.top;
            var _loc_12:* = _loc_8.bottom - _loc_7.bottom;
            shadow = new BitmapData(_loc_8.width, _loc_8.height);
            shadow.applyFilter(_loc_5, _loc_7, new Point(_loc_9, _loc_11), _loc_6);
            var _loc_13:* = new Point(0, 0);
            var _loc_14:* = new Rectangle();
            if (_loc_9 > 0)
            {
                _loc_14.x = 0;
                _loc_14.y = tlRadius + _loc_11 + _loc_12;
                _loc_14.width = _loc_9;
                _loc_14.height = 1;
                leftShadow = new BitmapData(_loc_9, 1);
                leftShadow.copyPixels(shadow, _loc_14, _loc_13);
            }
            else
            {
                leftShadow = null;
            }
            if (_loc_10 > 0)
            {
                _loc_14.x = shadow.width - _loc_10;
                _loc_14.y = trRadius + _loc_11 + _loc_12;
                _loc_14.width = _loc_10;
                _loc_14.height = 1;
                rightShadow = new BitmapData(_loc_10, 1);
                rightShadow.copyPixels(shadow, _loc_14, _loc_13);
            }
            else
            {
                rightShadow = null;
            }
            if (_loc_11 > 0)
            {
                _loc_14.x = tlRadius + _loc_9 + _loc_10;
                _loc_14.y = 0;
                _loc_14.width = 1;
                _loc_14.height = _loc_11;
                topShadow = new BitmapData(1, _loc_11);
                topShadow.copyPixels(shadow, _loc_14, _loc_13);
            }
            else
            {
                topShadow = null;
            }
            if (_loc_12 > 0)
            {
                _loc_14.x = blRadius + _loc_9 + _loc_10;
                _loc_14.y = shadow.height - _loc_12;
                _loc_14.width = 1;
                _loc_14.height = _loc_12;
                bottomShadow = new BitmapData(1, _loc_12);
                bottomShadow.copyPixels(shadow, _loc_14, _loc_13);
            }
            else
            {
                bottomShadow = null;
            }
            return;
        }// end function

        public function get alpha() : Number
        {
            return _alpha;
        }// end function

        public function get color() : int
        {
            return _color;
        }// end function

        public function set angle(param1:Number) : void
        {
            if (_angle != param1)
            {
                _angle = param1;
                changed = true;
            }
            return;
        }// end function

        public function set trRadius(param1:Number) : void
        {
            if (_trRadius != param1)
            {
                _trRadius = param1;
                changed = true;
            }
            return;
        }// end function

        public function set tlRadius(param1:Number) : void
        {
            if (_tlRadius != param1)
            {
                _tlRadius = param1;
                changed = true;
            }
            return;
        }// end function

        public function get trRadius() : Number
        {
            return _trRadius;
        }// end function

        public function set distance(param1:Number) : void
        {
            if (_distance != param1)
            {
                _distance = param1;
                changed = true;
            }
            return;
        }// end function

        public function get distance() : Number
        {
            return _distance;
        }// end function

        public function get tlRadius() : Number
        {
            return _tlRadius;
        }// end function

        public function set alpha(param1:Number) : void
        {
            if (_alpha != param1)
            {
                _alpha = param1;
                changed = true;
            }
            return;
        }// end function

        public function set blRadius(param1:Number) : void
        {
            if (_blRadius != param1)
            {
                _blRadius = param1;
                changed = true;
            }
            return;
        }// end function

    }
}
