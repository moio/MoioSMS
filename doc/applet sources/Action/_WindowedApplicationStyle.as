package 
{
    import mx.core.*;
    import mx.skins.halo.*;
    import mx.styles.*;

    public class _WindowedApplicationStyle extends Object
    {

        public function _WindowedApplicationStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration("WindowedApplication");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("WindowedApplication", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.statusTextStyleName = "statusTextStyle";
                this.minimizeButtonSkin = WindowMinimizeButtonSkin;
                this.gripperPadding = 3;
                this.borderStyle = "solid";
                this.restoreButtonSkin = WindowRestoreButtonSkin;
                this.closeButtonSkin = WindowCloseButtonSkin;
                this.highlightAlphas = [1, 1];
                this.cornerRadius = 8;
                this.titleBarBackgroundSkin = ApplicationTitleBarBackgroundSkin;
                this.backgroundImage = WindowBackground;
                this.borderThickness = 1;
                this.buttonPadding = 2;
                this.statusBarBackgroundColor = 13421772;
                this.titleBarButtonPadding = 5;
                this.buttonAlignment = "auto";
                this.titleTextStyleName = "titleTextStyle";
                this.borderColor = 10921638;
                this.roundedBottomCorners = false;
                this.titleAlignment = "auto";
                this.showFlexChrome = true;
                this.titleBarColors = [16777215, 12237498];
                this.gripperStyleName = "gripperSkin";
                this.maximizeButtonSkin = WindowMaximizeButtonSkin;
                this.backgroundColor = 12632256;
                this.statusBarBackgroundSkin = StatusBarBackgroundSkin;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
