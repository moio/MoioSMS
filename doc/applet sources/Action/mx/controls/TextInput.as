package mx.controls
{
    import flash.accessibility.*;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.text.*;
    import flash.ui.*;
    import mx.controls.listClasses.*;
    import mx.core.*;
    import mx.events.*;
    import mx.managers.*;
    import mx.styles.*;

    public class TextInput extends UIComponent implements IDataRenderer, IDropInListItemRenderer, IFocusManagerComponent, IIMESupport, IListItemRenderer, IFontContextComponent
    {
        private var _text:String = "";
        private var _textWidth:Number;
        private var _restrict:String;
        private var htmlTextChanged:Boolean = false;
        var border:IFlexDisplayObject;
        private var enabledChanged:Boolean = false;
        private var _maxChars:int = 0;
        private var _condenseWhite:Boolean = false;
        private var accessibilityPropertiesChanged:Boolean = false;
        private var _textHeight:Number;
        private var displayAsPasswordChanged:Boolean = false;
        private var prevMode:String = "UNKNOWN";
        private var selectableChanged:Boolean = false;
        private var restrictChanged:Boolean = false;
        private var selectionChanged:Boolean = false;
        private var _data:Object;
        private var maxCharsChanged:Boolean = false;
        private var _tabIndex:int = -1;
        private var errorCaught:Boolean = false;
        private var _selectionBeginIndex:int = 0;
        private var explicitHTMLText:String = null;
        private var editableChanged:Boolean = false;
        var parentDrawsFocus:Boolean = false;
        private var tabIndexChanged:Boolean = false;
        private var _horizontalScrollPosition:Number = 0;
        private var _editable:Boolean = true;
        private var _imeMode:String = null;
        private var condenseWhiteChanged:Boolean = false;
        protected var textField:IUITextField;
        private var _listData:BaseListData;
        private var _displayAsPassword:Boolean = false;
        private var textChanged:Boolean = false;
        private var _htmlText:String = "";
        private var _accessibilityProperties:AccessibilityProperties;
        private var _selectionEndIndex:int = 0;
        private var textSet:Boolean;
        private var horizontalScrollPositionChanged:Boolean = false;
        private var _selectable:Boolean = true;
        static const VERSION:String = "3.2.0.3958";

        public function TextInput()
        {
            tabChildren = true;
            return;
        }// end function

        public function get imeMode() : String
        {
            return _imeMode;
        }// end function

        public function set imeMode(param1:String) : void
        {
            _imeMode = param1;
            return;
        }// end function

        override protected function focusOutHandler(event:FocusEvent) : void
        {
            super.focusOutHandler(event);
            if (_imeMode != null && _editable)
            {
                if (IME.conversionMode != IMEConversionMode.UNKNOWN && prevMode != IMEConversionMode.UNKNOWN)
                {
                    IME.conversionMode = prevMode;
                }
                IME.enabled = false;
            }
            dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
            return;
        }// end function

        override public function drawFocus(param1:Boolean) : void
        {
            if (parentDrawsFocus)
            {
                IFocusManagerComponent(parent).drawFocus(param1);
                return;
            }
            super.drawFocus(param1);
            return;
        }// end function

        function getTextField() : IUITextField
        {
            return textField;
        }// end function

        private function textField_textInputHandler(event:TextEvent) : void
        {
            event.stopImmediatePropagation();
            var _loc_2:* = new TextEvent(TextEvent.TEXT_INPUT, false, true);
            _loc_2.text = event.text;
            dispatchEvent(_loc_2);
            if (_loc_2.isDefaultPrevented())
            {
                event.preventDefault();
            }
            return;
        }// end function

        override public function get accessibilityProperties() : AccessibilityProperties
        {
            return _accessibilityProperties;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            createBorder();
            createTextField(-1);
            return;
        }// end function

        private function textFieldChanged(param1:Boolean, param2:Boolean) : void
        {
            var _loc_3:Boolean = false;
            var _loc_4:Boolean = false;
            if (!param1)
            {
                _loc_3 = _text != textField.text;
                _text = textField.text;
            }
            _loc_4 = _htmlText != textField.htmlText;
            _htmlText = textField.htmlText;
            if (_loc_3)
            {
                dispatchEvent(new Event("textChanged"));
                if (param2)
                {
                    dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
                }
            }
            if (_loc_4)
            {
                dispatchEvent(new Event("htmlTextChanged"));
            }
            _textWidth = textField.textWidth;
            _textHeight = textField.textHeight;
            return;
        }// end function

        public function get text() : String
        {
            return _text;
        }// end function

        function createTextField(param1:int) : void
        {
            if (!textField)
            {
                textField = IUITextField(createInFontContext(UITextField));
                textField.autoSize = TextFieldAutoSize.NONE;
                textField.enabled = enabled;
                textField.ignorePadding = false;
                textField.multiline = false;
                textField.tabEnabled = true;
                textField.wordWrap = false;
                if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
                {
                    textField.styleName = this;
                }
                textField.addEventListener(Event.CHANGE, textField_changeHandler);
                textField.addEventListener(TextEvent.TEXT_INPUT, textField_textInputHandler);
                textField.addEventListener(Event.SCROLL, textField_scrollHandler);
                textField.addEventListener("textFieldStyleChange", textField_textFieldStyleChangeHandler);
                textField.addEventListener("textFormatChange", textField_textFormatChangeHandler);
                textField.addEventListener("textInsert", textField_textModifiedHandler);
                textField.addEventListener("textReplace", textField_textModifiedHandler);
                if (param1 == -1)
                {
                    addChild(DisplayObject(textField));
                }
                else
                {
                    addChildAt(DisplayObject(textField), param1);
                }
            }
            return;
        }// end function

        override public function get tabIndex() : int
        {
            return _tabIndex;
        }// end function

        override public function set accessibilityProperties(param1:AccessibilityProperties) : void
        {
            if (param1 == _accessibilityProperties)
            {
                return;
            }
            _accessibilityProperties = param1;
            accessibilityPropertiesChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function setSelection(param1:int, param2:int) : void
        {
            _selectionBeginIndex = param1;
            _selectionEndIndex = param2;
            selectionChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function get condenseWhite() : Boolean
        {
            return _condenseWhite;
        }// end function

        override protected function isOurFocus(param1:DisplayObject) : Boolean
        {
            if (param1 != textField)
            {
            }
            return super.isOurFocus(param1);
        }// end function

        public function get displayAsPassword() : Boolean
        {
            return _displayAsPassword;
        }// end function

        public function set data(param1:Object) : void
        {
            var _loc_2:* = undefined;
            _data = param1;
            if (_listData)
            {
                _loc_2 = _listData.label;
            }
            else if (_data != null)
            {
                if (_data is String)
                {
                    _loc_2 = String(_data);
                }
                else
                {
                    _loc_2 = _data.toString();
                }
            }
            if (_loc_2 !== undefined && !textSet)
            {
                text = _loc_2;
                textSet = false;
            }
            dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
            return;
        }// end function

        public function get selectionBeginIndex() : int
        {
            return textField ? (textField.selectionBeginIndex) : (_selectionBeginIndex);
        }// end function

        function get selectable() : Boolean
        {
            return _selectable;
        }// end function

        protected function createBorder() : void
        {
            var _loc_1:Class = null;
            if (!border)
            {
                _loc_1 = getStyle("borderSkin");
                if (_loc_1 != null)
                {
                    border = new _loc_1;
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

        public function get horizontalScrollPosition() : Number
        {
            return _horizontalScrollPosition;
        }// end function

        override protected function measure() : void
        {
            var _loc_2:Number = NaN;
            var _loc_3:Number = NaN;
            var _loc_4:TextLineMetrics = null;
            super.measure();
            if (border)
            {
            }
            var _loc_1:* = border is IRectangularBorder ? (IRectangularBorder(border).borderMetrics) : (EdgeMetrics.EMPTY);
            measuredWidth = DEFAULT_MEASURED_WIDTH;
            if (maxChars)
            {
                measuredWidth = Math.min(measuredWidth, measureText("W").width * maxChars + _loc_1.left + _loc_1.right + 8);
            }
            if (!text || text == "")
            {
                _loc_2 = DEFAULT_MEASURED_MIN_WIDTH;
                _loc_3 = measureText(" ").height + _loc_1.top + _loc_1.bottom + UITextField.TEXT_HEIGHT_PADDING;
                if (FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0)
                {
                    _loc_3 = _loc_3 + (getStyle("paddingTop") + getStyle("paddingBottom"));
                }
            }
            else
            {
                _loc_4 = measureText(text);
                _loc_2 = _loc_4.width + _loc_1.left + _loc_1.right + 8;
                _loc_3 = _loc_4.height + _loc_1.top + _loc_1.bottom + UITextField.TEXT_HEIGHT_PADDING;
                if (FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0)
                {
                    _loc_2 = _loc_2 + (getStyle("paddingLeft") + getStyle("paddingRight"));
                    _loc_3 = _loc_3 + (getStyle("paddingTop") + getStyle("paddingBottom"));
                }
            }
            measuredWidth = Math.max(_loc_2, measuredWidth);
            measuredHeight = Math.max(_loc_3, DEFAULT_MEASURED_HEIGHT);
            measuredMinWidth = DEFAULT_MEASURED_MIN_WIDTH;
            measuredMinHeight = DEFAULT_MEASURED_MIN_HEIGHT;
            return;
        }// end function

        public function get fontContext() : IFlexModuleFactory
        {
            return moduleFactory;
        }// end function

        public function set text(param1:String) : void
        {
            textSet = true;
            if (!param1)
            {
                param1 = "";
            }
            if (!isHTML && param1 == _text)
            {
                return;
            }
            _text = param1;
            textChanged = true;
            _htmlText = null;
            explicitHTMLText = null;
            invalidateProperties();
            invalidateSize();
            invalidateDisplayList();
            dispatchEvent(new Event("textChanged"));
            dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
            return;
        }// end function

        public function get selectionEndIndex() : int
        {
            return textField ? (textField.selectionEndIndex) : (_selectionEndIndex);
        }// end function

        public function get editable() : Boolean
        {
            return _editable;
        }// end function

        public function get listData() : BaseListData
        {
            return _listData;
        }// end function

        override protected function keyDownHandler(event:KeyboardEvent) : void
        {
            switch(event.keyCode)
            {
                case Keyboard.ENTER:
                {
                    dispatchEvent(new FlexEvent(FlexEvent.ENTER));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override protected function focusInHandler(event:FocusEvent) : void
        {
            var message:String;
            var event:* = event;
            if (event.target == this)
            {
                systemManager.stage.focus = TextField(textField);
            }
            var fm:* = focusManager;
            if (editable && fm)
            {
                fm.showFocusIndicator = true;
                if (textField.selectable && _selectionBeginIndex == _selectionEndIndex)
                {
                    textField.setSelection(0, textField.length);
                }
            }
            super.focusInHandler(event);
            if (_imeMode != null && _editable)
            {
                IME.enabled = true;
                prevMode = IME.conversionMode;
                try
                {
                    if (!errorCaught && IME.conversionMode != IMEConversionMode.UNKNOWN)
                    {
                        IME.conversionMode = _imeMode;
                    }
                    errorCaught = false;
                }
                catch (e:Error)
                {
                    errorCaught = true;
                    message = resourceManager.getString("controls", "unsupportedMode", [_imeMode]);
                    throw new Error(message);
                }
            }
            return;
        }// end function

        public function get htmlText() : String
        {
            return _htmlText;
        }// end function

        override public function set tabIndex(param1:int) : void
        {
            if (param1 == _tabIndex)
            {
                return;
            }
            _tabIndex = param1;
            tabIndexChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function set restrict(param1:String) : void
        {
            if (param1 == _restrict)
            {
                return;
            }
            _restrict = param1;
            restrictChanged = true;
            invalidateProperties();
            dispatchEvent(new Event("restrictChanged"));
            return;
        }// end function

        private function textField_textFieldStyleChangeHandler(event:Event) : void
        {
            textFieldChanged(true, false);
            return;
        }// end function

        private function textField_changeHandler(event:Event) : void
        {
            textFieldChanged(false, false);
            textChanged = false;
            htmlTextChanged = false;
            event.stopImmediatePropagation();
            dispatchEvent(new Event(Event.CHANGE));
            return;
        }// end function

        override public function set enabled(param1:Boolean) : void
        {
            if (param1 == enabled)
            {
                return;
            }
            super.enabled = param1;
            enabledChanged = true;
            invalidateProperties();
            if (border && border is IInvalidating)
            {
                IInvalidating(border).invalidateDisplayList();
            }
            return;
        }// end function

        override public function get baselinePosition() : Number
        {
            var _loc_1:String = null;
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                _loc_1 = text;
                if (_loc_1 == "")
                {
                    _loc_1 = " ";
                }
                if (border)
                {
                }
                return (border is IRectangularBorder ? (IRectangularBorder(border).borderMetrics.top) : (0)) + measureText(_loc_1).ascent;
            }
            if (!validateBaselinePosition())
            {
                return NaN;
            }
            return textField.y + textField.baselinePosition;
        }// end function

        public function set condenseWhite(param1:Boolean) : void
        {
            if (param1 == _condenseWhite)
            {
                return;
            }
            _condenseWhite = param1;
            condenseWhiteChanged = true;
            if (isHTML)
            {
                htmlTextChanged = true;
            }
            invalidateProperties();
            invalidateSize();
            invalidateDisplayList();
            dispatchEvent(new Event("condenseWhiteChanged"));
            return;
        }// end function

        public function get textWidth() : Number
        {
            return _textWidth;
        }// end function

        public function set displayAsPassword(param1:Boolean) : void
        {
            if (param1 == _displayAsPassword)
            {
                return;
            }
            _displayAsPassword = param1;
            displayAsPasswordChanged = true;
            invalidateProperties();
            invalidateSize();
            invalidateDisplayList();
            dispatchEvent(new Event("displayAsPasswordChanged"));
            return;
        }// end function

        function removeTextField() : void
        {
            if (textField)
            {
                textField.removeEventListener(Event.CHANGE, textField_changeHandler);
                textField.removeEventListener(TextEvent.TEXT_INPUT, textField_textInputHandler);
                textField.removeEventListener(Event.SCROLL, textField_scrollHandler);
                textField.removeEventListener("textFieldStyleChange", textField_textFieldStyleChangeHandler);
                textField.removeEventListener("textFormatChange", textField_textFormatChangeHandler);
                textField.removeEventListener("textInsert", textField_textModifiedHandler);
                textField.removeEventListener("textReplace", textField_textModifiedHandler);
                removeChild(DisplayObject(textField));
                textField = null;
            }
            return;
        }// end function

        public function get data() : Object
        {
            return _data;
        }// end function

        public function set maxChars(param1:int) : void
        {
            if (param1 == _maxChars)
            {
                return;
            }
            _maxChars = param1;
            maxCharsChanged = true;
            invalidateProperties();
            dispatchEvent(new Event("maxCharsChanged"));
            return;
        }// end function

        public function set horizontalScrollPosition(param1:Number) : void
        {
            if (param1 == _horizontalScrollPosition)
            {
                return;
            }
            _horizontalScrollPosition = param1;
            horizontalScrollPositionChanged = true;
            invalidateProperties();
            dispatchEvent(new Event("horizontalScrollPositionChanged"));
            return;
        }// end function

        override public function setFocus() : void
        {
            textField.setFocus();
            return;
        }// end function

        public function get restrict() : String
        {
            return _restrict;
        }// end function

        public function set fontContext(param1:IFlexModuleFactory) : void
        {
            this.moduleFactory = param1;
            return;
        }// end function

        public function set selectionBeginIndex(param1:int) : void
        {
            _selectionBeginIndex = param1;
            selectionChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function set selectionEndIndex(param1:int) : void
        {
            _selectionEndIndex = param1;
            selectionChanged = true;
            invalidateProperties();
            return;
        }// end function

        private function textField_scrollHandler(event:Event) : void
        {
            _horizontalScrollPosition = textField.scrollH;
            return;
        }// end function

        public function get textHeight() : Number
        {
            return _textHeight;
        }// end function

        public function set editable(param1:Boolean) : void
        {
            if (param1 == _editable)
            {
                return;
            }
            _editable = param1;
            editableChanged = true;
            invalidateProperties();
            dispatchEvent(new Event("editableChanged"));
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:int = 0;
            super.commitProperties();
            if (hasFontContextChanged() && textField != null)
            {
                _loc_1 = getChildIndex(DisplayObject(textField));
                removeTextField();
                createTextField(_loc_1);
                accessibilityPropertiesChanged = true;
                condenseWhiteChanged = true;
                displayAsPasswordChanged = true;
                enabledChanged = true;
                maxCharsChanged = true;
                restrictChanged = true;
                tabIndexChanged = true;
                textChanged = true;
                selectionChanged = true;
                horizontalScrollPositionChanged = true;
            }
            if (accessibilityPropertiesChanged)
            {
                textField.accessibilityProperties = _accessibilityProperties;
                accessibilityPropertiesChanged = false;
            }
            if (condenseWhiteChanged)
            {
                textField.condenseWhite = _condenseWhite;
                condenseWhiteChanged = false;
            }
            if (displayAsPasswordChanged)
            {
                textField.displayAsPassword = _displayAsPassword;
                displayAsPasswordChanged = false;
            }
            if (enabledChanged || editableChanged)
            {
                if (enabled)
                {
                }
                textField.type = _editable ? (TextFieldType.INPUT) : (TextFieldType.DYNAMIC);
                if (enabledChanged)
                {
                    if (textField.enabled != enabled)
                    {
                        textField.enabled = enabled;
                    }
                    enabledChanged = false;
                }
                selectableChanged = true;
                editableChanged = false;
            }
            if (selectableChanged)
            {
                if (_editable)
                {
                    textField.selectable = enabled;
                }
                else
                {
                    if (enabled)
                    {
                    }
                    textField.selectable = _selectable;
                }
                selectableChanged = false;
            }
            if (maxCharsChanged)
            {
                textField.maxChars = _maxChars;
                maxCharsChanged = false;
            }
            if (restrictChanged)
            {
                textField.restrict = _restrict;
                restrictChanged = false;
            }
            if (tabIndexChanged)
            {
                textField.tabIndex = _tabIndex;
                tabIndexChanged = false;
            }
            if (textChanged || htmlTextChanged)
            {
                if (isHTML)
                {
                    textField.htmlText = explicitHTMLText;
                }
                else
                {
                    textField.text = _text;
                }
                textFieldChanged(false, true);
                textChanged = false;
                htmlTextChanged = false;
            }
            if (selectionChanged)
            {
                textField.setSelection(_selectionBeginIndex, _selectionEndIndex);
                selectionChanged = false;
            }
            if (horizontalScrollPositionChanged)
            {
                textField.scrollH = _horizontalScrollPosition;
                horizontalScrollPositionChanged = false;
            }
            return;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            if (param1 != null)
            {
            }
            var _loc_2:* = param1 == "styleName";
            super.styleChanged(param1);
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

        private function get isHTML() : Boolean
        {
            return explicitHTMLText != null;
        }// end function

        public function get maxChars() : int
        {
            return _maxChars;
        }// end function

        public function get maxHorizontalScrollPosition() : Number
        {
            return textField ? (textField.maxScrollH) : (0);
        }// end function

        function set selectable(param1:Boolean) : void
        {
            if (_selectable == param1)
            {
                return;
            }
            _selectable = param1;
            selectableChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function get length() : int
        {
            return text != null ? (text.length) : (-1);
        }// end function

        public function set listData(param1:BaseListData) : void
        {
            _listData = param1;
            return;
        }// end function

        private function textField_textModifiedHandler(event:Event) : void
        {
            textFieldChanged(false, true);
            return;
        }// end function

        private function textField_textFormatChangeHandler(event:Event) : void
        {
            textFieldChanged(true, false);
            return;
        }// end function

        public function set htmlText(param1:String) : void
        {
            textSet = true;
            if (!param1)
            {
                param1 = "";
            }
            _htmlText = param1;
            htmlTextChanged = true;
            _text = null;
            explicitHTMLText = param1;
            invalidateProperties();
            invalidateSize();
            invalidateDisplayList();
            dispatchEvent(new Event("htmlTextChanged"));
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_3:EdgeMetrics = null;
            super.updateDisplayList(param1, param2);
            if (border)
            {
                border.setActualSize(param1, param2);
                _loc_3 = border is IRectangularBorder ? (IRectangularBorder(border).borderMetrics) : (EdgeMetrics.EMPTY);
            }
            else
            {
                _loc_3 = EdgeMetrics.EMPTY;
            }
            var _loc_4:* = getStyle("paddingLeft");
            var _loc_5:* = getStyle("paddingRight");
            var _loc_6:* = getStyle("paddingTop");
            var _loc_7:* = getStyle("paddingBottom");
            var _loc_8:* = _loc_3.left + _loc_3.right;
            var _loc_9:* = _loc_3.top + _loc_3.bottom + 1;
            textField.x = _loc_3.left;
            textField.y = _loc_3.top;
            if (FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0)
            {
                textField.x = textField.x + _loc_4;
                textField.y = textField.y + _loc_6;
                _loc_8 = _loc_8 + (_loc_4 + _loc_5);
                _loc_9 = _loc_9 + (_loc_6 + _loc_7);
            }
            textField.width = Math.max(0, param1 - _loc_8);
            textField.height = Math.max(0, param2 - _loc_9);
            return;
        }// end function

        public function getLineMetrics(param1:int) : TextLineMetrics
        {
            return textField ? (textField.getLineMetrics(param1)) : (null);
        }// end function

    }
}
