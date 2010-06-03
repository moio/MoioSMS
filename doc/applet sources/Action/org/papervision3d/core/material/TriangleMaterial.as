package org.papervision3d.core.material
{
    import flash.display.*;
    import flash.geom.*;
    import org.papervision3d.core.proto.*;
    import org.papervision3d.core.render.command.*;
    import org.papervision3d.core.render.data.*;

    public class TriangleMaterial extends MaterialObject3D implements ITriangleDrawer
    {

        public function TriangleMaterial()
        {
            return;
        }// end function

        override public function drawTriangle(param1:RenderTriangle, param2:Graphics, param3:RenderSessionData, param4:BitmapData = null, param5:Matrix = null) : void
        {
            return;
        }// end function

        override public function drawRT(param1:RenderTriangle, param2:Graphics, param3:RenderSessionData) : void
        {
            return;
        }// end function

    }
}
