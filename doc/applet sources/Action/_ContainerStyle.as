package 
{
    import mx.core.*;
    import mx.styles.*;

    public class _ContainerStyle extends Object
    {

        public function _ContainerStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration("Container");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("Container", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.borderStyle = "none";
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
