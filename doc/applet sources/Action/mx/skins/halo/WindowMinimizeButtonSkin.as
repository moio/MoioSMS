package mx.skins.halo
{
    import flash.system.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.states.*;

    public class WindowMinimizeButtonSkin extends UIComponent
    {
        private var isMac:Boolean;
        private var skinImage:Image;
        private static var macMinDisabledSkin:Class = WindowMinimizeButtonSkin_macMinDisabledSkin;
        private static var winMinOverSkin:Class = WindowMinimizeButtonSkin_winMinOverSkin;
        private static var macMinDownSkin:Class = WindowMinimizeButtonSkin_macMinDownSkin;
        private static var winMinDownSkin:Class = WindowMinimizeButtonSkin_winMinDownSkin;
        private static var winMinDisabledSkin:Class = WindowMinimizeButtonSkin_winMinDisabledSkin;
        private static var macMinOverSkin:Class = WindowMinimizeButtonSkin_macMinOverSkin;
        private static var winMinUpSkin:Class = WindowMinimizeButtonSkin_winMinUpSkin;
        static const VERSION:String = "3.2.0.3958";
        private static var macMinUpSkin:Class = WindowMinimizeButtonSkin_macMinUpSkin;

        public function WindowMinimizeButtonSkin()
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
            _loc_2.value = isMac ? (macMinUpSkin) : (winMinUpSkin);
            _loc_1.overrides.push(_loc_2);
            states.push(_loc_1);
            var _loc_3:* = new State();
            _loc_3.name = "down";
            var _loc_4:* = new SetProperty();
            new SetProperty().name = "source";
            _loc_4.target = skinImage;
            _loc_4.value = isMac ? (macMinDownSkin) : (winMinDownSkin);
            _loc_3.overrides.push(_loc_4);
            states.push(_loc_3);
            var _loc_5:* = new State();
            new State().name = "over";
            var _loc_6:* = new SetProperty();
            new SetProperty().name = "source";
            _loc_6.target = skinImage;
            _loc_6.value = isMac ? (macMinOverSkin) : (winMinOverSkin);
            _loc_5.overrides.push(_loc_6);
            states.push(_loc_5);
            var _loc_7:* = new State();
            new State().name = "disabled";
            var _loc_8:* = new SetProperty();
            new SetProperty().name = "source";
            _loc_8.target = skinImage;
            _loc_8.value = isMac ? (macMinDisabledSkin) : (winMinDisabledSkin);
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
