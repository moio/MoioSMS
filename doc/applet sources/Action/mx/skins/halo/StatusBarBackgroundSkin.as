package mx.skins.halo
{
    import mx.skins.*;

    public class StatusBarBackgroundSkin extends ProgrammaticSkin
    {
        static const VERSION:String = "3.2.0.3958";

        public function StatusBarBackgroundSkin()
        {
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            graphics.clear();
            drawRoundRect(0, 0, param1, param2, null, getStyle("statusBarBackgroundColor"), 1);
            graphics.moveTo(0, 0);
            graphics.lineStyle(1, 0, 0.35);
            graphics.lineTo(param1, 0);
            return;
        }// end function

    }
}
