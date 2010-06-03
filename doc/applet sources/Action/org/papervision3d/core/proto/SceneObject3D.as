package org.papervision3d.core.proto
{
    import org.papervision3d.*;
    import org.papervision3d.core.log.*;
    import org.papervision3d.materials.utils.*;
    import org.papervision3d.objects.*;

    public class SceneObject3D extends DisplayObjectContainer3D
    {
        public var objects:Array;
        public var materials:MaterialsList;

        public function SceneObject3D()
        {
            this.objects = new Array();
            this.materials = new MaterialsList();
            PaperLogger.info(Papervision3D.NAME + " " + Papervision3D.VERSION + " (" + Papervision3D.DATE + ")\n");
            this.root = this;
            return;
        }// end function

        override public function removeChild(param1:DisplayObject3D) : DisplayObject3D
        {
            super.removeChild(param1);
            var _loc_2:int = 0;
            while (_loc_2 < this.objects.length)
            {
                
                if (this.objects[_loc_2] === param1)
                {
                    this.objects.splice(_loc_2, 1);
                    return param1;
                }
                _loc_2++;
            }
            return param1;
        }// end function

        override public function addChild(param1:DisplayObject3D, param2:String = null) : DisplayObject3D
        {
            var _loc_3:* = super.addChild(param1, param2 ? (param2) : (param1.name));
            param1.scene = this;
            param1.parent = null;
            this.objects.push(_loc_3);
            return _loc_3;
        }// end function

    }
}
