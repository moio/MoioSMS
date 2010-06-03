package ws.tink.flex.pv3dEffects.effectClasses
{
    import flash.display.*;
    import flash.geom.*;
    import mx.core.*;
    import mx.effects.effectClasses.*;
    import mx.events.*;
    import org.papervision3d.cameras.*;
    import org.papervision3d.core.proto.*;
    import org.papervision3d.core.render.material.*;
    import org.papervision3d.materials.*;
    import org.papervision3d.objects.*;
    import org.papervision3d.render.*;
    import org.papervision3d.scenes.*;
    import org.papervision3d.view.*;
    import ws.tink.flex.managers.*;
    import ws.tink.flex.pv3dEffects.*;

    public class EffectInstance extends TweenEffectInstance
    {
        public var hideMethod:String;
        protected var _camera:Camera3D;
        protected var _viewport:Viewport3D;
        protected var _from:Array;
        protected var _display:UIComponent;
        protected var _scene:Scene3D;
        public var transparent:Boolean;
        protected var _bitmapDatas:Array;
        protected var _to:Array;
        protected var _renderer:BasicRenderEngine;
        protected var _materials:Array;
        protected var _root3D:DisplayObject3D;

        public function EffectInstance(param1:UIComponent)
        {
            super(param1);
            this.initialize();
            return;
        }// end function

        public function get display() : UIComponent
        {
            return this._display;
        }// end function

        protected function initialize() : void
        {
            var _loc_1:* = target.parent.localToGlobal(new Point(target.x, target.y));
            this._display = new UIComponent();
            this._display.addEventListener(FlexEvent.CREATION_COMPLETE, this.onDisplayCreationComplete);
            this._display.x = _loc_1.x;
            this._display.y = _loc_1.y;
            this._display.mouseEnabled = false;
            this._display.mouseChildren = false;
            this._display.visible = target.visible;
            this._scene = new Scene3D();
            this._viewport = new Viewport3D(target.width, target.height, false, false);
            this._display.addChild(this._viewport);
            this._viewport.containerSprite.cacheAsBitmap = false;
            this._camera = new Camera3D();
            this._camera.zoom = 2;
            this._camera.focus = 500;
            this._root3D = this._scene.addChild(new DisplayObject3D("_root3D"));
            this._renderer = new BasicRenderEngine();
            EffectManager.effectManager.addEffect(this);
            return;
        }// end function

        protected function disposeBitmapDatas() : void
        {
            var _loc_1:BitmapData = null;
            if (!this._bitmapDatas)
            {
                this._bitmapDatas = new Array();
            }
            var _loc_2:* = this._bitmapDatas.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_1 = BitmapData(this._bitmapDatas.shift());
                _loc_1.dispose();
                _loc_3++;
            }
            this._bitmapDatas = new Array();
            return;
        }// end function

        protected function createMaterials() : void
        {
            this._materials = new Array();
            var _loc_1:* = new BitmapMaterial(BitmapData(this._bitmapDatas[0]));
            _loc_1.doubleSided = false;
            this._materials.push(_loc_1);
            return;
        }// end function

        private function onDisplayCreationComplete(event:FlexEvent) : void
        {
            dispatchEvent(event);
            return;
        }// end function

        private function setTargetVisible(param1:Boolean) : void
        {
            switch(this.hideMethod)
            {
                case Effect.HIDE_METHOD_BLEND_MODE:
                {
                    target.blendMode = param1 ? (BlendMode.NORMAL) : (BlendMode.ERASE);
                    break;
                }
                case Effect.HIDE_METHOD_ALPHA:
                {
                    target.alpha = param1 ? (1) : (0);
                    break;
                }
                case Effect.HIDE_METHOD_NONE:
                {
                    break;
                }
                default:
                {
                    throw new Error("EffectInstance: hideMethod \'" + this.hideMethod + "\' not supported");
                    break;
                }
            }
            return;
        }// end function

        protected function createPropertiesToTween() : void
        {
            return;
        }// end function

        override public function onTweenEnd(param1:Object) : void
        {
            super.onTweenEnd(param1);
            this.setTargetVisible(true);
            var _loc_2:* = mx.effects::EffectManager;
            _loc_2.mx_internal::endBitmapEffect(UIComponent(target));
            return;
        }// end function

        override public function onTweenUpdate(param1:Object) : void
        {
            var value:* = param1;
            mx.effects::EffectManager.suspendEventHandling();
            try
            {
                this._renderer.renderScene(this._scene, this._camera, this._viewport);
            }
            catch (e:Error)
            {
            }
            mx.effects::EffectManager.resumeEventHandling();
            return;
        }// end function

        public function destroy() : void
        {
            var _loc_1:int = 0;
            var _loc_3:BitmapData = null;
            var _loc_4:int = 0;
            if (this._scene == null)
            {
                return;
            }
            this._scene.removeChild(this._root3D);
            this._scene.materials = null;
            this._display.removeChild(this._viewport);
            this._renderer.destroy();
            this._viewport.destroy();
            if (this._bitmapDatas.length)
            {
                _loc_4 = this._bitmapDatas.length;
                _loc_1 = 0;
                while (_loc_1 < _loc_4)
                {
                    
                    _loc_3 = BitmapData(this._bitmapDatas.shift());
                    _loc_3.dispose();
                    _loc_1++;
                }
            }
            var _loc_2:Number = 0;
            while (_loc_2++ < this._materials.length)
            {
                
                MaterialManager.unRegisterMaterial(this._materials[_loc_2]);
                MaterialObject3D(this._materials[_loc_2]).destroy();
            }
            this._root3D = null;
            this._scene = null;
            this._camera = null;
            this._display = null;
            this._renderer = null;
            this._viewport = null;
            this._bitmapDatas = null;
            this._materials = null;
            return;
        }// end function

        override public function play() : void
        {
            var _loc_1:* = mx.effects::EffectManager;
            _loc_1.mx_internal::startBitmapEffect(UIComponent(target));
            this.createBitmapDatas();
            this.createMaterials();
            this.createDisplayObject3Ds();
            this._renderer.renderScene(this._scene, this._camera, this._viewport);
            super.play();
            this.setTargetVisible(false);
            this.createPropertiesToTween();
            createTween(this, this._from, this._to, duration);
            this.display.visible = target.parent.visible;
            return;
        }// end function

        protected function createDisplayObject3Ds() : void
        {
            return;
        }// end function

        protected function createBitmapDatas() : void
        {
            var _loc_2:BitmapData = null;
            this._bitmapDatas = new Array();
            var _loc_1:* = this.transparent ? (0) : (0);
            _loc_2 = new BitmapData(target.width, target.height, this.transparent, _loc_1);
            _loc_2.draw(IBitmapDrawable(target));
            this._bitmapDatas.push(_loc_2);
            return;
        }// end function

    }
}
