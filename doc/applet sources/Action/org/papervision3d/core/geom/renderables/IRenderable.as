package org.papervision3d.core.geom.renderables
{
    import org.papervision3d.core.render.command.*;

    public interface IRenderable
    {

        public function IRenderable();

        function getRenderListItem() : IRenderListItem;

    }
}
