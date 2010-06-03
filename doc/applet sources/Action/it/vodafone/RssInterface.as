package it.vodafone
{
    import flash.events.*;
    import flash.utils.*;

    public class RssInterface extends EventDispatcher
    {
        private var _listaFeed:Array;
        private var _feedAttivi:Array;
        private var _killList:Array;
        private static var selfInstance:RssInterface;
        private static const _MINUTE:int = 60000;
        private static var _lastUpdateTimeStamp:int = -1;
        private static var _expireTimeout:int = -1;

        public function RssInterface()
        {
            var _loc_5:Object = null;
            this._listaFeed = new Array();
            this._feedAttivi = new Array();
            this._killList = new Array();
            var _loc_1:* = XML(RemotePreferences.getInstance().getValue("rss_feeds"));
            var _loc_2:* = _loc_1.child("rss_feed");
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length())
            {
                
                _loc_5 = new Object();
                _loc_5.titolo = String(_loc_2[_loc_3].@name);
                _loc_5.indirizzo = String(_loc_2[_loc_3].toString());
                if (_loc_2[_loc_3].@default == "n")
                {
                    this._killList.push(_loc_5.indirizzo);
                }
                this._listaFeed.push(_loc_5);
                _loc_3++;
            }
            var _loc_4:* = LocalPreferences.getInstance().storageGet("disabledFeeds");
            if (LocalPreferences.getInstance().storageGet("disabledFeeds") != null && _loc_4 != "")
            {
                this._killList = _loc_4.split("\'");
            }
            this.updateFeedList();
            return;
        }// end function

        private function saveKillList() : void
        {
            var _loc_1:* = this._killList.join("\'");
            if (_loc_1 == "")
            {
                _loc_1 = " ";
            }
            LocalPreferences.getInstance().storageSet("disabledFeeds", _loc_1, false);
            return;
        }// end function

        public function enableFeed(param1:int) : void
        {
            var _loc_2:* = this._listaFeed[param1].indirizzo;
            if (this._killList.indexOf(_loc_2) >= 0)
            {
                this._killList.splice(this._killList.indexOf(_loc_2), 1);
            }
            this.updateFeedList();
            this.saveKillList();
            return;
        }// end function

        public function feedEnabled(param1:int) : Boolean
        {
            var _loc_2:* = this._listaFeed[param1].indirizzo;
            if (this._killList.indexOf(_loc_2) < 0)
            {
                return true;
            }
            return false;
        }// end function

        private function updateFeedList(param1:Boolean = false) : void
        {
            var _loc_4:String = null;
            var _loc_5:String = null;
            var _loc_6:Boolean = false;
            var _loc_7:int = 0;
            trace("RssIntraface, updateFeedList(" + param1 + ") - BEGIN");
            if (param1)
            {
                this._feedAttivi = new Array();
            }
            trace("RssIntraface, updateFeedList, _feedAttivi.length = " + this._feedAttivi.length);
            while (_loc_2-- >= 0)
            {
                
                if (this._killList.indexOf(RssData(this._feedAttivi[this._feedAttivi.length--]).feedUrl) >= 0)
                {
                    this._feedAttivi.splice(_loc_2, 1);
                }
            }
            var _loc_3:int = 0;
            while (_loc_3 < this._listaFeed.length)
            {
                
                _loc_4 = this._listaFeed[_loc_3].indirizzo;
                _loc_5 = this._listaFeed[_loc_3].titolo;
                _loc_6 = false;
                _loc_7 = 0;
                while (_loc_7 < this._feedAttivi.length)
                {
                    
                    if (RssData(this._feedAttivi[_loc_7]).feedUrl == _loc_4)
                    {
                        _loc_6 = true;
                    }
                    _loc_7++;
                }
                if (!_loc_6 && this._killList.indexOf(_loc_4) < 0)
                {
                    this._feedAttivi.push(new RssData(_loc_4, _loc_5));
                }
                _loc_3++;
            }
            trace("RssIntraface, updateFeedList, _feedAttivi.length = " + this._feedAttivi.length);
            trace("RssIntraface, updateFeedList(" + param1 + ") - END");
            return;
        }// end function

        public function disableFeed(param1:int) : void
        {
            var _loc_2:* = this._listaFeed[param1].indirizzo;
            if (this._killList.indexOf(_loc_2) < 0)
            {
                this._killList.push(_loc_2);
            }
            this.updateFeedList();
            this.saveKillList();
            return;
        }// end function

        public function getTitle(param1:int) : String
        {
            return this._listaFeed[param1].titolo;
        }// end function

        public function get activeFeeds() : Array
        {
            return this._feedAttivi;
        }// end function

        public function get feedCount() : Number
        {
            return this._listaFeed.length;
        }// end function

        public function getUrl(param1:int) : String
        {
            return this._listaFeed[param1].indirizzo;
        }// end function

        public static function getInstance() : RssInterface
        {
            if (selfInstance == null)
            {
                trace("RssInterface, getInstance, selfInstance not initialized");
                selfInstance = new RssInterface;
            }
            if (_expireTimeout == -1)
            {
                trace("RssInterface, getInstance, _expireTimeout not initialized:" + _expireTimeout);
                _expireTimeout = readExpireTimeout();
            }
            if (_lastUpdateTimeStamp == -1)
            {
                trace("RssInterface, getInstance, _lastUpdateTimeStamp not initialized:" + _lastUpdateTimeStamp);
                _lastUpdateTimeStamp = getTimer();
            }
            var _loc_1:* = getTimer();
            if (_loc_1 - _lastUpdateTimeStamp > _expireTimeout)
            {
                trace("RssInterface, getInstance, it need Feed data refresh");
                selfInstance.updateFeedList(true);
                _lastUpdateTimeStamp = _loc_1;
            }
            trace("RssInterface, getInstance, _expireTimeout:" + _expireTimeout);
            trace("RssInterface, getInstance, currentTimestamp:" + _loc_1);
            trace("RssInterface, getInstance, _lastUpdateTimeStamp:" + _lastUpdateTimeStamp);
            return selfInstance;
        }// end function

        private static function readExpireTimeout() : int
        {
            var strTimeout:String;
            strTimeout = RemotePreferences.getInstance().getValue("rss_feed_update_time");
            var intTimeout:int;
            if (strTimeout != null && strTimeout != "")
            {
                try
                {
                    intTimeout = int(strTimeout);
                    trace("rss_feeds_refesh_timeout: " + intTimeout + " mins");
                }
                catch (e:Error)
                {
                    trace("error converting rss_feeds_refesh_timeout: " + strTimeout + ". Using default=5 mins");
                }
            }
            else
            {
                trace("rss_feeds_refesh_timeout is null or empty: " + strTimeout + ". Using default=5 mins");
            }
            return intTimeout * _MINUTE;
        }// end function

    }
}
