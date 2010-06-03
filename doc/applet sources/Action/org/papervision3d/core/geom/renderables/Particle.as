package org.papervision3d.core.geom.renderables
{
    import flash.geom.*;
    import org.papervision3d.core.render.command.*;
    import org.papervision3d.materials.special.*;

    public class Particle extends AbstractRenderable implements IRenderable
    {
        public var size:Number;
        public var material:ParticleMaterial;
        public var renderScale:Number;
        public var vertex3D:Vertex3D;
        public var renderRect:Rectangle;
        public var renderCommand:RenderParticle;

        public function Particle(param1:ParticleMaterial, param2:Number = 1, param3:Number = 0, param4:Number = 0, param5:Number = 0)
        {
            this.material = param1;
            this.size = param2;
            this.renderCommand = new RenderParticle(this);
            this.renderRect = new Rectangle();
            this.vertex3D = new Vertex3D(param3, param4, param5);
            return;
        }// end function

        public function updateRenderRect() : void
        {
            this.material.updateRenderRect(this);
            return;
        }// end function

        public function get z() : Number
        {
            return this.vertex3D.z;
        }// end function

        public function set z(param1:Number) : void
        {
            this.vertex3D.z = param1;
            return;
        }// end function

        public function set x(param1:Number) : void
        {
            this.vertex3D.x = param1;
            return;
        }// end function

        public function set y(param1:Number) : void
        {
            this.vertex3D.y = param1;
            return;
        }// end function

        public function get x() : Number
        {
            return this.vertex3D.x;
        }// end function

        public function get y() : Number
        {
            return this.vertex3D.y;
        }// end function

        override public function getRenderListItem() : IRenderListItem
        {
            return this.renderCommand;
        }// end function

    }
}
