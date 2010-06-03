package mx.core
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import mx.automation.*;
    import mx.managers.*;
    import mx.resources.*;
    import mx.styles.*;
    import mx.utils.*;

    public class UITextField extends FlexTextField implements IAutomationObject, IIMESupport, IFlexModule, IInvalidating, ISimpleStyleClient, IToolTipManagerClient, IUITextField
    {
        private var _enabled:Boolean = true;
        private var untruncatedText:String;
        private var cachedEmbeddedFont:EmbeddedFont = null;
        private var cachedTextFormat:TextFormat;
        private var _automationDelegate:IAutomationObject;
        private var _automationName:String;
        private var _styleName:Object;
        private var _document:Object;
        var _toolTip:String;
        private var _nestLevel:int = 0;
        private var _explicitHeight:Number;
        private var _moduleFactory:IFlexModuleFactory;
        private var _initialized:Boolean = false;
        private var _nonInheritingStyles:Object;
        private var _inheritingStyles:Object;
        private var _includeInLayout:Boolean = true;
        private var invalidateDisplayListFlag:Boolean = true;
        var explicitColor:uint = 4.29497e+009;
        private var _processedDescriptors:Boolean = true;
        private var _updateCompletePendingFlag:Boolean = false;
        private var explicitHTMLText:String = null;
        var _parent:DisplayObjectContainer;
        private var _imeMode:String = null;
        private var resourceManager:IResourceManager;
        var styleChangedFlag:Boolean = true;
        private var _ignorePadding:Boolean = true;
        private var _owner:DisplayObjectContainer;
        private var _explicitWidth:Number;
        static const TEXT_WIDTH_PADDING:int = 5;
        static const TEXT_HEIGHT_PADDING:int = 4;
        private static var truncationIndicatorResource:String;
        private static var _embeddedFontRegistry:IEmbeddedFontRegistry;
        static const VERSION:String = "3.2.0.3958";
        static var debuggingBorders:Boolean = false;

        public function UITextField()
        {
            resourceManager = ResourceManager.getInstance();
            _inheritingStyles = UIComponent.STYLE_UNINITIALIZED;
            _nonInheritingStyles = UIComponent.STYLE_UNINITIALIZED;
            super.text = "";
            focusRect = false;
            selectable = false;
            tabEnabled = false;
            if (debuggingBorders)
            {
                border = true;
            }
            if (!truncationIndicatorResource)
            {
                truncationIndicatorResource = resourceManager.getString("core", "truncationIndicator");
            }
            addEventListener(Event.CHANGE, changeHandler);
            addEventListener("textFieldStyleChange", textFieldStyleChangeHandler);
            resourceManager.addEventListener(Event.CHANGE, resourceManager_changeHandler, false, 0, true);
            return;
        }// end function

        public function set imeMode(param1:String) : void
        {
            _imeMode = param1;
            return;
        }// end function

        public function get nestLevel() : int
        {
            return _nestLevel;
        }// end function

        private function textFieldStyleChangeHandler(event:Event) : void
        {
            if (explicitHTMLText != null)
            {
                super.htmlText = explicitHTMLText;
            }
            return;
        }// end function

        public function truncateToFit(param1:String = null) : Boolean
        {
            var _loc_4:String = null;
            if (!param1)
            {
                param1 = truncationIndicatorResource;
            }
            validateNow();
            var _loc_2:* = super.text;
            untruncatedText = _loc_2;
            var _loc_3:* = width;
            if (_loc_2 != "" && textWidth + TEXT_WIDTH_PADDING > _loc_3 + 1e-014)
            {
                var _loc_5:* = _loc_2;
                super.text = _loc_2;
                _loc_4 = _loc_5;
                _loc_2.slice(0, Math.floor(_loc_3 / (textWidth + TEXT_WIDTH_PADDING) * _loc_2.length));
                while (_loc_4.length > 1 && textWidth + TEXT_WIDTH_PADDING > _loc_3)
                {
                    
                    _loc_4 = _loc_4.slice(0, -1);
                    super.text = _loc_4 + param1;
                }
                return true;
            }
            return false;
        }// end function

        public function set nestLevel(param1:int) : void
        {
            if (param1 > 1 && _nestLevel != param1)
            {
                _nestLevel = param1;
                StyleProtoChain.initTextField(this);
                styleChangedFlag = true;
                validateNow();
            }
            return;
        }// end function

        public function get minHeight() : Number
        {
            return 0;
        }// end function

        public function getExplicitOrMeasuredHeight() : Number
        {
            return !isNaN(explicitHeight) ? (explicitHeight) : (measuredHeight);
        }// end function

        public function getStyle(param1:String)
        {
            if (StyleManager.inheritingStyles[param1])
            {
                return inheritingStyles ? (inheritingStyles[param1]) : (IStyleClient(parent).getStyle(param1));
            }
            else
            {
                return nonInheritingStyles ? (nonInheritingStyles[param1]) : (IStyleClient(parent).getStyle(param1));
            }
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

        public function setColor(param1:uint) : void
        {
            explicitColor = param1;
            styleChangedFlag = true;
            invalidateDisplayListFlag = true;
            validateNow();
            return;
        }// end function

        override public function replaceText(param1:int, param2:int, param3:String) : void
        {
            super.replaceText(param1, param2, param3);
            dispatchEvent(new Event("textReplace"));
            return;
        }// end function

        private function creatingSystemManager() : ISystemManager
        {
            if (moduleFactory != null)
            {
            }
            return moduleFactory is ISystemManager ? (ISystemManager(moduleFactory)) : (systemManager);
        }// end function

        public function set document(param1:Object) : void
        {
            _document = param1;
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

        public function get explicitMinHeight() : Number
        {
            return NaN;
        }// end function

        public function get focusPane() : Sprite
        {
            return null;
        }// end function

        public function getTextStyles() : TextFormat
        {
            var _loc_1:* = new TextFormat();
            _loc_1.align = getStyle("textAlign");
            _loc_1.bold = getStyle("fontWeight") == "bold";
            if (enabled)
            {
                if (explicitColor == StyleManager.NOT_A_COLOR)
                {
                    _loc_1.color = getStyle("color");
                }
                else
                {
                    _loc_1.color = explicitColor;
                }
            }
            else
            {
                _loc_1.color = getStyle("disabledColor");
            }
            _loc_1.font = StringUtil.trimArrayElements(getStyle("fontFamily"), ",");
            _loc_1.indent = getStyle("textIndent");
            _loc_1.italic = getStyle("fontStyle") == "italic";
            _loc_1.kerning = getStyle("kerning");
            _loc_1.leading = getStyle("leading");
            _loc_1.leftMargin = ignorePadding ? (0) : (getStyle("paddingLeft"));
            _loc_1.letterSpacing = getStyle("letterSpacing");
            _loc_1.rightMargin = ignorePadding ? (0) : (getStyle("paddingRight"));
            _loc_1.size = getStyle("fontSize");
            _loc_1.underline = getStyle("textDecoration") == "underline";
            cachedTextFormat = _loc_1;
            return _loc_1;
        }// end function

        override public function set text(param1:String) : void
        {
            if (!param1)
            {
                param1 = "";
            }
            if (!isHTML && super.text == param1)
            {
                return;
            }
            super.text = param1;
            explicitHTMLText = null;
            if (invalidateDisplayListFlag)
            {
                validateNow();
            }
            return;
        }// end function

        public function getExplicitOrMeasuredWidth() : Number
        {
            return !isNaN(explicitWidth) ? (explicitWidth) : (measuredWidth);
        }// end function

        public function get showInAutomationHierarchy() : Boolean
        {
            return true;
        }// end function

        public function set automationName(param1:String) : void
        {
            _automationName = param1;
            return;
        }// end function

        public function get systemManager() : ISystemManager
        {
            var _loc_2:IUIComponent = null;
            var _loc_1:* = parent;
            while (_loc_1)
            {
                
                _loc_2 = _loc_1 as IUIComponent;
                if (_loc_2)
                {
                    return _loc_2.systemManager;
                }
                _loc_1 = _loc_1.parent;
            }
            return null;
        }// end function

        public function setStyle(param1:String, param2) : void
        {
            return;
        }// end function

        public function get percentWidth() : Number
        {
            return NaN;
        }// end function

        public function get explicitHeight() : Number
        {
            return _explicitHeight;
        }// end function

        public function get baselinePosition() : Number
        {
            var _loc_1:TextLineMetrics = null;
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                _loc_1 = getLineMetrics(0);
                return height - 4 - _loc_1.descent;
            }
            if (!parent)
            {
                return NaN;
            }
            var _loc_2:* = text == "";
            if (_loc_2)
            {
                super.text = "Wj";
            }
            _loc_1 = getLineMetrics(0);
            if (_loc_2)
            {
                super.text = "";
            }
            return 2 + _loc_1.ascent;
        }// end function

        public function set enabled(param1:Boolean) : void
        {
            mouseEnabled = param1;
            _enabled = param1;
            styleChanged("color");
            return;
        }// end function

        public function get minWidth() : Number
        {
            return 0;
        }// end function

        public function get automationValue() : Array
        {
            if (automationDelegate)
            {
                return automationDelegate.automationValue;
            }
            return [""];
        }// end function

        public function get tweeningProperties() : Array
        {
            return null;
        }// end function

        public function get measuredWidth() : Number
        {
            validateNow();
            if (!stage)
            {
                return textWidth + TEXT_WIDTH_PADDING;
            }
            return textWidth * transform.concatenatedMatrix.d + TEXT_WIDTH_PADDING;
        }// end function

        public function set tweeningProperties(param1:Array) : void
        {
            return;
        }// end function

        public function createAutomationIDPart(param1:IAutomationObject) : Object
        {
            return null;
        }// end function

        override public function get parent() : DisplayObjectContainer
        {
            return _parent ? (_parent) : (super.parent);
        }// end function

        public function set updateCompletePendingFlag(param1:Boolean) : void
        {
            _updateCompletePendingFlag = param1;
            return;
        }// end function

        public function setActualSize(param1:Number, param2:Number) : void
        {
            if (width != param1)
            {
                width = param1;
            }
            if (height != param2)
            {
                height = param2;
            }
            return;
        }// end function

        public function get numAutomationChildren() : int
        {
            return 0;
        }// end function

        public function set focusPane(param1:Sprite) : void
        {
            return;
        }// end function

        public function getAutomationChildAt(param1:int) : IAutomationObject
        {
            return null;
        }// end function

        public function get inheritingStyles() : Object
        {
            return _inheritingStyles;
        }// end function

        public function get owner() : DisplayObjectContainer
        {
            return _owner ? (_owner) : (parent);
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
            else if (param1 is SystemManager)
            {
                _parent = param1;
            }
            else
            {
                _parent = param1.parent;
            }
            return;
        }// end function

        public function get processedDescriptors() : Boolean
        {
            return _processedDescriptors;
        }// end function

        public function get maxWidth() : Number
        {
            return UIComponent.DEFAULT_MAX_WIDTH;
        }// end function

        private function getEmbeddedFont(param1:String, param2:Boolean, param3:Boolean) : EmbeddedFont
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

        public function get initialized() : Boolean
        {
            return _initialized;
        }// end function

        public function invalidateDisplayList() : void
        {
            invalidateDisplayListFlag = true;
            return;
        }// end function

        public function invalidateProperties() : void
        {
            return;
        }// end function

        override public function insertXMLText(param1:int, param2:int, param3:String, param4:Boolean = false) : void
        {
            super.insertXMLText(param1, param2, param3, param4);
            dispatchEvent(new Event("textInsert"));
            return;
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
            }
            return;
        }// end function

        override public function set htmlText(param1:String) : void
        {
            if (!param1)
            {
                param1 = "";
            }
            if (isHTML && super.htmlText == param1)
            {
                return;
            }
            if (cachedTextFormat && styleSheet == null)
            {
                defaultTextFormat = cachedTextFormat;
            }
            super.htmlText = param1;
            explicitHTMLText = param1;
            if (invalidateDisplayListFlag)
            {
                validateNow();
            }
            return;
        }// end function

        public function set showInAutomationHierarchy(param1:Boolean) : void
        {
            return;
        }// end function

        private function resourceManager_changeHandler(event:Event) : void
        {
            truncationIndicatorResource = resourceManager.getString("core", "truncationIndicator");
            if (untruncatedText != null)
            {
                super.text = untruncatedText;
                truncateToFit();
            }
            return;
        }// end function

        public function set measuredMinWidth(param1:Number) : void
        {
            return;
        }// end function

        public function set explicitHeight(param1:Number) : void
        {
            _explicitHeight = param1;
            return;
        }// end function

        public function get explicitMinWidth() : Number
        {
            return NaN;
        }// end function

        public function set percentWidth(param1:Number) : void
        {
            return;
        }// end function

        public function get imeMode() : String
        {
            return _imeMode;
        }// end function

        public function get moduleFactory() : IFlexModuleFactory
        {
            return _moduleFactory;
        }// end function

        public function set systemManager(param1:ISystemManager) : void
        {
            return;
        }// end function

        public function get explicitMaxWidth() : Number
        {
            return NaN;
        }// end function

        public function get document() : Object
        {
            return _document;
        }// end function

        public function get updateCompletePendingFlag() : Boolean
        {
            return _updateCompletePendingFlag;
        }// end function

        public function replayAutomatableEvent(event:Event) : Boolean
        {
            if (automationDelegate)
            {
                return automationDelegate.replayAutomatableEvent(event);
            }
            return false;
        }// end function

        public function get enabled() : Boolean
        {
            return _enabled;
        }// end function

        public function set owner(param1:DisplayObjectContainer) : void
        {
            _owner = param1;
            return;
        }// end function

        public function get automationTabularData() : Object
        {
            return null;
        }// end function

        public function set nonInheritingStyles(param1:Object) : void
        {
            _nonInheritingStyles = param1;
            return;
        }// end function

        public function get includeInLayout() : Boolean
        {
            return _includeInLayout;
        }// end function

        public function get measuredMinWidth() : Number
        {
            return 0;
        }// end function

        public function set isPopUp(param1:Boolean) : void
        {
            return;
        }// end function

        public function set automationDelegate(param1:Object) : void
        {
            _automationDelegate = param1 as IAutomationObject;
            return;
        }// end function

        public function get measuredHeight() : Number
        {
            validateNow();
            if (!stage)
            {
                return textHeight + TEXT_HEIGHT_PADDING;
            }
            return textHeight * transform.concatenatedMatrix.a + TEXT_HEIGHT_PADDING;
        }// end function

        public function set processedDescriptors(param1:Boolean) : void
        {
            _processedDescriptors = param1;
            return;
        }// end function

        public function setFocus() : void
        {
            systemManager.stage.focus = this;
            return;
        }// end function

        public function initialize() : void
        {
            return;
        }// end function

        public function set percentHeight(param1:Number) : void
        {
            return;
        }// end function

        public function resolveAutomationIDPart(param1:Object) : Array
        {
            return [];
        }// end function

        public function set inheritingStyles(param1:Object) : void
        {
            _inheritingStyles = param1;
            return;
        }// end function

        public function getUITextFormat() : UITextFormat
        {
            validateNow();
            var _loc_1:* = new UITextFormat(creatingSystemManager());
            _loc_1.moduleFactory = moduleFactory;
            _loc_1.copyFrom(getTextFormat());
            _loc_1.antiAliasType = antiAliasType;
            _loc_1.gridFitType = gridFitType;
            _loc_1.sharpness = sharpness;
            _loc_1.thickness = thickness;
            return _loc_1;
        }// end function

        private function changeHandler(event:Event) : void
        {
            explicitHTMLText = null;
            return;
        }// end function

        public function set initialized(param1:Boolean) : void
        {
            _initialized = param1;
            return;
        }// end function

        public function get nonZeroTextHeight() : Number
        {
            var _loc_1:Number = NaN;
            if (super.text == "")
            {
                super.text = "Wj";
                _loc_1 = textHeight;
                super.text = "";
                return _loc_1;
            }
            return textHeight;
        }// end function

        public function owns(param1:DisplayObject) : Boolean
        {
            return param1 == this;
        }// end function

        override public function setTextFormat(param1:TextFormat, param2:int = -1, param3:int = -1) : void
        {
            if (styleSheet)
            {
                return;
            }
            super.setTextFormat(param1, param2, param3);
            dispatchEvent(new Event("textFormatChange"));
            return;
        }// end function

        public function get nonInheritingStyles() : Object
        {
            return _nonInheritingStyles;
        }// end function

        public function setVisible(param1:Boolean, param2:Boolean = false) : void
        {
            this.visible = param1;
            return;
        }// end function

        public function get maxHeight() : Number
        {
            return UIComponent.DEFAULT_MAX_HEIGHT;
        }// end function

        public function get automationDelegate() : Object
        {
            return _automationDelegate;
        }// end function

        public function get isPopUp() : Boolean
        {
            return false;
        }// end function

        public function set ignorePadding(param1:Boolean) : void
        {
            _ignorePadding = param1;
            styleChanged(null);
            return;
        }// end function

        public function set styleName(param1:Object) : void
        {
            if (_styleName === param1)
            {
                return;
            }
            _styleName = param1;
            if (parent)
            {
                StyleProtoChain.initTextField(this);
                styleChanged("styleName");
            }
            return;
        }// end function

        public function styleChanged(param1:String) : void
        {
            styleChangedFlag = true;
            if (!invalidateDisplayListFlag)
            {
                invalidateDisplayListFlag = true;
                if ("callLater" in parent)
                {
                    Object(parent).callLater(validateNow);
                }
            }
            return;
        }// end function

        public function get percentHeight() : Number
        {
            return NaN;
        }// end function

        private function get isHTML() : Boolean
        {
            return explicitHTMLText != null;
        }// end function

        public function get explicitMaxHeight() : Number
        {
            return NaN;
        }// end function

        public function get styleName() : Object
        {
            return _styleName;
        }// end function

        public function set explicitWidth(param1:Number) : void
        {
            _explicitWidth = param1;
            return;
        }// end function

        public function validateNow() : void
        {
            var _loc_1:TextFormat = null;
            var _loc_2:EmbeddedFont = null;
            var _loc_3:IFlexModuleFactory = null;
            var _loc_4:ISystemManager = null;
            if (!parent)
            {
                return;
            }
            if (!isNaN(explicitWidth) && super.width != explicitWidth)
            {
                super.width = explicitWidth > 4 ? (explicitWidth) : (4);
            }
            if (!isNaN(explicitHeight) && super.height != explicitHeight)
            {
                super.height = explicitHeight;
            }
            if (styleChangedFlag)
            {
                _loc_1 = getTextStyles();
                if (_loc_1.font)
                {
                    _loc_2 = getEmbeddedFont(_loc_1.font, _loc_1.bold, _loc_1.italic);
                    _loc_3 = embeddedFontRegistry.getAssociatedModuleFactory(_loc_2, moduleFactory);
                    if (_loc_3 != null)
                    {
                        embedFonts = true;
                    }
                    else
                    {
                        _loc_4 = creatingSystemManager();
                        if (_loc_4 != null)
                        {
                        }
                        embedFonts = _loc_4.isFontFaceEmbedded(_loc_1);
                    }
                }
                else
                {
                    embedFonts = getStyle("embedFonts");
                }
                if (getStyle("fontAntiAliasType") != undefined)
                {
                    antiAliasType = getStyle("fontAntiAliasType");
                    gridFitType = getStyle("fontGridFitType");
                    sharpness = getStyle("fontSharpness");
                    thickness = getStyle("fontThickness");
                }
                if (!styleSheet)
                {
                    super.setTextFormat(_loc_1);
                    defaultTextFormat = _loc_1;
                }
                dispatchEvent(new Event("textFieldStyleChange"));
            }
            styleChangedFlag = false;
            invalidateDisplayListFlag = false;
            return;
        }// end function

        public function set toolTip(param1:String) : void
        {
            var _loc_2:* = _toolTip;
            _toolTip = param1;
            ToolTipManager.registerToolTip(this, _loc_2, param1);
            return;
        }// end function

        public function move(param1:Number, param2:Number) : void
        {
            if (this.x != param1)
            {
                this.x = param1;
            }
            if (this.y != param2)
            {
                this.y = param2;
            }
            return;
        }// end function

        public function get toolTip() : String
        {
            return _toolTip;
        }// end function

        public function get ignorePadding() : Boolean
        {
            return _ignorePadding;
        }// end function

        public function get explicitWidth() : Number
        {
            return _explicitWidth;
        }// end function

        public function invalidateSize() : void
        {
            invalidateDisplayListFlag = true;
            return;
        }// end function

        public function set measuredMinHeight(param1:Number) : void
        {
            return;
        }// end function

        public function get measuredMinHeight() : Number
        {
            return 0;
        }// end function

        public function set moduleFactory(param1:IFlexModuleFactory) : void
        {
            _moduleFactory = param1;
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

    }
}
