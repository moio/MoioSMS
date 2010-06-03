package org.papervision3d.core.geom.renderables
{
    import org.papervision3d.core.math.*;

    public class Vertex3DInstance extends Object
    {
        public var y:Number;
        private var persp:Number = 0;
        public var normal:Number3D;
        public var visible:Boolean;
        public var extra:Object;
        public var x:Number;
        public var z:Number;

        public function Vertex3DInstance(param1:Number = 0, param2:Number = 0, param3:Number = 0)
        {
            this.x = param1;
            this.y = param2;
            this.z = param3;
            this.visible = false;
            this.normal = new Number3D();
            return;
        }// end function

        public function deperspective(param1:Number) : Vertex3D
        {
            this.persp = 1 + this.z / param1;
            return new Vertex3D(this.x * this.persp, this.y * this.persp, this.z);
        }// end function

        public function distance(param1:Vertex3DInstance) : Number
        {
            return Math.sqrt((this.x - param1.x) * (this.x - param1.x) + (this.y - param1.y) * (this.y - param1.y));
        }// end function

        public function clone() : Vertex3DInstance
        {
            var _loc_1:* = new Vertex3DInstance(this.x, this.y, this.z);
            _loc_1.visible = this.visible;
            _loc_1.extra = this.extra;
            return _loc_1;
        }// end function

        public function distanceSqr(param1:Vertex3DInstance) : Number
        {
            return (this.x - param1.x) * (this.x - param1.x) + (this.y - param1.y) * (this.y - param1.y);
        }// end function

        public static function cross(param1:Vertex3DInstance, param2:Vertex3DInstance) : Number
        {
            return param1.x * param2.y - param2.x * param1.y;
        }// end function

        public static function dot(param1:Vertex3DInstance, param2:Vertex3DInstance) : Number
        {
            return param1.x * param2.x + param1.y * param2.y;
        }// end function

        public static function subTo(param1:Vertex3DInstance, param2:Vertex3DInstance, param3:Vertex3DInstance) : void
        {
            param3.x = param2.x - param1.x;
            param3.y = param2.y - param1.y;
            return;
        }// end function

        public static function median(param1:Vertex3DInstance, param2:Vertex3DInstance, param3:Number) : Vertex3DInstance
        {
            var _loc_4:* = (param1.z + param2.z) / 2;
            var _loc_5:* = param3 + param1.z;
            var _loc_6:* = param3 + param2.z;
            var _loc_7:* = 1 / (param3 + _loc_4) / 2;
            return new Vertex3DInstance((param1.x * _loc_5 + param2.x * _loc_6) * _loc_7, (param1.y * _loc_5 + param2.y * _loc_6) * _loc_7, _loc_4);
        }// end function

        public static function sub(param1:Vertex3DInstance, param2:Vertex3DInstance) : Vertex3DInstance
        {
            return new Vertex3DInstance(param2.x - param1.x, param2.y - param1.y);
        }// end function

    }
}
