package org.papervision3d.materials.shaders
{
    import org.papervision3d.core.render.data.*;
    import org.papervision3d.core.render.shader.*;

    public interface ILightShader
    {

        public function ILightShader();

        function updateLightMatrix(param1:ShaderObjectData, param2:RenderSessionData) : void;

    }
}
