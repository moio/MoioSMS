package mx.controls
{
    import mx.core.*;

    public class HRule extends UIComponent
    {
        static const VERSION:String = "3.2.0.3958";
        private static const DEFAULT_PREFERRED_WIDTH:Number = 100;

        public function HRule()
        {
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            measuredWidth = DEFAULT_PREFERRED_WIDTH;
            measuredHeight = getStyle("strokeWidth");
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = graphics;
            _loc_3.clear();
            var _loc_4:* = getStyle("strokeColor");
            var _loc_5:* = getStyle("shadowColor");
            var _loc_6:* = getStyle("strokeWidth");
            if (getStyle("strokeWidth") > param2)
            {
                _loc_6 = param2;
            }
            var _loc_7:Number = 0;
            var _loc_8:* = (param2 - _loc_6) / 2;
            var _loc_9:* = param1;
            var _loc_10:* = _loc_8 + _loc_6;
            if (_loc_6 == 1)
            {
                _loc_3.beginFill(_loc_4);
                _loc_3.drawRect(_loc_7, _loc_8, param1, _loc_10 - _loc_8);
                _loc_3.endFill();
            }
            else if (_loc_6 == 2)
            {
                _loc_3.beginFill(_loc_4);
                _loc_3.drawRect(_loc_7, _loc_8, param1, 1);
                _loc_3.endFill();
                _loc_3.beginFill(_loc_5);
                _loc_3.drawRect(_loc_7, _loc_10--, param1, 1);
                _loc_3.endFill();
            }
            else if (_loc_6 > 2)
            {
                _loc_3.beginFill(_loc_4);
                _loc_3.drawRect(_loc_7, _loc_8, param1--, 1);
                _loc_3.endFill();
                _loc_3.beginFill(_loc_5);
                _loc_3.drawRect(_loc_9--, _loc_8, 1, (_loc_10 - _loc_8)--);
                _loc_3.drawRect(_loc_7, _loc_10--, param1, 1);
                _loc_3.endFill();
                _loc_3.beginFill(_loc_4);
                _loc_3.drawRect(_loc_7, _loc_8 + 1, 1, _loc_10 - _loc_8 - 2);
                _loc_3.endFill();
            }
            return;
        }// end function

    }
}
