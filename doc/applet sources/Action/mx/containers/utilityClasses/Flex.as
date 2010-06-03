package mx.containers.utilityClasses
{
    import mx.core.*;

    public class Flex extends Object
    {
        static const VERSION:String = "3.2.0.3958";

        public function Flex()
        {
            return;
        }// end function

        public static function flexChildWidthsProportionally(param1:Container, param2:Number, param3:Number) : Number
        {
            var _loc_6:Array = null;
            var _loc_7:FlexChildInfo = null;
            var _loc_8:IUIComponent = null;
            var _loc_9:int = 0;
            var _loc_11:Number = NaN;
            var _loc_12:Number = NaN;
            var _loc_13:Number = NaN;
            var _loc_14:Number = NaN;
            var _loc_4:* = param2;
            var _loc_5:Number = 0;
            _loc_6 = [];
            var _loc_10:* = param1.numChildren;
            _loc_9 = 0;
            while (_loc_9 < _loc_10)
            {
                
                _loc_8 = IUIComponent(param1.getChildAt(_loc_9));
                _loc_11 = _loc_8.percentWidth;
                _loc_12 = _loc_8.percentHeight;
                if (!isNaN(_loc_12) && _loc_8.includeInLayout)
                {
                    _loc_13 = Math.max(_loc_8.minHeight, Math.min(_loc_8.maxHeight, _loc_12 >= 100 ? (param3) : (param3 * _loc_12 / 100)));
                }
                else
                {
                    _loc_13 = _loc_8.getExplicitOrMeasuredHeight();
                }
                if (!isNaN(_loc_11) && _loc_8.includeInLayout)
                {
                    _loc_5 = _loc_5 + _loc_11;
                    _loc_7 = new FlexChildInfo();
                    _loc_7.percent = _loc_11;
                    _loc_7.min = _loc_8.minWidth;
                    _loc_7.max = _loc_8.maxWidth;
                    _loc_7.height = _loc_13;
                    _loc_7.child = _loc_8;
                    _loc_6.push(_loc_7);
                }
                else
                {
                    _loc_14 = _loc_8.getExplicitOrMeasuredWidth();
                    if (_loc_8.scaleX == 1 && _loc_8.scaleY == 1)
                    {
                        _loc_8.setActualSize(Math.floor(_loc_14), Math.floor(_loc_13));
                    }
                    else
                    {
                        _loc_8.setActualSize(_loc_14, _loc_13);
                    }
                    if (_loc_8.includeInLayout)
                    {
                        _loc_4 = _loc_4 - _loc_8.width;
                    }
                }
                _loc_9++;
            }
            if (_loc_5)
            {
                _loc_4 = flexChildrenProportionally(param2, _loc_4, _loc_5, _loc_6);
                _loc_10 = _loc_6.length;
                _loc_9 = 0;
                while (_loc_9 < _loc_10)
                {
                    
                    _loc_7 = _loc_6[_loc_9];
                    _loc_8 = _loc_7.child;
                    if (_loc_8.scaleX == 1 && _loc_8.scaleY == 1)
                    {
                        _loc_8.setActualSize(Math.floor(_loc_7.size), Math.floor(_loc_7.height));
                    }
                    else
                    {
                        _loc_8.setActualSize(_loc_7.size, _loc_7.height);
                    }
                    _loc_9++;
                }
                if (FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0)
                {
                    distributeExtraWidth(param1, param2);
                }
            }
            return _loc_4;
        }// end function

        public static function distributeExtraHeight(param1:Container, param2:Number) : void
        {
            var _loc_5:int = 0;
            var _loc_6:Number = NaN;
            var _loc_9:IUIComponent = null;
            var _loc_10:Number = NaN;
            var _loc_11:Number = NaN;
            var _loc_3:* = param1.numChildren;
            var _loc_4:Boolean = false;
            var _loc_7:* = param2;
            var _loc_8:Number = 0;
            _loc_5 = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_9 = IUIComponent(param1.getChildAt(_loc_5));
                if (!_loc_9.includeInLayout)
                {
                }
                else
                {
                    _loc_10 = _loc_9.height;
                    _loc_6 = _loc_9.percentHeight;
                    _loc_8 = _loc_8 + _loc_10;
                    if (!isNaN(_loc_6))
                    {
                        _loc_11 = Math.ceil(_loc_6 / 100 * param2);
                        if (_loc_11 > _loc_10)
                        {
                            _loc_4 = true;
                        }
                    }
                }
                _loc_5++;
            }
            if (true)
            {
                return;
            }
            _loc_7 = _loc_7 - _loc_8;
            var _loc_12:Boolean = true;
            while (_loc_12 && _loc_7 > 0)
            {
                
                _loc_12 = false;
                _loc_5 = 0;
                while (_loc_5 < _loc_3)
                {
                    
                    _loc_9 = IUIComponent(param1.getChildAt(_loc_5));
                    _loc_10 = _loc_9.height;
                    _loc_6 = _loc_9.percentHeight;
                    if (!isNaN(_loc_6) && _loc_9.includeInLayout && _loc_10 < _loc_9.maxHeight)
                    {
                        _loc_11 = Math.ceil(_loc_6 / 100 * param2);
                        if (_loc_11 > _loc_10)
                        {
                            _loc_9.setActualSize(_loc_9.width, _loc_10 + 1);
                            _loc_12 = true;
                            if (_loc_7-- == 0)
                            {
                                return;
                            }
                        }
                    }
                    _loc_5++;
                }
            }
            return;
        }// end function

        public static function distributeExtraWidth(param1:Container, param2:Number) : void
        {
            var _loc_5:int = 0;
            var _loc_6:Number = NaN;
            var _loc_9:IUIComponent = null;
            var _loc_10:Number = NaN;
            var _loc_11:Number = NaN;
            var _loc_3:* = param1.numChildren;
            var _loc_4:Boolean = false;
            var _loc_7:* = param2;
            var _loc_8:Number = 0;
            _loc_5 = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_9 = IUIComponent(param1.getChildAt(_loc_5));
                if (!_loc_9.includeInLayout)
                {
                }
                else
                {
                    _loc_10 = _loc_9.width;
                    _loc_6 = _loc_9.percentWidth;
                    _loc_8 = _loc_8 + _loc_10;
                    if (!isNaN(_loc_6))
                    {
                        _loc_11 = Math.ceil(_loc_6 / 100 * param2);
                        if (_loc_11 > _loc_10)
                        {
                            _loc_4 = true;
                        }
                    }
                }
                _loc_5++;
            }
            if (true)
            {
                return;
            }
            _loc_7 = _loc_7 - _loc_8;
            var _loc_12:Boolean = true;
            while (_loc_12 && _loc_7 > 0)
            {
                
                _loc_12 = false;
                _loc_5 = 0;
                while (_loc_5 < _loc_3)
                {
                    
                    _loc_9 = IUIComponent(param1.getChildAt(_loc_5));
                    _loc_10 = _loc_9.width;
                    _loc_6 = _loc_9.percentWidth;
                    if (!isNaN(_loc_6) && _loc_9.includeInLayout && _loc_10 < _loc_9.maxWidth)
                    {
                        _loc_11 = Math.ceil(_loc_6 / 100 * param2);
                        if (_loc_11 > _loc_10)
                        {
                            _loc_9.setActualSize(_loc_10 + 1, _loc_9.height);
                            _loc_12 = true;
                            if (_loc_7-- == 0)
                            {
                                return;
                            }
                        }
                    }
                    _loc_5++;
                }
            }
            return;
        }// end function

        public static function flexChildrenProportionally(param1:Number, param2:Number, param3:Number, param4:Array) : Number
        {
            var _loc_6:Number = NaN;
            var _loc_7:Boolean = false;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            var _loc_13:* = undefined;
            var _loc_14:* = undefined;
            var _loc_5:* = param4.length;
            var _loc_8:* = param2 - param1 * param3 / 100;
            if (param2 - param1 * param3 / 100 > 0)
            {
                param2 = param2 - _loc_8;
            }
            do
            {
                
                _loc_6 = 0;
                _loc_7 = true;
                _loc_9 = param2 / param3;
                _loc_10 = 0;
                while (_loc_10++ < _loc_5)
                {
                    
                    _loc_11 = param4[_loc_10];
                    _loc_12 = _loc_11.percent * _loc_9;
                    if (_loc_12 < _loc_11.min)
                    {
                        _loc_13 = _loc_11.min;
                        _loc_11.size = _loc_13;
                        param4[_loc_10] = param4[--_loc_5];
                        param4[--_loc_5] = _loc_11;
                        param3 = param3 - _loc_11.percent;
                        param2 = param2 - _loc_13;
                        _loc_7 = false;
                        break;
                        continue;
                    }
                    if (_loc_12 > _loc_11.max)
                    {
                        _loc_14 = _loc_11.max;
                        _loc_11.size = _loc_14;
                        param4[_loc_10] = param4[--_loc_5];
                        param4[--_loc_5] = _loc_11;
                        param3 = param3 - _loc_11.percent;
                        param2 = param2 - _loc_14;
                        _loc_7 = false;
                        break;
                        continue;
                    }
                    _loc_11.size = _loc_12;
                    _loc_6 = _loc_6 + _loc_12;
                }
            }while (!_loc_7)
            return Math.max(0, Math.floor(param2 - _loc_6));
        }// end function

        public static function flexChildHeightsProportionally(param1:Container, param2:Number, param3:Number) : Number
        {
            var _loc_7:FlexChildInfo = null;
            var _loc_8:IUIComponent = null;
            var _loc_9:int = 0;
            var _loc_11:Number = NaN;
            var _loc_12:Number = NaN;
            var _loc_13:Number = NaN;
            var _loc_14:Number = NaN;
            var _loc_4:* = param2;
            var _loc_5:Number = 0;
            var _loc_6:Array = [];
            var _loc_10:* = param1.numChildren;
            _loc_9 = 0;
            while (_loc_9 < _loc_10)
            {
                
                _loc_8 = IUIComponent(param1.getChildAt(_loc_9));
                _loc_11 = _loc_8.percentWidth;
                _loc_12 = _loc_8.percentHeight;
                if (!isNaN(_loc_11) && _loc_8.includeInLayout)
                {
                    _loc_13 = Math.max(_loc_8.minWidth, Math.min(_loc_8.maxWidth, _loc_11 >= 100 ? (param3) : (param3 * _loc_11 / 100)));
                }
                else
                {
                    _loc_13 = _loc_8.getExplicitOrMeasuredWidth();
                }
                if (!isNaN(_loc_12) && _loc_8.includeInLayout)
                {
                    _loc_5 = _loc_5 + _loc_12;
                    _loc_7 = new FlexChildInfo();
                    _loc_7.percent = _loc_12;
                    _loc_7.min = _loc_8.minHeight;
                    _loc_7.max = _loc_8.maxHeight;
                    _loc_7.width = _loc_13;
                    _loc_7.child = _loc_8;
                    _loc_6.push(_loc_7);
                }
                else
                {
                    _loc_14 = _loc_8.getExplicitOrMeasuredHeight();
                    if (_loc_8.scaleX == 1 && _loc_8.scaleY == 1)
                    {
                        _loc_8.setActualSize(Math.floor(_loc_13), Math.floor(_loc_14));
                    }
                    else
                    {
                        _loc_8.setActualSize(_loc_13, _loc_14);
                    }
                    if (_loc_8.includeInLayout)
                    {
                        _loc_4 = _loc_4 - _loc_8.height;
                    }
                }
                _loc_9++;
            }
            if (_loc_5)
            {
                _loc_4 = flexChildrenProportionally(param2, _loc_4, _loc_5, _loc_6);
                _loc_10 = _loc_6.length;
                _loc_9 = 0;
                while (_loc_9 < _loc_10)
                {
                    
                    _loc_7 = _loc_6[_loc_9];
                    _loc_8 = _loc_7.child;
                    if (_loc_8.scaleX == 1 && _loc_8.scaleY == 1)
                    {
                        _loc_8.setActualSize(Math.floor(_loc_7.width), Math.floor(_loc_7.size));
                    }
                    else
                    {
                        _loc_8.setActualSize(_loc_7.width, _loc_7.size);
                    }
                    _loc_9++;
                }
                if (FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0)
                {
                    distributeExtraHeight(param1, param2);
                }
            }
            return _loc_4;
        }// end function

    }
}
