package mx.containers.utilityClasses
{
    import mx.core.*;

    public class ApplicationLayout extends BoxLayout
    {
        static const VERSION:String = "3.2.0.3958";

        public function ApplicationLayout()
        {
            return;
        }// end function

        override public function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_6:Number = NaN;
            var _loc_7:Number = NaN;
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            var _loc_10:IFlexDisplayObject = null;
            super.updateDisplayList(param1, param2);
            var _loc_3:* = super.target;
            if (_loc_3.horizontalScrollBar && getHorizontalAlignValue() > 0 || _loc_3.verticalScrollBar && getVerticalAlignValue() > 0)
            {
                _loc_4 = _loc_3.getStyle("paddingLeft");
                _loc_5 = _loc_3.getStyle("paddingTop");
                _loc_6 = 0;
                _loc_7 = 0;
                _loc_8 = _loc_3.numChildren;
                _loc_9 = 0;
                while (_loc_9 < _loc_8)
                {
                    
                    _loc_10 = IFlexDisplayObject(_loc_3.getChildAt(_loc_9));
                    if (_loc_10.x < _loc_4)
                    {
                        _loc_6 = Math.max(_loc_6, _loc_4 - _loc_10.x);
                    }
                    if (_loc_10.y < _loc_5)
                    {
                        _loc_7 = Math.max(_loc_7, _loc_5 - _loc_10.y);
                    }
                    _loc_9++;
                }
                if (_loc_6 != 0 || _loc_7 != 0)
                {
                    _loc_9 = 0;
                    while (_loc_9 < _loc_8)
                    {
                        
                        _loc_10 = IFlexDisplayObject(_loc_3.getChildAt(_loc_9));
                        IFlexDisplayObject(_loc_3.getChildAt(_loc_9)).move(_loc_10.x + _loc_6, _loc_10.y + _loc_7);
                        _loc_9++;
                    }
                }
            }
            return;
        }// end function

    }
}
