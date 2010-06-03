package org.papervision3d.core.clipping.draw
{
    import flash.display.*;
    import flash.geom.*;
    import org.papervision3d.core.render.command.*;

    public class Clipping extends Object
    {
        public var minX:Number = -1000000;
        public var minY:Number = -1000000;
        private var zeroPoint:Point;
        private var globalPoint:Point;
        private var rectangleClipping:RectangleClipping;
        public var maxX:Number = 1000000;
        public var maxY:Number = 1000000;

        public function Clipping()
        {
            this.zeroPoint = new Point(0, 0);
            return;
        }// end function

        public function rect(param1:Number, param2:Number, param3:Number, param4:Number) : Boolean
        {
            return true;
        }// end function

        public function screen(param1:Sprite) : Clipping
        {
            if (!this.rectangleClipping)
            {
                this.rectangleClipping = new RectangleClipping();
            }
            switch(param1.stage.align)
            {
                case StageAlign.TOP_LEFT:
                {
                    this.zeroPoint.x = 0;
                    this.zeroPoint.y = 0;
                    this.globalPoint = param1.globalToLocal(this.zeroPoint);
                    var _loc_2:* = this.globalPoint.x;
                    this.rectangleClipping.minX = this.globalPoint.x;
                    this.rectangleClipping.maxX = _loc_2 + param1.stage.stageWidth;
                    var _loc_2:* = this.globalPoint.y;
                    this.rectangleClipping.minY = this.globalPoint.y;
                    this.rectangleClipping.maxY = _loc_2 + param1.stage.stageHeight;
                    break;
                }
                case StageAlign.TOP_RIGHT:
                {
                    this.zeroPoint.x = param1.stage.stageWidth;
                    this.zeroPoint.y = 0;
                    this.globalPoint = param1.globalToLocal(this.zeroPoint);
                    var _loc_2:* = this.globalPoint.x;
                    this.rectangleClipping.maxX = this.globalPoint.x;
                    this.rectangleClipping.minX = _loc_2 - param1.stage.stageWidth;
                    var _loc_2:* = this.globalPoint.y;
                    this.rectangleClipping.minY = this.globalPoint.y;
                    this.rectangleClipping.maxY = _loc_2 + param1.stage.stageHeight;
                    break;
                }
                case StageAlign.BOTTOM_LEFT:
                {
                    this.zeroPoint.x = 0;
                    this.zeroPoint.y = param1.stage.stageHeight;
                    this.globalPoint = param1.globalToLocal(this.zeroPoint);
                    var _loc_2:* = this.globalPoint.x;
                    this.rectangleClipping.minX = this.globalPoint.x;
                    this.rectangleClipping.maxX = _loc_2 + param1.stage.stageWidth;
                    var _loc_2:* = this.globalPoint.y;
                    this.rectangleClipping.maxY = this.globalPoint.y;
                    this.rectangleClipping.minY = _loc_2 - param1.stage.stageHeight;
                    break;
                }
                case StageAlign.BOTTOM_RIGHT:
                {
                    this.zeroPoint.x = param1.stage.stageWidth;
                    this.zeroPoint.y = param1.stage.stageHeight;
                    this.globalPoint = param1.globalToLocal(this.zeroPoint);
                    var _loc_2:* = this.globalPoint.x;
                    this.rectangleClipping.maxX = this.globalPoint.x;
                    this.rectangleClipping.minX = _loc_2 - param1.stage.stageWidth;
                    var _loc_2:* = this.globalPoint.y;
                    this.rectangleClipping.maxY = this.globalPoint.y;
                    this.rectangleClipping.minY = _loc_2 - param1.stage.stageHeight;
                    break;
                }
                case StageAlign.TOP:
                {
                    this.zeroPoint.x = param1.stage.stageWidth / 2;
                    this.zeroPoint.y = 0;
                    this.globalPoint = param1.globalToLocal(this.zeroPoint);
                    this.rectangleClipping.minX = this.globalPoint.x - param1.stage.stageWidth / 2;
                    this.rectangleClipping.maxX = this.globalPoint.x + param1.stage.stageWidth / 2;
                    var _loc_2:* = this.globalPoint.y;
                    this.rectangleClipping.minY = this.globalPoint.y;
                    this.rectangleClipping.maxY = _loc_2 + param1.stage.stageHeight;
                    break;
                }
                case StageAlign.BOTTOM:
                {
                    this.zeroPoint.x = param1.stage.stageWidth / 2;
                    this.zeroPoint.y = param1.stage.stageHeight;
                    this.globalPoint = param1.globalToLocal(this.zeroPoint);
                    this.rectangleClipping.minX = this.globalPoint.x - param1.stage.stageWidth / 2;
                    this.rectangleClipping.maxX = this.globalPoint.x + param1.stage.stageWidth / 2;
                    var _loc_2:* = this.globalPoint.y;
                    this.rectangleClipping.maxY = this.globalPoint.y;
                    this.rectangleClipping.minY = _loc_2 - param1.stage.stageHeight;
                    break;
                }
                case StageAlign.LEFT:
                {
                    this.zeroPoint.x = 0;
                    this.zeroPoint.y = param1.stage.stageHeight / 2;
                    this.globalPoint = param1.globalToLocal(this.zeroPoint);
                    var _loc_2:* = this.globalPoint.x;
                    this.rectangleClipping.minX = this.globalPoint.x;
                    this.rectangleClipping.maxX = _loc_2 + param1.stage.stageWidth;
                    this.rectangleClipping.minY = this.globalPoint.y - param1.stage.stageHeight / 2;
                    this.rectangleClipping.maxY = this.globalPoint.y + param1.stage.stageHeight / 2;
                    break;
                }
                case StageAlign.RIGHT:
                {
                    this.zeroPoint.x = param1.stage.stageWidth;
                    this.zeroPoint.y = param1.stage.stageHeight / 2;
                    this.globalPoint = param1.globalToLocal(this.zeroPoint);
                    var _loc_2:* = this.globalPoint.x;
                    this.rectangleClipping.maxX = this.globalPoint.x;
                    this.rectangleClipping.minX = _loc_2 - param1.stage.stageWidth;
                    this.rectangleClipping.minY = this.globalPoint.y - param1.stage.stageHeight / 2;
                    this.rectangleClipping.maxY = this.globalPoint.y + param1.stage.stageHeight / 2;
                    break;
                }
                default:
                {
                    this.zeroPoint.x = param1.stage.stageWidth / 2;
                    this.zeroPoint.y = param1.stage.stageHeight / 2;
                    this.globalPoint = param1.globalToLocal(this.zeroPoint);
                    this.rectangleClipping.minX = this.globalPoint.x - param1.stage.stageWidth / 2;
                    this.rectangleClipping.maxX = this.globalPoint.x + param1.stage.stageWidth / 2;
                    this.rectangleClipping.minY = this.globalPoint.y - param1.stage.stageHeight / 2;
                    this.rectangleClipping.maxY = this.globalPoint.y + param1.stage.stageHeight / 2;
                    break;
                }
            }
            return this.rectangleClipping;
        }// end function

        public function check(param1:RenderableListItem) : Boolean
        {
            return true;
        }// end function

        public function asRectangleClipping() : RectangleClipping
        {
            if (!this.rectangleClipping)
            {
                this.rectangleClipping = new RectangleClipping();
            }
            this.rectangleClipping.minX = -1000000;
            this.rectangleClipping.minY = -1000000;
            this.rectangleClipping.maxX = 1000000;
            this.rectangleClipping.maxY = 1000000;
            return this.rectangleClipping;
        }// end function

    }
}
