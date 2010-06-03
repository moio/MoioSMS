package org.papervision3d.core.clipping
{
    import org.papervision3d.core.geom.renderables.*;
    import org.papervision3d.core.proto.*;
    import org.papervision3d.core.render.data.*;
    import org.papervision3d.objects.*;

    public class DefaultClipping extends Object
    {

        public function DefaultClipping()
        {
            return;
        }// end function

        public function testFace(param1:Triangle3D, param2:DisplayObject3D, param3:RenderSessionData) : Boolean
        {
            return false;
        }// end function

        public function clipFace(param1:Triangle3D, param2:DisplayObject3D, param3:MaterialObject3D, param4:RenderSessionData, param5:Array) : Number
        {
            return 0;
        }// end function

        public function setDisplayObject(param1:DisplayObject3D, param2:RenderSessionData) : void
        {
            return;
        }// end function

        public function reset(param1:RenderSessionData) : void
        {
            return;
        }// end function

    }
}
