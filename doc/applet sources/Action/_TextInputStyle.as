package 
{
    import mx.core.*;
    import mx.styles.*;

    public class _TextInputStyle extends Object
    {

        public function _TextInputStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration("TextInput");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("TextInput", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.backgroundDisabledColor = 14540253;
                this.backgroundColor = 16777215;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
