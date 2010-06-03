package mx.skins.halo
{
    import mx.skins.*;
    import mx.utils.*;

    public class ApplicationBackground extends ProgrammaticSkin
    {
        static const VERSION:String = "3.2.0.3958";

        public function ApplicationBackground()
        {
            return;
        }// end function

        override public function get measuredWidth() : Number
        {
            return 8;
        }// end function

        override public function get measuredHeight() : Number
        {
            return 8;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_6:uint = 0;
            super.updateDisplayList(param1, param2);
            var _loc_3:* = graphics;
            var _loc_4:* = getStyle("backgroundGradientColors");
            var _loc_5:* = getStyle("backgroundGradientAlphas");
            if (!_loc_4)
            {
                _loc_6 = getStyle("backgroundColor");
                if (isNaN(_loc_6))
                {
                    _loc_6 = 16777215;
                }
                _loc_4 = [];
                _loc_4[0] = ColorUtil.adjustBrightness(_loc_6, 15);
                _loc_4[1] = ColorUtil.adjustBrightness(_loc_6, -25);
            }
            if (!_loc_5)
            {
                _loc_5 = [1, 1];
            }
            _loc_3.clear();
            drawRoundRect(0, 0, param1, param2, 0, _loc_4, _loc_5, verticalGradientMatrix(0, 0, param1, param2));
            return;
        }// end function

    }
}
