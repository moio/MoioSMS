package it.vodafone
{
    import flash.display.*;
    import flash.events.*;
    import mx.events.*;
    import mx.preloaders.*;

    public class VodafonePreloader extends DownloadProgressBar
    {
        private var clip:Sprite;

        public function VodafonePreloader()
        {
            this.clip = new Sprite();
            addChild(this.clip);
            return;
        }// end function

        private function centerPreloader() : void
        {
            return;
        }// end function

        private function onSWFDownloadComplete(event:Event) : void
        {
            return;
        }// end function

        private function onFlexInitProgress(event:FlexEvent) : void
        {
            return;
        }// end function

        override protected function showDisplayForDownloading(param1:int, param2:ProgressEvent) : Boolean
        {
            return true;
        }// end function

        private function onSWFDownloadProgress(event:ProgressEvent) : void
        {
            return;
        }// end function

        private function onFlexInitComplete(event:FlexEvent) : void
        {
            dispatchEvent(new Event(Event.COMPLETE));
            return;
        }// end function

        override public function set preloader(param1:Sprite) : void
        {
            param1.addEventListener(FlexEvent.INIT_COMPLETE, this.onFlexInitComplete);
            return;
        }// end function

    }
}
