package 
{
    import mx.core.*;
    import mx.styles.*;

    public class _windowStatusStyle extends Object
    {

        public function _windowStatusStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration(".windowStatus");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".windowStatus", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.color = 6710886;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
