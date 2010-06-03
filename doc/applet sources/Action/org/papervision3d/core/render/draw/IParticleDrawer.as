package org.papervision3d.core.render.draw
{
    import flash.display.*;
    import org.papervision3d.core.geom.renderables.*;
    import org.papervision3d.core.render.data.*;

    public interface IParticleDrawer
    {

        public function IParticleDrawer();

        function drawParticle(param1:Particle, param2:Graphics, param3:RenderSessionData) : void;

        function updateRenderRect(param1:Particle) : void;

    }
}
