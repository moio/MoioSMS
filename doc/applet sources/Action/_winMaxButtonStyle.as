package 
{
    import mx.core.*;
    import mx.styles.*;

    public class _winMaxButtonStyle extends Object
    {
        private static var _embed_css_win_max_down_png_154265295:Class = _winMaxButtonStyle__embed_css_win_max_down_png_154265295;
        private static var _embed_css_win_max_up_png_2123186591:Class = _winMaxButtonStyle__embed_css_win_max_up_png_2123186591;
        private static var _embed_css_win_max_dis_png_499632057:Class = _winMaxButtonStyle__embed_css_win_max_dis_png_499632057;
        private static var _embed_css_win_max_over_png_68101371:Class = _winMaxButtonStyle__embed_css_win_max_over_png_68101371;

        public function _winMaxButtonStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration(".winMaxButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".winMaxButton", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.upSkin = _embed_css_win_max_up_png_2123186591;
                this.downSkin = _embed_css_win_max_down_png_154265295;
                this.overSkin = _embed_css_win_max_over_png_68101371;
                this.disabledSkin = _embed_css_win_max_dis_png_499632057;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
