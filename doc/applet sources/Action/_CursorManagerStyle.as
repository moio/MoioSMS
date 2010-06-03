package 
{
    import mx.core.*;
    import mx.skins.halo.*;
    import mx.styles.*;

    public class _CursorManagerStyle extends Object
    {
        private static var _embed_css_Assets_swf_mx_skins_cursor_BusyCursor_1850859719:Class = _CursorManagerStyle__embed_css_Assets_swf_mx_skins_cursor_BusyCursor_1850859719;

        public function _CursorManagerStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration("CursorManager");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("CursorManager", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.busyCursor = BusyCursor;
                this.busyCursorBackground = _embed_css_Assets_swf_mx_skins_cursor_BusyCursor_1850859719;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
