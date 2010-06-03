package mx.skins.halo
{
    import flash.system.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.states.*;

    public class WindowMaximizeButtonSkin extends UIComponent
    {
        private var isMac:Boolean;
        private var skinImage:Image;
        private static var winMaxUpSkin:Class = WindowMaximizeButtonSkin_winMaxUpSkin;
        private static var winMaxDisabledSkin:Class = WindowMaximizeButtonSkin_winMaxDisabledSkin;
        private static var winRestoreOverSkin:Class = WindowMaximizeButtonSkin_winRestoreOverSkin;
        private static var macMaxOverSkin:Class = WindowMaximizeButtonSkin_macMaxOverSkin;
        private static var winRestoreUpSkin:Class = WindowMaximizeButtonSkin_winRestoreUpSkin;
        private static var macMaxUpSkin:Class = WindowMaximizeButtonSkin_macMaxUpSkin;
        private static var winMaxDownSkin:Class = WindowMaximizeButtonSkin_winMaxDownSkin;
        private static var winRestoreDownSkin:Class = WindowMaximizeButtonSkin_winRestoreDownSkin;
        private static var macMaxDownSkin:Class = WindowMaximizeButtonSkin_macMaxDownSkin;
        static const VERSION:String = "3.2.0.3958";
        private static var winMaxOverSkin:Class = WindowMaximizeButtonSkin_winMaxOverSkin;
        private static var macMaxDisabledSkin:Class = WindowMaximizeButtonSkin_macMaxDisabledSkin;

        public function WindowMaximizeButtonSkin()
        {
            isMac = Capabilities.os.substring(0, 3) == "Mac";
            return;
        }// end function

        override public function get measuredWidth() : Number
        {
            if (skinImage.measuredWidth)
            {
                return skinImage.measuredWidth;
            }
            return 12;
        }// end function

        private function initializeStates() : void
        {
            var _loc_1:* = new State();
            _loc_1.name = "up";
            var _loc_2:* = new SetProperty();
            _loc_2.name = "source";
            _loc_2.target = skinImage;
            _loc_2.value = isMac ? (macMaxUpSkin) : (winMaxUpSkin);
            _loc_1.overrides.push(_loc_2);
            states.push(_loc_1);
            var _loc_3:* = new State();
            _loc_3.name = "down";
            var _loc_4:* = new SetProperty();
            new SetProperty().name = "source";
            _loc_4.target = skinImage;
            _loc_4.value = isMac ? (macMaxDownSkin) : (winMaxDownSkin);
            _loc_3.overrides.push(_loc_4);
            states.push(_loc_3);
            var _loc_5:* = new State();
            new State().name = "over";
            var _loc_6:* = new SetProperty();
            new SetProperty().name = "source";
            _loc_6.target = skinImage;
            _loc_6.value = isMac ? (macMaxOverSkin) : (winMaxOverSkin);
            _loc_5.overrides.push(_loc_6);
            states.push(_loc_5);
            var _loc_7:* = new State();
            new State().name = "disabled";
            var _loc_8:* = new SetProperty();
            new SetProperty().name = "source";
            _loc_8.target = skinImage;
            _loc_8.value = isMac ? (macMaxDisabledSkin) : (winMaxDisabledSkin);
            _loc_7.overrides.push(_loc_8);
            states.push(_loc_7);
            return;
        }// end function

        override protected function createChildren() : void
        {
            skinImage = new Image();
            addChild(skinImage);
            initializeStates();
            skinImage.setActualSize(12, 13);
            skinImage.move(0, 0);
            return;
        }// end function

        override public function get measuredHeight() : Number
        {
            if (skinImage.measuredHeight)
            {
                return skinImage.measuredHeight;
            }
            return 13;
        }// end function

    }
}
