package org.papervision3d.core.culling
{
    import org.papervision3d.core.geom.renderables.*;

    public interface ILineCuller
    {

        public function ILineCuller();

        function testLine(param1:Line3D) : Boolean;

    }
}
