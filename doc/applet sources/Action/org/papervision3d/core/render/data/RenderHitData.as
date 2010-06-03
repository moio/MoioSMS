package org.papervision3d.core.render.data
{
    import org.papervision3d.core.geom.renderables.*;
    import org.papervision3d.core.proto.*;
    import org.papervision3d.objects.*;

    public class RenderHitData extends Object
    {
        public var y:Number;
        public var z:Number;
        public var endTime:int = 0;
        public var startTime:int = 0;
        public var displayObject3D:DisplayObject3D;
        public var hasHit:Boolean = false;
        public var material:MaterialObject3D;
        public var renderable:IRenderable;
        public var u:Number;
        public var v:Number;
        public var x:Number;

        public function RenderHitData() : void
        {
            return;
        }// end function

        public function clear() : void
        {
            this.startTime = 0;
            this.endTime = 0;
            this.hasHit = false;
            this.displayObject3D = null;
            this.material = null;
            this.renderable = null;
            this.u = 0;
            this.v = 0;
            this.x = 0;
            this.y = 0;
            this.z = 0;
            return;
        }// end function

        public function clone() : RenderHitData
        {
            var _loc_1:* = new RenderHitData();
            _loc_1.startTime = this.startTime;
            _loc_1.endTime = this.endTime;
            _loc_1.hasHit = this.hasHit;
            _loc_1.displayObject3D = this.displayObject3D;
            _loc_1.material = this.material;
            _loc_1.renderable = this.renderable;
            _loc_1.u = this.u;
            _loc_1.v = this.v;
            _loc_1.x = this.x;
            _loc_1.y = this.y;
            _loc_1.z = this.z;
            return _loc_1;
        }// end function

        public function toString() : String
        {
            return this.displayObject3D + " " + this.renderable;
        }// end function

    }
}
