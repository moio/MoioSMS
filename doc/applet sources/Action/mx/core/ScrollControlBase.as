package mx.core
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import mx.controls.*;
    import mx.controls.scrollClasses.*;
    import mx.events.*;
    import mx.managers.*;
    import mx.styles.*;

    public class ScrollControlBase extends UIComponent
    {
        private var numberOfRows:Number = 0;
        private var _scrollTipFunction:Function;
        private var scrollTip:ToolTip;
        public var showScrollTips:Boolean = false;
        private var numberOfCols:Number = 0;
        protected var maskShape:Shape;
        private var oldTTMEnabled:Boolean;
        var _maxHorizontalScrollPosition:Number;
        protected var border:IFlexDisplayObject;
        private var _viewMetrics:EdgeMetrics;
        var _maxVerticalScrollPosition:Number;
        protected var verticalScrollBar:ScrollBar;
        var _horizontalScrollPosition:Number = 0;
        private var propsInited:Boolean;
        protected var horizontalScrollBar:ScrollBar;
        var _horizontalScrollPolicy:String = "off";
        var _verticalScrollPosition:Number = 0;
        private var scrollThumbMidPoint:Number;
        var _verticalScrollPolicy:String = "auto";
        protected var scrollAreaChanged:Boolean;
        private var viewableColumns:Number;
        public var liveScrolling:Boolean = true;
        private var viewableRows:Number;
        private var invLayout:Boolean;
        static const VERSION:String = "3.2.0.3958";

        public function ScrollControlBase()
        {
            _viewMetrics = EdgeMetrics.EMPTY;
            addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
            return;
        }// end function

        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            if (horizontalScrollBar)
            {
                horizontalScrollBar.enabled = param1;
            }
            if (verticalScrollBar)
            {
                verticalScrollBar.enabled = param1;
            }
            return;
        }// end function

        public function get scrollTipFunction() : Function
        {
            return _scrollTipFunction;
        }// end function

        public function set scrollTipFunction(param1:Function) : void
        {
            _scrollTipFunction = param1;
            dispatchEvent(new Event("scrollTipFunctionChanged"));
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            layoutChrome(param1, param2);
            var _loc_3:* = param1;
            var _loc_4:* = param2;
            invLayout = false;
            var _loc_9:* = viewMetrics;
            _viewMetrics = viewMetrics;
            var _loc_5:* = _loc_9;
            if (horizontalScrollBar && horizontalScrollBar.visible)
            {
                horizontalScrollBar.setActualSize(_loc_3 - _loc_5.left - _loc_5.right, horizontalScrollBar.minHeight);
                horizontalScrollBar.move(_loc_5.left, _loc_4 - _loc_5.bottom);
                horizontalScrollBar.enabled = enabled;
            }
            if (verticalScrollBar && verticalScrollBar.visible)
            {
                verticalScrollBar.setActualSize(verticalScrollBar.minWidth, _loc_4 - _loc_5.top - _loc_5.bottom);
                verticalScrollBar.move(_loc_3 - _loc_5.right, _loc_5.top);
                verticalScrollBar.enabled = enabled;
            }
            var _loc_6:* = maskShape;
            var _loc_7:* = _loc_3 - _loc_5.left - _loc_5.right;
            var _loc_8:* = _loc_4 - _loc_5.top - _loc_5.bottom;
            _loc_6.width = _loc_7 < 0 ? (0) : (_loc_7);
            _loc_6.height = _loc_8 < 0 ? (0) : (_loc_8);
            _loc_6.x = _loc_5.left;
            _loc_6.y = _loc_5.top;
            return;
        }// end function

        protected function setScrollBarProperties(param1:int, param2:int, param3:int, param4:int) : void
        {
            var _loc_7:Boolean = false;
            var _loc_5:* = this.horizontalScrollPolicy;
            var _loc_6:* = this.verticalScrollPolicy;
            scrollAreaChanged = false;
            if (_loc_5 == ScrollPolicy.ON || param2 < param1 && param1 > 0 && _loc_5 == ScrollPolicy.AUTO)
            {
                if (!horizontalScrollBar)
                {
                    createHScrollBar(false);
                    horizontalScrollBar.addEventListener(ScrollEvent.SCROLL, scrollHandler);
                    horizontalScrollBar.addEventListener(ScrollEvent.SCROLL, scrollTipHandler);
                    horizontalScrollBar.scrollPosition = _horizontalScrollPosition;
                }
                _loc_7 = roomForScrollBar(horizontalScrollBar, unscaledWidth, unscaledHeight);
                if (_loc_7 != horizontalScrollBar.visible)
                {
                    horizontalScrollBar.visible = _loc_7;
                    scrollAreaChanged = true;
                }
                if (horizontalScrollBar && horizontalScrollBar.visible && numberOfCols != param1 || viewableColumns != param2 || scrollAreaChanged)
                {
                    horizontalScrollBar.setScrollProperties(param2, 0, param1 - param2);
                    if (horizontalScrollBar.scrollPosition != _horizontalScrollPosition)
                    {
                        horizontalScrollBar.scrollPosition = _horizontalScrollPosition;
                    }
                    viewableColumns = param2;
                    numberOfCols = param1;
                }
            }
            else if (_loc_5 == ScrollPolicy.AUTO || _loc_5 == ScrollPolicy.OFF && horizontalScrollBar && horizontalScrollBar.visible)
            {
                horizontalScrollPosition = 0;
                horizontalScrollBar.setScrollProperties(param2, 0, 0);
                horizontalScrollBar.visible = false;
                viewableColumns = NaN;
                scrollAreaChanged = true;
            }
            if (_loc_6 == ScrollPolicy.ON || param4 < param3 && param3 > 0 && _loc_6 == ScrollPolicy.AUTO)
            {
                if (!verticalScrollBar)
                {
                    createVScrollBar(false);
                    verticalScrollBar.addEventListener(ScrollEvent.SCROLL, scrollHandler);
                    verticalScrollBar.addEventListener(ScrollEvent.SCROLL, scrollTipHandler);
                    verticalScrollBar.scrollPosition = _verticalScrollPosition;
                }
                _loc_7 = roomForScrollBar(verticalScrollBar, unscaledWidth, unscaledHeight);
                if (_loc_7 != verticalScrollBar.visible)
                {
                    verticalScrollBar.visible = _loc_7;
                    scrollAreaChanged = true;
                }
                if (verticalScrollBar && verticalScrollBar.visible && numberOfRows != param3 || viewableRows != param4 || scrollAreaChanged)
                {
                    verticalScrollBar.setScrollProperties(param4, 0, param3 - param4);
                    if (verticalScrollBar.scrollPosition != _verticalScrollPosition)
                    {
                        verticalScrollBar.scrollPosition = _verticalScrollPosition;
                    }
                    viewableRows = param4;
                    numberOfRows = param3;
                }
            }
            else if (_loc_6 == ScrollPolicy.AUTO || _loc_6 == ScrollPolicy.OFF && verticalScrollBar && verticalScrollBar.visible)
            {
                verticalScrollPosition = 0;
                verticalScrollBar.setScrollProperties(param4, 0, 0);
                verticalScrollBar.visible = false;
                viewableRows = NaN;
                scrollAreaChanged = true;
            }
            if (scrollAreaChanged)
            {
                updateDisplayList(unscaledWidth, unscaledHeight);
            }
            return;
        }// end function

        private function createHScrollBar(param1:Boolean) : ScrollBar
        {
            horizontalScrollBar = new HScrollBar();
            horizontalScrollBar.visible = param1;
            horizontalScrollBar.enabled = enabled;
            var _loc_2:* = getStyle("horizontalScrollBarStyleName");
            horizontalScrollBar.styleName = _loc_2;
            addChild(horizontalScrollBar);
            horizontalScrollBar.validateNow();
            return horizontalScrollBar;
        }// end function

        public function get horizontalScrollPolicy() : String
        {
            return _horizontalScrollPolicy;
        }// end function

        public function get maxVerticalScrollPosition() : Number
        {
            if (!isNaN(_maxVerticalScrollPosition))
            {
                return _maxVerticalScrollPosition;
            }
            var _loc_1:* = verticalScrollBar ? (verticalScrollBar.maxScrollPosition) : (0);
            return _loc_1;
        }// end function

        public function set horizontalScrollPosition(param1:Number) : void
        {
            _horizontalScrollPosition = param1;
            if (horizontalScrollBar)
            {
                horizontalScrollBar.scrollPosition = param1;
            }
            dispatchEvent(new Event("viewChanged"));
            return;
        }// end function

        protected function roomForScrollBar(param1:ScrollBar, param2:Number, param3:Number) : Boolean
        {
            var _loc_4:* = borderMetrics;
            if (param2 >= param1.minWidth + _loc_4.left + _loc_4.right)
            {
            }
            return param3 >= param1.minHeight + _loc_4.top + _loc_4.bottom;
        }// end function

        public function set maxHorizontalScrollPosition(param1:Number) : void
        {
            _maxHorizontalScrollPosition = param1;
            dispatchEvent(new Event("maxHorizontalScrollPositionChanged"));
            return;
        }// end function

        public function get verticalScrollPosition() : Number
        {
            return _verticalScrollPosition;
        }// end function

        public function set horizontalScrollPolicy(param1:String) : void
        {
            var _loc_2:* = param1.toLowerCase();
            if (_horizontalScrollPolicy != _loc_2)
            {
                _horizontalScrollPolicy = _loc_2;
                invalidateDisplayList();
                dispatchEvent(new Event("horizontalScrollPolicyChanged"));
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:Graphics = null;
            super.createChildren();
            createBorder();
            if (!maskShape)
            {
                maskShape = new FlexShape();
                maskShape.name = "mask";
                _loc_1 = maskShape.graphics;
                _loc_1.beginFill(16777215);
                _loc_1.drawRect(0, 0, 10, 10);
                _loc_1.endFill();
                addChild(maskShape);
            }
            maskShape.visible = false;
            return;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            var _loc_3:String = null;
            var _loc_4:String = null;
            if (param1 != null)
            {
            }
            var _loc_2:* = param1 == "styleName";
            super.styleChanged(param1);
            if (_loc_2 || param1 == "horizontalScrollBarStyleName")
            {
                if (horizontalScrollBar)
                {
                    _loc_3 = getStyle("horizontalScrollBarStyleName");
                    horizontalScrollBar.styleName = _loc_3;
                }
            }
            if (_loc_2 || param1 == "verticalScrollBarStyleName")
            {
                if (verticalScrollBar)
                {
                    _loc_4 = getStyle("verticalScrollBarStyleName");
                    verticalScrollBar.styleName = _loc_4;
                }
            }
            if (_loc_2 || param1 == "borderSkin")
            {
                if (border)
                {
                    removeChild(DisplayObject(border));
                    border = null;
                    createBorder();
                }
            }
            return;
        }// end function

        private function createVScrollBar(param1:Boolean) : ScrollBar
        {
            verticalScrollBar = new VScrollBar();
            verticalScrollBar.visible = param1;
            verticalScrollBar.enabled = enabled;
            var _loc_2:* = getStyle("verticalScrollBarStyleName");
            verticalScrollBar.styleName = _loc_2;
            addChild(verticalScrollBar);
            return verticalScrollBar;
        }// end function

        function get scroll_verticalScrollBar() : ScrollBar
        {
            return verticalScrollBar;
        }// end function

        protected function createBorder() : void
        {
            var _loc_1:Class = null;
            if (!border && isBorderNeeded())
            {
                _loc_1 = getStyle("borderSkin");
                if (_loc_1 != null)
                {
                    border = new _loc_1;
                    if (border is IUIComponent)
                    {
                        IUIComponent(border).enabled = enabled;
                    }
                    if (border is ISimpleStyleClient)
                    {
                        ISimpleStyleClient(border).styleName = this;
                    }
                    addChildAt(DisplayObject(border), 0);
                    invalidateDisplayList();
                }
            }
            return;
        }// end function

        function get scroll_horizontalScrollBar() : ScrollBar
        {
            return horizontalScrollBar;
        }// end function

        protected function layoutChrome(param1:Number, param2:Number) : void
        {
            if (border)
            {
                border.move(0, 0);
                border.setActualSize(param1, param2);
            }
            return;
        }// end function

        protected function scrollHandler(event:Event) : void
        {
            var _loc_2:ScrollBar = null;
            var _loc_3:Number = NaN;
            var _loc_4:QName = null;
            if (event is ScrollEvent)
            {
                _loc_2 = ScrollBar(event.target);
                _loc_3 = _loc_2.scrollPosition;
                if (_loc_2 == verticalScrollBar)
                {
                    _loc_4 = new QName(mx_internal, "_verticalScrollPosition");
                }
                else if (_loc_2 == horizontalScrollBar)
                {
                    _loc_4 = new QName(mx_internal, "_horizontalScrollPosition");
                }
                dispatchEvent(event);
                if (_loc_4)
                {
                    this[_loc_4] = _loc_3;
                }
            }
            return;
        }// end function

        protected function mouseWheelHandler(event:MouseEvent) : void
        {
            var _loc_2:int = 0;
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            var _loc_5:ScrollEvent = null;
            if (verticalScrollBar && verticalScrollBar.visible)
            {
                event.stopPropagation();
                _loc_2 = event.delta <= 0 ? (1) : (-1);
                _loc_3 = Math.max(Math.abs(event.delta), verticalScrollBar.lineScrollSize);
                _loc_4 = verticalScrollPosition;
                verticalScrollPosition = verticalScrollPosition + 3 * _loc_3 * _loc_2;
                _loc_5 = new ScrollEvent(ScrollEvent.SCROLL);
                _loc_5.direction = ScrollEventDirection.VERTICAL;
                _loc_5.position = verticalScrollPosition;
                _loc_5.delta = verticalScrollPosition - _loc_4;
                dispatchEvent(_loc_5);
            }
            return;
        }// end function

        private function scrollTipHandler(event:Event) : void
        {
            var _loc_2:ScrollBar = null;
            var _loc_3:Boolean = false;
            var _loc_4:String = null;
            var _loc_5:Number = NaN;
            var _loc_6:String = null;
            var _loc_7:Point = null;
            if (event is ScrollEvent)
            {
                if (!showScrollTips)
                {
                    return;
                }
                if (ScrollEvent(event).detail == ScrollEventDetail.THUMB_POSITION)
                {
                    if (scrollTip)
                    {
                        systemManager.topLevelSystemManager.removeChildFromSandboxRoot("toolTipChildren", scrollTip as DisplayObject);
                        scrollTip = null;
                        ToolTipManager.enabled = oldTTMEnabled;
                    }
                }
                else if (ScrollEvent(event).detail == ScrollEventDetail.THUMB_TRACK)
                {
                    _loc_2 = ScrollBar(event.target);
                    _loc_3 = _loc_2 == verticalScrollBar;
                    _loc_4 = _loc_3 ? ("vertical") : ("horizontal");
                    _loc_5 = _loc_2.scrollPosition;
                    if (!scrollTip)
                    {
                        scrollTip = new ToolTip();
                        systemManager.topLevelSystemManager.addChildToSandboxRoot("toolTipChildren", scrollTip as DisplayObject);
                        scrollThumbMidPoint = _loc_2.scrollThumb.height / 2;
                        oldTTMEnabled = ToolTipManager.enabled;
                        ToolTipManager.enabled = false;
                    }
                    _loc_6 = _loc_5.toString();
                    if (_scrollTipFunction != null)
                    {
                        _loc_6 = _scrollTipFunction(_loc_4, _loc_5);
                    }
                    if (_loc_6 == "")
                    {
                        scrollTip.visible = false;
                    }
                    else
                    {
                        scrollTip.text = _loc_6;
                        ToolTipManager.sizeTip(scrollTip);
                        _loc_7 = new Point();
                        if (_loc_3)
                        {
                            _loc_7.x = -3 - scrollTip.width;
                            _loc_7.y = _loc_2.scrollThumb.y + scrollThumbMidPoint - scrollTip.height / 2;
                        }
                        else
                        {
                            _loc_7.x = -3 - scrollTip.height;
                            _loc_7.y = _loc_2.scrollThumb.y + scrollThumbMidPoint - scrollTip.width / 2;
                        }
                        _loc_7 = _loc_2.localToGlobal(_loc_7);
                        scrollTip.move(_loc_7.x, _loc_7.y);
                        scrollTip.visible = true;
                    }
                }
            }
            return;
        }// end function

        public function set verticalScrollPosition(param1:Number) : void
        {
            _verticalScrollPosition = param1;
            if (verticalScrollBar)
            {
                verticalScrollBar.scrollPosition = param1;
            }
            dispatchEvent(new Event("viewChanged"));
            return;
        }// end function

        public function get horizontalScrollPosition() : Number
        {
            return _horizontalScrollPosition;
        }// end function

        private function isBorderNeeded() : Boolean
        {
            var _loc_1:* = getStyle("borderStyle");
            if (_loc_1)
            {
                if (_loc_1 != "none" || _loc_1 == "none" && getStyle("mouseShield"))
                {
                    return true;
                }
            }
            _loc_1 = getStyle("backgroundColor");
            if (_loc_1 !== null && _loc_1 !== "")
            {
                return true;
            }
            _loc_1 = getStyle("backgroundImage");
            if (_loc_1 != null)
            {
            }
            return _loc_1 != "";
        }// end function

        public function get maxHorizontalScrollPosition() : Number
        {
            if (!isNaN(_maxHorizontalScrollPosition))
            {
                return _maxHorizontalScrollPosition;
            }
            var _loc_1:* = horizontalScrollBar ? (horizontalScrollBar.maxScrollPosition) : (0);
            return _loc_1;
        }// end function

        public function set maxVerticalScrollPosition(param1:Number) : void
        {
            _maxVerticalScrollPosition = param1;
            dispatchEvent(new Event("maxVerticalScrollPositionChanged"));
            return;
        }// end function

        public function set verticalScrollPolicy(param1:String) : void
        {
            var _loc_2:* = param1.toLowerCase();
            if (_verticalScrollPolicy != _loc_2)
            {
                _verticalScrollPolicy = _loc_2;
                invalidateDisplayList();
                dispatchEvent(new Event("verticalScrollPolicyChanged"));
            }
            return;
        }// end function

        public function get viewMetrics() : EdgeMetrics
        {
            _viewMetrics = borderMetrics.clone();
            if (!horizontalScrollBar && horizontalScrollPolicy == ScrollPolicy.ON)
            {
                createHScrollBar(true);
                horizontalScrollBar.addEventListener(ScrollEvent.SCROLL, scrollHandler);
                horizontalScrollBar.addEventListener(ScrollEvent.SCROLL, scrollTipHandler);
                horizontalScrollBar.scrollPosition = _horizontalScrollPosition;
                invalidateDisplayList();
            }
            if (!verticalScrollBar && verticalScrollPolicy == ScrollPolicy.ON)
            {
                createVScrollBar(true);
                verticalScrollBar.addEventListener(ScrollEvent.SCROLL, scrollHandler);
                verticalScrollBar.addEventListener(ScrollEvent.SCROLL, scrollTipHandler);
                verticalScrollBar.scrollPosition = _verticalScrollPosition;
                invalidateDisplayList();
            }
            if (verticalScrollBar && verticalScrollBar.visible)
            {
                _viewMetrics.right = _viewMetrics.right + verticalScrollBar.minWidth;
            }
            if (horizontalScrollBar && horizontalScrollBar.visible)
            {
                _viewMetrics.bottom = _viewMetrics.bottom + horizontalScrollBar.minHeight;
            }
            return _viewMetrics;
        }// end function

        public function get verticalScrollPolicy() : String
        {
            return _verticalScrollPolicy;
        }// end function

        public function get borderMetrics() : EdgeMetrics
        {
            if (border)
            {
            }
            return border is IRectangularBorder ? (IRectangularBorder(border).borderMetrics) : (EdgeMetrics.EMPTY);
        }// end function

    }
}
