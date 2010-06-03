package mx.containers.utilityClasses
{
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;
    import mx.containers.errors.*;
    import mx.core.*;
    import mx.events.*;

    public class CanvasLayout extends Layout
    {
        private var colSpanChildren:Array;
        private var constraintRegionsInUse:Boolean = false;
        private var rowSpanChildren:Array;
        private var constraintCache:Dictionary;
        private var _contentArea:Rectangle;
        static const VERSION:String = "3.2.0.3958";
        private static var r:Rectangle = new Rectangle();

        public function CanvasLayout()
        {
            colSpanChildren = [];
            rowSpanChildren = [];
            constraintCache = new Dictionary(true);
            return;
        }// end function

        private function parseConstraints(param1:IUIComponent = null) : ChildConstraintInfo
        {
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_6:Number = NaN;
            var _loc_7:Number = NaN;
            var _loc_8:Number = NaN;
            var _loc_9:Number = NaN;
            var _loc_10:String = null;
            var _loc_11:String = null;
            var _loc_12:String = null;
            var _loc_13:String = null;
            var _loc_14:String = null;
            var _loc_15:String = null;
            var _loc_16:String = null;
            var _loc_17:Array = null;
            var _loc_18:int = 0;
            var _loc_30:ConstraintColumn = null;
            var _loc_31:Boolean = false;
            var _loc_32:ConstraintRow = null;
            var _loc_2:* = getLayoutConstraints(param1);
            if (!_loc_2)
            {
                return null;
            }
            while (true)
            {
                
                _loc_17 = parseConstraintExp(_loc_2.left);
                if (!_loc_17)
                {
                    _loc_3 = NaN;
                }
                else if (_loc_17.length == 1)
                {
                    _loc_3 = Number(_loc_17[0]);
                }
                else
                {
                    _loc_10 = _loc_17[0];
                    _loc_3 = _loc_17[1];
                }
                _loc_17 = parseConstraintExp(_loc_2.right);
                if (!_loc_17)
                {
                    _loc_4 = NaN;
                }
                else if (_loc_17.length == 1)
                {
                    _loc_4 = Number(_loc_17[0]);
                }
                else
                {
                    _loc_11 = _loc_17[0];
                    _loc_4 = _loc_17[1];
                }
                _loc_17 = parseConstraintExp(_loc_2.horizontalCenter);
                if (!_loc_17)
                {
                    _loc_5 = NaN;
                }
                else if (_loc_17.length == 1)
                {
                    _loc_5 = Number(_loc_17[0]);
                }
                else
                {
                    _loc_12 = _loc_17[0];
                    _loc_5 = _loc_17[1];
                }
                _loc_17 = parseConstraintExp(_loc_2.top);
                if (!_loc_17)
                {
                    _loc_6 = NaN;
                }
                else if (_loc_17.length == 1)
                {
                    _loc_6 = Number(_loc_17[0]);
                }
                else
                {
                    _loc_13 = _loc_17[0];
                    _loc_6 = _loc_17[1];
                }
                _loc_17 = parseConstraintExp(_loc_2.bottom);
                if (!_loc_17)
                {
                    _loc_7 = NaN;
                }
                else if (_loc_17.length == 1)
                {
                    _loc_7 = Number(_loc_17[0]);
                }
                else
                {
                    _loc_14 = _loc_17[0];
                    _loc_7 = _loc_17[1];
                }
                _loc_17 = parseConstraintExp(_loc_2.verticalCenter);
                if (!_loc_17)
                {
                    _loc_8 = NaN;
                }
                else if (_loc_17.length == 1)
                {
                    _loc_8 = Number(_loc_17[0]);
                }
                else
                {
                    _loc_15 = _loc_17[0];
                    _loc_8 = _loc_17[1];
                }
                _loc_17 = parseConstraintExp(_loc_2.baseline);
                if (!_loc_17)
                {
                    _loc_9 = NaN;
                }
                else if (_loc_17.length == 1)
                {
                    _loc_9 = Number(_loc_17[0]);
                }
                else
                {
                    _loc_16 = _loc_17[0];
                    _loc_9 = _loc_17[1];
                }
                break;
            }
            var _loc_19:* = new ContentColumnChild();
            var _loc_20:Boolean = false;
            var _loc_21:Number = 0;
            var _loc_22:Number = 0;
            var _loc_23:Number = 0;
            _loc_18 = 0;
            while (_loc_18 < IConstraintLayout(target).constraintColumns.length)
            {
                
                _loc_30 = IConstraintLayout(target).constraintColumns[_loc_18];
                if (mx_internal::contentSize)
                {
                    if (_loc_30.id == _loc_10)
                    {
                        _loc_19.leftCol = _loc_30;
                        _loc_19.leftOffset = _loc_3;
                        var _loc_33:* = _loc_18;
                        _loc_21 = _loc_18;
                        _loc_19.left = _loc_33;
                        _loc_20 = true;
                    }
                    if (_loc_30.id == _loc_11)
                    {
                        _loc_19.rightCol = _loc_30;
                        _loc_19.rightOffset = _loc_4;
                        var _loc_33:* = _loc_18 + 1;
                        _loc_22 = _loc_18 + 1;
                        _loc_19.right = _loc_33;
                        _loc_20 = true;
                    }
                    if (_loc_30.id == _loc_12)
                    {
                        _loc_19.hcCol = _loc_30;
                        _loc_19.hcOffset = _loc_5;
                        var _loc_33:* = _loc_18 + 1;
                        _loc_23 = _loc_18 + 1;
                        _loc_19.hc = _loc_33;
                        _loc_20 = true;
                    }
                }
                _loc_18++;
            }
            if (_loc_20)
            {
                _loc_19.child = param1;
                if (_loc_19.leftCol && !_loc_19.rightCol || _loc_19.rightCol && !_loc_19.leftCol || _loc_19.hcCol)
                {
                    _loc_19.span = 1;
                }
                else
                {
                    _loc_19.span = _loc_22 - _loc_21;
                }
                _loc_31 = false;
                _loc_18 = 0;
                while (_loc_18 < colSpanChildren.length)
                {
                    
                    if (_loc_19.child == colSpanChildren[_loc_18].child)
                    {
                        _loc_31 = true;
                        break;
                    }
                    _loc_18++;
                }
                if (true)
                {
                    colSpanChildren.push(_loc_19);
                }
            }
            _loc_20 = false;
            var _loc_24:* = new ContentRowChild();
            var _loc_25:Number = 0;
            var _loc_26:Number = 0;
            var _loc_27:Number = 0;
            var _loc_28:Number = 0;
            _loc_18 = 0;
            while (_loc_18 < IConstraintLayout(target).constraintRows.length)
            {
                
                _loc_32 = IConstraintLayout(target).constraintRows[_loc_18];
                if (mx_internal::contentSize)
                {
                    if (_loc_32.id == _loc_13)
                    {
                        _loc_24.topRow = _loc_32;
                        _loc_24.topOffset = _loc_6;
                        var _loc_33:* = _loc_18;
                        _loc_25 = _loc_18;
                        _loc_24.top = _loc_33;
                        _loc_20 = true;
                    }
                    if (_loc_32.id == _loc_14)
                    {
                        _loc_24.bottomRow = _loc_32;
                        _loc_24.bottomOffset = _loc_7;
                        var _loc_33:* = _loc_18 + 1;
                        _loc_26 = _loc_18 + 1;
                        _loc_24.bottom = _loc_33;
                        _loc_20 = true;
                    }
                    if (_loc_32.id == _loc_15)
                    {
                        _loc_24.vcRow = _loc_32;
                        _loc_24.vcOffset = _loc_8;
                        var _loc_33:* = _loc_18 + 1;
                        _loc_27 = _loc_18 + 1;
                        _loc_24.vc = _loc_33;
                        _loc_20 = true;
                    }
                    if (_loc_32.id == _loc_16)
                    {
                        _loc_24.baselineRow = _loc_32;
                        _loc_24.baselineOffset = _loc_9;
                        var _loc_33:* = _loc_18 + 1;
                        _loc_28 = _loc_18 + 1;
                        _loc_24.baseline = _loc_33;
                        _loc_20 = true;
                    }
                }
                _loc_18++;
            }
            if (_loc_20)
            {
                _loc_24.child = param1;
                if (_loc_24.topRow && !_loc_24.bottomRow || _loc_24.bottomRow && !_loc_24.topRow || _loc_24.vcRow || _loc_24.baselineRow)
                {
                    _loc_24.span = 1;
                }
                else
                {
                    _loc_24.span = _loc_26 - _loc_25;
                }
                _loc_31 = false;
                _loc_18 = 0;
                while (_loc_18 < rowSpanChildren.length)
                {
                    
                    if (_loc_24.child == rowSpanChildren[_loc_18].child)
                    {
                        _loc_31 = true;
                        break;
                    }
                    _loc_18++;
                }
                if (true)
                {
                    rowSpanChildren.push(_loc_24);
                }
            }
            var _loc_29:* = new ChildConstraintInfo(_loc_3, _loc_4, _loc_5, _loc_6, _loc_7, _loc_8, _loc_9, _loc_10, _loc_11, _loc_12, _loc_13, _loc_14, _loc_15, _loc_16);
            constraintCache[param1] = _loc_29;
            return _loc_29;
        }// end function

        private function bound(param1:Number, param2:Number, param3:Number) : Number
        {
            if (param1 < param2)
            {
                param1 = param2;
            }
            else if (param1 > param3)
            {
                param1 = param3;
            }
            else
            {
                param1 = Math.floor(param1);
            }
            return param1;
        }// end function

        private function shareRowSpace(param1:ContentRowChild, param2:Number) : Number
        {
            var _loc_11:Number = NaN;
            var _loc_12:Number = NaN;
            var _loc_13:Number = NaN;
            var _loc_3:* = param1.topRow;
            var _loc_4:* = param1.bottomRow;
            var _loc_5:* = param1.child;
            var _loc_6:Number = 0;
            var _loc_7:Number = 0;
            var _loc_8:* = param1.topOffset ? (param1.topOffset) : (0);
            var _loc_9:* = param1.bottomOffset ? (param1.bottomOffset) : (0);
            if (_loc_3 && _loc_3.height)
            {
                _loc_6 = _loc_6 + _loc_3.height;
            }
            else if (_loc_4 && !_loc_3)
            {
                _loc_3 = IConstraintLayout(target).constraintRows[param1.bottom - 2];
                if (_loc_3 && _loc_3.height)
                {
                    _loc_6 = _loc_6 + _loc_3.height;
                }
            }
            if (_loc_4 && _loc_4.height)
            {
                _loc_7 = _loc_7 + _loc_4.height;
            }
            else if (_loc_3 && !_loc_4)
            {
                _loc_4 = IConstraintLayout(target).constraintRows[param1.top + 1];
                if (_loc_4 && _loc_4.height)
                {
                    _loc_7 = _loc_7 + _loc_4.height;
                }
            }
            if (_loc_3 && isNaN(_loc_3.height))
            {
                _loc_3.setActualHeight(Math.max(0, _loc_3.maxHeight));
            }
            if (_loc_4 && isNaN(_loc_4.height))
            {
                _loc_4.setActualHeight(Math.max(0, _loc_4.height));
            }
            var _loc_10:* = _loc_5.getExplicitOrMeasuredHeight();
            if (_loc_5.getExplicitOrMeasuredHeight())
            {
                if (!param1.topRow)
                {
                    if (_loc_10 > _loc_6)
                    {
                        _loc_12 = _loc_10 - _loc_6 + _loc_9;
                    }
                    else
                    {
                        _loc_12 = _loc_10 + _loc_9;
                    }
                }
                if (!param1.bottomRow)
                {
                    if (_loc_10 > _loc_7)
                    {
                        _loc_11 = _loc_10 - _loc_7 + _loc_8;
                    }
                    else
                    {
                        _loc_11 = _loc_10 + _loc_8;
                    }
                }
                if (param1.topRow && param1.bottomRow)
                {
                    _loc_13 = _loc_10 / Number(param1.span);
                    if (_loc_13 + _loc_8 < _loc_6)
                    {
                        _loc_11 = _loc_6;
                        _loc_12 = _loc_10 - (_loc_6 - _loc_8) + _loc_9;
                    }
                    else
                    {
                        _loc_11 = _loc_13 + _loc_8;
                    }
                    if (_loc_13 + _loc_9 < _loc_7)
                    {
                        _loc_12 = _loc_7;
                        _loc_11 = _loc_10 - (_loc_7 - _loc_9) + _loc_8;
                    }
                    else
                    {
                        _loc_12 = _loc_13 + _loc_9;
                    }
                }
                _loc_12 = bound(_loc_12, _loc_4.minHeight, _loc_4.maxHeight);
                _loc_4.setActualHeight(_loc_12);
                param2 = param2 - _loc_12;
                _loc_11 = bound(_loc_11, _loc_3.minHeight, _loc_3.maxHeight);
                _loc_3.setActualHeight(_loc_11);
                param2 = param2 - _loc_11;
            }
            return param2;
        }// end function

        private function parseConstraintExp(param1:String) : Array
        {
            if (!param1)
            {
                return null;
            }
            var _loc_2:* = param1.replace(/:/g, " ");
            var _loc_3:* = _loc_2.split(/\s+/);
            return _loc_3;
        }// end function

        private function measureColumnsAndRows() : void
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_13:ConstraintColumn = null;
            var _loc_14:ConstraintRow = null;
            var _loc_15:Number = NaN;
            var _loc_16:Number = NaN;
            var _loc_17:Number = NaN;
            var _loc_18:Number = NaN;
            var _loc_19:ContentColumnChild = null;
            var _loc_20:ContentRowChild = null;
            var _loc_1:* = IConstraintLayout(target).constraintColumns;
            var _loc_2:* = IConstraintLayout(target).constraintRows;
            if (!_loc_2.length > 0 && !_loc_1.length > 0)
            {
                constraintRegionsInUse = false;
                return;
            }
            constraintRegionsInUse = true;
            var _loc_5:Number = 0;
            var _loc_6:Number = 0;
            var _loc_7:* = Container(target).viewMetrics;
            var _loc_8:* = Container(target).width - _loc_7.left - _loc_7.right;
            var _loc_9:* = Container(target).height - _loc_7.top - _loc_7.bottom;
            var _loc_10:Array = [];
            var _loc_11:Array = [];
            var _loc_12:Array = [];
            if (_loc_1.length > 0)
            {
                _loc_3 = 0;
                while (_loc_3 < _loc_1.length)
                {
                    
                    _loc_13 = _loc_1[_loc_3];
                    if (!isNaN(_loc_13.percentWidth))
                    {
                        _loc_11.push(_loc_13);
                    }
                    else if (!isNaN(_loc_13.width) && !mx_internal::contentSize)
                    {
                        _loc_10.push(_loc_13);
                    }
                    else
                    {
                        _loc_12.push(_loc_13);
                        mx_internal::contentSize = true;
                    }
                    _loc_3++;
                }
                _loc_3 = 0;
                while (_loc_3 < _loc_10.length)
                {
                    
                    _loc_13 = ConstraintColumn(_loc_10[_loc_3]);
                    _loc_8 = _loc_8 - _loc_13.width;
                    _loc_3++;
                }
                if (_loc_12.length > 0)
                {
                    if (colSpanChildren.length > 0)
                    {
                        colSpanChildren.sortOn("span");
                        _loc_4 = 0;
                        while (_loc_4 < colSpanChildren.length)
                        {
                            
                            _loc_19 = colSpanChildren[_loc_4];
                            if (_loc_19.span == 1)
                            {
                                if (_loc_19.hcCol)
                                {
                                    _loc_13 = ConstraintColumn(_loc_1[_loc_1.indexOf(_loc_19.hcCol)]);
                                }
                                else if (_loc_19.leftCol)
                                {
                                    _loc_13 = ConstraintColumn(_loc_1[_loc_1.indexOf(_loc_19.leftCol)]);
                                }
                                else if (_loc_19.rightCol)
                                {
                                    _loc_13 = ConstraintColumn(_loc_1[_loc_1.indexOf(_loc_19.rightCol)]);
                                }
                                _loc_16 = _loc_19.child.getExplicitOrMeasuredWidth();
                                if (_loc_19.hcOffset)
                                {
                                    _loc_16 = _loc_16 + _loc_19.hcOffset;
                                }
                                else
                                {
                                    if (_loc_19.leftOffset)
                                    {
                                        _loc_16 = _loc_16 + _loc_19.leftOffset;
                                    }
                                    if (_loc_19.rightOffset)
                                    {
                                        _loc_16 = _loc_16 + _loc_19.rightOffset;
                                    }
                                }
                                if (!isNaN(_loc_13.width))
                                {
                                    _loc_16 = Math.max(_loc_13.width, _loc_16);
                                }
                                _loc_16 = bound(_loc_16, _loc_13.minWidth, _loc_13.maxWidth);
                                _loc_13.setActualWidth(_loc_16);
                                _loc_8 = _loc_8 - _loc_13.width;
                            }
                            else
                            {
                                _loc_8 = shareColumnSpace(_loc_19, _loc_8);
                            }
                            _loc_4++;
                        }
                        colSpanChildren = [];
                    }
                    _loc_3 = 0;
                    while (_loc_3 < _loc_12.length)
                    {
                        
                        _loc_13 = _loc_12[_loc_3];
                        if (!_loc_13.width)
                        {
                            _loc_16 = bound(0, _loc_13.minWidth, 0);
                            _loc_13.setActualWidth(_loc_16);
                        }
                        _loc_3++;
                    }
                }
                _loc_18 = _loc_8;
                _loc_3 = 0;
                while (_loc_3 < _loc_11.length)
                {
                    
                    _loc_13 = ConstraintColumn(_loc_11[_loc_3]);
                    if (_loc_18 <= 0)
                    {
                        _loc_16 = 0;
                    }
                    else
                    {
                        _loc_16 = Math.round(_loc_18 * _loc_13.percentWidth / 100);
                    }
                    _loc_16 = bound(_loc_16, _loc_13.minWidth, _loc_13.maxWidth);
                    _loc_13.setActualWidth(_loc_16);
                    _loc_8 = _loc_8 - _loc_16;
                    _loc_3++;
                }
                _loc_3 = 0;
                while (_loc_3 < _loc_1.length)
                {
                    
                    _loc_13 = ConstraintColumn(_loc_1[_loc_3]);
                    _loc_13.x = _loc_5;
                    _loc_5 = _loc_5 + _loc_13.width;
                    _loc_3++;
                }
            }
            _loc_10 = [];
            _loc_11 = [];
            _loc_12 = [];
            if (_loc_2.length > 0)
            {
                _loc_3 = 0;
                while (_loc_3 < _loc_2.length)
                {
                    
                    _loc_14 = _loc_2[_loc_3];
                    if (!isNaN(_loc_14.percentHeight))
                    {
                        _loc_11.push(_loc_14);
                    }
                    else if (!isNaN(_loc_14.height) && !mx_internal::contentSize)
                    {
                        _loc_10.push(_loc_14);
                    }
                    else
                    {
                        _loc_12.push(_loc_14);
                        mx_internal::contentSize = true;
                    }
                    _loc_3++;
                }
                _loc_3 = 0;
                while (_loc_3 < _loc_10.length)
                {
                    
                    _loc_14 = ConstraintRow(_loc_10[_loc_3]);
                    _loc_9 = _loc_9 - _loc_14.height;
                    _loc_3++;
                }
                if (_loc_12.length > 0)
                {
                    if (rowSpanChildren.length > 0)
                    {
                        rowSpanChildren.sortOn("span");
                        _loc_4 = 0;
                        while (_loc_4 < rowSpanChildren.length)
                        {
                            
                            _loc_20 = rowSpanChildren[_loc_4];
                            if (_loc_20.span == 1)
                            {
                                if (_loc_20.vcRow)
                                {
                                    _loc_14 = ConstraintRow(_loc_2[_loc_2.indexOf(_loc_20.vcRow)]);
                                }
                                else if (_loc_20.baselineRow)
                                {
                                    _loc_14 = ConstraintRow(_loc_2[_loc_2.indexOf(_loc_20.baselineRow)]);
                                }
                                else if (_loc_20.topRow)
                                {
                                    _loc_14 = ConstraintRow(_loc_2[_loc_2.indexOf(_loc_20.topRow)]);
                                }
                                else if (_loc_20.bottomRow)
                                {
                                    _loc_14 = ConstraintRow(_loc_2[_loc_2.indexOf(_loc_20.bottomRow)]);
                                }
                                _loc_17 = _loc_20.child.getExplicitOrMeasuredHeight();
                                if (_loc_20.baselineOffset)
                                {
                                    _loc_17 = _loc_17 + _loc_20.baselineOffset;
                                }
                                else if (_loc_20.vcOffset)
                                {
                                    _loc_17 = _loc_17 + _loc_20.vcOffset;
                                }
                                else
                                {
                                    if (_loc_20.topOffset)
                                    {
                                        _loc_17 = _loc_17 + _loc_20.topOffset;
                                    }
                                    if (_loc_20.bottomOffset)
                                    {
                                        _loc_17 = _loc_17 + _loc_20.bottomOffset;
                                    }
                                }
                                if (!isNaN(_loc_14.height))
                                {
                                    _loc_17 = Math.max(_loc_14.height, _loc_17);
                                }
                                _loc_17 = bound(_loc_17, _loc_14.minHeight, _loc_14.maxHeight);
                                _loc_14.setActualHeight(_loc_17);
                                _loc_9 = _loc_9 - _loc_14.height;
                            }
                            else
                            {
                                _loc_9 = shareRowSpace(_loc_20, _loc_9);
                            }
                            _loc_4++;
                        }
                        rowSpanChildren = [];
                    }
                    _loc_3 = 0;
                    while (_loc_3 < _loc_12.length)
                    {
                        
                        _loc_14 = ConstraintRow(_loc_12[_loc_3]);
                        if (!_loc_14.height)
                        {
                            _loc_17 = bound(0, _loc_14.minHeight, 0);
                            _loc_14.setActualHeight(_loc_17);
                        }
                        _loc_3++;
                    }
                }
                _loc_18 = _loc_9;
                _loc_3 = 0;
                while (_loc_3 < _loc_11.length)
                {
                    
                    _loc_14 = ConstraintRow(_loc_11[_loc_3]);
                    if (_loc_18 <= 0)
                    {
                        _loc_17 = 0;
                    }
                    else
                    {
                        _loc_17 = Math.round(_loc_18 * _loc_14.percentHeight / 100);
                    }
                    _loc_17 = bound(_loc_17, _loc_14.minHeight, _loc_14.maxHeight);
                    _loc_14.setActualHeight(_loc_17);
                    _loc_9 = _loc_9 - _loc_17;
                    _loc_3++;
                }
                _loc_3 = 0;
                while (_loc_3 < _loc_2.length)
                {
                    
                    _loc_14 = _loc_2[_loc_3];
                    _loc_14.y = _loc_6;
                    _loc_6 = _loc_6 + _loc_14.height;
                    _loc_3++;
                }
            }
            return;
        }// end function

        private function child_moveHandler(event:MoveEvent) : void
        {
            if (event.target is IUIComponent)
            {
                if (!IUIComponent(event.target).includeInLayout)
                {
                    return;
                }
            }
            var _loc_2:* = super.target;
            if (_loc_2)
            {
                _loc_2.invalidateSize();
                _loc_2.invalidateDisplayList();
                _contentArea = null;
            }
            return;
        }// end function

        private function applyAnchorStylesDuringMeasure(param1:IUIComponent, param2:Rectangle) : void
        {
            var _loc_13:int = 0;
            var _loc_3:* = param1 as IConstraintClient;
            if (!_loc_3)
            {
                return;
            }
            var _loc_4:* = constraintCache[_loc_3];
            if (!constraintCache[_loc_3])
            {
                _loc_4 = parseConstraints(param1);
            }
            var _loc_5:* = _loc_4.left;
            var _loc_6:* = _loc_4.right;
            var _loc_7:* = _loc_4.hc;
            var _loc_8:* = _loc_4.top;
            var _loc_9:* = _loc_4.bottom;
            var _loc_10:* = _loc_4.vc;
            var _loc_11:* = IConstraintLayout(target).constraintColumns;
            var _loc_12:* = IConstraintLayout(target).constraintRows;
            var _loc_14:Number = 0;
            if (!_loc_11.length > 0)
            {
                if (!isNaN(_loc_7))
                {
                    param2.x = Math.round((target.width - param1.width) / 2 + _loc_7);
                }
                else if (!isNaN(_loc_5) && !isNaN(_loc_6))
                {
                    param2.x = _loc_5;
                    param2.width = param2.width + _loc_6;
                }
                else if (!isNaN(_loc_5))
                {
                    param2.x = _loc_5;
                }
                else if (!isNaN(_loc_6))
                {
                    param2.x = 0;
                    param2.width = param2.width + _loc_6;
                }
            }
            else
            {
                param2.x = 0;
                _loc_13 = 0;
                while (_loc_13 < _loc_11.length)
                {
                    
                    _loc_14 = _loc_14 + ConstraintColumn(_loc_11[_loc_13]).width;
                    _loc_13++;
                }
                param2.width = _loc_14;
            }
            if (!_loc_12.length > 0)
            {
                if (!isNaN(_loc_10))
                {
                    param2.y = Math.round((target.height - param1.height) / 2 + _loc_10);
                }
                else if (!isNaN(_loc_8) && !isNaN(_loc_9))
                {
                    param2.y = _loc_8;
                    param2.height = param2.height + _loc_9;
                }
                else if (!isNaN(_loc_8))
                {
                    param2.y = _loc_8;
                }
                else if (!isNaN(_loc_9))
                {
                    param2.y = 0;
                    param2.height = param2.height + _loc_9;
                }
            }
            else
            {
                _loc_14 = 0;
                param2.y = 0;
                _loc_13 = 0;
                while (_loc_13 < _loc_12.length)
                {
                    
                    _loc_14 = _loc_14 + ConstraintRow(_loc_12[_loc_13]).height;
                    _loc_13++;
                }
                param2.height = _loc_14;
            }
            return;
        }// end function

        override public function measure() : void
        {
            var _loc_1:Container = null;
            var _loc_5:EdgeMetrics = null;
            var _loc_6:Rectangle = null;
            var _loc_7:IUIComponent = null;
            var _loc_8:ConstraintColumn = null;
            var _loc_9:ConstraintRow = null;
            _loc_1 = super.target;
            var _loc_2:Number = 0;
            var _loc_3:Number = 0;
            var _loc_4:Number = 0;
            _loc_5 = _loc_1.viewMetrics;
            _loc_4 = 0;
            while (_loc_4++ < _loc_1.numChildren)
            {
                
                _loc_7 = _loc_1.getChildAt(_loc_4) as IUIComponent;
                parseConstraints(_loc_7);
            }
            _loc_4 = 0;
            while (_loc_4++ < IConstraintLayout(_loc_1).constraintColumns.length)
            {
                
                _loc_8 = IConstraintLayout(_loc_1).constraintColumns[_loc_4];
                if (mx_internal::contentSize)
                {
                    mx_internal::_width = NaN;
                }
            }
            _loc_4 = 0;
            while (_loc_4++ < IConstraintLayout(_loc_1).constraintRows.length)
            {
                
                _loc_9 = IConstraintLayout(_loc_1).constraintRows[_loc_4];
                if (mx_internal::contentSize)
                {
                    mx_internal::_height = NaN;
                }
            }
            measureColumnsAndRows();
            _contentArea = null;
            _loc_6 = measureContentArea();
            _loc_1.measuredWidth = _loc_6.width + _loc_5.left + _loc_5.right;
            _loc_1.measuredHeight = _loc_6.height + _loc_5.top + _loc_5.bottom;
            return;
        }// end function

        private function target_childRemoveHandler(event:ChildExistenceChangedEvent) : void
        {
            DisplayObject(event.relatedObject).removeEventListener(MoveEvent.MOVE, child_moveHandler);
            delete constraintCache[event.relatedObject];
            return;
        }// end function

        override public function set target(param1:Container) : void
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_2:* = super.target;
            if (param1 != _loc_2)
            {
                if (_loc_2)
                {
                    _loc_2.removeEventListener(ChildExistenceChangedEvent.CHILD_ADD, target_childAddHandler);
                    _loc_2.removeEventListener(ChildExistenceChangedEvent.CHILD_REMOVE, target_childRemoveHandler);
                    _loc_4 = _loc_2.numChildren;
                    _loc_3 = 0;
                    while (_loc_3 < _loc_4)
                    {
                        
                        DisplayObject(_loc_2.getChildAt(_loc_3)).removeEventListener(MoveEvent.MOVE, child_moveHandler);
                        _loc_3++;
                    }
                }
                if (param1)
                {
                    param1.addEventListener(ChildExistenceChangedEvent.CHILD_ADD, target_childAddHandler);
                    param1.addEventListener(ChildExistenceChangedEvent.CHILD_REMOVE, target_childRemoveHandler);
                    _loc_4 = param1.numChildren;
                    _loc_3 = 0;
                    while (_loc_3 < _loc_4)
                    {
                        
                        DisplayObject(param1.getChildAt(_loc_3)).addEventListener(MoveEvent.MOVE, child_moveHandler);
                        _loc_3++;
                    }
                }
                super.target = param1;
            }
            return;
        }// end function

        private function measureContentArea() : Rectangle
        {
            var _loc_1:int = 0;
            var _loc_3:Array = null;
            var _loc_4:Array = null;
            var _loc_5:IUIComponent = null;
            var _loc_6:LayoutConstraints = null;
            var _loc_7:Number = NaN;
            var _loc_8:Number = NaN;
            var _loc_9:Number = NaN;
            var _loc_10:Number = NaN;
            var _loc_11:Number = NaN;
            var _loc_12:Number = NaN;
            if (_contentArea)
            {
                return _contentArea;
            }
            _contentArea = new Rectangle();
            var _loc_2:* = target.numChildren;
            if (_loc_2 == 0 && constraintRegionsInUse)
            {
                _loc_3 = IConstraintLayout(target).constraintColumns;
                _loc_4 = IConstraintLayout(target).constraintRows;
                if (_loc_3.length > 0)
                {
                    _contentArea.right = _loc_3[_loc_3.length--].x + _loc_3[_loc_3.length--].width;
                }
                else
                {
                    _contentArea.right = 0;
                }
                if (_loc_4.length > 0)
                {
                    _contentArea.bottom = _loc_4[_loc_4.length--].y + _loc_4[_loc_4.length--].height;
                }
                else
                {
                    _contentArea.bottom = 0;
                }
            }
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                _loc_5 = target.getChildAt(_loc_1) as IUIComponent;
                _loc_6 = getLayoutConstraints(_loc_5);
                if (!_loc_5.includeInLayout)
                {
                }
                else
                {
                    _loc_7 = _loc_5.x;
                    _loc_8 = _loc_5.y;
                    _loc_9 = _loc_5.getExplicitOrMeasuredWidth();
                    _loc_10 = _loc_5.getExplicitOrMeasuredHeight();
                    if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
                    {
                        if (!isNaN(_loc_5.percentWidth) || _loc_6 && !isNaN(_loc_6.left) && !isNaN(_loc_6.right))
                        {
                            _loc_9 = _loc_5.minWidth;
                        }
                    }
                    else if (!isNaN(_loc_5.percentWidth) || _loc_6 && !isNaN(_loc_6.left) && !isNaN(_loc_6.right) && isNaN(_loc_5.explicitWidth))
                    {
                        _loc_9 = _loc_5.minWidth;
                    }
                    if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
                    {
                        if (!isNaN(_loc_5.percentHeight) || _loc_6 && !isNaN(_loc_6.top) && !isNaN(_loc_6.bottom))
                        {
                            _loc_10 = _loc_5.minHeight;
                        }
                    }
                    else if (!isNaN(_loc_5.percentHeight) || _loc_6 && !isNaN(_loc_6.top) && !isNaN(_loc_6.bottom) && isNaN(_loc_5.explicitHeight))
                    {
                        _loc_10 = _loc_5.minHeight;
                    }
                    r.x = _loc_7;
                    r.y = _loc_8;
                    r.width = _loc_9;
                    r.height = _loc_10;
                    applyAnchorStylesDuringMeasure(_loc_5, r);
                    _loc_7 = r.x;
                    _loc_8 = r.y;
                    _loc_9 = r.width;
                    _loc_10 = r.height;
                    if (isNaN(_loc_7))
                    {
                        _loc_7 = _loc_5.x;
                    }
                    if (isNaN(_loc_8))
                    {
                        _loc_8 = _loc_5.y;
                    }
                    _loc_11 = _loc_7;
                    _loc_12 = _loc_8;
                    if (isNaN(_loc_9))
                    {
                        _loc_9 = _loc_5.width;
                    }
                    if (isNaN(_loc_10))
                    {
                        _loc_10 = _loc_5.height;
                    }
                    _loc_11 = _loc_11 + _loc_9;
                    _loc_12 = _loc_12 + _loc_10;
                    _contentArea.right = Math.max(_contentArea.right, _loc_11);
                    _contentArea.bottom = Math.max(_contentArea.bottom, _loc_12);
                }
                _loc_1++;
            }
            return _contentArea;
        }// end function

        private function shareColumnSpace(param1:ContentColumnChild, param2:Number) : Number
        {
            var _loc_11:Number = NaN;
            var _loc_12:Number = NaN;
            var _loc_13:Number = NaN;
            var _loc_3:* = param1.leftCol;
            var _loc_4:* = param1.rightCol;
            var _loc_5:* = param1.child;
            var _loc_6:Number = 0;
            var _loc_7:Number = 0;
            var _loc_8:* = param1.rightOffset ? (param1.rightOffset) : (0);
            var _loc_9:* = param1.leftOffset ? (param1.leftOffset) : (0);
            if (_loc_3 && _loc_3.width)
            {
                _loc_6 = _loc_6 + _loc_3.width;
            }
            else if (_loc_4 && !_loc_3)
            {
                _loc_3 = IConstraintLayout(target).constraintColumns[param1.right - 2];
                if (_loc_3 && _loc_3.width)
                {
                    _loc_6 = _loc_6 + _loc_3.width;
                }
            }
            if (_loc_4 && _loc_4.width)
            {
                _loc_7 = _loc_7 + _loc_4.width;
            }
            else if (_loc_3 && !_loc_4)
            {
                _loc_4 = IConstraintLayout(target).constraintColumns[param1.left + 1];
                if (_loc_4 && _loc_4.width)
                {
                    _loc_7 = _loc_7 + _loc_4.width;
                }
            }
            if (_loc_3 && isNaN(_loc_3.width))
            {
                _loc_3.setActualWidth(Math.max(0, _loc_3.maxWidth));
            }
            if (_loc_4 && isNaN(_loc_4.width))
            {
                _loc_4.setActualWidth(Math.max(0, _loc_4.maxWidth));
            }
            var _loc_10:* = _loc_5.getExplicitOrMeasuredWidth();
            if (_loc_5.getExplicitOrMeasuredWidth())
            {
                if (!param1.leftCol)
                {
                    if (_loc_10 > _loc_6)
                    {
                        _loc_12 = _loc_10 - _loc_6 + _loc_8;
                    }
                    else
                    {
                        _loc_12 = _loc_10 + _loc_8;
                    }
                }
                if (!param1.rightCol)
                {
                    if (_loc_10 > _loc_7)
                    {
                        _loc_11 = _loc_10 - _loc_7 + _loc_9;
                    }
                    else
                    {
                        _loc_11 = _loc_10 + _loc_9;
                    }
                }
                if (param1.leftCol && param1.rightCol)
                {
                    _loc_13 = _loc_10 / Number(param1.span);
                    if (_loc_13 + _loc_9 < _loc_6)
                    {
                        _loc_11 = _loc_6;
                        _loc_12 = _loc_10 - (_loc_6 - _loc_9) + _loc_8;
                    }
                    else
                    {
                        _loc_11 = _loc_13 + _loc_9;
                    }
                    if (_loc_13 + _loc_8 < _loc_7)
                    {
                        _loc_12 = _loc_7;
                        _loc_11 = _loc_10 - (_loc_7 - _loc_8) + _loc_9;
                    }
                    else
                    {
                        _loc_12 = _loc_13 + _loc_8;
                    }
                }
                _loc_11 = bound(_loc_11, _loc_3.minWidth, _loc_3.maxWidth);
                _loc_3.setActualWidth(_loc_11);
                param2 = param2 - _loc_11;
                _loc_12 = bound(_loc_12, _loc_4.minWidth, _loc_4.maxWidth);
                _loc_4.setActualWidth(_loc_12);
                param2 = param2 - _loc_12;
            }
            return param2;
        }// end function

        private function getLayoutConstraints(param1:IUIComponent) : LayoutConstraints
        {
            var _loc_2:* = param1 as IConstraintClient;
            if (!_loc_2)
            {
                return null;
            }
            var _loc_3:* = new LayoutConstraints();
            _loc_3.baseline = _loc_2.getConstraintValue("baseline");
            _loc_3.bottom = _loc_2.getConstraintValue("bottom");
            _loc_3.horizontalCenter = _loc_2.getConstraintValue("horizontalCenter");
            _loc_3.left = _loc_2.getConstraintValue("left");
            _loc_3.right = _loc_2.getConstraintValue("right");
            _loc_3.top = _loc_2.getConstraintValue("top");
            _loc_3.verticalCenter = _loc_2.getConstraintValue("verticalCenter");
            return _loc_3;
        }// end function

        override public function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_3:int = 0;
            var _loc_4:IUIComponent = null;
            var _loc_10:ConstraintColumn = null;
            var _loc_11:ConstraintRow = null;
            var _loc_5:* = super.target;
            var _loc_6:* = super.target.numChildren;
            mx_internal::doingLayout = false;
            var _loc_7:* = _loc_5.viewMetrics;
            mx_internal::doingLayout = true;
            var _loc_8:* = param1 - _loc_7.left - _loc_7.right;
            var _loc_9:* = param2 - _loc_7.top - _loc_7.bottom;
            if (IConstraintLayout(_loc_5).constraintColumns.length > 0 || IConstraintLayout(_loc_5).constraintRows.length > 0)
            {
                constraintRegionsInUse = true;
            }
            if (constraintRegionsInUse)
            {
                _loc_3 = 0;
                while (_loc_3 < _loc_6)
                {
                    
                    _loc_4 = _loc_5.getChildAt(_loc_3) as IUIComponent;
                    parseConstraints(_loc_4);
                    _loc_3++;
                }
                _loc_3 = 0;
                while (_loc_3 < IConstraintLayout(_loc_5).constraintColumns.length)
                {
                    
                    _loc_10 = IConstraintLayout(_loc_5).constraintColumns[_loc_3];
                    if (mx_internal::contentSize)
                    {
                        mx_internal::_width = NaN;
                    }
                    _loc_3++;
                }
                _loc_3 = 0;
                while (_loc_3 < IConstraintLayout(_loc_5).constraintRows.length)
                {
                    
                    _loc_11 = IConstraintLayout(_loc_5).constraintRows[_loc_3];
                    if (mx_internal::contentSize)
                    {
                        mx_internal::_height = NaN;
                    }
                    _loc_3++;
                }
                measureColumnsAndRows();
            }
            _loc_3 = 0;
            while (_loc_3 < _loc_6)
            {
                
                _loc_4 = _loc_5.getChildAt(_loc_3) as IUIComponent;
                applyAnchorStylesDuringUpdateDisplayList(_loc_8, _loc_9, _loc_4);
                _loc_3++;
            }
            return;
        }// end function

        private function applyAnchorStylesDuringUpdateDisplayList(param1:Number, param2:Number, param3:IUIComponent = null) : void
        {
            var _loc_20:int = 0;
            var _loc_21:Number = NaN;
            var _loc_22:Number = NaN;
            var _loc_23:Number = NaN;
            var _loc_24:Number = NaN;
            var _loc_25:String = null;
            var _loc_34:Number = NaN;
            var _loc_35:Number = NaN;
            var _loc_36:Number = NaN;
            var _loc_37:Number = NaN;
            var _loc_38:Number = NaN;
            var _loc_39:Boolean = false;
            var _loc_40:Boolean = false;
            var _loc_41:Boolean = false;
            var _loc_42:ConstraintColumn = null;
            var _loc_43:Boolean = false;
            var _loc_44:Boolean = false;
            var _loc_45:Boolean = false;
            var _loc_46:Boolean = false;
            var _loc_47:ConstraintRow = null;
            var _loc_4:* = param3 as IConstraintClient;
            if (!(param3 as IConstraintClient))
            {
                return;
            }
            var _loc_5:* = parseConstraints(param3);
            var _loc_6:* = parseConstraints(param3).left;
            var _loc_7:* = _loc_5.right;
            var _loc_8:* = _loc_5.hc;
            var _loc_9:* = _loc_5.top;
            var _loc_10:* = _loc_5.bottom;
            var _loc_11:* = _loc_5.vc;
            var _loc_12:* = _loc_5.baseline;
            var _loc_13:* = _loc_5.leftBoundary;
            var _loc_14:* = _loc_5.rightBoundary;
            var _loc_15:* = _loc_5.hcBoundary;
            var _loc_16:* = _loc_5.topBoundary;
            var _loc_17:* = _loc_5.bottomBoundary;
            var _loc_18:* = _loc_5.vcBoundary;
            var _loc_19:* = _loc_5.baselineBoundary;
            var _loc_26:Boolean = false;
            var _loc_27:Boolean = false;
            if (!_loc_15 && !_loc_13)
            {
            }
            var _loc_28:* = !_loc_14;
            if (!_loc_18 && !_loc_16 && !_loc_17)
            {
            }
            var _loc_29:* = !_loc_19;
            var _loc_30:Number = 0;
            var _loc_31:* = param1;
            var _loc_32:Number = 0;
            var _loc_33:* = param2;
            if (!_loc_28)
            {
                _loc_39 = _loc_13 ? (true) : (false);
                _loc_40 = _loc_14 ? (true) : (false);
                _loc_41 = _loc_15 ? (true) : (false);
                _loc_20 = 0;
                while (_loc_20 < IConstraintLayout(target).constraintColumns.length)
                {
                    
                    _loc_42 = ConstraintColumn(IConstraintLayout(target).constraintColumns[_loc_20]);
                    if (_loc_39)
                    {
                        if (_loc_13 == _loc_42.id)
                        {
                            _loc_30 = _loc_42.x;
                            _loc_39 = false;
                        }
                    }
                    if (_loc_40)
                    {
                        if (_loc_14 == _loc_42.id)
                        {
                            _loc_31 = _loc_42.x + _loc_42.width;
                            _loc_40 = false;
                        }
                    }
                    if (_loc_41)
                    {
                        if (_loc_15 == _loc_42.id)
                        {
                            _loc_35 = _loc_42.width;
                            _loc_37 = _loc_42.x;
                            _loc_41 = false;
                        }
                    }
                    _loc_20++;
                }
                if (_loc_39)
                {
                    _loc_25 = resourceManager.getString("containers", "columnNotFound", [_loc_13]);
                    throw new ConstraintError(_loc_25);
                }
                if (_loc_40)
                {
                    _loc_25 = resourceManager.getString("containers", "columnNotFound", [_loc_14]);
                    throw new ConstraintError(_loc_25);
                }
                if (_loc_41)
                {
                    _loc_25 = resourceManager.getString("containers", "columnNotFound", [_loc_15]);
                    throw new ConstraintError(_loc_25);
                }
            }
            else if (!_loc_28)
            {
                _loc_25 = resourceManager.getString("containers", "noColumnsFound");
                throw new ConstraintError(_loc_25);
            }
            param1 = Math.round(_loc_31 - _loc_30);
            if (!isNaN(_loc_6) && !isNaN(_loc_7))
            {
                _loc_21 = param1 - _loc_6 - _loc_7;
                if (_loc_21 < param3.minWidth)
                {
                    _loc_21 = param3.minWidth;
                }
            }
            else if (!isNaN(param3.percentWidth))
            {
                _loc_21 = param3.percentWidth / 100 * param1;
                _loc_21 = bound(_loc_21, param3.minWidth, param3.maxWidth);
                _loc_26 = true;
            }
            else
            {
                _loc_21 = param3.getExplicitOrMeasuredWidth();
            }
            if (!_loc_29 && IConstraintLayout(target).constraintRows.length > 0)
            {
                _loc_43 = _loc_16 ? (true) : (false);
                _loc_44 = _loc_17 ? (true) : (false);
                _loc_45 = _loc_18 ? (true) : (false);
                _loc_46 = _loc_19 ? (true) : (false);
                _loc_20 = 0;
                while (_loc_20 < IConstraintLayout(target).constraintRows.length)
                {
                    
                    _loc_47 = ConstraintRow(IConstraintLayout(target).constraintRows[_loc_20]);
                    if (_loc_43)
                    {
                        if (_loc_16 == _loc_47.id)
                        {
                            _loc_32 = _loc_47.y;
                            _loc_43 = false;
                        }
                    }
                    if (_loc_44)
                    {
                        if (_loc_17 == _loc_47.id)
                        {
                            _loc_33 = _loc_47.y + _loc_47.height;
                            _loc_44 = false;
                        }
                    }
                    if (_loc_45)
                    {
                        if (_loc_18 == _loc_47.id)
                        {
                            _loc_34 = _loc_47.height;
                            _loc_36 = _loc_47.y;
                            _loc_45 = false;
                        }
                    }
                    if (_loc_46)
                    {
                        if (_loc_19 == _loc_47.id)
                        {
                            _loc_38 = _loc_47.y;
                            _loc_46 = false;
                        }
                    }
                    _loc_20++;
                }
                if (_loc_43)
                {
                    _loc_25 = resourceManager.getString("containers", "rowNotFound", [_loc_16]);
                    throw new ConstraintError(_loc_25);
                }
                if (_loc_44)
                {
                    _loc_25 = resourceManager.getString("containers", "rowNotFound", [_loc_17]);
                    throw new ConstraintError(_loc_25);
                }
                if (_loc_45)
                {
                    _loc_25 = resourceManager.getString("containers", "rowNotFound", [_loc_18]);
                    throw new ConstraintError(_loc_25);
                }
                if (_loc_46)
                {
                    _loc_25 = resourceManager.getString("containers", "rowNotFound", [_loc_19]);
                    throw new ConstraintError(_loc_25);
                }
            }
            else if (!_loc_29 && IConstraintLayout(target).constraintRows.length <= 0)
            {
                _loc_25 = resourceManager.getString("containers", "noRowsFound");
                throw new ConstraintError(_loc_25);
            }
            param2 = Math.round(_loc_33 - _loc_32);
            if (!isNaN(_loc_9) && !isNaN(_loc_10))
            {
                _loc_22 = param2 - _loc_9 - _loc_10;
                if (_loc_22 < param3.minHeight)
                {
                    _loc_22 = param3.minHeight;
                }
            }
            else if (!isNaN(param3.percentHeight))
            {
                _loc_22 = param3.percentHeight / 100 * param2;
                _loc_22 = bound(_loc_22, param3.minHeight, param3.maxHeight);
                _loc_27 = true;
            }
            else
            {
                _loc_22 = param3.getExplicitOrMeasuredHeight();
            }
            if (!isNaN(_loc_8))
            {
                if (_loc_15)
                {
                    _loc_23 = Math.round((_loc_35 - _loc_21) / 2 + _loc_8 + _loc_37);
                }
                else
                {
                    _loc_23 = Math.round((param1 - _loc_21) / 2 + _loc_8);
                }
            }
            else if (!isNaN(_loc_6))
            {
                if (_loc_13)
                {
                    _loc_23 = _loc_30 + _loc_6;
                }
                else
                {
                    _loc_23 = _loc_6;
                }
            }
            else if (!isNaN(_loc_7))
            {
                if (_loc_14)
                {
                    _loc_23 = _loc_31 - _loc_7 - _loc_21;
                }
                else
                {
                    _loc_23 = param1 - _loc_7 - _loc_21;
                }
            }
            if (!isNaN(_loc_12))
            {
                if (_loc_19)
                {
                    _loc_24 = _loc_38 - param3.baselinePosition + _loc_12;
                }
                else
                {
                    _loc_24 = _loc_12;
                }
            }
            if (!isNaN(_loc_11))
            {
                if (_loc_18)
                {
                    _loc_24 = Math.round((_loc_34 - _loc_22) / 2 + _loc_11 + _loc_36);
                }
                else
                {
                    _loc_24 = Math.round((param2 - _loc_22) / 2 + _loc_11);
                }
            }
            else if (!isNaN(_loc_9))
            {
                if (_loc_16)
                {
                    _loc_24 = _loc_32 + _loc_9;
                }
                else
                {
                    _loc_24 = _loc_9;
                }
            }
            else if (!isNaN(_loc_10))
            {
                if (_loc_17)
                {
                    _loc_24 = _loc_33 - _loc_10 - _loc_22;
                }
                else
                {
                    _loc_24 = param2 - _loc_10 - _loc_22;
                }
            }
            _loc_23 = isNaN(_loc_23) ? (param3.x) : (_loc_23);
            _loc_24 = isNaN(_loc_24) ? (param3.y) : (_loc_24);
            param3.move(_loc_23, _loc_24);
            if (_loc_26)
            {
                if (_loc_23 + _loc_21 > param1)
                {
                    _loc_21 = Math.max(param1 - _loc_23, param3.minWidth);
                }
            }
            if (_loc_27)
            {
                if (_loc_24 + _loc_22 > param2)
                {
                    _loc_22 = Math.max(param2 - _loc_24, param3.minHeight);
                }
            }
            if (!isNaN(_loc_21) && !isNaN(_loc_22))
            {
                param3.setActualSize(_loc_21, _loc_22);
            }
            return;
        }// end function

        private function target_childAddHandler(event:ChildExistenceChangedEvent) : void
        {
            DisplayObject(event.relatedObject).addEventListener(MoveEvent.MOVE, child_moveHandler);
            return;
        }// end function

    }
}
