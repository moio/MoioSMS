package 
{
    import mx.core.*;
    import mx.styles.*;

    public class _HTMLStyle extends Object
    {

        public function _HTMLStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration("HTML");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("HTML", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.borderStyle = "none";
                this.backgroundColor = 16777215;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
