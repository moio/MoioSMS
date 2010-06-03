package org.papervision3d.core.math
{
    import org.papervision3d.*;

    public class Number3D extends Object
    {
        public var x:Number;
        public var y:Number;
        public var z:Number;
        public static var toDEGREES:Number = 57.2958;
        private static var temp:Number3D = this.ZERO;
        public static var toRADIANS:Number = 0.0174533;

        public function Number3D(param1:Number = 0, param2:Number = 0, param3:Number = 0)
        {
            this.x = param1;
            this.y = param2;
            this.z = param3;
            return;
        }// end function

        public function isModuloLessThan(param1:Number) : Boolean
        {
            return this.moduloSquared < param1 * param1;
        }// end function

        public function rotateX(param1:Number) : void
        {
            if (Papervision3D.useDEGREES)
            {
                param1 = param1 * toRADIANS;
            }
            var _loc_2:* = Math.cos(param1);
            var _loc_3:* = Math.sin(param1);
            temp.copyFrom(this);
            this.y = temp.y * _loc_2 - temp.z * _loc_3;
            this.z = temp.y * _loc_3 + temp.z * _loc_2;
            return;
        }// end function

        public function rotateY(param1:Number) : void
        {
            if (Papervision3D.useDEGREES)
            {
                param1 = param1 * toRADIANS;
            }
            var _loc_2:* = Math.cos(param1);
            var _loc_3:* = Math.sin(param1);
            temp.copyFrom(this);
            this.x = temp.x * _loc_2 + temp.z * _loc_3;
            this.z = temp.x * (-_loc_3) + temp.z * _loc_2;
            return;
        }// end function

        public function plusEq(param1:Number3D) : void
        {
            this.x = this.x + param1.x;
            this.y = this.y + param1.y;
            this.z = this.z + param1.z;
            return;
        }// end function

        public function multiplyEq(param1:Number) : void
        {
            this.x = this.x * param1;
            this.y = this.y * param1;
            this.z = this.z * param1;
            return;
        }// end function

        public function toString() : String
        {
            return "x:" + Math.round(this.x * 100) / 100 + " y:" + Math.round(this.y * 100) / 100 + " z:" + Math.round(this.z * 100) / 100;
        }// end function

        public function normalize() : void
        {
            var _loc_1:* = Math.sqrt(this.x * this.x + this.y * this.y + this.z * this.z);
            if (_loc_1 != 0 && _loc_1 != 1)
            {
                _loc_1 = 1 / _loc_1;
                this.x = this.x * _loc_1;
                this.y = this.y * _loc_1;
                this.z = this.z * _loc_1;
            }
            return;
        }// end function

        public function rotateZ(param1:Number) : void
        {
            if (Papervision3D.useDEGREES)
            {
                param1 = param1 * toRADIANS;
            }
            var _loc_2:* = Math.cos(param1);
            var _loc_3:* = Math.sin(param1);
            temp.copyFrom(this);
            this.x = temp.x * _loc_2 - temp.y * _loc_3;
            this.y = temp.x * _loc_3 + temp.y * _loc_2;
            return;
        }// end function

        public function reset(param1:Number = 0, param2:Number = 0, param3:Number = 0) : void
        {
            this.x = param1;
            this.y = param2;
            this.z = param3;
            return;
        }// end function

        public function get moduloSquared() : Number
        {
            return this.x * this.x + this.y * this.y + this.z * this.z;
        }// end function

        public function get modulo() : Number
        {
            return Math.sqrt(this.x * this.x + this.y * this.y + this.z * this.z);
        }// end function

        public function copyTo(param1:Number3D) : void
        {
            param1.x = this.x;
            param1.y = this.y;
            param1.z = this.z;
            return;
        }// end function

        public function isModuloGreaterThan(param1:Number) : Boolean
        {
            return this.moduloSquared > param1 * param1;
        }// end function

        public function minusEq(param1:Number3D) : void
        {
            this.x = this.x - param1.x;
            this.y = this.y - param1.y;
            this.z = this.z - param1.z;
            return;
        }// end function

        public function clone() : Number3D
        {
            return new Number3D(this.x, this.y, this.z);
        }// end function

        public function isModuloEqualTo(param1:Number) : Boolean
        {
            return this.moduloSquared == param1 * param1;
        }// end function

        public function copyFrom(param1:Number3D) : void
        {
            this.x = param1.x;
            this.y = param1.y;
            this.z = param1.z;
            return;
        }// end function

        public static function sub(param1:Number3D, param2:Number3D) : Number3D
        {
            return new Number3D(param1.x - param2.x, param1.y - param2.y, param1.z - param2.z);
        }// end function

        public static function add(param1:Number3D, param2:Number3D) : Number3D
        {
            return new Number3D(param1.x + param2.x, param1.y + param2.y, param1.z + param2.z);
        }// end function

        public static function cross(param1:Number3D, param2:Number3D, param3:Number3D = null) : Number3D
        {
            if (!param3)
            {
                param3 = ZERO;
            }
            param3.reset(param2.y * param1.z - param2.z * param1.y, param2.z * param1.x - param2.x * param1.z, param2.x * param1.y - param2.y * param1.x);
            return param3;
        }// end function

        public static function dot(param1:Number3D, param2:Number3D) : Number
        {
            return param1.x * param2.x + param1.y * param2.y + param2.z * param1.z;
        }// end function

        public static function get ZERO() : Number3D
        {
            return new Number3D(0, 0, 0);
        }// end function

    }
}
