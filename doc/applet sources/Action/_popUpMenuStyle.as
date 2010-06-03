package 
{
    import mx.core.*;
    import mx.styles.*;

    public class _popUpMenuStyle extends Object
    {

        public function _popUpMenuStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration(".popUpMenu");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".popUpMenu", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.textAlign = "left";
                this.fontWeight = "normal";
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
