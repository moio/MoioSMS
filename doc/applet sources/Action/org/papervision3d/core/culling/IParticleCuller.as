package org.papervision3d.core.culling
{
    import org.papervision3d.core.geom.renderables.*;

    public interface IParticleCuller
    {

        public function IParticleCuller();

        function testParticle(param1:Particle) : Boolean;

    }
}
