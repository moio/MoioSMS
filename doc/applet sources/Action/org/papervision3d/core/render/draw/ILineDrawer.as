package org.papervision3d.core.render.draw
{
    import flash.display.*;
    import org.papervision3d.core.render.command.*;
    import org.papervision3d.core.render.data.*;

    public interface ILineDrawer
    {

        public function ILineDrawer();

        function drawLine(param1:RenderLine, param2:Graphics, param3:RenderSessionData) : void;

    }
}
