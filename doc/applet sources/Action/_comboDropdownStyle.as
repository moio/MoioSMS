package 
{
    import mx.core.*;
    import mx.styles.*;

    public class _comboDropdownStyle extends Object
    {

        public function _comboDropdownStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration(".comboDropdown");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".comboDropdown", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.paddingLeft = 5;
                this.fontWeight = "normal";
                this.cornerRadius = 0;
                this.paddingRight = 5;
                this.dropShadowEnabled = true;
                this.shadowDirection = "center";
                this.leading = 0;
                this.borderThickness = 0;
                this.shadowDistance = 1;
                this.backgroundColor = 16777215;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
