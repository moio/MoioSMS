package org.papervision3d.core.culling
{
    import org.papervision3d.objects.*;

    public interface IObjectCuller
    {

        public function IObjectCuller();

        function testObject(param1:DisplayObject3D) : int;

    }
}
