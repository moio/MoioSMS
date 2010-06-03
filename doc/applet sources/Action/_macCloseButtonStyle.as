package 
{
    import mx.core.*;
    import mx.styles.*;

    public class _macCloseButtonStyle extends Object
    {
        private static var _embed_css_mac_close_up_png_604762939:Class = _macCloseButtonStyle__embed_css_mac_close_up_png_604762939;
        private static var _embed_css_mac_close_over_png_2138983717:Class = _macCloseButtonStyle__embed_css_mac_close_over_png_2138983717;
        private static var _embed_css_mac_close_down_png_1802990305:Class = _macCloseButtonStyle__embed_css_mac_close_down_png_1802990305;

        public function _macCloseButtonStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration(".macCloseButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".macCloseButton", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.upSkin = _embed_css_mac_close_up_png_604762939;
                this.overSkin = _embed_css_mac_close_over_png_2138983717;
                this.downSkin = _embed_css_mac_close_down_png_1802990305;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
