package org.papervision3d.core.render.material
{
    import flash.utils.*;
    import org.papervision3d.core.proto.*;
    import org.papervision3d.core.render.data.*;

    public class MaterialManager extends Object
    {
        private var materials:Dictionary;
        private static var instance:MaterialManager;

        public function MaterialManager() : void
        {
            if (instance)
            {
                throw new Error("Only 1 instance of materialmanager allowed");
            }
            this.init();
            return;
        }// end function

        private function init() : void
        {
            this.materials = new Dictionary(true);
            return;
        }// end function

        private function _unRegisterMaterial(param1:MaterialObject3D) : void
        {
            delete this.materials[param1];
            return;
        }// end function

        public function updateMaterialsAfterRender(param1:RenderSessionData) : void
        {
            var _loc_2:IUpdateAfterMaterial = null;
            var _loc_3:* = undefined;
            for (_loc_3 in this.materials)
            {
                
                if (_loc_3 is IUpdateAfterMaterial)
                {
                    _loc_2 = _loc_3 as IUpdateAfterMaterial;
                    _loc_2.updateAfterRender(param1);
                }
            }
            return;
        }// end function

        private function _registerMaterial(param1:MaterialObject3D) : void
        {
            this.materials[param1] = true;
            return;
        }// end function

        public function updateMaterialsBeforeRender(param1:RenderSessionData) : void
        {
            var _loc_2:IUpdateBeforeMaterial = null;
            var _loc_3:* = undefined;
            for (_loc_3 in this.materials)
            {
                
                if (_loc_3 is IUpdateBeforeMaterial)
                {
                    _loc_2 = _loc_3 as IUpdateBeforeMaterial;
                    if (_loc_2.isUpdateable())
                    {
                        _loc_2.updateBeforeRender(param1);
                    }
                }
            }
            return;
        }// end function

        public static function getInstance() : MaterialManager
        {
            if (!instance)
            {
                instance = new MaterialManager;
            }
            return instance;
        }// end function

        public static function unRegisterMaterial(param1:MaterialObject3D) : void
        {
            getInstance()._unRegisterMaterial(param1);
            return;
        }// end function

        public static function registerMaterial(param1:MaterialObject3D) : void
        {
            getInstance()._registerMaterial(param1);
            return;
        }// end function

    }
}
