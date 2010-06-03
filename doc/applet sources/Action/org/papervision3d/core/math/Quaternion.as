package org.papervision3d.core.math
{

    public class Quaternion extends Object
    {
        private var _matrix:Matrix3D;
        public var w:Number;
        public var x:Number;
        public var y:Number;
        public var z:Number;
        public static const EPSILON:Number = 1e-006;
        public static const DEGTORAD:Number = 0.0174533;
        public static const RADTODEG:Number = 57.2958;

        public function Quaternion(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 1)
        {
            this.x = param1;
            this.y = param2;
            this.z = param3;
            this.w = param4;
            this._matrix = Matrix3D.IDENTITY;
            return;
        }// end function

        public function get matrix() : Matrix3D
        {
            var _loc_1:* = this.x * this.x;
            var _loc_2:* = this.x * this.y;
            var _loc_3:* = this.x * this.z;
            var _loc_4:* = this.x * this.w;
            var _loc_5:* = this.y * this.y;
            var _loc_6:* = this.y * this.z;
            var _loc_7:* = this.y * this.w;
            var _loc_8:* = this.z * this.z;
            var _loc_9:* = this.z * this.w;
            this._matrix.n11 = 1 - 2 * (_loc_5 + _loc_8);
            this._matrix.n12 = 2 * (_loc_2 - _loc_9);
            this._matrix.n13 = 2 * (_loc_3 + _loc_7);
            this._matrix.n21 = 2 * (_loc_2 + _loc_9);
            this._matrix.n22 = 1 - 2 * (_loc_1 + _loc_8);
            this._matrix.n23 = 2 * (_loc_6 - _loc_4);
            this._matrix.n31 = 2 * (_loc_3 - _loc_7);
            this._matrix.n32 = 2 * (_loc_6 + _loc_4);
            this._matrix.n33 = 1 - 2 * (_loc_1 + _loc_5);
            return this._matrix;
        }// end function

        public function setFromEuler(param1:Number, param2:Number, param3:Number, param4:Boolean = false) : void
        {
            if (param4)
            {
                param1 = param1 * DEGTORAD;
                param2 = param2 * DEGTORAD;
                param3 = param3 * DEGTORAD;
            }
            var _loc_5:* = Math.sin(param1 * 0.5);
            var _loc_6:* = Math.cos(param1 * 0.5);
            var _loc_7:* = Math.sin(param2 * 0.5);
            var _loc_8:* = Math.cos(param2 * 0.5);
            var _loc_9:* = Math.sin(param3 * 0.5);
            var _loc_10:* = Math.cos(param3 * 0.5);
            var _loc_11:* = _loc_6 * _loc_8;
            var _loc_12:* = _loc_5 * _loc_7;
            this.x = _loc_9 * _loc_11 - _loc_10 * _loc_12;
            this.y = _loc_10 * _loc_5 * _loc_8 + _loc_9 * _loc_6 * _loc_7;
            this.z = _loc_10 * _loc_6 * _loc_7 - _loc_9 * _loc_5 * _loc_8;
            this.w = _loc_10 * _loc_11 + _loc_9 * _loc_12;
            return;
        }// end function

        public function setFromAxisAngle(param1:Number, param2:Number, param3:Number, param4:Number) : void
        {
            var _loc_5:* = Math.sin(param4 / 2);
            var _loc_6:* = Math.cos(param4 / 2);
            this.x = param1 * _loc_5;
            this.y = param2 * _loc_5;
            this.z = param3 * _loc_5;
            this.w = _loc_6;
            this.normalize();
            return;
        }// end function

        public function calculateMultiply(param1:Quaternion, param2:Quaternion) : void
        {
            this.x = param1.w * param2.x + param1.x * param2.w + param1.y * param2.z - param1.z * param2.y;
            this.y = param1.w * param2.y - param1.x * param2.z + param1.y * param2.w + param1.z * param2.x;
            this.z = param1.w * param2.z + param1.x * param2.y - param1.y * param2.x + param1.z * param2.w;
            this.w = param1.w * param2.w - param1.x * param2.x - param1.y * param2.y - param1.z * param2.z;
            return;
        }// end function

        public function toString() : String
        {
            return "Quaternion: x:" + this.x + " y:" + this.y + " z:" + this.z + " w:" + this.w;
        }// end function

        public function normalize() : void
        {
            var _loc_2:Number = NaN;
            var _loc_1:* = this.modulo;
            if (Math.abs(_loc_1) < EPSILON)
            {
                var _loc_3:Number = 0;
                this.z = 0;
                var _loc_3:* = _loc_3;
                this.y = _loc_3;
                this.x = _loc_3;
                this.w = 1;
            }
            else
            {
                _loc_2 = 1 / _loc_1;
                this.x = this.x * _loc_2;
                this.y = this.y * _loc_2;
                this.z = this.z * _loc_2;
                this.w = this.w * _loc_2;
            }
            return;
        }// end function

        public function toEuler() : Number3D
        {
            var _loc_1:* = new Number3D();
            var _loc_2:Quaternion = this;
            var _loc_3:* = _loc_2.x * _loc_2.y + _loc_2.z * _loc_2.w;
            if (_loc_3 > 0.499)
            {
                _loc_1.x = 2 * Math.atan2(_loc_2.x, _loc_2.w);
                _loc_1.y = Math.PI / 2;
                _loc_1.z = 0;
                return _loc_1;
            }
            if (_loc_3 < -0.499)
            {
                _loc_1.x = -2 * Math.atan2(_loc_2.x, _loc_2.w);
                _loc_1.y = (-Math.PI) / 2;
                _loc_1.z = 0;
                return _loc_1;
            }
            var _loc_4:* = _loc_2.x * _loc_2.x;
            var _loc_5:* = _loc_2.y * _loc_2.y;
            var _loc_6:* = _loc_2.z * _loc_2.z;
            _loc_1.x = Math.atan2(2 * _loc_2.y * _loc_2.w - 2 * _loc_2.x * _loc_2.z, 1 - 2 * _loc_5 - 2 * _loc_6);
            _loc_1.y = Math.asin(2 * _loc_3);
            _loc_1.z = Math.atan2(2 * _loc_2.x * _loc_2.w - 2 * _loc_2.y * _loc_2.z, 1 - 2 * _loc_4 - 2 * _loc_6);
            return _loc_1;
        }// end function

        public function get modulo() : Number
        {
            return Math.sqrt(this.x * this.x + this.y * this.y + this.z * this.z + this.w * this.w);
        }// end function

        public function clone() : Quaternion
        {
            return new Quaternion(this.x, this.y, this.z, this.w);
        }// end function

        public function mult(param1:Quaternion) : void
        {
            var _loc_2:* = this.w;
            var _loc_3:* = this.x;
            var _loc_4:* = this.y;
            var _loc_5:* = this.z;
            this.x = _loc_2 * param1.x + _loc_3 * param1.w + _loc_4 * param1.z - _loc_5 * param1.y;
            this.y = _loc_2 * param1.y - _loc_3 * param1.z + _loc_4 * param1.w + _loc_5 * param1.x;
            this.z = _loc_2 * param1.z + _loc_3 * param1.y - _loc_4 * param1.x + _loc_5 * param1.w;
            this.w = _loc_2 * param1.w - _loc_3 * param1.x - _loc_4 * param1.y - _loc_5 * param1.z;
            return;
        }// end function

        public static function sub(param1:Quaternion, param2:Quaternion) : Quaternion
        {
            return new Quaternion(param1.x - param2.x, param1.y - param2.y, param1.z - param2.z, param1.w - param2.w);
        }// end function

        public static function add(param1:Quaternion, param2:Quaternion) : Quaternion
        {
            return new Quaternion(param1.x + param2.x, param1.y + param2.y, param1.z + param2.z, param1.w + param2.w);
        }// end function

        public static function createFromEuler(param1:Number, param2:Number, param3:Number, param4:Boolean = false) : Quaternion
        {
            if (param4)
            {
                param1 = param1 * DEGTORAD;
                param2 = param2 * DEGTORAD;
                param3 = param3 * DEGTORAD;
            }
            var _loc_5:* = Math.sin(param1 * 0.5);
            var _loc_6:* = Math.cos(param1 * 0.5);
            var _loc_7:* = Math.sin(param2 * 0.5);
            var _loc_8:* = Math.cos(param2 * 0.5);
            var _loc_9:* = Math.sin(param3 * 0.5);
            var _loc_10:* = Math.cos(param3 * 0.5);
            var _loc_11:* = _loc_6 * _loc_8;
            var _loc_12:* = _loc_5 * _loc_7;
            var _loc_13:* = new Quaternion;
            new Quaternion.x = _loc_9 * _loc_11 - _loc_10 * _loc_12;
            _loc_13.y = _loc_10 * _loc_5 * _loc_8 + _loc_9 * _loc_6 * _loc_7;
            _loc_13.z = _loc_10 * _loc_6 * _loc_7 - _loc_9 * _loc_5 * _loc_8;
            _loc_13.w = _loc_10 * _loc_11 + _loc_9 * _loc_12;
            return _loc_13;
        }// end function

        public static function createFromMatrix(param1:Matrix3D) : Quaternion
        {
            var _loc_3:Number = NaN;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_9:Array = null;
            var _loc_10:Array = null;
            var _loc_2:* = new Quaternion;
            var _loc_4:* = new Array(4);
            var _loc_8:* = param1.n11 + param1.n22 + param1.n33;
            if (param1.n11 + param1.n22 + param1.n33 > 0)
            {
                _loc_3 = Math.sqrt(_loc_8 + 1);
                _loc_2.w = _loc_3 / 2;
                _loc_3 = 0.5 / _loc_3;
                _loc_2.x = (param1.n32 - param1.n23) * _loc_3;
                _loc_2.y = (param1.n13 - param1.n31) * _loc_3;
                _loc_2.z = (param1.n21 - param1.n12) * _loc_3;
            }
            else
            {
                _loc_9 = [1, 2, 0];
                _loc_10 = [[param1.n11, param1.n12, param1.n13, param1.n14], [param1.n21, param1.n22, param1.n23, param1.n24], [param1.n31, param1.n32, param1.n33, param1.n34]];
                _loc_5 = 0;
                if (_loc_10[1][1] > _loc_10[0][0])
                {
                    _loc_5 = 1;
                }
                if (_loc_10[2][2] > _loc_10[_loc_5][_loc_5])
                {
                    _loc_5 = 2;
                }
                _loc_6 = _loc_9[_loc_5];
                _loc_7 = _loc_9[_loc_6];
                _loc_3 = Math.sqrt(_loc_10[_loc_5][_loc_5] - (_loc_10[_loc_6][_loc_6] + _loc_10[_loc_7][_loc_7]) + 1);
                _loc_4[_loc_5] = _loc_3 * 0.5;
                if (_loc_3 != 0)
                {
                    _loc_3 = 0.5 / _loc_3;
                }
                _loc_4[3] = (_loc_10[_loc_7][_loc_6] - _loc_10[_loc_6][_loc_7]) * _loc_3;
                _loc_4[_loc_6] = (_loc_10[_loc_6][_loc_5] + _loc_10[_loc_5][_loc_6]) * _loc_3;
                _loc_4[_loc_7] = (_loc_10[_loc_7][_loc_5] + _loc_10[_loc_5][_loc_7]) * _loc_3;
                _loc_2.x = _loc_4[0];
                _loc_2.y = _loc_4[1];
                _loc_2.z = _loc_4[2];
                _loc_2.w = _loc_4[3];
            }
            return _loc_2;
        }// end function

        public static function dot(param1:Quaternion, param2:Quaternion) : Number
        {
            return param1.x * param2.x + param1.y * param2.y + param1.z * param2.z + param1.w * param2.w;
        }// end function

        public static function multiply(param1:Quaternion, param2:Quaternion) : Quaternion
        {
            var _loc_3:* = new Quaternion;
            _loc_3.x = param1.w * param2.x + param1.x * param2.w + param1.y * param2.z - param1.z * param2.y;
            _loc_3.y = param1.w * param2.y - param1.x * param2.z + param1.y * param2.w + param1.z * param2.x;
            _loc_3.z = param1.w * param2.z + param1.x * param2.y - param1.y * param2.x + param1.z * param2.w;
            _loc_3.w = param1.w * param2.w - param1.x * param2.x - param1.y * param2.y - param1.z * param2.z;
            return _loc_3;
        }// end function

        public static function createFromAxisAngle(param1:Number, param2:Number, param3:Number, param4:Number) : Quaternion
        {
            var _loc_5:* = new Quaternion;
            new Quaternion.setFromAxisAngle(param1, param2, param3, param4);
            return _loc_5;
        }// end function

        public static function slerp(param1:Quaternion, param2:Quaternion, param3:Number) : Quaternion
        {
            var _loc_5:Number = NaN;
            var _loc_6:Number = NaN;
            var _loc_7:Number = NaN;
            var _loc_8:Number = NaN;
            var _loc_4:* = param1.w * param2.w + param1.x * param2.x + param1.y * param2.y + param1.z * param2.z;
            if (param1.w * param2.w + param1.x * param2.x + param1.y * param2.y + param1.z * param2.z < 0)
            {
                param1.x = param1.x * -1;
                param1.y = param1.y * -1;
                param1.z = param1.z * -1;
                param1.w = param1.w * -1;
                _loc_4 = _loc_4 * -1;
            }
            if (_loc_4 + 1 > EPSILON)
            {
                if (1 - _loc_4 >= EPSILON)
                {
                    _loc_7 = Math.acos(_loc_4);
                    _loc_8 = 1 / Math.sin(_loc_7);
                    _loc_5 = Math.sin(_loc_7 * (1 - param3)) * _loc_8;
                    _loc_6 = Math.sin(_loc_7 * param3) * _loc_8;
                }
                else
                {
                    _loc_5 = 1 - param3;
                    _loc_6 = param3;
                }
            }
            else
            {
                param2.y = -param1.y;
                param2.x = param1.x;
                param2.w = -param1.w;
                param2.z = param1.z;
                _loc_5 = Math.sin(Math.PI * (0.5 - param3));
                _loc_6 = Math.sin(Math.PI * param3);
            }
            return new Quaternion(_loc_5 * param1.x + _loc_6 * param2.x, _loc_5 * param1.y + _loc_6 * param2.y, _loc_5 * param1.z + _loc_6 * param2.z, _loc_5 * param1.w + _loc_6 * param2.w);
        }// end function

        public static function createFromOrthoMatrix(param1:Matrix3D) : Quaternion
        {
            var _loc_2:* = new Quaternion;
            _loc_2.w = Math.sqrt(Math.max(0, 1 + param1.n11 + param1.n22 + param1.n33)) / 2;
            _loc_2.x = Math.sqrt(Math.max(0, 1 + param1.n11 - param1.n22 - param1.n33)) / 2;
            _loc_2.y = Math.sqrt(Math.max(0, 1 - param1.n11 + param1.n22 - param1.n33)) / 2;
            _loc_2.z = Math.sqrt(Math.max(0, 1 - param1.n11 - param1.n22 + param1.n33)) / 2;
            _loc_2.x = param1.n32 - param1.n23 < 0 ? (_loc_2.x < 0 ? (_loc_2.x) : (-_loc_2.x)) : (_loc_2.x < 0 ? (-_loc_2.x) : (_loc_2.x));
            _loc_2.y = param1.n13 - param1.n31 < 0 ? (_loc_2.y < 0 ? (_loc_2.y) : (-_loc_2.y)) : (_loc_2.y < 0 ? (-_loc_2.y) : (_loc_2.y));
            _loc_2.z = param1.n21 - param1.n12 < 0 ? (_loc_2.z < 0 ? (_loc_2.z) : (-_loc_2.z)) : (_loc_2.z < 0 ? (-_loc_2.z) : (_loc_2.z));
            return _loc_2;
        }// end function

        public static function conjugate(param1:Quaternion) : Quaternion
        {
            var _loc_2:* = new Quaternion;
            _loc_2.x = -param1.x;
            _loc_2.y = -param1.y;
            _loc_2.z = -param1.z;
            _loc_2.w = param1.w;
            return _loc_2;
        }// end function

        public static function slerpOld(param1:Quaternion, param2:Quaternion, param3:Number) : Quaternion
        {
            var _loc_4:* = new Quaternion;
            var _loc_5:* = param1.w * param2.w + param1.x * param2.x + param1.y * param2.y + param1.z * param2.z;
            if (Math.abs(_loc_5) >= 1)
            {
                _loc_4.w = param1.w;
                _loc_4.x = param1.x;
                _loc_4.y = param1.y;
                _loc_4.z = param1.z;
                return _loc_4;
            }
            var _loc_6:* = Math.acos(_loc_5);
            var _loc_7:* = Math.sqrt(1 - _loc_5 * _loc_5);
            if (Math.abs(_loc_7) < 0.001)
            {
                _loc_4.w = param1.w * 0.5 + param2.w * 0.5;
                _loc_4.x = param1.x * 0.5 + param2.x * 0.5;
                _loc_4.y = param1.y * 0.5 + param2.y * 0.5;
                _loc_4.z = param1.z * 0.5 + param2.z * 0.5;
                return _loc_4;
            }
            var _loc_8:* = Math.sin((1 - param3) * _loc_6) / _loc_7;
            var _loc_9:* = Math.sin(param3 * _loc_6) / _loc_7;
            _loc_4.w = param1.w * _loc_8 + param2.w * _loc_9;
            _loc_4.x = param1.x * _loc_8 + param2.x * _loc_9;
            _loc_4.y = param1.y * _loc_8 + param2.y * _loc_9;
            _loc_4.z = param1.z * _loc_8 + param2.z * _loc_9;
            return _loc_4;
        }// end function

    }
}
