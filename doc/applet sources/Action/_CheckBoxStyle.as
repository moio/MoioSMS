package 
{
    import mx.core.*;
    import mx.skins.halo.*;
    import mx.styles.*;

    public class _CheckBoxStyle extends Object
    {

        public function _CheckBoxStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration("CheckBox");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("CheckBox", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.skin = null;
                this.paddingLeft = 0;
                this.selectedDisabledIcon = null;
                this.fontWeight = "normal";
                this.selectedOverIcon = null;
                this.upSkin = null;
                this.overIcon = null;
                this.iconColor = 2831164;
                this.overSkin = null;
                this.selectedDisabledSkin = null;
                this.selectedDownIcon = null;
                this.disabledIcon = null;
                this.textAlign = "left";
                this.selectedDownSkin = null;
                this.selectedUpSkin = null;
                this.paddingRight = 0;
                this.selectedOverSkin = null;
                this.upIcon = null;
                this.icon = CheckBoxIcon;
                this.downSkin = null;
                this.horizontalGap = 5;
                this.selectedUpIcon = null;
                this.disabledSkin = null;
                this.downIcon = null;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
