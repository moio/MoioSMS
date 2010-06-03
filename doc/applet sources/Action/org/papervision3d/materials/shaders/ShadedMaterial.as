package org.papervision3d.materials.shaders
{
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;
    import org.papervision3d.core.log.*;
    import org.papervision3d.core.material.*;
    import org.papervision3d.core.render.command.*;
    import org.papervision3d.core.render.data.*;
    import org.papervision3d.core.render.shader.*;
    import org.papervision3d.materials.*;
    import org.papervision3d.objects.*;

    public class ShadedMaterial extends TriangleMaterial implements ITriangleDrawer, IUpdateBeforeMaterial, IUpdateAfterMaterial
    {
        public var shader:Shader;
        private var _shaderCompositeMode:int;
        public var material:BitmapMaterial;
        public var shaderObjectData:Dictionary;
        private static var bmp:BitmapData;

        public function ShadedMaterial(param1:BitmapMaterial, param2:Shader, param3:int = 0)
        {
            this.shader = param2;
            this.material = param1;
            this.shaderCompositeMode = param3;
            this.init();
            return;
        }// end function

        override public function registerObject(param1:DisplayObject3D) : void
        {
            super.registerObject(param1);
            var _loc_3:* = new ShaderObjectData(param1, this.material, this);
            this.shaderObjectData[param1] = new ShaderObjectData(param1, this.material, this);
            var _loc_2:* = _loc_3;
            _loc_2.shaderRenderer.inputBitmap = this.material.bitmap;
            this.shader.setContainerForObject(param1, _loc_2.shaderRenderer.getLayerForShader(this.shader));
            return;
        }// end function

        public function updateAfterRender(param1:RenderSessionData) : void
        {
            var _loc_2:ShaderObjectData = null;
            for each (_loc_2 in this.shaderObjectData)
            {
                
                this.shader.updateAfterRender(param1, _loc_2);
                if (this.shaderCompositeMode == ShaderCompositeModes.PER_LAYER)
                {
                    _loc_2.shaderRenderer.render(param1);
                }
            }
            return;
        }// end function

        override public function drawTriangle(param1:RenderTriangle, param2:Graphics, param3:RenderSessionData, param4:BitmapData = null, param5:Matrix = null) : void
        {
            var _loc_6:* = ShaderObjectData(this.shaderObjectData[param1.renderableInstance.instance]);
            if (this.shaderCompositeMode == ShaderCompositeModes.PER_LAYER)
            {
                this.material.drawTriangle(param1, param2, param3, _loc_6.shaderRenderer.outputBitmap);
                this.shader.renderLayer(param1.triangle, param3, _loc_6);
            }
            else if (this.shaderCompositeMode == ShaderCompositeModes.PER_TRIANGLE_IN_BITMAP)
            {
                bmp = _loc_6.getOutputBitmapFor(param1.triangle);
                this.material.drawTriangle(param1, param2, param3, bmp, _loc_6.triangleUVS[param1.triangle] ? (_loc_6.triangleUVS[param1.triangle]) : (_loc_6.getPerTriUVForDraw(param1.triangle)));
                this.shader.renderTri(param1.triangle, param3, _loc_6, bmp);
            }
            return;
        }// end function

        private function init() : void
        {
            this.shaderObjectData = new Dictionary();
            return;
        }// end function

        public function set shaderCompositeMode(param1:int) : void
        {
            this._shaderCompositeMode = param1;
            return;
        }// end function

        public function get shaderCompositeMode() : int
        {
            return this._shaderCompositeMode;
        }// end function

        public function getOutputBitmapDataFor(param1:DisplayObject3D) : BitmapData
        {
            var _loc_2:ShaderObjectData = null;
            if (this.shaderCompositeMode == ShaderCompositeModes.PER_LAYER)
            {
                if (this.shaderObjectData[param1])
                {
                    _loc_2 = ShaderObjectData(this.shaderObjectData[param1]);
                    return _loc_2.shaderRenderer.outputBitmap;
                }
                PaperLogger.warning("object not registered with shaded material");
            }
            else
            {
                PaperLogger.warning("getOutputBitmapDataFor only works on per layer mode");
            }
            return null;
        }// end function

        override public function destroy() : void
        {
            var _loc_1:ShaderObjectData = null;
            super.destroy();
            for each (_loc_1 in this.shaderObjectData)
            {
                
                _loc_1.destroy();
            }
            this.material = null;
            this.shader = null;
            return;
        }// end function

        override public function unregisterObject(param1:DisplayObject3D) : void
        {
            super.unregisterObject(param1);
            var _loc_2:* = this.shaderObjectData[param1];
            _loc_2.destroy();
            delete this.shaderObjectData[param1];
            return;
        }// end function

        public function updateBeforeRender(param1:RenderSessionData) : void
        {
            var _loc_2:ShaderObjectData = null;
            var _loc_3:ILightShader = null;
            for each (_loc_2 in this.shaderObjectData)
            {
                
                _loc_2.shaderRenderer.inputBitmap = this.material.bitmap;
                if (this.shaderCompositeMode == ShaderCompositeModes.PER_LAYER)
                {
                    if (_loc_2.shaderRenderer.resizedInput)
                    {
                        _loc_2.shaderRenderer.resizedInput = false;
                        _loc_2.uvMatrices = new Dictionary();
                    }
                    _loc_2.shaderRenderer.clear();
                }
                if (this.shader is ILightShader)
                {
                    _loc_3 = this.shader as ILightShader;
                    _loc_3.updateLightMatrix(_loc_2, param1);
                }
            }
            return;
        }// end function

    }
}
