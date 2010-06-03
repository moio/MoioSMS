package org.papervision3d.core.culling
{
    import flash.geom.*;
    import org.papervision3d.core.geom.renderables.*;
    import org.papervision3d.core.math.util.*;

    public class RectangleLineCuller extends Object implements ILineCuller
    {
        private var lineBoundsRect:Rectangle;
        private var rectIntersection:Rectangle;
        private var cullingRectangle:Rectangle;

        public function RectangleLineCuller(param1:Rectangle = null) : void
        {
            if (param1)
            {
                this.cullingRectangle = param1;
            }
            this.lineBoundsRect = new Rectangle();
            this.rectIntersection = new Rectangle();
            return;
        }// end function

        public function testLine(param1:Line3D) : Boolean
        {
            if (!param1.v0.vertex3DInstance.visible || !param1.v1.vertex3DInstance.visible)
            {
                return false;
            }
            var _loc_2:* = param1.v0.vertex3DInstance.x;
            var _loc_3:* = param1.v0.vertex3DInstance.y;
            var _loc_4:* = param1.v1.vertex3DInstance.x;
            var _loc_5:* = param1.v1.vertex3DInstance.y;
            this.lineBoundsRect.width = Math.abs(_loc_4 - _loc_2);
            this.lineBoundsRect.height = Math.abs(_loc_5 - _loc_3);
            if (_loc_2 < _loc_4)
            {
                this.lineBoundsRect.x = _loc_2;
            }
            else
            {
                this.lineBoundsRect.x = _loc_4;
            }
            if (_loc_3 < _loc_5)
            {
                this.lineBoundsRect.y = _loc_3;
            }
            else
            {
                this.lineBoundsRect.y = _loc_5;
            }
            if (this.cullingRectangle.containsRect(this.lineBoundsRect))
            {
                return true;
            }
            if (!FastRectangleTools.intersects(this.lineBoundsRect, this.cullingRectangle))
            {
                return false;
            }
            this.rectIntersection = FastRectangleTools.intersection(this.lineBoundsRect, this.cullingRectangle);
            var _loc_6:* = (_loc_5 - _loc_3) / (_loc_4 - _loc_2);
            var _loc_7:* = _loc_3 - _loc_6 * _loc_2;
            var _loc_8:* = (this.cullingRectangle.top - _loc_7) / _loc_6;
            if ((this.cullingRectangle.top - _loc_7) / _loc_6 > this.rectIntersection.left && _loc_8 < this.rectIntersection.right)
            {
                return true;
            }
            _loc_8 = (this.cullingRectangle.bottom - _loc_7) / _loc_6;
            if (_loc_8 > this.rectIntersection.left && _loc_8 < this.rectIntersection.right)
            {
                return true;
            }
            var _loc_9:* = _loc_6 * this.cullingRectangle.left + _loc_7;
            if (_loc_6 * this.cullingRectangle.left + _loc_7 > this.rectIntersection.top && _loc_9 < this.rectIntersection.bottom)
            {
                return true;
            }
            _loc_9 = _loc_6 * this.cullingRectangle.right + _loc_7;
            if (_loc_9 > this.rectIntersection.top && _loc_9 < this.rectIntersection.bottom)
            {
                return true;
            }
            return false;
        }// end function

    }
}
