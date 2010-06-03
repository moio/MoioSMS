package org.papervision3d.core.render.material
{
    import org.papervision3d.core.render.data.*;

    public interface IUpdateAfterMaterial
    {

        public function IUpdateAfterMaterial();

        function updateAfterRender(param1:RenderSessionData) : void;

    }
}
