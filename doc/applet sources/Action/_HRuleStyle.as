package 
{
    import mx.core.*;
    import mx.styles.*;

    public class _HRuleStyle extends Object
    {

        public function _HRuleStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration("HRule");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("HRule", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.strokeWidth = 2;
                this.strokeColor = 12897484;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
