package 
{
    import mx.core.*;
    import mx.styles.*;

    public class _macMinButtonStyle extends Object
    {
        private static var _embed_css_mac_min_down_png_149856075:Class = _macMinButtonStyle__embed_css_mac_min_down_png_149856075;
        private static var _embed_css_mac_min_up_png_1321410959:Class = _macMinButtonStyle__embed_css_mac_min_up_png_1321410959;
        private static var _embed_css_mac_min_dis_png_372701207:Class = _macMinButtonStyle__embed_css_mac_min_dis_png_372701207;
        private static var _embed_css_mac_min_over_png_660076415:Class = _macMinButtonStyle__embed_css_mac_min_over_png_660076415;

        public function _macMinButtonStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration(".macMinButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".macMinButton", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.upSkin = _embed_css_mac_min_up_png_1321410959;
                this.overSkin = _embed_css_mac_min_over_png_660076415;
                this.downSkin = _embed_css_mac_min_down_png_149856075;
                this.disabledSkin = _embed_css_mac_min_dis_png_372701207;
                this.alpha = 0.5;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
