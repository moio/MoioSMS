package org.papervision3d.core.geom
{
    import org.papervision3d.core.culling.*;
    import org.papervision3d.core.math.*;
    import org.papervision3d.core.proto.*;
    import org.papervision3d.core.render.data.*;
    import org.papervision3d.objects.*;

    public class Vertices3D extends DisplayObject3D
    {

        public function Vertices3D(param1:Array, param2:String = null)
        {
            super(param2, new GeometryObject3D());
            if (!param1)
            {
            }
            this.geometry.vertices = new Array();
            return;
        }// end function

        override public function project(param1:DisplayObject3D, param2:RenderSessionData) : Number
        {
            super.project(param1, param2);
            if (this.culled)
            {
                return 0;
            }
            if (param2.camera is IObjectCuller)
            {
                return this.projectFrustum(param1, param2);
            }
            if (!this.geometry || !this.geometry.vertices)
            {
                return 0;
            }
            return param2.camera.projectVertices(this.geometry.vertices, this, param2);
        }// end function

        public function projectEmpty(param1:DisplayObject3D, param2:RenderSessionData) : Number
        {
            return super.project(param1, param2);
        }// end function

        public function transformVertices(param1:Matrix3D) : void
        {
            geometry.transformVertices(param1);
            return;
        }// end function

        public function boundingBox() : Object
        {
            var _loc_3:Vertex3D = null;
            var _loc_1:* = this.geometry.vertices;
            var _loc_2:* = new Object();
            _loc_2.min = new Number3D(Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE);
            _loc_2.max = new Number3D(-Number.MAX_VALUE, -Number.MAX_VALUE, -Number.MAX_VALUE);
            _loc_2.size = new Number3D();
            for each (_loc_3 in _loc_1)
            {
                
                _loc_2.min.x = Math.min(_loc_3.x, _loc_2.min.x);
                _loc_2.min.y = Math.min(_loc_3.y, _loc_2.min.y);
                _loc_2.min.z = Math.min(_loc_3.z, _loc_2.min.z);
                _loc_2.max.x = Math.max(_loc_3.x, _loc_2.max.x);
                _loc_2.max.y = Math.max(_loc_3.y, _loc_2.max.y);
                _loc_2.max.z = Math.max(_loc_3.z, _loc_2.max.z);
            }
            _loc_2.size.x = _loc_2.max.x - _loc_2.min.x;
            _loc_2.size.y = _loc_2.max.y - _loc_2.min.y;
            _loc_2.size.z = _loc_2.max.z - _loc_2.min.z;
            return _loc_2;
        }// end function

        public function projectFrustum(param1:DisplayObject3D, param2:RenderSessionData) : Number
        {
            return 0;
        }// end function

        override public function clone() : DisplayObject3D
        {
            var _loc_1:* = super.clone();
            var _loc_2:* = new Vertices3D(null, _loc_1.name);
            _loc_2.material = _loc_1.material;
            if (_loc_1.materials)
            {
                _loc_2.materials = _loc_1.materials.clone();
            }
            if (this.geometry)
            {
                _loc_2.geometry = this.geometry.clone(_loc_2);
            }
            _loc_2.copyTransform(this.transform);
            return _loc_2;
        }// end function

    }
}
