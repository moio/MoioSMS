package org.papervision3d.core.geom.renderables
{
    import org.papervision3d.core.geom.*;
    import org.papervision3d.core.render.command.*;
    import org.papervision3d.materials.special.*;

    public class Line3D extends AbstractRenderable implements IRenderable
    {
        public var size:Number;
        public var material:LineMaterial;
        public var cV:Vertex3D;
        public var renderCommand:RenderLine;
        public var v0:Vertex3D;
        public var v1:Vertex3D;

        public function Line3D(param1:Lines3D, param2:LineMaterial, param3:Number, param4:Vertex3D, param5:Vertex3D)
        {
            this.size = param3;
            this.material = param2;
            this.v0 = param4;
            this.v1 = param5;
            this.cV = param5;
            this.instance = param1;
            this.renderCommand = new RenderLine(this);
            return;
        }// end function

        public function addControlVertex(param1:Number, param2:Number, param3:Number) : void
        {
            this.cV = new Vertex3D(param1, param2, param3);
            if (instance.geometry.vertices.indexOf(this.cV) == -1)
            {
                instance.geometry.vertices.push(this.cV);
            }
            this.renderCommand.cV = this.cV.vertex3DInstance;
            return;
        }// end function

        override public function getRenderListItem() : IRenderListItem
        {
            return this.renderCommand;
        }// end function

    }
}
