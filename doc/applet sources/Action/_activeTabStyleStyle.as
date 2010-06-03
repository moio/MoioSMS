package 
{
    import mx.core.*;
    import mx.styles.*;

    public class _activeTabStyleStyle extends Object
    {

        public function _activeTabStyleStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration(".activeTabStyle");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".activeTabStyle", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.fontWeight = "bold";
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
