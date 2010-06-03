package org.papervision3d.core.geom.renderables
{
    import flash.utils.*;
    import org.papervision3d.core.math.*;
    import org.papervision3d.core.render.command.*;

    public class Vertex3D extends AbstractRenderable implements IRenderable
    {
        public var z:Number;
        public var vertex3DInstance:Vertex3DInstance;
        public var extra:Object;
        public var timestamp:Number;
        public var normal:Number3D;
        protected var position:Number3D;
        public var connectedFaces:Dictionary;
        public var x:Number;
        public var y:Number;
        private var persp:Number = 0;

        public function Vertex3D(param1:Number = 0, param2:Number = 0, param3:Number = 0)
        {
            this.position = new Number3D();
            var _loc_4:* = param1;
            this.position.x = param1;
            this.x = _loc_4;
            var _loc_4:* = param2;
            this.position.y = param2;
            this.y = _loc_4;
            var _loc_4:* = param3;
            this.position.z = param3;
            this.z = _loc_4;
            this.vertex3DInstance = new Vertex3DInstance();
            this.normal = new Number3D();
            this.connectedFaces = new Dictionary();
            return;
        }// end function

        public function perspective(param1:Number) : Vertex3DInstance
        {
            this.persp = 1 / (1 + this.z / param1);
            return new Vertex3DInstance(this.x * this.persp, this.y * this.persp, this.z);
        }// end function

        public function toNumber3D() : Number3D
        {
            return new Number3D(this.x, this.y, this.z);
        }// end function

        public function clone() : Vertex3D
        {
            var _loc_1:* = new Vertex3D(this.x, this.y, this.z);
            _loc_1.extra = this.extra;
            _loc_1.vertex3DInstance = this.vertex3DInstance.clone();
            _loc_1.normal = this.normal.clone();
            return _loc_1;
        }// end function

        public function getPosition() : Number3D
        {
            this.position.x = this.x;
            this.position.y = this.y;
            this.position.z = this.z;
            return this.position;
        }// end function

        public function calculateNormal() : void
        {
            var _loc_1:Triangle3D = null;
            var _loc_2:Number = NaN;
            var _loc_3:Number3D = null;
            _loc_2 = 0;
            this.normal.reset();
            for each (_loc_1 in this.connectedFaces)
            {
                
                if (_loc_1.faceNormal)
                {
                    this.normal.plusEq(_loc_1.faceNormal);
                }
            }
            _loc_3 = this.getPosition();
            _loc_3.x = _loc_3.x / _loc_2++;
            _loc_3.y = _loc_3.y / _loc_2;
            _loc_3.z = _loc_3.z / _loc_2;
            _loc_3.normalize();
            this.normal.plusEq(_loc_3);
            this.normal.normalize();
            return;
        }// end function

        override public function getRenderListItem() : IRenderListItem
        {
            return null;
        }// end function

        public static function weighted(param1:Vertex3D, param2:Vertex3D, param3:Number, param4:Number) : Vertex3D
        {
            var _loc_5:* = param3 + param4;
            var _loc_6:* = param3 / _loc_5;
            var _loc_7:* = param4 / _loc_5;
            return new Vertex3D(param1.x * _loc_6 + param2.x * _loc_7, param1.y * _loc_6 + param2.y * _loc_7, param1.z * _loc_6 + param2.z * _loc_7);
        }// end function

    }
}
