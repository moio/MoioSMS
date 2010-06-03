package 
{
    import mx.core.*;
    import mx.styles.*;

    public class _errorTipStyle extends Object
    {

        public function _errorTipStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration(".errorTip");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".errorTip", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.paddingTop = 4;
                this.borderColor = 13510953;
                this.paddingLeft = 4;
                this.color = 16777215;
                this.fontWeight = "bold";
                this.paddingRight = 4;
                this.shadowColor = 0;
                this.fontSize = 9;
                this.paddingBottom = 4;
                this.borderStyle = "errorTipRight";
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
