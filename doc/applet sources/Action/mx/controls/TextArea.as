package mx.controls
{
    import flash.accessibility.*;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.text.*;
    import mx.controls.listClasses.*;
    import mx.core.*;
    import mx.events.*;

    public class TextArea extends ScrollControlBase implements IDataRenderer, IDropInListItemRenderer, IFocusManagerComponent, IIMESupport, IListItemRenderer, IFontContextComponent
    {
        private var _text:String = "";
        private var _selectable:Boolean = true;
        private var _textWidth:Number;
        private var _restrict:String = null;
        private var htmlTextChanged:Boolean = false;
        private var _maxChars:int = 0;
        private var enabledChanged:Boolean = false;
        private var _condenseWhite:Boolean = false;
        private var accessibilityPropertiesChanged:Boolean = false;
        private var _hScrollPosition:Number;
        private var _textHeight:Number;
        private var displayAsPasswordChanged:Boolean = false;
        private var prevMode:String = "UNKNOWN";
        private var selectableChanged:Boolean = false;
        private var restrictChanged:Boolean = false;
        private var selectionChanged:Boolean = false;
        private var maxCharsChanged:Boolean = false;
        private var _tabIndex:int = -1;
        private var errorCaught:Boolean = false;
        private var _selectionBeginIndex:int = 0;
        private var wordWrapChanged:Boolean = false;
        private var _data:Object;
        private var explicitHTMLText:String = null;
        private var styleSheetChanged:Boolean = false;
        private var tabIndexChanged:Boolean = false;
        private var editableChanged:Boolean = false;
        private var _editable:Boolean = true;
        private var allowScrollEvent:Boolean = true;
        private var _imeMode:String = null;
        private var condenseWhiteChanged:Boolean = false;
        protected var textField:IUITextField;
        private var _listData:BaseListData;
        private var _displayAsPassword:Boolean = false;
        private var _wordWrap:Boolean = true;
        private var _styleSheet:StyleSheet;
        private var textChanged:Boolean = false;
        private var _accessibilityProperties:AccessibilityProperties;
        private var _selectionEndIndex:int = 0;
        private var _htmlText:String = "";
        private var _vScrollPosition:Number;
        private var textSet:Boolean;
        static const VERSION:String = "3.2.0.3958";

        public function TextArea()
        {
            tabChildren = true;
            _horizontalScrollPolicy = ScrollPolicy.AUTO;
            _verticalScrollPolicy = ScrollPolicy.AUTO;
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
            var _loc_2:* = focusManager;
            if (_loc_2)
            {
                _loc_2.defaultButtonEnabled = true;
            }
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
            createTextField(-1);
            return;
        }// end function

        private function adjustScrollBars() : void
        {
            var _loc_1:* = textField.bottomScrollV - textField.scrollV + 1;
            var _loc_2:* = textField.numLines;
            setScrollBarProperties(textField.width + textField.maxScrollH, textField.width, textField.numLines, _loc_1);
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

        private function textField_ioErrorHandler(event:IOErrorEvent) : void
        {
            return;
        }// end function

        public function get text() : String
        {
            return _text;
        }// end function

        public function get styleSheet() : StyleSheet
        {
            return _styleSheet;
        }// end function

        function createTextField(param1:int) : void
        {
            if (!textField)
            {
                textField = IUITextField(createInFontContext(UITextField));
                textField.autoSize = TextFieldAutoSize.NONE;
                textField.enabled = enabled;
                textField.ignorePadding = true;
                textField.multiline = true;
                textField.selectable = true;
                textField.styleName = this;
                textField.tabEnabled = true;
                textField.type = TextFieldType.INPUT;
                textField.useRichTextClipboard = true;
                textField.wordWrap = true;
                textField.addEventListener(Event.CHANGE, textField_changeHandler);
                textField.addEventListener(Event.SCROLL, textField_scrollHandler);
                textField.addEventListener(IOErrorEvent.IO_ERROR, textField_ioErrorHandler);
                textField.addEventListener(TextEvent.TEXT_INPUT, textField_textInputHandler);
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

        public function get selectionBeginIndex() : int
        {
            return textField ? (textField.selectionBeginIndex) : (_selectionBeginIndex);
        }// end function

        public function get selectable() : Boolean
        {
            return _selectable;
        }// end function

        override public function set verticalScrollPosition(param1:Number) : void
        {
            super.verticalScrollPosition = param1;
            _vScrollPosition = param1;
            if (textField)
            {
                textField.scrollV = param1 + 1;
                textField.background = false;
            }
            else
            {
                invalidateProperties();
            }
            return;
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

        public function set styleSheet(param1:StyleSheet) : void
        {
            _styleSheet = param1;
            styleSheetChanged = true;
            htmlTextChanged = true;
            invalidateProperties();
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            measuredMinWidth = DEFAULT_MEASURED_MIN_WIDTH;
            measuredWidth = DEFAULT_MEASURED_WIDTH;
            var _loc_1:* = 2 * DEFAULT_MEASURED_MIN_HEIGHT;
            measuredHeight = 2 * DEFAULT_MEASURED_MIN_HEIGHT;
            measuredMinHeight = _loc_1;
            return;
        }// end function

        public function get fontContext() : IFlexModuleFactory
        {
            return moduleFactory;
        }// end function

        public function get selectionEndIndex() : int
        {
            return textField ? (textField.selectionEndIndex) : (_selectionEndIndex);
        }// end function

        public function get editable() : Boolean
        {
            return _editable;
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
            }
            if (fm)
            {
                fm.defaultButtonEnabled = false;
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

        public function get listData() : BaseListData
        {
            return _listData;
        }// end function

        public function get wordWrap() : Boolean
        {
            return _wordWrap;
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

        public function get htmlText() : String
        {
            return _htmlText;
        }// end function

        override public function set enabled(param1:Boolean) : void
        {
            if (param1 == enabled)
            {
                return;
            }
            super.enabled = param1;
            enabledChanged = true;
            if (verticalScrollBar)
            {
                verticalScrollBar.enabled = param1;
            }
            if (horizontalScrollBar)
            {
                horizontalScrollBar.enabled = param1;
            }
            invalidateProperties();
            if (border && border is IInvalidating)
            {
                IInvalidating(border).invalidateDisplayList();
            }
            return;
        }// end function

        private function textField_textFieldStyleChangeHandler(event:Event) : void
        {
            textFieldChanged(true, false);
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

        override public function get baselinePosition() : Number
        {
            var _loc_1:String = null;
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                _loc_1 = text;
                if (!_loc_1 || _loc_1 == "")
                {
                    _loc_1 = " ";
                }
                return viewMetrics.top + measureText(_loc_1).ascent;
            }
            if (!validateBaselinePosition())
            {
                return NaN;
            }
            return textField.y + textField.baselinePosition;
        }// end function

        private function textField_changeHandler(event:Event) : void
        {
            textFieldChanged(false, false);
            adjustScrollBars();
            textChanged = false;
            htmlTextChanged = false;
            event.stopImmediatePropagation();
            dispatchEvent(new Event(Event.CHANGE));
            return;
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

        override public function get horizontalScrollPolicy() : String
        {
            return height <= 40 ? (ScrollPolicy.OFF) : (_horizontalScrollPolicy);
        }// end function

        public function get data() : Object
        {
            return _data;
        }// end function

        override public function get maxVerticalScrollPosition() : Number
        {
            return textField ? (textField.maxScrollV--) : (0);
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

        public function set selectable(param1:Boolean) : void
        {
            if (param1 == selectable)
            {
                return;
            }
            _selectable = param1;
            selectableChanged = true;
            invalidateProperties();
            return;
        }// end function

        override public function set horizontalScrollPosition(param1:Number) : void
        {
            super.horizontalScrollPosition = param1;
            _hScrollPosition = param1;
            if (textField)
            {
                textField.scrollH = param1;
                textField.background = false;
            }
            else
            {
                invalidateProperties();
            }
            return;
        }// end function

        override public function setFocus() : void
        {
            var _loc_1:* = verticalScrollPosition;
            allowScrollEvent = false;
            textField.setFocus();
            verticalScrollPosition = _loc_1;
            allowScrollEvent = true;
            return;
        }// end function

        public function set selectionBeginIndex(param1:int) : void
        {
            _selectionBeginIndex = param1;
            selectionChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function get restrict() : String
        {
            return _restrict;
        }// end function

        override protected function scrollHandler(event:Event) : void
        {
            if (event is ScrollEvent)
            {
                if (!liveScrolling && ScrollEvent(event).detail == ScrollEventDetail.THUMB_TRACK)
                {
                    return;
                }
                super.scrollHandler(event);
                textField.scrollH = horizontalScrollPosition;
                textField.scrollV = verticalScrollPosition + 1;
                _vScrollPosition = textField.scrollV--;
                _hScrollPosition = textField.scrollH;
            }
            return;
        }// end function

        public function set fontContext(param1:IFlexModuleFactory) : void
        {
            this.moduleFactory = param1;
            return;
        }// end function

        function removeTextField() : void
        {
            if (textField)
            {
                textField.removeEventListener(Event.CHANGE, textField_changeHandler);
                textField.removeEventListener(Event.SCROLL, textField_scrollHandler);
                textField.removeEventListener(IOErrorEvent.IO_ERROR, textField_ioErrorHandler);
                textField.removeEventListener(TextEvent.TEXT_INPUT, textField_textInputHandler);
                textField.removeEventListener("textFieldStyleChange", textField_textFieldStyleChangeHandler);
                textField.removeEventListener("textFormatChange", textField_textFormatChangeHandler);
                textField.removeEventListener("textInsert", textField_textModifiedHandler);
                textField.removeEventListener("textReplace", textField_textModifiedHandler);
                removeChild(DisplayObject(textField));
                textField = null;
            }
            return;
        }// end function

        public function set selectionEndIndex(param1:int) : void
        {
            _selectionEndIndex = param1;
            selectionChanged = true;
            invalidateProperties();
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
            super.commitProperties();
            if (hasFontContextChanged() && textField != null)
            {
                removeTextField();
                createTextField(-1);
                accessibilityPropertiesChanged = true;
                condenseWhiteChanged = true;
                displayAsPasswordChanged = true;
                editableChanged = true;
                enabledChanged = true;
                maxCharsChanged = true;
                restrictChanged = true;
                selectableChanged = true;
                tabIndexChanged = true;
                wordWrapChanged = true;
                textChanged = true;
                selectionChanged = true;
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
            if (editableChanged)
            {
                if (_editable)
                {
                }
                textField.type = enabled ? (TextFieldType.INPUT) : (TextFieldType.DYNAMIC);
                editableChanged = false;
            }
            if (enabledChanged)
            {
                textField.enabled = enabled;
                enabledChanged = false;
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
            if (selectableChanged)
            {
                textField.selectable = _selectable;
                selectableChanged = false;
            }
            if (styleSheetChanged)
            {
                textField.styleSheet = _styleSheet;
                styleSheetChanged = false;
            }
            if (tabIndexChanged)
            {
                textField.tabIndex = _tabIndex;
                tabIndexChanged = false;
            }
            if (wordWrapChanged)
            {
                textField.wordWrap = _wordWrap;
                wordWrapChanged = false;
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
            if (!isNaN(_hScrollPosition))
            {
                horizontalScrollPosition = _hScrollPosition;
            }
            if (!isNaN(_vScrollPosition))
            {
                verticalScrollPosition = _vScrollPosition;
            }
            return;
        }// end function

        private function get isHTML() : Boolean
        {
            return explicitHTMLText != null;
        }// end function

        public function set listData(param1:BaseListData) : void
        {
            _listData = param1;
            return;
        }// end function

        public function get maxChars() : int
        {
            return _maxChars;
        }// end function

        override public function get maxHorizontalScrollPosition() : Number
        {
            return textField ? (textField.maxScrollH) : (0);
        }// end function

        override protected function mouseWheelHandler(event:MouseEvent) : void
        {
            event.stopPropagation();
            return;
        }// end function

        private function textField_scrollHandler(event:Event) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:ScrollEvent = null;
            if (initialized && allowScrollEvent)
            {
                _loc_2 = textField.scrollH - horizontalScrollPosition;
                _loc_3 = textField.scrollV-- - verticalScrollPosition;
                horizontalScrollPosition = textField.scrollH;
                verticalScrollPosition = textField.scrollV--;
                if (_loc_2)
                {
                    _loc_4 = new ScrollEvent(ScrollEvent.SCROLL, false, false, null, horizontalScrollPosition, ScrollEventDirection.HORIZONTAL, _loc_2);
                    dispatchEvent(_loc_4);
                }
                if (_loc_3)
                {
                    _loc_4 = new ScrollEvent(ScrollEvent.SCROLL, false, false, null, verticalScrollPosition, ScrollEventDirection.VERTICAL, _loc_3);
                    dispatchEvent(_loc_4);
                }
            }
            return;
        }// end function

        public function set wordWrap(param1:Boolean) : void
        {
            if (param1 == _wordWrap)
            {
                return;
            }
            _wordWrap = param1;
            wordWrapChanged = true;
            invalidateProperties();
            invalidateDisplayList();
            dispatchEvent(new Event("wordWrapChanged"));
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
            super.updateDisplayList(param1, param2);
            var _loc_3:* = viewMetrics;
            _loc_3.left = _loc_3.left + getStyle("paddingLeft");
            _loc_3.top = _loc_3.top + getStyle("paddingTop");
            _loc_3.right = _loc_3.right + getStyle("paddingRight");
            _loc_3.bottom = _loc_3.bottom + getStyle("paddingBottom");
            textField.move(_loc_3.left, _loc_3.top);
            var _loc_4:* = param1 - _loc_3.left - _loc_3.right;
            var _loc_5:* = param2 - _loc_3.top - _loc_3.bottom;
            if (_loc_3.top + _loc_3.bottom > 0)
            {
            }
            textField.setActualSize(Math.max(4, _loc_4), Math.max(4, _loc_5++));
            if (!initialized)
            {
                callLater(invalidateDisplayList);
            }
            else
            {
                callLater(adjustScrollBars);
            }
            if (isNaN(_hScrollPosition))
            {
                _hScrollPosition = 0;
            }
            if (isNaN(_vScrollPosition))
            {
                _vScrollPosition = 0;
            }
            var _loc_6:* = Math.min(textField.maxScrollH, _hScrollPosition);
            if (Math.min(textField.maxScrollH, _hScrollPosition) != textField.scrollH)
            {
                horizontalScrollPosition = _loc_6;
            }
            _loc_6 = Math.min(textField.maxScrollV--, _vScrollPosition);
            if (_loc_6 != textField.scrollV--)
            {
                verticalScrollPosition = _loc_6;
            }
            return;
        }// end function

        public function getLineMetrics(param1:int) : TextLineMetrics
        {
            return textField ? (textField.getLineMetrics(param1)) : (null);
        }// end function

        override public function get verticalScrollPolicy() : String
        {
            return height <= 40 ? (ScrollPolicy.OFF) : (_verticalScrollPolicy);
        }// end function

        public function get length() : int
        {
            return text != null ? (text.length) : (-1);
        }// end function

    }
}
