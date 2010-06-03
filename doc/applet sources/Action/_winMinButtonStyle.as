package 
{
    import mx.core.*;
    import mx.styles.*;

    public class _winMinButtonStyle extends Object
    {
        private static var _embed_css_win_min_up_png_888005083:Class = _winMinButtonStyle__embed_css_win_min_up_png_888005083;
        private static var _embed_css_win_min_down_png_921636923:Class = _winMinButtonStyle__embed_css_win_min_down_png_921636923;
        private static var _embed_css_win_min_dis_png_152798009:Class = _winMinButtonStyle__embed_css_win_min_dis_png_152798009;
        private static var _embed_css_win_min_over_png_1544401607:Class = _winMinButtonStyle__embed_css_win_min_over_png_1544401607;

        public function _winMinButtonStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration(".winMinButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".winMinButton", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.upSkin = _embed_css_win_min_up_png_888005083;
                this.downSkin = _embed_css_win_min_down_png_921636923;
                this.overSkin = _embed_css_win_min_over_png_1544401607;
                this.disabledSkin = _embed_css_win_min_dis_png_152798009;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
