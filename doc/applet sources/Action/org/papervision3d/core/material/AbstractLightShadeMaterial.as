package org.papervision3d.core.material
{
    import flash.utils.*;
    import org.papervision3d.core.math.*;
    import org.papervision3d.core.proto.*;
    import org.papervision3d.core.render.data.*;
    import org.papervision3d.materials.utils.*;
    import org.papervision3d.objects.*;

    public class AbstractLightShadeMaterial extends TriangleMaterial implements ITriangleDrawer, IUpdateBeforeMaterial
    {
        public var lightMatrices:Dictionary;
        private var _light:LightObject3D;
        static var lightMatrix:Matrix3D;

        public function AbstractLightShadeMaterial()
        {
            this.init();
            return;
        }// end function

        public function updateBeforeRender(param1:RenderSessionData) : void
        {
            var _loc_2:Object = null;
            var _loc_3:DisplayObject3D = null;
            for (_loc_2 in objects)
            {
                
                _loc_3 = _loc_2 as DisplayObject3D;
                this.lightMatrices[_loc_2] = LightMatrix.getLightMatrix(this.light, _loc_3, param1, this.lightMatrices[_loc_2]);
            }
            return;
        }// end function

        protected function init() : void
        {
            this.lightMatrices = new Dictionary();
            return;
        }// end function

        public function get light() : LightObject3D
        {
            return this._light;
        }// end function

        public function set light(param1:LightObject3D) : void
        {
            this._light = param1;
            return;
        }// end function

    }
}
