package mx.controls
{
    import flash.display.*;
    import flash.text.*;
    import mx.core.*;
    import mx.styles.*;

    public class ToolTip extends UIComponent implements IToolTip, IFontContextComponent
    {
        private var textChanged:Boolean;
        private var _text:String;
        protected var textField:IUITextField;
        var border:IFlexDisplayObject;
        static const VERSION:String = "3.2.0.3958";
        public static var maxWidth:Number = 300;

        public function ToolTip()
        {
            mouseEnabled = false;
            return;
        }// end function

        public function set fontContext(param1:IFlexModuleFactory) : void
        {
            this.moduleFactory = param1;
            return;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            super.styleChanged(param1);
            if (param1 == "borderStyle" || param1 == "styleName" || param1 == null)
            {
                invalidateDisplayList();
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:int = 0;
            var _loc_2:TextFormat = null;
            super.commitProperties();
            if (hasFontContextChanged() && textField != null)
            {
                _loc_1 = getChildIndex(DisplayObject(textField));
                removeTextField();
                createTextField(_loc_1);
                invalidateSize();
                textChanged = true;
            }
            if (textChanged)
            {
                _loc_2 = textField.getTextFormat();
                _loc_2.leftMargin = 0;
                _loc_2.rightMargin = 0;
                textField.defaultTextFormat = _loc_2;
                textField.text = _text;
                textChanged = false;
            }
            return;
        }// end function

        function getTextField() : IUITextField
        {
            return textField;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:Class = null;
            super.createChildren();
            if (!border)
            {
                _loc_1 = getStyle("borderSkin");
                border = new _loc_1;
                if (border is ISimpleStyleClient)
                {
                    ISimpleStyleClient(border).styleName = this;
                }
                addChild(DisplayObject(border));
            }
            createTextField(-1);
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_7:Number = NaN;
            super.measure();
            var _loc_1:* = borderMetrics;
            var _loc_2:* = _loc_1.left + getStyle("paddingLeft");
            var _loc_3:* = _loc_1.top + getStyle("paddingTop");
            var _loc_4:* = _loc_1.right + getStyle("paddingRight");
            var _loc_5:* = _loc_1.bottom + getStyle("paddingBottom");
            var _loc_6:* = _loc_2 + _loc_4;
            _loc_7 = _loc_3 + _loc_5;
            textField.wordWrap = false;
            if (textField.textWidth + _loc_6 > ToolTip.maxWidth)
            {
                textField.width = ToolTip.maxWidth - _loc_6;
                textField.wordWrap = true;
            }
            measuredWidth = textField.width + _loc_6;
            measuredHeight = textField.height + _loc_7;
            return;
        }// end function

        public function get fontContext() : IFlexModuleFactory
        {
            return moduleFactory;
        }// end function

        public function set text(param1:String) : void
        {
            _text = param1;
            textChanged = true;
            invalidateProperties();
            invalidateSize();
            invalidateDisplayList();
            return;
        }// end function

        public function get text() : String
        {
            return _text;
        }// end function

        function removeTextField() : void
        {
            if (textField)
            {
                removeChild(DisplayObject(textField));
                textField = null;
            }
            return;
        }// end function

        function createTextField(param1:int) : void
        {
            if (!textField)
            {
                textField = IUITextField(createInFontContext(UITextField));
                textField.autoSize = TextFieldAutoSize.LEFT;
                textField.mouseEnabled = false;
                textField.multiline = true;
                textField.selectable = false;
                textField.wordWrap = false;
                textField.styleName = this;
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

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = borderMetrics;
            var _loc_4:* = _loc_3.left + getStyle("paddingLeft");
            var _loc_5:* = _loc_3.top + getStyle("paddingTop");
            var _loc_6:* = _loc_3.right + getStyle("paddingRight");
            var _loc_7:* = _loc_3.bottom + getStyle("paddingBottom");
            var _loc_8:* = _loc_4 + _loc_6;
            var _loc_9:* = _loc_5 + _loc_7;
            border.setActualSize(param1, param2);
            textField.move(_loc_4, _loc_5);
            textField.setActualSize(param1 - _loc_8, param2 - _loc_9);
            return;
        }// end function

        private function get borderMetrics() : EdgeMetrics
        {
            if (border is IRectangularBorder)
            {
                return IRectangularBorder(border).borderMetrics;
            }
            return EdgeMetrics.EMPTY;
        }// end function

    }
}
