package org.papervision3d.view
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import org.papervision3d.core.culling.*;
    import org.papervision3d.core.geom.renderables.*;
    import org.papervision3d.core.log.*;
    import org.papervision3d.core.render.*;
    import org.papervision3d.core.render.command.*;
    import org.papervision3d.core.render.data.*;
    import org.papervision3d.core.utils.*;
    import org.papervision3d.objects.*;
    import org.papervision3d.view.layer.*;

    public class Viewport3D extends Sprite implements IViewport3D
    {
        public var interactiveSceneManager:InteractiveSceneManager;
        public var lastRenderList:Array;
        public var cullingRectangle:Rectangle;
        protected var _interactive:Boolean;
        private var stageScaleModeSet:Boolean = false;
        protected var _autoCulling:Boolean;
        protected var _viewportObjectFilter:ViewportObjectFilter;
        public var particleCuller:IParticleCuller;
        protected var _height:Number;
        protected var _width:Number;
        public var lineCuller:ILineCuller;
        protected var _layerInstances:Dictionary;
        protected var _autoScaleToStage:Boolean;
        public var triangleCuller:ITriangleCuller;
        protected var _lastRenderer:IRenderEngine;
        protected var _hWidth:Number;
        protected var _containerSprite:ViewportBaseLayer;
        protected var _hHeight:Number;
        public var sizeRectangle:Rectangle;
        protected var renderHitData:RenderHitData;
        protected var _autoClipping:Boolean;

        public function Viewport3D(param1:Number = 640, param2:Number = 480, param3:Boolean = false, param4:Boolean = false, param5:Boolean = true, param6:Boolean = true)
        {
            this.init();
            this.interactive = param4;
            this.viewportWidth = param1;
            this.viewportHeight = param2;
            this.autoClipping = param5;
            this.autoCulling = param6;
            this.autoScaleToStage = param3;
            this._layerInstances = new Dictionary(true);
            return;
        }// end function

        public function set viewportWidth(param1:Number) : void
        {
            this._width = param1;
            this._hWidth = param1 / 2;
            this.containerSprite.x = this._hWidth;
            this.cullingRectangle.x = -this._hWidth;
            this.cullingRectangle.width = param1;
            this.sizeRectangle.width = param1;
            if (this._autoClipping)
            {
                scrollRect = this.sizeRectangle;
            }
            return;
        }// end function

        public function get autoCulling() : Boolean
        {
            return this._autoCulling;
        }// end function

        protected function onStageResize(event:Event = null) : void
        {
            if (this._autoScaleToStage)
            {
                this.viewportWidth = stage.stageWidth;
                this.viewportHeight = stage.stageHeight;
            }
            return;
        }// end function

        public function set autoCulling(param1:Boolean) : void
        {
            if (param1)
            {
                this.triangleCuller = new RectangleTriangleCuller(this.cullingRectangle);
                this.particleCuller = new RectangleParticleCuller(this.cullingRectangle);
                this.lineCuller = new RectangleLineCuller(this.cullingRectangle);
            }
            else if (!param1)
            {
                this.triangleCuller = new DefaultTriangleCuller();
                this.particleCuller = new DefaultParticleCuller();
                this.lineCuller = new DefaultLineCuller();
            }
            this._autoCulling = param1;
            return;
        }// end function

        public function getChildLayer(param1:DisplayObject3D, param2:Boolean = true, param3:Boolean = true) : ViewportLayer
        {
            return this.containerSprite.getChildLayer(param1, param2, param3);
        }// end function

        protected function init() : void
        {
            this.renderHitData = new RenderHitData();
            this.lastRenderList = new Array();
            this.sizeRectangle = new Rectangle();
            this.cullingRectangle = new Rectangle();
            this._containerSprite = new ViewportBaseLayer(this);
            this._containerSprite.doubleClickEnabled = true;
            addChild(this._containerSprite);
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            return;
        }// end function

        public function get autoClipping() : Boolean
        {
            return this._autoClipping;
        }// end function

        public function updateAfterRender(param1:RenderSessionData) : void
        {
            var _loc_2:ViewportLayer = null;
            if (this.interactive)
            {
                this.interactiveSceneManager.updateAfterRender();
            }
            if (param1.renderLayers)
            {
                for each (_loc_2 in param1.renderLayers)
                {
                    
                    _loc_2.updateInfo();
                    _loc_2.sortChildLayers();
                    _loc_2.updateAfterRender();
                }
            }
            else
            {
                this.containerSprite.updateInfo();
                this.containerSprite.updateAfterRender();
            }
            this.containerSprite.sortChildLayers();
            return;
        }// end function

        protected function onAddedToStage(event:Event) : void
        {
            if (this._autoScaleToStage)
            {
                this.setStageScaleMode();
            }
            stage.addEventListener(Event.RESIZE, this.onStageResize);
            this.onStageResize();
            return;
        }// end function

        public function get containerSprite() : ViewportLayer
        {
            return this._containerSprite;
        }// end function

        public function set autoClipping(param1:Boolean) : void
        {
            if (param1)
            {
                scrollRect = this.sizeRectangle;
            }
            else
            {
                scrollRect = null;
            }
            this._autoClipping = param1;
            return;
        }// end function

        protected function setStageScaleMode() : void
        {
            if (!this.stageScaleModeSet)
            {
                PaperLogger.info("Viewport autoScaleToStage : Papervision has changed the Stage scale mode.");
                stage.align = StageAlign.TOP_LEFT;
                stage.scaleMode = StageScaleMode.NO_SCALE;
                this.stageScaleModeSet = true;
            }
            return;
        }// end function

        public function accessLayerFor(param1:RenderableListItem, param2:Boolean = false) : ViewportLayer
        {
            var _loc_3:DisplayObject3D = null;
            if (param1.renderableInstance)
            {
                _loc_3 = param1.renderableInstance.instance;
                _loc_3 = _loc_3.parentContainer ? (_loc_3.parentContainer) : (_loc_3);
                if (this.containerSprite.layers[_loc_3])
                {
                    if (param2)
                    {
                        _loc_3.container = this.containerSprite.layers[_loc_3];
                    }
                    return this.containerSprite.layers[_loc_3];
                }
                else if (_loc_3.useOwnContainer)
                {
                    return this.containerSprite.getChildLayer(_loc_3, true, true);
                }
            }
            return this.containerSprite;
        }// end function

        public function get viewportWidth() : Number
        {
            return this._width;
        }// end function

        public function set interactive(param1:Boolean) : void
        {
            if (param1 != this._interactive)
            {
                if (this._interactive && this.interactiveSceneManager)
                {
                    this.interactiveSceneManager.destroy();
                    this.interactiveSceneManager = null;
                }
                this._interactive = param1;
                if (param1)
                {
                    this.interactiveSceneManager = new InteractiveSceneManager(this);
                }
            }
            return;
        }// end function

        public function set viewportObjectFilter(param1:ViewportObjectFilter) : void
        {
            this._viewportObjectFilter = param1;
            return;
        }// end function

        public function set autoScaleToStage(param1:Boolean) : void
        {
            this._autoScaleToStage = param1;
            if (param1 && stage != null)
            {
                this.setStageScaleMode();
                this.onStageResize();
            }
            return;
        }// end function

        public function set viewportHeight(param1:Number) : void
        {
            this._height = param1;
            this._hHeight = param1 / 2;
            this.containerSprite.y = this._hHeight;
            this.cullingRectangle.y = -this._hHeight;
            this.cullingRectangle.height = param1;
            this.sizeRectangle.height = param1;
            if (this._autoClipping)
            {
                scrollRect = this.sizeRectangle;
            }
            return;
        }// end function

        public function updateBeforeRender(param1:RenderSessionData) : void
        {
            var _loc_2:ViewportLayer = null;
            this.lastRenderList.length = 0;
            if (param1.renderLayers)
            {
                for each (_loc_2 in param1.renderLayers)
                {
                    
                    _loc_2.updateBeforeRender();
                }
            }
            else
            {
                this._containerSprite.updateBeforeRender();
            }
            this._layerInstances = new Dictionary(true);
            return;
        }// end function

        public function hitTestMouse() : RenderHitData
        {
            var _loc_1:* = new Point(this.containerSprite.mouseX, this.containerSprite.mouseY);
            return this.hitTestPoint2D(_loc_1);
        }// end function

        public function get interactive() : Boolean
        {
            return this._interactive;
        }// end function

        public function get autoScaleToStage() : Boolean
        {
            return this._autoScaleToStage;
        }// end function

        public function hitTestPointObject(param1:Point, param2:DisplayObject3D) : RenderHitData
        {
            var _loc_3:RenderableListItem = null;
            var _loc_4:RenderHitData = null;
            var _loc_5:IRenderListItem = null;
            var _loc_6:uint = 0;
            if (this.interactive)
            {
                _loc_4 = new RenderHitData();
                _loc_6 = this.lastRenderList.length;
                do
                {
                    
                    if (_loc_5 is RenderableListItem)
                    {
                        _loc_3 = _loc_5 as RenderableListItem;
                        if (_loc_3.renderableInstance is Triangle3D)
                        {
                            if (Triangle3D(_loc_3.renderableInstance).instance != param2)
                            {
                            }
                        }
                        else
                        {
                        }
                        else
                        {
                            _loc_4 = _loc_3.hitTestPoint2D(param1, _loc_4);
                            if (_loc_4.hasHit)
                            {
                                return _loc_4;
                            }
                        }
                    }
                    var _loc_7:* = this.lastRenderList[--_loc_6];
                    _loc_5 = this.lastRenderList[--_loc_6];
                }while (_loc_7)
            }
            return new RenderHitData();
        }// end function

        public function hitTestPoint2D(param1:Point) : RenderHitData
        {
            var _loc_2:RenderableListItem = null;
            var _loc_3:RenderHitData = null;
            var _loc_4:IRenderListItem = null;
            var _loc_5:uint = 0;
            this.renderHitData.clear();
            if (this.interactive)
            {
                _loc_3 = this.renderHitData;
                _loc_5 = this.lastRenderList.length;
                do
                {
                    
                    if (_loc_4 is RenderableListItem)
                    {
                        _loc_2 = _loc_4 as RenderableListItem;
                        _loc_3 = _loc_2.hitTestPoint2D(param1, _loc_3);
                        if (_loc_3.hasHit)
                        {
                            return _loc_3;
                        }
                    }
                    var _loc_6:* = this.lastRenderList[--_loc_5];
                    _loc_4 = this.lastRenderList[--_loc_5];
                }while (_loc_6)
            }
            return this.renderHitData;
        }// end function

        protected function onRemovedFromStage(event:Event) : void
        {
            stage.removeEventListener(Event.RESIZE, this.onStageResize);
            return;
        }// end function

        public function get viewportHeight() : Number
        {
            return this._height;
        }// end function

        public function destroy() : void
        {
            if (this.interactiveSceneManager)
            {
                this.interactiveSceneManager.destroy();
                this.interactiveSceneManager = null;
            }
            this.lastRenderList = null;
            return;
        }// end function

        public function get viewportObjectFilter() : ViewportObjectFilter
        {
            return this._viewportObjectFilter;
        }// end function

    }
}
