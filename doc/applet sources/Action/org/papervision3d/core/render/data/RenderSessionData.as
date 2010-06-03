package org.papervision3d.core.render.data
{
    import flash.display.*;
    import org.papervision3d.core.clipping.*;
    import org.papervision3d.core.culling.*;
    import org.papervision3d.core.proto.*;
    import org.papervision3d.core.render.*;
    import org.papervision3d.view.*;

    public class RenderSessionData extends Object
    {
        public var container:Sprite;
        public var renderer:IRenderEngine;
        public var particleCuller:IParticleCuller;
        public var viewPort:Viewport3D;
        public var triangleCuller:ITriangleCuller;
        public var clipping:DefaultClipping;
        public var scene:SceneObject3D;
        public var renderStatistics:RenderStatistics;
        public var renderObjects:Array;
        public var camera:CameraObject3D;
        public var renderLayers:Array;
        public var quadrantTree:QuadTree;
        public var sorted:Boolean;

        public function RenderSessionData() : void
        {
            this.renderStatistics = new RenderStatistics();
            return;
        }// end function

        public function destroy() : void
        {
            this.triangleCuller = null;
            this.particleCuller = null;
            this.viewPort = null;
            this.container = null;
            this.scene = null;
            this.camera = null;
            this.renderer = null;
            this.renderStatistics = null;
            this.renderObjects = null;
            this.renderLayers = null;
            this.clipping = null;
            this.quadrantTree = null;
            return;
        }// end function

        public function clone() : RenderSessionData
        {
            var _loc_1:* = new RenderSessionData();
            _loc_1.triangleCuller = this.triangleCuller;
            _loc_1.particleCuller = this.particleCuller;
            _loc_1.viewPort = this.viewPort;
            _loc_1.container = this.container;
            _loc_1.scene = this.scene;
            _loc_1.camera = this.camera;
            _loc_1.renderer = this.renderer;
            _loc_1.renderStatistics = this.renderStatistics.clone();
            _loc_1.clipping = this.clipping;
            _loc_1.quadrantTree = this.quadrantTree;
            return _loc_1;
        }// end function

    }
}
