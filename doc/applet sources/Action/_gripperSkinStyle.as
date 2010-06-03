package 
{
    import mx.core.*;
    import mx.styles.*;

    public class _gripperSkinStyle extends Object
    {
        private static var _embed_css_gripper_up_png_15424853:Class = _gripperSkinStyle__embed_css_gripper_up_png_15424853;

        public function _gripperSkinStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration(".gripperSkin");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".gripperSkin", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.upSkin = _embed_css_gripper_up_png_15424853;
                this.overSkin = _embed_css_gripper_up_png_15424853;
                this.downSkin = _embed_css_gripper_up_png_15424853;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
