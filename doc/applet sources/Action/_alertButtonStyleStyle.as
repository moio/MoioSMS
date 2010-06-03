package 
{
    import mx.core.*;
    import mx.styles.*;

    public class _alertButtonStyleStyle extends Object
    {

        public function _alertButtonStyleStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration(".alertButtonStyle");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".alertButtonStyle", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.color = 734012;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
