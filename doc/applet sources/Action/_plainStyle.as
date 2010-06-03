package 
{
    import mx.core.*;
    import mx.styles.*;

    public class _plainStyle extends Object
    {

        public function _plainStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration(".plain");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".plain", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.paddingTop = 0;
                this.paddingLeft = 0;
                this.horizontalAlign = "left";
                this.paddingRight = 0;
                this.backgroundImage = "";
                this.paddingBottom = 0;
                this.backgroundColor = 16777215;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
