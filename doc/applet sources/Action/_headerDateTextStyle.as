package 
{
    import mx.core.*;
    import mx.styles.*;

    public class _headerDateTextStyle extends Object
    {

        public function _headerDateTextStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration(".headerDateText");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".headerDateText", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.textAlign = "center";
                this.fontWeight = "bold";
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
