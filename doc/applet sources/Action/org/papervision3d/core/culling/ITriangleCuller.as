package org.papervision3d.core.culling
{
    import org.papervision3d.core.geom.renderables.*;

    public interface ITriangleCuller
    {

        public function ITriangleCuller();

        function testFace(param1:Triangle3D, param2:Vertex3DInstance, param3:Vertex3DInstance, param4:Vertex3DInstance) : Boolean;

    }
}
