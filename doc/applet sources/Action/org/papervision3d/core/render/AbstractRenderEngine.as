package org.papervision3d.core.render
{
    import flash.events.*;
    import org.papervision3d.core.proto.*;
    import org.papervision3d.core.render.command.*;
    import org.papervision3d.core.render.data.*;
    import org.papervision3d.view.*;

    public class AbstractRenderEngine extends EventDispatcher implements IRenderEngine
    {

        public function AbstractRenderEngine(param1:IEventDispatcher = null)
        {
            super(param1);
            return;
        }// end function

        public function addToRenderList(param1:RenderableListItem) : int
        {
            return 0;
        }// end function

        public function removeFromRenderList(param1:IRenderListItem) : int
        {
            return 0;
        }// end function

        public function renderScene(param1:SceneObject3D, param2:CameraObject3D, param3:Viewport3D) : RenderStatistics
        {
            return null;
        }// end function

    }
}
