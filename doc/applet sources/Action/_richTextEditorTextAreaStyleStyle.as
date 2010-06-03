package 
{
    import mx.core.*;
    import mx.styles.*;

    public class _richTextEditorTextAreaStyleStyle extends Object
    {

        public function _richTextEditorTextAreaStyleStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration(".richTextEditorTextAreaStyle");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".richTextEditorTextAreaStyle", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
