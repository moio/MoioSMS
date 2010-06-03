package it.vodafone
{
    import com.adobe.utils.*;
    import flash.events.*;
    import flash.net.*;

    public class RssData extends EventDispatcher
    {
        private var _XMLData:XML;
        private var _feedLoader:URLLoader;
        private var _status:String;
        private var _feedUrl:String;
        public var titolo:String;
        private var _listaTitoli:Array;
        public static var READY:String = "status_ready";
        public static var LOADED:String = "status_loaded";
        public static var LOADING:String = "status_loading";
        public static var ERROR:String = "status_error";

        public function RssData(param1:String, param2:String)
        {
            this.titolo = param2;
            this._feedUrl = param1;
            this._status = LOADING;
            this._listaTitoli = new Array();
            var _loc_3:* = new URLRequest(this._feedUrl);
            _loc_3.cacheResponse = false;
            _loc_3.useCache = false;
            _loc_3.userAgent = RemotePreferences.getInstance().getValue("user_agent");
            _loc_3.requestHeaders.push(new URLRequestHeader("Cookie", ""));
            this._feedLoader = new URLLoader();
            this._feedLoader.addEventListener(Event.COMPLETE, this.parsingRisultato);
            this._feedLoader.addEventListener(IOErrorEvent.IO_ERROR, this.dataUnavailable);
            this._feedLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.dataUnavailable);
            this._feedLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, this.genericHttpStatusHandler);
            this._feedLoader.load(_loc_3);
            return;
        }// end function

        public function getArticleLink(param1:Number) : String
        {
            return this._listaTitoli[param1].link;
        }// end function

        private function parsingRisultato(event:Event) : void
        {
            var _loc_4:XML = null;
            var _loc_5:String = null;
            var _loc_6:String = null;
            var _loc_7:Object = null;
            trace("RSSDATA result " + event);
            var _loc_2:* = this._feedLoader.data;
            this._listaTitoli = new Array();
            if (!XMLUtil.isValidXML(_loc_2))
            {
                trace("Feed does not contain valid XML.");
                this.dataUnavailable();
                return;
            }
            var _loc_3:* = XML(this._feedLoader.data);
            for each (_loc_4 in _loc_3..item)
            {
                
                _loc_5 = _loc_4.title.toString();
                _loc_6 = _loc_4.link.toString();
                if (_loc_5.length > 0 && _loc_6.length > 0)
                {
                    _loc_7 = new Object();
                    _loc_7.titolo = _loc_5;
                    _loc_7.link = _loc_6;
                    this._listaTitoli.push(_loc_7);
                }
            }
            this._status = LOADED;
            dispatchEvent(new Event(LOADED));
            return;
        }// end function

        public function get loaded() : Boolean
        {
            if (this._status == LOADED)
            {
                return true;
            }
            return false;
        }// end function

        public function getArticleTitle(param1:Number) : String
        {
            return this._listaTitoli[param1].titolo;
        }// end function

        public function get error() : Boolean
        {
            if (this._status == ERROR)
            {
                return true;
            }
            return false;
        }// end function

        private function dataUnavailable(event:Event = null) : void
        {
            this._status = ERROR;
            dispatchEvent(new Event(ERROR));
            return;
        }// end function

        private function genericHttpStatusHandler(event:HTTPStatusEvent) : void
        {
            if (event.status >= 400)
            {
                this._status = ERROR;
                dispatchEvent(new Event(ERROR));
            }
            return;
        }// end function

        public function refresh() : void
        {
            if (this._status != LOADED)
            {
                return;
            }
            var _loc_1:* = new URLRequest(this._feedUrl);
            _loc_1.cacheResponse = false;
            _loc_1.useCache = false;
            _loc_1.userAgent = RemotePreferences.getInstance().getValue("user_agent");
            _loc_1.requestHeaders.push(new URLRequestHeader("Cookie", ""));
            this._feedLoader = new URLLoader();
            this._feedLoader.addEventListener(Event.COMPLETE, this.parsingRisultato);
            this._feedLoader.load(_loc_1);
            return;
        }// end function

        public function get articleCount() : Number
        {
            return this._listaTitoli.length;
        }// end function

        public function get feedUrl() : String
        {
            return this._feedUrl;
        }// end function

        public function get title() : String
        {
            return this._XMLData.channel.title.toString();
        }// end function

    }
}
