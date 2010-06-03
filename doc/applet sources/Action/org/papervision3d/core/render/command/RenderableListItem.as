package org.papervision3d.core.render.command
{
    import flash.geom.*;
    import org.papervision3d.core.geom.renderables.*;
    import org.papervision3d.core.render.data.*;
    import org.papervision3d.objects.*;

    public class RenderableListItem extends AbstractRenderListItem
    {
        public var minX:Number;
        public var minY:Number;
        public var minZ:Number;
        public var area:Number;
        public var instance:DisplayObject3D;
        public var renderableInstance:AbstractRenderable;
        public var renderable:Class;
        public var maxX:Number;
        public var maxY:Number;
        public var maxZ:Number;
        public var quadrant:QuadTreeNode;

        public function RenderableListItem()
        {
            return;
        }// end function

        public function getZ(param1:Number, param2:Number, param3:Number) : Number
        {
            return screenZ;
        }// end function

        public function update() : void
        {
            return;
        }// end function

        public function hitTestPoint2D(param1:Point, param2:RenderHitData) : RenderHitData
        {
            return param2;
        }// end function

        public function quarter(param1:Number) : Array
        {
            return [];
        }// end function

    }
}
