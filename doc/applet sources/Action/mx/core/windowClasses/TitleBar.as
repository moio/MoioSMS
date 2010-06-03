package mx.core.windowClasses
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.system.*;
    import flash.text.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.styles.*;

    public class TitleBar extends UIComponent
    {
        public var closeButton:Button;
        private var minimizeButtonSkin:Class;
        var titleIconObject:Object;
        public var titleTextField:IUITextField;
        private var _title:String = "";
        private var titleIconChanged:Boolean = false;
        public var maximizeButton:Button;
        private var closeButtonSkin:Class;
        var titleBarBackground:IFlexDisplayObject;
        public var minimizeButton:Button;
        private var _titleIcon:Class;
        private var maximizeButtonSkin:Class;
        private var titleChanged:Boolean = false;
        private var restoreButtonSkin:Class;
        static const VERSION:String = "3.2.0.3958";

        public function TitleBar() : void
        {
            doubleClickEnabled = true;
            addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
            addEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler);
            return;
        }// end function

        protected function placeButtons(param1:String, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void
        {
            var _loc_7:* = getStyle("buttonPadding");
            var _loc_8:* = getStyle("titleBarButtonPadding");
            minimizeButton.setActualSize(minimizeButton.measuredWidth, minimizeButton.measuredHeight);
            maximizeButton.setActualSize(maximizeButton.measuredWidth, maximizeButton.measuredHeight);
            closeButton.setActualSize(closeButton.measuredWidth, closeButton.measuredHeight);
            if (param1 == "right")
            {
                minimizeButton.move(param2 - (minimizeButton.measuredWidth + maximizeButton.measuredWidth + closeButton.measuredWidth + 2 * _loc_7) - param6 - _loc_8, (param3 - minimizeButton.measuredHeight) / 2);
                maximizeButton.move(param2 - (maximizeButton.measuredWidth + closeButton.measuredWidth + _loc_7) - param6 - _loc_8, (param3 - maximizeButton.measuredHeight) / 2);
                closeButton.move(param2 - closeButton.measuredWidth - param6 - _loc_8, (param3 - closeButton.measuredHeight) / 2);
            }
            else
            {
                _loc_8 = Math.max(_loc_8, param4);
                closeButton.move(_loc_8, (param3 - closeButton.measuredHeight) / 2);
                minimizeButton.move(_loc_7 + _loc_8 + closeButton.measuredWidth, (param3 - minimizeButton.measuredHeight) / 2);
                maximizeButton.move(_loc_8 + _loc_7 * 2 + closeButton.measuredWidth + minimizeButton.measuredWidth, (param3 - maximizeButton.measuredHeight) / 2);
            }
            return;
        }// end function

        private function minimizeButton_clickHandler(event:Event) : void
        {
            window.minimize();
            return;
        }// end function

        private function measureChromeText(param1:IUITextField) : Rectangle
        {
            var _loc_2:Number = 20;
            var _loc_3:Number = 14;
            if (param1 && param1.text)
            {
                param1.validateNow();
                _loc_2 = param1.textWidth;
                _loc_3 = param1.textHeight;
            }
            return new Rectangle(0, 0, _loc_2, _loc_3);
        }// end function

        override protected function createChildren() : void
        {
            var _loc_2:IStyleClient = null;
            var _loc_3:ISimpleStyleClient = null;
            super.createChildren();
            var _loc_1:* = getStyle("titleBarBackgroundSkin");
            if (_loc_1)
            {
                if (!titleBarBackground)
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
                    addChild(DisplayObject(titleBarBackground));
                }
            }
            if (!titleTextField)
            {
                titleTextField = IUITextField(createInFontContext(UITextField));
                titleTextField.text = _title;
                titleTextField.styleName = getStyle("titleTextStyleName");
                titleTextField.enabled = true;
                addChild(DisplayObject(titleTextField));
            }
            if (!titleIconObject && _titleIcon)
            {
                titleIconObject = new _titleIcon();
                addChild(DisplayObject(titleIconObject));
            }
            if (!minimizeButton)
            {
                minimizeButton = new Button();
                minimizeButtonSkin = getStyle("minimizeButtonSkin");
                if (minimizeButtonSkin)
                {
                    minimizeButton.setStyle("skin", minimizeButtonSkin);
                }
                minimizeButton.focusEnabled = false;
                minimizeButton.enabled = window.minimizable;
                minimizeButton.addEventListener(MouseEvent.MOUSE_DOWN, button_mouseDownHandler);
                minimizeButton.addEventListener(MouseEvent.CLICK, minimizeButton_clickHandler);
                addChild(minimizeButton);
            }
            if (!maximizeButton)
            {
                maximizeButton = new Button();
                maximizeButtonSkin = getStyle("maximizeButtonSkin");
                if (maximizeButtonSkin)
                {
                    maximizeButton.setStyle("skin", maximizeButtonSkin);
                }
                maximizeButton.focusEnabled = false;
                maximizeButton.enabled = window.maximizable;
                maximizeButton.addEventListener(MouseEvent.MOUSE_DOWN, button_mouseDownHandler);
                maximizeButton.addEventListener(MouseEvent.CLICK, maximizeButton_clickHandler);
                addChild(maximizeButton);
                restoreButtonSkin = isMac() ? (null) : (getStyle("restoreButtonSkin"));
            }
            if (!closeButton)
            {
                closeButton = new Button();
                closeButtonSkin = getStyle("closeButtonSkin");
                if (closeButtonSkin)
                {
                    closeButton.setStyle("skin", closeButtonSkin);
                }
                closeButton.focusEnabled = false;
                closeButton.addEventListener(MouseEvent.MOUSE_DOWN, button_mouseDownHandler);
                closeButton.addEventListener(MouseEvent.CLICK, closeButton_clickHandler);
                addChild(closeButton);
            }
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
            if (_loc_2 || param1 == "titleBarBackgroundSkin")
            {
                _loc_3 = getStyle("titleBarBackgroundSkin");
                if (_loc_3)
                {
                    if (titleBarBackground)
                    {
                        removeChild(DisplayObject(titleBarBackground));
                        titleBarBackground = null;
                    }
                    titleBarBackground = new _loc_3;
                    _loc_4 = titleBarBackground as IStyleClient;
                    if (_loc_4)
                    {
                        _loc_4.setStyle("backgroundImage", undefined);
                    }
                    _loc_5 = titleBarBackground as ISimpleStyleClient;
                    if (_loc_5)
                    {
                        _loc_5.styleName = this;
                    }
                    addChildAt(DisplayObject(titleBarBackground), 0);
                }
            }
            if (_loc_2 || param1 == "titleTextStyleName")
            {
                if (titleTextField)
                {
                    titleTextField.styleName = getStyle("titleTextStyleName");
                }
            }
            if (_loc_2 || param1 == "closeButtonSkin")
            {
                closeButtonSkin = getStyle("closeButtonSkin");
                if (closeButtonSkin && closeButton)
                {
                    closeButton.setStyle("skin", closeButtonSkin);
                }
            }
            if (_loc_2 || param1 == "maximizeButtonSkin")
            {
                maximizeButtonSkin = getStyle("maximizeButtonSkin");
                if (maximizeButtonSkin && maximizeButton)
                {
                    maximizeButton.setStyle("skin", maximizeButtonSkin);
                }
            }
            if (_loc_2 || param1 == "minimizeButtonSkin")
            {
                minimizeButtonSkin = getStyle("minimizeButtonSkin");
                if (minimizeButtonSkin && minimizeButton)
                {
                    minimizeButton.setStyle("skin", minimizeButtonSkin);
                }
            }
            if (_loc_2 || param1 == "restoreButtonSkin")
            {
                restoreButtonSkin = getStyle("restoreButtonSkin");
            }
            return;
        }// end function

        private function closeButton_clickHandler(event:Event) : void
        {
            window.close();
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (titleChanged)
            {
                titleTextField.text = _title;
                titleChanged = false;
            }
            if (titleIconChanged)
            {
                if (titleIconObject)
                {
                    removeChild(DisplayObject(titleIconObject));
                    titleIconObject = null;
                }
                if (_titleIcon)
                {
                    titleIconObject = new _titleIcon();
                    addChild(DisplayObject(titleIconObject));
                }
                titleIconChanged = false;
            }
            return;
        }// end function

        protected function doubleClickHandler(event:MouseEvent) : void
        {
            if (isMac())
            {
                window.minimize();
            }
            else if (window.nativeWindow.displayState == NativeWindowDisplayState.MAXIMIZED)
            {
                window.restore();
            }
            else
            {
                window.maximize();
            }
            return;
        }// end function

        public function get title() : String
        {
            return _title;
        }// end function

        private function maximizeButton_clickHandler(event:Event) : void
        {
            if (window.nativeWindow.displayState == NativeWindowDisplayState.MAXIMIZED)
            {
                window.restore();
            }
            else
            {
                window.maximize();
                maximizeButton.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT));
            }
            return;
        }// end function

        private function button_mouseDownHandler(event:MouseEvent) : void
        {
            event.stopPropagation();
            return;
        }// end function

        public function set titleIcon(param1:Class) : void
        {
            _titleIcon = param1;
            titleIconChanged = true;
            invalidateProperties();
            invalidateSize();
            return;
        }// end function

        private function mouseDownHandler(event:MouseEvent) : void
        {
            window.nativeWindow.startMove();
            event.stopPropagation();
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            titleTextField.validateNow();
            if (titleTextField.textHeight == 0)
            {
                titleTextField.text = " ";
                titleTextField.validateNow();
            }
            measuredHeight = Math.max(titleTextField.textHeight + UITextField.TEXT_HEIGHT_PADDING, Math.max(maximizeButton.measuredHeight, minimizeButton.measuredHeight, closeButton.measuredHeight) + 12);
            measuredWidth = titleTextField.width + maximizeButton.measuredWidth + minimizeButton.measuredWidth + closeButton.measuredWidth;
            if (titleIconObject)
            {
                measuredHeight = Math.max(measuredHeight, titleIconObject.height + 1);
                measuredWidth = measuredWidth + titleIconObject.width;
            }
            return;
        }// end function

        public function set title(param1:String) : void
        {
            _title = param1;
            titleChanged = true;
            invalidateProperties();
            invalidateSize();
            invalidateDisplayList();
            return;
        }// end function

        public function get titleIcon() : Class
        {
            return _titleIcon;
        }// end function

        protected function placeTitle(param1:String, param2:Number, param3:Number, param4:String) : void
        {
            var _loc_6:TextFormat = null;
            titleTextField.text = _title;
            titleTextField.validateNow();
            var _loc_5:* = titleTextField.getLineMetrics(0).width / titleTextField.length;
            if (param1 == "left")
            {
                if (param4 == "left")
                {
                    titleTextField.setActualSize(width - param2 - param3 - 2 - Math.max(closeButton.x + closeButton.measuredWidth, minimizeButton.x + minimizeButton.measuredWidth, maximizeButton.x + maximizeButton.measuredWidth), measureChromeText(titleTextField).height + UITextField.TEXT_HEIGHT_PADDING);
                    titleTextField.move(param2 + Math.max(closeButton.x + closeButton.measuredWidth, minimizeButton.x + minimizeButton.measuredWidth, maximizeButton.x + maximizeButton.measuredWidth), (height - (measureChromeText(titleTextField).height + UITextField.TEXT_HEIGHT_PADDING)) / 2);
                    titleTextField.truncateToFit();
                }
                else
                {
                    titleTextField.setActualSize(Math.max(0, Math.min(width - param2 - param3, minimizeButton.x)) - 2, measureChromeText(titleTextField).height + UITextField.TEXT_HEIGHT_PADDING);
                    titleTextField.move(param2, (height - (measureChromeText(titleTextField).height + UITextField.TEXT_HEIGHT_PADDING)) / 2);
                    titleTextField.truncateToFit();
                }
            }
            else
            {
                _loc_6 = new TextFormat();
                _loc_6.align = TextFormatAlign.CENTER;
                titleTextField.setTextFormat(_loc_6);
                if (param4 == "left")
                {
                    titleTextField.setActualSize(width - param2 - param3 - Math.max(closeButton.x + closeButton.measuredWidth, minimizeButton.x + minimizeButton.measuredWidth, maximizeButton.x + maximizeButton.measuredWidth) - 2, measureChromeText(titleTextField).height + UITextField.TEXT_HEIGHT_PADDING);
                    titleTextField.move(Math.max(closeButton.x + closeButton.measuredWidth, minimizeButton.x + minimizeButton.measuredWidth, maximizeButton.x + maximizeButton.measuredWidth), (height - (measureChromeText(titleTextField).height + UITextField.TEXT_HEIGHT_PADDING)) / 2);
                    titleTextField.truncateToFit();
                }
                else
                {
                    titleTextField.setActualSize(width - param2 - param3 - (width - Math.min(closeButton.x, minimizeButton.x, maximizeButton.x)) - 2, measureChromeText(titleTextField).height + UITextField.TEXT_HEIGHT_PADDING);
                    titleTextField.move(param2, (height - (measureChromeText(titleTextField).height + UITextField.TEXT_HEIGHT_PADDING)) / 2);
                    titleTextField.truncateToFit();
                }
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            super.updateDisplayList(param1, param2);
            if (window.nativeWindow.closed)
            {
                return;
            }
            var _loc_3:Number = 0;
            var _loc_4:Number = 5;
            var _loc_5:* = getStyle("cornerRadius") / 2;
            if (titleBarBackground)
            {
                titleBarBackground.move(0, 0);
                IFlexDisplayObject(titleBarBackground).setActualSize(param1, param2);
            }
            if (titleIconObject)
            {
                _loc_8 = titleIconObject.height;
                _loc_9 = (height - _loc_8) / 2;
                titleIconObject.move(_loc_5, _loc_9);
                _loc_3 = _loc_3 + (_loc_5 + titleIconObject.width + getStyle("buttonPadding"));
            }
            if (!isMac())
            {
                if (window.nativeWindow.displayState == NativeWindowDisplayState.MAXIMIZED)
                {
                    if (restoreButtonSkin)
                    {
                        maximizeButton.setStyle("skin", restoreButtonSkin);
                    }
                }
                else
                {
                    maximizeButton.setStyle("skin", maximizeButtonSkin);
                }
            }
            var _loc_6:* = getStyle("buttonAlignment");
            if (getStyle("buttonAlignment") == "right")
            {
                placeButtons(_loc_6, width, height, _loc_3, _loc_4, _loc_5);
            }
            else if (_loc_6 == "left")
            {
                placeButtons(_loc_6, width, height, _loc_3, _loc_4, _loc_5);
            }
            else if (isMac())
            {
                _loc_6 = "left";
                placeButtons("left", width, height, _loc_3, _loc_4, _loc_5);
            }
            else
            {
                placeButtons("right", width, height, _loc_3, _loc_4, _loc_5);
            }
            var _loc_7:* = String(getStyle("titleAlignment"));
            if (String(getStyle("titleAlignment")) == "center" || _loc_7 == "left")
            {
                placeTitle(_loc_7, _loc_3, _loc_4, _loc_6);
            }
            else if (isMac())
            {
                placeTitle("center", _loc_3, _loc_4, _loc_6);
            }
            else
            {
                placeTitle("left", _loc_3, _loc_4, _loc_6);
            }
            return;
        }// end function

        private function get window() : IWindow
        {
            return IWindow(parent);
        }// end function

        private static function isMac() : Boolean
        {
            return Capabilities.os.substring(0, 3) == "Mac";
        }// end function

    }
}
