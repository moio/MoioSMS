package mx.controls.scrollClasses
{
    import flash.events.*;
    import flash.geom.*;
    import mx.controls.*;
    import mx.events.*;

    public class ScrollThumb extends Button
    {
        private var lastY:Number;
        private var datamin:Number;
        private var ymax:Number;
        private var ymin:Number;
        private var datamax:Number;
        static const VERSION:String = "3.2.0.3958";

        public function ScrollThumb()
        {
            explicitMinHeight = 10;
            stickyHighlighting = true;
            return;
        }// end function

        private function stopDragThumb() : void
        {
            var _loc_1:* = ScrollBar(parent);
            _loc_1.isScrolling = false;
            _loc_1.dispatchScrollEvent(_loc_1.oldPosition, ScrollEventDetail.THUMB_POSITION);
            _loc_1.oldPosition = NaN;
            systemManager.getSandboxRoot().removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, true);
            return;
        }// end function

        override protected function mouseDownHandler(event:MouseEvent) : void
        {
            super.mouseDownHandler(event);
            var _loc_2:* = ScrollBar(parent);
            _loc_2.oldPosition = _loc_2.scrollPosition;
            lastY = event.localY;
            systemManager.getSandboxRoot().addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, true);
            return;
        }// end function

        private function mouseMoveHandler(event:MouseEvent) : void
        {
            if (ymin == ymax)
            {
                return;
            }
            var _loc_2:* = new Point(event.stageX, event.stageY);
            _loc_2 = globalToLocal(_loc_2);
            var _loc_3:* = _loc_2.y - lastY;
            _loc_3 = _loc_3 + y;
            if (_loc_3 < ymin)
            {
                _loc_3 = ymin;
            }
            else if (_loc_3 > ymax)
            {
                _loc_3 = ymax;
            }
            var _loc_4:* = ScrollBar(parent);
            ScrollBar(parent).isScrolling = true;
            $y = _loc_3;
            var _loc_5:* = _loc_4.scrollPosition;
            var _loc_6:* = Math.round((datamax - datamin) * (y - ymin) / (ymax - ymin)) + datamin;
            _loc_4.scrollPosition = _loc_6;
            _loc_4.dispatchScrollEvent(_loc_5, ScrollEventDetail.THUMB_TRACK);
            event.updateAfterEvent();
            return;
        }// end function

        override function buttonReleased() : void
        {
            super.buttonReleased();
            stopDragThumb();
            return;
        }// end function

        function setRange(param1:Number, param2:Number, param3:Number, param4:Number) : void
        {
            this.ymin = param1;
            this.ymax = param2;
            this.datamin = param3;
            this.datamax = param4;
            return;
        }// end function

    }
}
