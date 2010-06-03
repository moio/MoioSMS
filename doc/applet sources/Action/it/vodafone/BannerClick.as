package it.vodafone
{
    import flash.events.*;

    public class BannerClick extends Event
    {
        public var _destination:String;
        public static const BANNER_CLICK:String = "banner_click";

        public function BannerClick(param1:String)
        {
            super(BANNER_CLICK, true);
            this._destination = param1;
            return;
        }// end function

    }
}
