package 
{
    import mx.core.*;
    import mx.skins.halo.*;
    import mx.styles.*;

    public class _globalStyle extends Object
    {

        public function _globalStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration("global");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("global", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.fontWeight = "normal";
                this.modalTransparencyBlur = 3;
                this.verticalGridLineColor = 14015965;
                this.borderStyle = "inset";
                this.buttonColor = 7305079;
                this.borderCapColor = 9542041;
                this.textAlign = "left";
                this.disabledIconColor = 10066329;
                this.stroked = false;
                this.fillColors = [16777215, 13421772, 16777215, 15658734];
                this.fontStyle = "normal";
                this.borderSides = "left top right bottom";
                this.borderThickness = 1;
                this.modalTransparencyDuration = 100;
                this.useRollOver = true;
                this.strokeWidth = 1;
                this.filled = true;
                this.borderColor = 12040892;
                this.horizontalGridLines = false;
                this.horizontalGridLineColor = 16250871;
                this.shadowCapColor = 14015965;
                this.fontGridFitType = "pixel";
                this.horizontalAlign = "left";
                this.modalTransparencyColor = 14540253;
                this.disabledColor = 11187123;
                this.borderSkin = HaloBorder;
                this.dropShadowColor = 0;
                this.paddingBottom = 0;
                this.indentation = 17;
                this.version = "3.0.0";
                this.fontThickness = 0;
                this.verticalGridLines = true;
                this.embedFonts = false;
                this.fontSharpness = 0;
                this.shadowDirection = "center";
                this.textDecoration = "none";
                this.selectionDuration = 250;
                this.bevel = true;
                this.fillColor = 16777215;
                this.focusBlendMode = "normal";
                this.dropShadowEnabled = false;
                this.textRollOverColor = 2831164;
                this.textIndent = 0;
                this.fontSize = 10;
                this.openDuration = 250;
                this.closeDuration = 250;
                this.kerning = false;
                this.paddingTop = 0;
                this.highlightAlphas = [0.3, 0];
                this.cornerRadius = 0;
                this.horizontalGap = 8;
                this.textSelectedColor = 2831164;
                this.paddingLeft = 0;
                this.modalTransparency = 0.5;
                this.roundedBottomCorners = true;
                this.repeatDelay = 500;
                this.selectionDisabledColor = 14540253;
                this.fontAntiAliasType = "advanced";
                this.focusSkin = HaloFocusRect;
                this.verticalGap = 6;
                this.leading = 2;
                this.shadowColor = 15658734;
                this.backgroundAlpha = 1;
                this.iconColor = 1118481;
                this.focusAlpha = 0.4;
                this.borderAlpha = 1;
                this.focusThickness = 2;
                this.themeColor = 40447;
                this.backgroundSize = "auto";
                this.indicatorGap = 14;
                this.letterSpacing = 0;
                this.fontFamily = "Verdana";
                this.fillAlphas = [0.6, 0.4, 0.75, 0.65];
                this.color = 734012;
                this.paddingRight = 0;
                this.errorColor = 16711680;
                this.verticalAlign = "top";
                this.focusRoundedCorners = "tl tr bl br";
                this.shadowDistance = 2;
                this.repeatInterval = 35;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
