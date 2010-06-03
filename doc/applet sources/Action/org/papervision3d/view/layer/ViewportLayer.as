package org.papervision3d.view.layer
{
    import flash.display.*;
    import flash.utils.*;
    import org.papervision3d.core.log.*;
    import org.papervision3d.core.render.command.*;
    import org.papervision3d.objects.*;
    import org.papervision3d.view.*;
    import org.papervision3d.view.layer.util.*;

    public class ViewportLayer extends Sprite
    {
        public var layerIndex:Number;
        public var layers:Dictionary;
        public var childLayers:Array;
        public var weight:Number = 0;
        public var dynamicLayer:Boolean = false;
        public var forceDepth:Boolean = false;
        public var displayObject3D:DisplayObject3D;
        public var sortMode:String;
        protected var viewport:Viewport3D;
        public var displayObjects:Dictionary;
        public var graphicsChannel:Graphics;
        public var originDepth:Number = 0;
        public var screenDepth:Number = 0;

        public function ViewportLayer(param1:Viewport3D, param2:DisplayObject3D, param3:Boolean = false)
        {
            this.layers = new Dictionary(true);
            this.displayObjects = new Dictionary(true);
            this.sortMode = ViewportLayerSortMode.Z_SORT;
            this.viewport = param1;
            this.displayObject3D = param2;
            this.dynamicLayer = param3;
            this.graphicsChannel = this.graphics;
            if (param3)
            {
                this.filters = param2.filters;
                this.blendMode = param2.blendMode;
                this.alpha = param2.alpha;
            }
            if (param2)
            {
                this.addDisplayObject3D(param2);
                param2.container = this;
            }
            this.init();
            return;
        }// end function

        public function removeLayerAt(param1:Number) : void
        {
            var _loc_2:DisplayObject3D = null;
            for each (_loc_2 in this.childLayers[param1].displayObjects)
            {
                
                this.unlinkChild(_loc_2);
            }
            removeChild(this.childLayers[param1]);
            this.childLayers.splice(param1, 1);
            return;
        }// end function

        private function onChildAdded(event:ViewportLayerEvent) : void
        {
            if (event.do3d)
            {
                this.linkChild(event.do3d, event.layer, event);
            }
            return;
        }// end function

        public function addLayer(param1:ViewportLayer) : void
        {
            var _loc_2:DisplayObject3D = null;
            var _loc_3:ViewportLayer = null;
            this.childLayers.push(param1);
            addChild(param1);
            param1.addEventListener(ViewportLayerEvent.CHILD_ADDED, this.onChildAdded);
            param1.addEventListener(ViewportLayerEvent.CHILD_REMOVED, this.onChildRemoved);
            for each (_loc_2 in param1.displayObjects)
            {
                
                this.linkChild(_loc_2, param1);
            }
            for each (_loc_3 in param1.layers)
            {
                
                for each (_loc_2 in _loc_3.displayObjects)
                {
                    
                    this.linkChild(_loc_2, _loc_3);
                }
            }
            return;
        }// end function

        protected function getChildLayerFor(param1:DisplayObject3D, param2:Boolean = false) : ViewportLayer
        {
            var _loc_3:ViewportLayer = null;
            if (param1)
            {
                _loc_3 = new ViewportLayer(this.viewport, param1, param1.useOwnContainer);
                this.addLayer(_loc_3);
                if (param2)
                {
                    param1.addChildrenToLayer(param1, _loc_3);
                }
                return _loc_3;
            }
            else
            {
                PaperLogger.warning("Needs to be a do3d");
            }
            return null;
        }// end function

        public function updateAfterRender() : void
        {
            var _loc_1:ViewportLayer = null;
            for each (_loc_1 in this.childLayers)
            {
                
                _loc_1.updateAfterRender();
            }
            return;
        }// end function

        protected function init() : void
        {
            this.childLayers = new Array();
            return;
        }// end function

        public function clear() : void
        {
            this.graphicsChannel.clear();
            this.reset();
            return;
        }// end function

        public function childLayerIndex(param1:DisplayObject3D) : Number
        {
            param1 = param1.parentContainer ? (param1.parentContainer) : (param1);
            var _loc_2:int = 0;
            while (_loc_2 < this.childLayers.length)
            {
                
                if (this.childLayers[_loc_2].hasDisplayObject3D(param1))
                {
                    return _loc_2;
                }
                _loc_2++;
            }
            return -1;
        }// end function

        protected function reset() : void
        {
            if (!this.forceDepth)
            {
                this.screenDepth = 0;
                this.originDepth = 0;
            }
            this.weight = 0;
            return;
        }// end function

        public function updateInfo() : void
        {
            var _loc_1:ViewportLayer = null;
            for each (_loc_1 in this.childLayers)
            {
                
                _loc_1.updateInfo();
                if (!this.forceDepth)
                {
                    this.weight = this.weight + _loc_1.weight;
                    this.screenDepth = this.screenDepth + _loc_1.screenDepth * _loc_1.weight;
                    this.originDepth = this.originDepth + _loc_1.originDepth * _loc_1.weight;
                }
            }
            if (!this.forceDepth)
            {
                this.screenDepth = this.screenDepth / this.weight;
                this.originDepth = this.originDepth / this.weight;
            }
            return;
        }// end function

        public function getChildLayer(param1:DisplayObject3D, param2:Boolean = true, param3:Boolean = false) : ViewportLayer
        {
            param1 = param1.parentContainer ? (param1.parentContainer) : (param1);
            if (this.layers[param1])
            {
                return this.layers[param1];
            }
            if (param2)
            {
                return this.getChildLayerFor(param1, param3);
            }
            return null;
        }// end function

        protected function orderLayers() : void
        {
            var _loc_2:ViewportLayer = null;
            var _loc_1:int = 0;
            while (_loc_1 < this.childLayers.length)
            {
                
                _loc_2 = this.childLayers[_loc_1];
                if (this.getChildIndex(_loc_2) != _loc_1)
                {
                    this.setChildIndex(_loc_2, _loc_1);
                }
                _loc_2.sortChildLayers();
                _loc_1++;
            }
            return;
        }// end function

        public function updateBeforeRender() : void
        {
            var _loc_1:ViewportLayer = null;
            this.clear();
            for each (_loc_1 in this.childLayers)
            {
                
                _loc_1.updateBeforeRender();
            }
            return;
        }// end function

        public function hasDisplayObject3D(param1:DisplayObject3D) : Boolean
        {
            return this.displayObjects[param1] != null;
        }// end function

        public function sortChildLayers() : void
        {
            switch(this.sortMode)
            {
                case ViewportLayerSortMode.Z_SORT:
                {
                    this.childLayers.sortOn("screenDepth", Array.DESCENDING | Array.NUMERIC);
                    break;
                }
                case ViewportLayerSortMode.INDEX_SORT:
                {
                    this.childLayers.sortOn("layerIndex", Array.NUMERIC);
                    break;
                }
                case ViewportLayerSortMode.ORIGIN_SORT:
                {
                    this.childLayers.sortOn(["originDepth", "screenDepth"], [Array.DESCENDING | Array.NUMERIC, Array.DESCENDING | Array.NUMERIC]);
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.orderLayers();
            return;
        }// end function

        private function onChildRemoved(event:ViewportLayerEvent) : void
        {
            if (event.do3d)
            {
                this.unlinkChild(event.do3d, event);
            }
            return;
        }// end function

        public function removeAllLayers() : void
        {
            while (_loc_1-- >= 0)
            {
                
                this.removeLayerAt(this.childLayers.length--);
            }
            return;
        }// end function

        public function processRenderItem(param1:RenderableListItem) : void
        {
            if (!this.forceDepth)
            {
                this.screenDepth = this.screenDepth + param1.screenZ;
                if (param1.instance)
                {
                    this.originDepth = this.originDepth + param1.instance.world.n34;
                    this.originDepth = this.originDepth + param1.instance.screen.z;
                }
                var _loc_2:String = this;
                _loc_2.weight = this.weight++;
            }
            return;
        }// end function

        public function removeLayer(param1:ViewportLayer) : void
        {
            var _loc_2:* = getChildIndex(param1);
            if (_loc_2 > -1)
            {
                this.removeLayerAt(_loc_2);
            }
            else
            {
                PaperLogger.error("Layer not found for removal.");
            }
            return;
        }// end function

        private function linkChild(param1:DisplayObject3D, param2:ViewportLayer, param3:ViewportLayerEvent = null) : void
        {
            this.layers[param1] = param2;
            dispatchEvent(new ViewportLayerEvent(ViewportLayerEvent.CHILD_ADDED, param1, param2));
            return;
        }// end function

        public function addDisplayObject3D(param1:DisplayObject3D, param2:Boolean = false) : void
        {
            if (!param1)
            {
                return;
            }
            this.displayObjects[param1] = param1;
            dispatchEvent(new ViewportLayerEvent(ViewportLayerEvent.CHILD_ADDED, param1, this));
            if (param2)
            {
                param1.addChildrenToLayer(param1, this);
            }
            return;
        }// end function

        public function removeDisplayObject3D(param1:DisplayObject3D) : void
        {
            this.displayObjects[param1] = null;
            dispatchEvent(new ViewportLayerEvent(ViewportLayerEvent.CHILD_REMOVED, param1, this));
            return;
        }// end function

        private function unlinkChild(param1:DisplayObject3D, param2:ViewportLayerEvent = null) : void
        {
            this.layers[param1] = null;
            dispatchEvent(new ViewportLayerEvent(ViewportLayerEvent.CHILD_REMOVED, param1));
            return;
        }// end function

        public function getLayerObjects(param1:Array = null) : Array
        {
            var _loc_2:DisplayObject3D = null;
            var _loc_3:ViewportLayer = null;
            if (!param1)
            {
                param1 = new Array();
            }
            for each (_loc_2 in this.displayObjects)
            {
                
                if (_loc_2)
                {
                    param1.push(_loc_2);
                }
            }
            for each (_loc_3 in this.childLayers)
            {
                
                _loc_3.getLayerObjects(param1);
            }
            return param1;
        }// end function

    }
}
