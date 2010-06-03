package 
{
    import mx.core.*;
    import mx.styles.*;

    public class _AlertStyle extends Object
    {

        public function _AlertStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration("Alert");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("Alert", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.paddingTop = 2;
                this.borderColor = 8821927;
                this.paddingLeft = 10;
                this.color = 16777215;
                this.roundedBottomCorners = true;
                this.paddingRight = 10;
                this.backgroundAlpha = 0.9;
                this.paddingBottom = 2;
                this.borderAlpha = 0.9;
                this.buttonStyleName = "alertButtonStyle";
                this.backgroundColor = 8821927;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
