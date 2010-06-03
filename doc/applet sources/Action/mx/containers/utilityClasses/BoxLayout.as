package mx.containers.utilityClasses
{
    import mx.containers.*;
    import mx.core.*;

    public class BoxLayout extends Layout
    {
        public var direction:String = "vertical";
        static const VERSION:String = "3.2.0.3958";

        public function BoxLayout()
        {
            return;
        }// end function

        private function isVertical() : Boolean
        {
            return direction != BoxDirection.HORIZONTAL;
        }// end function

        function getHorizontalAlignValue() : Number
        {
            var _loc_1:* = target.getStyle("horizontalAlign");
            if (_loc_1 == "center")
            {
                return 0.5;
            }
            if (_loc_1 == "right")
            {
                return 1;
            }
            return 0;
        }// end function

        override public function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_16:Number = NaN;
            var _loc_17:int = 0;
            var _loc_18:Number = NaN;
            var _loc_19:Number = NaN;
            var _loc_20:Number = NaN;
            var _loc_21:int = 0;
            var _loc_22:IUIComponent = null;
            var _loc_23:IUIComponent = null;
            var _loc_24:Number = NaN;
            var _loc_25:Number = NaN;
            var _loc_26:Number = NaN;
            var _loc_27:Number = NaN;
            var _loc_3:* = super.target;
            var _loc_4:* = _loc_3.numChildren;
            if (_loc_3.numChildren == 0)
            {
                return;
            }
            var _loc_5:* = _loc_3.viewMetricsAndPadding;
            var _loc_6:* = _loc_3.getStyle("paddingLeft");
            var _loc_7:* = _loc_3.getStyle("paddingTop");
            var _loc_8:* = getHorizontalAlignValue();
            var _loc_9:* = getVerticalAlignValue();
            if (_loc_3.scaleX > 0)
            {
            }
            var _loc_10:* = _loc_3.scaleX != 1 ? (_loc_3.minWidth / Math.abs(_loc_3.scaleX)) : (_loc_3.minWidth);
            if (_loc_3.scaleY > 0)
            {
            }
            var _loc_11:* = _loc_3.scaleY != 1 ? (_loc_3.minHeight / Math.abs(_loc_3.scaleY)) : (_loc_3.minHeight);
            var _loc_12:* = Math.max(param1, _loc_10) - _loc_5.right - _loc_5.left;
            var _loc_13:* = Math.max(param2, _loc_11) - _loc_5.bottom - _loc_5.top;
            var _loc_14:* = _loc_3.horizontalScrollBar;
            var _loc_15:* = _loc_3.verticalScrollBar;
            if (_loc_4 == 1)
            {
                _loc_23 = IUIComponent(_loc_3.getChildAt(0));
                _loc_24 = _loc_23.percentWidth;
                _loc_25 = _loc_23.percentHeight;
                if (_loc_24)
                {
                    _loc_26 = Math.max(_loc_23.minWidth, Math.min(_loc_23.maxWidth, _loc_24 >= 100 ? (_loc_12) : (_loc_12 * _loc_24 / 100)));
                }
                else
                {
                    _loc_26 = _loc_23.getExplicitOrMeasuredWidth();
                }
                if (_loc_25)
                {
                    _loc_27 = Math.max(_loc_23.minHeight, Math.min(_loc_23.maxHeight, _loc_25 >= 100 ? (_loc_13) : (_loc_13 * _loc_25 / 100)));
                }
                else
                {
                    _loc_27 = _loc_23.getExplicitOrMeasuredHeight();
                }
                if (_loc_23.scaleX == 1 && _loc_23.scaleY == 1)
                {
                    _loc_23.setActualSize(Math.floor(_loc_26), Math.floor(_loc_27));
                }
                else
                {
                    _loc_23.setActualSize(_loc_26, _loc_27);
                }
                if (_loc_15 != null && _loc_3.verticalScrollPolicy == ScrollPolicy.AUTO)
                {
                    _loc_12 = _loc_12 + _loc_15.minWidth;
                }
                if (_loc_14 != null && _loc_3.horizontalScrollPolicy == ScrollPolicy.AUTO)
                {
                    _loc_13 = _loc_13 + _loc_14.minHeight;
                }
                _loc_20 = (_loc_12 - _loc_23.width) * _loc_8 + _loc_6;
                _loc_19 = (_loc_13 - _loc_23.height) * _loc_9 + _loc_7;
                _loc_23.move(Math.floor(_loc_20), Math.floor(_loc_19));
            }
            else if (isVertical())
            {
                _loc_16 = _loc_3.getStyle("verticalGap");
                _loc_17 = _loc_4;
                _loc_21 = 0;
                while (_loc_21 < _loc_4)
                {
                    
                    if (!IUIComponent(_loc_3.getChildAt(_loc_21)).includeInLayout)
                    {
                    }
                    _loc_21++;
                }
                _loc_18 = Flex.flexChildHeightsProportionally(_loc_3, _loc_13 - _loc_17---- * _loc_16, _loc_12);
                if (_loc_14 != null && _loc_3.horizontalScrollPolicy == ScrollPolicy.AUTO)
                {
                    _loc_18 = _loc_18 + _loc_14.minHeight;
                }
                if (_loc_15 != null && _loc_3.verticalScrollPolicy == ScrollPolicy.AUTO)
                {
                    _loc_12 = _loc_12 + _loc_15.minWidth;
                }
                _loc_19 = _loc_7 + _loc_18 * _loc_9;
                _loc_21 = 0;
                while (_loc_21 < _loc_4)
                {
                    
                    _loc_22 = IUIComponent(_loc_3.getChildAt(_loc_21));
                    _loc_20 = (_loc_12 - _loc_22.width) * _loc_8 + _loc_6;
                    _loc_22.move(Math.floor(_loc_20), Math.floor(_loc_19));
                    if (_loc_22.includeInLayout)
                    {
                        _loc_19 = _loc_19 + (_loc_22.height + _loc_16);
                    }
                    _loc_21++;
                }
            }
            else
            {
                _loc_16 = _loc_3.getStyle("horizontalGap");
                _loc_17 = _loc_4;
                _loc_21 = 0;
                while (_loc_21 < _loc_4)
                {
                    
                    if (!IUIComponent(_loc_3.getChildAt(_loc_21)).includeInLayout)
                    {
                    }
                    _loc_21++;
                }
                _loc_18 = Flex.flexChildWidthsProportionally(_loc_3, _loc_12 - _loc_17---- * _loc_16, _loc_13);
                if (_loc_14 != null && _loc_3.horizontalScrollPolicy == ScrollPolicy.AUTO)
                {
                    _loc_13 = _loc_13 + _loc_14.minHeight;
                }
                if (_loc_15 != null && _loc_3.verticalScrollPolicy == ScrollPolicy.AUTO)
                {
                    _loc_18 = _loc_18 + _loc_15.minWidth;
                }
                _loc_20 = _loc_6 + _loc_18 * _loc_8;
                _loc_21 = 0;
                while (_loc_21 < _loc_4)
                {
                    
                    _loc_22 = IUIComponent(_loc_3.getChildAt(_loc_21));
                    _loc_19 = (_loc_13 - _loc_22.height) * _loc_9 + _loc_7;
                    _loc_22.move(Math.floor(_loc_20), Math.floor(_loc_19));
                    if (_loc_22.includeInLayout)
                    {
                        _loc_20 = _loc_20 + (_loc_22.width + _loc_16);
                    }
                    _loc_21++;
                }
            }
            return;
        }// end function

        function getVerticalAlignValue() : Number
        {
            var _loc_1:* = target.getStyle("verticalAlign");
            if (_loc_1 == "middle")
            {
                return 0.5;
            }
            if (_loc_1 == "bottom")
            {
                return 1;
            }
            return 0;
        }// end function

        function heightPadding(param1:Number) : Number
        {
            var _loc_2:* = target.viewMetricsAndPadding;
            var _loc_3:* = _loc_2.top + _loc_2.bottom;
            if (param1 > 1 && isVertical())
            {
                _loc_3 = _loc_3 + target.getStyle("verticalGap") * param1--;
            }
            return _loc_3;
        }// end function

        function widthPadding(param1:Number) : Number
        {
            var _loc_2:* = target.viewMetricsAndPadding;
            var _loc_3:* = _loc_2.left + _loc_2.right;
            if (param1 > 1 && isVertical() == false)
            {
                _loc_3 = _loc_3 + target.getStyle("horizontalGap") * param1--;
            }
            return _loc_3;
        }// end function

        override public function measure() : void
        {
            var _loc_1:Container = null;
            var _loc_10:Number = NaN;
            var _loc_11:Number = NaN;
            var _loc_12:IUIComponent = null;
            var _loc_13:Number = NaN;
            var _loc_14:Number = NaN;
            _loc_1 = super.target;
            var _loc_2:* = isVertical();
            var _loc_3:Number = 0;
            var _loc_4:Number = 0;
            var _loc_5:Number = 0;
            var _loc_6:Number = 0;
            var _loc_7:* = _loc_1.numChildren;
            var _loc_8:* = _loc_1.numChildren;
            var _loc_9:int = 0;
            while (_loc_9 < _loc_7)
            {
                
                _loc_12 = IUIComponent(_loc_1.getChildAt(_loc_9));
                if (!_loc_12.includeInLayout)
                {
                }
                else
                {
                    _loc_13 = _loc_12.getExplicitOrMeasuredWidth();
                    _loc_14 = _loc_12.getExplicitOrMeasuredHeight();
                    if (_loc_2)
                    {
                        _loc_3 = Math.max(!isNaN(_loc_12.percentWidth) ? (_loc_12.minWidth) : (_loc_13), _loc_3);
                        _loc_5 = Math.max(_loc_13, _loc_5);
                        _loc_4 = _loc_4 + (!isNaN(_loc_12.percentHeight) ? (_loc_12.minHeight) : (_loc_14));
                        _loc_6 = _loc_6 + _loc_14;
                    }
                    else
                    {
                        _loc_3 = _loc_3 + (!isNaN(_loc_12.percentWidth) ? (_loc_12.minWidth) : (_loc_13));
                        _loc_5 = _loc_5 + _loc_13;
                        _loc_4 = Math.max(!isNaN(_loc_12.percentHeight) ? (_loc_12.minHeight) : (_loc_14), _loc_4);
                        _loc_6 = Math.max(_loc_14, _loc_6);
                    }
                }
                _loc_9++;
            }
            _loc_10 = widthPadding(_loc_8--);
            _loc_11 = heightPadding(_loc_8);
            _loc_1.measuredMinWidth = _loc_3 + _loc_10;
            _loc_1.measuredMinHeight = _loc_4 + _loc_11;
            _loc_1.measuredWidth = _loc_5 + _loc_10;
            _loc_1.measuredHeight = _loc_6 + _loc_11;
            return;
        }// end function

    }
}
