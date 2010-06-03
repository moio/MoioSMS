package mx.controls
{
    import mx.core.*;

    public class CheckBox extends Button
    {
        static const VERSION:String = "3.2.0.3958";
        static var createAccessibilityImplementation:Function;

        public function CheckBox()
        {
            _toggle = true;
            centerContent = false;
            extraSpacing = 8;
            return;
        }// end function

        override public function set toggle(param1:Boolean) : void
        {
            return;
        }// end function

        override public function set emphasized(param1:Boolean) : void
        {
            return;
        }// end function

        override protected function initializeAccessibility() : void
        {
            if (createAccessibilityImplementation != null)
            {
                createAccessibilityImplementation(this);
            }
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_1:Number = NaN;
            var _loc_2:Number = NaN;
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            super.measure();
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                _loc_1 = measureText(label).height;
                _loc_2 = currentIcon ? (currentIcon.height) : (0);
                _loc_3 = 0;
                if (labelPlacement == ButtonLabelPlacement.LEFT || labelPlacement == ButtonLabelPlacement.RIGHT)
                {
                    _loc_3 = Math.max(_loc_1, _loc_2);
                }
                else
                {
                    _loc_3 = _loc_1 + _loc_2;
                    _loc_4 = getStyle("verticalGap");
                    if (_loc_2 != 0 && !isNaN(_loc_4))
                    {
                        _loc_3 = _loc_3 + _loc_4;
                    }
                }
                var _loc_5:* = Math.max(_loc_3, 18);
                measuredHeight = Math.max(_loc_3, 18);
                measuredMinHeight = _loc_5;
            }
            return;
        }// end function

    }
}
