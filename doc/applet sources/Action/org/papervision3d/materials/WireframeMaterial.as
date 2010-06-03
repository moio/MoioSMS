package org.papervision3d.materials
{
    import flash.display.*;
    import flash.geom.*;
    import org.papervision3d.core.material.*;
    import org.papervision3d.core.render.command.*;
    import org.papervision3d.core.render.data.*;

    public class WireframeMaterial extends TriangleMaterial implements ITriangleDrawer
    {

        public function WireframeMaterial(param1:Number = 16711935, param2:Number = 100, param3:Number = 0)
        {
            this.lineColor = param1;
            this.lineAlpha = param2;
            this.lineThickness = param3;
            this.doubleSided = false;
            return;
        }// end function

        override public function toString() : String
        {
            return "WireframeMaterial - color:" + this.lineColor + " alpha:" + this.lineAlpha;
        }// end function

        override public function drawTriangle(param1:RenderTriangle, param2:Graphics, param3:RenderSessionData, param4:BitmapData = null, param5:Matrix = null) : void
        {
            var _loc_6:* = param1.v0.x;
            var _loc_7:* = param1.v0.y;
            if (lineAlpha)
            {
                param2.lineStyle(lineThickness, lineColor, lineAlpha);
                param2.moveTo(_loc_6, _loc_7);
                param2.lineTo(param1.v1.x, param1.v1.y);
                param2.lineTo(param1.v2.x, param1.v2.y);
                param2.lineTo(_loc_6, _loc_7);
                param2.lineStyle();
                var _loc_8:* = param3.renderStatistics;
                _loc_8.triangles = param3.renderStatistics.triangles++;
            }
            return;
        }// end function

    }
}
