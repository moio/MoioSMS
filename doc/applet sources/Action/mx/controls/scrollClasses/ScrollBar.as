package mx.controls.scrollClasses
{
    import flash.events.*;
    import flash.geom.*;
    import flash.ui.*;
    import flash.utils.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.styles.*;

    public class ScrollBar extends UIComponent
    {
        private var _direction:String = "vertical";
        private var _pageScrollSize:Number = 0;
        var scrollTrack:Button;
        var downArrow:Button;
        var scrollThumb:ScrollThumb;
        private var trackScrollRepeatDirection:int;
        private var _minScrollPosition:Number = 0;
        private var trackPosition:Number;
        private var _pageSize:Number = 0;
        var _minHeight:Number = 32;
        private var _maxScrollPosition:Number = 0;
        private var trackScrollTimer:Timer;
        var upArrow:Button;
        private var _lineScrollSize:Number = 1;
        private var _scrollPosition:Number = 0;
        private var trackScrolling:Boolean = false;
        var isScrolling:Boolean;
        var oldPosition:Number;
        var _minWidth:Number = 16;
        static const VERSION:String = "3.2.0.3958";
        public static const THICKNESS:Number = 16;

        public function ScrollBar()
        {
            return;
        }// end function

        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            invalidateDisplayList();
            return;
        }// end function

        public function set lineScrollSize(param1:Number) : void
        {
            _lineScrollSize = param1;
            return;
        }// end function

        public function get minScrollPosition() : Number
        {
            return _minScrollPosition;
        }// end function

        function dispatchScrollEvent(param1:Number, param2:String) : void
        {
            var _loc_3:* = new ScrollEvent(ScrollEvent.SCROLL);
            _loc_3.detail = param2;
            _loc_3.position = scrollPosition;
            _loc_3.delta = scrollPosition - param1;
            _loc_3.direction = direction;
            dispatchEvent(_loc_3);
            return;
        }// end function

        private function downArrow_buttonDownHandler(event:FlexEvent) : void
        {
            if (isNaN(oldPosition))
            {
                oldPosition = scrollPosition;
            }
            lineScroll(1);
            return;
        }// end function

        private function scrollTrack_mouseDownHandler(event:MouseEvent) : void
        {
            if (!(event.target == this || event.target == scrollTrack))
            {
                return;
            }
            trackScrolling = true;
            var _loc_2:* = systemManager.getSandboxRoot();
            _loc_2.addEventListener(MouseEvent.MOUSE_UP, scrollTrack_mouseUpHandler, true);
            _loc_2.addEventListener(MouseEvent.MOUSE_MOVE, scrollTrack_mouseMoveHandler, true);
            _loc_2.addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, scrollTrack_mouseLeaveHandler);
            systemManager.deployMouseShields(true);
            var _loc_3:* = new Point(event.localX, event.localY);
            _loc_3 = event.target.localToGlobal(_loc_3);
            _loc_3 = globalToLocal(_loc_3);
            trackPosition = _loc_3.y;
            if (isNaN(oldPosition))
            {
                oldPosition = scrollPosition;
            }
            trackScrollRepeatDirection = scrollThumb.y + scrollThumb.height < _loc_3.y ? (1) : (scrollThumb.y > _loc_3.y ? (-1) : (0));
            pageScroll(trackScrollRepeatDirection);
            if (!trackScrollTimer)
            {
                trackScrollTimer = new Timer(getStyle("repeatDelay"), 1);
                trackScrollTimer.addEventListener(TimerEvent.TIMER, trackScrollTimerHandler);
            }
            trackScrollTimer.start();
            return;
        }// end function

        public function set minScrollPosition(param1:Number) : void
        {
            _minScrollPosition = param1;
            invalidateDisplayList();
            return;
        }// end function

        public function get scrollPosition() : Number
        {
            return _scrollPosition;
        }// end function

        function get linePlusDetail() : String
        {
            return direction == ScrollBarDirection.VERTICAL ? (ScrollEventDetail.LINE_DOWN) : (ScrollEventDetail.LINE_RIGHT);
        }// end function

        public function get maxScrollPosition() : Number
        {
            return _maxScrollPosition;
        }// end function

        protected function get thumbStyleFilters() : Object
        {
            return null;
        }// end function

        override public function set doubleClickEnabled(param1:Boolean) : void
        {
            return;
        }// end function

        public function get lineScrollSize() : Number
        {
            return _lineScrollSize;
        }// end function

        function get virtualHeight() : Number
        {
            return unscaledHeight;
        }// end function

        public function set scrollPosition(param1:Number) : void
        {
            var _loc_2:Number = NaN;
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            _scrollPosition = param1;
            if (scrollThumb)
            {
                if (!cacheAsBitmap)
                {
                    var _loc_5:Boolean = true;
                    scrollThumb.cacheHeuristic = true;
                    cacheHeuristic = _loc_5;
                }
                if (!isScrolling)
                {
                    param1 = Math.min(param1, maxScrollPosition);
                    param1 = Math.max(param1, minScrollPosition);
                    _loc_2 = maxScrollPosition - minScrollPosition;
                    if (_loc_2 != 0)
                    {
                    }
                    _loc_3 = isNaN(_loc_2) ? (0) : ((param1 - minScrollPosition) * (trackHeight - scrollThumb.height) / _loc_2 + trackY);
                    _loc_4 = (virtualWidth - scrollThumb.width) / 2 + getStyle("thumbOffset");
                    scrollThumb.move(Math.round(_loc_4), Math.round(_loc_3));
                }
            }
            return;
        }// end function

        protected function get downArrowStyleFilters() : Object
        {
            return null;
        }// end function

        public function get pageSize() : Number
        {
            return _pageSize;
        }// end function

        public function set pageScrollSize(param1:Number) : void
        {
            _pageScrollSize = param1;
            return;
        }// end function

        public function set maxScrollPosition(param1:Number) : void
        {
            _maxScrollPosition = param1;
            invalidateDisplayList();
            return;
        }// end function

        function pageScroll(param1:int) : void
        {
            var _loc_4:Number = NaN;
            var _loc_5:String = null;
            var _loc_2:* = _pageScrollSize != 0 ? (_pageScrollSize) : (pageSize);
            var _loc_3:* = _scrollPosition + param1 * _loc_2;
            if (_loc_3 > maxScrollPosition)
            {
                _loc_3 = maxScrollPosition;
            }
            else if (_loc_3 < minScrollPosition)
            {
                _loc_3 = minScrollPosition;
            }
            if (_loc_3 != scrollPosition)
            {
                _loc_4 = scrollPosition;
                scrollPosition = _loc_3;
                _loc_5 = param1 < 0 ? (pageMinusDetail) : (pagePlusDetail);
                dispatchScrollEvent(_loc_4, _loc_5);
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            if (!scrollTrack)
            {
                scrollTrack = new Button();
                scrollTrack.focusEnabled = false;
                scrollTrack.skinName = "trackSkin";
                scrollTrack.upSkinName = "trackUpSkin";
                scrollTrack.overSkinName = "trackOverSkin";
                scrollTrack.downSkinName = "trackDownSkin";
                scrollTrack.disabledSkinName = "trackDisabledSkin";
                if (scrollTrack is ISimpleStyleClient)
                {
                    ISimpleStyleClient(scrollTrack).styleName = this;
                }
                addChild(scrollTrack);
                scrollTrack.validateProperties();
            }
            if (!upArrow)
            {
                upArrow = new Button();
                upArrow.enabled = false;
                upArrow.autoRepeat = true;
                upArrow.focusEnabled = false;
                upArrow.upSkinName = "upArrowUpSkin";
                upArrow.overSkinName = "upArrowOverSkin";
                upArrow.downSkinName = "upArrowDownSkin";
                upArrow.disabledSkinName = "upArrowDisabledSkin";
                upArrow.skinName = "upArrowSkin";
                upArrow.upIconName = "";
                upArrow.overIconName = "";
                upArrow.downIconName = "";
                upArrow.disabledIconName = "";
                addChild(upArrow);
                upArrow.styleName = new StyleProxy(this, upArrowStyleFilters);
                upArrow.validateProperties();
                upArrow.addEventListener(FlexEvent.BUTTON_DOWN, upArrow_buttonDownHandler);
            }
            if (!downArrow)
            {
                downArrow = new Button();
                downArrow.enabled = false;
                downArrow.autoRepeat = true;
                downArrow.focusEnabled = false;
                downArrow.upSkinName = "downArrowUpSkin";
                downArrow.overSkinName = "downArrowOverSkin";
                downArrow.downSkinName = "downArrowDownSkin";
                downArrow.disabledSkinName = "downArrowDisabledSkin";
                downArrow.skinName = "downArrowSkin";
                downArrow.upIconName = "";
                downArrow.overIconName = "";
                downArrow.downIconName = "";
                downArrow.disabledIconName = "";
                addChild(downArrow);
                downArrow.styleName = new StyleProxy(this, downArrowStyleFilters);
                downArrow.validateProperties();
                downArrow.addEventListener(FlexEvent.BUTTON_DOWN, downArrow_buttonDownHandler);
            }
            return;
        }// end function

        private function scrollTrack_mouseOverHandler(event:MouseEvent) : void
        {
            if (!(event.target == this || event.target == scrollTrack))
            {
                return;
            }
            if (trackScrolling)
            {
                trackScrollTimer.start();
            }
            return;
        }// end function

        private function get minDetail() : String
        {
            return direction == ScrollBarDirection.VERTICAL ? (ScrollEventDetail.AT_TOP) : (ScrollEventDetail.AT_LEFT);
        }// end function

        function isScrollBarKey(param1:uint) : Boolean
        {
            var _loc_2:Number = NaN;
            if (param1 == Keyboard.HOME)
            {
                if (scrollPosition != 0)
                {
                    _loc_2 = scrollPosition;
                    scrollPosition = 0;
                    dispatchScrollEvent(_loc_2, minDetail);
                }
                return true;
            }
            else if (param1 == Keyboard.END)
            {
                if (scrollPosition < maxScrollPosition)
                {
                    _loc_2 = scrollPosition;
                    scrollPosition = maxScrollPosition;
                    dispatchScrollEvent(_loc_2, maxDetail);
                }
                return true;
            }
            return false;
        }// end function

        function get lineMinusDetail() : String
        {
            return direction == ScrollBarDirection.VERTICAL ? (ScrollEventDetail.LINE_UP) : (ScrollEventDetail.LINE_LEFT);
        }// end function

        function get pageMinusDetail() : String
        {
            return direction == ScrollBarDirection.VERTICAL ? (ScrollEventDetail.PAGE_UP) : (ScrollEventDetail.PAGE_LEFT);
        }// end function

        private function get maxDetail() : String
        {
            return direction == ScrollBarDirection.VERTICAL ? (ScrollEventDetail.AT_BOTTOM) : (ScrollEventDetail.AT_RIGHT);
        }// end function

        private function scrollTrack_mouseLeaveHandler(event:Event) : void
        {
            trackScrolling = false;
            var _loc_2:* = systemManager.getSandboxRoot();
            _loc_2.removeEventListener(MouseEvent.MOUSE_UP, scrollTrack_mouseUpHandler, true);
            _loc_2.removeEventListener(MouseEvent.MOUSE_MOVE, scrollTrack_mouseMoveHandler, true);
            _loc_2.removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, scrollTrack_mouseLeaveHandler);
            systemManager.deployMouseShields(false);
            if (trackScrollTimer)
            {
                trackScrollTimer.reset();
            }
            if (event.target != scrollTrack)
            {
                return;
            }
            var _loc_3:* = oldPosition > scrollPosition ? (pageMinusDetail) : (pagePlusDetail);
            dispatchScrollEvent(oldPosition, _loc_3);
            oldPosition = NaN;
            return;
        }// end function

        protected function get upArrowStyleFilters() : Object
        {
            return null;
        }// end function

        private function get trackHeight() : Number
        {
            return virtualHeight - (upArrow.getExplicitOrMeasuredHeight() + downArrow.getExplicitOrMeasuredHeight());
        }// end function

        public function get pageScrollSize() : Number
        {
            return _pageScrollSize;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            upArrow.validateSize();
            downArrow.validateSize();
            scrollTrack.validateSize();
            if (FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0)
            {
                _minWidth = scrollThumb ? (scrollThumb.getExplicitOrMeasuredWidth()) : (0);
                _minWidth = Math.max(scrollTrack.getExplicitOrMeasuredWidth(), upArrow.getExplicitOrMeasuredWidth(), downArrow.getExplicitOrMeasuredWidth(), _minWidth);
            }
            else
            {
                _minWidth = upArrow.getExplicitOrMeasuredWidth();
            }
            _minHeight = upArrow.getExplicitOrMeasuredHeight() + downArrow.getExplicitOrMeasuredHeight();
            return;
        }// end function

        function lineScroll(param1:int) : void
        {
            var _loc_4:Number = NaN;
            var _loc_5:String = null;
            var _loc_2:* = _lineScrollSize;
            var _loc_3:* = _scrollPosition + param1 * _loc_2;
            if (_loc_3 > maxScrollPosition)
            {
                _loc_3 = maxScrollPosition;
            }
            else if (_loc_3 < minScrollPosition)
            {
                _loc_3 = minScrollPosition;
            }
            if (_loc_3 != scrollPosition)
            {
                _loc_4 = scrollPosition;
                scrollPosition = _loc_3;
                _loc_5 = param1 < 0 ? (lineMinusDetail) : (linePlusDetail);
                dispatchScrollEvent(_loc_4, _loc_5);
            }
            return;
        }// end function

        public function setScrollProperties(param1:Number, param2:Number, param3:Number, param4:Number = 0) : void
        {
            var _loc_5:Number = NaN;
            this.pageSize = param1;
            _pageScrollSize = param4 > 0 ? (param4) : (param1);
            this.minScrollPosition = Math.max(param2, 0);
            this.maxScrollPosition = Math.max(param3, 0);
            _scrollPosition = Math.max(this.minScrollPosition, _scrollPosition);
            _scrollPosition = Math.min(this.maxScrollPosition, _scrollPosition);
            if (this.maxScrollPosition - this.minScrollPosition > 0 && enabled)
            {
                upArrow.enabled = true;
                downArrow.enabled = true;
                scrollTrack.enabled = true;
                addEventListener(MouseEvent.MOUSE_DOWN, scrollTrack_mouseDownHandler);
                addEventListener(MouseEvent.MOUSE_OVER, scrollTrack_mouseOverHandler);
                addEventListener(MouseEvent.MOUSE_OUT, scrollTrack_mouseOutHandler);
                if (!scrollThumb)
                {
                    scrollThumb = new ScrollThumb();
                    scrollThumb.focusEnabled = false;
                    addChildAt(scrollThumb, getChildIndex(downArrow));
                    scrollThumb.styleName = new StyleProxy(this, thumbStyleFilters);
                    scrollThumb.upSkinName = "thumbUpSkin";
                    scrollThumb.overSkinName = "thumbOverSkin";
                    scrollThumb.downSkinName = "thumbDownSkin";
                    scrollThumb.iconName = "thumbIcon";
                    scrollThumb.skinName = "thumbSkin";
                }
                _loc_5 = trackHeight < 0 ? (0) : (Math.round(param1 / (this.maxScrollPosition - this.minScrollPosition + param1) * trackHeight));
                if (_loc_5 < scrollThumb.minHeight)
                {
                    if (trackHeight < scrollThumb.minHeight)
                    {
                        scrollThumb.visible = false;
                    }
                    else
                    {
                        _loc_5 = scrollThumb.minHeight;
                        scrollThumb.visible = true;
                        scrollThumb.setActualSize(scrollThumb.measuredWidth, scrollThumb.minHeight);
                    }
                }
                else
                {
                    scrollThumb.visible = true;
                    scrollThumb.setActualSize(scrollThumb.measuredWidth, _loc_5);
                }
                scrollThumb.setRange(upArrow.getExplicitOrMeasuredHeight() + 0, virtualHeight - downArrow.getExplicitOrMeasuredHeight() - scrollThumb.height, this.minScrollPosition, this.maxScrollPosition);
                scrollPosition = Math.max(Math.min(scrollPosition, this.maxScrollPosition), this.minScrollPosition);
            }
            else
            {
                upArrow.enabled = false;
                downArrow.enabled = false;
                scrollTrack.enabled = false;
                if (scrollThumb)
                {
                    scrollThumb.visible = false;
                }
            }
            return;
        }// end function

        private function trackScrollTimerHandler(event:Event) : void
        {
            if (trackScrollRepeatDirection == 1)
            {
                if (scrollThumb.y + scrollThumb.height > trackPosition)
                {
                    return;
                }
            }
            if (trackScrollRepeatDirection == -1)
            {
                if (scrollThumb.y < trackPosition)
                {
                    return;
                }
            }
            pageScroll(trackScrollRepeatDirection);
            if (trackScrollTimer && trackScrollTimer.repeatCount == 1)
            {
                trackScrollTimer.delay = getStyle("repeatInterval");
                trackScrollTimer.repeatCount = 0;
            }
            return;
        }// end function

        private function upArrow_buttonDownHandler(event:FlexEvent) : void
        {
            if (isNaN(oldPosition))
            {
                oldPosition = scrollPosition;
            }
            lineScroll(-1);
            return;
        }// end function

        public function set pageSize(param1:Number) : void
        {
            _pageSize = param1;
            return;
        }// end function

        private function get trackY() : Number
        {
            return upArrow.getExplicitOrMeasuredHeight();
        }// end function

        private function scrollTrack_mouseOutHandler(event:MouseEvent) : void
        {
            if (trackScrolling)
            {
                trackScrollTimer.stop();
            }
            return;
        }// end function

        private function scrollTrack_mouseUpHandler(event:MouseEvent) : void
        {
            scrollTrack_mouseLeaveHandler(event);
            return;
        }// end function

        private function scrollTrack_mouseMoveHandler(event:MouseEvent) : void
        {
            var _loc_2:Point = null;
            if (trackScrolling)
            {
                _loc_2 = new Point(event.stageX, event.stageY);
                _loc_2 = globalToLocal(_loc_2);
                trackPosition = _loc_2.y;
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            if ($height == 1)
            {
                return;
            }
            if (!upArrow)
            {
                return;
            }
            super.updateDisplayList(param1, param2);
            if (cacheAsBitmap)
            {
                var _loc_3:Boolean = false;
                scrollThumb.cacheHeuristic = false;
                cacheHeuristic = _loc_3;
            }
            upArrow.setActualSize(upArrow.getExplicitOrMeasuredWidth(), upArrow.getExplicitOrMeasuredHeight());
            if (FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0)
            {
                upArrow.move((virtualWidth - upArrow.width) / 2, 0);
            }
            else
            {
                upArrow.move(0, 0);
            }
            scrollTrack.setActualSize(scrollTrack.getExplicitOrMeasuredWidth(), virtualHeight);
            if (FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0)
            {
                scrollTrack.x = (virtualWidth - scrollTrack.width) / 2;
            }
            scrollTrack.y = 0;
            downArrow.setActualSize(downArrow.getExplicitOrMeasuredWidth(), downArrow.getExplicitOrMeasuredHeight());
            if (FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0)
            {
                downArrow.move((virtualWidth - downArrow.width) / 2, virtualHeight - downArrow.getExplicitOrMeasuredHeight());
            }
            else
            {
                downArrow.move(0, virtualHeight - downArrow.getExplicitOrMeasuredHeight());
            }
            setScrollProperties(pageSize, minScrollPosition, maxScrollPosition, _pageScrollSize);
            scrollPosition = _scrollPosition;
            return;
        }// end function

        function get pagePlusDetail() : String
        {
            return direction == ScrollBarDirection.VERTICAL ? (ScrollEventDetail.PAGE_DOWN) : (ScrollEventDetail.PAGE_RIGHT);
        }// end function

        function get virtualWidth() : Number
        {
            return unscaledWidth;
        }// end function

        public function set direction(param1:String) : void
        {
            _direction = param1;
            invalidateSize();
            invalidateDisplayList();
            dispatchEvent(new Event("directionChanged"));
            return;
        }// end function

        public function get direction() : String
        {
            return _direction;
        }// end function

    }
}
