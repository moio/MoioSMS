package org.papervision3d.core.render.shader
{
    import flash.display.*;
    import org.papervision3d.core.render.data.*;
    import org.papervision3d.materials.shaders.*;

    public interface IShaderRenderer
    {

        public function IShaderRenderer();

        function destroy() : void;

        function getLayerForShader(param1:Shader) : Sprite;

        function clear() : void;

        function render(param1:RenderSessionData) : void;

    }
}
