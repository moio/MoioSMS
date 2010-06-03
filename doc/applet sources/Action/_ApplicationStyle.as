package 
{
    import mx.core.*;
    import mx.skins.halo.*;
    import mx.styles.*;

    public class _ApplicationStyle extends Object
    {

        public function _ApplicationStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration("Application");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("Application", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.paddingTop = 24;
                this.paddingLeft = 24;
                this.backgroundGradientAlphas = [1, 1];
                this.horizontalAlign = "center";
                this.paddingRight = 24;
                this.backgroundImage = ApplicationBackground;
                this.paddingBottom = 24;
                this.backgroundSize = "100%";
                this.backgroundColor = 8821927;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
