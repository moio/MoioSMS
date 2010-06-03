package org.papervision3d.core.render.draw
{
    import flash.display.*;
    import flash.geom.*;
    import org.papervision3d.core.render.command.*;
    import org.papervision3d.core.render.data.*;

    public interface ITriangleDrawer
    {

        public function ITriangleDrawer();

        function drawTriangle(param1:RenderTriangle, param2:Graphics, param3:RenderSessionData, param4:BitmapData = null, param5:Matrix = null) : void;

        function drawRT(param1:RenderTriangle, param2:Graphics, param3:RenderSessionData) : void;

    }
}
