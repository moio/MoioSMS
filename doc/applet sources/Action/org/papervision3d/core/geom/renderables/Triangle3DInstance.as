package org.papervision3d.core.geom.renderables
{
    import flash.display.*;
    import org.papervision3d.core.math.*;
    import org.papervision3d.objects.*;

    public class Triangle3DInstance extends Object
    {
        public var container:Sprite;
        public var instance:DisplayObject3D;
        public var visible:Boolean = false;
        public var faceNormal:Number3D;
        public var screenZ:Number;

        public function Triangle3DInstance(param1:Triangle3D, param2:DisplayObject3D)
        {
            this.instance = param2;
            this.faceNormal = new Number3D();
            return;
        }// end function

    }
}
