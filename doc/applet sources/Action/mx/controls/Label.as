package mx.controls
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import mx.controls.listClasses.*;
    import mx.core.*;
    import mx.events.*;

    public class Label extends UIComponent implements IDataRenderer, IDropInListItemRenderer, IListItemRenderer, IFontContextComponent
    {
        private var _selectable:Boolean = false;
        private var _text:String = "";
        private var _data:Object;
        var htmlTextChanged:Boolean = false;
        private var _tabIndex:int = -1;
        private var _textWidth:Number;
        private var explicitHTMLText:String = null;
        private var enabledChanged:Boolean = false;
        private var condenseWhiteChanged:Boolean = false;
        private var _listData:BaseListData;
        private var _textHeight:Number;
        protected var textField:IUITextField;
        private var _htmlText:String = "";
        private var _condenseWhite:Boolean = false;
        var textChanged:Boolean = false;
        public var truncateToFit:Boolean = true;
        private var textSet:Boolean;
        private var selectableChanged:Boolean;
        private var toolTipSet:Boolean = false;
        static const VERSION:String = "3.2.0.3958";

        public function Label()
        {
            tabChildren = true;
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
            return;
        }// end function

        private function textField_textFieldStyleChangeHandler(event:Event) : void
        {
            textFieldChanged(true);
            return;
        }// end function

        override public function get baselinePosition() : Number
        {
            var _loc_1:String = null;
            var _loc_2:TextLineMetrics = null;
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                if (!textField)
                {
                    return NaN;
                }
                validateNow();
                _loc_1 = isHTML ? (explicitHTMLText) : (text);
                if (_loc_1 == "")
                {
                    _loc_1 = " ";
                }
                _loc_2 = isHTML ? (measureHTMLText(_loc_1)) : (measureText(_loc_1));
                return textField.y + _loc_2.ascent;
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

        override protected function createChildren() : void
        {
            super.createChildren();
            if (!textField)
            {
                createTextField(-1);
            }
            return;
        }// end function

        function getTextField() : IUITextField
        {
            return textField;
        }// end function

        private function measureTextFieldBounds(param1:String) : Rectangle
        {
            var _loc_2:* = isHTML ? (measureHTMLText(param1)) : (measureText(param1));
            return new Rectangle(0, 0, _loc_2.width + UITextField.TEXT_WIDTH_PADDING, _loc_2.height + UITextField.TEXT_HEIGHT_PADDING);
        }// end function

        function getMinimumText(param1:String) : String
        {
            if (!param1 || param1.length < 2)
            {
                param1 = "Wj";
            }
            return param1;
        }// end function

        private function textFieldChanged(param1:Boolean) : void
        {
            var _loc_2:Boolean = false;
            var _loc_3:Boolean = false;
            if (!param1)
            {
                _loc_2 = _text != textField.text;
                _text = textField.text;
            }
            _loc_3 = _htmlText != textField.htmlText;
            _htmlText = textField.htmlText;
            if (_loc_2)
            {
                dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
            }
            if (_loc_3)
            {
                dispatchEvent(new Event("htmlTextChanged"));
            }
            _textWidth = textField.textWidth;
            _textHeight = textField.textHeight;
            return;
        }// end function

        public function get data() : Object
        {
            return _data;
        }// end function

        public function get text() : String
        {
            return _text;
        }// end function

        function removeTextField() : void
        {
            if (textField)
            {
                textField.removeEventListener("textFieldStyleChange", textField_textFieldStyleChangeHandler);
                textField.removeEventListener("textInsert", textField_textModifiedHandler);
                textField.removeEventListener("textReplace", textField_textModifiedHandler);
                removeChild(DisplayObject(textField));
                textField = null;
            }
            return;
        }// end function

        public function get textHeight() : Number
        {
            return _textHeight;
        }// end function

        function get styleSheet() : StyleSheet
        {
            return textField.styleSheet;
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

        override public function get tabIndex() : int
        {
            return _tabIndex;
        }// end function

        public function set fontContext(param1:IFlexModuleFactory) : void
        {
            this.moduleFactory = param1;
            return;
        }// end function

        override public function set toolTip(param1:String) : void
        {
            super.toolTip = param1;
            toolTipSet = param1 != null;
            return;
        }// end function

        function createTextField(param1:int) : void
        {
            if (!textField)
            {
                textField = IUITextField(createInFontContext(UITextField));
                textField.enabled = enabled;
                textField.ignorePadding = true;
                textField.selectable = selectable;
                textField.styleName = this;
                textField.addEventListener("textFieldStyleChange", textField_textFieldStyleChangeHandler);
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

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (hasFontContextChanged() && textField != null)
            {
                removeTextField();
                condenseWhiteChanged = true;
                enabledChanged = true;
                selectableChanged = true;
                textChanged = true;
            }
            if (!textField)
            {
                createTextField(-1);
            }
            if (condenseWhiteChanged)
            {
                textField.condenseWhite = _condenseWhite;
                condenseWhiteChanged = false;
            }
            textField.tabIndex = tabIndex;
            if (enabledChanged)
            {
                textField.enabled = enabled;
                enabledChanged = false;
            }
            if (selectableChanged)
            {
                textField.selectable = _selectable;
                selectableChanged = false;
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
                textFieldChanged(false);
                textChanged = false;
                htmlTextChanged = false;
            }
            return;
        }// end function

        public function get condenseWhite() : Boolean
        {
            return _condenseWhite;
        }// end function

        public function set listData(param1:BaseListData) : void
        {
            _listData = param1;
            return;
        }// end function

        private function get isHTML() : Boolean
        {
            return explicitHTMLText != null;
        }// end function

        public function get selectable() : Boolean
        {
            return _selectable;
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

        override protected function measure() : void
        {
            super.measure();
            var _loc_1:* = isHTML ? (explicitHTMLText) : (text);
            _loc_1 = getMinimumText(_loc_1);
            var _loc_2:* = measureTextFieldBounds(_loc_1);
            var _loc_3:* = _loc_2.width + getStyle("paddingLeft") + getStyle("paddingRight");
            measuredWidth = _loc_2.width + getStyle("paddingLeft") + getStyle("paddingRight");
            measuredMinWidth = _loc_3;
            var _loc_3:* = _loc_2.height + getStyle("paddingTop") + getStyle("paddingBottom");
            measuredHeight = _loc_2.height + getStyle("paddingTop") + getStyle("paddingBottom");
            measuredMinHeight = _loc_3;
            return;
        }// end function

        public function get fontContext() : IFlexModuleFactory
        {
            return moduleFactory;
        }// end function

        private function textField_textModifiedHandler(event:Event) : void
        {
            textFieldChanged(false);
            return;
        }// end function

        public function get listData() : BaseListData
        {
            return _listData;
        }// end function

        function set styleSheet(param1:StyleSheet) : void
        {
            textField.styleSheet = param1;
            return;
        }// end function

        public function set htmlText(param1:String) : void
        {
            textSet = true;
            if (!param1)
            {
                param1 = "";
            }
            if (isHTML && param1 == explicitHTMLText)
            {
                return;
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
            var _loc_9:Boolean = false;
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("paddingLeft");
            var _loc_4:* = getStyle("paddingTop");
            var _loc_5:* = getStyle("paddingRight");
            var _loc_6:* = getStyle("paddingBottom");
            textField.setActualSize(param1 - _loc_3 - _loc_5, param2 - _loc_4 - _loc_6);
            textField.x = _loc_3;
            textField.y = _loc_4;
            var _loc_7:* = isHTML ? (explicitHTMLText) : (text);
            var _loc_8:* = measureTextFieldBounds(_loc_7);
            if (truncateToFit)
            {
                if (isHTML)
                {
                    _loc_9 = _loc_8.width > textField.width;
                }
                else
                {
                    textField.text = _text;
                    _loc_9 = textField.truncateToFit();
                }
                if (!toolTipSet)
                {
                    super.toolTip = _loc_9 ? (text) : (null);
                }
            }
            return;
        }// end function

        public function get htmlText() : String
        {
            return _htmlText;
        }// end function

        public function getLineMetrics(param1:int) : TextLineMetrics
        {
            return textField ? (textField.getLineMetrics(param1)) : (null);
        }// end function

        override public function set tabIndex(param1:int) : void
        {
            _tabIndex = param1;
            invalidateProperties();
            return;
        }// end function

    }
}
