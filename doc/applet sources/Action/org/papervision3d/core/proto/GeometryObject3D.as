package org.papervision3d.core.proto
{
    import flash.events.*;
    import flash.utils.*;
    import org.papervision3d.core.geom.renderables.*;
    import org.papervision3d.core.math.*;
    import org.papervision3d.objects.*;

    public class GeometryObject3D extends EventDispatcher
    {
        protected var _boundingSphereDirty:Boolean = true;
        public var dirty:Boolean;
        protected var _aabbDirty:Boolean = true;
        public var _ready:Boolean = false;
        protected var _boundingSphere:BoundingSphere;
        public var faces:Array;
        private var _numInstances:uint = 0;
        public var vertices:Array;
        protected var _aabb:AxisAlignedBoundingBox;

        public function GeometryObject3D() : void
        {
            this.dirty = true;
            return;
        }// end function

        public function transformVertices(param1:Matrix3D) : void
        {
            var _loc_15:Vertex3D = null;
            var _loc_16:Number = NaN;
            var _loc_17:Number = NaN;
            var _loc_18:Number = NaN;
            var _loc_19:Number = NaN;
            var _loc_20:Number = NaN;
            var _loc_21:Number = NaN;
            var _loc_2:* = param1.n11;
            var _loc_3:* = param1.n12;
            var _loc_4:* = param1.n13;
            var _loc_5:* = param1.n21;
            var _loc_6:* = param1.n22;
            var _loc_7:* = param1.n23;
            var _loc_8:* = param1.n31;
            var _loc_9:* = param1.n32;
            var _loc_10:* = param1.n33;
            var _loc_11:* = param1.n14;
            var _loc_12:* = param1.n24;
            var _loc_13:* = param1.n34;
            var _loc_14:* = this.vertices.length;
            do
            {
                
                _loc_16 = _loc_15.x;
                _loc_17 = _loc_15.y;
                _loc_18 = _loc_15.z;
                _loc_19 = _loc_16 * _loc_2 + _loc_17 * _loc_3 + _loc_18 * _loc_4 + _loc_11;
                _loc_20 = _loc_16 * _loc_5 + _loc_17 * _loc_6 + _loc_18 * _loc_7 + _loc_12;
                _loc_21 = _loc_16 * _loc_8 + _loc_17 * _loc_9 + _loc_18 * _loc_10 + _loc_13;
                _loc_15.x = _loc_19;
                _loc_15.y = _loc_20;
                _loc_15.z = _loc_21;
                var _loc_22:* = this.vertices[--_loc_14];
                _loc_15 = this.vertices[--_loc_14];
            }while (_loc_22)
            return;
        }// end function

        public function set ready(param1:Boolean) : void
        {
            if (param1)
            {
                this.createVertexNormals();
                this.dirty = false;
            }
            this._ready = param1;
            return;
        }// end function

        public function flipFaces() : void
        {
            var _loc_1:Triangle3D = null;
            var _loc_2:Vertex3D = null;
            for each (_loc_1 in this.faces)
            {
                
                _loc_2 = _loc_1.v0;
                _loc_1.v0 = _loc_1.v2;
                _loc_1.v2 = _loc_2;
                _loc_1.uv = [_loc_1.uv2, _loc_1.uv1, _loc_1.uv0];
                _loc_1.createNormal();
            }
            this.ready = true;
            return;
        }// end function

        private function createVertexNormals() : void
        {
            var _loc_2:Triangle3D = null;
            var _loc_3:Vertex3D = null;
            var _loc_1:* = new Dictionary(true);
            for each (_loc_2 in this.faces)
            {
                
                _loc_2.v0.connectedFaces[_loc_2] = _loc_2;
                _loc_2.v1.connectedFaces[_loc_2] = _loc_2;
                _loc_2.v2.connectedFaces[_loc_2] = _loc_2;
                _loc_1[_loc_2.v0] = _loc_2.v0;
                _loc_1[_loc_2.v1] = _loc_2.v1;
                _loc_1[_loc_2.v2] = _loc_2.v2;
            }
            for each (_loc_3 in _loc_1)
            {
                
                _loc_3.calculateNormal();
            }
            return;
        }// end function

        public function get boundingSphere() : BoundingSphere
        {
            if (this._boundingSphereDirty)
            {
                this._boundingSphere = BoundingSphere.getFromVertices(this.vertices);
                this._boundingSphereDirty = false;
            }
            return this._boundingSphere;
        }// end function

        public function clone(param1:DisplayObject3D = null) : GeometryObject3D
        {
            var _loc_5:int = 0;
            var _loc_6:MaterialObject3D = null;
            var _loc_7:Vertex3D = null;
            var _loc_8:Triangle3D = null;
            var _loc_9:Vertex3D = null;
            var _loc_10:Vertex3D = null;
            var _loc_11:Vertex3D = null;
            var _loc_2:* = new Dictionary(true);
            var _loc_3:* = new Dictionary(true);
            var _loc_4:* = new GeometryObject3D();
            new GeometryObject3D().vertices = new Array();
            _loc_4.faces = new Array();
            _loc_5 = 0;
            while (_loc_5 < this.vertices.length)
            {
                
                _loc_7 = this.vertices[_loc_5];
                _loc_3[_loc_7] = _loc_7.clone();
                _loc_4.vertices.push(_loc_3[_loc_7]);
                _loc_5++;
            }
            _loc_5 = 0;
            while (_loc_5 < this.faces.length)
            {
                
                _loc_8 = this.faces[_loc_5];
                _loc_9 = _loc_3[_loc_8.v0];
                _loc_10 = _loc_3[_loc_8.v1];
                _loc_11 = _loc_3[_loc_8.v2];
                _loc_4.faces.push(new Triangle3D(param1, [_loc_9, _loc_10, _loc_11], _loc_8.material, _loc_8.uv));
                _loc_2[_loc_8.material] = _loc_8.material;
                _loc_5++;
            }
            for each (_loc_6 in _loc_2)
            {
                
                _loc_6.registerObject(param1);
            }
            return _loc_4;
        }// end function

        public function get ready() : Boolean
        {
            return this._ready;
        }// end function

        public function get aabb() : AxisAlignedBoundingBox
        {
            if (this._aabbDirty)
            {
                this._aabb = AxisAlignedBoundingBox.createFromVertices(this.vertices);
                this._aabbDirty = false;
            }
            return this._aabb;
        }// end function

    }
}
