package org.papervision3d.core.render.data
{

    public class RenderStatistics extends Object
    {
        public var renderTime:int = 0;
        public var culledObjects:int = 0;
        public var shadedTriangles:int = 0;
        public var culledParticles:int = 0;
        public var culledTriangles:int = 0;
        public var triangles:int = 0;
        public var particles:int = 0;
        public var rendered:int = 0;
        public var projectionTime:int = 0;
        public var filteredObjects:int = 0;
        public var lines:int = 0;

        public function RenderStatistics()
        {
            return;
        }// end function

        public function clear() : void
        {
            this.projectionTime = 0;
            this.renderTime = 0;
            this.rendered = 0;
            this.particles = 0;
            this.triangles = 0;
            this.culledTriangles = 0;
            this.culledParticles = 0;
            this.lines = 0;
            this.shadedTriangles = 0;
            this.filteredObjects = 0;
            this.culledObjects = 0;
            return;
        }// end function

        public function clone() : RenderStatistics
        {
            var _loc_1:* = new RenderStatistics();
            _loc_1.projectionTime = this.projectionTime;
            _loc_1.renderTime = this.renderTime;
            _loc_1.rendered = this.rendered;
            _loc_1.particles = this.particles;
            _loc_1.triangles = this.triangles;
            _loc_1.culledTriangles = this.culledTriangles;
            _loc_1.lines = this.lines;
            _loc_1.shadedTriangles = this.shadedTriangles;
            _loc_1.filteredObjects = this.filteredObjects;
            _loc_1.culledObjects = this.culledObjects;
            return _loc_1;
        }// end function

        public function toString() : String
        {
            return new String("ProjectionTime:" + this.projectionTime + " RenderTime:" + this.renderTime + " Particles:" + this.particles + " CulledParticles :" + this.culledParticles + " Triangles:" + this.triangles + " ShadedTriangles :" + this.shadedTriangles + " CulledTriangles:" + this.culledTriangles + " FilteredObjects:" + this.filteredObjects + " CulledObjects:" + this.culledObjects + "");
        }// end function

    }
}
