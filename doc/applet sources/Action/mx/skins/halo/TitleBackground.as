package mx.skins.halo
{
    import flash.display.*;
    import mx.skins.*;
    import mx.styles.*;
    import mx.utils.*;

    public class TitleBackground extends ProgrammaticSkin
    {
        static const VERSION:String = "3.2.0.3958";

        public function TitleBackground()
        {
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("borderAlpha");
            var _loc_4:* = getStyle("cornerRadius");
            var _loc_5:* = getStyle("highlightAlphas");
            var _loc_6:* = getStyle("headerColors");
            var _loc_7:* = getStyle("headerColors") != null;
            StyleManager.getColorNames(_loc_6);
            var _loc_8:* = ColorUtil.adjustBrightness2(_loc_6 ? (_loc_6[1]) : (16777215), -20);
            var _loc_9:* = graphics;
            graphics.clear();
            if (param2 < 3)
            {
                return;
            }
            if (_loc_7)
            {
                _loc_9.lineStyle(0, _loc_8, _loc_3);
                _loc_9.moveTo(0, param2);
                _loc_9.lineTo(param1, param2);
                _loc_9.lineStyle(0, 0, 0);
                drawRoundRect(0, 0, param1, param2, {tl:_loc_4, tr:_loc_4, bl:0, br:0}, _loc_6, _loc_3, verticalGradientMatrix(0, 0, param1, param2));
                drawRoundRect(0, 0, param1, param2 / 2, {tl:_loc_4, tr:_loc_4, bl:0, br:0}, [16777215, 16777215], _loc_5, verticalGradientMatrix(0, 0, param1, param2 / 2));
                drawRoundRect(0, 0, param1, param2, {tl:_loc_4, tr:_loc_4, bl:0, br:0}, 16777215, _loc_5[0], null, GradientType.LINEAR, null, {x:0, y:1, w:param1, h:param2--, r:{tl:_loc_4, tr:_loc_4, bl:0, br:0}});
            }
            return;
        }// end function

    }
}
