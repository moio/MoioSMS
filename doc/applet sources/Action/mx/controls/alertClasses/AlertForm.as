package mx.controls.alertClasses
{
    import flash.display.*;
    import flash.events.*;
    import flash.ui.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.managers.*;

    public class AlertForm extends UIComponent implements IFontContextComponent
    {
        var buttons:Array;
        private var icon:DisplayObject;
        var textField:IUITextField;
        var defaultButton:Button;
        private var textWidth:Number;
        private var defaultButtonChanged:Boolean = false;
        private var textHeight:Number;
        static const VERSION:String = "3.2.0.3958";

        public function AlertForm()
        {
            buttons = [];
            tabChildren = true;
            return;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            var _loc_2:String = null;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            super.styleChanged(param1);
            if (!param1 || param1 == "styleName" || param1 == "buttonStyleName")
            {
                if (buttons)
                {
                    _loc_2 = getStyle("buttonStyleName");
                    _loc_3 = buttons.length;
                    _loc_4 = 0;
                    while (_loc_4 < _loc_3)
                    {
                        
                        buttons[_loc_4].styleName = _loc_2;
                        _loc_4++;
                    }
                }
            }
            return;
        }// end function

        public function set fontContext(param1:IFlexModuleFactory) : void
        {
            this.moduleFactory = param1;
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:int = 0;
            var _loc_2:ISystemManager = null;
            super.commitProperties();
            if (hasFontContextChanged() && textField != null)
            {
                _loc_1 = getChildIndex(DisplayObject(textField));
                removeTextField();
                createTextField(_loc_1);
            }
            if (defaultButtonChanged && defaultButton)
            {
                defaultButtonChanged = false;
                Alert(parent).defaultButton = defaultButton;
                if (parent is IFocusManagerContainer)
                {
                    _loc_2 = Alert(parent).systemManager;
                    _loc_2.activate(IFocusManagerContainer(parent));
                }
                defaultButton.setFocus();
            }
            return;
        }// end function

        private function createButton(param1:String, param2:String) : Button
        {
            var _loc_3:* = new Button();
            _loc_3.label = param1;
            _loc_3.name = param2;
            var _loc_4:* = getStyle("buttonStyleName");
            if (getStyle("buttonStyleName"))
            {
                _loc_3.styleName = _loc_4;
            }
            _loc_3.addEventListener(MouseEvent.CLICK, clickHandler);
            _loc_3.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
            _loc_3.owner = parent;
            addChild(_loc_3);
            _loc_3.setActualSize(Alert.buttonWidth, Alert.buttonHeight);
            buttons.push(_loc_3);
            return _loc_3;
        }// end function

        override protected function resourcesChanged() : void
        {
            var _loc_1:Button = null;
            super.resourcesChanged();
            _loc_1 = Button(getChildByName("OK"));
            if (_loc_1)
            {
                _loc_1.label = String(Alert.okLabel);
            }
            _loc_1 = Button(getChildByName("CANCEL"));
            if (_loc_1)
            {
                _loc_1.label = String(Alert.cancelLabel);
            }
            _loc_1 = Button(getChildByName("YES"));
            if (_loc_1)
            {
                _loc_1.label = String(Alert.yesLabel);
            }
            _loc_1 = Button(getChildByName("NO"));
            if (_loc_1)
            {
                _loc_1.label = String(Alert.noLabel);
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_5:String = null;
            var _loc_6:Button = null;
            super.createChildren();
            createTextField(-1);
            var _loc_1:* = Alert(parent).iconClass;
            if (_loc_1 && !icon)
            {
                icon = new _loc_1;
                addChild(icon);
            }
            var _loc_2:* = Alert(parent);
            var _loc_3:* = _loc_2.buttonFlags;
            var _loc_4:* = _loc_2.defaultButtonFlag;
            if (_loc_3 & Alert.OK)
            {
                _loc_5 = String(Alert.okLabel);
                _loc_6 = createButton(_loc_5, "OK");
                if (_loc_4 == Alert.OK)
                {
                    defaultButton = _loc_6;
                }
            }
            if (_loc_3 & Alert.YES)
            {
                _loc_5 = String(Alert.yesLabel);
                _loc_6 = createButton(_loc_5, "YES");
                if (_loc_4 == Alert.YES)
                {
                    defaultButton = _loc_6;
                }
            }
            if (_loc_3 & Alert.NO)
            {
                _loc_5 = String(Alert.noLabel);
                _loc_6 = createButton(_loc_5, "NO");
                if (_loc_4 == Alert.NO)
                {
                    defaultButton = _loc_6;
                }
            }
            if (_loc_3 & Alert.CANCEL)
            {
                _loc_5 = String(Alert.cancelLabel);
                _loc_6 = createButton(_loc_5, "CANCEL");
                if (_loc_4 == Alert.CANCEL)
                {
                    defaultButton = _loc_6;
                }
            }
            if (!defaultButton && buttons.length)
            {
                defaultButton = buttons[0];
            }
            if (defaultButton)
            {
                defaultButtonChanged = true;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            var _loc_1:* = Alert(parent).title;
            var _loc_2:* = Alert(parent).getTitleTextField().getUITextFormat().measureText(_loc_1);
            var _loc_3:* = Math.max(buttons.length, 2);
            var _loc_4:* = _loc_3 * buttons[0].width + _loc_3-- * 8;
            var _loc_5:* = Math.max(_loc_4, _loc_2.width);
            textField.width = 2 * _loc_5;
            textWidth = textField.textWidth + UITextField.TEXT_WIDTH_PADDING;
            var _loc_6:* = Math.max(_loc_5, textWidth);
            _loc_6 = Math.min(_loc_6, 2 * _loc_5);
            if (textWidth < _loc_6 && textField.multiline == true)
            {
                textField.multiline = false;
                textField.wordWrap = false;
            }
            else if (textField.multiline == false)
            {
                textField.wordWrap = true;
                textField.multiline = true;
            }
            _loc_6 = _loc_6 + 16;
            if (icon)
            {
                _loc_6 = _loc_6 + (icon.width + 8);
            }
            textHeight = textField.textHeight + UITextField.TEXT_HEIGHT_PADDING;
            var _loc_7:* = textHeight;
            if (icon)
            {
                _loc_7 = Math.max(_loc_7, icon.height);
            }
            _loc_7 = Math.min(_loc_7, screen.height * 0.75);
            _loc_7 = _loc_7 + (buttons[0].height + 3 * 8);
            measuredWidth = _loc_6;
            measuredHeight = _loc_7;
            return;
        }// end function

        public function get fontContext() : IFlexModuleFactory
        {
            return moduleFactory;
        }// end function

        private function clickHandler(event:MouseEvent) : void
        {
            var _loc_2:* = Button(event.currentTarget).name;
            removeAlert(_loc_2);
            return;
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

        override protected function keyDownHandler(event:KeyboardEvent) : void
        {
            var _loc_2:* = Alert(parent).buttonFlags;
            if (event.keyCode == Keyboard.ESCAPE)
            {
                if (_loc_2 & Alert.CANCEL || !(_loc_2 & Alert.NO))
                {
                    removeAlert("CANCEL");
                }
                else if (_loc_2 & Alert.NO)
                {
                    removeAlert("NO");
                }
            }
            return;
        }// end function

        function createTextField(param1:int) : void
        {
            if (!textField)
            {
                textField = IUITextField(createInFontContext(UITextField));
                textField.styleName = this;
                textField.text = Alert(parent).text;
                textField.multiline = true;
                textField.wordWrap = true;
                textField.selectable = true;
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
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            super.updateDisplayList(param1, param2);
            _loc_4 = param2 - buttons[0].height;
            _loc_5 = buttons.length * (buttons[0].width + 8) - 8;
            _loc_3 = (param1 - _loc_5) / 2;
            var _loc_6:int = 0;
            while (_loc_6 < buttons.length)
            {
                
                buttons[_loc_6].move(_loc_3, _loc_4);
                buttons[_loc_6].tabIndex = _loc_6 + 1;
                _loc_3 = _loc_3 + (buttons[_loc_6].width + 8);
                _loc_6++;
            }
            _loc_5 = textWidth;
            if (icon)
            {
                _loc_5 = _loc_5 + (icon.width + 8);
            }
            _loc_3 = (param1 - _loc_5) / 2;
            if (icon)
            {
                icon.x = _loc_3;
                icon.y = (_loc_4 - icon.height) / 2;
                _loc_3 = _loc_3 + (icon.width + 8);
            }
            var _loc_7:* = textField.getExplicitOrMeasuredHeight();
            textField.move(_loc_3, (_loc_4 - _loc_7) / 2);
            textField.setActualSize(textWidth + 5, _loc_7);
            return;
        }// end function

        private function removeAlert(param1:String) : void
        {
            var _loc_2:* = Alert(parent);
            _loc_2.visible = false;
            var _loc_3:* = new CloseEvent(CloseEvent.CLOSE);
            if (param1 == "YES")
            {
                _loc_3.detail = Alert.YES;
            }
            else if (param1 == "NO")
            {
                _loc_3.detail = Alert.NO;
            }
            else if (param1 == "OK")
            {
                _loc_3.detail = Alert.OK;
            }
            else if (param1 == "CANCEL")
            {
                _loc_3.detail = Alert.CANCEL;
            }
            _loc_2.dispatchEvent(_loc_3);
            PopUpManager.removePopUp(_loc_2);
            return;
        }// end function

    }
}
