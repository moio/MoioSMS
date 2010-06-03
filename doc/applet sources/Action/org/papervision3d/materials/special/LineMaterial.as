package org.papervision3d.materials.special
{
    import flash.display.*;
    import org.papervision3d.core.proto.*;
    import org.papervision3d.core.render.command.*;
    import org.papervision3d.core.render.data.*;

    public class LineMaterial extends MaterialObject3D implements ILineDrawer
    {

        public function LineMaterial(param1:Number = 16711680, param2:Number = 1)
        {
            this.lineColor = param1;
            this.lineAlpha = param2;
            return;
        }// end function

        public function drawLine(param1:RenderLine, param2:Graphics, param3:RenderSessionData) : void
        {
            param2.lineStyle(param1.size, lineColor, lineAlpha);
            param2.moveTo(param1.v0.x, param1.v0.y);
            if (param1.cV)
            {
                param2.curveTo(param1.cV.x, param1.cV.y, param1.v1.x, param1.v1.y);
            }
            else
            {
                param2.lineTo(param1.v1.x, param1.v1.y);
            }
            param2.moveTo(0, 0);
            param2.lineStyle();
            return;
        }// end function

    }
}
