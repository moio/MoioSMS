package org.papervision3d.core.utils
{
    import org.papervision3d.core.geom.renderables.*;
    import org.papervision3d.core.math.*;
    import org.papervision3d.core.render.data.*;
    import org.papervision3d.objects.*;

    public class Mouse3D extends DisplayObject3D
    {
        private var target:Number3D;
        public static var enabled:Boolean = false;
        private static var UP:Number3D = new Number3D(0, 1, 0);

        public function Mouse3D() : void
        {
            this.target = new Number3D();
            return;
        }// end function

        public function updatePosition(param1:RenderHitData) : void
        {
            var _loc_5:Number3D = null;
            var _loc_6:Number3D = null;
            var _loc_7:Matrix3D = null;
            var _loc_2:* = param1.renderable as Triangle3D;
            this.target.x = _loc_2.faceNormal.x;
            this.target.y = _loc_2.faceNormal.y;
            this.target.z = _loc_2.faceNormal.z;
            var _loc_3:* = Number3D.sub(this.target, position);
            _loc_3.normalize();
            if (_loc_3.modulo > 0.1)
            {
                _loc_5 = Number3D.cross(_loc_3, UP);
                _loc_5.normalize();
                _loc_6 = Number3D.cross(_loc_3, _loc_5);
                _loc_6.normalize();
                _loc_7 = this.transform;
                _loc_7.n11 = _loc_5.x;
                _loc_7.n21 = _loc_5.y;
                _loc_7.n31 = _loc_5.z;
                _loc_7.n12 = -_loc_6.x;
                _loc_7.n22 = -_loc_6.y;
                _loc_7.n32 = -_loc_6.z;
                _loc_7.n13 = _loc_3.x;
                _loc_7.n23 = _loc_3.y;
                _loc_7.n33 = _loc_3.z;
            }
            var _loc_4:* = Matrix3D.IDENTITY;
            this.transform = Matrix3D.multiply(_loc_2.instance.world, _loc_7);
            x = param1.x;
            y = param1.y;
            z = param1.z;
            return;
        }// end function

    }
}
