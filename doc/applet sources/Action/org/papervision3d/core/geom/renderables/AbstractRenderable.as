package org.papervision3d.core.geom.renderables
{
    import org.papervision3d.core.data.*;
    import org.papervision3d.core.render.command.*;
    import org.papervision3d.objects.*;

    public class AbstractRenderable extends Object implements IRenderable
    {
        public var _userData:UserData;
        public var instance:DisplayObject3D;

        public function AbstractRenderable()
        {
            return;
        }// end function

        public function set userData(param1:UserData) : void
        {
            this._userData = param1;
            return;
        }// end function

        public function get userData() : UserData
        {
            return this._userData;
        }// end function

        public function getRenderListItem() : IRenderListItem
        {
            return null;
        }// end function

    }
}
