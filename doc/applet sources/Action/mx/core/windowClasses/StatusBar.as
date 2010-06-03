package mx.core.windowClasses
{
    import flash.display.*;
    import mx.core.*;
    import mx.styles.*;

    public class StatusBar extends UIComponent
    {
        private var statusChanged:Boolean = false;
        public var statusTextField:IUITextField;
        var statusBarBackground:IFlexDisplayObject;
        private var _status:String = "";
        static const VERSION:String = "3.2.0.3958";

        public function StatusBar() : void
        {
            return;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            var _loc_3:Class = null;
            var _loc_4:IStyleClient = null;
            var _loc_5:ISimpleStyleClient = null;
            super.styleChanged(param1);
            invalidateDisplayList();
            if (param1)
            {
            }
            var _loc_2:* = param1 == "styleName";
            if (_loc_2 || param1 == "statusBarBackgroundSkin")
            {
                _loc_3 = getStyle("statusBarBackgroundSkin");
                if (_loc_3)
                {
                    if (statusBarBackground)
                    {
                        removeChild(DisplayObject(statusBarBackground));
                        statusBarBackground = null;
                    }
                    statusBarBackground = new _loc_3;
                    _loc_4 = statusBarBackground as IStyleClient;
                    if (_loc_4)
                    {
                        _loc_4.setStyle("backgroundImage", undefined);
                    }
                    _loc_5 = statusBarBackground as ISimpleStyleClient;
                    if (_loc_5)
                    {
                        _loc_5.styleName = this;
                    }
                    addChildAt(DisplayObject(statusBarBackground), 0);
                }
            }
            if (_loc_2 || param1 == "statusTextStyleName")
            {
                if (statusTextField)
                {
                    statusTextField.styleName = getStyle("statusTextStyleName");
                }
            }
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            statusTextField.validateNow();
            if (statusTextField.textHeight == 0)
            {
                statusTextField.text = " ";
                statusTextField.validateNow();
            }
            measuredHeight = statusTextField.textHeight + UITextField.TEXT_HEIGHT_PADDING;
            measuredWidth = statusTextField.textWidth;
            return;
        }// end function

        public function set status(param1:String) : void
        {
            _status = param1;
            statusChanged = true;
            invalidateProperties();
            invalidateSize();
            return;
        }// end function

        public function get status() : String
        {
            return _status;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            statusBarBackground.setActualSize(param1, param2);
            statusTextField.text = _status;
            statusTextField.width = param1;
            statusTextField.truncateToFit("...");
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (statusChanged)
            {
                statusTextField.text = _status;
                statusChanged = false;
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_2:IStyleClient = null;
            var _loc_3:ISimpleStyleClient = null;
            super.createChildren();
            var _loc_1:* = getStyle("statusBarBackgroundSkin");
            if (_loc_1)
            {
                statusBarBackground = new _loc_1;
                _loc_2 = statusBarBackground as IStyleClient;
                if (_loc_2)
                {
                    _loc_2.setStyle("backgroundImage", undefined);
                }
                _loc_3 = statusBarBackground as ISimpleStyleClient;
                if (_loc_3)
                {
                    _loc_3.styleName = this;
                }
                addChild(DisplayObject(statusBarBackground));
            }
            if (!statusTextField)
            {
                statusTextField = IUITextField(createInFontContext(UITextField));
                statusTextField.text = _status;
                statusTextField.styleName = getStyle("statusTextStyleName");
                statusTextField.enabled = true;
                addChild(DisplayObject(statusTextField));
            }
            return;
        }// end function

    }
}
