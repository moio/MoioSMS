package 
{
    import mx.core.*;
    import mx.styles.*;

    public class _opaquePanelStyle extends Object
    {

        public function _opaquePanelStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration(".opaquePanel");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".opaquePanel", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.footerColors = [15198183, 13092807];
                this.borderColor = 16777215;
                this.headerColors = [15198183, 14277081];
                this.borderAlpha = 1;
                this.backgroundColor = 16777215;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
