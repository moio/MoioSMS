package org.papervision3d.core.culling
{
    import org.papervision3d.core.geom.renderables.*;

    public class DefaultLineCuller extends Object implements ILineCuller
    {

        public function DefaultLineCuller()
        {
            return;
        }// end function

        public function testLine(param1:Line3D) : Boolean
        {
            if (param1.v0.vertex3DInstance.visible)
            {
            }
            return param1.v1.vertex3DInstance.visible;
        }// end function

    }
}
