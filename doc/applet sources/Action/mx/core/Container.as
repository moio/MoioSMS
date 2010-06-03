package mx.core
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;
    import mx.binding.*;
    import mx.controls.*;
    import mx.controls.scrollClasses.*;
    import mx.events.*;
    import mx.graphics.*;
    import mx.managers.*;
    import mx.styles.*;

    public class Container extends UIComponent implements IContainer, IDataRenderer, IFocusManagerContainer, IListItemRenderer, IRawChildrenContainer
    {
        private var forceLayout:Boolean = false;
        private var _numChildrenCreated:int = -1;
        private var _horizontalLineScrollSize:Number = 5;
        var border:IFlexDisplayObject;
        protected var actualCreationPolicy:String;
        private var _viewMetricsAndPadding:EdgeMetrics;
        private var _creatingContentPane:Boolean = false;
        private var _childRepeaters:Array;
        private var scrollableWidth:Number = 0;
        private var _childDescriptors:Array;
        private var _rawChildren:ContainerRawChildrenList;
        private var _data:Object;
        private var _verticalPageScrollSize:Number = 0;
        private var _viewMetrics:EdgeMetrics;
        private var _verticalScrollBar:ScrollBar;
        private var scrollPropertiesChanged:Boolean = false;
        private var changedStyles:String = null;
        private var scrollPositionChanged:Boolean = true;
        private var _defaultButton:IFlexDisplayObject;
        private var mouseEventReferenceCount:int = 0;
        private var _focusPane:Sprite;
        protected var whiteBox:Shape;
        private var _forceClippingCount:int;
        private var _horizontalPageScrollSize:Number = 0;
        private var _creationPolicy:String;
        private var _creationIndex:int = -1;
        private var _clipContent:Boolean = true;
        private var _verticalScrollPosition:Number = 0;
        private var _autoLayout:Boolean = true;
        private var _icon:Class = null;
        var doingLayout:Boolean = false;
        private var _horizontalScrollBar:ScrollBar;
        private var numChildrenBefore:int;
        private var viewableHeight:Number = 0;
        private var viewableWidth:Number = 0;
        var contentPane:Sprite = null;
        private var _createdComponents:Array;
        private var _firstChildIndex:int = 0;
        private var scrollableHeight:Number = 0;
        private var _verticalLineScrollSize:Number = 5;
        private var _horizontalScrollPosition:Number = 0;
        var _horizontalScrollPolicy:String = "auto";
        private var verticalScrollPositionPending:Number;
        var _verticalScrollPolicy:String = "auto";
        private var horizontalScrollPositionPending:Number;
        var _numChildren:int = 0;
        private var recursionFlag:Boolean = true;
        private var _label:String = "";
        var blocker:Sprite;
        static const VERSION:String = "3.2.0.3958";
        private static const MULTIPLE_PROPERTIES:String = "<MULTIPLE>";

        public function Container()
        {
            tabChildren = true;
            tabEnabled = false;
            showInAutomationHierarchy = false;
            return;
        }// end function

        public function set verticalScrollPolicy(param1:String) : void
        {
            if (_verticalScrollPolicy != param1)
            {
                _verticalScrollPolicy = param1;
                invalidateDisplayList();
                dispatchEvent(new Event("verticalScrollPolicyChanged"));
            }
            return;
        }// end function

        private function createContentPaneAndScrollbarsIfNeeded() : Boolean
        {
            var _loc_1:Rectangle = null;
            var _loc_2:Boolean = false;
            if (_clipContent)
            {
                _loc_1 = getScrollableRect();
                _loc_2 = createScrollbarsIfNeeded(_loc_1);
                if (border)
                {
                    updateBackgroundImageRect();
                }
                return _loc_2;
            }
            else
            {
                _loc_2 = createOrDestroyScrollbars(false, false, false);
                _loc_1 = getScrollableRect();
                scrollableWidth = _loc_1.right;
                scrollableHeight = _loc_1.bottom;
                if (_loc_2 && border)
                {
                    updateBackgroundImageRect();
                }
                return _loc_2;
            }
        }// end function

        override protected function initializationComplete() : void
        {
            return;
        }// end function

        function rawChildren_getObjectsUnderPoint(param1:Point) : Array
        {
            return super.getObjectsUnderPoint(param1);
        }// end function

        public function set creatingContentPane(param1:Boolean) : void
        {
            _creatingContentPane = param1;
            return;
        }// end function

        public function set clipContent(param1:Boolean) : void
        {
            if (_clipContent != param1)
            {
                _clipContent = param1;
                invalidateDisplayList();
            }
            return;
        }// end function

        protected function scrollChildren() : void
        {
            if (!contentPane)
            {
                return;
            }
            var _loc_1:* = viewMetrics;
            var _loc_2:Number = 0;
            var _loc_3:Number = 0;
            var _loc_4:* = unscaledWidth - _loc_1.left - _loc_1.right;
            var _loc_5:* = unscaledHeight - _loc_1.top - _loc_1.bottom;
            if (_clipContent)
            {
                _loc_2 = _loc_2 + _horizontalScrollPosition;
                if (horizontalScrollBar)
                {
                    _loc_4 = viewableWidth;
                }
                _loc_3 = _loc_3 + _verticalScrollPosition;
                if (verticalScrollBar)
                {
                    _loc_5 = viewableHeight;
                }
            }
            else
            {
                _loc_4 = scrollableWidth;
                _loc_5 = scrollableHeight;
            }
            var _loc_6:* = getScrollableRect();
            if (_loc_2 == 0 && _loc_3 == 0 && _loc_4 >= _loc_6.right && _loc_5 >= _loc_6.bottom && _loc_6.left >= 0 && _loc_6.top >= 0 && _forceClippingCount <= 0)
            {
                contentPane.scrollRect = null;
                contentPane.opaqueBackground = null;
                contentPane.cacheAsBitmap = false;
            }
            else
            {
                contentPane.scrollRect = new Rectangle(_loc_2, _loc_3, _loc_4, _loc_5);
            }
            if (focusPane)
            {
                focusPane.scrollRect = contentPane.scrollRect;
            }
            if (border && border is IRectangularBorder && IRectangularBorder(border).hasBackgroundImage)
            {
                IRectangularBorder(border).layoutBackgroundImage();
            }
            return;
        }// end function

        override public function set doubleClickEnabled(param1:Boolean) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:InteractiveObject = null;
            super.doubleClickEnabled = param1;
            if (contentPane)
            {
                _loc_2 = contentPane.numChildren;
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    _loc_4 = contentPane.getChildAt(_loc_3) as InteractiveObject;
                    if (_loc_4)
                    {
                        _loc_4.doubleClickEnabled = param1;
                    }
                    _loc_3++;
                }
            }
            return;
        }// end function

        override public function notifyStyleChangeInChildren(param1:String, param2:Boolean) : void
        {
            var _loc_5:ISimpleStyleClient = null;
            var _loc_3:* = super.numChildren;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (contentPane || _loc_4 < _firstChildIndex || _loc_4 >= _firstChildIndex + _numChildren)
                {
                    _loc_5 = super.getChildAt(_loc_4) as ISimpleStyleClient;
                    if (_loc_5)
                    {
                        _loc_5.styleChanged(param1);
                        if (_loc_5 is IStyleClient)
                        {
                            IStyleClient(_loc_5).notifyStyleChangeInChildren(param1, param2);
                        }
                    }
                }
                _loc_4++;
            }
            if (param2)
            {
                if (changedStyles == null)
                {
                }
                changedStyles = param1 == null ? (MULTIPLE_PROPERTIES) : (param1);
                invalidateProperties();
            }
            return;
        }// end function

        function get createdComponents() : Array
        {
            return _createdComponents;
        }// end function

        public function get childDescriptors() : Array
        {
            return _childDescriptors;
        }// end function

        override public function get contentMouseY() : Number
        {
            if (contentPane)
            {
                return contentPane.mouseY;
            }
            return super.contentMouseY;
        }// end function

        function get childRepeaters() : Array
        {
            return _childRepeaters;
        }// end function

        override public function contains(param1:DisplayObject) : Boolean
        {
            if (contentPane)
            {
                return contentPane.contains(param1);
            }
            return super.contains(param1);
        }// end function

        override public function get contentMouseX() : Number
        {
            if (contentPane)
            {
                return contentPane.mouseX;
            }
            return super.contentMouseX;
        }// end function

        function set createdComponents(param1:Array) : void
        {
            _createdComponents = param1;
            return;
        }// end function

        public function get horizontalScrollBar() : ScrollBar
        {
            return _horizontalScrollBar;
        }// end function

        override public function validateSize(param1:Boolean = false) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:DisplayObject = null;
            if (autoLayout == false && forceLayout == false)
            {
                if (param1)
                {
                    _loc_2 = super.numChildren;
                    _loc_3 = 0;
                    while (_loc_3 < _loc_2)
                    {
                        
                        _loc_4 = super.getChildAt(_loc_3);
                        if (_loc_4 is ILayoutManagerClient)
                        {
                            ILayoutManagerClient(_loc_4).validateSize(true);
                        }
                        _loc_3++;
                    }
                }
                adjustSizesForScaleChanges();
            }
            else
            {
                super.validateSize(param1);
            }
            return;
        }// end function

        public function get rawChildren() : IChildList
        {
            if (!_rawChildren)
            {
                _rawChildren = new ContainerRawChildrenList(this);
            }
            return _rawChildren;
        }// end function

        override public function getChildAt(param1:int) : DisplayObject
        {
            if (contentPane)
            {
                return contentPane.getChildAt(param1);
            }
            return super.getChildAt(_firstChildIndex + param1);
        }// end function

        override protected function attachOverlay() : void
        {
            rawChildren_addChild(overlay);
            return;
        }// end function

        override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            super.addEventListener(param1, param2, param3, param4, param5);
            if (param1 == MouseEvent.CLICK || param1 == MouseEvent.DOUBLE_CLICK || param1 == MouseEvent.MOUSE_DOWN || param1 == MouseEvent.MOUSE_MOVE || param1 == MouseEvent.MOUSE_OVER || param1 == MouseEvent.MOUSE_OUT || param1 == MouseEvent.MOUSE_UP || param1 == MouseEvent.MOUSE_WHEEL)
            {
                if (mouseEventReferenceCount < 2147483647 && mouseEventReferenceCount++ == 0)
                {
                    setStyle("mouseShield", true);
                    setStyle("mouseShieldChildren", true);
                }
            }
            return;
        }// end function

        override public function localToContent(param1:Point) : Point
        {
            if (!contentPane)
            {
                return param1;
            }
            param1 = localToGlobal(param1);
            return globalToContent(param1);
        }// end function

        public function executeChildBindings(param1:Boolean) : void
        {
            var _loc_4:IUIComponent = null;
            var _loc_2:* = numChildren;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = IUIComponent(getChildAt(_loc_3));
                if (_loc_4 is IDeferredInstantiationUIComponent)
                {
                    IDeferredInstantiationUIComponent(_loc_4).executeBindings(param1);
                }
                _loc_3++;
            }
            return;
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
                    border.name = "border";
                    if (border is IUIComponent)
                    {
                        IUIComponent(border).enabled = enabled;
                    }
                    if (border is ISimpleStyleClient)
                    {
                        ISimpleStyleClient(border).styleName = this;
                    }
                    rawChildren.addChildAt(DisplayObject(border), 0);
                    invalidateDisplayList();
                }
            }
            return;
        }// end function

        public function get verticalScrollPosition() : Number
        {
            if (!isNaN(verticalScrollPositionPending))
            {
                return verticalScrollPositionPending;
            }
            return _verticalScrollPosition;
        }// end function

        public function get horizontalScrollPosition() : Number
        {
            if (!isNaN(horizontalScrollPositionPending))
            {
                return horizontalScrollPositionPending;
            }
            return _horizontalScrollPosition;
        }// end function

        protected function layoutChrome(param1:Number, param2:Number) : void
        {
            if (border)
            {
                updateBackgroundImageRect();
                border.move(0, 0);
                border.setActualSize(param1, param2);
            }
            return;
        }// end function

        function set childRepeaters(param1:Array) : void
        {
            _childRepeaters = param1;
            return;
        }// end function

        override public function get focusPane() : Sprite
        {
            return _focusPane;
        }// end function

        public function set creationIndex(param1:int) : void
        {
            _creationIndex = param1;
            return;
        }// end function

        public function get viewMetrics() : EdgeMetrics
        {
            var _loc_1:* = borderMetrics;
            if (!(verticalScrollBar != null && doingLayout))
            {
            }
            var _loc_2:* = verticalScrollPolicy == ScrollPolicy.ON;
            if (!(horizontalScrollBar != null && doingLayout))
            {
            }
            var _loc_3:* = horizontalScrollPolicy == ScrollPolicy.ON;
            if (!_loc_2 && !_loc_3)
            {
                return _loc_1;
            }
            if (!_viewMetrics)
            {
                _viewMetrics = _loc_1.clone();
            }
            else
            {
                _viewMetrics.left = _loc_1.left;
                _viewMetrics.right = _loc_1.right;
                _viewMetrics.top = _loc_1.top;
                _viewMetrics.bottom = _loc_1.bottom;
            }
            if (_loc_2)
            {
                _viewMetrics.right = _viewMetrics.right + verticalScrollBar.minWidth;
            }
            if (_loc_3)
            {
                _viewMetrics.bottom = _viewMetrics.bottom + horizontalScrollBar.minHeight;
            }
            return _viewMetrics;
        }// end function

        public function set verticalScrollBar(param1:ScrollBar) : void
        {
            _verticalScrollBar = param1;
            return;
        }// end function

        public function set verticalScrollPosition(param1:Number) : void
        {
            if (_verticalScrollPosition == param1)
            {
                return;
            }
            _verticalScrollPosition = param1;
            scrollPositionChanged = true;
            if (!initialized)
            {
                verticalScrollPositionPending = param1;
            }
            invalidateDisplayList();
            dispatchEvent(new Event("viewChanged"));
            return;
        }// end function

        private function createOrDestroyScrollbars(param1:Boolean, param2:Boolean, param3:Boolean) : Boolean
        {
            var _loc_5:IFocusManager = null;
            var _loc_6:String = null;
            var _loc_7:String = null;
            var _loc_8:Graphics = null;
            var _loc_4:Boolean = false;
            if (param1 || param2 || param3)
            {
                createContentPane();
            }
            if (param1)
            {
                if (!horizontalScrollBar)
                {
                    horizontalScrollBar = new HScrollBar();
                    horizontalScrollBar.name = "horizontalScrollBar";
                    _loc_6 = getStyle("horizontalScrollBarStyleName");
                    if (_loc_6 && horizontalScrollBar is ISimpleStyleClient)
                    {
                        ISimpleStyleClient(horizontalScrollBar).styleName = _loc_6;
                    }
                    rawChildren.addChild(DisplayObject(horizontalScrollBar));
                    horizontalScrollBar.lineScrollSize = horizontalLineScrollSize;
                    horizontalScrollBar.pageScrollSize = horizontalPageScrollSize;
                    horizontalScrollBar.addEventListener(ScrollEvent.SCROLL, horizontalScrollBar_scrollHandler);
                    horizontalScrollBar.enabled = enabled;
                    if (horizontalScrollBar is IInvalidating)
                    {
                        IInvalidating(horizontalScrollBar).validateNow();
                    }
                    invalidateDisplayList();
                    invalidateViewMetricsAndPadding();
                    _loc_4 = true;
                    if (!verticalScrollBar)
                    {
                        addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
                    }
                }
            }
            else if (horizontalScrollBar)
            {
                horizontalScrollBar.removeEventListener(ScrollEvent.SCROLL, horizontalScrollBar_scrollHandler);
                rawChildren.removeChild(DisplayObject(horizontalScrollBar));
                horizontalScrollBar = null;
                var _loc_9:int = 0;
                scrollableWidth = 0;
                viewableWidth = _loc_9;
                if (_horizontalScrollPosition != 0)
                {
                    _horizontalScrollPosition = 0;
                    scrollPositionChanged = true;
                }
                invalidateDisplayList();
                invalidateViewMetricsAndPadding();
                _loc_4 = true;
                _loc_5 = focusManager;
                if (!verticalScrollBar && !_loc_5 || _loc_5.getFocus() != this)
                {
                    removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
                }
            }
            if (param2)
            {
                if (!verticalScrollBar)
                {
                    verticalScrollBar = new VScrollBar();
                    verticalScrollBar.name = "verticalScrollBar";
                    _loc_7 = getStyle("verticalScrollBarStyleName");
                    if (_loc_7 && verticalScrollBar is ISimpleStyleClient)
                    {
                        ISimpleStyleClient(verticalScrollBar).styleName = _loc_7;
                    }
                    rawChildren.addChild(DisplayObject(verticalScrollBar));
                    verticalScrollBar.lineScrollSize = verticalLineScrollSize;
                    verticalScrollBar.pageScrollSize = verticalPageScrollSize;
                    verticalScrollBar.addEventListener(ScrollEvent.SCROLL, verticalScrollBar_scrollHandler);
                    verticalScrollBar.enabled = enabled;
                    if (verticalScrollBar is IInvalidating)
                    {
                        IInvalidating(verticalScrollBar).validateNow();
                    }
                    invalidateDisplayList();
                    invalidateViewMetricsAndPadding();
                    _loc_4 = true;
                    if (!horizontalScrollBar)
                    {
                        addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
                    }
                    addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
                }
            }
            else if (verticalScrollBar)
            {
                verticalScrollBar.removeEventListener(ScrollEvent.SCROLL, verticalScrollBar_scrollHandler);
                rawChildren.removeChild(DisplayObject(verticalScrollBar));
                verticalScrollBar = null;
                var _loc_9:int = 0;
                scrollableHeight = 0;
                viewableHeight = _loc_9;
                if (_verticalScrollPosition != 0)
                {
                    _verticalScrollPosition = 0;
                    scrollPositionChanged = true;
                }
                invalidateDisplayList();
                invalidateViewMetricsAndPadding();
                _loc_4 = true;
                _loc_5 = focusManager;
                if (!horizontalScrollBar && !_loc_5 || _loc_5.getFocus() != this)
                {
                    removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
                }
                removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
            }
            if (horizontalScrollBar && verticalScrollBar)
            {
                if (!whiteBox)
                {
                    whiteBox = new FlexShape();
                    whiteBox.name = "whiteBox";
                    _loc_8 = whiteBox.graphics;
                    _loc_8.beginFill(16777215);
                    _loc_8.drawRect(0, 0, verticalScrollBar.minWidth, horizontalScrollBar.minHeight);
                    _loc_8.endFill();
                    rawChildren.addChild(whiteBox);
                }
            }
            else if (whiteBox)
            {
                rawChildren.removeChild(whiteBox);
                whiteBox = null;
            }
            return _loc_4;
        }// end function

        override protected function keyDownHandler(event:KeyboardEvent) : void
        {
            var _loc_3:String = null;
            var _loc_4:Number = NaN;
            var _loc_2:* = getFocus();
            if (_loc_2 is TextField)
            {
                return;
            }
            if (verticalScrollBar)
            {
                _loc_3 = ScrollEventDirection.VERTICAL;
                _loc_4 = verticalScrollPosition;
                switch(event.keyCode)
                {
                    case Keyboard.DOWN:
                    {
                        verticalScrollPosition = verticalScrollPosition + verticalLineScrollSize;
                        dispatchScrollEvent(_loc_3, _loc_4, verticalScrollPosition, ScrollEventDetail.LINE_DOWN);
                        event.stopPropagation();
                        break;
                    }
                    case Keyboard.UP:
                    {
                        verticalScrollPosition = verticalScrollPosition - verticalLineScrollSize;
                        dispatchScrollEvent(_loc_3, _loc_4, verticalScrollPosition, ScrollEventDetail.LINE_UP);
                        event.stopPropagation();
                        break;
                    }
                    case Keyboard.PAGE_UP:
                    {
                        verticalScrollPosition = verticalScrollPosition - verticalPageScrollSize;
                        dispatchScrollEvent(_loc_3, _loc_4, verticalScrollPosition, ScrollEventDetail.PAGE_UP);
                        event.stopPropagation();
                        break;
                    }
                    case Keyboard.PAGE_DOWN:
                    {
                        verticalScrollPosition = verticalScrollPosition + verticalPageScrollSize;
                        dispatchScrollEvent(_loc_3, _loc_4, verticalScrollPosition, ScrollEventDetail.PAGE_DOWN);
                        event.stopPropagation();
                        break;
                    }
                    case Keyboard.HOME:
                    {
                        verticalScrollPosition = verticalScrollBar.minScrollPosition;
                        dispatchScrollEvent(_loc_3, _loc_4, verticalScrollPosition, ScrollEventDetail.AT_TOP);
                        event.stopPropagation();
                        break;
                    }
                    case Keyboard.END:
                    {
                        verticalScrollPosition = verticalScrollBar.maxScrollPosition;
                        dispatchScrollEvent(_loc_3, _loc_4, verticalScrollPosition, ScrollEventDetail.AT_BOTTOM);
                        event.stopPropagation();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            if (horizontalScrollBar)
            {
                _loc_3 = ScrollEventDirection.HORIZONTAL;
                _loc_4 = horizontalScrollPosition;
                switch(event.keyCode)
                {
                    case Keyboard.LEFT:
                    {
                        horizontalScrollPosition = horizontalScrollPosition - horizontalLineScrollSize;
                        dispatchScrollEvent(_loc_3, _loc_4, horizontalScrollPosition, ScrollEventDetail.LINE_LEFT);
                        event.stopPropagation();
                        break;
                    }
                    case Keyboard.RIGHT:
                    {
                        horizontalScrollPosition = horizontalScrollPosition + horizontalLineScrollSize;
                        dispatchScrollEvent(_loc_3, _loc_4, horizontalScrollPosition, ScrollEventDetail.LINE_RIGHT);
                        event.stopPropagation();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function get icon() : Class
        {
            return _icon;
        }// end function

        private function createOrDestroyBlocker() : void
        {
            var _loc_1:DisplayObject = null;
            var _loc_2:ISystemManager = null;
            if (enabled)
            {
                if (blocker)
                {
                    rawChildren.removeChild(blocker);
                    blocker = null;
                }
            }
            else if (!blocker)
            {
                blocker = new FlexSprite();
                blocker.name = "blocker";
                blocker.mouseEnabled = true;
                rawChildren.addChild(blocker);
                blocker.addEventListener(MouseEvent.CLICK, blocker_clickHandler);
                _loc_1 = focusManager ? (DisplayObject(focusManager.getFocus())) : (null);
                while (_loc_1)
                {
                    
                    if (_loc_1 == this)
                    {
                        _loc_2 = systemManager;
                        if (_loc_2 && _loc_2.stage)
                        {
                            _loc_2.stage.focus = null;
                        }
                        break;
                    }
                    _loc_1 = _loc_1.parent;
                }
            }
            return;
        }// end function

        private function horizontalScrollBar_scrollHandler(event:Event) : void
        {
            var _loc_2:Number = NaN;
            if (event is ScrollEvent)
            {
                _loc_2 = horizontalScrollPosition;
                horizontalScrollPosition = horizontalScrollBar.scrollPosition;
                dispatchScrollEvent(ScrollEventDirection.HORIZONTAL, _loc_2, horizontalScrollPosition, ScrollEvent(event).detail);
            }
            return;
        }// end function

        public function createComponentFromDescriptor(param1:ComponentDescriptor, param2:Boolean) : IFlexDisplayObject
        {
            var _loc_7:String = null;
            var _loc_10:IRepeaterClient = null;
            var _loc_11:IStyleClient = null;
            var _loc_12:String = null;
            var _loc_13:String = null;
            var _loc_3:* = UIComponentDescriptor(param1);
            var _loc_4:* = _loc_3.properties;
            if (numChildrenBefore != 0 || numChildrenCreated != -1 && _loc_3.instanceIndices == null && hasChildMatchingDescriptor(_loc_3))
            {
                return null;
            }
            UIComponentGlobals.layoutManager.usePhasedInstantiation = true;
            var _loc_5:* = _loc_3.type;
            var _loc_6:* = new _loc_3.type;
            new _loc_3.type.id = _loc_3.id;
            if (_loc_6.id && _loc_6.id != "")
            {
                _loc_6.name = _loc_6.id;
            }
            _loc_6.descriptor = _loc_3;
            if (_loc_4.childDescriptors && _loc_6 is Container)
            {
                Container(_loc_6)._childDescriptors = _loc_4.childDescriptors;
                delete _loc_4.childDescriptors;
            }
            for (_loc_7 in _loc_4)
            {
                
                _loc_6[_loc_7] = _loc_4[_loc_7];
            }
            if (_loc_6 is Container)
            {
                Container(_loc_6).recursionFlag = param2;
            }
            if (_loc_3.instanceIndices)
            {
                if (_loc_6 is IRepeaterClient)
                {
                    _loc_10 = IRepeaterClient(_loc_6);
                    _loc_10.instanceIndices = _loc_3.instanceIndices;
                    _loc_10.repeaters = _loc_3.repeaters;
                    _loc_10.repeaterIndices = _loc_3.repeaterIndices;
                }
            }
            if (_loc_6 is IStyleClient)
            {
                _loc_11 = IStyleClient(_loc_6);
                if (_loc_3.stylesFactory != null)
                {
                    if (!_loc_11.styleDeclaration)
                    {
                        _loc_11.styleDeclaration = new CSSStyleDeclaration();
                    }
                    _loc_11.styleDeclaration.factory = _loc_3.stylesFactory;
                }
            }
            var _loc_8:* = _loc_3.events;
            if (_loc_3.events)
            {
                for (_loc_12 in _loc_8)
                {
                    
                    _loc_13 = _loc_8[_loc_12];
                    _loc_6.addEventListener(_loc_12, _loc_3.document[_loc_13]);
                }
            }
            var _loc_9:* = _loc_3.effects;
            if (_loc_3.effects)
            {
                _loc_6.registerEffects(_loc_9);
            }
            if (_loc_6 is IRepeaterClient)
            {
                IRepeaterClient(_loc_6).initializeRepeaterArrays(this);
            }
            _loc_6.createReferenceOnParentDocument(IFlexDisplayObject(_loc_3.document));
            if (!_loc_6.document)
            {
                _loc_6.document = _loc_3.document;
            }
            if (_loc_6 is IRepeater)
            {
                if (!childRepeaters)
                {
                    childRepeaters = [];
                }
                childRepeaters.push(_loc_6);
                _loc_6.executeBindings();
                IRepeater(_loc_6).initializeRepeater(this, param2);
            }
            else
            {
                addChild(DisplayObject(_loc_6));
                _loc_6.executeBindings();
                if (creationPolicy == ContainerCreationPolicy.QUEUED || creationPolicy == ContainerCreationPolicy.NONE)
                {
                    _loc_6.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
                }
            }
            return _loc_6;
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
            invalidateProperties();
            return;
        }// end function

        public function set horizontalScrollBar(param1:ScrollBar) : void
        {
            _horizontalScrollBar = param1;
            return;
        }// end function

        function get usePadding() : Boolean
        {
            return true;
        }// end function

        override public function get baselinePosition() : Number
        {
            var _loc_2:IUIComponent = null;
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                if (getStyle("verticalAlign") == "top" && numChildren > 0)
                {
                    _loc_2 = getChildAt(0) as IUIComponent;
                    if (_loc_2)
                    {
                        return _loc_2.y + _loc_2.baselinePosition;
                    }
                }
                return super.baselinePosition;
            }
            if (!validateBaselinePosition())
            {
                return NaN;
            }
            var _loc_1:* = measureText("Wj");
            if (height < 2 * viewMetrics.top + 4 + _loc_1.ascent)
            {
                return int(height + (_loc_1.ascent - height) / 2);
            }
            return viewMetrics.top + 2 + _loc_1.ascent;
        }// end function

        override public function getChildByName(param1:String) : DisplayObject
        {
            var _loc_2:DisplayObject = null;
            var _loc_3:int = 0;
            if (contentPane)
            {
                return contentPane.getChildByName(param1);
            }
            _loc_2 = super.getChildByName(param1);
            if (!_loc_2)
            {
                return null;
            }
            _loc_3 = super.getChildIndex(_loc_2) - _firstChildIndex;
            if (_loc_3 < 0 || _loc_3 >= _numChildren)
            {
                return null;
            }
            return _loc_2;
        }// end function

        public function get verticalLineScrollSize() : Number
        {
            return _verticalLineScrollSize;
        }// end function

        public function get horizontalScrollPolicy() : String
        {
            return _horizontalScrollPolicy;
        }// end function

        override public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
        {
            var _loc_3:* = param1.parent;
            if (_loc_3 && !(_loc_3 is Loader))
            {
                if (_loc_3 == this)
                {
                    param2 = param2 == numChildren ? (param2--) : (param2);
                }
                _loc_3.removeChild(param1);
            }
            addingChild(param1);
            if (contentPane)
            {
                contentPane.addChildAt(param1, param2);
            }
            else
            {
                $addChildAt(param1, _firstChildIndex + param2);
            }
            childAdded(param1);
            if (param1 is UIComponent && UIComponent(param1).isDocument)
            {
                BindingManager.setEnabled(param1, true);
            }
            return param1;
        }// end function

        public function get maxVerticalScrollPosition() : Number
        {
            return verticalScrollBar ? (verticalScrollBar.maxScrollPosition) : (Math.max(scrollableHeight - viewableHeight, 0));
        }// end function

        public function set horizontalScrollPosition(param1:Number) : void
        {
            if (_horizontalScrollPosition == param1)
            {
                return;
            }
            _horizontalScrollPosition = param1;
            scrollPositionChanged = true;
            if (!initialized)
            {
                horizontalScrollPositionPending = param1;
            }
            invalidateDisplayList();
            dispatchEvent(new Event("viewChanged"));
            return;
        }// end function

        function invalidateViewMetricsAndPadding() : void
        {
            _viewMetricsAndPadding = null;
            return;
        }// end function

        public function get horizontalLineScrollSize() : Number
        {
            return _horizontalLineScrollSize;
        }// end function

        override public function set focusPane(param1:Sprite) : void
        {
            var _loc_2:* = invalidateSizeFlag;
            var _loc_3:* = invalidateDisplayListFlag;
            invalidateSizeFlag = true;
            invalidateDisplayListFlag = true;
            if (param1)
            {
                rawChildren.addChild(param1);
                param1.x = 0;
                param1.y = 0;
                param1.scrollRect = null;
                _focusPane = param1;
            }
            else
            {
                rawChildren.removeChild(_focusPane);
                _focusPane = null;
            }
            if (param1 && contentPane)
            {
                param1.x = contentPane.x;
                param1.y = contentPane.y;
                param1.scrollRect = contentPane.scrollRect;
            }
            invalidateSizeFlag = _loc_2;
            invalidateDisplayListFlag = _loc_3;
            return;
        }// end function

        private function updateBackgroundImageRect() : void
        {
            var _loc_1:* = border as IRectangularBorder;
            if (!_loc_1)
            {
                return;
            }
            if (viewableWidth == 0 && viewableHeight == 0)
            {
                _loc_1.backgroundImageBounds = null;
                return;
            }
            var _loc_2:* = viewMetrics;
            var _loc_3:* = viewableWidth ? (viewableWidth) : (unscaledWidth - _loc_2.left - _loc_2.right);
            var _loc_4:* = viewableHeight ? (viewableHeight) : (unscaledHeight - _loc_2.top - _loc_2.bottom);
            if (getStyle("backgroundAttachment") == "fixed")
            {
                _loc_1.backgroundImageBounds = new Rectangle(_loc_2.left, _loc_2.top, _loc_3, _loc_4);
            }
            else
            {
                _loc_1.backgroundImageBounds = new Rectangle(_loc_2.left, _loc_2.top, Math.max(scrollableWidth, _loc_3), Math.max(scrollableHeight, _loc_4));
            }
            return;
        }// end function

        private function blocker_clickHandler(event:Event) : void
        {
            event.stopPropagation();
            return;
        }// end function

        private function mouseWheelHandler(event:MouseEvent) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            if (verticalScrollBar)
            {
                event.stopPropagation();
                _loc_2 = event.delta <= 0 ? (1) : (-1);
                _loc_3 = verticalScrollBar ? (verticalScrollBar.lineScrollSize) : (1);
                _loc_4 = Math.max(Math.abs(event.delta), _loc_3);
                _loc_5 = verticalScrollPosition;
                verticalScrollPosition = verticalScrollPosition + 3 * _loc_4 * _loc_2;
                dispatchScrollEvent(ScrollEventDirection.VERTICAL, _loc_5, verticalScrollPosition, event.delta <= 0 ? (ScrollEventDetail.LINE_UP) : (ScrollEventDetail.LINE_DOWN));
            }
            return;
        }// end function

        public function get defaultButton() : IFlexDisplayObject
        {
            return _defaultButton;
        }// end function

        function createContentPane() : void
        {
            var _loc_3:int = 0;
            var _loc_5:IUIComponent = null;
            if (contentPane)
            {
                return;
            }
            creatingContentPane = true;
            var _loc_1:* = numChildren;
            var _loc_2:* = new FlexSprite();
            _loc_2.name = "contentPane";
            _loc_2.tabChildren = true;
            if (border)
            {
                _loc_3 = rawChildren.getChildIndex(DisplayObject(border)) + 1;
                if (border is IRectangularBorder && IRectangularBorder(border).hasBackgroundImage)
                {
                    _loc_3++;
                }
            }
            else
            {
                _loc_3 = 0;
            }
            rawChildren.addChildAt(_loc_2, _loc_3);
            var _loc_4:int = 0;
            while (_loc_4 < _loc_1)
            {
                
                _loc_5 = IUIComponent(super.getChildAt(_firstChildIndex));
                _loc_2.addChild(DisplayObject(_loc_5));
                _loc_5.parentChanged(_loc_2);
                _numChildren--;
                _loc_4++;
            }
            contentPane = _loc_2;
            creatingContentPane = false;
            contentPane.visible = true;
            return;
        }// end function

        public function set verticalPageScrollSize(param1:Number) : void
        {
            scrollPropertiesChanged = true;
            _verticalPageScrollSize = param1;
            invalidateDisplayList();
            dispatchEvent(new Event("verticalPageScrollSizeChanged"));
            return;
        }// end function

        function setDocumentDescriptor(param1:UIComponentDescriptor) : void
        {
            var _loc_2:String = null;
            if (processedDescriptors)
            {
                return;
            }
            if (_documentDescriptor && _documentDescriptor.properties.childDescriptors)
            {
                if (param1.properties.childDescriptors)
                {
                    _loc_2 = resourceManager.getString("core", "multipleChildSets_ClassAndSubclass");
                    throw new Error(_loc_2);
                }
            }
            else
            {
                _documentDescriptor = param1;
                _documentDescriptor.document = this;
            }
            return;
        }// end function

        private function verticalScrollBar_scrollHandler(event:Event) : void
        {
            var _loc_2:Number = NaN;
            if (event is ScrollEvent)
            {
                _loc_2 = verticalScrollPosition;
                verticalScrollPosition = verticalScrollBar.scrollPosition;
                dispatchScrollEvent(ScrollEventDirection.VERTICAL, _loc_2, verticalScrollPosition, ScrollEvent(event).detail);
            }
            return;
        }// end function

        public function get creationPolicy() : String
        {
            return _creationPolicy;
        }// end function

        public function set icon(param1:Class) : void
        {
            _icon = param1;
            dispatchEvent(new Event("iconChanged"));
            return;
        }// end function

        private function dispatchScrollEvent(param1:String, param2:Number, param3:Number, param4:String) : void
        {
            var _loc_5:* = new ScrollEvent(ScrollEvent.SCROLL);
            new ScrollEvent(ScrollEvent.SCROLL).direction = param1;
            _loc_5.position = param3;
            _loc_5.delta = param3 - param2;
            _loc_5.detail = param4;
            dispatchEvent(_loc_5);
            return;
        }// end function

        public function get label() : String
        {
            return _label;
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

        private function creationCompleteHandler(event:FlexEvent) : void
        {
            numChildrenCreated--;
            if (numChildrenCreated <= 0)
            {
                dispatchEvent(new FlexEvent("childrenCreationComplete"));
            }
            return;
        }// end function

        override public function contentToLocal(param1:Point) : Point
        {
            if (!contentPane)
            {
                return param1;
            }
            param1 = contentToGlobal(param1);
            return globalToLocal(param1);
        }// end function

        override public function removeChild(param1:DisplayObject) : DisplayObject
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            if (param1 is IDeferredInstantiationUIComponent && IDeferredInstantiationUIComponent(param1).descriptor)
            {
                if (createdComponents)
                {
                    _loc_2 = createdComponents.length;
                    _loc_3 = 0;
                    while (_loc_3 < _loc_2)
                    {
                        
                        if (createdComponents[_loc_3] === param1)
                        {
                            createdComponents.splice(_loc_3, 1);
                        }
                        _loc_3++;
                    }
                }
            }
            removingChild(param1);
            if (param1 is UIComponent && UIComponent(param1).isDocument)
            {
                BindingManager.setEnabled(param1, false);
            }
            if (contentPane)
            {
                contentPane.removeChild(param1);
            }
            else
            {
                $removeChild(param1);
            }
            childRemoved(param1);
            return param1;
        }// end function

        final function get $numChildren() : int
        {
            return super.numChildren;
        }// end function

        function get numRepeaters() : int
        {
            return childRepeaters ? (childRepeaters.length) : (0);
        }// end function

        function set numChildrenCreated(param1:int) : void
        {
            _numChildrenCreated = param1;
            return;
        }// end function

        public function get creatingContentPane() : Boolean
        {
            return _creatingContentPane;
        }// end function

        public function get clipContent() : Boolean
        {
            return _clipContent;
        }// end function

        function rawChildren_getChildIndex(param1:DisplayObject) : int
        {
            return super.getChildIndex(param1);
        }// end function

        override public function regenerateStyleCache(param1:Boolean) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:DisplayObject = null;
            super.regenerateStyleCache(param1);
            if (contentPane)
            {
                _loc_2 = contentPane.numChildren;
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    _loc_4 = getChildAt(_loc_3);
                    if (param1 && _loc_4 is UIComponent)
                    {
                        if (UIComponent(_loc_4).inheritingStyles != UIComponent.STYLE_UNINITIALIZED)
                        {
                            UIComponent(_loc_4).regenerateStyleCache(param1);
                        }
                    }
                    else if (_loc_4 is IUITextField && IUITextField(_loc_4).inheritingStyles)
                    {
                        StyleProtoChain.initTextField(IUITextField(_loc_4));
                    }
                    _loc_3++;
                }
            }
            return;
        }// end function

        override public function getChildIndex(param1:DisplayObject) : int
        {
            var _loc_2:int = 0;
            if (contentPane)
            {
                return contentPane.getChildIndex(param1);
            }
            _loc_2 = super.getChildIndex(param1) - _firstChildIndex;
            return _loc_2;
        }// end function

        function rawChildren_contains(param1:DisplayObject) : Boolean
        {
            return super.contains(param1);
        }// end function

        function getScrollableRect() : Rectangle
        {
            var _loc_9:DisplayObject = null;
            var _loc_1:Number = 0;
            var _loc_2:Number = 0;
            var _loc_3:Number = 0;
            var _loc_4:Number = 0;
            var _loc_5:* = numChildren;
            var _loc_6:int = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_9 = getChildAt(_loc_6);
                if (_loc_9 is IUIComponent && !IUIComponent(_loc_9).includeInLayout)
                {
                }
                else
                {
                    _loc_1 = Math.min(_loc_1, _loc_9.x);
                    _loc_2 = Math.min(_loc_2, _loc_9.y);
                    if (!isNaN(_loc_9.width))
                    {
                        _loc_3 = Math.max(_loc_3, _loc_9.x + _loc_9.width);
                    }
                    if (!isNaN(_loc_9.height))
                    {
                        _loc_4 = Math.max(_loc_4, _loc_9.y + _loc_9.height);
                    }
                }
                _loc_6++;
            }
            var _loc_7:* = viewMetrics;
            var _loc_8:* = new Rectangle();
            new Rectangle().left = _loc_1;
            _loc_8.top = _loc_2;
            _loc_8.right = _loc_3;
            _loc_8.bottom = _loc_4;
            if (usePadding)
            {
                _loc_8.right = _loc_8.right + getStyle("paddingRight");
                _loc_8.bottom = _loc_8.bottom + getStyle("paddingBottom");
            }
            return _loc_8;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:Application = null;
            super.createChildren();
            createBorder();
            if (horizontalScrollPolicy != ScrollPolicy.ON)
            {
            }
            createOrDestroyScrollbars(horizontalScrollPolicy == ScrollPolicy.ON, verticalScrollPolicy == ScrollPolicy.ON, verticalScrollPolicy == ScrollPolicy.ON);
            if (creationPolicy != null)
            {
                actualCreationPolicy = creationPolicy;
            }
            else if (parent is Container)
            {
                if (Container(parent).actualCreationPolicy == ContainerCreationPolicy.QUEUED)
                {
                    actualCreationPolicy = ContainerCreationPolicy.AUTO;
                }
                else
                {
                    actualCreationPolicy = Container(parent).actualCreationPolicy;
                }
            }
            if (actualCreationPolicy == ContainerCreationPolicy.NONE)
            {
                actualCreationPolicy = ContainerCreationPolicy.AUTO;
            }
            else if (actualCreationPolicy == ContainerCreationPolicy.QUEUED)
            {
                _loc_1 = parentApplication ? (Application(parentApplication)) : (Application(Application.application));
                _loc_1.addToCreationQueue(this, creationIndex, null, this);
            }
            else if (recursionFlag)
            {
                createComponentsFromDescriptors();
            }
            if (autoLayout == false)
            {
                forceLayout = true;
            }
            UIComponentGlobals.layoutManager.addEventListener(FlexEvent.UPDATE_COMPLETE, layoutCompleteHandler, false, 0, true);
            return;
        }// end function

        override public function executeBindings(param1:Boolean = false) : void
        {
            if (descriptor)
            {
            }
            var _loc_2:* = descriptor.document ? (descriptor.document) : (parentDocument);
            BindingManager.executeBindings(_loc_2, id, this);
            if (param1)
            {
                executeChildBindings(param1);
            }
            return;
        }// end function

        override public function setChildIndex(param1:DisplayObject, param2:int) : void
        {
            var _loc_3:int = 0;
            var _loc_4:* = _loc_3;
            var _loc_5:* = param2;
            if (contentPane)
            {
                contentPane.setChildIndex(param1, param2);
                if (_autoLayout || forceLayout)
                {
                    invalidateDisplayList();
                }
            }
            else
            {
                _loc_3 = super.getChildIndex(param1);
                param2 = param2 + _firstChildIndex;
                if (param2 == _loc_3)
                {
                    return;
                }
                super.setChildIndex(param1, param2);
                invalidateDisplayList();
                _loc_4 = _loc_3 - _firstChildIndex;
                _loc_5 = param2 - _firstChildIndex;
            }
            var _loc_6:* = new IndexChangedEvent(IndexChangedEvent.CHILD_INDEX_CHANGE);
            new IndexChangedEvent(IndexChangedEvent.CHILD_INDEX_CHANGE).relatedObject = param1;
            _loc_6.oldIndex = _loc_4;
            _loc_6.newIndex = _loc_5;
            dispatchEvent(_loc_6);
            dispatchEvent(new Event("childrenChanged"));
            return;
        }// end function

        override public function globalToContent(param1:Point) : Point
        {
            if (contentPane)
            {
                return contentPane.globalToLocal(param1);
            }
            return globalToLocal(param1);
        }// end function

        function rawChildren_removeChild(param1:DisplayObject) : DisplayObject
        {
            var _loc_2:* = rawChildren_getChildIndex(param1);
            return rawChildren_removeChildAt(_loc_2);
        }// end function

        function rawChildren_setChildIndex(param1:DisplayObject, param2:int) : void
        {
            var _loc_3:* = super.getChildIndex(param1);
            super.setChildIndex(param1, param2);
            if (_loc_3 < _firstChildIndex && param2 >= _firstChildIndex)
            {
                _firstChildIndex--;
            }
            else if (_loc_3 >= _firstChildIndex && param2 <= _firstChildIndex)
            {
                _firstChildIndex++;
            }
            dispatchEvent(new Event("childrenChanged"));
            return;
        }// end function

        public function set verticalLineScrollSize(param1:Number) : void
        {
            scrollPropertiesChanged = true;
            _verticalLineScrollSize = param1;
            invalidateDisplayList();
            dispatchEvent(new Event("verticalLineScrollSizeChanged"));
            return;
        }// end function

        function rawChildren_getChildAt(param1:int) : DisplayObject
        {
            return super.getChildAt(param1);
        }// end function

        public function get creationIndex() : int
        {
            return _creationIndex;
        }// end function

        public function get verticalScrollBar() : ScrollBar
        {
            return _verticalScrollBar;
        }// end function

        public function get viewMetricsAndPadding() : EdgeMetrics
        {
            if (_viewMetricsAndPadding && !horizontalScrollBar || horizontalScrollPolicy == ScrollPolicy.ON && !verticalScrollBar || verticalScrollPolicy == ScrollPolicy.ON)
            {
                return _viewMetricsAndPadding;
            }
            if (!_viewMetricsAndPadding)
            {
                _viewMetricsAndPadding = new EdgeMetrics();
            }
            var _loc_1:* = _viewMetricsAndPadding;
            var _loc_2:* = viewMetrics;
            _loc_1.left = _loc_2.left + getStyle("paddingLeft");
            _loc_1.right = _loc_2.right + getStyle("paddingRight");
            _loc_1.top = _loc_2.top + getStyle("paddingTop");
            _loc_1.bottom = _loc_2.bottom + getStyle("paddingBottom");
            return _loc_1;
        }// end function

        override public function addChild(param1:DisplayObject) : DisplayObject
        {
            return addChildAt(param1, numChildren);
        }// end function

        public function set horizontalPageScrollSize(param1:Number) : void
        {
            scrollPropertiesChanged = true;
            _horizontalPageScrollSize = param1;
            invalidateDisplayList();
            dispatchEvent(new Event("horizontalPageScrollSizeChanged"));
            return;
        }// end function

        override function childAdded(param1:DisplayObject) : void
        {
            dispatchEvent(new Event("childrenChanged"));
            var _loc_2:* = new ChildExistenceChangedEvent(ChildExistenceChangedEvent.CHILD_ADD);
            _loc_2.relatedObject = param1;
            dispatchEvent(_loc_2);
            param1.dispatchEvent(new FlexEvent(FlexEvent.ADD));
            super.childAdded(param1);
            return;
        }// end function

        public function set horizontalScrollPolicy(param1:String) : void
        {
            if (_horizontalScrollPolicy != param1)
            {
                _horizontalScrollPolicy = param1;
                invalidateDisplayList();
                dispatchEvent(new Event("horizontalScrollPolicyChanged"));
            }
            return;
        }// end function

        private function layoutCompleteHandler(event:FlexEvent) : void
        {
            UIComponentGlobals.layoutManager.removeEventListener(FlexEvent.UPDATE_COMPLETE, layoutCompleteHandler);
            forceLayout = false;
            var _loc_2:Boolean = false;
            if (!isNaN(horizontalScrollPositionPending))
            {
                if (horizontalScrollPositionPending < 0)
                {
                    horizontalScrollPositionPending = 0;
                }
                else if (horizontalScrollPositionPending > maxHorizontalScrollPosition)
                {
                    horizontalScrollPositionPending = maxHorizontalScrollPosition;
                }
                if (horizontalScrollBar && horizontalScrollBar.scrollPosition != horizontalScrollPositionPending)
                {
                    _horizontalScrollPosition = horizontalScrollPositionPending;
                    horizontalScrollBar.scrollPosition = horizontalScrollPositionPending;
                    _loc_2 = true;
                }
                horizontalScrollPositionPending = NaN;
            }
            if (!isNaN(verticalScrollPositionPending))
            {
                if (verticalScrollPositionPending < 0)
                {
                    verticalScrollPositionPending = 0;
                }
                else if (verticalScrollPositionPending > maxVerticalScrollPosition)
                {
                    verticalScrollPositionPending = maxVerticalScrollPosition;
                }
                if (verticalScrollBar && verticalScrollBar.scrollPosition != verticalScrollPositionPending)
                {
                    _verticalScrollPosition = verticalScrollPositionPending;
                    verticalScrollBar.scrollPosition = verticalScrollPositionPending;
                    _loc_2 = true;
                }
                verticalScrollPositionPending = NaN;
            }
            if (_loc_2)
            {
                scrollChildren();
            }
            return;
        }// end function

        public function createComponentsFromDescriptors(param1:Boolean = true) : void
        {
            var _loc_4:IFlexDisplayObject = null;
            numChildrenBefore = numChildren;
            createdComponents = [];
            var _loc_2:* = childDescriptors ? (childDescriptors.length) : (0);
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = createComponentFromDescriptor(childDescriptors[_loc_3], param1);
                createdComponents.push(_loc_4);
                _loc_3++;
            }
            if (creationPolicy == ContainerCreationPolicy.QUEUED || creationPolicy == ContainerCreationPolicy.NONE)
            {
                UIComponentGlobals.layoutManager.usePhasedInstantiation = false;
            }
            numChildrenCreated = numChildren - numChildrenBefore;
            processedDescriptors = true;
            return;
        }// end function

        override function fillOverlay(param1:UIComponent, param2:uint, param3:RoundedRectangle = null) : void
        {
            var _loc_4:* = viewMetrics;
            var _loc_5:Number = 0;
            if (!param3)
            {
                param3 = new RoundedRectangle(_loc_4.left, _loc_4.top, unscaledWidth - _loc_4.right - _loc_4.left, unscaledHeight - _loc_4.bottom - _loc_4.top, _loc_5);
            }
            if (isNaN(param3.x) || isNaN(param3.y) || isNaN(param3.width) || isNaN(param3.height) || isNaN(param3.cornerRadius))
            {
                return;
            }
            var _loc_6:* = param1.graphics;
            param1.graphics.clear();
            _loc_6.beginFill(param2);
            _loc_6.drawRoundRect(param3.x, param3.y, param3.width, param3.height, param3.cornerRadius * 2, param3.cornerRadius * 2);
            _loc_6.endFill();
            return;
        }// end function

        override public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            super.removeEventListener(param1, param2, param3);
            if (param1 == MouseEvent.CLICK || param1 == MouseEvent.DOUBLE_CLICK || param1 == MouseEvent.MOUSE_DOWN || param1 == MouseEvent.MOUSE_MOVE || param1 == MouseEvent.MOUSE_OVER || param1 == MouseEvent.MOUSE_OUT || param1 == MouseEvent.MOUSE_UP || param1 == MouseEvent.MOUSE_WHEEL)
            {
                if (mouseEventReferenceCount > 0 && --mouseEventReferenceCount == 0)
                {
                    setStyle("mouseShield", false);
                    setStyle("mouseShieldChildren", false);
                }
            }
            return;
        }// end function

        function rawChildren_removeChildAt(param1:int) : DisplayObject
        {
            var _loc_2:* = super.getChildAt(param1);
            super.removingChild(_loc_2);
            $removeChildAt(param1);
            super.childRemoved(_loc_2);
            if (_firstChildIndex < param1 && param1 < _firstChildIndex + _numChildren)
            {
                _numChildren--;
            }
            else if (_numChildren == 0 || param1 < _firstChildIndex)
            {
                _firstChildIndex--;
            }
            invalidateSize();
            invalidateDisplayList();
            dispatchEvent(new Event("childrenChanged"));
            return _loc_2;
        }// end function

        public function set data(param1:Object) : void
        {
            _data = param1;
            dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
            invalidateDisplayList();
            return;
        }// end function

        override public function removeChildAt(param1:int) : DisplayObject
        {
            return removeChild(getChildAt(param1));
        }// end function

        private function isBorderNeeded() : Boolean
        {
            var c:* = getStyle("borderSkin");
            try
            {
                if (c != getDefinitionByName("mx.skins.halo::HaloBorder"))
                {
                    return true;
                }
            }
            catch (e:Error)
            {
                return true;
            }
            var v:* = getStyle("borderStyle");
            if (v)
            {
                if (v != "none" || v == "none" && getStyle("mouseShield"))
                {
                    return true;
                }
            }
            v = getStyle("backgroundColor");
            if (v !== null && v !== "")
            {
                return true;
            }
            v = getStyle("backgroundImage");
            if (v != null)
            {
            }
            return v != "";
        }// end function

        public function set autoLayout(param1:Boolean) : void
        {
            var _loc_2:IInvalidating = null;
            _autoLayout = param1;
            if (param1)
            {
                invalidateSize();
                invalidateDisplayList();
                _loc_2 = parent as IInvalidating;
                if (_loc_2)
                {
                    _loc_2.invalidateSize();
                    _loc_2.invalidateDisplayList();
                }
            }
            return;
        }// end function

        public function get verticalPageScrollSize() : Number
        {
            return _verticalPageScrollSize;
        }// end function

        public function getChildren() : Array
        {
            var _loc_1:Array = [];
            var _loc_2:* = numChildren;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_1.push(getChildAt(_loc_3));
                _loc_3++;
            }
            return _loc_1;
        }// end function

        private function createScrollbarsIfNeeded(param1:Rectangle) : Boolean
        {
            var _loc_2:* = param1.right;
            var _loc_3:* = param1.bottom;
            var _loc_4:* = unscaledWidth;
            var _loc_5:* = unscaledHeight;
            if (param1.left >= 0)
            {
            }
            var _loc_6:* = param1.top < 0;
            var _loc_7:* = viewMetrics;
            if (scaleX != 1)
            {
                _loc_4 = _loc_4 + 1 / Math.abs(scaleX);
            }
            if (scaleY != 1)
            {
                _loc_5 = _loc_5 + 1 / Math.abs(scaleY);
            }
            _loc_4 = Math.floor(_loc_4);
            _loc_5 = Math.floor(_loc_5);
            _loc_2 = Math.floor(_loc_2);
            _loc_3 = Math.floor(_loc_3);
            if (horizontalScrollBar && horizontalScrollPolicy != ScrollPolicy.ON)
            {
                _loc_5 = _loc_5 - horizontalScrollBar.minHeight;
            }
            if (verticalScrollBar && verticalScrollPolicy != ScrollPolicy.ON)
            {
                _loc_4 = _loc_4 - verticalScrollBar.minWidth;
            }
            _loc_4 = _loc_4 - (_loc_7.left + _loc_7.right);
            _loc_5 = _loc_5 - (_loc_7.top + _loc_7.bottom);
            var _loc_8:* = horizontalScrollPolicy == ScrollPolicy.ON;
            var _loc_9:* = verticalScrollPolicy == ScrollPolicy.ON;
            if (!(_loc_8 || _loc_9 || _loc_6 || overlay != null || _loc_7.left > 0))
            {
            }
            var _loc_10:* = _loc_7.top > 0;
            if (_loc_4 < _loc_2)
            {
                _loc_10 = true;
                if (horizontalScrollPolicy == ScrollPolicy.AUTO && unscaledHeight - _loc_7.top - _loc_7.bottom >= 18 && unscaledWidth - _loc_7.left - _loc_7.right >= 32)
                {
                    _loc_8 = true;
                }
            }
            if (_loc_5 < _loc_3)
            {
                _loc_10 = true;
                if (verticalScrollPolicy == ScrollPolicy.AUTO && unscaledWidth - _loc_7.left - _loc_7.right >= 18 && unscaledHeight - _loc_7.top - _loc_7.bottom >= 32)
                {
                    _loc_9 = true;
                }
            }
            if (_loc_8 && _loc_9 && horizontalScrollPolicy == ScrollPolicy.AUTO && verticalScrollPolicy == ScrollPolicy.AUTO && horizontalScrollBar && verticalScrollBar && _loc_4 + verticalScrollBar.minWidth >= _loc_2 && _loc_5 + horizontalScrollBar.minHeight >= _loc_3)
            {
                var _loc_12:Boolean = false;
                _loc_9 = false;
                _loc_8 = _loc_12;
            }
            else if (_loc_8 && !_loc_9 && verticalScrollBar && horizontalScrollPolicy == ScrollPolicy.AUTO && _loc_4 + verticalScrollBar.minWidth >= _loc_2)
            {
                _loc_8 = false;
            }
            var _loc_11:* = createOrDestroyScrollbars(_loc_8, _loc_9, _loc_10);
            if (scrollableWidth != _loc_2 || viewableWidth != _loc_4 || _loc_11)
            {
                if (horizontalScrollBar)
                {
                    horizontalScrollBar.setScrollProperties(_loc_4, 0, _loc_2 - _loc_4, horizontalPageScrollSize);
                    scrollPositionChanged = true;
                }
                viewableWidth = _loc_4;
                scrollableWidth = _loc_2;
            }
            if (scrollableHeight != _loc_3 || viewableHeight != _loc_5 || _loc_11)
            {
                if (verticalScrollBar)
                {
                    verticalScrollBar.setScrollProperties(_loc_5, 0, _loc_3 - _loc_5, verticalPageScrollSize);
                    scrollPositionChanged = true;
                }
                viewableHeight = _loc_5;
                scrollableHeight = _loc_3;
            }
            return _loc_11;
        }// end function

        override function removingChild(param1:DisplayObject) : void
        {
            super.removingChild(param1);
            param1.dispatchEvent(new FlexEvent(FlexEvent.REMOVE));
            var _loc_2:* = new ChildExistenceChangedEvent(ChildExistenceChangedEvent.CHILD_REMOVE);
            _loc_2.relatedObject = param1;
            dispatchEvent(_loc_2);
            return;
        }// end function

        function get numChildrenCreated() : int
        {
            return _numChildrenCreated;
        }// end function

        function rawChildren_addChildAt(param1:DisplayObject, param2:int) : DisplayObject
        {
            if (_firstChildIndex < param2 && param2 < _firstChildIndex + _numChildren + 1)
            {
                _numChildren++;
            }
            else if (param2 <= _firstChildIndex)
            {
                _firstChildIndex++;
            }
            super.addingChild(param1);
            $addChildAt(param1, param2);
            super.childAdded(param1);
            dispatchEvent(new Event("childrenChanged"));
            return param1;
        }// end function

        private function hasChildMatchingDescriptor(param1:UIComponentDescriptor) : Boolean
        {
            var _loc_4:int = 0;
            var _loc_5:IUIComponent = null;
            var _loc_2:* = param1.id;
            if (_loc_2 != null && document[_loc_2] == null)
            {
                return false;
            }
            var _loc_3:* = numChildren;
            _loc_4 = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = IUIComponent(getChildAt(_loc_4));
                if (_loc_5 is IDeferredInstantiationUIComponent && IDeferredInstantiationUIComponent(_loc_5).descriptor == param1)
                {
                    return true;
                }
                _loc_4++;
            }
            if (childRepeaters)
            {
                _loc_3 = childRepeaters.length;
                _loc_4 = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    if (IDeferredInstantiationUIComponent(childRepeaters[_loc_4]).descriptor == param1)
                    {
                        return true;
                    }
                    _loc_4++;
                }
            }
            return false;
        }// end function

        function rawChildren_getChildByName(param1:String) : DisplayObject
        {
            return super.getChildByName(param1);
        }// end function

        override public function validateDisplayList() : void
        {
            var _loc_1:EdgeMetrics = null;
            var _loc_2:Number = NaN;
            var _loc_3:Number = NaN;
            var _loc_4:Object = null;
            var _loc_5:Number = NaN;
            var _loc_6:Number = NaN;
            var _loc_7:Number = NaN;
            if (_autoLayout || forceLayout)
            {
                doingLayout = true;
                super.validateDisplayList();
                doingLayout = false;
            }
            else
            {
                layoutChrome(unscaledWidth, unscaledHeight);
            }
            invalidateDisplayListFlag = true;
            if (createContentPaneAndScrollbarsIfNeeded())
            {
                if (_autoLayout || forceLayout)
                {
                    doingLayout = true;
                    super.validateDisplayList();
                    doingLayout = false;
                }
                createContentPaneAndScrollbarsIfNeeded();
            }
            if (clampScrollPositions())
            {
                scrollChildren();
            }
            if (contentPane)
            {
                _loc_1 = viewMetrics;
                if (overlay)
                {
                    overlay.x = 0;
                    overlay.y = 0;
                    overlay.width = unscaledWidth;
                    overlay.height = unscaledHeight;
                }
                if (horizontalScrollBar || verticalScrollBar)
                {
                    if (verticalScrollBar && verticalScrollPolicy == ScrollPolicy.ON)
                    {
                        _loc_1.right = _loc_1.right - verticalScrollBar.minWidth;
                    }
                    if (horizontalScrollBar && horizontalScrollPolicy == ScrollPolicy.ON)
                    {
                        _loc_1.bottom = _loc_1.bottom - horizontalScrollBar.minHeight;
                    }
                    if (horizontalScrollBar)
                    {
                        _loc_2 = unscaledWidth - _loc_1.left - _loc_1.right;
                        if (verticalScrollBar)
                        {
                            _loc_2 = _loc_2 - verticalScrollBar.minWidth;
                        }
                        horizontalScrollBar.setActualSize(_loc_2, horizontalScrollBar.minHeight);
                        horizontalScrollBar.move(_loc_1.left, unscaledHeight - _loc_1.bottom - horizontalScrollBar.minHeight);
                    }
                    if (verticalScrollBar)
                    {
                        _loc_3 = unscaledHeight - _loc_1.top - _loc_1.bottom;
                        if (horizontalScrollBar)
                        {
                            _loc_3 = _loc_3 - horizontalScrollBar.minHeight;
                        }
                        verticalScrollBar.setActualSize(verticalScrollBar.minWidth, _loc_3);
                        verticalScrollBar.move(unscaledWidth - _loc_1.right - verticalScrollBar.minWidth, _loc_1.top);
                    }
                    if (whiteBox)
                    {
                        whiteBox.x = verticalScrollBar.x;
                        whiteBox.y = horizontalScrollBar.y;
                    }
                }
                contentPane.x = _loc_1.left;
                contentPane.y = _loc_1.top;
                if (focusPane)
                {
                    focusPane.x = _loc_1.left;
                    focusPane.y = _loc_1.top;
                }
                scrollChildren();
            }
            invalidateDisplayListFlag = false;
            if (blocker)
            {
                _loc_1 = viewMetrics;
                _loc_4 = enabled ? (null) : (getStyle("backgroundDisabledColor"));
                if (_loc_4 === null || isNaN(Number(_loc_4)))
                {
                    _loc_4 = getStyle("backgroundColor");
                }
                if (_loc_4 === null || isNaN(Number(_loc_4)))
                {
                    _loc_4 = 16777215;
                }
                _loc_5 = getStyle("disabledOverlayAlpha");
                if (isNaN(_loc_5))
                {
                    _loc_5 = 0.6;
                }
                blocker.x = _loc_1.left;
                blocker.y = _loc_1.top;
                _loc_6 = unscaledWidth - (_loc_1.left + _loc_1.right);
                _loc_7 = unscaledHeight - (_loc_1.top + _loc_1.bottom);
                blocker.graphics.clear();
                blocker.graphics.beginFill(uint(_loc_4), _loc_5);
                blocker.graphics.drawRect(0, 0, _loc_6, _loc_7);
                blocker.graphics.endFill();
                rawChildren.setChildIndex(blocker, rawChildren.numChildren--);
            }
            return;
        }// end function

        public function set horizontalLineScrollSize(param1:Number) : void
        {
            scrollPropertiesChanged = true;
            _horizontalLineScrollSize = param1;
            invalidateDisplayList();
            dispatchEvent(new Event("horizontalLineScrollSizeChanged"));
            return;
        }// end function

        override public function initialize() : void
        {
            var _loc_1:* = undefined;
            var _loc_2:String = null;
            if (isDocument && documentDescriptor && !processedDescriptors)
            {
                _loc_1 = documentDescriptor.properties;
                if (_loc_1 && _loc_1.childDescriptors)
                {
                    if (_childDescriptors)
                    {
                        _loc_2 = resourceManager.getString("core", "multipleChildSets_ClassAndInstance");
                        throw new Error(_loc_2);
                    }
                    _childDescriptors = _loc_1.childDescriptors;
                }
            }
            super.initialize();
            return;
        }// end function

        function set forceClipping(param1:Boolean) : void
        {
            if (_clipContent)
            {
                if (param1)
                {
                    _forceClippingCount++;
                }
                else
                {
                    _forceClippingCount--;
                }
                createContentPane();
                scrollChildren();
            }
            return;
        }// end function

        public function removeAllChildren() : void
        {
            while (numChildren > 0)
            {
                
                removeChildAt(0);
            }
            return;
        }// end function

        override public function contentToGlobal(param1:Point) : Point
        {
            if (contentPane)
            {
                return contentPane.localToGlobal(param1);
            }
            return localToGlobal(param1);
        }// end function

        public function get horizontalPageScrollSize() : Number
        {
            return _horizontalPageScrollSize;
        }// end function

        override function childRemoved(param1:DisplayObject) : void
        {
            super.childRemoved(param1);
            invalidateSize();
            invalidateDisplayList();
            if (!contentPane)
            {
                _numChildren--;
                if (_numChildren == 0)
                {
                    _firstChildIndex = super.numChildren;
                }
            }
            if (contentPane && !autoLayout)
            {
                forceLayout = true;
                UIComponentGlobals.layoutManager.addEventListener(FlexEvent.UPDATE_COMPLETE, layoutCompleteHandler, false, 0, true);
            }
            dispatchEvent(new Event("childrenChanged"));
            return;
        }// end function

        public function set defaultButton(param1:IFlexDisplayObject) : void
        {
            _defaultButton = param1;
            ContainerGlobals.focusedContainer = null;
            return;
        }// end function

        public function get data() : Object
        {
            return _data;
        }// end function

        override public function get numChildren() : int
        {
            return contentPane ? (contentPane.numChildren) : (_numChildren);
        }// end function

        public function get autoLayout() : Boolean
        {
            return _autoLayout;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            var _loc_3:String = null;
            var _loc_4:String = null;
            if (param1 != null)
            {
            }
            var _loc_2:* = param1 == "styleName";
            if (_loc_2 || StyleManager.isSizeInvalidatingStyle(param1))
            {
                invalidateDisplayList();
            }
            if (_loc_2 || param1 == "borderSkin")
            {
                if (border)
                {
                    rawChildren.removeChild(DisplayObject(border));
                    border = null;
                    createBorder();
                }
            }
            if (_loc_2 || param1 == "borderStyle" || param1 == "backgroundColor" || param1 == "backgroundImage" || param1 == "mouseShield" || param1 == "mouseShieldChildren")
            {
                createBorder();
            }
            super.styleChanged(param1);
            if (_loc_2 || StyleManager.isSizeInvalidatingStyle(param1))
            {
                invalidateViewMetricsAndPadding();
            }
            if (_loc_2 || param1 == "horizontalScrollBarStyleName")
            {
                if (horizontalScrollBar && horizontalScrollBar is ISimpleStyleClient)
                {
                    _loc_3 = getStyle("horizontalScrollBarStyleName");
                    ISimpleStyleClient(horizontalScrollBar).styleName = _loc_3;
                }
            }
            if (_loc_2 || param1 == "verticalScrollBarStyleName")
            {
                if (verticalScrollBar && verticalScrollBar is ISimpleStyleClient)
                {
                    _loc_4 = getStyle("verticalScrollBarStyleName");
                    ISimpleStyleClient(verticalScrollBar).styleName = _loc_4;
                }
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:String = null;
            super.commitProperties();
            if (changedStyles)
            {
                _loc_1 = changedStyles == MULTIPLE_PROPERTIES ? (null) : (changedStyles);
                super.notifyStyleChangeInChildren(_loc_1, true);
                changedStyles = null;
            }
            createOrDestroyBlocker();
            return;
        }// end function

        override public function finishPrint(param1:Object, param2:IFlexDisplayObject) : void
        {
            if (param1)
            {
                contentPane.scrollRect = Rectangle(param1);
            }
            super.finishPrint(param1, param2);
            return;
        }// end function

        public function get maxHorizontalScrollPosition() : Number
        {
            return horizontalScrollBar ? (horizontalScrollBar.maxScrollPosition) : (Math.max(scrollableWidth - viewableWidth, 0));
        }// end function

        public function set creationPolicy(param1:String) : void
        {
            _creationPolicy = param1;
            setActualCreationPolicies(param1);
            return;
        }// end function

        public function set label(param1:String) : void
        {
            _label = param1;
            dispatchEvent(new Event("labelChanged"));
            return;
        }// end function

        private function clampScrollPositions() : Boolean
        {
            var _loc_1:Boolean = false;
            if (_horizontalScrollPosition < 0)
            {
                _horizontalScrollPosition = 0;
                _loc_1 = true;
            }
            else if (_horizontalScrollPosition > maxHorizontalScrollPosition)
            {
                _horizontalScrollPosition = maxHorizontalScrollPosition;
                _loc_1 = true;
            }
            if (horizontalScrollBar && horizontalScrollBar.scrollPosition != _horizontalScrollPosition)
            {
                horizontalScrollBar.scrollPosition = _horizontalScrollPosition;
            }
            if (_verticalScrollPosition < 0)
            {
                _verticalScrollPosition = 0;
                _loc_1 = true;
            }
            else if (_verticalScrollPosition > maxVerticalScrollPosition)
            {
                _verticalScrollPosition = maxVerticalScrollPosition;
                _loc_1 = true;
            }
            if (verticalScrollBar && verticalScrollBar.scrollPosition != _verticalScrollPosition)
            {
                verticalScrollBar.scrollPosition = _verticalScrollPosition;
            }
            return _loc_1;
        }// end function

        override public function prepareToPrint(param1:IFlexDisplayObject) : Object
        {
            if (contentPane)
            {
            }
            var _loc_2:* = contentPane.scrollRect ? (contentPane.scrollRect) : (null);
            if (_loc_2)
            {
                contentPane.scrollRect = null;
            }
            super.prepareToPrint(param1);
            return _loc_2;
        }// end function

        function get firstChildIndex() : int
        {
            return _firstChildIndex;
        }// end function

        function rawChildren_addChild(param1:DisplayObject) : DisplayObject
        {
            if (_numChildren == 0)
            {
                _firstChildIndex++;
            }
            super.addingChild(param1);
            $addChild(param1);
            super.childAdded(param1);
            dispatchEvent(new Event("childrenChanged"));
            return param1;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_3:Object = null;
            var _loc_4:Number = NaN;
            super.updateDisplayList(param1, param2);
            layoutChrome(param1, param2);
            if (scrollPositionChanged)
            {
                clampScrollPositions();
                scrollChildren();
                scrollPositionChanged = false;
            }
            if (scrollPropertiesChanged)
            {
                if (horizontalScrollBar)
                {
                    horizontalScrollBar.lineScrollSize = horizontalLineScrollSize;
                    horizontalScrollBar.pageScrollSize = horizontalPageScrollSize;
                }
                if (verticalScrollBar)
                {
                    verticalScrollBar.lineScrollSize = verticalLineScrollSize;
                    verticalScrollBar.pageScrollSize = verticalPageScrollSize;
                }
                scrollPropertiesChanged = false;
            }
            if (contentPane && contentPane.scrollRect)
            {
                _loc_3 = enabled ? (null) : (getStyle("backgroundDisabledColor"));
                if (_loc_3 === null || isNaN(Number(_loc_3)))
                {
                    _loc_3 = getStyle("backgroundColor");
                }
                _loc_4 = getStyle("backgroundAlpha");
                if (!_clipContent || isNaN(Number(_loc_3)) || _loc_3 === "" || horizontalScrollBar || !verticalScrollBar && !cacheAsBitmap)
                {
                    _loc_3 = null;
                }
                else
                {
                    if (getStyle("backgroundImage") || getStyle("background"))
                    {
                        _loc_3 = null;
                    }
                    else if (_loc_4 != 1)
                    {
                        _loc_3 = null;
                    }
                }
                contentPane.opaqueBackground = _loc_3;
                contentPane.cacheAsBitmap = _loc_3 != null;
            }
            return;
        }// end function

        override function addingChild(param1:DisplayObject) : void
        {
            var _loc_2:* = IUIComponent(param1);
            super.addingChild(param1);
            invalidateSize();
            invalidateDisplayList();
            if (!contentPane)
            {
                if (_numChildren == 0)
                {
                    _firstChildIndex = super.numChildren;
                }
                _numChildren++;
            }
            if (contentPane && !autoLayout)
            {
                forceLayout = true;
                UIComponentGlobals.layoutManager.addEventListener(FlexEvent.UPDATE_COMPLETE, layoutCompleteHandler, false, 0, true);
            }
            return;
        }// end function

        function setActualCreationPolicies(param1:String) : void
        {
            var _loc_5:IFlexDisplayObject = null;
            var _loc_6:Container = null;
            actualCreationPolicy = param1;
            var _loc_2:* = param1;
            if (param1 == ContainerCreationPolicy.QUEUED)
            {
                _loc_2 = ContainerCreationPolicy.AUTO;
            }
            var _loc_3:* = numChildren;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = IFlexDisplayObject(getChildAt(_loc_4));
                if (_loc_5 is Container)
                {
                    _loc_6 = Container(_loc_5);
                    if (_loc_6.creationPolicy == null)
                    {
                        _loc_6.setActualCreationPolicies(_loc_2);
                    }
                }
                _loc_4++;
            }
            return;
        }// end function

    }
}
