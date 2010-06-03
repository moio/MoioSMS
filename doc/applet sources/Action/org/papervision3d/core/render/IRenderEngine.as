package org.papervision3d.core.render
{
    import org.papervision3d.core.proto.*;
    import org.papervision3d.core.render.command.*;
    import org.papervision3d.core.render.data.*;
    import org.papervision3d.view.*;

    public interface IRenderEngine
    {

        public function IRenderEngine();

        function addToRenderList(param1:RenderableListItem) : int;

        function removeFromRenderList(param1:IRenderListItem) : int;

        function renderScene(param1:SceneObject3D, param2:CameraObject3D, param3:Viewport3D) : RenderStatistics;

    }
}
