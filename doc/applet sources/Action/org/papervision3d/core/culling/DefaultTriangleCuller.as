package org.papervision3d.core.culling
{
    import org.papervision3d.core.geom.renderables.*;

    public class DefaultTriangleCuller extends Object implements ITriangleCuller
    {
        static var y2:Number;
        static var y1:Number;
        static var y0:Number;
        static var x0:Number;
        static var x1:Number;
        static var x2:Number;

        public function DefaultTriangleCuller()
        {
            return;
        }// end function

        public function testFace(param1:Triangle3D, param2:Vertex3DInstance, param3:Vertex3DInstance, param4:Vertex3DInstance) : Boolean
        {
            var _loc_5:MaterialObject3D = null;
            if (param2.visible && param3.visible && param4.visible)
            {
                _loc_5 = param1.material ? (param1.material) : (param1.instance.material);
                if (_loc_5.invisible)
                {
                    return false;
                }
                x0 = param2.x;
                y0 = param2.y;
                x1 = param3.x;
                y1 = param3.y;
                x2 = param4.x;
                y2 = param4.y;
                if (_loc_5.oneSide)
                {
                    if (_loc_5.opposite)
                    {
                        if ((x2 - x0) * (y1 - y0) - (y2 - y0) * (x1 - x0) > 0)
                        {
                            return false;
                        }
                    }
                    else if ((x2 - x0) * (y1 - y0) - (y2 - y0) * (x1 - x0) < 0)
                    {
                        return false;
                    }
                }
                return true;
            }
            return false;
        }// end function

    }
}
