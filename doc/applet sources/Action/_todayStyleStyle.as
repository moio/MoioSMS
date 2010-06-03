package 
{
    import mx.core.*;
    import mx.styles.*;

    public class _todayStyleStyle extends Object
    {

        public function _todayStyleStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration(".todayStyle");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".todayStyle", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.textAlign = "center";
                this.color = 16777215;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
