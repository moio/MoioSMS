package 
{
    import mx.core.*;
    import mx.styles.*;

    public class _dateFieldPopupStyle extends Object
    {

        public function _dateFieldPopupStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration(".dateFieldPopup");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".dateFieldPopup", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.dropShadowEnabled = true;
                this.borderThickness = 0;
                this.backgroundColor = 16777215;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
