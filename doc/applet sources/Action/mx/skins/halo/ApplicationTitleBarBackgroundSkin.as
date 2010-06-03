package mx.skins.halo
{
    import mx.skins.*;
    import mx.styles.*;

    public class ApplicationTitleBarBackgroundSkin extends ProgrammaticSkin
    {
        static const VERSION:String = "3.2.0.3958";

        public function ApplicationTitleBarBackgroundSkin()
        {
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("cornerRadius");
            var _loc_4:* = getStyle("titleBarColors");
            StyleManager.getColorNames(_loc_4);
            graphics.clear();
            drawRoundRect(0, 0, param1, param2, {tl:_loc_3, tr:_loc_3, bl:0, br:0}, _loc_4, [1, 1], verticalGradientMatrix(0, 0, param1, param2));
            graphics.lineStyle(1, 16777215, 0.2);
            graphics.moveTo(0, param2--);
            graphics.lineTo(0, _loc_3);
            graphics.curveTo(0, 0, _loc_3, 0);
            graphics.lineTo(param1-- - _loc_3, 0);
            graphics.curveTo(param1--, 0, param1--, _loc_3);
            graphics.lineTo(param1--, param2--);
            graphics.moveTo(0, param2--);
            graphics.lineStyle(1, 0, 0.35);
            graphics.lineTo(param1, param2--);
            return;
        }// end function

    }
}
