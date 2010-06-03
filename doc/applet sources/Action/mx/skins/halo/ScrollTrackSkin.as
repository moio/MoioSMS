package mx.skins.halo
{
    import flash.display.*;
    import mx.core.*;
    import mx.skins.*;
    import mx.styles.*;
    import mx.utils.*;

    public class ScrollTrackSkin extends Border
    {
        static const VERSION:String = "3.2.0.3958";

        public function ScrollTrackSkin()
        {
            return;
        }// end function

        override public function get measuredWidth() : Number
        {
            return 16;
        }// end function

        override public function get measuredHeight() : Number
        {
            return 1;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("trackColors");
            StyleManager.getColorNames(_loc_3);
            var _loc_4:* = ColorUtil.adjustBrightness2(getStyle("borderColor"), -20);
            var _loc_5:* = ColorUtil.adjustBrightness2(_loc_4, -30);
            graphics.clear();
            var _loc_6:Number = 1;
            if (name == "trackDisabledSkin" && FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0)
            {
                _loc_6 = 0.2;
            }
            drawRoundRect(0, 0, param1, param2, 0, [_loc_4, _loc_5], _loc_6, verticalGradientMatrix(0, 0, param1, param2), GradientType.LINEAR, null, {x:1, y:1, w:param1 - 2, h:param2 - 2, r:0});
            drawRoundRect(1, 1, param1 - 2, param2 - 2, 0, _loc_3, _loc_6, horizontalGradientMatrix(1, 1, param1 / 3 * 2, param2 - 2));
            return;
        }// end function

    }
}
