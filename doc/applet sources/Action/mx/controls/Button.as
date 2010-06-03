package mx.controls
{
    import flash.display.*;
    import flash.events.*;
    import flash.ui.*;
    import flash.utils.*;
    import mx.controls.dataGridClasses.*;
    import mx.controls.listClasses.*;
    import mx.core.*;
    import mx.events.*;
    import mx.styles.*;

    public class Button extends UIComponent implements IDataRenderer, IDropInListItemRenderer, IFocusManagerComponent, IListItemRenderer, IFontContextComponent, IButton
    {
        var _emphasized:Boolean = false;
        var extraSpacing:Number = 20;
        private var icons:Array;
        public var selectedField:String = null;
        private var labelChanged:Boolean = false;
        private var skinMeasuredWidth:Number;
        var checkedDefaultSkin:Boolean = false;
        private var autoRepeatTimer:Timer;
        var disabledIconName:String = "disabledIcon";
        var disabledSkinName:String = "disabledSkin";
        var checkedDefaultIcon:Boolean = false;
        public var stickyHighlighting:Boolean = false;
        private var enabledChanged:Boolean = false;
        var selectedUpIconName:String = "selectedUpIcon";
        var selectedUpSkinName:String = "selectedUpSkin";
        var upIconName:String = "upIcon";
        var upSkinName:String = "upSkin";
        var centerContent:Boolean = true;
        var buttonOffset:Number = 0;
        private var skinMeasuredHeight:Number;
        private var oldUnscaledWidth:Number;
        var downIconName:String = "downIcon";
        var _labelPlacement:String = "right";
        var downSkinName:String = "downSkin";
        var _toggle:Boolean = false;
        private var _phase:String = "up";
        private var toolTipSet:Boolean = false;
        private var _data:Object;
        var currentIcon:IFlexDisplayObject;
        var currentSkin:IFlexDisplayObject;
        var overIconName:String = "overIcon";
        var selectedDownIconName:String = "selectedDownIcon";
        var overSkinName:String = "overSkin";
        var iconName:String = "icon";
        var skinName:String = "skin";
        var selectedDownSkinName:String = "selectedDownSkin";
        private var skins:Array;
        private var selectedSet:Boolean;
        private var _autoRepeat:Boolean = false;
        private var styleChangedFlag:Boolean = true;
        var selectedOverIconName:String = "selectedOverIcon";
        private var _listData:BaseListData;
        var selectedOverSkinName:String = "selectedOverSkin";
        protected var textField:IUITextField;
        private var labelSet:Boolean;
        var defaultIconUsesStates:Boolean = false;
        var defaultSkinUsesStates:Boolean = false;
        var toggleChanged:Boolean = false;
        private var emphasizedChanged:Boolean = false;
        private var _label:String = "";
        var _selected:Boolean = false;
        var selectedDisabledIconName:String = "selectedDisabledIcon";
        var selectedDisabledSkinName:String = "selectedDisabledSkin";
        static var createAccessibilityImplementation:Function;
        static var TEXT_WIDTH_PADDING:Number = 6;
        static const VERSION:String = "3.2.0.3958";

        public function Button()
        {
            skins = [];
            icons = [];
            mouseChildren = false;
            addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
            addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
            addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
            addEventListener(MouseEvent.CLICK, clickHandler);
            return;
        }// end function

        private function previousVersion_measure() : void
        {
            var bm:EdgeMetrics;
            var lineMetrics:TextLineMetrics;
            var paddingLeft:Number;
            var paddingRight:Number;
            var paddingTop:Number;
            var paddingBottom:Number;
            var horizontalGap:Number;
            super.measure();
            var textWidth:Number;
            var textHeight:Number;
            if (label)
            {
                lineMetrics = measureText(label);
                textWidth = lineMetrics.width;
                textHeight = lineMetrics.height;
                paddingLeft = getStyle("paddingLeft");
                paddingRight = getStyle("paddingRight");
                paddingTop = getStyle("paddingTop");
                paddingBottom = getStyle("paddingBottom");
                textWidth = textWidth + (paddingLeft + paddingRight + getStyle("textIndent"));
                textHeight = textHeight + (paddingTop + paddingBottom);
            }
            try
            {
                bm = currentSkin["borderMetrics"];
            }
            catch (e:Error)
            {
                bm = new EdgeMetrics(3, 3, 3, 3);
            }
            var tempCurrentIcon:* = getCurrentIcon();
            var iconWidth:* = tempCurrentIcon ? (tempCurrentIcon.width) : (0);
            var iconHeight:* = tempCurrentIcon ? (tempCurrentIcon.height) : (0);
            var w:Number;
            var h:Number;
            if (labelPlacement == ButtonLabelPlacement.LEFT || labelPlacement == ButtonLabelPlacement.RIGHT)
            {
                w = textWidth + iconWidth;
                if (iconWidth != 0)
                {
                    horizontalGap = getStyle("horizontalGap");
                    w = w + (horizontalGap - 2);
                }
                h = Math.max(textHeight, iconHeight + 6);
            }
            else
            {
                w = Math.max(textWidth, iconWidth);
                h = textHeight + iconHeight;
                if (iconHeight != 0)
                {
                    h = h + getStyle("verticalGap");
                }
            }
            if (bm)
            {
                w = w + (bm.left + bm.right);
                h = h + (bm.top + bm.bottom);
            }
            if (label && label.length != 0)
            {
                w = w + extraSpacing;
            }
            else
            {
                w = w + 6;
            }
            if (currentSkin && isNaN(skinMeasuredWidth) || isNaN(skinMeasuredHeight))
            {
                skinMeasuredWidth = currentSkin.measuredWidth;
                skinMeasuredHeight = currentSkin.measuredHeight;
            }
            if (!isNaN(skinMeasuredWidth))
            {
                w = Math.max(skinMeasuredWidth, w);
            }
            if (!isNaN(skinMeasuredHeight))
            {
                h = Math.max(skinMeasuredHeight, h);
            }
            var _loc_2:* = w;
            measuredWidth = w;
            measuredMinWidth = _loc_2;
            var _loc_2:* = h;
            measuredHeight = h;
            measuredMinHeight = _loc_2;
            return;
        }// end function

        public function get label() : String
        {
            return _label;
        }// end function

        function getCurrentIconName() : String
        {
            var _loc_1:String = null;
            if (!enabled)
            {
                _loc_1 = selected ? (selectedDisabledIconName) : (disabledIconName);
            }
            else if (phase == ButtonPhase.UP)
            {
                _loc_1 = selected ? (selectedUpIconName) : (upIconName);
            }
            else if (phase == ButtonPhase.OVER)
            {
                _loc_1 = selected ? (selectedOverIconName) : (overIconName);
            }
            else if (phase == ButtonPhase.DOWN)
            {
                _loc_1 = selected ? (selectedDownIconName) : (downIconName);
            }
            return _loc_1;
        }// end function

        protected function mouseUpHandler(event:MouseEvent) : void
        {
            if (!enabled)
            {
                return;
            }
            phase = ButtonPhase.OVER;
            buttonReleased();
            if (!toggle)
            {
                event.updateAfterEvent();
            }
            return;
        }// end function

        override protected function adjustFocusRect(param1:DisplayObject = null) : void
        {
            super.adjustFocusRect(!currentSkin ? (DisplayObject(currentIcon)) : (this));
            return;
        }// end function

        function set phase(param1:String) : void
        {
            _phase = param1;
            invalidateSize();
            invalidateDisplayList();
            return;
        }// end function

        function viewIconForPhase(param1:String) : IFlexDisplayObject
        {
            var _loc_3:IFlexDisplayObject = null;
            var _loc_4:Boolean = false;
            var _loc_5:String = null;
            var _loc_2:* = Class(getStyle(param1));
            if (!_loc_2)
            {
                _loc_2 = Class(getStyle(iconName));
                if (defaultIconUsesStates)
                {
                    param1 = iconName;
                }
                if (!checkedDefaultIcon && _loc_2)
                {
                    _loc_3 = IFlexDisplayObject(new _loc_2);
                    if (!(_loc_3 is IProgrammaticSkin) && _loc_3 is IStateClient)
                    {
                        defaultIconUsesStates = true;
                        param1 = iconName;
                    }
                    if (_loc_3)
                    {
                        checkedDefaultIcon = true;
                    }
                }
            }
            _loc_3 = IFlexDisplayObject(getChildByName(param1));
            if (_loc_3 == null)
            {
                if (_loc_2 != null)
                {
                    _loc_3 = IFlexDisplayObject(new _loc_2);
                    _loc_3.name = param1;
                    if (_loc_3 is ISimpleStyleClient)
                    {
                        ISimpleStyleClient(_loc_3).styleName = this;
                    }
                    addChild(DisplayObject(_loc_3));
                    _loc_4 = false;
                    if (_loc_3 is IInvalidating)
                    {
                        IInvalidating(_loc_3).validateNow();
                        _loc_4 = true;
                    }
                    else if (_loc_3 is IProgrammaticSkin)
                    {
                        IProgrammaticSkin(_loc_3).validateDisplayList();
                        _loc_4 = true;
                    }
                    if (_loc_3 && _loc_3 is IUIComponent)
                    {
                        IUIComponent(_loc_3).enabled = enabled;
                    }
                    if (_loc_4)
                    {
                        _loc_3.setActualSize(_loc_3.measuredWidth, _loc_3.measuredHeight);
                    }
                    icons.push(_loc_3);
                }
            }
            if (currentIcon != null)
            {
                currentIcon.visible = false;
            }
            currentIcon = _loc_3;
            if (defaultIconUsesStates && currentIcon is IStateClient)
            {
                _loc_5 = "";
                if (!enabled)
                {
                    _loc_5 = selected ? ("selectedDisabled") : ("disabled");
                }
                else if (phase == ButtonPhase.UP)
                {
                    _loc_5 = selected ? ("selectedUp") : ("up");
                }
                else if (phase == ButtonPhase.OVER)
                {
                    _loc_5 = selected ? ("selectedOver") : ("over");
                }
                else if (phase == ButtonPhase.DOWN)
                {
                    _loc_5 = selected ? ("selectedDown") : ("down");
                }
                IStateClient(currentIcon).currentState = _loc_5;
            }
            if (currentIcon != null)
            {
                currentIcon.visible = true;
            }
            return _loc_3;
        }// end function

        function viewSkinForPhase(param1:String, param2:String) : void
        {
            var _loc_4:IFlexDisplayObject = null;
            var _loc_5:Number = NaN;
            var _loc_6:ISimpleStyleClient = null;
            var _loc_3:* = Class(getStyle(param1));
            if (!_loc_3)
            {
                _loc_3 = Class(getStyle(skinName));
                if (defaultSkinUsesStates)
                {
                    param1 = skinName;
                }
                if (!checkedDefaultSkin && _loc_3)
                {
                    _loc_4 = IFlexDisplayObject(new _loc_3);
                    if (!(_loc_4 is IProgrammaticSkin) && _loc_4 is IStateClient)
                    {
                        defaultSkinUsesStates = true;
                        param1 = skinName;
                    }
                    if (_loc_4)
                    {
                        checkedDefaultSkin = true;
                    }
                }
            }
            _loc_4 = IFlexDisplayObject(getChildByName(param1));
            if (!_loc_4)
            {
                if (_loc_3)
                {
                    _loc_4 = IFlexDisplayObject(new _loc_3);
                    _loc_4.name = param1;
                    _loc_6 = _loc_4 as ISimpleStyleClient;
                    if (_loc_6)
                    {
                        _loc_6.styleName = this;
                    }
                    addChild(DisplayObject(_loc_4));
                    _loc_4.setActualSize(unscaledWidth, unscaledHeight);
                    if (_loc_4 is IInvalidating && initialized)
                    {
                        IInvalidating(_loc_4).validateNow();
                    }
                    else if (_loc_4 is IProgrammaticSkin && initialized)
                    {
                        IProgrammaticSkin(_loc_4).validateDisplayList();
                    }
                    skins.push(_loc_4);
                }
            }
            if (currentSkin)
            {
                currentSkin.visible = false;
            }
            currentSkin = _loc_4;
            if (defaultSkinUsesStates && currentSkin is IStateClient)
            {
                IStateClient(currentSkin).currentState = param2;
            }
            if (currentSkin)
            {
                currentSkin.visible = true;
            }
            if (enabled)
            {
                if (phase == ButtonPhase.OVER)
                {
                    _loc_5 = textField.getStyle("textRollOverColor");
                }
                else if (phase == ButtonPhase.DOWN)
                {
                    _loc_5 = textField.getStyle("textSelectedColor");
                }
                else
                {
                    _loc_5 = textField.getStyle("color");
                }
                textField.setColor(_loc_5);
            }
            return;
        }// end function

        function getTextField() : IUITextField
        {
            return textField;
        }// end function

        protected function rollOverHandler(event:MouseEvent) : void
        {
            if (phase == ButtonPhase.UP)
            {
                if (event.buttonDown)
                {
                    return;
                }
                phase = ButtonPhase.OVER;
                event.updateAfterEvent();
            }
            else if (phase == ButtonPhase.OVER)
            {
                phase = ButtonPhase.DOWN;
                event.updateAfterEvent();
                if (autoRepeatTimer)
                {
                    autoRepeatTimer.start();
                }
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            if (!textField)
            {
                textField = IUITextField(createInFontContext(UITextField));
                textField.styleName = this;
                addChild(DisplayObject(textField));
            }
            return;
        }// end function

        function setSelected(param1:Boolean, param2:Boolean = false) : void
        {
            if (_selected != param1)
            {
                _selected = param1;
                invalidateDisplayList();
                if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
                {
                    if (toggle)
                    {
                        dispatchEvent(new Event(Event.CHANGE));
                    }
                }
                else if (toggle && !param2)
                {
                    dispatchEvent(new Event(Event.CHANGE));
                }
                dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
            }
            return;
        }// end function

        private function autoRepeatTimer_timerDelayHandler(event:Event) : void
        {
            if (!enabled)
            {
                return;
            }
            dispatchEvent(new FlexEvent(FlexEvent.BUTTON_DOWN));
            if (autoRepeat)
            {
                autoRepeatTimer.reset();
                autoRepeatTimer.removeEventListener(TimerEvent.TIMER, autoRepeatTimer_timerDelayHandler);
                autoRepeatTimer.delay = getStyle("repeatInterval");
                autoRepeatTimer.addEventListener(TimerEvent.TIMER, autoRepeatTimer_timerHandler);
                autoRepeatTimer.start();
            }
            return;
        }// end function

        public function get autoRepeat() : Boolean
        {
            return _autoRepeat;
        }// end function

        public function set selected(param1:Boolean) : void
        {
            selectedSet = true;
            setSelected(param1, true);
            return;
        }// end function

        override protected function focusOutHandler(event:FocusEvent) : void
        {
            super.focusOutHandler(event);
            if (phase != ButtonPhase.UP)
            {
                phase = ButtonPhase.UP;
            }
            return;
        }// end function

        public function get labelPlacement() : String
        {
            return _labelPlacement;
        }// end function

        public function set autoRepeat(param1:Boolean) : void
        {
            _autoRepeat = param1;
            if (param1)
            {
                autoRepeatTimer = new Timer(1);
            }
            else
            {
                autoRepeatTimer = null;
            }
            return;
        }// end function

        function changeIcons() : void
        {
            var _loc_1:* = icons.length;
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1)
            {
                
                removeChild(icons[_loc_2]);
                _loc_2++;
            }
            icons = [];
            checkedDefaultIcon = false;
            defaultIconUsesStates = false;
            return;
        }// end function

        public function set data(param1:Object) : void
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            _data = param1;
            if (_listData && _listData is DataGridListData && DataGridListData(_listData).dataField != null)
            {
                _loc_2 = _data[DataGridListData(_listData).dataField];
                _loc_3 = "";
            }
            else if (_listData)
            {
                if (selectedField)
                {
                    _loc_2 = _data[selectedField];
                }
                _loc_3 = _listData.label;
            }
            else
            {
                _loc_2 = _data;
            }
            if (_loc_2 !== undefined && !selectedSet)
            {
                selected = _loc_2 as Boolean;
                selectedSet = false;
            }
            if (_loc_3 !== undefined && !labelSet)
            {
                label = _loc_3;
                labelSet = false;
            }
            dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
            return;
        }// end function

        function getCurrentIcon() : IFlexDisplayObject
        {
            var _loc_1:* = getCurrentIconName();
            if (!_loc_1)
            {
                return null;
            }
            return viewIconForPhase(_loc_1);
        }// end function

        public function get fontContext() : IFlexModuleFactory
        {
            return moduleFactory;
        }// end function

        public function get emphasized() : Boolean
        {
            return _emphasized;
        }// end function

        public function get listData() : BaseListData
        {
            return _listData;
        }// end function

        function layoutContents(param1:Number, param2:Number, param3:Boolean) : void
        {
            var _loc_20:TextLineMetrics = null;
            var _loc_28:MoveEvent = null;
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                previousVersion_layoutContents(param1, param2, param3);
                return;
            }
            var _loc_4:Number = 0;
            var _loc_5:Number = 0;
            var _loc_6:Number = 0;
            var _loc_7:Number = 0;
            var _loc_8:Number = 0;
            var _loc_9:Number = 0;
            var _loc_10:Number = 0;
            var _loc_11:Number = 0;
            var _loc_12:Number = 0;
            var _loc_13:Number = 0;
            var _loc_14:* = getStyle("paddingLeft");
            var _loc_15:* = getStyle("paddingRight");
            var _loc_16:* = getStyle("paddingTop");
            var _loc_17:* = getStyle("paddingBottom");
            var _loc_18:Number = 0;
            var _loc_19:Number = 0;
            if (label)
            {
                _loc_20 = measureText(label);
                _loc_18 = _loc_20.width + TEXT_WIDTH_PADDING;
                _loc_19 = _loc_20.height + UITextField.TEXT_HEIGHT_PADDING;
            }
            else
            {
                _loc_20 = measureText("Wj");
                _loc_19 = _loc_20.height + UITextField.TEXT_HEIGHT_PADDING;
            }
            var _loc_21:* = param3 ? (buttonOffset) : (0);
            var _loc_22:* = getStyle("textAlign");
            var _loc_23:* = param1;
            var _loc_24:* = param2;
            if (currentSkin && currentSkin is IBorder)
            {
            }
            var _loc_25:* = !(currentSkin is IFlexAsset) ? (IBorder(currentSkin).borderMetrics) : (null);
            if (!(currentSkin is IFlexAsset) ? (IBorder(currentSkin).borderMetrics) : (null))
            {
                _loc_23 = _loc_23 - (_loc_25.left + _loc_25.right);
                _loc_24 = _loc_24 - (_loc_25.top + _loc_25.bottom);
            }
            if (currentIcon)
            {
                _loc_8 = currentIcon.width;
                _loc_9 = currentIcon.height;
            }
            if (labelPlacement == ButtonLabelPlacement.LEFT || labelPlacement == ButtonLabelPlacement.RIGHT)
            {
                _loc_12 = getStyle("horizontalGap");
                if (_loc_8 == 0 || _loc_18 == 0)
                {
                    _loc_12 = 0;
                }
                if (_loc_18 > 0)
                {
                    var _loc_29:* = Math.max(Math.min(_loc_23 - _loc_8 - _loc_12 - _loc_14 - _loc_15, _loc_18), 0);
                    _loc_4 = Math.max(Math.min(_loc_23 - _loc_8 - _loc_12 - _loc_14 - _loc_15, _loc_18), 0);
                    textField.width = _loc_29;
                }
                else
                {
                    var _loc_29:int = 0;
                    _loc_4 = 0;
                    textField.width = _loc_29;
                }
                var _loc_29:* = Math.min(_loc_24, _loc_19);
                _loc_5 = Math.min(_loc_24, _loc_19);
                textField.height = _loc_29;
                if (_loc_22 == "left")
                {
                    _loc_6 = _loc_6 + _loc_14;
                }
                else if (_loc_22 == "right")
                {
                    _loc_6 = _loc_6 + (_loc_23 - _loc_4 - _loc_8 - _loc_12 - _loc_15);
                }
                else
                {
                    _loc_6 = _loc_6 + ((_loc_23 - _loc_4 - _loc_8 - _loc_12 - _loc_14 - _loc_15) / 2 + _loc_14);
                }
                if (labelPlacement == ButtonLabelPlacement.RIGHT)
                {
                    _loc_6 = _loc_6 + (_loc_8 + _loc_12);
                    _loc_10 = _loc_6 - (_loc_8 + _loc_12);
                }
                else
                {
                    _loc_10 = _loc_6 + _loc_4 + _loc_12;
                }
                _loc_11 = (_loc_24 - _loc_9 - _loc_16 - _loc_17) / 2 + _loc_16;
                _loc_7 = (_loc_24 - _loc_5 - _loc_16 - _loc_17) / 2 + _loc_16;
            }
            else
            {
                _loc_13 = getStyle("verticalGap");
                if (_loc_9 == 0 || label == "")
                {
                    _loc_13 = 0;
                }
                if (_loc_18 > 0)
                {
                    var _loc_29:* = Math.max(_loc_23 - _loc_14 - _loc_15, 0);
                    _loc_4 = Math.max(_loc_23 - _loc_14 - _loc_15, 0);
                    textField.width = _loc_29;
                    var _loc_29:* = Math.min(_loc_24 - _loc_9 - _loc_16 - _loc_17 - _loc_13, _loc_19);
                    _loc_5 = Math.min(_loc_24 - _loc_9 - _loc_16 - _loc_17 - _loc_13, _loc_19);
                    textField.height = _loc_29;
                }
                else
                {
                    var _loc_29:int = 0;
                    _loc_4 = 0;
                    textField.width = _loc_29;
                    var _loc_29:int = 0;
                    _loc_5 = 0;
                    textField.height = _loc_29;
                }
                _loc_6 = _loc_14;
                if (_loc_22 == "left")
                {
                    _loc_10 = _loc_10 + _loc_14;
                }
                else if (_loc_22 == "right")
                {
                    _loc_10 = _loc_10 + Math.max(_loc_23 - _loc_8 - _loc_15, _loc_14);
                }
                else
                {
                    _loc_10 = _loc_10 + ((_loc_23 - _loc_8 - _loc_14 - _loc_15) / 2 + _loc_14);
                }
                if (labelPlacement == ButtonLabelPlacement.TOP)
                {
                    _loc_7 = _loc_7 + ((_loc_24 - _loc_5 - _loc_9 - _loc_16 - _loc_17 - _loc_13) / 2 + _loc_16);
                    _loc_11 = _loc_11 + (_loc_7 + _loc_5 + _loc_13);
                }
                else
                {
                    _loc_11 = _loc_11 + ((_loc_24 - _loc_5 - _loc_9 - _loc_16 - _loc_17 - _loc_13) / 2 + _loc_16);
                    _loc_7 = _loc_7 + (_loc_11 + _loc_9 + _loc_13);
                }
            }
            var _loc_26:* = _loc_21;
            var _loc_27:* = _loc_21;
            if (_loc_25)
            {
                _loc_26 = _loc_26 + _loc_25.left;
                _loc_27 = _loc_27 + _loc_25.top;
            }
            textField.x = Math.round(_loc_6 + _loc_26);
            textField.y = Math.round(_loc_7 + _loc_27);
            if (currentIcon)
            {
                _loc_10 = _loc_10 + _loc_26;
                _loc_11 = _loc_11 + _loc_27;
                _loc_28 = new MoveEvent(MoveEvent.MOVE);
                _loc_28.oldX = currentIcon.x;
                _loc_28.oldY = currentIcon.y;
                currentIcon.x = Math.round(_loc_10);
                currentIcon.y = Math.round(_loc_11);
                currentIcon.dispatchEvent(_loc_28);
            }
            if (currentSkin)
            {
                setChildIndex(DisplayObject(currentSkin), numChildren--);
            }
            if (currentIcon)
            {
                setChildIndex(DisplayObject(currentIcon), numChildren--);
            }
            if (textField)
            {
                setChildIndex(DisplayObject(textField), numChildren--);
            }
            return;
        }// end function

        protected function mouseDownHandler(event:MouseEvent) : void
        {
            if (!enabled)
            {
                return;
            }
            systemManager.getSandboxRoot().addEventListener(MouseEvent.MOUSE_UP, systemManager_mouseUpHandler, true);
            systemManager.getSandboxRoot().addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, stage_mouseLeaveHandler);
            buttonPressed();
            event.updateAfterEvent();
            return;
        }// end function

        override protected function keyDownHandler(event:KeyboardEvent) : void
        {
            if (!enabled)
            {
                return;
            }
            if (event.keyCode == Keyboard.SPACE)
            {
                buttonPressed();
            }
            return;
        }// end function

        protected function rollOutHandler(event:MouseEvent) : void
        {
            if (phase == ButtonPhase.OVER)
            {
                phase = ButtonPhase.UP;
                event.updateAfterEvent();
            }
            else if (phase == ButtonPhase.DOWN && !stickyHighlighting)
            {
                phase = ButtonPhase.OVER;
                event.updateAfterEvent();
                if (autoRepeatTimer)
                {
                    autoRepeatTimer.stop();
                }
            }
            return;
        }// end function

        function get phase() : String
        {
            return _phase;
        }// end function

        override public function set enabled(param1:Boolean) : void
        {
            if (super.enabled == param1)
            {
                return;
            }
            super.enabled = param1;
            enabledChanged = true;
            invalidateProperties();
            invalidateDisplayList();
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_9:TextLineMetrics = null;
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                previousVersion_measure();
                return;
            }
            super.measure();
            var _loc_1:Number = 0;
            var _loc_2:Number = 0;
            if (label)
            {
                _loc_9 = measureText(label);
                _loc_1 = _loc_9.width + TEXT_WIDTH_PADDING;
                _loc_2 = _loc_9.height + UITextField.TEXT_HEIGHT_PADDING;
            }
            var _loc_3:* = getCurrentIcon();
            var _loc_4:* = _loc_3 ? (_loc_3.width) : (0);
            var _loc_5:* = _loc_3 ? (_loc_3.height) : (0);
            var _loc_6:Number = 0;
            var _loc_7:Number = 0;
            if (labelPlacement == ButtonLabelPlacement.LEFT || labelPlacement == ButtonLabelPlacement.RIGHT)
            {
                _loc_6 = _loc_1 + _loc_4;
                if (_loc_1 && _loc_4)
                {
                    _loc_6 = _loc_6 + getStyle("horizontalGap");
                }
                _loc_7 = Math.max(_loc_2, _loc_5);
            }
            else
            {
                _loc_6 = Math.max(_loc_1, _loc_4);
                _loc_7 = _loc_2 + _loc_5;
                if (_loc_2 && _loc_5)
                {
                    _loc_7 = _loc_7 + getStyle("verticalGap");
                }
            }
            if (_loc_1 || _loc_4)
            {
                _loc_6 = _loc_6 + (getStyle("paddingLeft") + getStyle("paddingRight"));
                _loc_7 = _loc_7 + (getStyle("paddingTop") + getStyle("paddingBottom"));
            }
            if (currentSkin && currentSkin is IBorder)
            {
            }
            var _loc_8:* = !(currentSkin is IFlexAsset) ? (IBorder(currentSkin).borderMetrics) : (null);
            if (!(currentSkin is IFlexAsset) ? (IBorder(currentSkin).borderMetrics) : (null))
            {
                _loc_6 = _loc_6 + (_loc_8.left + _loc_8.right);
                _loc_7 = _loc_7 + (_loc_8.top + _loc_8.bottom);
            }
            if (currentSkin && isNaN(skinMeasuredWidth) || isNaN(skinMeasuredHeight))
            {
                skinMeasuredWidth = currentSkin.measuredWidth;
                skinMeasuredHeight = currentSkin.measuredHeight;
            }
            if (!isNaN(skinMeasuredWidth))
            {
                _loc_6 = Math.max(skinMeasuredWidth, _loc_6);
            }
            if (!isNaN(skinMeasuredHeight))
            {
                _loc_7 = Math.max(skinMeasuredHeight, _loc_7);
            }
            var _loc_10:* = _loc_6;
            measuredWidth = _loc_6;
            measuredMinWidth = _loc_10;
            var _loc_10:* = _loc_7;
            measuredHeight = _loc_7;
            measuredMinHeight = _loc_10;
            return;
        }// end function

        public function get toggle() : Boolean
        {
            return _toggle;
        }// end function

        function buttonReleased() : void
        {
            systemManager.getSandboxRoot().removeEventListener(MouseEvent.MOUSE_UP, systemManager_mouseUpHandler, true);
            systemManager.getSandboxRoot().removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, stage_mouseLeaveHandler);
            if (autoRepeatTimer)
            {
                autoRepeatTimer.removeEventListener(TimerEvent.TIMER, autoRepeatTimer_timerDelayHandler);
                autoRepeatTimer.removeEventListener(TimerEvent.TIMER, autoRepeatTimer_timerHandler);
                autoRepeatTimer.reset();
            }
            return;
        }// end function

        function buttonPressed() : void
        {
            phase = ButtonPhase.DOWN;
            dispatchEvent(new FlexEvent(FlexEvent.BUTTON_DOWN));
            if (autoRepeat)
            {
                autoRepeatTimer.delay = getStyle("repeatDelay");
                autoRepeatTimer.addEventListener(TimerEvent.TIMER, autoRepeatTimer_timerDelayHandler);
                autoRepeatTimer.start();
            }
            return;
        }// end function

        override protected function keyUpHandler(event:KeyboardEvent) : void
        {
            if (!enabled)
            {
                return;
            }
            if (event.keyCode == Keyboard.SPACE)
            {
                buttonReleased();
                if (phase == ButtonPhase.DOWN)
                {
                    dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                }
                phase = ButtonPhase.UP;
            }
            return;
        }// end function

        public function get selected() : Boolean
        {
            return _selected;
        }// end function

        public function set labelPlacement(param1:String) : void
        {
            _labelPlacement = param1;
            invalidateSize();
            invalidateDisplayList();
            dispatchEvent(new Event("labelPlacementChanged"));
            return;
        }// end function

        protected function clickHandler(event:MouseEvent) : void
        {
            if (!enabled)
            {
                event.stopImmediatePropagation();
                return;
            }
            if (toggle)
            {
                setSelected(!selected);
                event.updateAfterEvent();
            }
            return;
        }// end function

        override protected function initializeAccessibility() : void
        {
            if (Button.createAccessibilityImplementation != null)
            {
                Button.createAccessibilityImplementation(this);
            }
            return;
        }// end function

        public function set toggle(param1:Boolean) : void
        {
            _toggle = param1;
            toggleChanged = true;
            invalidateProperties();
            invalidateDisplayList();
            dispatchEvent(new Event("toggleChanged"));
            return;
        }// end function

        override public function get baselinePosition() : Number
        {
            var _loc_1:String = null;
            var _loc_2:TextLineMetrics = null;
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                _loc_1 = label;
                if (!_loc_1)
                {
                    _loc_1 = "Wj";
                }
                validateNow();
                if (!label && labelPlacement == ButtonLabelPlacement.TOP || labelPlacement == ButtonLabelPlacement.BOTTOM)
                {
                    _loc_2 = measureText(_loc_1);
                    return (measuredHeight - _loc_2.height) / 2 + _loc_2.ascent;
                }
                return textField.y + measureText(_loc_1).ascent;
            }
            if (!validateBaselinePosition())
            {
                return NaN;
            }
            return textField.y + textField.baselinePosition;
        }// end function

        public function get data() : Object
        {
            return _data;
        }// end function

        public function set fontContext(param1:IFlexModuleFactory) : void
        {
            this.moduleFactory = param1;
            return;
        }// end function

        function viewSkin() : void
        {
            var _loc_1:String = null;
            var _loc_2:String = null;
            if (!enabled)
            {
                _loc_1 = selected ? (selectedDisabledSkinName) : (disabledSkinName);
                _loc_2 = selected ? ("selectedDisabled") : ("disabled");
            }
            else if (phase == ButtonPhase.UP)
            {
                _loc_1 = selected ? (selectedUpSkinName) : (upSkinName);
                _loc_2 = selected ? ("selectedUp") : ("up");
            }
            else if (phase == ButtonPhase.OVER)
            {
                _loc_1 = selected ? (selectedOverSkinName) : (overSkinName);
                _loc_2 = selected ? ("selectedOver") : ("over");
            }
            else if (phase == ButtonPhase.DOWN)
            {
                _loc_1 = selected ? (selectedDownSkinName) : (downSkinName);
                _loc_2 = selected ? ("selectedDown") : ("down");
            }
            viewSkinForPhase(_loc_1, _loc_2);
            return;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            styleChangedFlag = true;
            super.styleChanged(param1);
            if (!param1 || param1 == "styleName")
            {
                changeSkins();
                changeIcons();
                if (initialized)
                {
                    viewSkin();
                    viewIcon();
                }
            }
            else if (param1.toLowerCase().indexOf("skin") != -1)
            {
                changeSkins();
            }
            else if (param1.toLowerCase().indexOf("icon") != -1)
            {
                changeIcons();
                invalidateSize();
            }
            return;
        }// end function

        public function set emphasized(param1:Boolean) : void
        {
            _emphasized = param1;
            emphasizedChanged = true;
            invalidateDisplayList();
            return;
        }// end function

        function viewIcon() : void
        {
            var _loc_1:* = getCurrentIconName();
            viewIconForPhase(_loc_1);
            return;
        }// end function

        override public function set toolTip(param1:String) : void
        {
            super.toolTip = param1;
            if (param1)
            {
                toolTipSet = true;
            }
            else
            {
                toolTipSet = false;
                invalidateDisplayList();
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (hasFontContextChanged() && textField != null)
            {
                removeChild(DisplayObject(textField));
                textField = null;
            }
            if (!textField)
            {
                textField = IUITextField(createInFontContext(UITextField));
                textField.styleName = this;
                addChild(DisplayObject(textField));
                enabledChanged = true;
                toggleChanged = true;
            }
            if (!initialized)
            {
                viewSkin();
                viewIcon();
            }
            if (enabledChanged)
            {
                textField.enabled = enabled;
                if (currentIcon && currentIcon is IUIComponent)
                {
                    IUIComponent(currentIcon).enabled = enabled;
                }
                enabledChanged = false;
            }
            if (toggleChanged)
            {
                if (!toggle)
                {
                    selected = false;
                }
                toggleChanged = false;
            }
            return;
        }// end function

        function changeSkins() : void
        {
            var _loc_1:* = skins.length;
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1)
            {
                
                removeChild(skins[_loc_2]);
                _loc_2++;
            }
            skins = [];
            skinMeasuredWidth = NaN;
            skinMeasuredHeight = NaN;
            checkedDefaultSkin = false;
            defaultSkinUsesStates = false;
            if (initialized && FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0)
            {
                viewSkin();
                invalidateSize();
            }
            return;
        }// end function

        private function autoRepeatTimer_timerHandler(event:Event) : void
        {
            if (!enabled)
            {
                return;
            }
            dispatchEvent(new FlexEvent(FlexEvent.BUTTON_DOWN));
            return;
        }// end function

        private function previousVersion_layoutContents(param1:Number, param2:Number, param3:Boolean) : void
        {
            var _loc_20:TextLineMetrics = null;
            var _loc_28:Number = NaN;
            var _loc_29:MoveEvent = null;
            var _loc_4:Number = 0;
            var _loc_5:Number = 0;
            var _loc_6:Number = 0;
            var _loc_7:Number = 0;
            var _loc_8:Number = 0;
            var _loc_9:Number = 0;
            var _loc_10:Number = 0;
            var _loc_11:Number = 0;
            var _loc_12:Number = 2;
            var _loc_13:Number = 2;
            var _loc_14:* = getStyle("paddingLeft");
            var _loc_15:* = getStyle("paddingRight");
            var _loc_16:* = getStyle("paddingTop");
            var _loc_17:* = getStyle("paddingBottom");
            var _loc_18:Number = 0;
            var _loc_19:Number = 0;
            if (label)
            {
                _loc_20 = measureText(label);
                if (_loc_20.width > 0)
                {
                    _loc_18 = _loc_14 + _loc_15 + getStyle("textIndent") + _loc_20.width;
                }
                _loc_19 = _loc_20.height;
            }
            else
            {
                _loc_20 = measureText("Wj");
                _loc_19 = _loc_20.height;
            }
            var _loc_21:* = param3 ? (buttonOffset) : (0);
            var _loc_22:* = getStyle("textAlign");
            if (currentSkin)
            {
            }
            var _loc_23:* = currentSkin is IRectangularBorder ? (IRectangularBorder(currentSkin).borderMetrics) : (null);
            var _loc_24:* = param1;
            var _loc_25:* = param2 - _loc_16 - _loc_17;
            if (_loc_23)
            {
                _loc_24 = _loc_24 - (_loc_23.left + _loc_23.right);
                _loc_25 = _loc_25 - (_loc_23.top + _loc_23.bottom);
            }
            if (currentIcon)
            {
                _loc_8 = currentIcon.width;
                _loc_9 = currentIcon.height;
            }
            if (labelPlacement == ButtonLabelPlacement.LEFT || labelPlacement == ButtonLabelPlacement.RIGHT)
            {
                _loc_12 = getStyle("horizontalGap");
                if (_loc_8 == 0 || _loc_18 == 0)
                {
                    _loc_12 = 0;
                }
                if (_loc_18 > 0)
                {
                    var _loc_30:* = Math.max(_loc_24 - _loc_8 - _loc_12 - _loc_14 - _loc_15, 0);
                    _loc_4 = Math.max(_loc_24 - _loc_8 - _loc_12 - _loc_14 - _loc_15, 0);
                    textField.width = _loc_30;
                }
                else
                {
                    var _loc_30:int = 0;
                    _loc_4 = 0;
                    textField.width = _loc_30;
                }
                var _loc_30:* = Math.min(_loc_25 + 2, _loc_19 + UITextField.TEXT_HEIGHT_PADDING);
                _loc_5 = Math.min(_loc_25 + 2, _loc_19 + UITextField.TEXT_HEIGHT_PADDING);
                textField.height = _loc_30;
                if (labelPlacement == ButtonLabelPlacement.RIGHT)
                {
                    _loc_6 = _loc_8 + _loc_12;
                    if (centerContent)
                    {
                        if (_loc_22 == "left")
                        {
                            _loc_6 = _loc_6 + _loc_14;
                        }
                        else if (_loc_22 == "right")
                        {
                            _loc_6 = _loc_6 + (_loc_24 - _loc_4 - _loc_8 - _loc_12 - _loc_14);
                        }
                        else
                        {
                            _loc_28 = (_loc_24 - _loc_4 - _loc_8 - _loc_12) / 2;
                            _loc_6 = _loc_6 + Math.max(_loc_28, _loc_14);
                        }
                    }
                    _loc_10 = _loc_6 - (_loc_8 + _loc_12);
                    if (!centerContent)
                    {
                        _loc_6 = _loc_6 + _loc_14;
                    }
                }
                else
                {
                    _loc_6 = _loc_24 - _loc_4 - _loc_8 - _loc_12 - _loc_15;
                    if (centerContent)
                    {
                        if (_loc_22 == "left")
                        {
                            _loc_6 = 2;
                        }
                        else if (_loc_22 == "right")
                        {
                        }
                        else if (_loc_6-- > 0)
                        {
                            _loc_6 = _loc_6 / 2;
                        }
                    }
                    _loc_10 = _loc_6 + _loc_4 + _loc_12;
                }
                var _loc_30:int = 0;
                _loc_7 = 0;
                _loc_11 = _loc_30;
                if (centerContent)
                {
                    _loc_11 = Math.round((_loc_25 - _loc_9) / 2) + _loc_16;
                    _loc_7 = Math.round((_loc_25 - _loc_5) / 2) + _loc_16;
                }
                else
                {
                    _loc_7 = _loc_7 + (Math.max(0, (_loc_25 - _loc_5) / 2) + _loc_16);
                    _loc_11 = _loc_11 + (Math.max(0, ((_loc_25 - _loc_9) / 2)--) + _loc_16);
                }
            }
            else
            {
                _loc_13 = getStyle("verticalGap");
                if (_loc_9 == 0 || _loc_19 == 0)
                {
                    _loc_13 = 0;
                }
                if (_loc_18 > 0)
                {
                    var _loc_30:* = Math.min(_loc_24, _loc_18 + UITextField.TEXT_WIDTH_PADDING);
                    _loc_4 = Math.min(_loc_24, _loc_18 + UITextField.TEXT_WIDTH_PADDING);
                    textField.width = _loc_30;
                    var _loc_30:* = Math.min(_loc_25 - _loc_9 + 1, _loc_19 + 5);
                    _loc_5 = Math.min(_loc_25 - _loc_9 + 1, _loc_19 + 5);
                    textField.height = _loc_30;
                }
                else
                {
                    var _loc_30:int = 0;
                    _loc_4 = 0;
                    textField.width = _loc_30;
                    var _loc_30:int = 0;
                    _loc_5 = 0;
                    textField.height = _loc_30;
                }
                _loc_6 = (_loc_24 - _loc_4) / 2;
                _loc_10 = (_loc_24 - _loc_8) / 2;
                if (labelPlacement == ButtonLabelPlacement.TOP)
                {
                    _loc_7 = _loc_25 - _loc_5 - _loc_9 - _loc_13;
                    if (centerContent && _loc_7 > 0)
                    {
                        _loc_7 = _loc_7 / 2;
                    }
                    _loc_7 = _loc_7 + _loc_16;
                    _loc_11 = _loc_7 + _loc_5 + _loc_13 - 3;
                }
                else
                {
                    _loc_7 = _loc_9 + _loc_13 + _loc_16;
                    if (centerContent)
                    {
                        _loc_7 = _loc_7 + ((_loc_25 - _loc_5 - _loc_9 - _loc_13) / 2 + 1);
                    }
                    _loc_11 = _loc_7 - _loc_9 - _loc_13 + 3;
                }
            }
            var _loc_26:* = _loc_21;
            var _loc_27:* = _loc_21;
            if (_loc_23)
            {
                _loc_26 = _loc_26 + _loc_23.left;
                _loc_27 = _loc_27 + _loc_23.top;
            }
            textField.x = _loc_6 + _loc_26;
            textField.y = _loc_7 + _loc_27;
            if (currentIcon)
            {
                _loc_10 = _loc_10 + _loc_26;
                _loc_11 = _loc_11 + _loc_27;
                _loc_29 = new MoveEvent(MoveEvent.MOVE);
                _loc_29.oldX = currentIcon.x;
                _loc_29.oldY = currentIcon.y;
                currentIcon.x = Math.round(_loc_10);
                currentIcon.y = Math.round(_loc_11);
                currentIcon.dispatchEvent(_loc_29);
            }
            if (currentSkin)
            {
                setChildIndex(DisplayObject(currentSkin), numChildren--);
            }
            if (currentIcon)
            {
                setChildIndex(DisplayObject(currentIcon), numChildren--);
            }
            if (textField)
            {
                setChildIndex(DisplayObject(textField), numChildren--);
            }
            return;
        }// end function

        private function systemManager_mouseUpHandler(event:MouseEvent) : void
        {
            if (contains(DisplayObject(event.target)))
            {
                return;
            }
            phase = ButtonPhase.UP;
            buttonReleased();
            event.updateAfterEvent();
            return;
        }// end function

        public function set label(param1:String) : void
        {
            labelSet = true;
            if (_label != param1)
            {
                _label = param1;
                labelChanged = true;
                invalidateSize();
                invalidateDisplayList();
                dispatchEvent(new Event("labelChanged"));
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_5:IFlexDisplayObject = null;
            var _loc_6:Boolean = false;
            super.updateDisplayList(param1, param2);
            if (emphasizedChanged)
            {
                changeSkins();
                emphasizedChanged = false;
            }
            var _loc_3:* = skins.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = IFlexDisplayObject(skins[_loc_4]);
                _loc_5.setActualSize(param1, param2);
                _loc_4++;
            }
            viewSkin();
            viewIcon();
            layoutContents(param1, param2, phase == ButtonPhase.DOWN);
            if (oldUnscaledWidth > param1 || textField.text != label || labelChanged || styleChangedFlag)
            {
                textField.text = label;
                _loc_6 = textField.truncateToFit();
                if (!toolTipSet)
                {
                    if (_loc_6)
                    {
                        super.toolTip = label;
                    }
                    else
                    {
                        super.toolTip = null;
                    }
                }
                styleChangedFlag = false;
                labelChanged = false;
            }
            oldUnscaledWidth = param1;
            return;
        }// end function

        private function stage_mouseLeaveHandler(event:Event) : void
        {
            phase = ButtonPhase.UP;
            buttonReleased();
            return;
        }// end function

        public function set listData(param1:BaseListData) : void
        {
            _listData = param1;
            return;
        }// end function

    }
}
