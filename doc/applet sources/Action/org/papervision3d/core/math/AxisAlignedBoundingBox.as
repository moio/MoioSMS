package org.papervision3d.core.math
{
    import org.papervision3d.core.geom.renderables.*;

    public class AxisAlignedBoundingBox extends Object
    {
        public var minX:Number;
        public var minY:Number;
        public var minZ:Number;
        public var maxX:Number;
        public var maxY:Number;
        public var maxZ:Number;
        protected var _vertices:Array;

        public function AxisAlignedBoundingBox(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number)
        {
            this.minX = param1;
            this.minY = param2;
            this.minZ = param3;
            this.maxX = param4;
            this.maxY = param5;
            this.maxZ = param6;
            this.createBoxVertices();
            return;
        }// end function

        protected function createBoxVertices() : void
        {
            this._vertices = new Array();
            this._vertices.push(new Vertex3D(this.minX, this.minY, this.minZ));
            this._vertices.push(new Vertex3D(this.minX, this.minY, this.maxZ));
            this._vertices.push(new Vertex3D(this.minX, this.maxY, this.minZ));
            this._vertices.push(new Vertex3D(this.minX, this.maxY, this.maxZ));
            this._vertices.push(new Vertex3D(this.maxX, this.minY, this.minZ));
            this._vertices.push(new Vertex3D(this.maxX, this.minY, this.maxZ));
            this._vertices.push(new Vertex3D(this.maxX, this.maxY, this.minZ));
            this._vertices.push(new Vertex3D(this.maxX, this.maxY, this.maxZ));
            return;
        }// end function

        public function getBoxVertices() : Array
        {
            return this._vertices;
        }// end function

        public function merge(param1:AxisAlignedBoundingBox) : void
        {
            this.minX = Math.min(this.minX, param1.minX);
            this.minY = Math.min(this.minY, param1.minY);
            this.minZ = Math.min(this.minZ, param1.minZ);
            this.maxX = Math.max(this.maxX, param1.maxX);
            this.maxY = Math.max(this.maxY, param1.maxY);
            this.maxZ = Math.max(this.maxZ, param1.maxZ);
            this.createBoxVertices();
            return;
        }// end function

        public static function createFromVertices(param1:Array) : AxisAlignedBoundingBox
        {
            var _loc_8:Vertex3D = null;
            var _loc_2:* = Number.MAX_VALUE;
            var _loc_3:* = Number.MAX_VALUE;
            var _loc_4:* = Number.MAX_VALUE;
            var _loc_5:* = -_loc_2;
            var _loc_6:* = -_loc_3;
            var _loc_7:* = -_loc_4;
            for each (_loc_8 in param1)
            {
                
                _loc_2 = Math.min(_loc_2, _loc_8.x);
                _loc_3 = Math.min(_loc_3, _loc_8.y);
                _loc_4 = Math.min(_loc_4, _loc_8.z);
                _loc_5 = Math.max(_loc_5, _loc_8.x);
                _loc_6 = Math.max(_loc_6, _loc_8.y);
                _loc_7 = Math.max(_loc_7, _loc_8.z);
            }
            return new AxisAlignedBoundingBox(_loc_2, _loc_3, _loc_4, _loc_5, _loc_6, _loc_7);
        }// end function

    }
}
