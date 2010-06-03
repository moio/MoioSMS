package org.papervision3d.materials.special
{
    import flash.display.*;
    import flash.geom.*;
    import org.papervision3d.core.material.*;
    import org.papervision3d.core.proto.*;
    import org.papervision3d.core.render.command.*;
    import org.papervision3d.core.render.data.*;
    import org.papervision3d.objects.*;

    public class CompositeMaterial extends TriangleMaterial implements ITriangleDrawer
    {
        public var materials:Array;

        public function CompositeMaterial()
        {
            this.init();
            return;
        }// end function

        private function init() : void
        {
            this.materials = new Array();
            return;
        }// end function

        override public function registerObject(param1:DisplayObject3D) : void
        {
            var _loc_2:MaterialObject3D = null;
            super.registerObject(param1);
            for each (_loc_2 in this.materials)
            {
                
                _loc_2.registerObject(param1);
            }
            return;
        }// end function

        override public function drawTriangle(param1:RenderTriangle, param2:Graphics, param3:RenderSessionData, param4:BitmapData = null, param5:Matrix = null) : void
        {
            var _loc_6:MaterialObject3D = null;
            for each (_loc_6 in this.materials)
            {
                
                if (!_loc_6.invisible)
                {
                    _loc_6.drawTriangle(param1, param2, param3);
                }
            }
            return;
        }// end function

        public function removeAllMaterials() : void
        {
            this.materials = new Array();
            return;
        }// end function

        override public function unregisterObject(param1:DisplayObject3D) : void
        {
            var _loc_2:MaterialObject3D = null;
            super.unregisterObject(param1);
            for each (_loc_2 in this.materials)
            {
                
                _loc_2.unregisterObject(param1);
            }
            return;
        }// end function

        public function removeMaterial(param1:MaterialObject3D) : void
        {
            this.materials.splice(this.materials.indexOf(param1), 1);
            return;
        }// end function

        public function addMaterial(param1:MaterialObject3D) : void
        {
            var _loc_2:Object = null;
            var _loc_3:DisplayObject3D = null;
            this.materials.push(param1);
            for (_loc_2 in objects)
            {
                
                _loc_3 = _loc_2 as DisplayObject3D;
                param1.registerObject(_loc_3);
            }
            return;
        }// end function

    }
}
