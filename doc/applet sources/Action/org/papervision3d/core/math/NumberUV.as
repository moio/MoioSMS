package org.papervision3d.core.math
{

    public class NumberUV extends Object
    {
        public var u:Number;
        public var v:Number;

        public function NumberUV(param1:Number = 0, param2:Number = 0)
        {
            this.u = param1;
            this.v = param2;
            return;
        }// end function

        public function toString() : String
        {
            return "u:" + this.u + " v:" + this.v;
        }// end function

        public function clone() : NumberUV
        {
            return new NumberUV(this.u, this.v);
        }// end function

        public static function get ZERO() : NumberUV
        {
            return new NumberUV(0, 0);
        }// end function

        public static function median(param1:NumberUV, param2:NumberUV) : NumberUV
        {
            if (param1 == null)
            {
                return null;
            }
            if (param2 == null)
            {
                return null;
            }
            return new NumberUV((param1.u + param2.u) / 2, (param1.v + param2.v) / 2);
        }// end function

        public static function weighted(param1:NumberUV, param2:NumberUV, param3:Number, param4:Number) : NumberUV
        {
            if (param1 == null)
            {
                return null;
            }
            if (param2 == null)
            {
                return null;
            }
            var _loc_5:* = param3 + param4;
            var _loc_6:* = param3 / _loc_5;
            var _loc_7:* = param4 / _loc_5;
            return new NumberUV(param1.u * _loc_6 + param2.u * _loc_7, param1.v * _loc_6 + param2.v * _loc_7);
        }// end function

    }
}
