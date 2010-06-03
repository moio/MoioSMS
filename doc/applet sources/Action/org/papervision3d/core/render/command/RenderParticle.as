package org.papervision3d.core.render.command
{
    import flash.display.*;
    import flash.geom.*;
    import org.papervision3d.core.geom.renderables.*;
    import org.papervision3d.core.render.data.*;
    import org.papervision3d.materials.special.*;

    public class RenderParticle extends RenderableListItem implements IRenderListItem
    {
        public var renderMat:ParticleMaterial;
        public var particle:Particle;

        public function RenderParticle(param1:Particle)
        {
            this.particle = param1;
            this.renderableInstance = param1;
            this.renderable = Particle;
            this.instance = param1.instance;
            return;
        }// end function

        override public function render(param1:RenderSessionData, param2:Graphics) : void
        {
            this.particle.material.drawParticle(this.particle, param2, param1);
            return;
        }// end function

        override public function hitTestPoint2D(param1:Point, param2:RenderHitData) : RenderHitData
        {
            this.renderMat = this.particle.material;
            if (this.renderMat.interactive)
            {
                if (this.particle.renderRect.contains(param1.x, param1.y))
                {
                    param2.displayObject3D = this.particle.instance;
                    param2.material = this.renderMat;
                    param2.renderable = this.particle;
                    param2.hasHit = true;
                    param2.x = this.particle.x;
                    param2.y = this.particle.y;
                    param2.z = this.particle.z;
                    param2.u = 0;
                    param2.v = 0;
                    return param2;
                }
            }
            return param2;
        }// end function

    }
}
