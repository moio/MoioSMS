package 
{
    import mx.core.*;
    import mx.styles.*;

    public class _macMaxButtonStyle extends Object
    {
        private static var _embed_css_mac_max_dis_png_1727934519:Class = _macMaxButtonStyle__embed_css_mac_max_dis_png_1727934519;
        private static var _embed_css_mac_max_down_png_953594743:Class = _macMaxButtonStyle__embed_css_mac_max_down_png_953594743;
        private static var _embed_css_mac_max_up_png_1645577899:Class = _macMaxButtonStyle__embed_css_mac_max_up_png_1645577899;
        private static var _embed_css_mac_max_over_png_557736117:Class = _macMaxButtonStyle__embed_css_mac_max_over_png_557736117;

        public function _macMaxButtonStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration(".macMaxButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".macMaxButton", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.upSkin = _embed_css_mac_max_up_png_1645577899;
                this.overSkin = _embed_css_mac_max_over_png_557736117;
                this.downSkin = _embed_css_mac_max_down_png_953594743;
                this.disabledSkin = _embed_css_mac_max_dis_png_1727934519;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
