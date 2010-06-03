package org.papervision3d.core.render.shader
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import org.papervision3d.core.render.data.*;
    import org.papervision3d.materials.shaders.*;

    public class ShaderRenderer extends EventDispatcher implements IShaderRenderer
    {
        public var container:Sprite;
        public var shadeLayers:Dictionary;
        public var outputBitmap:BitmapData;
        public var bitmapContainer:Bitmap;
        public var resizedInput:Boolean = false;
        public var bitmapLayer:Sprite;
        private var _inputBitmapData:BitmapData;

        public function ShaderRenderer()
        {
            this.container = new Sprite();
            this.bitmapLayer = new Sprite();
            this.bitmapContainer = new Bitmap();
            this.bitmapLayer.addChild(this.bitmapContainer);
            this.bitmapLayer.blendMode = BlendMode.NORMAL;
            this.shadeLayers = new Dictionary();
            this.container.addChild(this.bitmapLayer);
            return;
        }// end function

        public function clear() : void
        {
            var _loc_1:Sprite = null;
            for each (_loc_1 in this.shadeLayers)
            {
                
                if (this.inputBitmap && this.inputBitmap.width > 0 && this.inputBitmap.height > 0)
                {
                    _loc_1.graphics.clear();
                    _loc_1.graphics.beginFill(0, 1);
                    _loc_1.graphics.drawRect(0, 0, this.inputBitmap.width, this.inputBitmap.height);
                    _loc_1.graphics.endFill();
                }
            }
            return;
        }// end function

        public function render(param1:RenderSessionData) : void
        {
            if (this.outputBitmap)
            {
                this.outputBitmap.fillRect(this.outputBitmap.rect, 0);
                this.bitmapContainer.bitmapData = this.inputBitmap;
                this.outputBitmap.draw(this.container, null, null, null, this.outputBitmap.rect, false);
                if (this.outputBitmap.transparent)
                {
                    this.outputBitmap.copyChannel(this.inputBitmap, this.outputBitmap.rect, new Point(0, 0), BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
                }
            }
            return;
        }// end function

        public function get inputBitmap() : BitmapData
        {
            return this._inputBitmapData;
        }// end function

        public function set inputBitmap(param1:BitmapData) : void
        {
            if (param1 != null)
            {
                if (this._inputBitmapData != param1)
                {
                    this._inputBitmapData = param1;
                    if (this.outputBitmap)
                    {
                        if (this._inputBitmapData.width != this.outputBitmap.width || this._inputBitmapData.height != this.outputBitmap.height)
                        {
                            this.resizedInput = true;
                            this.outputBitmap.dispose();
                            this.outputBitmap = this._inputBitmapData.clone();
                        }
                    }
                    else
                    {
                        this.resizedInput = true;
                        this.outputBitmap = this._inputBitmapData.clone();
                    }
                }
            }
            return;
        }// end function

        public function getLayerForShader(param1:Shader) : Sprite
        {
            var _loc_2:* = new Sprite();
            this.shadeLayers[param1] = _loc_2;
            var _loc_3:* = new Sprite();
            _loc_2.addChild(_loc_3);
            if (this.inputBitmap != null)
            {
                _loc_3.graphics.beginFill(0, 0);
                _loc_3.graphics.drawRect(0, 0, this.inputBitmap.width, this.inputBitmap.height);
                _loc_3.graphics.endFill();
            }
            this.container.addChild(_loc_2);
            _loc_2.blendMode = param1.layerBlendMode;
            return _loc_2;
        }// end function

        public function destroy() : void
        {
            this.bitmapLayer = null;
            this.outputBitmap.dispose();
            return;
        }// end function

    }
}
