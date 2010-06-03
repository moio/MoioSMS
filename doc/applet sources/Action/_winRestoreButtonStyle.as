package 
{
    import mx.core.*;
    import mx.styles.*;

    public class _winRestoreButtonStyle extends Object
    {
        private static var _embed_css_win_restore_up_png_1803365653:Class = _winRestoreButtonStyle__embed_css_win_restore_up_png_1803365653;
        private static var _embed_css_win_restore_down_png_1010944693:Class = _winRestoreButtonStyle__embed_css_win_restore_down_png_1010944693;
        private static var _embed_css_win_restore_over_png_971132241:Class = _winRestoreButtonStyle__embed_css_win_restore_over_png_971132241;

        public function _winRestoreButtonStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration(".winRestoreButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".winRestoreButton", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.upSkin = _embed_css_win_restore_up_png_1803365653;
                this.downSkin = _embed_css_win_restore_down_png_1010944693;
                this.overSkin = _embed_css_win_restore_over_png_971132241;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
