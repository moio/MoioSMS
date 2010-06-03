package org.papervision3d.view.layer
{
    import flash.events.*;
    import org.papervision3d.objects.*;

    public class ViewportLayerEvent extends Event
    {
        public var layer:ViewportLayer;
        public var do3d:DisplayObject3D;
        public static const CHILD_REMOVED:String = "childRemoved";
        public static const CHILD_ADDED:String = "childAdded";

        public function ViewportLayerEvent(param1:String, param2:DisplayObject3D = null, param3:ViewportLayer = null)
        {
            super(param1, false, false);
            this.do3d = param2;
            this.layer = param3;
            return;
        }// end function

    }
}
