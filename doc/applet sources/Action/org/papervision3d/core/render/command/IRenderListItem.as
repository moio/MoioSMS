package org.papervision3d.core.render.command
{
    import flash.display.*;
    import org.papervision3d.core.render.data.*;

    public interface IRenderListItem
    {

        public function IRenderListItem();

        function render(param1:RenderSessionData, param2:Graphics) : void;

    }
}
