package mx.containers
{
    import flash.events.*;
    import mx.containers.utilityClasses.*;
    import mx.core.*;

    public class Box extends Container
    {
        var layoutObject:BoxLayout;
        static const VERSION:String = "3.2.0.3958";

        public function Box()
        {
            layoutObject = new BoxLayout();
            layoutObject.target = this;
            return;
        }// end function

        function isVertical() : Boolean
        {
            return direction != BoxDirection.HORIZONTAL;
        }// end function

        public function set direction(param1:String) : void
        {
            layoutObject.direction = param1;
            invalidateSize();
            invalidateDisplayList();
            dispatchEvent(new Event("directionChanged"));
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            layoutObject.updateDisplayList(param1, param2);
            return;
        }// end function

        public function pixelsToPercent(param1:Number) : Number
        {
            var _loc_8:IUIComponent = null;
            var _loc_9:Number = NaN;
            var _loc_10:Number = NaN;
            var _loc_2:* = isVertical();
            var _loc_3:Number = 0;
            var _loc_4:Number = 0;
            var _loc_5:* = numChildren;
            var _loc_6:int = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_8 = IUIComponent(getChildAt(_loc_6));
                _loc_9 = _loc_2 ? (_loc_8.height) : (_loc_8.width);
                _loc_10 = _loc_2 ? (_loc_8.percentHeight) : (_loc_8.percentWidth);
                if (!isNaN(_loc_10))
                {
                    _loc_3 = _loc_3 + _loc_10;
                    _loc_4 = _loc_4 + _loc_9;
                }
                _loc_6++;
            }
            var _loc_7:Number = 100;
            if (_loc_4 != param1)
            {
                _loc_7 = _loc_4 * _loc_3 / (_loc_4 - param1) - _loc_3;
            }
            return _loc_7;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            layoutObject.measure();
            return;
        }// end function

        public function get direction() : String
        {
            return layoutObject.direction;
        }// end function

    }
}
