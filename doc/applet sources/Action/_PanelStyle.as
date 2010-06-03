package 
{
    import mx.core.*;
    import mx.skins.halo.*;
    import mx.styles.*;

    public class _PanelStyle extends Object
    {

        public function _PanelStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var effects:Array;
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration("Panel");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("Panel", style, false);
                effects = mx_internal::effects;
                if (!effects)
                {
                    var _loc_3:* = new Array();
                    mx_internal::effects = new Array();
                    effects = _loc_3;
                }
                effects.push("resizeEndEffect");
                effects.push("resizeStartEffect");
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.borderColor = 14869218;
                this.paddingLeft = 0;
                this.roundedBottomCorners = false;
                this.dropShadowEnabled = true;
                this.resizeStartEffect = "Dissolve";
                this.borderSkin = PanelSkin;
                this.statusStyleName = "windowStatus";
                this.borderAlpha = 0.4;
                this.borderStyle = "default";
                this.paddingBottom = 0;
                this.resizeEndEffect = "Dissolve";
                this.paddingTop = 0;
                this.borderThicknessRight = 10;
                this.titleStyleName = "windowStyles";
                this.cornerRadius = 4;
                this.paddingRight = 0;
                this.borderThicknessLeft = 10;
                this.titleBackgroundSkin = TitleBackground;
                this.borderThickness = 0;
                this.borderThicknessTop = 2;
                this.backgroundColor = 16777215;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
