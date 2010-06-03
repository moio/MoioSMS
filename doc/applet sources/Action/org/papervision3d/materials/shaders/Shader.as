package org.papervision3d.materials.shaders
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.utils.*;
    import org.papervision3d.core.geom.renderables.*;
    import org.papervision3d.core.render.data.*;
    import org.papervision3d.core.render.shader.*;
    import org.papervision3d.objects.*;

    public class Shader extends EventDispatcher implements IShader
    {
        protected var layers:Dictionary;
        protected var _blendMode:String = "multiply";
        protected var _filter:BitmapFilter;
        protected var _object:DisplayObject3D;

        public function Shader()
        {
            this.layers = new Dictionary(true);
            return;
        }// end function

        public function set layerBlendMode(param1:String) : void
        {
            this._blendMode = param1;
            return;
        }// end function

        public function setContainerForObject(param1:DisplayObject3D, param2:Sprite) : void
        {
            this.layers[param1] = param2;
            return;
        }// end function

        public function updateAfterRender(param1:RenderSessionData, param2:ShaderObjectData) : void
        {
            return;
        }// end function

        public function set filter(param1:BitmapFilter) : void
        {
            this._filter = param1;
            return;
        }// end function

        public function get layerBlendMode() : String
        {
            return this._blendMode;
        }// end function

        public function get filter() : BitmapFilter
        {
            return this._filter;
        }// end function

        public function destroy() : void
        {
            return;
        }// end function

        public function renderTri(param1:Triangle3D, param2:RenderSessionData, param3:ShaderObjectData, param4:BitmapData) : void
        {
            return;
        }// end function

        public function renderLayer(param1:Triangle3D, param2:RenderSessionData, param3:ShaderObjectData) : void
        {
            return;
        }// end function

    }
}
