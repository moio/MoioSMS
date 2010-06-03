package org.papervision3d.materials.shaders
{
    import flash.display.*;
    import org.papervision3d.core.geom.renderables.*;
    import org.papervision3d.core.render.data.*;
    import org.papervision3d.core.render.shader.*;

    public interface IShader
    {

        public function IShader();

        function updateAfterRender(param1:RenderSessionData, param2:ShaderObjectData) : void;

        function destroy() : void;

        function renderLayer(param1:Triangle3D, param2:RenderSessionData, param3:ShaderObjectData) : void;

        function renderTri(param1:Triangle3D, param2:RenderSessionData, param3:ShaderObjectData, param4:BitmapData) : void;

    }
}
