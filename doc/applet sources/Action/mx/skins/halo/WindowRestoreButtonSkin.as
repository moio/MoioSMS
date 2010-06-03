package mx.skins.halo
{
    import mx.controls.*;
    import mx.core.*;
    import mx.states.*;

    public class WindowRestoreButtonSkin extends UIComponent
    {
        private var skinImage:Image;
        private static var winRestoreDownSkin:Class = WindowRestoreButtonSkin_winRestoreDownSkin;
        private static var winRestoreOverSkin:Class = WindowRestoreButtonSkin_winRestoreOverSkin;
        static const VERSION:String = "3.2.0.3958";
        private static var winRestoreUpSkin:Class = WindowRestoreButtonSkin_winRestoreUpSkin;

        public function WindowRestoreButtonSkin()
        {
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
            _loc_2.value = winRestoreUpSkin;
            _loc_1.overrides.push(_loc_2);
            states.push(_loc_1);
            var _loc_3:* = new State();
            _loc_3.name = "down";
            var _loc_4:* = new SetProperty();
            new SetProperty().name = "source";
            _loc_4.target = skinImage;
            _loc_4.value = winRestoreDownSkin;
            _loc_3.overrides.push(_loc_4);
            states.push(_loc_3);
            var _loc_5:* = new State();
            new State().name = "over";
            var _loc_6:* = new SetProperty();
            new SetProperty().name = "source";
            _loc_6.target = skinImage;
            _loc_6.value = winRestoreOverSkin;
            _loc_5.overrides.push(_loc_6);
            states.push(_loc_5);
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
