package org.papervision3d.render
{
    import flash.geom.*;
    import org.papervision3d.core.clipping.*;
    import org.papervision3d.core.proto.*;
    import org.papervision3d.core.render.*;
    import org.papervision3d.core.render.command.*;
    import org.papervision3d.core.render.data.*;
    import org.papervision3d.core.render.filter.*;
    import org.papervision3d.core.render.material.*;
    import org.papervision3d.core.render.project.*;
    import org.papervision3d.core.render.sort.*;
    import org.papervision3d.core.utils.*;
    import org.papervision3d.events.*;
    import org.papervision3d.view.*;

    public class BasicRenderEngine extends AbstractRenderEngine implements IRenderEngine
    {
        public var clipping:DefaultClipping;
        protected var renderDoneEvent:RendererEvent;
        public var sorter:IRenderSorter;
        public var projectionPipeline:ProjectionPipeline;
        protected var renderList:Array;
        protected var renderStatistics:RenderStatistics;
        protected var cleanRHD:RenderHitData;
        protected var projectionDoneEvent:RendererEvent;
        protected var renderSessionData:RenderSessionData;
        protected var stopWatch:StopWatch;
        public var filter:IRenderFilter;

        public function BasicRenderEngine() : void
        {
            this.cleanRHD = new RenderHitData();
            this.init();
            return;
        }// end function

        protected function doRender(param1:RenderSessionData, param2:Array = null) : RenderStatistics
        {
            var _loc_3:RenderableListItem = null;
            var _loc_5:ViewportLayer = null;
            this.stopWatch.reset();
            this.stopWatch.start();
            MaterialManager.getInstance().updateMaterialsBeforeRender(param1);
            this.filter.filter(this.renderList);
            this.sorter.sort(this.renderList);
            var _loc_4:* = param1.viewPort;
            do
            {
                
                _loc_5 = _loc_4.accessLayerFor(_loc_3, true);
                _loc_3.render(param1, _loc_5.graphicsChannel);
                _loc_4.lastRenderList.push(_loc_3);
                _loc_5.processRenderItem(_loc_3);
                var _loc_6:* = this.renderList.pop();
                _loc_3 = this.renderList.pop();
            }while (_loc_6)
            MaterialManager.getInstance().updateMaterialsAfterRender(param1);
            param1.renderStatistics.renderTime = this.stopWatch.stop();
            param1.viewPort.updateAfterRender(param1);
            return this.renderStatistics;
        }// end function

        protected function init() : void
        {
            this.renderStatistics = new RenderStatistics();
            this.projectionPipeline = new BasicProjectionPipeline();
            this.stopWatch = new StopWatch();
            this.sorter = new BasicRenderSorter();
            this.filter = new BasicRenderFilter();
            this.renderList = new Array();
            this.clipping = null;
            this.renderSessionData = new RenderSessionData();
            this.renderSessionData.renderer = this;
            this.projectionDoneEvent = new RendererEvent(RendererEvent.PROJECTION_DONE, this.renderSessionData);
            this.renderDoneEvent = new RendererEvent(RendererEvent.RENDER_DONE, this.renderSessionData);
            return;
        }// end function

        override public function renderScene(param1:SceneObject3D, param2:CameraObject3D, param3:Viewport3D) : RenderStatistics
        {
            param2.viewport = param3.sizeRectangle;
            this.renderSessionData.scene = param1;
            this.renderSessionData.camera = param2;
            this.renderSessionData.viewPort = param3;
            this.renderSessionData.container = param3.containerSprite;
            this.renderSessionData.triangleCuller = param3.triangleCuller;
            this.renderSessionData.particleCuller = param3.particleCuller;
            this.renderSessionData.renderObjects = param1.objects;
            this.renderSessionData.renderLayers = null;
            this.renderSessionData.renderStatistics.clear();
            this.renderSessionData.clipping = this.clipping;
            if (this.clipping)
            {
                this.clipping.reset(this.renderSessionData);
            }
            param3.updateBeforeRender(this.renderSessionData);
            this.projectionPipeline.project(this.renderSessionData);
            if (hasEventListener(RendererEvent.PROJECTION_DONE))
            {
                dispatchEvent(this.projectionDoneEvent);
            }
            this.doRender(this.renderSessionData, null);
            if (hasEventListener(RendererEvent.RENDER_DONE))
            {
                dispatchEvent(this.renderDoneEvent);
            }
            return this.renderSessionData.renderStatistics;
        }// end function

        public function hitTestPoint2D(param1:Point, param2:Viewport3D) : RenderHitData
        {
            return param2.hitTestPoint2D(param1);
        }// end function

        override public function removeFromRenderList(param1:IRenderListItem) : int
        {
            return this.renderList.splice(this.renderList.indexOf(param1), 1);
        }// end function

        override public function addToRenderList(param1:RenderableListItem) : int
        {
            return this.renderList.push(param1);
        }// end function

        private function getLayerObjects(param1:Array) : Array
        {
            var _loc_3:ViewportLayer = null;
            var _loc_2:* = new Array();
            for each (_loc_3 in param1)
            {
                
                _loc_2 = _loc_2.concat(_loc_3.getLayerObjects());
            }
            return _loc_2;
        }// end function

        public function destroy() : void
        {
            this.renderDoneEvent = null;
            this.projectionDoneEvent = null;
            this.projectionPipeline = null;
            this.sorter = null;
            this.filter = null;
            this.renderStatistics = null;
            this.renderList = null;
            this.renderSessionData.destroy();
            this.renderSessionData = null;
            this.cleanRHD = null;
            this.stopWatch = null;
            this.clipping = null;
            return;
        }// end function

        public function renderLayers(param1:SceneObject3D, param2:CameraObject3D, param3:Viewport3D, param4:Array = null) : RenderStatistics
        {
            this.renderSessionData.scene = param1;
            this.renderSessionData.camera = param2;
            this.renderSessionData.viewPort = param3;
            this.renderSessionData.container = param3.containerSprite;
            this.renderSessionData.triangleCuller = param3.triangleCuller;
            this.renderSessionData.particleCuller = param3.particleCuller;
            this.renderSessionData.renderObjects = this.getLayerObjects(param4);
            this.renderSessionData.renderLayers = param4;
            this.renderSessionData.renderStatistics.clear();
            this.renderSessionData.clipping = this.clipping;
            param3.updateBeforeRender(this.renderSessionData);
            this.projectionPipeline.project(this.renderSessionData);
            if (hasEventListener(RendererEvent.PROJECTION_DONE))
            {
                dispatchEvent(this.projectionDoneEvent);
            }
            this.doRender(this.renderSessionData);
            if (hasEventListener(RendererEvent.RENDER_DONE))
            {
                dispatchEvent(this.renderDoneEvent);
            }
            return this.renderSessionData.renderStatistics;
        }// end function

    }
}
