package org.papervision3d.core.culling
{
    import flash.geom.*;
    import org.papervision3d.core.geom.renderables.*;
    import org.papervision3d.core.math.util.*;

    public class RectangleParticleCuller extends Object implements IParticleCuller
    {
        public var cullingRectangle:Rectangle;
        private static var vInstance:Vertex3DInstance;
        private static var testPoint:Point;

        public function RectangleParticleCuller(param1:Rectangle = null)
        {
            this.cullingRectangle = param1;
            testPoint = new Point();
            return;
        }// end function

        public function testParticle(param1:Particle) : Boolean
        {
            vInstance = param1.vertex3D.vertex3DInstance;
            if (param1.material.invisible == false)
            {
                if (vInstance.visible)
                {
                    if (FastRectangleTools.intersects(param1.renderRect, this.cullingRectangle))
                    {
                        return true;
                    }
                }
            }
            return false;
        }// end function

    }
}
