package 
{
    import mx.core.*;
    import mx.skins.halo.*;
    import mx.styles.*;

    public class _DragManagerStyle extends Object
    {
        private static var _embed_css_Assets_swf_mx_skins_cursor_DragLink_2102843560:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragLink_2102843560;
        private static var _embed_css_Assets_swf_mx_skins_cursor_DragCopy_2102057017:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragCopy_2102057017;
        private static var _embed_css_Assets_swf_mx_skins_cursor_DragReject_1784673037:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragReject_1784673037;
        private static var _embed_css_Assets_swf_mx_skins_cursor_DragMove_2102819997:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragMove_2102819997;

        public function _DragManagerStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration("DragManager");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("DragManager", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.rejectCursor = _embed_css_Assets_swf_mx_skins_cursor_DragReject_1784673037;
                this.defaultDragImageSkin = DefaultDragImage;
                this.moveCursor = _embed_css_Assets_swf_mx_skins_cursor_DragMove_2102819997;
                this.copyCursor = _embed_css_Assets_swf_mx_skins_cursor_DragCopy_2102057017;
                this.linkCursor = _embed_css_Assets_swf_mx_skins_cursor_DragLink_2102843560;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
