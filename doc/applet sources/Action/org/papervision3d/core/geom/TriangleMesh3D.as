package org.papervision3d.core.geom
{
    import flash.utils.*;
    import org.papervision3d.core.geom.renderables.*;
    import org.papervision3d.core.math.*;
    import org.papervision3d.core.proto.*;
    import org.papervision3d.core.render.command.*;
    import org.papervision3d.core.render.data.*;
    import org.papervision3d.core.render.draw.*;
    import org.papervision3d.objects.*;

    public class TriangleMesh3D extends Vertices3D
    {
        private var _tri:RenderTriangle;
        private var _dtStore:Array;
        private var _dtActive:Array;

        public function TriangleMesh3D(param1:MaterialObject3D, param2:Array, param3:Array, param4:String = null)
        {
            this._dtStore = new Array();
            this._dtActive = new Array();
            super(param2, param4);
            if (!param3)
            {
            }
            this.geometry.faces = new Array();
            if (!param1)
            {
            }
            this.material = MaterialObject3D.DEFAULT;
            return;
        }// end function

        public function projectTexture(param1:String = "x", param2:String = "y") : void
        {
            var _loc_10:String = null;
            var _loc_11:Triangle3D = null;
            var _loc_12:Array = null;
            var _loc_13:Vertex3D = null;
            var _loc_14:Vertex3D = null;
            var _loc_15:Vertex3D = null;
            var _loc_16:NumberUV = null;
            var _loc_17:NumberUV = null;
            var _loc_18:NumberUV = null;
            var _loc_3:* = this.geometry.faces;
            var _loc_4:* = this.boundingBox();
            var _loc_5:* = this.boundingBox().min[param1];
            var _loc_6:* = _loc_4.size[param1];
            var _loc_7:* = _loc_4.min[param2];
            var _loc_8:* = _loc_4.size[param2];
            var _loc_9:* = this.material;
            for (_loc_10 in _loc_3)
            {
                
                _loc_11 = _loc_3[Number(_loc_10)];
                _loc_12 = _loc_11.vertices;
                _loc_13 = _loc_12[0];
                _loc_14 = _loc_12[1];
                _loc_15 = _loc_12[2];
                _loc_16 = new NumberUV((_loc_13[param1] - _loc_5) / _loc_6, (_loc_13[param2] - _loc_7) / _loc_8);
                _loc_17 = new NumberUV((_loc_14[param1] - _loc_5) / _loc_6, (_loc_14[param2] - _loc_7) / _loc_8);
                _loc_18 = new NumberUV((_loc_15[param1] - _loc_5) / _loc_6, (_loc_15[param2] - _loc_7) / _loc_8);
                _loc_11.uv = [_loc_16, _loc_17, _loc_18];
            }
            return;
        }// end function

        public function quarterFaces() : void
        {
            var _loc_4:Triangle3D = null;
            var _loc_6:Vertex3D = null;
            var _loc_7:Vertex3D = null;
            var _loc_8:Vertex3D = null;
            var _loc_9:Vertex3D = null;
            var _loc_10:Vertex3D = null;
            var _loc_11:Vertex3D = null;
            var _loc_12:NumberUV = null;
            var _loc_13:NumberUV = null;
            var _loc_14:NumberUV = null;
            var _loc_15:NumberUV = null;
            var _loc_16:NumberUV = null;
            var _loc_17:NumberUV = null;
            var _loc_18:Triangle3D = null;
            var _loc_19:Triangle3D = null;
            var _loc_20:Triangle3D = null;
            var _loc_21:Triangle3D = null;
            var _loc_1:* = new Array();
            var _loc_2:* = new Array();
            var _loc_3:* = this.geometry.faces;
            var _loc_5:* = _loc_3.length;
            do
            {
                
                _loc_6 = _loc_4.v0;
                _loc_7 = _loc_4.v1;
                _loc_8 = _loc_4.v2;
                _loc_9 = new Vertex3D((_loc_6.x + _loc_7.x) / 2, (_loc_6.y + _loc_7.y) / 2, (_loc_6.z + _loc_7.z) / 2);
                _loc_10 = new Vertex3D((_loc_7.x + _loc_8.x) / 2, (_loc_7.y + _loc_8.y) / 2, (_loc_7.z + _loc_8.z) / 2);
                _loc_11 = new Vertex3D((_loc_8.x + _loc_6.x) / 2, (_loc_8.y + _loc_6.y) / 2, (_loc_8.z + _loc_6.z) / 2);
                this.geometry.vertices.push(_loc_9, _loc_10, _loc_11);
                _loc_12 = _loc_4.uv[0];
                _loc_13 = _loc_4.uv[1];
                _loc_14 = _loc_4.uv[2];
                _loc_15 = new NumberUV((_loc_12.u + _loc_13.u) / 2, (_loc_12.v + _loc_13.v) / 2);
                _loc_16 = new NumberUV((_loc_13.u + _loc_14.u) / 2, (_loc_13.v + _loc_14.v) / 2);
                _loc_17 = new NumberUV((_loc_14.u + _loc_12.u) / 2, (_loc_14.v + _loc_12.v) / 2);
                _loc_18 = new Triangle3D(this, [_loc_6, _loc_9, _loc_11], _loc_4.material, [_loc_12, _loc_15, _loc_17]);
                _loc_19 = new Triangle3D(this, [_loc_9, _loc_7, _loc_10], _loc_4.material, [_loc_15, _loc_13, _loc_16]);
                _loc_20 = new Triangle3D(this, [_loc_11, _loc_10, _loc_8], _loc_4.material, [_loc_17, _loc_16, _loc_14]);
                _loc_21 = new Triangle3D(this, [_loc_9, _loc_10, _loc_11], _loc_4.material, [_loc_15, _loc_16, _loc_17]);
                _loc_2.push(_loc_18, _loc_19, _loc_20, _loc_21);
                var _loc_22:* = _loc_3[--_loc_5];
                _loc_4 = _loc_3[--_loc_5];
            }while (_loc_22)
            this.geometry.faces = _loc_2;
            this.mergeVertices();
            this.geometry.ready = true;
            return;
        }// end function

        override public function set material(param1:MaterialObject3D) : void
        {
            var _loc_2:Triangle3D = null;
            super.material = param1;
            for each (_loc_2 in geometry.faces)
            {
                
                _loc_2.material = param1;
            }
            return;
        }// end function

        public function mergeVertices() : void
        {
            var _loc_3:Vertex3D = null;
            var _loc_4:Triangle3D = null;
            var _loc_5:Vertex3D = null;
            var _loc_1:* = new Dictionary();
            var _loc_2:* = new Array();
            for each (_loc_3 in this.geometry.vertices)
            {
                
                for each (_loc_5 in _loc_1)
                {
                    
                    if (_loc_3.x == _loc_5.x && _loc_3.y == _loc_5.y && _loc_3.z == _loc_5.z)
                    {
                        _loc_1[_loc_3] = _loc_5;
                        break;
                    }
                }
                if (!_loc_1[_loc_3])
                {
                    _loc_1[_loc_3] = _loc_3;
                    _loc_2.push(_loc_3);
                }
            }
            this.geometry.vertices = _loc_2;
            for each (_loc_4 in geometry.faces)
            {
                
                var _loc_8:* = _loc_1[_loc_4.v0];
                _loc_4.vertices[0] = _loc_1[_loc_4.v0];
                (_loc_7[_loc_6]).v0 = _loc_8;
                var _loc_8:* = _loc_1[_loc_4.v1];
                _loc_4.vertices[1] = _loc_1[_loc_4.v1];
                _loc_4.v1 = _loc_8;
                var _loc_8:* = _loc_1[_loc_4.v2];
                _loc_4.vertices[2] = _loc_1[_loc_4.v2];
                _loc_4.v2 = _loc_8;
            }
            return;
        }// end function

        override public function project(param1:DisplayObject3D, param2:RenderSessionData) : Number
        {
            var _loc_5:Triangle3D = null;
            var _loc_6:Array = null;
            var _loc_7:Number = NaN;
            var _loc_8:Number = NaN;
            var _loc_9:ITriangleCuller = null;
            var _loc_10:Vertex3DInstance = null;
            var _loc_11:Vertex3DInstance = null;
            var _loc_12:Vertex3DInstance = null;
            var _loc_13:Triangle3DInstance = null;
            var _loc_14:Triangle3D = null;
            var _loc_15:MaterialObject3D = null;
            var _loc_16:RenderTriangle = null;
            this._dtStore = [];
            this._dtActive = new Array();
            var _loc_3:* = this.geometry.vertices.length;
            var _loc_4:Array = [];
            if (param2.clipping && this.useClipping && !this.culled)
            {
            }
            if (param2.camera.useCulling ? (cullTest == 0) : (true))
            {
                super.projectEmpty(param1, param2);
                param2.clipping.setDisplayObject(this, param2);
                for each (_loc_5 in this.geometry.faces)
                {
                    
                    if (param2.clipping.testFace(_loc_5, this, param2))
                    {
                        param2.clipping.clipFace(_loc_5, this, _loc_15, param2, _loc_4);
                        continue;
                    }
                    _loc_4.push(_loc_5);
                }
                super.project(param1, param2);
                param2.camera.projectFaces(_loc_4, this, param2);
            }
            else
            {
                super.project(param1, param2);
                _loc_4 = this.geometry.faces;
            }
            if (!this.culled)
            {
                _loc_6 = this.geometry.faces;
                _loc_7 = 0;
                _loc_8 = 0;
                _loc_9 = param2.triangleCuller;
                for each (_loc_14 in _loc_4)
                {
                    
                    _loc_15 = _loc_14.material ? (_loc_14.material) : (material);
                    _loc_10 = _loc_14.v0.vertex3DInstance;
                    _loc_11 = _loc_14.v1.vertex3DInstance;
                    _loc_12 = _loc_14.v2.vertex3DInstance;
                    if (_loc_9.testFace(_loc_14, _loc_10, _loc_11, _loc_12))
                    {
                        _loc_16 = _loc_14.renderCommand;
                        var _loc_19:* = this.setScreenZ(meshSort, _loc_10, _loc_11, _loc_12);
                        _loc_16.screenZ = this.setScreenZ(meshSort, _loc_10, _loc_11, _loc_12);
                        _loc_7 = _loc_7 + _loc_19;
                        _loc_16.renderer = _loc_15 as ITriangleDrawer;
                        _loc_16.v0 = _loc_10;
                        _loc_16.v1 = _loc_11;
                        _loc_16.v2 = _loc_12;
                        _loc_16.uv0 = _loc_14.uv0;
                        _loc_16.uv1 = _loc_14.uv1;
                        _loc_16.uv2 = _loc_14.uv2;
                        if (param2.quadrantTree)
                        {
                            if (_loc_16.create == null)
                            {
                                _loc_16.create = this.createRenderTriangle;
                            }
                            _loc_16.update();
                            if (_loc_16.area < 0 && _loc_14.material.doubleSided || _loc_14.material.oneSide && _loc_14.material.opposite)
                            {
                                _loc_16.area = -_loc_16.area;
                            }
                        }
                        param2.renderer.addToRenderList(_loc_16);
                        continue;
                    }
                    var _loc_19:* = param2.renderStatistics;
                    _loc_19.culledTriangles = param2.renderStatistics.culledTriangles++;
                }
                if (_loc_3)
                {
                    while (this.geometry.vertices.length > _loc_3)
                    {
                        
                        this.geometry.vertices.pop();
                    }
                }
                var _loc_17:* = _loc_7 / _loc_8++;
                this.screenZ = _loc_7 / _loc_8++;
                return _loc_17;
            }
            else
            {
                var _loc_17:* = param2.renderStatistics;
                _loc_17.culledObjects = param2.renderStatistics.culledObjects++;
                return 0;
            }
        }// end function

        public function createRenderTriangle(param1:Triangle3D, param2:MaterialObject3D, param3:Vertex3DInstance, param4:Vertex3DInstance, param5:Vertex3DInstance, param6:NumberUV, param7:NumberUV, param8:NumberUV) : RenderTriangle
        {
            if (this._dtStore.length)
            {
                var _loc_9:* = this._dtStore.pop();
                this._tri = this._dtStore.pop();
                this._dtActive.push(_loc_9);
            }
            else
            {
                var _loc_9:* = new RenderTriangle(param1);
                this._tri = new RenderTriangle(param1);
                this._dtActive.push(_loc_9);
            }
            this._tri.instance = this;
            this._tri.triangle = param1;
            this._tri.renderableInstance = param1;
            this._tri.renderer = param2;
            this._tri.create = this.createRenderTriangle;
            this._tri.v0 = param3;
            this._tri.v1 = param4;
            this._tri.v2 = param5;
            this._tri.uv0 = param6;
            this._tri.uv1 = param7;
            this._tri.uv2 = param8;
            this._tri.update();
            return this._tri;
        }// end function

        protected function setScreenZ(param1:uint, param2:Vertex3DInstance, param3:Vertex3DInstance, param4:Vertex3DInstance) : Number
        {
            switch(param1)
            {
                case DisplayObject3D.MESH_SORT_CENTER:
                {
                    return (param2.z + param3.z + param4.z) / 3;
                }
                case DisplayObject3D.MESH_SORT_FAR:
                {
                    return Math.max(param2.z, param3.z, param4.z);
                }
                case DisplayObject3D.MESH_SORT_CLOSE:
                {
                    return Math.min(param2.z, param3.z, param4.z);
                }
                default:
                {
                    break;
                }
            }
            return 0;
        }// end function

        override public function clone() : DisplayObject3D
        {
            var _loc_1:* = super.clone();
            var _loc_2:* = new TriangleMesh3D(this.material, [], [], _loc_1.name);
            if (this.materials)
            {
                _loc_2.materials = this.materials.clone();
            }
            if (_loc_1.geometry)
            {
                _loc_2.geometry = _loc_1.geometry.clone(_loc_2);
            }
            _loc_2.copyTransform(this.transform);
            return _loc_2;
        }// end function

    }
}
