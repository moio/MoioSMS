package 
{
    import flash.display.*;
    import flash.system.*;
    import flash.text.*;
    import mx.preloaders.*;

    private class ErrorField extends Sprite
    {
        private var downloadProgressBar:DownloadProgressBar;
        private const TEXT_MARGIN_PX:int = 10;
        private const MAX_WIDTH_INCHES:int = 6;
        private const MIN_WIDTH_INCHES:int = 2;

        private function ErrorField(param1:DownloadProgressBar)
        {
            this.downloadProgressBar = param1;
            return;
        }// end function

        protected function get labelFormat() : TextFormat
        {
            var _loc_1:* = new TextFormat();
            _loc_1.color = 0;
            _loc_1.font = "Verdana";
            _loc_1.size = 10;
            return _loc_1;
        }// end function

        public function show(param1:String) : void
        {
            if (param1 == null || param1.length == 0)
            {
                return;
            }
            var _loc_2:* = downloadProgressBar.stageWidth;
            var _loc_3:* = downloadProgressBar.stageHeight;
            var _loc_4:* = new TextField();
            new TextField().autoSize = TextFieldAutoSize.LEFT;
            _loc_4.multiline = true;
            _loc_4.wordWrap = true;
            _loc_4.background = true;
            _loc_4.defaultTextFormat = labelFormat;
            _loc_4.text = param1;
            _loc_4.width = Math.max(MIN_WIDTH_INCHES * Capabilities.screenDPI, _loc_2 - TEXT_MARGIN_PX * 2);
            _loc_4.width = Math.min(MAX_WIDTH_INCHES * Capabilities.screenDPI, _loc_4.width);
            _loc_4.y = Math.max(0, _loc_3 - TEXT_MARGIN_PX - _loc_4.height);
            _loc_4.x = (_loc_2 - _loc_4.width) / 2;
            downloadProgressBar.parent.addChild(this);
            this.addChild(_loc_4);
            return;
        }// end function

    }
}
