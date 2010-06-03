package mx.core
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.system.*;
    import flash.text.*;
    import flash.utils.*;
    import mx.automation.*;
    import mx.binding.*;
    import mx.controls.*;
    import mx.effects.*;
    import mx.events.*;
    import mx.graphics.*;
    import mx.managers.*;
    import mx.modules.*;
    import mx.resources.*;
    import mx.states.*;
    import mx.styles.*;
    import mx.utils.*;

    public class UIComponent extends FlexSprite implements IAutomationObject, IChildList, IDeferredInstantiationUIComponent, IFlexDisplayObject, IFlexModule, IInvalidating, ILayoutManagerClient, IPropertyChangeNotifier, IRepeaterClient, ISimpleStyleClient, IStyleClient, IToolTipManagerClient, IUIComponent, IValidatorListener, IStateClient, IConstraintClient
    {
        private var cachedEmbeddedFont:EmbeddedFont = null;
        private var errorStringChanged:Boolean = false;
        var overlay:UIComponent;
        var automaticRadioButtonGroups:Object;
        private var _currentState:String;
        private var _isPopUp:Boolean;
        private var _repeaters:Array;
        private var _systemManager:ISystemManager;
        private var _measuredWidth:Number = 0;
        private var methodQueue:Array;
        var _width:Number;
        private var _tweeningProperties:Array;
        private var _validationSubField:String;
        private var _endingEffectInstances:Array;
        var saveBorderColor:Boolean = true;
        var overlayColor:uint;
        var overlayReferenceCount:int = 0;
        private var hasFontContextBeenSaved:Boolean = false;
        private var _repeaterIndices:Array;
        private var oldExplicitWidth:Number;
        var _descriptor:UIComponentDescriptor;
        private var _initialized:Boolean = false;
        private var _focusEnabled:Boolean = true;
        private var cacheAsBitmapCount:int = 0;
        private var requestedCurrentState:String;
        private var listeningForRender:Boolean = false;
        var invalidateDisplayListFlag:Boolean = false;
        private var oldScaleX:Number = 1;
        private var oldScaleY:Number = 1;
        var _explicitMaxHeight:Number;
        var invalidatePropertiesFlag:Boolean = false;
        private var hasFocusRect:Boolean = false;
        var invalidateSizeFlag:Boolean = false;
        private var _scaleX:Number = 1;
        private var _scaleY:Number = 1;
        private var _styleDeclaration:CSSStyleDeclaration;
        private var _resourceManager:IResourceManager;
        var _affectedProperties:Object;
        var _documentDescriptor:UIComponentDescriptor;
        private var _processedDescriptors:Boolean = false;
        var origBorderColor:Number;
        private var _focusManager:IFocusManager;
        private var _cachePolicy:String = "auto";
        private var _measuredHeight:Number = 0;
        private var _id:String;
        private var _owner:DisplayObjectContainer;
        public var transitions:Array;
        var _parent:DisplayObjectContainer;
        private var _measuredMinWidth:Number = 0;
        private var oldMinWidth:Number;
        private var _explicitWidth:Number;
        private var _enabled:Boolean = false;
        public var states:Array;
        private var _mouseFocusEnabled:Boolean = true;
        private var oldHeight:Number = 0;
        private var _currentStateChanged:Boolean;
        private var cachedTextFormat:UITextFormat;
        var _height:Number;
        private var _automationDelegate:IAutomationObject;
        private var _percentWidth:Number;
        private var _automationName:String = null;
        private var _isEffectStarted:Boolean = false;
        private var _styleName:Object;
        private var lastUnscaledWidth:Number;
        var _document:Object;
        var _errorString:String = "";
        private var oldExplicitHeight:Number;
        private var _nestLevel:int = 0;
        private var _systemManagerDirty:Boolean = false;
        private var _explicitHeight:Number;
        var _toolTip:String;
        private var _filters:Array;
        private var _focusPane:Sprite;
        private var playStateTransition:Boolean = true;
        private var _nonInheritingStyles:Object;
        private var _showInAutomationHierarchy:Boolean = true;
        private var _moduleFactory:IFlexModuleFactory;
        private var preventDrawFocus:Boolean = false;
        private var oldX:Number = 0;
        private var oldY:Number = 0;
        private var _instanceIndices:Array;
        private var _visible:Boolean = true;
        private var _inheritingStyles:Object;
        private var _includeInLayout:Boolean = true;
        var _effectsStarted:Array;
        var _explicitMinWidth:Number;
        private var lastUnscaledHeight:Number;
        var _explicitMaxWidth:Number;
        private var _measuredMinHeight:Number = 0;
        private var _uid:String;
        private var _currentTransitionEffect:IEffect;
        private var _updateCompletePendingFlag:Boolean = false;
        private var oldMinHeight:Number;
        private var _flexContextMenu:IFlexContextMenu;
        var _explicitMinHeight:Number;
        private var _percentHeight:Number;
        private var oldEmbeddedFontContext:IFlexModuleFactory = null;
        private var oldWidth:Number = 0;
        static var dispatchEventHook:Function;
        private static var fakeMouseY:QName = new QName(mx_internal, "_mouseY");
        public static const DEFAULT_MEASURED_WIDTH:Number = 160;
        public static const DEFAULT_MAX_WIDTH:Number = 10000;
        public static const DEFAULT_MEASURED_MIN_HEIGHT:Number = 22;
        static var createAccessibilityImplementation:Function;
        static var STYLE_UNINITIALIZED:Object = {};
        private static var fakeMouseX:QName = new QName(mx_internal, "_mouseX");
        public static const DEFAULT_MAX_HEIGHT:Number = 10000;
        public static const DEFAULT_MEASURED_HEIGHT:Number = 22;
        private static var _embeddedFontRegistry:IEmbeddedFontRegistry;
        static const VERSION:String = "3.2.0.3958";
        public static const DEFAULT_MEASURED_MIN_WIDTH:Number = 40;

        public function UIComponent()
        {
            methodQueue = [];
            _resourceManager = ResourceManager.getInstance();
            _inheritingStyles = UIComponent.STYLE_UNINITIALIZED;
            _nonInheritingStyles = UIComponent.STYLE_UNINITIALIZED;
            states = [];
            transitions = [];
            _effectsStarted = [];
            _affectedProperties = {};
            _endingEffectInstances = [];
            focusRect = false;
            tabEnabled = this is IFocusManagerComponent;
            tabChildren = false;
            enabled = true;
            $visible = false;
            addEventListener(Event.ADDED, addedHandler);
            addEventListener(Event.REMOVED, removedHandler);
            if (this is IFocusManagerComponent)
            {
                addEventListener(FocusEvent.FOCUS_IN, focusInHandler);
                addEventListener(FocusEvent.FOCUS_OUT, focusOutHandler);
                addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
                addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
            }
            resourcesChanged();
            resourceManager.addEventListener(Event.CHANGE, resourceManager_changeHandler, false, 0, true);
            _width = super.width;
            _height = super.height;
            return;
        }// end function

        override public function get filters() : Array
        {
            return _filters ? (_filters) : (super.filters);
        }// end function

        public function get toolTip() : String
        {
            return _toolTip;
        }// end function

        private function transition_effectEndHandler(event:EffectEvent) : void
        {
            _currentTransitionEffect = null;
            return;
        }// end function

        public function get nestLevel() : int
        {
            return _nestLevel;
        }// end function

        protected function adjustFocusRect(param1:DisplayObject = null) : void
        {
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_6:Point = null;
            var _loc_7:Number = NaN;
            if (!param1)
            {
                param1 = this;
            }
            if (isNaN(param1.width) || isNaN(param1.height))
            {
                return;
            }
            var _loc_2:* = focusManager;
            if (!_loc_2)
            {
                return;
            }
            var _loc_3:* = IFlexDisplayObject(getFocusObject());
            if (_loc_3)
            {
                if (errorString && errorString != "")
                {
                    _loc_4 = getStyle("errorColor");
                }
                else
                {
                    _loc_4 = getStyle("themeColor");
                }
                _loc_5 = getStyle("focusThickness");
                if (_loc_3 is IStyleClient)
                {
                    IStyleClient(_loc_3).setStyle("focusColor", _loc_4);
                }
                _loc_3.setActualSize(param1.width + 2 * _loc_5, param1.height + 2 * _loc_5);
                if (rotation)
                {
                    _loc_7 = rotation * Math.PI / 180;
                    _loc_6 = new Point(param1.x - _loc_5 * (Math.cos(_loc_7) - Math.sin(_loc_7)), param1.y - _loc_5 * (Math.cos(_loc_7) + Math.sin(_loc_7)));
                    DisplayObject(_loc_3).rotation = rotation;
                }
                else
                {
                    _loc_6 = new Point(param1.x - _loc_5, param1.y - _loc_5);
                }
                if (param1.parent == this)
                {
                    _loc_6.x = _loc_6.x + x;
                    _loc_6.y = _loc_6.y + y;
                }
                _loc_6 = parent.localToGlobal(_loc_6);
                _loc_6 = parent.globalToLocal(_loc_6);
                _loc_3.move(_loc_6.x, _loc_6.y);
                if (_loc_3 is IInvalidating)
                {
                    IInvalidating(_loc_3).validateNow();
                }
                else if (_loc_3 is IProgrammaticSkin)
                {
                    IProgrammaticSkin(_loc_3).mx.core:IProgrammaticSkin::validateNow();
                }
            }
            return;
        }// end function

        function setUnscaledWidth(param1:Number) : void
        {
            var _loc_2:* = param1 * Math.abs(oldScaleX);
            if (_explicitWidth == _loc_2)
            {
                return;
            }
            if (!isNaN(_loc_2))
            {
                _percentWidth = NaN;
            }
            _explicitWidth = _loc_2;
            invalidateSize();
            var _loc_3:* = parent as IInvalidating;
            if (_loc_3 && includeInLayout)
            {
                _loc_3.invalidateSize();
                _loc_3.invalidateDisplayList();
            }
            return;
        }// end function

        private function isOnDisplayList() : Boolean
        {
            var p:DisplayObjectContainer;
            try
            {
                p = _parent ? (_parent) : (super.parent);
            }
            catch (e:SecurityError)
            {
                return true;
            }
            return p ? (true) : (false);
        }// end function

        public function set nestLevel(param1:int) : void
        {
            var _loc_2:IChildList = null;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:ILayoutManagerClient = null;
            var _loc_6:IUITextField = null;
            if (param1 > 1 && _nestLevel != param1)
            {
                _nestLevel = param1;
                updateCallbacks();
                _loc_2 = this is IRawChildrenContainer ? (IRawChildrenContainer(this).rawChildren) : (IChildList(this));
                _loc_3 = _loc_2.numChildren;
                _loc_4 = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    _loc_5 = _loc_2.getChildAt(_loc_4) as ILayoutManagerClient;
                    if (_loc_5)
                    {
                        _loc_5.nestLevel = param1 + 1;
                    }
                    else
                    {
                        _loc_6 = _loc_2.getChildAt(_loc_4) as IUITextField;
                        if (_loc_6)
                        {
                            _loc_6.mx.core:IUITextField::nestLevel = param1 + 1;
                        }
                    }
                    _loc_4++;
                }
            }
            return;
        }// end function

        public function getExplicitOrMeasuredHeight() : Number
        {
            return !isNaN(explicitHeight) ? (explicitHeight) : (measuredHeight);
        }// end function

        private function callLaterDispatcher(event:Event) : void
        {
            var callLaterErrorEvent:DynamicEvent;
            var event:* = event;
            var _loc_3:* = UIComponentGlobals;
            _loc_3.callLaterDispatcherCount = UIComponentGlobals.callLaterDispatcherCount++;
            if (!UIComponentGlobals.catchCallLaterExceptions)
            {
                callLaterDispatcher2(event);
            }
            else
            {
                try
                {
                    callLaterDispatcher2(event);
                }
                catch (e:Error)
                {
                    callLaterErrorEvent = new DynamicEvent("callLaterError");
                    callLaterErrorEvent.error = e;
                    systemManager.dispatchEvent(callLaterErrorEvent);
                }
            }
            var _loc_3:* = UIComponentGlobals;
            _loc_3.callLaterDispatcherCount = UIComponentGlobals.callLaterDispatcherCount--;
            return;
        }// end function

        public function getStyle(param1:String)
        {
            return StyleManager.inheritingStyles[param1] ? (_inheritingStyles[param1]) : (_nonInheritingStyles[param1]);
        }// end function

        final function get $width() : Number
        {
            return super.width;
        }// end function

        public function get className() : String
        {
            var _loc_1:* = getQualifiedClassName(this);
            var _loc_2:* = _loc_1.indexOf("::");
            if (_loc_2 != -1)
            {
                _loc_1 = _loc_1.substr(_loc_2 + 2);
            }
            return _loc_1;
        }// end function

        public function verticalGradientMatrix(param1:Number, param2:Number, param3:Number, param4:Number) : Matrix
        {
            UIComponentGlobals.tempMatrix.createGradientBox(param3, param4, Math.PI / 2, param1, param2);
            return UIComponentGlobals.tempMatrix;
        }// end function

        public function setCurrentState(param1:String, param2:Boolean = true) : void
        {
            if (param1 != currentState && isBaseState(param1) && !isBaseState(currentState))
            {
                requestedCurrentState = param1;
                playStateTransition = param2;
                if (initialized)
                {
                    commitCurrentState();
                }
                else
                {
                    _currentStateChanged = true;
                    addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
                }
            }
            return;
        }// end function

        private function getBaseStates(param1:State) : Array
        {
            var _loc_2:Array = [];
            while (param1 && param1.basedOn)
            {
                
                _loc_2.push(param1.basedOn);
                param1 = getState(param1.basedOn);
            }
            return _loc_2;
        }// end function

        public function set minHeight(param1:Number) : void
        {
            if (explicitMinHeight == param1)
            {
                return;
            }
            explicitMinHeight = param1;
            return;
        }// end function

        protected function isOurFocus(param1:DisplayObject) : Boolean
        {
            return param1 == this;
        }// end function

        public function get errorString() : String
        {
            return _errorString;
        }// end function

        function setUnscaledHeight(param1:Number) : void
        {
            var _loc_2:* = param1 * Math.abs(oldScaleY);
            if (_explicitHeight == _loc_2)
            {
                return;
            }
            if (!isNaN(_loc_2))
            {
                _percentHeight = NaN;
            }
            _explicitHeight = _loc_2;
            invalidateSize();
            var _loc_3:* = parent as IInvalidating;
            if (_loc_3 && includeInLayout)
            {
                _loc_3.invalidateSize();
                _loc_3.invalidateDisplayList();
            }
            return;
        }// end function

        public function get automationName() : String
        {
            if (_automationName)
            {
                return _automationName;
            }
            if (automationDelegate)
            {
                return automationDelegate.automationName;
            }
            return "";
        }// end function

        final function set $width(param1:Number) : void
        {
            super.width = param1;
            return;
        }// end function

        public function getVisibleRect(param1:DisplayObject = null) : Rectangle
        {
            if (!param1)
            {
                param1 = DisplayObject(systemManager);
            }
            var _loc_2:* = new Point(x, y);
            var _loc_3:* = $parent ? ($parent) : (parent);
            _loc_2 = _loc_3.localToGlobal(_loc_2);
            var _loc_4:* = new Rectangle(_loc_2.x, _loc_2.y, width, height);
            var _loc_5:DisplayObject = this;
            var _loc_6:* = new Rectangle();
            do
            {
                
                if (_loc_5 is UIComponent)
                {
                    if (UIComponent(_loc_5).$parent)
                    {
                        _loc_5 = UIComponent(_loc_5).$parent;
                    }
                    else
                    {
                        _loc_5 = UIComponent(_loc_5).parent;
                    }
                }
                else
                {
                    _loc_5 = _loc_5.parent;
                }
                if (_loc_5 && _loc_5.scrollRect)
                {
                    _loc_6 = _loc_5.scrollRect.clone();
                    _loc_2 = _loc_5.localToGlobal(_loc_6.topLeft);
                    _loc_6.x = _loc_2.x;
                    _loc_6.y = _loc_2.y;
                    _loc_4 = _loc_4.intersection(_loc_6);
                }
            }while (_loc_5 && _loc_5 != param1)
            return _loc_4;
        }// end function

        public function invalidateDisplayList() : void
        {
            if (!invalidateDisplayListFlag)
            {
                invalidateDisplayListFlag = true;
                if (isOnDisplayList() && UIComponentGlobals.layoutManager)
                {
                    UIComponentGlobals.layoutManager.mx.managers:ILayoutManager::invalidateDisplayList(this);
                }
            }
            return;
        }// end function

        function initThemeColor() : Boolean
        {
            var _loc_2:Object = null;
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            var _loc_5:Object = null;
            var _loc_6:Array = null;
            var _loc_7:int = 0;
            var _loc_8:CSSStyleDeclaration = null;
            var _loc_1:* = _styleName;
            if (_styleDeclaration)
            {
                _loc_2 = _styleDeclaration.getStyle("themeColor");
                _loc_3 = _styleDeclaration.getStyle("rollOverColor");
                _loc_4 = _styleDeclaration.getStyle("selectionColor");
            }
            if (_loc_2 === null || !StyleManager.isValidStyleValue(_loc_2) && _loc_1 && !(_loc_1 is ISimpleStyleClient))
            {
                _loc_5 = _loc_1 is String ? (StyleManager.getStyleDeclaration("." + _loc_1)) : (_loc_1);
                if (_loc_5)
                {
                    _loc_2 = _loc_5.getStyle("themeColor");
                    _loc_3 = _loc_5.getStyle("rollOverColor");
                    _loc_4 = _loc_5.getStyle("selectionColor");
                }
            }
            if (_loc_2 === null || !StyleManager.isValidStyleValue(_loc_2))
            {
                _loc_6 = getClassStyleDeclarations();
                _loc_7 = 0;
                while (_loc_7 < _loc_6.length)
                {
                    
                    _loc_8 = _loc_6[_loc_7];
                    if (_loc_8)
                    {
                        _loc_2 = _loc_8.getStyle("themeColor");
                        _loc_3 = _loc_8.getStyle("rollOverColor");
                        _loc_4 = _loc_8.getStyle("selectionColor");
                    }
                    if (_loc_2 !== null && StyleManager.isValidStyleValue(_loc_2))
                    {
                        break;
                    }
                    _loc_7++;
                }
            }
            if (_loc_2 !== null && StyleManager.isValidStyleValue(_loc_2) && isNaN(_loc_3) && isNaN(_loc_4))
            {
                setThemeColor(_loc_2);
                return true;
            }
            if (_loc_2 !== null && StyleManager.isValidStyleValue(_loc_2) && !isNaN(_loc_3))
            {
            }
            return !isNaN(_loc_4);
        }// end function

        override public function get scaleX() : Number
        {
            return _scaleX;
        }// end function

        public function get uid() : String
        {
            if (!_uid)
            {
                _uid = toString();
            }
            return _uid;
        }// end function

        override public function get mouseX() : Number
        {
            if (!root || root is Stage || root[fakeMouseX] === undefined)
            {
                return super.mouseX;
            }
            return globalToLocal(new Point(root[fakeMouseX], 0)).x;
        }// end function

        override public function stopDrag() : void
        {
            super.stopDrag();
            invalidateProperties();
            dispatchEvent(new Event("xChanged"));
            dispatchEvent(new Event("yChanged"));
            return;
        }// end function

        public function get focusPane() : Sprite
        {
            return _focusPane;
        }// end function

        public function set tweeningProperties(param1:Array) : void
        {
            _tweeningProperties = param1;
            return;
        }// end function

        public function horizontalGradientMatrix(param1:Number, param2:Number, param3:Number, param4:Number) : Matrix
        {
            UIComponentGlobals.tempMatrix.createGradientBox(param3, param4, 0, param1, param2);
            return UIComponentGlobals.tempMatrix;
        }// end function

        public function get isDocument() : Boolean
        {
            return document == this;
        }// end function

        public function set validationSubField(param1:String) : void
        {
            _validationSubField = param1;
            return;
        }// end function

        override public function get scaleY() : Number
        {
            return _scaleY;
        }// end function

        protected function keyDownHandler(event:KeyboardEvent) : void
        {
            return;
        }// end function

        protected function createInFontContext(param1:Class) : Object
        {
            hasFontContextBeenSaved = true;
            var _loc_2:* = StringUtil.trimArrayElements(getStyle("fontFamily"), ",");
            var _loc_3:* = getStyle("fontWeight");
            var _loc_4:* = getStyle("fontStyle");
            var _loc_5:* = _loc_3 == "bold";
            var _loc_6:* = _loc_4 == "italic";
            oldEmbeddedFontContext = getFontContext(_loc_2, _loc_5, _loc_6);
            var _loc_7:* = createInModuleContext(oldEmbeddedFontContext ? (oldEmbeddedFontContext) : (moduleFactory), getQualifiedClassName(param1));
            if (createInModuleContext(oldEmbeddedFontContext ? (oldEmbeddedFontContext) : (moduleFactory), getQualifiedClassName(param1)) == null)
            {
                _loc_7 = new param1;
            }
            return _loc_7;
        }// end function

        public function get screen() : Rectangle
        {
            var _loc_1:* = systemManager;
            return _loc_1 ? (_loc_1.screen) : (null);
        }// end function

        protected function focusInHandler(event:FocusEvent) : void
        {
            var _loc_2:IFocusManager = null;
            if (isOurFocus(DisplayObject(event.target)))
            {
                _loc_2 = focusManager;
                if (_loc_2 && _loc_2.showFocusIndicator)
                {
                    drawFocus(true);
                }
                ContainerGlobals.checkFocus(event.relatedObject, this);
            }
            return;
        }// end function

        public function hasFontContextChanged() : Boolean
        {
            if (!hasFontContextBeenSaved)
            {
                return false;
            }
            var _loc_1:* = StringUtil.trimArrayElements(getStyle("fontFamily"), ",");
            var _loc_2:* = getStyle("fontWeight");
            var _loc_3:* = getStyle("fontStyle");
            var _loc_4:* = _loc_2 == "bold";
            var _loc_5:* = _loc_3 == "italic";
            var _loc_6:* = getEmbeddedFont(_loc_1, _loc_4, _loc_5);
            var _loc_7:* = embeddedFontRegistry.getAssociatedModuleFactory(_loc_6, moduleFactory);
            return embeddedFontRegistry.getAssociatedModuleFactory(_loc_6, moduleFactory) != oldEmbeddedFontContext;
        }// end function

        public function get explicitHeight() : Number
        {
            return _explicitHeight;
        }// end function

        override public function get x() : Number
        {
            return super.x;
        }// end function

        override public function get y() : Number
        {
            return super.y;
        }// end function

        override public function get visible() : Boolean
        {
            return _visible;
        }// end function

        function addOverlay(param1:uint, param2:RoundedRectangle = null) : void
        {
            if (!overlay)
            {
                overlayColor = param1;
                overlay = new UIComponent();
                overlay.name = "overlay";
                overlay.$visible = true;
                fillOverlay(overlay, param1, param2);
                attachOverlay();
                if (!param2)
                {
                    addEventListener(ResizeEvent.RESIZE, overlay_resizeHandler);
                }
                overlay.x = 0;
                overlay.y = 0;
                invalidateDisplayList();
                overlayReferenceCount = 1;
            }
            else
            {
                overlayReferenceCount++;
            }
            dispatchEvent(new ChildExistenceChangedEvent(ChildExistenceChangedEvent.OVERLAY_CREATED, true, false, overlay));
            return;
        }// end function

        public function get percentWidth() : Number
        {
            return _percentWidth;
        }// end function

        public function set explicitMinHeight(param1:Number) : void
        {
            if (_explicitMinHeight == param1)
            {
                return;
            }
            _explicitMinHeight = param1;
            invalidateSize();
            var _loc_2:* = parent as IInvalidating;
            if (_loc_2)
            {
                _loc_2.invalidateSize();
                _loc_2.invalidateDisplayList();
            }
            dispatchEvent(new Event("explicitMinHeightChanged"));
            return;
        }// end function

        public function set automationName(param1:String) : void
        {
            _automationName = param1;
            return;
        }// end function

        public function get mouseFocusEnabled() : Boolean
        {
            return _mouseFocusEnabled;
        }// end function

        function getEmbeddedFont(param1:String, param2:Boolean, param3:Boolean) : EmbeddedFont
        {
            if (cachedEmbeddedFont)
            {
                if (cachedEmbeddedFont.fontName == param1 && cachedEmbeddedFont.fontStyle == EmbeddedFontRegistry.getFontStyle(param2, param3))
                {
                    return cachedEmbeddedFont;
                }
            }
            cachedEmbeddedFont = new EmbeddedFont(param1, param2, param3);
            return cachedEmbeddedFont;
        }// end function

        public function stylesInitialized() : void
        {
            return;
        }// end function

        public function set errorString(param1:String) : void
        {
            var _loc_2:* = _errorString;
            _errorString = param1;
            ToolTipManager.registerErrorString(this, _loc_2, param1);
            errorStringChanged = true;
            invalidateProperties();
            dispatchEvent(new Event("errorStringChanged"));
            return;
        }// end function

        public function getExplicitOrMeasuredWidth() : Number
        {
            return !isNaN(explicitWidth) ? (explicitWidth) : (measuredWidth);
        }// end function

        final function set $height(param1:Number) : void
        {
            super.height = param1;
            return;
        }// end function

        protected function keyUpHandler(event:KeyboardEvent) : void
        {
            return;
        }// end function

        final function $removeChild(param1:DisplayObject) : DisplayObject
        {
            return super.removeChild(param1);
        }// end function

        override public function set scaleX(param1:Number) : void
        {
            if (_scaleX == param1)
            {
                return;
            }
            _scaleX = param1;
            invalidateProperties();
            invalidateSize();
            dispatchEvent(new Event("scaleXChanged"));
            return;
        }// end function

        override public function set scaleY(param1:Number) : void
        {
            if (_scaleY == param1)
            {
                return;
            }
            _scaleY = param1;
            invalidateProperties();
            invalidateSize();
            dispatchEvent(new Event("scaleYChanged"));
            return;
        }// end function

        public function set uid(param1:String) : void
        {
            this._uid = param1;
            return;
        }// end function

        public function createAutomationIDPart(param1:IAutomationObject) : Object
        {
            if (automationDelegate)
            {
                return automationDelegate.createAutomationIDPart(param1);
            }
            return null;
        }// end function

        public function getAutomationChildAt(param1:int) : IAutomationObject
        {
            if (automationDelegate)
            {
                return automationDelegate.getAutomationChildAt(param1);
            }
            return null;
        }// end function

        function get isEffectStarted() : Boolean
        {
            return _isEffectStarted;
        }// end function

        override public function get parent() : DisplayObjectContainer
        {
            try
            {
                return _parent ? (_parent) : (super.parent);
            }
            catch (e:SecurityError)
            {
            }
            return null;
        }// end function

        override public function get mouseY() : Number
        {
            if (!root || root is Stage || root[fakeMouseY] === undefined)
            {
                return super.mouseY;
            }
            return globalToLocal(new Point(0, root[fakeMouseY])).y;
        }// end function

        public function setActualSize(param1:Number, param2:Number) : void
        {
            var _loc_3:Boolean = false;
            if (_width != param1)
            {
                _width = param1;
                dispatchEvent(new Event("widthChanged"));
                _loc_3 = true;
            }
            if (_height != param2)
            {
                _height = param2;
                dispatchEvent(new Event("heightChanged"));
                _loc_3 = true;
            }
            if (_loc_3)
            {
                invalidateDisplayList();
                dispatchResizeEvent();
            }
            return;
        }// end function

        private function focusObj_resizeHandler(event:ResizeEvent) : void
        {
            adjustFocusRect();
            return;
        }// end function

        function adjustSizesForScaleChanges() : void
        {
            var _loc_3:Number = NaN;
            var _loc_1:* = scaleX;
            var _loc_2:* = scaleY;
            if (_loc_1 != oldScaleX)
            {
                _loc_3 = Math.abs(_loc_1 / oldScaleX);
                if (explicitMinWidth)
                {
                    explicitMinWidth = explicitMinWidth * _loc_3;
                }
                if (!isNaN(explicitWidth))
                {
                    explicitWidth = explicitWidth * _loc_3;
                }
                if (explicitMaxWidth)
                {
                    explicitMaxWidth = explicitMaxWidth * _loc_3;
                }
                oldScaleX = _loc_1;
            }
            if (_loc_2 != oldScaleY)
            {
                _loc_3 = Math.abs(_loc_2 / oldScaleY);
                if (explicitMinHeight)
                {
                    explicitMinHeight = explicitMinHeight * _loc_3;
                }
                if (explicitHeight)
                {
                    explicitHeight = explicitHeight * _loc_3;
                }
                if (explicitMaxHeight)
                {
                    explicitMaxHeight = explicitMaxHeight * _loc_3;
                }
                oldScaleY = _loc_2;
            }
            return;
        }// end function

        public function set focusPane(param1:Sprite) : void
        {
            if (param1)
            {
                addChild(param1);
                param1.x = 0;
                param1.y = 0;
                param1.scrollRect = null;
                _focusPane = param1;
            }
            else
            {
                removeChild(_focusPane);
                _focusPane.mask = null;
                _focusPane = null;
            }
            return;
        }// end function

        public function determineTextFormatFromStyles() : UITextFormat
        {
            var _loc_2:String = null;
            var _loc_1:* = cachedTextFormat;
            if (!_loc_1)
            {
                _loc_2 = StringUtil.trimArrayElements(_inheritingStyles.fontFamily, ",");
                _loc_1 = new UITextFormat(getNonNullSystemManager(), _loc_2);
                _loc_1.moduleFactory = moduleFactory;
                _loc_1.align = _inheritingStyles.textAlign;
                _loc_1.bold = _inheritingStyles.fontWeight == "bold";
                _loc_1.color = enabled ? (_inheritingStyles.color) : (_inheritingStyles.disabledColor);
                _loc_1.font = _loc_2;
                _loc_1.indent = _inheritingStyles.textIndent;
                _loc_1.italic = _inheritingStyles.fontStyle == "italic";
                _loc_1.kerning = _inheritingStyles.kerning;
                _loc_1.leading = _nonInheritingStyles.leading;
                _loc_1.leftMargin = _nonInheritingStyles.paddingLeft;
                _loc_1.letterSpacing = _inheritingStyles.letterSpacing;
                _loc_1.rightMargin = _nonInheritingStyles.paddingRight;
                _loc_1.size = _inheritingStyles.fontSize;
                _loc_1.underline = _nonInheritingStyles.textDecoration == "underline";
                _loc_1.antiAliasType = _inheritingStyles.fontAntiAliasType;
                _loc_1.gridFitType = _inheritingStyles.fontGridFitType;
                _loc_1.sharpness = _inheritingStyles.fontSharpness;
                _loc_1.thickness = _inheritingStyles.fontThickness;
                cachedTextFormat = _loc_1;
            }
            return _loc_1;
        }// end function

        public function validationResultHandler(event:ValidationResultEvent) : void
        {
            var _loc_2:String = null;
            var _loc_3:ValidationResult = null;
            var _loc_4:int = 0;
            if (event.type == ValidationResultEvent.VALID)
            {
                if (errorString != "")
                {
                    errorString = "";
                    dispatchEvent(new FlexEvent(FlexEvent.VALID));
                }
            }
            else
            {
                if (validationSubField != null && validationSubField != "" && event.results)
                {
                    _loc_4 = 0;
                    while (_loc_4 < event.results.length)
                    {
                        
                        _loc_3 = event.results[_loc_4];
                        if (_loc_3.subField == validationSubField)
                        {
                            if (_loc_3.isError)
                            {
                                _loc_2 = _loc_3.errorMessage;
                            }
                            else if (errorString != "")
                            {
                                errorString = "";
                                dispatchEvent(new FlexEvent(FlexEvent.VALID));
                            }
                            break;
                        }
                        _loc_4++;
                    }
                }
                else if (event.results && event.results.length > 0)
                {
                    _loc_2 = event.results[0].errorMessage;
                }
                if (_loc_2 && errorString != _loc_2)
                {
                    errorString = _loc_2;
                    dispatchEvent(new FlexEvent(FlexEvent.INVALID));
                }
            }
            return;
        }// end function

        public function invalidateProperties() : void
        {
            if (!invalidatePropertiesFlag)
            {
                invalidatePropertiesFlag = true;
                if (parent && UIComponentGlobals.layoutManager)
                {
                    UIComponentGlobals.layoutManager.invalidateProperties(this);
                }
            }
            return;
        }// end function

        public function get inheritingStyles() : Object
        {
            return _inheritingStyles;
        }// end function

        private function focusObj_scrollHandler(event:Event) : void
        {
            adjustFocusRect();
            return;
        }// end function

        final function get $x() : Number
        {
            return super.x;
        }// end function

        final function get $y() : Number
        {
            return super.y;
        }// end function

        public function setConstraintValue(param1:String, param2) : void
        {
            setStyle(param1, param2);
            return;
        }// end function

        protected function resourcesChanged() : void
        {
            return;
        }// end function

        public function registerEffects(param1:Array) : void
        {
            var _loc_4:String = null;
            var _loc_2:* = param1.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = EffectManager.getEventForEffectTrigger(param1[_loc_3]);
                if (_loc_4 != null && _loc_4 != "")
                {
                    addEventListener(_loc_4, EffectManager.eventHandler, false, EventPriority.EFFECT);
                }
                _loc_3++;
            }
            return;
        }// end function

        public function get explicitMinWidth() : Number
        {
            return _explicitMinWidth;
        }// end function

        private function filterChangeHandler(event:Event) : void
        {
            super.filters = _filters;
            return;
        }// end function

        override public function set visible(param1:Boolean) : void
        {
            setVisible(param1);
            return;
        }// end function

        public function set explicitHeight(param1:Number) : void
        {
            if (_explicitHeight == param1)
            {
                return;
            }
            if (!isNaN(param1))
            {
                _percentHeight = NaN;
            }
            _explicitHeight = param1;
            invalidateSize();
            var _loc_2:* = parent as IInvalidating;
            if (_loc_2 && includeInLayout)
            {
                _loc_2.invalidateSize();
                _loc_2.invalidateDisplayList();
            }
            dispatchEvent(new Event("explicitHeightChanged"));
            return;
        }// end function

        override public function set x(param1:Number) : void
        {
            if (super.x == param1)
            {
                return;
            }
            super.x = param1;
            invalidateProperties();
            dispatchEvent(new Event("xChanged"));
            return;
        }// end function

        public function set showInAutomationHierarchy(param1:Boolean) : void
        {
            _showInAutomationHierarchy = param1;
            return;
        }// end function

        override public function set y(param1:Number) : void
        {
            if (super.y == param1)
            {
                return;
            }
            super.y = param1;
            invalidateProperties();
            dispatchEvent(new Event("yChanged"));
            return;
        }// end function

        private function resourceManager_changeHandler(event:Event) : void
        {
            resourcesChanged();
            return;
        }// end function

        public function set systemManager(param1:ISystemManager) : void
        {
            _systemManager = param1;
            _systemManagerDirty = false;
            return;
        }// end function

        function getFocusObject() : DisplayObject
        {
            var _loc_1:* = focusManager;
            if (!_loc_1 || !_loc_1.focusPane)
            {
                return null;
            }
            return _loc_1.focusPane.numChildren == 0 ? (null) : (_loc_1.focusPane.getChildAt(0));
        }// end function

        public function set percentWidth(param1:Number) : void
        {
            if (_percentWidth == param1)
            {
                return;
            }
            if (!isNaN(param1))
            {
                _explicitWidth = NaN;
            }
            _percentWidth = param1;
            var _loc_2:* = parent as IInvalidating;
            if (_loc_2)
            {
                _loc_2.invalidateSize();
                _loc_2.invalidateDisplayList();
            }
            return;
        }// end function

        public function get moduleFactory() : IFlexModuleFactory
        {
            return _moduleFactory;
        }// end function

        override public function addChild(param1:DisplayObject) : DisplayObject
        {
            var _loc_2:* = param1.parent;
            if (_loc_2 && !(_loc_2 is Loader))
            {
                _loc_2.removeChild(param1);
            }
            if (overlayReferenceCount)
            {
            }
            var _loc_3:* = param1 != overlay ? (Math.max(0, super.numChildren--)) : (super.numChildren);
            addingChild(param1);
            $addChildAt(param1, _loc_3);
            childAdded(param1);
            return param1;
        }// end function

        public function get document() : Object
        {
            return _document;
        }// end function

        public function set mouseFocusEnabled(param1:Boolean) : void
        {
            _mouseFocusEnabled = param1;
            return;
        }// end function

        final function $addChild(param1:DisplayObject) : DisplayObject
        {
            return super.addChild(param1);
        }// end function

        function setThemeColor(param1:Object) : void
        {
            var _loc_2:Number = NaN;
            if (_loc_2 is String)
            {
                _loc_2 = parseInt(String(param1));
            }
            else
            {
                _loc_2 = Number(param1);
            }
            if (isNaN(_loc_2))
            {
                _loc_2 = StyleManager.getColorName(param1);
            }
            var _loc_3:* = ColorUtil.adjustBrightness2(_loc_2, 50);
            var _loc_4:* = ColorUtil.adjustBrightness2(_loc_2, 70);
            setStyle("selectionColor", _loc_3);
            setStyle("rollOverColor", _loc_4);
            return;
        }// end function

        public function get explicitMaxWidth() : Number
        {
            return _explicitMaxWidth;
        }// end function

        public function get id() : String
        {
            return _id;
        }// end function

        override public function get height() : Number
        {
            return _height;
        }// end function

        public function set minWidth(param1:Number) : void
        {
            if (explicitMinWidth == param1)
            {
                return;
            }
            explicitMinWidth = param1;
            return;
        }// end function

        public function set currentState(param1:String) : void
        {
            setCurrentState(param1, true);
            return;
        }// end function

        public function getRepeaterItem(param1:int = -1) : Object
        {
            var _loc_2:* = repeaters;
            if (param1 == -1)
            {
            }
            return _loc_2[_loc_2.length--].getItemAt(repeaterIndices[_loc_1]);
        }// end function

        public function executeBindings(param1:Boolean = false) : void
        {
            if (descriptor)
            {
            }
            var _loc_2:* = descriptor.document ? (descriptor.document) : (parentDocument);
            BindingManager.executeBindings(_loc_2, id, this);
            return;
        }// end function

        public function replayAutomatableEvent(event:Event) : Boolean
        {
            if (automationDelegate)
            {
                return automationDelegate.replayAutomatableEvent(event);
            }
            return false;
        }// end function

        function getFontContext(param1:String, param2:Boolean, param3:Boolean) : IFlexModuleFactory
        {
            return embeddedFontRegistry.getAssociatedModuleFactory(getEmbeddedFont(param1, param2, param3), moduleFactory);
        }// end function

        public function get instanceIndex() : int
        {
            return _instanceIndices ? (_instanceIndices[_instanceIndices.length--]) : (-1);
        }// end function

        public function set measuredWidth(param1:Number) : void
        {
            _measuredWidth = param1;
            return;
        }// end function

        public function effectFinished(param1:IEffectInstance) : void
        {
            _endingEffectInstances.push(param1);
            invalidateProperties();
            UIComponentGlobals.layoutManager.addEventListener(FlexEvent.UPDATE_COMPLETE, updateCompleteHandler, false, 0, true);
            return;
        }// end function

        function set isEffectStarted(param1:Boolean) : void
        {
            _isEffectStarted = param1;
            return;
        }// end function

        function fillOverlay(param1:UIComponent, param2:uint, param3:RoundedRectangle = null) : void
        {
            if (!param3)
            {
                param3 = new RoundedRectangle(0, 0, unscaledWidth, unscaledHeight, 0);
            }
            var _loc_4:* = param1.graphics;
            param1.graphics.clear();
            _loc_4.beginFill(param2);
            _loc_4.drawRoundRect(param3.x, param3.y, param3.width, param3.height, param3.cornerRadius * 2, param3.cornerRadius * 2);
            _loc_4.endFill();
            return;
        }// end function

        public function get instanceIndices() : Array
        {
            return _instanceIndices ? (_instanceIndices.slice(0)) : (null);
        }// end function

        function childAdded(param1:DisplayObject) : void
        {
            if (param1 is UIComponent)
            {
                if (!UIComponent(param1).initialized)
                {
                    UIComponent(param1).initialize();
                }
            }
            else if (param1 is IUIComponent)
            {
                IUIComponent(param1).initialize();
            }
            return;
        }// end function

        public function globalToContent(param1:Point) : Point
        {
            return globalToLocal(param1);
        }// end function

        function removingChild(param1:DisplayObject) : void
        {
            return;
        }// end function

        function getEffectsForProperty(param1:String) : Array
        {
            return _affectedProperties[param1] != undefined ? (_affectedProperties[param1]) : ([]);
        }// end function

        override public function removeChildAt(param1:int) : DisplayObject
        {
            var _loc_2:* = getChildAt(param1);
            removingChild(_loc_2);
            $removeChild(_loc_2);
            childRemoved(_loc_2);
            return _loc_2;
        }// end function

        protected function measure() : void
        {
            measuredMinWidth = 0;
            measuredMinHeight = 0;
            measuredWidth = 0;
            measuredHeight = 0;
            return;
        }// end function

        public function set owner(param1:DisplayObjectContainer) : void
        {
            _owner = param1;
            return;
        }// end function

        function getNonNullSystemManager() : ISystemManager
        {
            var _loc_1:* = systemManager;
            if (!_loc_1)
            {
                _loc_1 = ISystemManager(SystemManager.getSWFRoot(this));
            }
            if (!_loc_1)
            {
                return SystemManagerGlobals.topLevelSystemManagers[0];
            }
            return _loc_1;
        }// end function

        protected function get unscaledWidth() : Number
        {
            return width / Math.abs(scaleX);
        }// end function

        public function set processedDescriptors(param1:Boolean) : void
        {
            _processedDescriptors = param1;
            if (param1)
            {
                dispatchEvent(new FlexEvent(FlexEvent.INITIALIZE));
            }
            return;
        }// end function

        private function processEffectFinished(param1:Array) : void
        {
            var _loc_3:int = 0;
            var _loc_4:IEffectInstance = null;
            var _loc_5:IEffectInstance = null;
            var _loc_6:Array = null;
            var _loc_7:int = 0;
            var _loc_8:String = null;
            var _loc_9:int = 0;
            while (_loc_2-- >= 0)
            {
                
                _loc_3 = 0;
                while (_loc_3 < param1.length)
                {
                    
                    _loc_4 = param1[_loc_3];
                    if (_loc_4 == _effectsStarted[_effectsStarted.length--])
                    {
                        _loc_5 = _effectsStarted[_loc_2];
                        _effectsStarted.splice(_loc_2, 1);
                        _loc_6 = _loc_5.effect.getAffectedProperties();
                        _loc_7 = 0;
                        while (_loc_7 < _loc_6.length)
                        {
                            
                            _loc_8 = _loc_6[_loc_7];
                            if (_affectedProperties[_loc_8] != undefined)
                            {
                                _loc_9 = 0;
                                while (_loc_9 < _affectedProperties[_loc_8].length)
                                {
                                    
                                    if (_affectedProperties[_loc_8][_loc_9] == _loc_4)
                                    {
                                        _affectedProperties[_loc_8].splice(_loc_9, 1);
                                        break;
                                    }
                                    _loc_9++;
                                }
                                if (_affectedProperties[_loc_8].length == 0)
                                {
                                    delete _affectedProperties[_loc_8];
                                }
                            }
                            _loc_7++;
                        }
                        break;
                    }
                    _loc_3++;
                }
            }
            isEffectStarted = _effectsStarted.length > 0 ? (true) : (false);
            if (_loc_4 && _loc_4.hideFocusRing)
            {
                preventDrawFocus = false;
            }
            return;
        }// end function

        private function commitCurrentState() : void
        {
            var _loc_3:StateChangeEvent = null;
            var _loc_1:* = playStateTransition ? (getTransition(_currentState, requestedCurrentState)) : (null);
            var _loc_2:* = findCommonBaseState(_currentState, requestedCurrentState);
            var _loc_4:* = _currentState ? (_currentState) : ("");
            var _loc_5:* = getState(requestedCurrentState);
            if (_currentTransitionEffect)
            {
                _currentTransitionEffect.end();
            }
            initializeState(requestedCurrentState);
            if (_loc_1)
            {
                _loc_1.captureStartValues();
            }
            _loc_3 = new StateChangeEvent(StateChangeEvent.CURRENT_STATE_CHANGING);
            _loc_3.oldState = _loc_4;
            _loc_3.newState = requestedCurrentState ? (requestedCurrentState) : ("");
            dispatchEvent(_loc_3);
            if (isBaseState(_currentState))
            {
                dispatchEvent(new FlexEvent(FlexEvent.EXIT_STATE));
            }
            removeState(_currentState, _loc_2);
            _currentState = requestedCurrentState;
            if (isBaseState(currentState))
            {
                dispatchEvent(new FlexEvent(FlexEvent.ENTER_STATE));
            }
            else
            {
                applyState(_currentState, _loc_2);
            }
            _loc_3 = new StateChangeEvent(StateChangeEvent.CURRENT_STATE_CHANGE);
            _loc_3.oldState = _loc_4;
            _loc_3.newState = _currentState ? (_currentState) : ("");
            dispatchEvent(_loc_3);
            if (_loc_1)
            {
                UIComponentGlobals.layoutManager.validateNow();
                _currentTransitionEffect = _loc_1;
                _loc_1.addEventListener(EffectEvent.EFFECT_END, transition_effectEndHandler);
                _loc_1.play();
            }
            return;
        }// end function

        public function get includeInLayout() : Boolean
        {
            return _includeInLayout;
        }// end function

        private function dispatchResizeEvent() : void
        {
            var _loc_1:* = new ResizeEvent(ResizeEvent.RESIZE);
            _loc_1.oldWidth = oldWidth;
            _loc_1.oldHeight = oldHeight;
            dispatchEvent(_loc_1);
            oldWidth = width;
            oldHeight = height;
            return;
        }// end function

        public function set maxWidth(param1:Number) : void
        {
            if (explicitMaxWidth == param1)
            {
                return;
            }
            explicitMaxWidth = param1;
            return;
        }// end function

        public function validateDisplayList() : void
        {
            var _loc_1:ISystemManager = null;
            var _loc_2:Number = NaN;
            var _loc_3:Number = NaN;
            if (invalidateDisplayListFlag)
            {
                _loc_1 = parent as ISystemManager;
                if (_loc_1)
                {
                    if (_loc_1 is SystemManagerProxy || _loc_1 == systemManager.topLevelSystemManager && _loc_1.document != this)
                    {
                        setActualSize(getExplicitOrMeasuredWidth(), getExplicitOrMeasuredHeight());
                    }
                }
                _loc_2 = scaleX == 0 ? (0) : (width / scaleX);
                _loc_3 = scaleY == 0 ? (0) : (height / scaleY);
                if (Math.abs(_loc_2 - lastUnscaledWidth) < 1e-005)
                {
                    _loc_2 = lastUnscaledWidth;
                }
                if (Math.abs(_loc_3 - lastUnscaledHeight) < 1e-005)
                {
                    _loc_3 = lastUnscaledHeight;
                }
                updateDisplayList(_loc_2, _loc_3);
                lastUnscaledWidth = _loc_2;
                lastUnscaledHeight = _loc_3;
                invalidateDisplayListFlag = false;
            }
            return;
        }// end function

        public function contentToGlobal(param1:Point) : Point
        {
            return localToGlobal(param1);
        }// end function

        public function resolveAutomationIDPart(param1:Object) : Array
        {
            if (automationDelegate)
            {
                return automationDelegate.resolveAutomationIDPart(param1);
            }
            return [];
        }// end function

        public function set inheritingStyles(param1:Object) : void
        {
            _inheritingStyles = param1;
            return;
        }// end function

        public function setFocus() : void
        {
            var _loc_1:* = systemManager;
            if (_loc_1 && _loc_1.stage || _loc_1.useSWFBridge())
            {
                if (UIComponentGlobals.callLaterDispatcherCount == 0)
                {
                    _loc_1.stage.focus = this;
                    UIComponentGlobals.nextFocusObject = null;
                }
                else
                {
                    UIComponentGlobals.nextFocusObject = this;
                    _loc_1.addEventListener(FlexEvent.ENTER_FRAME, setFocusLater);
                }
            }
            else
            {
                UIComponentGlobals.nextFocusObject = this;
                callLater(setFocusLater);
            }
            return;
        }// end function

        private function getTransition(param1:String, param2:String) : IEffect
        {
            var _loc_6:Transition = null;
            var _loc_3:IEffect = null;
            var _loc_4:int = 0;
            if (!transitions)
            {
                return null;
            }
            if (!param1)
            {
                param1 = "";
            }
            if (!param2)
            {
                param2 = "";
            }
            var _loc_5:int = 0;
            while (_loc_5 < transitions.length)
            {
                
                _loc_6 = transitions[_loc_5];
                if (_loc_6.fromState == "*" && _loc_6.toState == "*" && _loc_4 < 1)
                {
                    _loc_3 = _loc_6.effect;
                    _loc_4 = 1;
                }
                else if (_loc_6.fromState == param1 && _loc_6.toState == "*" && _loc_4 < 2)
                {
                    _loc_3 = _loc_6.effect;
                    _loc_4 = 2;
                }
                else if (_loc_6.fromState == "*" && _loc_6.toState == param2 && _loc_4 < 3)
                {
                    _loc_3 = _loc_6.effect;
                    _loc_4 = 3;
                }
                else if (_loc_6.fromState == param1 && _loc_6.toState == param2 && _loc_4 < 4)
                {
                    _loc_3 = _loc_6.effect;
                    _loc_4 = 4;
                    break;
                }
                _loc_5++;
            }
            return _loc_3;
        }// end function

        public function set initialized(param1:Boolean) : void
        {
            _initialized = param1;
            if (param1)
            {
                setVisible(_visible, true);
                dispatchEvent(new FlexEvent(FlexEvent.CREATION_COMPLETE));
            }
            return;
        }// end function

        final function set $y(param1:Number) : void
        {
            super.y = param1;
            return;
        }// end function

        public function owns(param1:DisplayObject) : Boolean
        {
            var child:* = param1;
            var childList:* = this is IRawChildrenContainer ? (IRawChildrenContainer(this).rawChildren) : (IChildList(this));
            if (childList.contains(child))
            {
                return true;
            }
            try
            {
                while (child && child != this)
                {
                    
                    if (child is IUIComponent)
                    {
                        child = IUIComponent(child).owner;
                        continue;
                    }
                    child = child.parent;
                }
            }
            catch (e:SecurityError)
            {
                return false;
            }
            return child == this;
        }// end function

        public function setVisible(param1:Boolean, param2:Boolean = false) : void
        {
            _visible = param1;
            if (!initialized)
            {
                return;
            }
            if ($visible == param1)
            {
                return;
            }
            $visible = param1;
            if (!param2)
            {
                dispatchEvent(new FlexEvent(param1 ? (FlexEvent.SHOW) : (FlexEvent.HIDE)));
            }
            return;
        }// end function

        final function $addChildAt(param1:DisplayObject, param2:int) : DisplayObject
        {
            return super.addChildAt(param1, param2);
        }// end function

        public function deleteReferenceOnParentDocument(param1:IFlexDisplayObject) : void
        {
            var _loc_2:Array = null;
            var _loc_3:Object = null;
            var _loc_4:Array = null;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:Object = null;
            var _loc_9:PropertyChangeEvent = null;
            if (id && id != "")
            {
                _loc_2 = _instanceIndices;
                if (!_loc_2)
                {
                    param1[id] = null;
                }
                else
                {
                    _loc_3 = param1[id];
                    if (!_loc_3)
                    {
                        return;
                    }
                    _loc_4 = [];
                    _loc_4.push(_loc_3);
                    _loc_5 = _loc_2.length;
                    _loc_6 = 0;
                    while (_loc_6 < _loc_5--)
                    {
                        
                        _loc_8 = _loc_3[_loc_2[_loc_6]];
                        if (!_loc_8)
                        {
                            return;
                        }
                        _loc_3 = _loc_8;
                        _loc_4.push(_loc_3);
                        _loc_6++;
                    }
                    _loc_3.splice(_loc_2[_loc_5--], 1);
                    while (_loc_7-- > 0)
                    {
                        
                        if (_loc_4[_loc_4.length--].length == 0)
                        {
                            _loc_4[_loc_7--].splice(_loc_2[_loc_7], 1);
                        }
                    }
                    if (_loc_4.length > 0 && _loc_4[0].length == 0)
                    {
                        param1[id] = null;
                    }
                    else
                    {
                        _loc_9 = PropertyChangeEvent.createUpdateEvent(param1, id, param1[id], param1[id]);
                        param1.dispatchEvent(_loc_9);
                    }
                }
            }
            return;
        }// end function

        public function get nonInheritingStyles() : Object
        {
            return _nonInheritingStyles;
        }// end function

        public function effectStarted(param1:IEffectInstance) : void
        {
            var _loc_4:String = null;
            _effectsStarted.push(param1);
            var _loc_2:* = param1.effect.getAffectedProperties();
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_4 = _loc_2[_loc_3];
                if (_affectedProperties[_loc_4] == undefined)
                {
                    _affectedProperties[_loc_4] = [];
                }
                _affectedProperties[_loc_4].push(param1);
                _loc_3++;
            }
            isEffectStarted = true;
            if (param1.hideFocusRing)
            {
                preventDrawFocus = true;
                drawFocus(false);
            }
            return;
        }// end function

        final function set $x(param1:Number) : void
        {
            super.x = param1;
            return;
        }// end function

        private function applyState(param1:String, param2:String) : void
        {
            var _loc_4:Array = null;
            var _loc_5:int = 0;
            var _loc_3:* = getState(param1);
            if (param1 == param2)
            {
                return;
            }
            if (_loc_3)
            {
                if (_loc_3.basedOn != param2)
                {
                    applyState(_loc_3.basedOn, param2);
                }
                _loc_4 = _loc_3.overrides;
                _loc_5 = 0;
                while (_loc_5 < _loc_4.length)
                {
                    
                    _loc_4[_loc_5].apply(this);
                    _loc_5++;
                }
                _loc_3.dispatchEnterState();
            }
            return;
        }// end function

        protected function commitProperties() : void
        {
            var _loc_1:Number = NaN;
            var _loc_2:Number = NaN;
            if (_scaleX != oldScaleX)
            {
                _loc_1 = Math.abs(_scaleX / oldScaleX);
                if (!isNaN(explicitMinWidth))
                {
                    explicitMinWidth = explicitMinWidth * _loc_1;
                }
                if (!isNaN(explicitWidth))
                {
                    explicitWidth = explicitWidth * _loc_1;
                }
                if (!isNaN(explicitMaxWidth))
                {
                    explicitMaxWidth = explicitMaxWidth * _loc_1;
                }
                _width = _width * _loc_1;
                var _loc_3:* = _scaleX;
                oldScaleX = _scaleX;
                super.scaleX = _loc_3;
            }
            if (_scaleY != oldScaleY)
            {
                _loc_2 = Math.abs(_scaleY / oldScaleY);
                if (!isNaN(explicitMinHeight))
                {
                    explicitMinHeight = explicitMinHeight * _loc_2;
                }
                if (!isNaN(explicitHeight))
                {
                    explicitHeight = explicitHeight * _loc_2;
                }
                if (!isNaN(explicitMaxHeight))
                {
                    explicitMaxHeight = explicitMaxHeight * _loc_2;
                }
                _height = _height * _loc_2;
                var _loc_3:* = _scaleY;
                oldScaleY = _scaleY;
                super.scaleY = _loc_3;
            }
            if (x != oldX || y != oldY)
            {
                dispatchMoveEvent();
            }
            if (width != oldWidth || height != oldHeight)
            {
                dispatchResizeEvent();
            }
            if (errorStringChanged)
            {
                errorStringChanged = false;
                setBorderColorForErrorString();
            }
            return;
        }// end function

        public function get percentHeight() : Number
        {
            return _percentHeight;
        }// end function

        override public function get width() : Number
        {
            return _width;
        }// end function

        final function get $parent() : DisplayObjectContainer
        {
            return super.parent;
        }// end function

        public function set explicitMinWidth(param1:Number) : void
        {
            if (_explicitMinWidth == param1)
            {
                return;
            }
            _explicitMinWidth = param1;
            invalidateSize();
            var _loc_2:* = parent as IInvalidating;
            if (_loc_2)
            {
                _loc_2.invalidateSize();
                _loc_2.invalidateDisplayList();
            }
            dispatchEvent(new Event("explicitMinWidthChanged"));
            return;
        }// end function

        public function get isPopUp() : Boolean
        {
            return _isPopUp;
        }// end function

        private function measureSizes() : Boolean
        {
            var _loc_2:Number = NaN;
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_1:Boolean = false;
            if (!invalidateSizeFlag)
            {
                return _loc_1;
            }
            if (isNaN(explicitWidth) || isNaN(explicitHeight))
            {
                _loc_4 = Math.abs(scaleX);
                _loc_5 = Math.abs(scaleY);
                if (_loc_4 != 1)
                {
                    _measuredMinWidth = _measuredMinWidth / _loc_4;
                    _measuredWidth = _measuredWidth / _loc_4;
                }
                if (_loc_5 != 1)
                {
                    _measuredMinHeight = _measuredMinHeight / _loc_5;
                    _measuredHeight = _measuredHeight / _loc_5;
                }
                measure();
                invalidateSizeFlag = false;
                if (!isNaN(explicitMinWidth) && measuredWidth < explicitMinWidth)
                {
                    measuredWidth = explicitMinWidth;
                }
                if (!isNaN(explicitMaxWidth) && measuredWidth > explicitMaxWidth)
                {
                    measuredWidth = explicitMaxWidth;
                }
                if (!isNaN(explicitMinHeight) && measuredHeight < explicitMinHeight)
                {
                    measuredHeight = explicitMinHeight;
                }
                if (!isNaN(explicitMaxHeight) && measuredHeight > explicitMaxHeight)
                {
                    measuredHeight = explicitMaxHeight;
                }
                if (_loc_4 != 1)
                {
                    _measuredMinWidth = _measuredMinWidth * _loc_4;
                    _measuredWidth = _measuredWidth * _loc_4;
                }
                if (_loc_5 != 1)
                {
                    _measuredMinHeight = _measuredMinHeight * _loc_5;
                    _measuredHeight = _measuredHeight * _loc_5;
                }
            }
            else
            {
                invalidateSizeFlag = false;
                _measuredMinWidth = 0;
                _measuredMinHeight = 0;
            }
            adjustSizesForScaleChanges();
            if (isNaN(oldMinWidth))
            {
                oldMinWidth = !isNaN(explicitMinWidth) ? (explicitMinWidth) : (measuredMinWidth);
                oldMinHeight = !isNaN(explicitMinHeight) ? (explicitMinHeight) : (measuredMinHeight);
                oldExplicitWidth = !isNaN(explicitWidth) ? (explicitWidth) : (measuredWidth);
                oldExplicitHeight = !isNaN(explicitHeight) ? (explicitHeight) : (measuredHeight);
                _loc_1 = true;
            }
            else
            {
                _loc_3 = !isNaN(explicitMinWidth) ? (explicitMinWidth) : (measuredMinWidth);
                if (_loc_3 != oldMinWidth)
                {
                    oldMinWidth = _loc_3;
                    _loc_1 = true;
                }
                _loc_3 = !isNaN(explicitMinHeight) ? (explicitMinHeight) : (measuredMinHeight);
                if (_loc_3 != oldMinHeight)
                {
                    oldMinHeight = _loc_3;
                    _loc_1 = true;
                }
                _loc_3 = !isNaN(explicitWidth) ? (explicitWidth) : (measuredWidth);
                if (_loc_3 != oldExplicitWidth)
                {
                    oldExplicitWidth = _loc_3;
                    _loc_1 = true;
                }
                _loc_3 = !isNaN(explicitHeight) ? (explicitHeight) : (measuredHeight);
                if (_loc_3 != oldExplicitHeight)
                {
                    oldExplicitHeight = _loc_3;
                    _loc_1 = true;
                }
            }
            return _loc_1;
        }// end function

        public function get automationTabularData() : Object
        {
            if (automationDelegate)
            {
                return automationDelegate.automationTabularData;
            }
            return null;
        }// end function

        public function validateNow() : void
        {
            UIComponentGlobals.layoutManager.validateClient(this);
            return;
        }// end function

        public function finishPrint(param1:Object, param2:IFlexDisplayObject) : void
        {
            return;
        }// end function

        public function get repeaters() : Array
        {
            return _repeaters ? (_repeaters.slice(0)) : ([]);
        }// end function

        private function dispatchMoveEvent() : void
        {
            var _loc_1:* = new MoveEvent(MoveEvent.MOVE);
            _loc_1.oldX = oldX;
            _loc_1.oldY = oldY;
            dispatchEvent(_loc_1);
            oldX = x;
            oldY = y;
            return;
        }// end function

        public function drawFocus(param1:Boolean) : void
        {
            var _loc_4:DisplayObjectContainer = null;
            var _loc_5:Class = null;
            if (!parent)
            {
                return;
            }
            var _loc_2:* = getFocusObject();
            var _loc_3:* = focusManager ? (focusManager.focusPane) : (null);
            if (param1 && !preventDrawFocus)
            {
                _loc_4 = _loc_3.parent;
                if (_loc_4 != parent)
                {
                    if (_loc_4)
                    {
                        if (_loc_4 is ISystemManager)
                        {
                            ISystemManager(_loc_4).focusPane = null;
                        }
                        else
                        {
                            IUIComponent(_loc_4).focusPane = null;
                        }
                    }
                    if (parent is ISystemManager)
                    {
                        ISystemManager(parent).focusPane = _loc_3;
                    }
                    else
                    {
                        IUIComponent(parent).focusPane = _loc_3;
                    }
                }
                _loc_5 = getStyle("focusSkin");
                if (_loc_2 && !(_loc_2 is _loc_5))
                {
                    _loc_3.removeChild(_loc_2);
                    _loc_2 = null;
                }
                if (!_loc_2)
                {
                    _loc_2 = new _loc_5;
                    _loc_2.name = "focus";
                    _loc_3.addChild(_loc_2);
                }
                if (_loc_2 is ILayoutManagerClient)
                {
                    ILayoutManagerClient(_loc_2).nestLevel = nestLevel;
                }
                if (_loc_2 is ISimpleStyleClient)
                {
                    ISimpleStyleClient(_loc_2).styleName = this;
                }
                addEventListener(MoveEvent.MOVE, focusObj_moveHandler, true);
                addEventListener(MoveEvent.MOVE, focusObj_moveHandler);
                addEventListener(ResizeEvent.RESIZE, focusObj_resizeHandler, true);
                addEventListener(ResizeEvent.RESIZE, focusObj_resizeHandler);
                addEventListener(Event.REMOVED, focusObj_removedHandler, true);
                _loc_2.visible = true;
                hasFocusRect = true;
                adjustFocusRect();
            }
            else if (hasFocusRect)
            {
                hasFocusRect = false;
                if (_loc_2)
                {
                    _loc_2.visible = false;
                }
                removeEventListener(MoveEvent.MOVE, focusObj_moveHandler);
                removeEventListener(MoveEvent.MOVE, focusObj_moveHandler, true);
                removeEventListener(ResizeEvent.RESIZE, focusObj_resizeHandler, true);
                removeEventListener(ResizeEvent.RESIZE, focusObj_resizeHandler);
                removeEventListener(Event.REMOVED, focusObj_removedHandler, true);
            }
            return;
        }// end function

        public function get flexContextMenu() : IFlexContextMenu
        {
            return _flexContextMenu;
        }// end function

        private function get indexedID() : String
        {
            var _loc_1:* = id;
            var _loc_2:* = instanceIndices;
            if (_loc_2)
            {
                _loc_1 = _loc_1 + ("[" + _loc_2.join("][") + "]");
            }
            return _loc_1;
        }// end function

        public function get measuredMinHeight() : Number
        {
            return _measuredMinHeight;
        }// end function

        function addingChild(param1:DisplayObject) : void
        {
            if (param1 is IUIComponent && !IUIComponent(param1).document)
            {
                IUIComponent(param1).document = document ? (document) : (ApplicationGlobals.application);
            }
            if (param1 is UIComponent && UIComponent(param1).moduleFactory == null)
            {
                if (moduleFactory != null)
                {
                    UIComponent(param1).moduleFactory = moduleFactory;
                }
                else if (document is IFlexModule && document.moduleFactory != null)
                {
                    UIComponent(param1).moduleFactory = document.moduleFactory;
                }
                else if (parent is UIComponent && UIComponent(parent).moduleFactory != null)
                {
                    UIComponent(param1).moduleFactory = UIComponent(parent).moduleFactory;
                }
            }
            if (param1 is IFontContextComponent && !param1 is UIComponent && IFontContextComponent(param1).fontContext == null)
            {
                IFontContextComponent(param1).fontContext = moduleFactory;
            }
            if (param1 is IUIComponent)
            {
                IUIComponent(param1).parentChanged(this);
            }
            if (param1 is ILayoutManagerClient)
            {
                ILayoutManagerClient(param1).nestLevel = nestLevel + 1;
            }
            else if (param1 is IUITextField)
            {
                IUITextField(param1).mx.core:IUITextField::nestLevel = nestLevel + 1;
            }
            if (param1 is InteractiveObject)
            {
                if (doubleClickEnabled)
                {
                    InteractiveObject(param1).doubleClickEnabled = true;
                }
            }
            if (param1 is IStyleClient)
            {
                IStyleClient(param1).regenerateStyleCache(true);
            }
            else if (param1 is IUITextField && IUITextField(param1).inheritingStyles)
            {
                StyleProtoChain.initTextField(IUITextField(param1));
            }
            if (param1 is ISimpleStyleClient)
            {
                ISimpleStyleClient(param1).styleChanged(null);
            }
            if (param1 is IStyleClient)
            {
                IStyleClient(param1).notifyStyleChangeInChildren(null, true);
            }
            if (param1 is UIComponent)
            {
                UIComponent(param1).initThemeColor();
            }
            if (param1 is UIComponent)
            {
                UIComponent(param1).stylesInitialized();
            }
            return;
        }// end function

        public function set repeaterIndices(param1:Array) : void
        {
            _repeaterIndices = param1;
            return;
        }// end function

        protected function initializationComplete() : void
        {
            processedDescriptors = true;
            return;
        }// end function

        public function set moduleFactory(param1:IFlexModuleFactory) : void
        {
            var _loc_4:UIComponent = null;
            var _loc_2:* = numChildren;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = getChildAt(_loc_3) as UIComponent;
                if (!_loc_4)
                {
                }
                else if (_loc_4.moduleFactory == null || _loc_4.moduleFactory == _moduleFactory)
                {
                    _loc_4.moduleFactory = param1;
                }
                _loc_3++;
            }
            _moduleFactory = param1;
            return;
        }// end function

        private function focusObj_removedHandler(event:Event) : void
        {
            if (event.target != this)
            {
                return;
            }
            var _loc_2:* = getFocusObject();
            if (_loc_2)
            {
                _loc_2.visible = false;
            }
            return;
        }// end function

        function updateCallbacks() : void
        {
            if (invalidateDisplayListFlag)
            {
                UIComponentGlobals.layoutManager.invalidateDisplayList(this);
            }
            if (invalidateSizeFlag)
            {
                UIComponentGlobals.layoutManager.invalidateSize(this);
            }
            if (invalidatePropertiesFlag)
            {
                UIComponentGlobals.layoutManager.invalidateProperties(this);
            }
            if (systemManager && _systemManager.stage || _systemManager.useSWFBridge())
            {
                if (methodQueue.length > 0 && !listeningForRender)
                {
                    _systemManager.addEventListener(FlexEvent.RENDER, callLaterDispatcher);
                    _systemManager.addEventListener(FlexEvent.ENTER_FRAME, callLaterDispatcher);
                    listeningForRender = true;
                }
                if (_systemManager.stage)
                {
                    _systemManager.stage.invalidate();
                }
            }
            return;
        }// end function

        public function set styleDeclaration(param1:CSSStyleDeclaration) : void
        {
            _styleDeclaration = param1;
            return;
        }// end function

        override public function set doubleClickEnabled(param1:Boolean) : void
        {
            var _loc_2:IChildList = null;
            var _loc_4:InteractiveObject = null;
            super.doubleClickEnabled = param1;
            if (this is IRawChildrenContainer)
            {
                _loc_2 = IRawChildrenContainer(this).rawChildren;
            }
            else
            {
                _loc_2 = IChildList(this);
            }
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.numChildren)
            {
                
                _loc_4 = _loc_2.getChildAt(_loc_3) as InteractiveObject;
                if (_loc_4)
                {
                    _loc_4.doubleClickEnabled = param1;
                }
                _loc_3++;
            }
            return;
        }// end function

        public function prepareToPrint(param1:IFlexDisplayObject) : Object
        {
            return null;
        }// end function

        public function get minHeight() : Number
        {
            if (!isNaN(explicitMinHeight))
            {
                return explicitMinHeight;
            }
            return measuredMinHeight;
        }// end function

        public function notifyStyleChangeInChildren(param1:String, param2:Boolean) : void
        {
            var _loc_5:ISimpleStyleClient = null;
            cachedTextFormat = null;
            var _loc_3:* = numChildren;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = getChildAt(_loc_4) as ISimpleStyleClient;
                if (_loc_5)
                {
                    _loc_5.styleChanged(param1);
                    if (_loc_5 is IStyleClient)
                    {
                        IStyleClient(_loc_5).notifyStyleChangeInChildren(param1, param2);
                    }
                }
                _loc_4++;
            }
            return;
        }// end function

        public function get contentMouseX() : Number
        {
            return mouseX;
        }// end function

        public function get contentMouseY() : Number
        {
            return mouseY;
        }// end function

        public function get tweeningProperties() : Array
        {
            return _tweeningProperties;
        }// end function

        public function set explicitMaxWidth(param1:Number) : void
        {
            if (_explicitMaxWidth == param1)
            {
                return;
            }
            _explicitMaxWidth = param1;
            invalidateSize();
            var _loc_2:* = parent as IInvalidating;
            if (_loc_2)
            {
                _loc_2.invalidateSize();
                _loc_2.invalidateDisplayList();
            }
            dispatchEvent(new Event("explicitMaxWidthChanged"));
            return;
        }// end function

        public function set document(param1:Object) : void
        {
            var _loc_4:IUIComponent = null;
            var _loc_2:* = numChildren;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = getChildAt(_loc_3) as IUIComponent;
                if (!_loc_4)
                {
                }
                else if (_loc_4.document == _document || _loc_4.document == ApplicationGlobals.application)
                {
                    _loc_4.document = param1;
                }
                _loc_3++;
            }
            _document = param1;
            return;
        }// end function

        public function validateSize(param1:Boolean = false) : void
        {
            var _loc_2:int = 0;
            var _loc_3:DisplayObject = null;
            var _loc_4:Boolean = false;
            var _loc_5:IInvalidating = null;
            if (param1)
            {
                _loc_2 = 0;
                while (_loc_2 < numChildren)
                {
                    
                    _loc_3 = getChildAt(_loc_2);
                    if (_loc_3 is ILayoutManagerClient)
                    {
                        (_loc_3 as ILayoutManagerClient).validateSize(true);
                    }
                    _loc_2++;
                }
            }
            if (invalidateSizeFlag)
            {
                _loc_4 = measureSizes();
                if (_loc_4 && includeInLayout)
                {
                    invalidateDisplayList();
                    _loc_5 = parent as IInvalidating;
                    if (_loc_5)
                    {
                        _loc_5.invalidateSize();
                        _loc_5.invalidateDisplayList();
                    }
                }
            }
            return;
        }// end function

        public function get validationSubField() : String
        {
            return _validationSubField;
        }// end function

        override public function dispatchEvent(event:Event) : Boolean
        {
            if (dispatchEventHook != null)
            {
                dispatchEventHook(event, this);
            }
            return super.dispatchEvent(event);
        }// end function

        public function set id(param1:String) : void
        {
            _id = param1;
            return;
        }// end function

        private function overlay_resizeHandler(event:Event) : void
        {
            fillOverlay(overlay, overlayColor, null);
            return;
        }// end function

        public function set updateCompletePendingFlag(param1:Boolean) : void
        {
            _updateCompletePendingFlag = param1;
            return;
        }// end function

        final function get $height() : Number
        {
            return super.height;
        }// end function

        protected function attachOverlay() : void
        {
            addChild(overlay);
            return;
        }// end function

        public function get explicitMinHeight() : Number
        {
            return _explicitMinHeight;
        }// end function

        override public function set height(param1:Number) : void
        {
            var _loc_2:IInvalidating = null;
            if (explicitHeight != param1)
            {
                explicitHeight = param1;
                invalidateSize();
            }
            if (_height != param1)
            {
                invalidateProperties();
                invalidateDisplayList();
                _loc_2 = parent as IInvalidating;
                if (_loc_2 && includeInLayout)
                {
                    _loc_2.invalidateSize();
                    _loc_2.invalidateDisplayList();
                }
                _height = param1;
                dispatchEvent(new Event("heightChanged"));
            }
            return;
        }// end function

        public function get numAutomationChildren() : int
        {
            if (automationDelegate)
            {
                return automationDelegate.numAutomationChildren;
            }
            return 0;
        }// end function

        public function get parentApplication() : Object
        {
            var _loc_2:UIComponent = null;
            var _loc_1:* = systemManager.document;
            if (_loc_1 == this)
            {
                _loc_2 = _loc_1.systemManager.parent as UIComponent;
                _loc_1 = _loc_2 ? (_loc_2.systemManager.document) : (null);
            }
            return _loc_1;
        }// end function

        public function localToContent(param1:Point) : Point
        {
            return param1;
        }// end function

        public function get repeaterIndex() : int
        {
            return _repeaterIndices ? (_repeaterIndices[_repeaterIndices.length--]) : (-1);
        }// end function

        private function removeState(param1:String, param2:String) : void
        {
            var _loc_4:Array = null;
            var _loc_5:int = 0;
            var _loc_3:* = getState(param1);
            if (param1 == param2)
            {
                return;
            }
            if (_loc_3)
            {
                _loc_3.dispatchExitState();
                _loc_4 = _loc_3.overrides;
                _loc_5 = _loc_4.length;
                while (_loc_5--)
                {
                    
                    _loc_4[_loc_5--].remove(this);
                }
                if (_loc_3.basedOn != param2)
                {
                    removeState(_loc_3.basedOn, param2);
                }
            }
            return;
        }// end function

        public function setStyle(param1:String, param2) : void
        {
            if (param1 == "styleName")
            {
                styleName = param2;
                return;
            }
            if (EffectManager.getEventForEffectTrigger(param1) != "")
            {
                EffectManager.setStyle(param1, this);
            }
            var _loc_3:* = StyleManager.isInheritingStyle(param1);
            var _loc_4:* = inheritingStyles != UIComponent.STYLE_UNINITIALIZED;
            var _loc_5:* = getStyle(param1) != param2;
            if (!_styleDeclaration)
            {
                _styleDeclaration = new CSSStyleDeclaration();
                _styleDeclaration.setStyle(param1, param2);
                if (_loc_4)
                {
                    regenerateStyleCache(_loc_3);
                }
            }
            else
            {
                _styleDeclaration.setStyle(param1, param2);
            }
            if (_loc_4 && _loc_5)
            {
                styleChanged(param1);
                notifyStyleChangeInChildren(param1, _loc_3);
            }
            return;
        }// end function

        public function get showInAutomationHierarchy() : Boolean
        {
            return _showInAutomationHierarchy;
        }// end function

        public function get systemManager() : ISystemManager
        {
            var _loc_1:DisplayObject = null;
            var _loc_2:DisplayObjectContainer = null;
            var _loc_3:IUIComponent = null;
            if (!_systemManager || _systemManagerDirty)
            {
                _loc_1 = root;
                if (_systemManager is SystemManagerProxy)
                {
                }
                else if (_loc_1 && !(_loc_1 is Stage))
                {
                    _systemManager = _loc_1 as ISystemManager;
                }
                else if (_loc_1)
                {
                    _systemManager = Stage(_loc_1).getChildAt(0) as ISystemManager;
                }
                else
                {
                    _loc_2 = parent;
                    while (_loc_2)
                    {
                        
                        _loc_3 = _loc_2 as IUIComponent;
                        if (_loc_3)
                        {
                            _systemManager = _loc_3.systemManager;
                            break;
                        }
                        else if (_loc_2 is ISystemManager)
                        {
                            _systemManager = _loc_2 as ISystemManager;
                            break;
                        }
                        _loc_2 = _loc_2.parent;
                    }
                }
                _systemManagerDirty = false;
            }
            return _systemManager;
        }// end function

        private function isBaseState(param1:String) : Boolean
        {
            if (param1)
            {
            }
            return param1 == "";
        }// end function

        public function set enabled(param1:Boolean) : void
        {
            _enabled = param1;
            cachedTextFormat = null;
            invalidateDisplayList();
            dispatchEvent(new Event("enabledChanged"));
            return;
        }// end function

        public function set focusEnabled(param1:Boolean) : void
        {
            _focusEnabled = param1;
            return;
        }// end function

        public function get minWidth() : Number
        {
            if (!isNaN(explicitMinWidth))
            {
                return explicitMinWidth;
            }
            return measuredMinWidth;
        }// end function

        private function setFocusLater(event:Event = null) : void
        {
            var _loc_2:* = systemManager;
            if (_loc_2 && _loc_2.stage)
            {
                _loc_2.stage.removeEventListener(Event.ENTER_FRAME, setFocusLater);
                if (UIComponentGlobals.nextFocusObject)
                {
                    _loc_2.stage.focus = UIComponentGlobals.nextFocusObject;
                }
                UIComponentGlobals.nextFocusObject = null;
            }
            return;
        }// end function

        public function get currentState() : String
        {
            return _currentStateChanged ? (requestedCurrentState) : (_currentState);
        }// end function

        public function initializeRepeaterArrays(param1:IRepeaterClient) : void
        {
            if (param1 && param1.instanceIndices && !param1.isDocument || param1 != descriptor.document && !_instanceIndices)
            {
                _instanceIndices = param1.instanceIndices;
                _repeaters = param1.repeaters;
                _repeaterIndices = param1.repeaterIndices;
            }
            return;
        }// end function

        public function get baselinePosition() : Number
        {
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                return NaN;
            }
            if (!validateBaselinePosition())
            {
                return NaN;
            }
            var _loc_1:* = measureText("Wj");
            if (height < 2 + _loc_1.ascent + 2)
            {
                return int(height + (_loc_1.ascent - height) / 2);
            }
            return 2 + _loc_1.ascent;
        }// end function

        public function get measuredWidth() : Number
        {
            return _measuredWidth;
        }// end function

        public function set instanceIndices(param1:Array) : void
        {
            _instanceIndices = param1;
            return;
        }// end function

        public function set cachePolicy(param1:String) : void
        {
            if (_cachePolicy != param1)
            {
                _cachePolicy = param1;
                if (param1 == UIComponentCachePolicy.OFF)
                {
                    cacheAsBitmap = false;
                }
                else if (param1 == UIComponentCachePolicy.ON)
                {
                    cacheAsBitmap = true;
                }
                else
                {
                    cacheAsBitmap = cacheAsBitmapCount > 0;
                }
            }
            return;
        }// end function

        public function get automationValue() : Array
        {
            if (automationDelegate)
            {
                return automationDelegate.automationValue;
            }
            return [];
        }// end function

        private function addedHandler(event:Event) : void
        {
            var event:* = event;
            if (event.eventPhase != EventPhase.AT_TARGET)
            {
                return;
            }
            try
            {
                if (parent is IContainer && IContainer(parent).creatingContentPane)
                {
                    event.stopImmediatePropagation();
                    return;
                }
            }
            catch (error:SecurityError)
            {
            }
            return;
        }// end function

        public function parentChanged(param1:DisplayObjectContainer) : void
        {
            if (!param1)
            {
                _parent = null;
                _nestLevel = 0;
            }
            else if (param1 is IStyleClient)
            {
                _parent = param1;
            }
            else if (param1 is ISystemManager)
            {
                _parent = param1;
            }
            else
            {
                _parent = param1.parent;
            }
            return;
        }// end function

        public function get owner() : DisplayObjectContainer
        {
            return _owner ? (_owner) : (parent);
        }// end function

        public function get processedDescriptors() : Boolean
        {
            return _processedDescriptors;
        }// end function

        override public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
        {
            var _loc_3:* = param1.parent;
            if (_loc_3 && !(_loc_3 is Loader))
            {
                _loc_3.removeChild(param1);
            }
            if (overlayReferenceCount && param1 != overlay)
            {
                param2 = Math.min(param2, Math.max(0, super.numChildren--));
            }
            addingChild(param1);
            $addChildAt(param1, param2);
            childAdded(param1);
            return param1;
        }// end function

        public function get maxWidth() : Number
        {
            return !isNaN(explicitMaxWidth) ? (explicitMaxWidth) : (DEFAULT_MAX_WIDTH);
        }// end function

        override public function set alpha(param1:Number) : void
        {
            super.alpha = param1;
            dispatchEvent(new Event("alphaChanged"));
            return;
        }// end function

        private function removedHandler(event:Event) : void
        {
            var event:* = event;
            if (event.eventPhase != EventPhase.AT_TARGET)
            {
                return;
            }
            try
            {
                if (parent is IContainer && IContainer(parent).creatingContentPane)
                {
                    event.stopImmediatePropagation();
                    return;
                }
            }
            catch (error:SecurityError)
            {
            }
            _systemManagerDirty = true;
            return;
        }// end function

        public function callLater(param1:Function, param2:Array = null) : void
        {
            methodQueue.push(new MethodQueueElement(param1, param2));
            var _loc_3:* = systemManager;
            if (_loc_3 && _loc_3.stage || _loc_3.useSWFBridge())
            {
                if (!listeningForRender)
                {
                    _loc_3.addEventListener(FlexEvent.RENDER, callLaterDispatcher);
                    _loc_3.addEventListener(FlexEvent.ENTER_FRAME, callLaterDispatcher);
                    listeningForRender = true;
                }
                if (_loc_3.stage)
                {
                    _loc_3.stage.invalidate();
                }
            }
            return;
        }// end function

        public function get initialized() : Boolean
        {
            return _initialized;
        }// end function

        private function callLaterDispatcher2(event:Event) : void
        {
            var _loc_6:MethodQueueElement = null;
            if (UIComponentGlobals.callLaterSuspendCount > 0)
            {
                return;
            }
            var _loc_2:* = systemManager;
            if (_loc_2 && _loc_2.stage || _loc_2.useSWFBridge() && listeningForRender)
            {
                _loc_2.removeEventListener(FlexEvent.RENDER, callLaterDispatcher);
                _loc_2.removeEventListener(FlexEvent.ENTER_FRAME, callLaterDispatcher);
                listeningForRender = false;
            }
            var _loc_3:* = methodQueue;
            methodQueue = [];
            var _loc_4:* = _loc_3.length;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_6 = MethodQueueElement(_loc_3[_loc_5]);
                _loc_6.method.apply(null, _loc_6.args);
                _loc_5++;
            }
            return;
        }// end function

        public function measureHTMLText(param1:String) : TextLineMetrics
        {
            return determineTextFormatFromStyles().measureHTMLText(param1);
        }// end function

        public function set descriptor(param1:UIComponentDescriptor) : void
        {
            _descriptor = param1;
            return;
        }// end function

        private function getState(param1:String) : State
        {
            if (!states || isBaseState(param1))
            {
                return null;
            }
            var _loc_2:int = 0;
            while (_loc_2 < states.length)
            {
                
                if (states[_loc_2].name == param1)
                {
                    return states[_loc_2];
                }
                _loc_2++;
            }
            var _loc_3:* = resourceManager.getString("core", "stateUndefined", [param1]);
            throw new ArgumentError(_loc_3);
        }// end function

        public function validateProperties() : void
        {
            if (invalidatePropertiesFlag)
            {
                commitProperties();
                invalidatePropertiesFlag = false;
            }
            return;
        }// end function

        function get documentDescriptor() : UIComponentDescriptor
        {
            return _documentDescriptor;
        }// end function

        public function set includeInLayout(param1:Boolean) : void
        {
            var _loc_2:IInvalidating = null;
            if (_includeInLayout != param1)
            {
                _includeInLayout = param1;
                _loc_2 = parent as IInvalidating;
                if (_loc_2)
                {
                    _loc_2.invalidateSize();
                    _loc_2.invalidateDisplayList();
                }
                dispatchEvent(new Event("includeInLayoutChanged"));
            }
            return;
        }// end function

        public function getClassStyleDeclarations() : Array
        {
            var myApplicationDomain:ApplicationDomain;
            var cache:Array;
            var myRoot:DisplayObject;
            var s:CSSStyleDeclaration;
            var factory:* = ModuleManager.getAssociatedFactory(this);
            if (factory != null)
            {
                myApplicationDomain = ApplicationDomain(factory.info()["currentDomain"]);
            }
            else
            {
                myRoot = SystemManager.getSWFRoot(this);
                if (!myRoot)
                {
                    return [];
                }
                myApplicationDomain = myRoot.loaderInfo.applicationDomain;
            }
            var className:* = getQualifiedClassName(this);
            className = className.replace("::", ".");
            cache = StyleManager.typeSelectorCache[className];
            if (cache)
            {
                return cache;
            }
            var decls:Array;
            var classNames:Array;
            var caches:Array;
            var declcache:Array;
            do
            {
                
                cache = StyleManager.typeSelectorCache[className];
                if (cache)
                {
                    decls = decls.concat(cache);
                    break;
                }
                s = StyleManager.getStyleDeclaration(className);
                if (s)
                {
                    decls.unshift(s);
                    classNames.push(className);
                    caches.push(classNames);
                    declcache.push(decls);
                    decls;
                    classNames;
                }
                else
                {
                    classNames.push(className);
                }
                try
                {
                    className = getQualifiedSuperclassName(myApplicationDomain.getDefinition(className));
                    className = className.replace("::", ".");
                }
                catch (e:ReferenceError)
                {
                    className;
                }
            }while (className != null && className != "mx.core.UIComponent" && className != "mx.core.UITextField")
            caches.push(classNames);
            declcache.push(decls);
            decls;
            while (caches.length)
            {
                
                classNames = caches.pop();
                decls = decls.concat(declcache.pop());
                while (classNames.length)
                {
                    
                    StyleManager.typeSelectorCache[classNames.pop()] = decls;
                }
            }
            return decls;
        }// end function

        public function set measuredMinWidth(param1:Number) : void
        {
            _measuredMinWidth = param1;
            return;
        }// end function

        private function initializeState(param1:String) : void
        {
            var _loc_2:* = getState(param1);
            while (_loc_2)
            {
                
                _loc_2.initialize();
                _loc_2 = getState(_loc_2.basedOn);
            }
            return;
        }// end function

        function initProtoChain() : void
        {
            var _loc_1:CSSStyleDeclaration = null;
            var _loc_7:Object = null;
            var _loc_8:CSSStyleDeclaration = null;
            if (styleName)
            {
                if (styleName is CSSStyleDeclaration)
                {
                    _loc_1 = CSSStyleDeclaration(styleName);
                }
                else
                {
                    if (styleName is IFlexDisplayObject || styleName is IStyleClient)
                    {
                        StyleProtoChain.initProtoChainForUIComponentStyleName(this);
                        return;
                    }
                    if (styleName is String)
                    {
                        _loc_1 = StyleManager.getStyleDeclaration("." + styleName);
                    }
                }
            }
            var _loc_2:* = StyleManager.stylesRoot;
            if (_loc_2 && _loc_2.effects)
            {
                registerEffects(_loc_2.effects);
            }
            var _loc_3:* = parent as IStyleClient;
            if (_loc_3)
            {
                _loc_7 = _loc_3.inheritingStyles;
                if (_loc_7 == UIComponent.STYLE_UNINITIALIZED)
                {
                    _loc_7 = _loc_2;
                }
            }
            else if (isPopUp)
            {
                if (FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0 && _owner && _owner is IStyleClient)
                {
                    _loc_7 = IStyleClient(_owner).inheritingStyles;
                }
                else
                {
                    _loc_7 = ApplicationGlobals.application.inheritingStyles;
                }
            }
            else
            {
                _loc_7 = StyleManager.stylesRoot;
            }
            var _loc_4:* = getClassStyleDeclarations();
            var _loc_5:* = getClassStyleDeclarations().length;
            var _loc_6:int = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_8 = _loc_4[_loc_6];
                _loc_7 = _loc_8.addStyleToProtoChain(_loc_7, this);
                _loc_2 = _loc_8.addStyleToProtoChain(_loc_2, this);
                if (_loc_8.effects)
                {
                    registerEffects(_loc_8.effects);
                }
                _loc_6++;
            }
            if (_loc_1)
            {
                _loc_7 = _loc_1.addStyleToProtoChain(_loc_7, this);
                _loc_2 = _loc_1.addStyleToProtoChain(_loc_2, this);
                if (_loc_1.effects)
                {
                    registerEffects(_loc_1.effects);
                }
            }
            inheritingStyles = _styleDeclaration ? (_styleDeclaration.addStyleToProtoChain(_loc_7, this)) : (_loc_7);
            nonInheritingStyles = _styleDeclaration ? (_styleDeclaration.addStyleToProtoChain(_loc_2, this)) : (_loc_2);
            return;
        }// end function

        public function get repeaterIndices() : Array
        {
            return _repeaterIndices ? (_repeaterIndices.slice()) : ([]);
        }// end function

        override public function removeChild(param1:DisplayObject) : DisplayObject
        {
            removingChild(param1);
            $removeChild(param1);
            childRemoved(param1);
            return param1;
        }// end function

        private function focusObj_moveHandler(event:MoveEvent) : void
        {
            adjustFocusRect();
            return;
        }// end function

        public function get styleDeclaration() : CSSStyleDeclaration
        {
            return _styleDeclaration;
        }// end function

        override public function get doubleClickEnabled() : Boolean
        {
            return super.doubleClickEnabled;
        }// end function

        public function contentToLocal(param1:Point) : Point
        {
            return param1;
        }// end function

        private function creationCompleteHandler(event:FlexEvent) : void
        {
            if (_currentStateChanged)
            {
                _currentStateChanged = false;
                commitCurrentState();
                validateNow();
            }
            removeEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
            return;
        }// end function

        public function set measuredHeight(param1:Number) : void
        {
            _measuredHeight = param1;
            return;
        }// end function

        protected function createChildren() : void
        {
            return;
        }// end function

        public function get activeEffects() : Array
        {
            return _effectsStarted;
        }// end function

        override public function setChildIndex(param1:DisplayObject, param2:int) : void
        {
            if (overlayReferenceCount && param1 != overlay)
            {
                param2 = Math.min(param2, Math.max(0, super.numChildren - 2));
            }
            super.setChildIndex(param1, param2);
            return;
        }// end function

        public function regenerateStyleCache(param1:Boolean) : void
        {
            var _loc_5:DisplayObject = null;
            initProtoChain();
            var _loc_2:* = this is IRawChildrenContainer ? (IRawChildrenContainer(this).rawChildren) : (IChildList(this));
            var _loc_3:* = _loc_2.numChildren;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _loc_2.getChildAt(_loc_4);
                if (_loc_5 is IStyleClient)
                {
                    if (IStyleClient(_loc_5).inheritingStyles != UIComponent.STYLE_UNINITIALIZED)
                    {
                        IStyleClient(_loc_5).regenerateStyleCache(param1);
                    }
                }
                else if (_loc_5 is IUITextField)
                {
                    if (IUITextField(_loc_5).inheritingStyles)
                    {
                        StyleProtoChain.initTextField(IUITextField(_loc_5));
                    }
                }
                _loc_4++;
            }
            return;
        }// end function

        public function get updateCompletePendingFlag() : Boolean
        {
            return _updateCompletePendingFlag;
        }// end function

        protected function focusOutHandler(event:FocusEvent) : void
        {
            if (isOurFocus(DisplayObject(event.target)))
            {
                drawFocus(false);
            }
            return;
        }// end function

        public function getFocus() : InteractiveObject
        {
            var _loc_1:* = systemManager;
            if (!_loc_1)
            {
                return null;
            }
            if (UIComponentGlobals.nextFocusObject)
            {
                return UIComponentGlobals.nextFocusObject;
            }
            return _loc_1.stage.focus;
        }// end function

        public function endEffectsStarted() : void
        {
            var _loc_1:* = _effectsStarted.length;
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1)
            {
                
                _effectsStarted[_loc_2].end();
                _loc_2++;
            }
            return;
        }// end function

        protected function get unscaledHeight() : Number
        {
            return height / Math.abs(scaleY);
        }// end function

        public function get enabled() : Boolean
        {
            return _enabled;
        }// end function

        public function get focusEnabled() : Boolean
        {
            return _focusEnabled;
        }// end function

        override public function set cacheAsBitmap(param1:Boolean) : void
        {
            super.cacheAsBitmap = param1;
            cacheAsBitmapCount = param1 ? (1) : (0);
            return;
        }// end function

        function removeOverlay() : void
        {
            if (overlayReferenceCount > 0 && --overlayReferenceCount == 0 && overlay)
            {
                removeEventListener("resize", overlay_resizeHandler);
                if (super.getChildByName("overlay"))
                {
                    $removeChild(overlay);
                }
                overlay = null;
            }
            return;
        }// end function

        public function set cacheHeuristic(param1:Boolean) : void
        {
            if (_cachePolicy == UIComponentCachePolicy.AUTO)
            {
                if (param1)
                {
                    cacheAsBitmapCount++;
                }
                else if (cacheAsBitmapCount != 0)
                {
                    cacheAsBitmapCount--;
                }
                super.cacheAsBitmap = cacheAsBitmapCount != 0;
            }
            return;
        }// end function

        public function get cachePolicy() : String
        {
            return _cachePolicy;
        }// end function

        public function set maxHeight(param1:Number) : void
        {
            if (explicitMaxHeight == param1)
            {
                return;
            }
            explicitMaxHeight = param1;
            return;
        }// end function

        public function getConstraintValue(param1:String)
        {
            return getStyle(param1);
        }// end function

        public function set focusManager(param1:IFocusManager) : void
        {
            _focusManager = param1;
            return;
        }// end function

        public function clearStyle(param1:String) : void
        {
            setStyle(param1, undefined);
            return;
        }// end function

        public function get descriptor() : UIComponentDescriptor
        {
            return _descriptor;
        }// end function

        public function set nonInheritingStyles(param1:Object) : void
        {
            _nonInheritingStyles = param1;
            return;
        }// end function

        public function get cursorManager() : ICursorManager
        {
            var _loc_2:ICursorManager = null;
            var _loc_1:* = parent;
            while (_loc_1)
            {
                
                if (_loc_1 is IUIComponent && "cursorManager" in _loc_1)
                {
                    _loc_2 = _loc_1["cursorManager"];
                    return _loc_2;
                }
                _loc_1 = _loc_1.parent;
            }
            return CursorManager.getInstance();
        }// end function

        public function set automationDelegate(param1:Object) : void
        {
            _automationDelegate = param1 as IAutomationObject;
            return;
        }// end function

        public function get measuredMinWidth() : Number
        {
            return _measuredMinWidth;
        }// end function

        public function createReferenceOnParentDocument(param1:IFlexDisplayObject) : void
        {
            var _loc_2:Array = null;
            var _loc_3:Object = null;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:PropertyChangeEvent = null;
            var _loc_7:Object = null;
            if (id && id != "")
            {
                _loc_2 = _instanceIndices;
                if (!_loc_2)
                {
                    param1[id] = this;
                }
                else
                {
                    _loc_3 = param1[id];
                    if (!(_loc_3 is Array))
                    {
                        var _loc_8:* = [];
                        param1[id] = [];
                        _loc_3 = _loc_8;
                    }
                    _loc_4 = _loc_2.length;
                    _loc_5 = 0;
                    while (_loc_5 < _loc_4--)
                    {
                        
                        _loc_7 = _loc_3[_loc_2[_loc_5]];
                        if (!(_loc_7 is Array))
                        {
                            var _loc_8:* = [];
                            _loc_3[_loc_2[_loc_5]] = [];
                            _loc_7 = _loc_8;
                        }
                        _loc_3 = _loc_7;
                        _loc_5++;
                    }
                    _loc_3[_loc_2[_loc_4--]] = this;
                    _loc_6 = PropertyChangeEvent.createUpdateEvent(param1, id, param1[id], param1[id]);
                    param1.dispatchEvent(_loc_6);
                }
            }
            return;
        }// end function

        public function get repeater() : IRepeater
        {
            return _repeaters ? (_repeaters[_repeaters.length--]) : (null);
        }// end function

        public function set isPopUp(param1:Boolean) : void
        {
            _isPopUp = param1;
            return;
        }// end function

        public function get measuredHeight() : Number
        {
            return _measuredHeight;
        }// end function

        public function initialize() : void
        {
            if (initialized)
            {
                return;
            }
            dispatchEvent(new FlexEvent(FlexEvent.PREINITIALIZE));
            createChildren();
            childrenCreated();
            initializeAccessibility();
            initializationComplete();
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            var _loc_2:IInvalidating = null;
            if (explicitWidth != param1)
            {
                explicitWidth = param1;
                invalidateSize();
            }
            if (_width != param1)
            {
                invalidateProperties();
                invalidateDisplayList();
                _loc_2 = parent as IInvalidating;
                if (_loc_2 && includeInLayout)
                {
                    _loc_2.invalidateSize();
                    _loc_2.invalidateDisplayList();
                }
                _width = param1;
                dispatchEvent(new Event("widthChanged"));
            }
            return;
        }// end function

        public function set percentHeight(param1:Number) : void
        {
            if (_percentHeight == param1)
            {
                return;
            }
            if (!isNaN(param1))
            {
                _explicitHeight = NaN;
            }
            _percentHeight = param1;
            var _loc_2:* = parent as IInvalidating;
            if (_loc_2)
            {
                _loc_2.invalidateSize();
                _loc_2.invalidateDisplayList();
            }
            return;
        }// end function

        final function set $visible(param1:Boolean) : void
        {
            super.visible = param1;
            return;
        }// end function

        private function findCommonBaseState(param1:String, param2:String) : String
        {
            var _loc_3:* = getState(param1);
            var _loc_4:* = getState(param2);
            if (!_loc_3 || !_loc_4)
            {
                return "";
            }
            if (isBaseState(_loc_3.basedOn) && isBaseState(_loc_4.basedOn))
            {
                return "";
            }
            var _loc_5:* = getBaseStates(_loc_3);
            var _loc_6:* = getBaseStates(_loc_4);
            var _loc_7:String = "";
            while (_loc_5[_loc_5.length--] == _loc_6[_loc_6.length--])
            {
                
                _loc_7 = _loc_5.pop();
                _loc_6.pop();
                if (!_loc_5.length || !_loc_6.length)
                {
                    break;
                }
            }
            if (_loc_5.length && _loc_5[_loc_5.length--] == _loc_4.name)
            {
                _loc_7 = _loc_4.name;
            }
            else if (_loc_6.length && _loc_6[_loc_6.length--] == _loc_3.name)
            {
                _loc_7 = _loc_3.name;
            }
            return _loc_7;
        }// end function

        function childRemoved(param1:DisplayObject) : void
        {
            if (param1 is IUIComponent)
            {
                if (IUIComponent(param1).document != param1)
                {
                    IUIComponent(param1).document = null;
                }
                IUIComponent(param1).parentChanged(null);
            }
            return;
        }// end function

        final function $removeChildAt(param1:int) : DisplayObject
        {
            return super.removeChildAt(param1);
        }// end function

        public function get maxHeight() : Number
        {
            return !isNaN(explicitMaxHeight) ? (explicitMaxHeight) : (DEFAULT_MAX_HEIGHT);
        }// end function

        protected function initializeAccessibility() : void
        {
            if (UIComponent.createAccessibilityImplementation != null)
            {
                UIComponent.createAccessibilityImplementation(this);
            }
            return;
        }// end function

        public function set explicitMaxHeight(param1:Number) : void
        {
            if (_explicitMaxHeight == param1)
            {
                return;
            }
            _explicitMaxHeight = param1;
            invalidateSize();
            var _loc_2:* = parent as IInvalidating;
            if (_loc_2)
            {
                _loc_2.invalidateSize();
                _loc_2.invalidateDisplayList();
            }
            dispatchEvent(new Event("explicitMaxHeightChanged"));
            return;
        }// end function

        public function get focusManager() : IFocusManager
        {
            if (_focusManager)
            {
                return _focusManager;
            }
            var _loc_1:* = parent;
            while (_loc_1)
            {
                
                if (_loc_1 is IFocusManagerContainer)
                {
                    return IFocusManagerContainer(_loc_1).focusManager;
                }
                _loc_1 = _loc_1.parent;
            }
            return null;
        }// end function

        public function set styleName(param1:Object) : void
        {
            if (_styleName === param1)
            {
                return;
            }
            _styleName = param1;
            if (inheritingStyles == UIComponent.STYLE_UNINITIALIZED)
            {
                return;
            }
            regenerateStyleCache(true);
            initThemeColor();
            styleChanged("styleName");
            notifyStyleChangeInChildren("styleName", true);
            return;
        }// end function

        public function get automationDelegate() : Object
        {
            return _automationDelegate;
        }// end function

        protected function get resourceManager() : IResourceManager
        {
            return _resourceManager;
        }// end function

        function validateBaselinePosition() : Boolean
        {
            var _loc_1:Number = NaN;
            var _loc_2:Number = NaN;
            if (!parent)
            {
                return false;
            }
            if (width == 0 && height == 0)
            {
                validateNow();
                _loc_1 = getExplicitOrMeasuredWidth();
                _loc_2 = getExplicitOrMeasuredHeight();
                setActualSize(_loc_1, _loc_2);
            }
            validateNow();
            return true;
        }// end function

        function cancelAllCallLaters() : void
        {
            var _loc_1:* = systemManager;
            if (_loc_1 && _loc_1.stage || _loc_1.useSWFBridge())
            {
                if (listeningForRender)
                {
                    _loc_1.removeEventListener(FlexEvent.RENDER, callLaterDispatcher);
                    _loc_1.removeEventListener(FlexEvent.ENTER_FRAME, callLaterDispatcher);
                    listeningForRender = false;
                }
            }
            methodQueue.splice(0);
            return;
        }// end function

        private function updateCompleteHandler(event:FlexEvent) : void
        {
            UIComponentGlobals.layoutManager.removeEventListener(FlexEvent.UPDATE_COMPLETE, updateCompleteHandler);
            processEffectFinished(_endingEffectInstances);
            _endingEffectInstances = [];
            return;
        }// end function

        public function styleChanged(param1:String) : void
        {
            if (this is IFontContextComponent && hasFontContextChanged())
            {
                invalidateProperties();
            }
            if (!param1 || param1 == "styleName" || StyleManager.isSizeInvalidatingStyle(param1))
            {
                invalidateSize();
            }
            if (!param1 || param1 == "styleName" || param1 == "themeColor")
            {
                initThemeColor();
            }
            invalidateDisplayList();
            if (parent is IInvalidating)
            {
                if (StyleManager.isParentSizeInvalidatingStyle(param1))
                {
                    IInvalidating(parent).invalidateSize();
                }
                if (StyleManager.isParentDisplayListInvalidatingStyle(param1))
                {
                    IInvalidating(parent).invalidateDisplayList();
                }
            }
            return;
        }// end function

        final function get $visible() : Boolean
        {
            return super.visible;
        }// end function

        public function drawRoundRect(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null, param6:Object = null, param7:Object = null, param8:Object = null, param9:String = null, param10:Array = null, param11:Object = null) : void
        {
            var _loc_13:Number = NaN;
            var _loc_14:Array = null;
            var _loc_15:Matrix = null;
            var _loc_16:Object = null;
            var _loc_12:* = graphics;
            if (!param3 || !param4)
            {
                return;
            }
            if (param6 !== null)
            {
                if (param6 is Array)
                {
                    if (param7 is Array)
                    {
                        _loc_14 = param7 as Array;
                    }
                    else
                    {
                        _loc_14 = [param7, param7];
                    }
                    if (!param10)
                    {
                        param10 = [0, 255];
                    }
                    _loc_15 = null;
                    if (param8)
                    {
                        if (param8 is Matrix)
                        {
                            _loc_15 = Matrix(param8);
                        }
                        else
                        {
                            _loc_15 = new Matrix();
                            if (param8 is Number)
                            {
                                _loc_15.createGradientBox(param3, param4, Number(param8) * Math.PI / 180, param1, param2);
                            }
                            else
                            {
                                _loc_15.createGradientBox(param8.w, param8.h, param8.r, param8.x, param8.y);
                            }
                        }
                    }
                    if (param9 == GradientType.RADIAL)
                    {
                        _loc_12.beginGradientFill(GradientType.RADIAL, param6 as Array, _loc_14, param10, _loc_15);
                    }
                    else
                    {
                        _loc_12.beginGradientFill(GradientType.LINEAR, param6 as Array, _loc_14, param10, _loc_15);
                    }
                }
                else
                {
                    _loc_12.beginFill(Number(param6), Number(param7));
                }
            }
            if (!param5)
            {
                _loc_12.drawRect(param1, param2, param3, param4);
            }
            else if (param5 is Number)
            {
                _loc_13 = Number(param5) * 2;
                _loc_12.drawRoundRect(param1, param2, param3, param4, _loc_13, _loc_13);
            }
            else
            {
                GraphicsUtil.drawRoundRectComplex(_loc_12, param1, param2, param3, param4, param5.tl, param5.tr, param5.bl, param5.br);
            }
            if (param11)
            {
                _loc_16 = param11.r;
                if (_loc_16 is Number)
                {
                    _loc_13 = Number(_loc_16) * 2;
                    _loc_12.drawRoundRect(param11.x, param11.y, param11.w, param11.h, _loc_13, _loc_13);
                }
                else
                {
                    GraphicsUtil.drawRoundRectComplex(_loc_12, param11.x, param11.y, param11.w, param11.h, _loc_16.tl, _loc_16.tr, _loc_16.bl, _loc_16.br);
                }
            }
            if (param6 !== null)
            {
                _loc_12.endFill();
            }
            return;
        }// end function

        public function move(param1:Number, param2:Number) : void
        {
            var _loc_3:Boolean = false;
            if (param1 != super.x)
            {
                super.x = param1;
                dispatchEvent(new Event("xChanged"));
                _loc_3 = true;
            }
            if (param2 != super.y)
            {
                super.y = param2;
                dispatchEvent(new Event("yChanged"));
                _loc_3 = true;
            }
            if (_loc_3)
            {
                dispatchMoveEvent();
            }
            return;
        }// end function

        public function set toolTip(param1:String) : void
        {
            var _loc_2:* = _toolTip;
            _toolTip = param1;
            ToolTipManager.registerToolTip(this, _loc_2, param1);
            dispatchEvent(new Event("toolTipChanged"));
            return;
        }// end function

        public function set repeaters(param1:Array) : void
        {
            _repeaters = param1;
            return;
        }// end function

        public function get explicitMaxHeight() : Number
        {
            return _explicitMaxHeight;
        }// end function

        public function measureText(param1:String) : TextLineMetrics
        {
            return determineTextFormatFromStyles().measureText(param1);
        }// end function

        public function get styleName() : Object
        {
            return _styleName;
        }// end function

        protected function createInModuleContext(param1:IFlexModuleFactory, param2:String) : Object
        {
            var _loc_3:Object = null;
            if (param1)
            {
                _loc_3 = param1.create(param2);
            }
            return _loc_3;
        }// end function

        public function get parentDocument() : Object
        {
            var _loc_1:IUIComponent = null;
            var _loc_2:ISystemManager = null;
            if (document == this)
            {
                _loc_1 = parent as IUIComponent;
                if (_loc_1)
                {
                    return _loc_1.document;
                }
                _loc_2 = parent as ISystemManager;
                if (_loc_2)
                {
                    return _loc_2.document;
                }
                return null;
            }
            else
            {
                return document;
            }
        }// end function

        protected function childrenCreated() : void
        {
            invalidateProperties();
            invalidateSize();
            invalidateDisplayList();
            return;
        }// end function

        public function set flexContextMenu(param1:IFlexContextMenu) : void
        {
            if (_flexContextMenu)
            {
                _flexContextMenu.unsetContextMenu(this);
            }
            _flexContextMenu = param1;
            if (param1 != null)
            {
                _flexContextMenu.setContextMenu(this);
            }
            return;
        }// end function

        public function set explicitWidth(param1:Number) : void
        {
            if (_explicitWidth == param1)
            {
                return;
            }
            if (!isNaN(param1))
            {
                _percentWidth = NaN;
            }
            _explicitWidth = param1;
            invalidateSize();
            var _loc_2:* = parent as IInvalidating;
            if (_loc_2 && includeInLayout)
            {
                _loc_2.invalidateSize();
                _loc_2.invalidateDisplayList();
            }
            dispatchEvent(new Event("explicitWidthChanged"));
            return;
        }// end function

        private function setBorderColorForErrorString() : void
        {
            if (!_errorString || _errorString.length == 0)
            {
                if (!isNaN(origBorderColor))
                {
                    setStyle("borderColor", origBorderColor);
                    saveBorderColor = true;
                }
            }
            else
            {
                if (saveBorderColor)
                {
                    saveBorderColor = false;
                    origBorderColor = getStyle("borderColor");
                }
                setStyle("borderColor", getStyle("errorColor"));
            }
            styleChanged("themeColor");
            var _loc_1:* = focusManager;
            var _loc_2:* = _loc_1 ? (DisplayObject(_loc_1.getFocus())) : (null);
            if (_loc_1 && _loc_1.showFocusIndicator && _loc_2 == this)
            {
                drawFocus(true);
            }
            return;
        }// end function

        public function get explicitWidth() : Number
        {
            return _explicitWidth;
        }// end function

        public function invalidateSize() : void
        {
            if (!invalidateSizeFlag)
            {
                invalidateSizeFlag = true;
                if (parent && UIComponentGlobals.layoutManager)
                {
                    UIComponentGlobals.layoutManager.invalidateSize(this);
                }
            }
            return;
        }// end function

        public function set measuredMinHeight(param1:Number) : void
        {
            _measuredMinHeight = param1;
            return;
        }// end function

        protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            return;
        }// end function

        override public function set filters(param1:Array) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:IEventDispatcher = null;
            if (_filters)
            {
                _loc_2 = _filters.length;
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    _loc_4 = _filters[_loc_3] as IEventDispatcher;
                    if (_loc_4)
                    {
                        _loc_4.removeEventListener("change", filterChangeHandler);
                    }
                    _loc_3++;
                }
            }
            _filters = param1;
            if (_filters)
            {
                _loc_2 = _filters.length;
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    _loc_4 = _filters[_loc_3] as IEventDispatcher;
                    if (_loc_4)
                    {
                        _loc_4.addEventListener("change", filterChangeHandler);
                    }
                    _loc_3++;
                }
            }
            super.filters = _filters;
            return;
        }// end function

        private static function get embeddedFontRegistry() : IEmbeddedFontRegistry
        {
            if (!_embeddedFontRegistry)
            {
                _embeddedFontRegistry = IEmbeddedFontRegistry(Singleton.getInstance("mx.core::IEmbeddedFontRegistry"));
            }
            return _embeddedFontRegistry;
        }// end function

        public static function resumeBackgroundProcessing() : void
        {
            var _loc_1:ISystemManager = null;
            if (UIComponentGlobals.callLaterSuspendCount > 0)
            {
                var _loc_2:* = UIComponentGlobals;
                _loc_2.callLaterSuspendCount = UIComponentGlobals.callLaterSuspendCount--;
                if (UIComponentGlobals.callLaterSuspendCount == 0)
                {
                    _loc_1 = SystemManagerGlobals.topLevelSystemManagers[0];
                    if (_loc_1 && _loc_1.stage)
                    {
                        _loc_1.stage.invalidate();
                    }
                }
            }
            return;
        }// end function

        public static function suspendBackgroundProcessing() : void
        {
            var _loc_1:* = UIComponentGlobals;
            _loc_1.callLaterSuspendCount = UIComponentGlobals.callLaterSuspendCount++;
            return;
        }// end function

    }
}
