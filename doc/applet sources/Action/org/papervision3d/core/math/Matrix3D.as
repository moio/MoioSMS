package org.papervision3d.core.math
{
    import org.papervision3d.*;

    public class Matrix3D extends Object
    {
        public var n31:Number;
        public var n32:Number;
        public var n11:Number;
        public var n34:Number;
        public var n13:Number;
        public var n14:Number;
        public var n33:Number;
        public var n12:Number;
        public var n41:Number;
        public var n42:Number;
        public var n21:Number;
        public var n22:Number;
        public var n23:Number;
        public var n24:Number;
        public var n44:Number;
        public var n43:Number;
        private static var _cos:Function = Math.cos;
        private static var _sin:Function = Math.sin;
        private static var temp:Matrix3D = this.IDENTITY;
        private static var n3Di:Number3D = Number3D.ZERO;
        private static var n3Dj:Number3D = Number3D.ZERO;
        private static var n3Dk:Number3D = Number3D.ZERO;
        private static var toDEGREES:Number = 57.2958;
        private static var toRADIANS:Number = 0.0174533;

        public function Matrix3D(param1:Array = null)
        {
            this.reset(param1);
            return;
        }// end function

        public function calculateMultiply3x3(param1:Matrix3D, param2:Matrix3D) : void
        {
            var _loc_3:* = param1.n11;
            var _loc_4:* = param2.n11;
            var _loc_5:* = param1.n21;
            var _loc_6:* = param2.n21;
            var _loc_7:* = param1.n31;
            var _loc_8:* = param2.n31;
            var _loc_9:* = param1.n12;
            var _loc_10:* = param2.n12;
            var _loc_11:* = param1.n22;
            var _loc_12:* = param2.n22;
            var _loc_13:* = param1.n32;
            var _loc_14:* = param2.n32;
            var _loc_15:* = param1.n13;
            var _loc_16:* = param2.n13;
            var _loc_17:* = param1.n23;
            var _loc_18:* = param2.n23;
            var _loc_19:* = param1.n33;
            var _loc_20:* = param2.n33;
            this.n11 = _loc_3 * _loc_4 + _loc_9 * _loc_6 + _loc_15 * _loc_8;
            this.n12 = _loc_3 * _loc_10 + _loc_9 * _loc_12 + _loc_15 * _loc_14;
            this.n13 = _loc_3 * _loc_16 + _loc_9 * _loc_18 + _loc_15 * _loc_20;
            this.n21 = _loc_5 * _loc_4 + _loc_11 * _loc_6 + _loc_17 * _loc_8;
            this.n22 = _loc_5 * _loc_10 + _loc_11 * _loc_12 + _loc_17 * _loc_14;
            this.n23 = _loc_5 * _loc_16 + _loc_11 * _loc_18 + _loc_17 * _loc_20;
            this.n31 = _loc_7 * _loc_4 + _loc_13 * _loc_6 + _loc_19 * _loc_8;
            this.n32 = _loc_7 * _loc_10 + _loc_13 * _loc_12 + _loc_19 * _loc_14;
            this.n33 = _loc_7 * _loc_16 + _loc_13 * _loc_18 + _loc_19 * _loc_20;
            return;
        }// end function

        public function calculateMultiply4x4(param1:Matrix3D, param2:Matrix3D) : void
        {
            var _loc_3:* = param1.n11;
            var _loc_4:* = param2.n11;
            var _loc_5:* = param1.n21;
            var _loc_6:* = param2.n21;
            var _loc_7:* = param1.n31;
            var _loc_8:* = param2.n31;
            var _loc_9:* = param1.n41;
            var _loc_10:* = param2.n41;
            var _loc_11:* = param1.n12;
            var _loc_12:* = param2.n12;
            var _loc_13:* = param1.n22;
            var _loc_14:* = param2.n22;
            var _loc_15:* = param1.n32;
            var _loc_16:* = param2.n32;
            var _loc_17:* = param1.n42;
            var _loc_18:* = param2.n42;
            var _loc_19:* = param1.n13;
            var _loc_20:* = param2.n13;
            var _loc_21:* = param1.n23;
            var _loc_22:* = param2.n23;
            var _loc_23:* = param1.n33;
            var _loc_24:* = param2.n33;
            var _loc_25:* = param1.n43;
            var _loc_26:* = param2.n43;
            var _loc_27:* = param1.n14;
            var _loc_28:* = param2.n14;
            var _loc_29:* = param1.n24;
            var _loc_30:* = param2.n24;
            var _loc_31:* = param1.n34;
            var _loc_32:* = param2.n34;
            var _loc_33:* = param1.n44;
            var _loc_34:* = param2.n44;
            this.n11 = _loc_3 * _loc_4 + _loc_11 * _loc_6 + _loc_19 * _loc_8;
            this.n12 = _loc_3 * _loc_12 + _loc_11 * _loc_14 + _loc_19 * _loc_16;
            this.n13 = _loc_3 * _loc_20 + _loc_11 * _loc_22 + _loc_19 * _loc_24;
            this.n14 = _loc_3 * _loc_28 + _loc_11 * _loc_30 + _loc_19 * _loc_32 + _loc_27;
            this.n21 = _loc_5 * _loc_4 + _loc_13 * _loc_6 + _loc_21 * _loc_8;
            this.n22 = _loc_5 * _loc_12 + _loc_13 * _loc_14 + _loc_21 * _loc_16;
            this.n23 = _loc_5 * _loc_20 + _loc_13 * _loc_22 + _loc_21 * _loc_24;
            this.n24 = _loc_5 * _loc_28 + _loc_13 * _loc_30 + _loc_21 * _loc_32 + _loc_29;
            this.n31 = _loc_7 * _loc_4 + _loc_15 * _loc_6 + _loc_23 * _loc_8;
            this.n32 = _loc_7 * _loc_12 + _loc_15 * _loc_14 + _loc_23 * _loc_16;
            this.n33 = _loc_7 * _loc_20 + _loc_15 * _loc_22 + _loc_23 * _loc_24;
            this.n34 = _loc_7 * _loc_28 + _loc_15 * _loc_30 + _loc_23 * _loc_32 + _loc_31;
            this.n41 = _loc_9 * _loc_4 + _loc_17 * _loc_6 + _loc_25 * _loc_8;
            this.n42 = _loc_9 * _loc_12 + _loc_17 * _loc_14 + _loc_25 * _loc_16;
            this.n43 = _loc_9 * _loc_20 + _loc_17 * _loc_22 + _loc_25 * _loc_24;
            this.n44 = _loc_9 * _loc_28 + _loc_17 * _loc_30 + _loc_25 * _loc_32 + _loc_33;
            return;
        }// end function

        public function get det() : Number
        {
            return (this.n11 * this.n22 - this.n21 * this.n12) * this.n33 - (this.n11 * this.n32 - this.n31 * this.n12) * this.n23 + (this.n21 * this.n32 - this.n31 * this.n22) * this.n13;
        }// end function

        public function copy(param1:Matrix3D) : Matrix3D
        {
            this.n11 = param1.n11;
            this.n12 = param1.n12;
            this.n13 = param1.n13;
            this.n14 = param1.n14;
            this.n21 = param1.n21;
            this.n22 = param1.n22;
            this.n23 = param1.n23;
            this.n24 = param1.n24;
            this.n31 = param1.n31;
            this.n32 = param1.n32;
            this.n33 = param1.n33;
            this.n34 = param1.n34;
            return this;
        }// end function

        public function copy3x3(param1:Matrix3D) : Matrix3D
        {
            this.n11 = param1.n11;
            this.n12 = param1.n12;
            this.n13 = param1.n13;
            this.n21 = param1.n21;
            this.n22 = param1.n22;
            this.n23 = param1.n23;
            this.n31 = param1.n31;
            this.n32 = param1.n32;
            this.n33 = param1.n33;
            return this;
        }// end function

        public function calculateAdd(param1:Matrix3D, param2:Matrix3D) : void
        {
            this.n11 = param1.n11 + param2.n11;
            this.n12 = param1.n12 + param2.n12;
            this.n13 = param1.n13 + param2.n13;
            this.n14 = param1.n14 + param2.n14;
            this.n21 = param1.n21 + param2.n21;
            this.n22 = param1.n22 + param2.n22;
            this.n23 = param1.n23 + param2.n23;
            this.n24 = param1.n24 + param2.n24;
            this.n31 = param1.n31 + param2.n31;
            this.n32 = param1.n32 + param2.n32;
            this.n33 = param1.n33 + param2.n33;
            this.n34 = param1.n34 + param2.n34;
            return;
        }// end function

        public function calculateMultiply(param1:Matrix3D, param2:Matrix3D) : void
        {
            var _loc_3:* = param1.n11;
            var _loc_4:* = param2.n11;
            var _loc_5:* = param1.n21;
            var _loc_6:* = param2.n21;
            var _loc_7:* = param1.n31;
            var _loc_8:* = param2.n31;
            var _loc_9:* = param1.n12;
            var _loc_10:* = param2.n12;
            var _loc_11:* = param1.n22;
            var _loc_12:* = param2.n22;
            var _loc_13:* = param1.n32;
            var _loc_14:* = param2.n32;
            var _loc_15:* = param1.n13;
            var _loc_16:* = param2.n13;
            var _loc_17:* = param1.n23;
            var _loc_18:* = param2.n23;
            var _loc_19:* = param1.n33;
            var _loc_20:* = param2.n33;
            var _loc_21:* = param1.n14;
            var _loc_22:* = param2.n14;
            var _loc_23:* = param1.n24;
            var _loc_24:* = param2.n24;
            var _loc_25:* = param1.n34;
            var _loc_26:* = param2.n34;
            this.n11 = _loc_3 * _loc_4 + _loc_9 * _loc_6 + _loc_15 * _loc_8;
            this.n12 = _loc_3 * _loc_10 + _loc_9 * _loc_12 + _loc_15 * _loc_14;
            this.n13 = _loc_3 * _loc_16 + _loc_9 * _loc_18 + _loc_15 * _loc_20;
            this.n14 = _loc_3 * _loc_22 + _loc_9 * _loc_24 + _loc_15 * _loc_26 + _loc_21;
            this.n21 = _loc_5 * _loc_4 + _loc_11 * _loc_6 + _loc_17 * _loc_8;
            this.n22 = _loc_5 * _loc_10 + _loc_11 * _loc_12 + _loc_17 * _loc_14;
            this.n23 = _loc_5 * _loc_16 + _loc_11 * _loc_18 + _loc_17 * _loc_20;
            this.n24 = _loc_5 * _loc_22 + _loc_11 * _loc_24 + _loc_17 * _loc_26 + _loc_23;
            this.n31 = _loc_7 * _loc_4 + _loc_13 * _loc_6 + _loc_19 * _loc_8;
            this.n32 = _loc_7 * _loc_10 + _loc_13 * _loc_12 + _loc_19 * _loc_14;
            this.n33 = _loc_7 * _loc_16 + _loc_13 * _loc_18 + _loc_19 * _loc_20;
            this.n34 = _loc_7 * _loc_22 + _loc_13 * _loc_24 + _loc_19 * _loc_26 + _loc_25;
            return;
        }// end function

        public function reset(param1:Array = null) : void
        {
            if (!param1 || param1.length < 12)
            {
                var _loc_2:int = 1;
                this.n44 = 1;
                var _loc_2:* = _loc_2;
                this.n33 = _loc_2;
                var _loc_2:* = _loc_2;
                this.n22 = _loc_2;
                this.n11 = _loc_2;
                var _loc_2:int = 0;
                this.n43 = 0;
                var _loc_2:* = _loc_2;
                this.n42 = _loc_2;
                var _loc_2:* = _loc_2;
                this.n41 = _loc_2;
                var _loc_2:* = _loc_2;
                this.n34 = _loc_2;
                var _loc_2:* = _loc_2;
                this.n32 = _loc_2;
                var _loc_2:* = _loc_2;
                this.n31 = _loc_2;
                var _loc_2:* = _loc_2;
                this.n24 = _loc_2;
                var _loc_2:* = _loc_2;
                this.n23 = _loc_2;
                var _loc_2:* = _loc_2;
                this.n21 = _loc_2;
                var _loc_2:* = _loc_2;
                this.n14 = _loc_2;
                var _loc_2:* = _loc_2;
                this.n13 = _loc_2;
                this.n12 = _loc_2;
            }
            else
            {
                this.n11 = param1[0];
                this.n12 = param1[1];
                this.n13 = param1[2];
                this.n14 = param1[3];
                this.n21 = param1[4];
                this.n22 = param1[5];
                this.n23 = param1[6];
                this.n24 = param1[7];
                this.n31 = param1[8];
                this.n32 = param1[9];
                this.n33 = param1[10];
                this.n34 = param1[11];
                if (param1.length == 16)
                {
                    this.n41 = param1[12];
                    this.n42 = param1[13];
                    this.n43 = param1[14];
                    this.n44 = param1[15];
                }
                else
                {
                    var _loc_2:int = 0;
                    this.n43 = 0;
                    var _loc_2:* = _loc_2;
                    this.n42 = _loc_2;
                    this.n41 = _loc_2;
                    this.n44 = 1;
                }
            }
            return;
        }// end function

        public function invert() : void
        {
            temp.copy(this);
            this.calculateInverse(temp);
            return;
        }// end function

        public function calculateInverse(param1:Matrix3D) : void
        {
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_6:Number = NaN;
            var _loc_7:Number = NaN;
            var _loc_8:Number = NaN;
            var _loc_9:Number = NaN;
            var _loc_10:Number = NaN;
            var _loc_11:Number = NaN;
            var _loc_12:Number = NaN;
            var _loc_13:Number = NaN;
            var _loc_14:Number = NaN;
            var _loc_2:* = param1.det;
            if (Math.abs(_loc_2) > 0.001)
            {
                _loc_2 = 1 / _loc_2;
                _loc_3 = param1.n11;
                _loc_4 = param1.n21;
                _loc_5 = param1.n31;
                _loc_6 = param1.n12;
                _loc_7 = param1.n22;
                _loc_8 = param1.n32;
                _loc_9 = param1.n13;
                _loc_10 = param1.n23;
                _loc_11 = param1.n33;
                _loc_12 = param1.n14;
                _loc_13 = param1.n24;
                _loc_14 = param1.n34;
                this.n11 = _loc_2 * (_loc_7 * _loc_11 - _loc_8 * _loc_10);
                this.n12 = (-_loc_2) * (_loc_6 * _loc_11 - _loc_8 * _loc_9);
                this.n13 = _loc_2 * (_loc_6 * _loc_10 - _loc_7 * _loc_9);
                this.n14 = (-_loc_2) * (_loc_6 * (_loc_10 * _loc_14 - _loc_11 * _loc_13) - _loc_7 * (_loc_9 * _loc_14 - _loc_11 * _loc_12) + _loc_8 * (_loc_9 * _loc_13 - _loc_10 * _loc_12));
                this.n21 = (-_loc_2) * (_loc_4 * _loc_11 - _loc_5 * _loc_10);
                this.n22 = _loc_2 * (_loc_3 * _loc_11 - _loc_5 * _loc_9);
                this.n23 = (-_loc_2) * (_loc_3 * _loc_10 - _loc_4 * _loc_9);
                this.n24 = _loc_2 * (_loc_3 * (_loc_10 * _loc_14 - _loc_11 * _loc_13) - _loc_4 * (_loc_9 * _loc_14 - _loc_11 * _loc_12) + _loc_5 * (_loc_9 * _loc_13 - _loc_10 * _loc_12));
                this.n31 = _loc_2 * (_loc_4 * _loc_8 - _loc_5 * _loc_7);
                this.n32 = (-_loc_2) * (_loc_3 * _loc_8 - _loc_5 * _loc_6);
                this.n33 = _loc_2 * (_loc_3 * _loc_7 - _loc_4 * _loc_6);
                this.n34 = (-_loc_2) * (_loc_3 * (_loc_7 * _loc_14 - _loc_8 * _loc_13) - _loc_4 * (_loc_6 * _loc_14 - _loc_8 * _loc_12) + _loc_5 * (_loc_6 * _loc_13 - _loc_7 * _loc_12));
            }
            return;
        }// end function

        public function calculateTranspose() : void
        {
            var _loc_1:* = this.n11;
            var _loc_2:* = this.n21;
            var _loc_3:* = this.n31;
            var _loc_4:* = this.n41;
            var _loc_5:* = this.n12;
            var _loc_6:* = this.n22;
            var _loc_7:* = this.n32;
            var _loc_8:* = this.n42;
            var _loc_9:* = this.n13;
            var _loc_10:* = this.n23;
            var _loc_11:* = this.n33;
            var _loc_12:* = this.n43;
            var _loc_13:* = this.n14;
            var _loc_14:* = this.n24;
            var _loc_15:* = this.n34;
            var _loc_16:* = this.n44;
            this.n11 = _loc_1;
            this.n12 = _loc_2;
            this.n13 = _loc_3;
            this.n14 = _loc_4;
            this.n21 = _loc_5;
            this.n22 = _loc_6;
            this.n23 = _loc_7;
            this.n24 = _loc_8;
            this.n31 = _loc_9;
            this.n32 = _loc_10;
            this.n33 = _loc_11;
            this.n34 = _loc_12;
            this.n41 = _loc_13;
            this.n42 = _loc_14;
            this.n43 = _loc_15;
            this.n44 = _loc_16;
            return;
        }// end function

        public function toString() : String
        {
            var _loc_1:String = "";
            _loc_1 = _loc_1 + (int(this.n11 * 1000) / 1000 + "\t\t" + int(this.n12 * 1000) / 1000 + "\t\t" + int(this.n13 * 1000) / 1000 + "\t\t" + int(this.n14 * 1000) / 1000 + "\n");
            _loc_1 = _loc_1 + (int(this.n21 * 1000) / 1000 + "\t\t" + int(this.n22 * 1000) / 1000 + "\t\t" + int(this.n23 * 1000) / 1000 + "\t\t" + int(this.n24 * 1000) / 1000 + "\n");
            _loc_1 = _loc_1 + (int(this.n31 * 1000) / 1000 + "\t\t" + int(this.n32 * 1000) / 1000 + "\t\t" + int(this.n33 * 1000) / 1000 + "\t\t" + int(this.n34 * 1000) / 1000 + "\n");
            _loc_1 = _loc_1 + (int(this.n41 * 1000) / 1000 + "\t\t" + int(this.n42 * 1000) / 1000 + "\t\t" + int(this.n43 * 1000) / 1000 + "\t\t" + int(this.n44 * 1000) / 1000 + "\n");
            return _loc_1;
        }// end function

        public static function rotationMatrixWithReference(param1:Number3D, param2:Number, param3:Number3D) : Matrix3D
        {
            var _loc_4:* = Matrix3D.translationMatrix(param3.x, -param3.y, param3.z);
            Matrix3D.translationMatrix(param3.x, -param3.y, param3.z).calculateMultiply(Matrix3D.translationMatrix(param3.x, -param3.y, param3.z), Matrix3D.rotationMatrix(param1.x, param1.y, param1.z, param2));
            _loc_4.calculateMultiply(_loc_4, Matrix3D.translationMatrix(-param3.x, param3.y, -param3.z));
            return _loc_4;
        }// end function

        public static function multiplyVector(param1:Matrix3D, param2:Number3D) : void
        {
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_3:* = param2.x;
            _loc_4 = param2.y;
            _loc_5 = param2.z;
            param2.x = _loc_3 * param1.n11 + _loc_4 * param1.n12 + _loc_5 * param1.n13 + param1.n14;
            param2.y = _loc_3 * param1.n21 + _loc_4 * param1.n22 + _loc_5 * param1.n23 + param1.n24;
            param2.z = _loc_3 * param1.n31 + _loc_4 * param1.n32 + _loc_5 * param1.n33 + param1.n34;
            return;
        }// end function

        public static function multiplyVector4x4(param1:Matrix3D, param2:Number3D) : void
        {
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            var _loc_6:Number = NaN;
            _loc_3 = param2.x;
            _loc_4 = param2.y;
            var _loc_5:* = param2.z;
            _loc_6 = 1 / (_loc_3 * param1.n41 + _loc_4 * param1.n42 + _loc_5 * param1.n43 + param1.n44);
            param2.x = _loc_3 * param1.n11 + _loc_4 * param1.n12 + _loc_5 * param1.n13 + param1.n14;
            param2.y = _loc_3 * param1.n21 + _loc_4 * param1.n22 + _loc_5 * param1.n23 + param1.n24;
            param2.z = _loc_3 * param1.n31 + _loc_4 * param1.n32 + _loc_5 * param1.n33 + param1.n34;
            param2.x = param2.x * _loc_6;
            param2.y = param2.y * _loc_6;
            param2.z = param2.z * _loc_6;
            return;
        }// end function

        public static function multiply3x3(param1:Matrix3D, param2:Matrix3D) : Matrix3D
        {
            var _loc_3:* = new Matrix3D;
            _loc_3.calculateMultiply3x3(param1, param2);
            return _loc_3;
        }// end function

        public static function normalizeQuaternion(param1:Object) : Object
        {
            var _loc_2:* = magnitudeQuaternion(param1);
            param1.x = param1.x / _loc_2;
            param1.y = param1.y / _loc_2;
            param1.z = param1.z / _loc_2;
            param1.w = param1.w / _loc_2;
            return param1;
        }// end function

        public static function multiplyVector3x3(param1:Matrix3D, param2:Number3D) : void
        {
            var _loc_3:* = param2.x;
            var _loc_4:* = param2.y;
            var _loc_5:* = param2.z;
            param2.x = _loc_3 * param1.n11 + _loc_4 * param1.n12 + _loc_5 * param1.n13;
            param2.y = _loc_3 * param1.n21 + _loc_4 * param1.n22 + _loc_5 * param1.n23;
            param2.z = _loc_3 * param1.n31 + _loc_4 * param1.n32 + _loc_5 * param1.n33;
            return;
        }// end function

        public static function axis2quaternion(param1:Number, param2:Number, param3:Number, param4:Number) : Object
        {
            var _loc_5:* = Math.sin(param4 / 2);
            var _loc_6:* = Math.cos(param4 / 2);
            var _loc_7:* = new Object();
            new Object().x = param1 * _loc_5;
            _loc_7.y = param2 * _loc_5;
            _loc_7.z = param3 * _loc_5;
            _loc_7.w = _loc_6;
            return normalizeQuaternion(_loc_7);
        }// end function

        public static function translationMatrix(param1:Number, param2:Number, param3:Number) : Matrix3D
        {
            var _loc_4:* = IDENTITY;
            IDENTITY.n14 = param1;
            _loc_4.n24 = param2;
            _loc_4.n34 = param3;
            return _loc_4;
        }// end function

        public static function magnitudeQuaternion(param1:Object) : Number
        {
            return Math.sqrt(param1.w * param1.w + param1.x * param1.x + param1.y * param1.y + param1.z * param1.z);
        }// end function

        public static function rotationX(param1:Number) : Matrix3D
        {
            var _loc_2:* = IDENTITY;
            var _loc_3:* = Math.cos(param1);
            var _loc_4:* = Math.sin(param1);
            _loc_2.n22 = _loc_3;
            _loc_2.n23 = -_loc_4;
            _loc_2.n32 = _loc_4;
            _loc_2.n33 = _loc_3;
            return _loc_2;
        }// end function

        public static function rotationY(param1:Number) : Matrix3D
        {
            var _loc_2:* = IDENTITY;
            var _loc_3:* = Math.cos(param1);
            var _loc_4:* = Math.sin(param1);
            _loc_2.n11 = _loc_3;
            _loc_2.n13 = -_loc_4;
            _loc_2.n31 = _loc_4;
            _loc_2.n33 = _loc_3;
            return _loc_2;
        }// end function

        public static function rotationZ(param1:Number) : Matrix3D
        {
            var _loc_2:* = IDENTITY;
            var _loc_3:* = Math.cos(param1);
            var _loc_4:* = Math.sin(param1);
            _loc_2.n11 = _loc_3;
            _loc_2.n12 = -_loc_4;
            _loc_2.n21 = _loc_4;
            _loc_2.n22 = _loc_3;
            return _loc_2;
        }// end function

        public static function clone(param1:Matrix3D) : Matrix3D
        {
            return new Matrix3D([param1.n11, param1.n12, param1.n13, param1.n14, param1.n21, param1.n22, param1.n23, param1.n24, param1.n31, param1.n32, param1.n33, param1.n34]);
        }// end function

        public static function rotationMatrix(param1:Number, param2:Number, param3:Number, param4:Number, param5:Matrix3D = null) : Matrix3D
        {
            var _loc_6:Matrix3D = null;
            if (!param5)
            {
                _loc_6 = IDENTITY;
            }
            else
            {
                _loc_6 = param5;
            }
            var _loc_7:* = Math.cos(param4);
            var _loc_8:* = Math.sin(param4);
            var _loc_9:* = 1 - _loc_7;
            var _loc_10:* = param1 * param2 * _loc_9;
            var _loc_11:* = param2 * param3 * _loc_9;
            var _loc_12:* = param1 * param3 * _loc_9;
            var _loc_13:* = _loc_8 * param3;
            var _loc_14:* = _loc_8 * param2;
            var _loc_15:* = _loc_8 * param1;
            _loc_6.n11 = _loc_7 + param1 * param1 * _loc_9;
            _loc_6.n12 = -_loc_13 + _loc_10;
            _loc_6.n13 = _loc_14 + _loc_12;
            _loc_6.n14 = 0;
            _loc_6.n21 = _loc_13 + _loc_10;
            _loc_6.n22 = _loc_7 + param2 * param2 * _loc_9;
            _loc_6.n23 = -_loc_15 + _loc_11;
            _loc_6.n24 = 0;
            _loc_6.n31 = -_loc_14 + _loc_12;
            _loc_6.n32 = _loc_15 + _loc_11;
            _loc_6.n33 = _loc_7 + param3 * param3 * _loc_9;
            _loc_6.n34 = 0;
            return _loc_6;
        }// end function

        public static function add(param1:Matrix3D, param2:Matrix3D) : Matrix3D
        {
            var _loc_3:* = new Matrix3D;
            _loc_3.calculateAdd(param1, param2);
            return _loc_3;
        }// end function

        public static function multiply(param1:Matrix3D, param2:Matrix3D) : Matrix3D
        {
            var _loc_3:* = new Matrix3D;
            _loc_3.calculateMultiply(param1, param2);
            return _loc_3;
        }// end function

        public static function euler2quaternion(param1:Number, param2:Number, param3:Number, param4:Quaternion = null) : Quaternion
        {
            var _loc_13:Quaternion = null;
            var _loc_5:* = Math.sin(param1 * 0.5);
            var _loc_6:* = Math.cos(param1 * 0.5);
            var _loc_7:* = Math.sin(param2 * 0.5);
            var _loc_8:* = Math.cos(param2 * 0.5);
            var _loc_9:* = Math.sin(param3 * 0.5);
            var _loc_10:* = Math.cos(param3 * 0.5);
            var _loc_11:* = _loc_6 * _loc_8;
            var _loc_12:* = _loc_5 * _loc_7;
            if (!param4)
            {
                _loc_13 = new Quaternion();
            }
            else
            {
                _loc_13 = param4;
            }
            _loc_13.x = _loc_9 * _loc_11 - _loc_10 * _loc_12;
            _loc_13.y = _loc_10 * _loc_5 * _loc_8 + _loc_9 * _loc_6 * _loc_7;
            _loc_13.z = _loc_10 * _loc_6 * _loc_7 - _loc_9 * _loc_5 * _loc_8;
            _loc_13.w = _loc_10 * _loc_11 + _loc_9 * _loc_12;
            return _loc_13;
        }// end function

        public static function quaternion2matrix(param1:Number, param2:Number, param3:Number, param4:Number, param5:Matrix3D = null) : Matrix3D
        {
            var _loc_15:Matrix3D = null;
            var _loc_6:* = param1 * param1;
            var _loc_7:* = param1 * param2;
            var _loc_8:* = param1 * param3;
            var _loc_9:* = param1 * param4;
            var _loc_10:* = param2 * param2;
            var _loc_11:* = param2 * param3;
            var _loc_12:* = param2 * param4;
            var _loc_13:* = param3 * param3;
            var _loc_14:* = param3 * param4;
            if (!param5)
            {
                _loc_15 = IDENTITY;
            }
            else
            {
                _loc_15 = param5;
            }
            _loc_15.n11 = 1 - 2 * (_loc_10 + _loc_13);
            _loc_15.n12 = 2 * (_loc_7 - _loc_14);
            _loc_15.n13 = 2 * (_loc_8 + _loc_12);
            _loc_15.n21 = 2 * (_loc_7 + _loc_14);
            _loc_15.n22 = 1 - 2 * (_loc_6 + _loc_13);
            _loc_15.n23 = 2 * (_loc_11 - _loc_9);
            _loc_15.n31 = 2 * (_loc_8 - _loc_12);
            _loc_15.n32 = 2 * (_loc_11 + _loc_9);
            _loc_15.n33 = 1 - 2 * (_loc_6 + _loc_10);
            return _loc_15;
        }// end function

        public static function inverse(param1:Matrix3D) : Matrix3D
        {
            var _loc_2:* = new Matrix3D;
            _loc_2.calculateInverse(param1);
            return _loc_2;
        }// end function

        public static function euler2matrix(param1:Number3D) : Matrix3D
        {
            temp.reset();
            var _loc_2:* = temp;
            _loc_2 = temp;
            var _loc_3:* = param1.x * toRADIANS;
            var _loc_4:* = param1.y * toRADIANS;
            var _loc_5:* = param1.z * toRADIANS;
            var _loc_6:* = Math.cos(_loc_3);
            var _loc_7:* = Math.sin(_loc_3);
            var _loc_8:* = Math.cos(_loc_4);
            var _loc_9:* = Math.sin(_loc_4);
            var _loc_10:* = Math.cos(_loc_5);
            var _loc_11:* = Math.sin(_loc_5);
            var _loc_12:* = _loc_6 * _loc_9;
            var _loc_13:* = _loc_7 * _loc_9;
            _loc_2.n11 = _loc_8 * _loc_10;
            _loc_2.n12 = (-_loc_8) * _loc_11;
            _loc_2.n13 = _loc_9;
            _loc_2.n21 = _loc_13 * _loc_10 + _loc_6 * _loc_11;
            _loc_2.n22 = (-_loc_13) * _loc_11 + _loc_6 * _loc_10;
            _loc_2.n23 = (-_loc_7) * _loc_8;
            _loc_2.n31 = (-_loc_12) * _loc_10 + _loc_7 * _loc_11;
            _loc_2.n32 = _loc_12 * _loc_11 + _loc_7 * _loc_10;
            _loc_2.n33 = _loc_6 * _loc_8;
            return _loc_2;
        }// end function

        public static function scaleMatrix(param1:Number, param2:Number, param3:Number) : Matrix3D
        {
            var _loc_4:* = IDENTITY;
            IDENTITY.n11 = param1;
            _loc_4.n22 = param2;
            _loc_4.n33 = param3;
            return _loc_4;
        }// end function

        public static function rotateAxis(param1:Matrix3D, param2:Number3D) : void
        {
            var _loc_3:* = param2.x;
            var _loc_4:* = param2.y;
            var _loc_5:* = param2.z;
            param2.x = _loc_3 * param1.n11 + _loc_4 * param1.n12 + _loc_5 * param1.n13;
            param2.y = _loc_3 * param1.n21 + _loc_4 * param1.n22 + _loc_5 * param1.n23;
            param2.z = _loc_3 * param1.n31 + _loc_4 * param1.n32 + _loc_5 * param1.n33;
            param2.normalize();
            return;
        }// end function

        public static function matrix2euler(param1:Matrix3D, param2:Number3D = null, param3:Number3D = null) : Number3D
        {
            if (!param2)
            {
            }
            param2 = new Number3D();
            if (param3)
            {
            }
            var _loc_4:* = param3.x == 1 ? (1) : (Math.sqrt(param1.n11 * param1.n11 + param1.n21 * param1.n21 + param1.n31 * param1.n31));
            if (param3)
            {
            }
            var _loc_5:* = param3.y == 1 ? (1) : (Math.sqrt(param1.n12 * param1.n12 + param1.n22 * param1.n22 + param1.n32 * param1.n32));
            if (param3)
            {
            }
            var _loc_6:* = param3.z == 1 ? (1) : (Math.sqrt(param1.n13 * param1.n13 + param1.n23 * param1.n23 + param1.n33 * param1.n33));
            var _loc_7:* = param1.n11 / _loc_4;
            var _loc_8:* = param1.n21 / _loc_5;
            var _loc_9:* = param1.n31 / _loc_6;
            var _loc_10:* = param1.n32 / _loc_6;
            var _loc_11:* = param1.n33 / _loc_6;
            _loc_9 = _loc_9 > 1 ? (1) : (_loc_9);
            _loc_9 = _loc_9 < -1 ? (-1) : (_loc_9);
            param2.y = Math.asin(-_loc_9);
            param2.z = Math.atan2(_loc_8, _loc_7);
            param2.x = Math.atan2(_loc_10, _loc_11);
            if (Papervision3D.useDEGREES)
            {
                param2.x = param2.x * toDEGREES;
                param2.y = param2.y * toDEGREES;
                param2.z = param2.z * toDEGREES;
            }
            return param2;
        }// end function

        public static function multiplyQuaternion(param1:Object, param2:Object) : Object
        {
            var _loc_3:* = param1.x;
            var _loc_4:* = param1.y;
            var _loc_5:* = param1.z;
            var _loc_6:* = param1.w;
            var _loc_7:* = param2.x;
            var _loc_8:* = param2.y;
            var _loc_9:* = param2.z;
            var _loc_10:* = param2.w;
            var _loc_11:* = new Object();
            new Object().x = _loc_6 * _loc_7 + _loc_3 * _loc_10 + _loc_4 * _loc_9 - _loc_5 * _loc_8;
            _loc_11.y = _loc_6 * _loc_8 + _loc_4 * _loc_10 + _loc_5 * _loc_7 - _loc_3 * _loc_9;
            _loc_11.z = _loc_6 * _loc_9 + _loc_5 * _loc_10 + _loc_3 * _loc_8 - _loc_4 * _loc_7;
            _loc_11.w = _loc_6 * _loc_10 - _loc_3 * _loc_7 - _loc_4 * _loc_8 - _loc_5 * _loc_9;
            return _loc_11;
        }// end function

        public static function get IDENTITY() : Matrix3D
        {
            return new Matrix3D([1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1]);
        }// end function

    }
}
