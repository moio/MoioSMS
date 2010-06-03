package org.papervision3d.core.geom.renderables
{
    import org.papervision3d.core.math.*;
    import org.papervision3d.core.proto.*;
    import org.papervision3d.core.render.command.*;
    import org.papervision3d.materials.*;
    import org.papervision3d.materials.special.*;
    import org.papervision3d.objects.*;

    public class Triangle3D extends AbstractRenderable implements IRenderable
    {
        public var _uvArray:Array;
        public var renderCommand:RenderTriangle;
        public var id:Number;
        public var material:MaterialObject3D;
        public var faceNormal:Number3D;
        public var screenZ:Number;
        public var uv0:NumberUV;
        public var uv1:NumberUV;
        public var _materialName:String;
        public var visible:Boolean;
        public var uv2:NumberUV;
        public var vertices:Array;
        public var v0:Vertex3D;
        public var v1:Vertex3D;
        public var v2:Vertex3D;
        private static var _totalFaces:Number = 0;

        public function Triangle3D(param1:DisplayObject3D, param2:Array, param3:MaterialObject3D = null, param4:Array = null)
        {
            this.instance = param1;
            this.faceNormal = new Number3D();
            if (param2 && param2.length == 3)
            {
                this.vertices = param2;
                this.v0 = param2[0];
                this.v1 = param2[1];
                this.v2 = param2[2];
                this.createNormal();
            }
            else
            {
                param2 = new Array();
                var _loc_5:* = new Vertex3D();
                param2[0] = new Vertex3D();
                this.v0 = _loc_5;
                var _loc_5:* = new Vertex3D();
                param2[1] = new Vertex3D();
                this.v1 = _loc_5;
                var _loc_5:* = new Vertex3D();
                param2[2] = new Vertex3D();
                this.v2 = _loc_5;
            }
            this.material = param3;
            this.uv = param4;
            this.id = _totalFaces++;
            this.renderCommand = new RenderTriangle(this);
            return;
        }// end function

        public function set uv(param1:Array) : void
        {
            if (param1 && param1.length == 3)
            {
                this.uv0 = NumberUV(param1[0]);
                this.uv1 = NumberUV(param1[1]);
                this.uv2 = NumberUV(param1[2]);
            }
            this._uvArray = param1;
            return;
        }// end function

        public function createNormal() : void
        {
            var _loc_1:* = this.v0.getPosition();
            var _loc_2:* = this.v1.getPosition();
            var _loc_3:* = this.v2.getPosition();
            _loc_2.minusEq(_loc_1);
            _loc_3.minusEq(_loc_1);
            this.faceNormal = Number3D.cross(_loc_2, _loc_3, this.faceNormal);
            this.faceNormal.normalize();
            return;
        }// end function

        override public function getRenderListItem() : IRenderListItem
        {
            return this.renderCommand;
        }// end function

        public function reset(param1:DisplayObject3D, param2:Array, param3:MaterialObject3D, param4:Array) : void
        {
            var _loc_5:MaterialObject3D = null;
            this.instance = param1;
            this.renderCommand.instance = param1;
            this.renderCommand.renderer = param3;
            this.vertices = param2;
            this.updateVertices();
            this.material = param3;
            this.uv = param4;
            if (param3 is BitmapMaterial)
            {
                BitmapMaterial(param3).uvMatrices[this.renderCommand] = null;
            }
            if (param3 is CompositeMaterial)
            {
                for each (_loc_5 in CompositeMaterial(param3).materials)
                {
                    
                    if (_loc_5 is BitmapMaterial)
                    {
                        BitmapMaterial(_loc_5).uvMatrices[this.renderCommand] = null;
                    }
                }
            }
            return;
        }// end function

        public function get uv() : Array
        {
            return this._uvArray;
        }// end function

        public function updateVertices() : void
        {
            this.v0 = this.vertices[0];
            this.v1 = this.vertices[1];
            this.v2 = this.vertices[2];
            return;
        }// end function

    }
}
