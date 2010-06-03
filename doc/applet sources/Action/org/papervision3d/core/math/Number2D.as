package org.papervision3d.core.math
{
    import org.papervision3d.*;

    public class Number2D extends Object
    {
        public var x:Number;
        public var y:Number;
        public static const DEGTORAD:Number = 0.0174533;
        public static const RADTODEG:Number = 57.2958;

        public function Number2D(param1:Number = 0, param2:Number = 0)
        {
            this.x = param1;
            this.y = param2;
            return;
        }// end function

        public function isModuloLessThan(param1:Number) : Boolean
        {
            return this.moduloSquared < param1 * param1;
        }// end function

        public function reverse() : void
        {
            this.x = -this.x;
            this.y = -this.y;
            return;
        }// end function

        public function divideEq(param1:Number) : void
        {
            this.x = this.x / param1;
            this.y = this.y / param1;
            return;
        }// end function

        public function plusEq(param1:Number2D) : void
        {
            this.x = this.x + param1.x;
            this.y = this.y + param1.y;
            return;
        }// end function

        public function multiplyEq(param1:Number) : void
        {
            this.x = this.x * param1;
            this.y = this.y * param1;
            return;
        }// end function

        public function isModuloGreaterThan(param1:Number) : Boolean
        {
            return this.moduloSquared > param1 * param1;
        }// end function

        public function toString() : String
        {
            var _loc_1:* = Math.round(this.x * 1000) / 1000;
            var _loc_2:* = Math.round(this.y * 1000) / 1000;
            return "[" + _loc_1 + ", " + _loc_2 + "]";
        }// end function

        public function reset(param1:Number = 0, param2:Number = 0) : void
        {
            this.x = param1;
            this.y = param2;
            return;
        }// end function

        public function get moduloSquared() : Number
        {
            return this.x * this.x + this.y * this.y;
        }// end function

        public function normalise() : void
        {
            var _loc_1:* = this.modulo;
            this.x = this.x / _loc_1;
            this.y = this.y / _loc_1;
            return;
        }// end function

        public function get modulo() : Number
        {
            return Math.sqrt(this.x * this.x + this.y * this.y);
        }// end function

        public function copyTo(param1:Number2D) : void
        {
            param1.x = this.x;
            param1.y = this.y;
            return;
        }// end function

        public function angle() : Number
        {
            if (Papervision3D.useDEGREES)
            {
                return RADTODEG * Math.atan2(this.y, this.x);
            }
            return Math.atan2(this.y, this.x);
        }// end function

        public function rotate(param1:Number) : void
        {
            var _loc_4:Number2D = null;
            if (Papervision3D.useDEGREES)
            {
                param1 = param1 * DEGTORAD;
            }
            var _loc_2:* = Math.cos(param1);
            var _loc_3:* = Math.sin(param1);
            _loc_4 = this.clone();
            this.x = _loc_4.x * _loc_2 - _loc_4.y * _loc_3;
            this.y = _loc_4.x * _loc_3 + _loc_4.y * _loc_2;
            return;
        }// end function

        public function minusEq(param1:Number2D) : void
        {
            this.x = this.x - param1.x;
            this.y = this.y - param1.y;
            return;
        }// end function

        public function clone() : Number2D
        {
            return new Number2D(this.x, this.y);
        }// end function

        public function isModuloEqualTo(param1:Number) : Boolean
        {
            return this.moduloSquared == param1 * param1;
        }// end function

        public function copyFrom(param1:Number2D) : void
        {
            this.x = param1.x;
            this.y = param1.y;
            return;
        }// end function

        public static function multiplyScalar(param1:Number2D, param2:Number) : Number2D
        {
            return new Number2D(param1.x * param2, param1.y * param2);
        }// end function

        public static function add(param1:Number2D, param2:Number2D) : Number2D
        {
            var _loc_3:* = param1.x + param2.x;
            param1.x = param1.x + param2.x;
            return new Number2D(_loc_3, param1.y + param2.y);
        }// end function

        public static function dot(param1:Number2D, param2:Number2D) : Number
        {
            return param1.x * param2.x + param1.y * param2.y;
        }// end function

        public static function subtract(param1:Number2D, param2:Number2D) : Number2D
        {
            return new Number2D(param1.x - param2.x, param1.y - param2.y);
        }// end function

    }
}
