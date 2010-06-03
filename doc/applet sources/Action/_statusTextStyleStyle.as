package 
{
    import mx.core.*;
    import mx.styles.*;

    public class _statusTextStyleStyle extends Object
    {

        public function _statusTextStyleStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration(".statusTextStyle");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".statusTextStyle", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.color = 5789784;
                this.fontSize = 10;
                this.alpha = 0.6;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
