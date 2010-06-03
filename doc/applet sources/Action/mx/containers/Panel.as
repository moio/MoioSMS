package mx.containers
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import mx.automation.*;
    import mx.containers.utilityClasses.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.effects.*;
    import mx.events.*;
    import mx.styles.*;

    public class Panel extends Container implements IConstraintLayout, IFontContextComponent
    {
        private var layoutObject:Layout;
        private var _status:String = "";
        private var _titleChanged:Boolean = false;
        var titleBarBackground:IFlexDisplayObject;
        private var regX:Number;
        private var regY:Number;
        private var _layout:String = "vertical";
        var closeButton:Button;
        private var initializing:Boolean = true;
        private var _title:String = "";
        protected var titleTextField:IUITextField;
        private var _statusChanged:Boolean = false;
        private var autoSetRoundedCorners:Boolean;
        private var _titleIcon:Class;
        private var _constraintRows:Array;
        protected var controlBar:IUIComponent;
        var titleIconObject:Object = null;
        protected var titleBar:UIComponent;
        private var panelViewMetrics:EdgeMetrics;
        private var _constraintColumns:Array;
        var _showCloseButton:Boolean = false;
        private var checkedForAutoSetRoundedCorners:Boolean;
        private var _titleIconChanged:Boolean = false;
        protected var statusTextField:IUITextField;
        static var createAccessibilityImplementation:Function;
        private static var _closeButtonStyleFilters:Object = {closeButtonUpSkin:"closeButtonUpSkin", closeButtonOverSkin:"closeButtonOverSkin", closeButtonDownSkin:"closeButtonDownSkin", closeButtonDisabledSkin:"closeButtonDisabledSkin", closeButtonSkin:"closeButtonSkin", repeatDelay:"repeatDelay", repeatInterval:"repeatInterval"};
        static const VERSION:String = "3.2.0.3958";
        private static const HEADER_PADDING:Number = 14;

        public function Panel()
        {
            _constraintColumns = [];
            _constraintRows = [];
            addEventListener("resizeStart", EffectManager.eventHandler, false, EventPriority.EFFECT);
            addEventListener("resizeEnd", EffectManager.eventHandler, false, EventPriority.EFFECT);
            layoutObject = new BoxLayout();
            layoutObject.target = this;
            showInAutomationHierarchy = true;
            return;
        }// end function

        private function systemManager_mouseUpHandler(event:MouseEvent) : void
        {
            if (!isNaN(regX))
            {
                stopDragging();
            }
            return;
        }// end function

        function getHeaderHeightProxy() : Number
        {
            return getHeaderHeight();
        }// end function

        override public function getChildIndex(param1:DisplayObject) : int
        {
            if (controlBar && param1 == controlBar)
            {
                return numChildren;
            }
            return super.getChildIndex(param1);
        }// end function

        function get _controlBar() : IUIComponent
        {
            return controlBar;
        }// end function

        function getTitleBar() : UIComponent
        {
            return titleBar;
        }// end function

        public function get layout() : String
        {
            return _layout;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:Class = null;
            var _loc_2:IStyleClient = null;
            var _loc_3:ISimpleStyleClient = null;
            super.createChildren();
            if (!titleBar)
            {
                titleBar = new UIComponent();
                titleBar.visible = false;
                titleBar.addEventListener(MouseEvent.MOUSE_DOWN, titleBar_mouseDownHandler);
                rawChildren.addChild(titleBar);
            }
            if (!titleBarBackground)
            {
                _loc_1 = getStyle("titleBackgroundSkin");
                if (_loc_1)
                {
                    titleBarBackground = new _loc_1;
                    _loc_2 = titleBarBackground as IStyleClient;
                    if (_loc_2)
                    {
                        _loc_2.setStyle("backgroundImage", undefined);
                    }
                    _loc_3 = titleBarBackground as ISimpleStyleClient;
                    if (_loc_3)
                    {
                        _loc_3.styleName = this;
                    }
                    titleBar.addChild(DisplayObject(titleBarBackground));
                }
            }
            createTitleTextField(-1);
            createStatusTextField(-1);
            if (!closeButton)
            {
                closeButton = new Button();
                closeButton.styleName = new StyleProxy(this, closeButtonStyleFilters);
                closeButton.upSkinName = "closeButtonUpSkin";
                closeButton.overSkinName = "closeButtonOverSkin";
                closeButton.downSkinName = "closeButtonDownSkin";
                closeButton.disabledSkinName = "closeButtonDisabledSkin";
                closeButton.skinName = "closeButtonSkin";
                var _loc_4:int = 16;
                closeButton.explicitHeight = 16;
                closeButton.explicitWidth = _loc_4;
                closeButton.focusEnabled = false;
                closeButton.visible = false;
                closeButton.enabled = enabled;
                closeButton.addEventListener(MouseEvent.CLICK, closeButton_clickHandler);
                titleBar.addChild(closeButton);
                closeButton.owner = this;
            }
            return;
        }// end function

        public function get constraintColumns() : Array
        {
            return _constraintColumns;
        }// end function

        override public function set cacheAsBitmap(param1:Boolean) : void
        {
            super.cacheAsBitmap = param1;
            if (cacheAsBitmap && !contentPane && cachePolicy != UIComponentCachePolicy.OFF && getStyle("backgroundColor"))
            {
                createContentPane();
                invalidateDisplayList();
            }
            return;
        }// end function

        override public function createComponentsFromDescriptors(param1:Boolean = true) : void
        {
            var _loc_3:Object = null;
            super.createComponentsFromDescriptors();
            if (numChildren == 0)
            {
                setControlBar(null);
                return;
            }
            var _loc_2:* = IUIComponent(getChildAt(numChildren--));
            if (_loc_2 is ControlBar)
            {
                _loc_3 = _loc_2.document;
                if (contentPane)
                {
                    contentPane.removeChild(DisplayObject(_loc_2));
                }
                else
                {
                    removeChild(DisplayObject(_loc_2));
                }
                _loc_2.document = _loc_3;
                rawChildren.addChild(DisplayObject(_loc_2));
                setControlBar(_loc_2);
            }
            else
            {
                setControlBar(null);
            }
            return;
        }// end function

        override protected function layoutChrome(param1:Number, param2:Number) : void
        {
            var _loc_9:Number = NaN;
            var _loc_10:Graphics = null;
            var _loc_11:Number = NaN;
            var _loc_12:Number = NaN;
            var _loc_13:Number = NaN;
            var _loc_14:Number = NaN;
            var _loc_15:Number = NaN;
            var _loc_16:Number = NaN;
            var _loc_17:Number = NaN;
            var _loc_18:Number = NaN;
            var _loc_19:Number = NaN;
            var _loc_20:Number = NaN;
            var _loc_21:Number = NaN;
            super.layoutChrome(param1, param2);
            var _loc_3:* = EdgeMetrics.EMPTY;
            var _loc_4:* = getStyle("borderThickness");
            if (getQualifiedClassName(border) == "mx.skins.halo::PanelSkin" && getStyle("borderStyle") != "default" && _loc_4)
            {
                _loc_3 = new EdgeMetrics(_loc_4, _loc_4, _loc_4, _loc_4);
            }
            var _loc_5:* = FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0 ? (borderMetrics) : (_loc_3);
            var _loc_6:* = (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0 ? (borderMetrics) : (_loc_3)).left;
            var _loc_7:* = _loc_5.top;
            var _loc_8:* = getHeaderHeight();
            if (getHeaderHeight() > 0 && height >= _loc_8)
            {
                _loc_9 = param1 - _loc_5.left - _loc_5.right;
                showTitleBar(true);
                titleBar.mouseChildren = true;
                titleBar.mouseEnabled = true;
                _loc_10 = titleBar.graphics;
                _loc_10.clear();
                _loc_10.beginFill(16777215, 0);
                _loc_10.drawRect(0, 0, _loc_9, _loc_8);
                _loc_10.endFill();
                titleBar.move(_loc_6, _loc_7);
                titleBar.setActualSize(_loc_9, _loc_8);
                titleBarBackground.move(0, 0);
                IFlexDisplayObject(titleBarBackground).setActualSize(_loc_9, _loc_8);
                closeButton.visible = _showCloseButton;
                if (_showCloseButton)
                {
                    closeButton.setActualSize(closeButton.getExplicitOrMeasuredWidth(), closeButton.getExplicitOrMeasuredHeight());
                    closeButton.move(param1 - _loc_6 - _loc_5.right - 10 - closeButton.getExplicitOrMeasuredWidth(), (_loc_8 - closeButton.getExplicitOrMeasuredHeight()) / 2);
                }
                _loc_11 = 10;
                _loc_12 = 10;
                if (titleIconObject)
                {
                    _loc_13 = titleIconObject.height;
                    _loc_14 = (_loc_8 - _loc_13) / 2;
                    titleIconObject.move(_loc_11, _loc_14);
                    _loc_11 = _loc_11 + (titleIconObject.width + 4);
                }
                if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
                {
                    _loc_13 = titleTextField.nonZeroTextHeight;
                }
                else
                {
                    _loc_13 = titleTextField.getUITextFormat().measureText(titleTextField.text).height;
                }
                _loc_14 = (_loc_8 - _loc_13) / 2;
                _loc_15 = _loc_5.left + _loc_5.right;
                titleTextField.move(_loc_11, _loc_14--);
                titleTextField.setActualSize(Math.max(0, param1 - _loc_11 - _loc_12 - _loc_15), _loc_13 + UITextField.TEXT_HEIGHT_PADDING);
                if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
                {
                    _loc_13 = statusTextField.textHeight;
                }
                else
                {
                    _loc_13 = statusTextField.text != "" ? (statusTextField.getUITextFormat().measureText(statusTextField.text).height) : (0);
                }
                _loc_14 = (_loc_8 - _loc_13) / 2;
                _loc_16 = param1 - _loc_12 - 4 - _loc_15 - statusTextField.textWidth;
                if (_showCloseButton)
                {
                    _loc_16 = _loc_16 - (closeButton.getExplicitOrMeasuredWidth() + 4);
                }
                statusTextField.move(_loc_16, _loc_14--);
                statusTextField.setActualSize(statusTextField.textWidth + 8, statusTextField.textHeight + UITextField.TEXT_HEIGHT_PADDING);
                _loc_17 = titleTextField.x + titleTextField.textWidth + 8;
                if (statusTextField.x < _loc_17)
                {
                    statusTextField.width = Math.max(statusTextField.width - (_loc_17 - statusTextField.x), 0);
                    statusTextField.x = _loc_17;
                }
            }
            else if (titleBar)
            {
                showTitleBar(false);
                titleBar.mouseChildren = false;
                titleBar.mouseEnabled = false;
            }
            if (controlBar)
            {
                _loc_18 = controlBar.x;
                _loc_19 = controlBar.y;
                _loc_20 = controlBar.width;
                _loc_21 = controlBar.height;
                controlBar.setActualSize(param1 - (_loc_5.left + _loc_5.right), controlBar.getExplicitOrMeasuredHeight());
                controlBar.move(_loc_5.left, param2 - _loc_5.bottom - controlBar.getExplicitOrMeasuredHeight());
                if (controlBar.includeInLayout)
                {
                    controlBar.visible = controlBar.y >= _loc_5.top;
                }
                if (_loc_18 != controlBar.x || _loc_19 != controlBar.y || _loc_20 != controlBar.width || _loc_21 != controlBar.height)
                {
                    invalidateDisplayList();
                }
            }
            return;
        }// end function

        public function set layout(param1:String) : void
        {
            if (_layout != param1)
            {
                _layout = param1;
                if (layoutObject)
                {
                    layoutObject.target = null;
                }
                if (_layout == ContainerLayout.ABSOLUTE)
                {
                    layoutObject = new CanvasLayout();
                }
                else
                {
                    layoutObject = new BoxLayout();
                    if (_layout == ContainerLayout.VERTICAL)
                    {
                        BoxLayout(layoutObject).direction = BoxDirection.VERTICAL;
                    }
                    else
                    {
                        BoxLayout(layoutObject).direction = BoxDirection.HORIZONTAL;
                    }
                }
                if (layoutObject)
                {
                    layoutObject.target = this;
                }
                invalidateSize();
                invalidateDisplayList();
                dispatchEvent(new Event("layoutChanged"));
            }
            return;
        }// end function

        public function get constraintRows() : Array
        {
            return _constraintRows;
        }// end function

        public function get title() : String
        {
            return _title;
        }// end function

        function getTitleTextField() : IUITextField
        {
            return titleTextField;
        }// end function

        function createStatusTextField(param1:int) : void
        {
            var _loc_2:String = null;
            if (titleBar && !statusTextField)
            {
                statusTextField = IUITextField(createInFontContext(UITextField));
                statusTextField.selectable = false;
                if (param1 == -1)
                {
                    titleBar.addChild(DisplayObject(statusTextField));
                }
                else
                {
                    titleBar.addChildAt(DisplayObject(statusTextField), param1);
                }
                _loc_2 = getStyle("statusStyleName");
                statusTextField.styleName = _loc_2;
                statusTextField.text = status;
                statusTextField.enabled = enabled;
            }
            return;
        }// end function

        public function get fontContext() : IFlexModuleFactory
        {
            return moduleFactory;
        }// end function

        override protected function measure() : void
        {
            var _loc_6:Number = NaN;
            super.measure();
            layoutObject.measure();
            var _loc_1:* = measureHeaderText();
            var _loc_2:* = _loc_1.width;
            var _loc_3:* = _loc_1.height;
            var _loc_4:* = FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0 ? (borderMetrics) : (EdgeMetrics.EMPTY);
            _loc_2 = _loc_2 + (_loc_4.left + _loc_4.right);
            var _loc_5:Number = 5;
            _loc_2 = _loc_2 + _loc_5 * 2;
            if (titleIconObject)
            {
                _loc_2 = _loc_2 + titleIconObject.width;
            }
            if (closeButton)
            {
                _loc_2 = _loc_2 + (closeButton.getExplicitOrMeasuredWidth() + 6);
            }
            measuredMinWidth = Math.max(_loc_2, measuredMinWidth);
            measuredWidth = Math.max(_loc_2, measuredWidth);
            if (controlBar && controlBar.includeInLayout)
            {
                _loc_6 = controlBar.getExplicitOrMeasuredWidth() + _loc_4.left + _loc_4.right;
                measuredWidth = Math.max(measuredWidth, _loc_6);
            }
            return;
        }// end function

        function getControlBar() : IUIComponent
        {
            return controlBar;
        }// end function

        override public function get viewMetrics() : EdgeMetrics
        {
            var _loc_2:EdgeMetrics = null;
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_6:Number = NaN;
            var _loc_7:Number = NaN;
            var _loc_8:Number = NaN;
            var _loc_1:* = super.viewMetrics;
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                if (!panelViewMetrics)
                {
                    panelViewMetrics = new EdgeMetrics(0, 0, 0, 0);
                }
                _loc_1 = panelViewMetrics;
                _loc_2 = super.viewMetrics;
                _loc_3 = getStyle("borderThickness");
                _loc_4 = getStyle("borderThicknessLeft");
                _loc_5 = getStyle("borderThicknessTop");
                _loc_6 = getStyle("borderThicknessRight");
                _loc_7 = getStyle("borderThicknessBottom");
                _loc_1.left = _loc_2.left + (isNaN(_loc_4) ? (_loc_3) : (_loc_4));
                _loc_1.top = _loc_2.top + (isNaN(_loc_5) ? (_loc_3) : (_loc_5));
                _loc_1.right = _loc_2.right + (isNaN(_loc_6) ? (_loc_3) : (_loc_6));
                if (controlBar)
                {
                }
                _loc_1.bottom = _loc_2.bottom + (isNaN(_loc_7) ? (if (!controlBar) goto 27, !isNaN(_loc_5) ? (_loc_5) : (isNaN(_loc_4) ? (_loc_3) : (_loc_4))) : (_loc_7));
                _loc_8 = getHeaderHeight();
                if (!isNaN(_loc_8))
                {
                    _loc_1.top = _loc_1.top + _loc_8;
                }
                if (controlBar && controlBar.includeInLayout)
                {
                    _loc_1.bottom = _loc_1.bottom + controlBar.getExplicitOrMeasuredHeight();
                }
            }
            return _loc_1;
        }// end function

        private function measureHeaderText() : Rectangle
        {
            var _loc_3:UITextFormat = null;
            var _loc_4:TextLineMetrics = null;
            var _loc_1:Number = 20;
            var _loc_2:Number = 14;
            if (titleTextField && titleTextField.text)
            {
                titleTextField.validateNow();
                _loc_3 = titleTextField.getUITextFormat();
                _loc_4 = _loc_3.measureText(titleTextField.text, false);
                _loc_1 = _loc_4.width;
                _loc_2 = _loc_4.height;
            }
            if (statusTextField && statusTextField.text)
            {
                statusTextField.validateNow();
                _loc_3 = statusTextField.getUITextFormat();
                _loc_4 = _loc_3.measureText(statusTextField.text, false);
                _loc_1 = Math.max(_loc_1, _loc_4.width);
                _loc_2 = Math.max(_loc_2, _loc_4.height);
            }
            return new Rectangle(0, 0, Math.round(_loc_1), Math.round(_loc_2));
        }// end function

        function createTitleTextField(param1:int) : void
        {
            var _loc_2:String = null;
            if (!titleTextField)
            {
                titleTextField = IUITextField(createInFontContext(UITextField));
                titleTextField.selectable = false;
                if (param1 == -1)
                {
                    titleBar.addChild(DisplayObject(titleTextField));
                }
                else
                {
                    titleBar.addChildAt(DisplayObject(titleTextField), param1);
                }
                _loc_2 = getStyle("titleStyleName");
                titleTextField.styleName = _loc_2;
                titleTextField.text = title;
                titleTextField.enabled = enabled;
            }
            return;
        }// end function

        private function closeButton_clickHandler(event:MouseEvent) : void
        {
            dispatchEvent(new CloseEvent(CloseEvent.CLOSE));
            return;
        }// end function

        private function setControlBar(param1:IUIComponent) : void
        {
            if (param1 == controlBar)
            {
                return;
            }
            controlBar = param1;
            if (!checkedForAutoSetRoundedCorners)
            {
                checkedForAutoSetRoundedCorners = true;
                autoSetRoundedCorners = styleDeclaration ? (styleDeclaration.getStyle("roundedBottomCorners") === undefined) : (true);
            }
            if (autoSetRoundedCorners)
            {
                setStyle("roundedBottomCorners", controlBar != null);
            }
            var _loc_2:* = getStyle("controlBarStyleName");
            if (_loc_2 && controlBar is ISimpleStyleClient)
            {
                ISimpleStyleClient(controlBar).styleName = _loc_2;
            }
            if (controlBar)
            {
                controlBar.enabled = enabled;
            }
            if (controlBar is IAutomationObject)
            {
                IAutomationObject(controlBar).showInAutomationHierarchy = false;
            }
            invalidateViewMetricsAndPadding();
            invalidateSize();
            invalidateDisplayList();
            return;
        }// end function

        protected function get closeButtonStyleFilters() : Object
        {
            return _closeButtonStyleFilters;
        }// end function

        public function set constraintColumns(param1:Array) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            if (param1 != _constraintColumns)
            {
                _loc_2 = param1.length;
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    ConstraintColumn(param1[_loc_3]).container = this;
                    _loc_3++;
                }
                _constraintColumns = param1;
                invalidateSize();
                invalidateDisplayList();
            }
            return;
        }// end function

        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            if (titleTextField)
            {
                titleTextField.enabled = param1;
            }
            if (statusTextField)
            {
                statusTextField.enabled = param1;
            }
            if (controlBar)
            {
                controlBar.enabled = param1;
            }
            if (closeButton)
            {
                closeButton.enabled = param1;
            }
            return;
        }// end function

        override public function get baselinePosition() : Number
        {
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                return super.baselinePosition;
            }
            if (!validateBaselinePosition())
            {
                return NaN;
            }
            return titleBar.y + titleTextField.y + titleTextField.baselinePosition;
        }// end function

        protected function stopDragging() : void
        {
            var _loc_1:* = systemManager.getSandboxRoot();
            _loc_1.removeEventListener(MouseEvent.MOUSE_MOVE, systemManager_mouseMoveHandler, true);
            _loc_1.removeEventListener(MouseEvent.MOUSE_UP, systemManager_mouseUpHandler, true);
            _loc_1.removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, stage_mouseLeaveHandler);
            regX = NaN;
            regY = NaN;
            systemManager.deployMouseShields(false);
            return;
        }// end function

        private function titleBar_mouseDownHandler(event:MouseEvent) : void
        {
            if (event.target == closeButton)
            {
                return;
            }
            if (enabled && isPopUp && isNaN(regX))
            {
                startDragging(event);
            }
            return;
        }// end function

        override function get usePadding() : Boolean
        {
            return layout != ContainerLayout.ABSOLUTE;
        }// end function

        override protected function initializeAccessibility() : void
        {
            if (Panel.createAccessibilityImplementation != null)
            {
                Panel.createAccessibilityImplementation(this);
            }
            return;
        }// end function

        protected function getHeaderHeight() : Number
        {
            var _loc_1:* = getStyle("headerHeight");
            if (isNaN(_loc_1))
            {
                _loc_1 = measureHeaderText().height + HEADER_PADDING;
            }
            return _loc_1;
        }// end function

        public function set constraintRows(param1:Array) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            if (param1 != _constraintRows)
            {
                _loc_2 = param1.length;
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    ConstraintRow(param1[_loc_3]).container = this;
                    _loc_3++;
                }
                _constraintRows = param1;
                invalidateSize();
                invalidateDisplayList();
            }
            return;
        }// end function

        public function set title(param1:String) : void
        {
            _title = param1;
            _titleChanged = true;
            invalidateProperties();
            invalidateSize();
            invalidateViewMetricsAndPadding();
            dispatchEvent(new Event("titleChanged"));
            return;
        }// end function

        private function showTitleBar(param1:Boolean) : void
        {
            var _loc_4:DisplayObject = null;
            titleBar.visible = param1;
            var _loc_2:* = titleBar.numChildren;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = titleBar.getChildAt(_loc_3);
                _loc_4.visible = param1;
                _loc_3++;
            }
            return;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            var _loc_3:String = null;
            var _loc_4:String = null;
            var _loc_5:String = null;
            var _loc_6:Class = null;
            var _loc_7:IStyleClient = null;
            var _loc_8:ISimpleStyleClient = null;
            if (param1)
            {
            }
            var _loc_2:* = param1 == "styleName";
            super.styleChanged(param1);
            if (_loc_2 || param1 == "titleStyleName")
            {
                if (titleTextField)
                {
                    _loc_3 = getStyle("titleStyleName");
                    titleTextField.styleName = _loc_3;
                }
            }
            if (_loc_2 || param1 == "statusStyleName")
            {
                if (statusTextField)
                {
                    _loc_4 = getStyle("statusStyleName");
                    statusTextField.styleName = _loc_4;
                }
            }
            if (_loc_2 || param1 == "controlBarStyleName")
            {
                if (controlBar && controlBar is ISimpleStyleClient)
                {
                    _loc_5 = getStyle("controlBarStyleName");
                    ISimpleStyleClient(controlBar).styleName = _loc_5;
                }
            }
            if (_loc_2 || param1 == "titleBackgroundSkin")
            {
                if (titleBar)
                {
                    _loc_6 = getStyle("titleBackgroundSkin");
                    if (_loc_6)
                    {
                        if (titleBarBackground)
                        {
                            titleBar.removeChild(DisplayObject(titleBarBackground));
                            titleBarBackground = null;
                        }
                        titleBarBackground = new _loc_6;
                        _loc_7 = titleBarBackground as IStyleClient;
                        if (_loc_7)
                        {
                            _loc_7.setStyle("backgroundImage", undefined);
                        }
                        _loc_8 = titleBarBackground as ISimpleStyleClient;
                        if (_loc_8)
                        {
                            _loc_8.styleName = this;
                        }
                        titleBar.addChildAt(DisplayObject(titleBarBackground), 0);
                    }
                }
            }
            return;
        }// end function

        function getStatusTextField() : IUITextField
        {
            return statusTextField;
        }// end function

        public function set fontContext(param1:IFlexModuleFactory) : void
        {
            this.moduleFactory = param1;
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:int = 0;
            super.commitProperties();
            if (hasFontContextChanged())
            {
                if (titleTextField)
                {
                    _loc_1 = titleBar.getChildIndex(DisplayObject(titleTextField));
                    removeTitleTextField();
                    createTitleTextField(_loc_1);
                    _titleChanged = true;
                }
                if (statusTextField)
                {
                    _loc_1 = titleBar.getChildIndex(DisplayObject(statusTextField));
                    removeStatusTextField();
                    createStatusTextField(_loc_1);
                    _statusChanged = true;
                }
            }
            if (_titleChanged)
            {
                _titleChanged = false;
                titleTextField.text = _title;
                if (initialized)
                {
                    layoutChrome(unscaledWidth, unscaledHeight);
                }
            }
            if (_titleIconChanged)
            {
                _titleIconChanged = false;
                if (titleIconObject)
                {
                    titleBar.removeChild(DisplayObject(titleIconObject));
                    titleIconObject = null;
                }
                if (_titleIcon)
                {
                    titleIconObject = new _titleIcon();
                    titleBar.addChild(DisplayObject(titleIconObject));
                }
                if (initialized)
                {
                    layoutChrome(unscaledWidth, unscaledHeight);
                }
            }
            if (_statusChanged)
            {
                _statusChanged = false;
                statusTextField.text = _status;
                if (initialized)
                {
                    layoutChrome(unscaledWidth, unscaledHeight);
                }
            }
            return;
        }// end function

        protected function startDragging(event:MouseEvent) : void
        {
            regX = event.stageX - x;
            regY = event.stageY - y;
            var _loc_2:* = systemManager.getSandboxRoot();
            _loc_2.addEventListener(MouseEvent.MOUSE_MOVE, systemManager_mouseMoveHandler, true);
            _loc_2.addEventListener(MouseEvent.MOUSE_UP, systemManager_mouseUpHandler, true);
            _loc_2.addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, stage_mouseLeaveHandler);
            systemManager.deployMouseShields(true);
            return;
        }// end function

        function removeStatusTextField() : void
        {
            if (titleBar && statusTextField)
            {
                titleBar.removeChild(DisplayObject(statusTextField));
                statusTextField = null;
            }
            return;
        }// end function

        private function stage_mouseLeaveHandler(event:Event) : void
        {
            if (!isNaN(regX))
            {
                stopDragging();
            }
            return;
        }// end function

        public function set status(param1:String) : void
        {
            _status = param1;
            _statusChanged = true;
            invalidateProperties();
            dispatchEvent(new Event("statusChanged"));
            return;
        }// end function

        public function get titleIcon() : Class
        {
            return _titleIcon;
        }// end function

        public function get status() : String
        {
            return _status;
        }// end function

        private function systemManager_mouseMoveHandler(event:MouseEvent) : void
        {
            event.stopImmediatePropagation();
            if (isNaN(regX) || isNaN(regY))
            {
                return;
            }
            move(event.stageX - regX, event.stageY - regY);
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            layoutObject.updateDisplayList(param1, param2);
            if (border)
            {
                border.visible = true;
            }
            titleBar.visible = true;
            return;
        }// end function

        function removeTitleTextField() : void
        {
            if (titleBar && titleTextField)
            {
                titleBar.removeChild(DisplayObject(titleTextField));
                titleTextField = null;
            }
            return;
        }// end function

        public function set titleIcon(param1:Class) : void
        {
            _titleIcon = param1;
            _titleIconChanged = true;
            invalidateProperties();
            invalidateSize();
            dispatchEvent(new Event("titleIconChanged"));
            return;
        }// end function

    }
}
