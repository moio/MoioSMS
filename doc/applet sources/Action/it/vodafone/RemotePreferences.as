package it.vodafone
{
    import flash.events.*;
    import flash.net.*;

    public class RemotePreferences extends EventDispatcher
    {
        public const SKIN_TYPE:String = "vodafone_skin";
        public var loaded:Boolean = false;
        public const VODAFONE_SKIN:String = "vodafone_skin";
        private var prefLoader:URLLoader;
        public const ZEROLIMITS_SKIN:String = "zerolimits_skin";
        private static var selfInstance:RemotePreferences;
        public static var PREFERENCES_LOADED:String = "preferences_loaded";

        public function RemotePreferences() : void
        {
            this.performRequest();
            return;
        }// end function

        public function getValue(param1:String) : String
        {
            var _loc_2:* = LocalPreferences.getInstance().storageGet(param1);
            if (_loc_2 != null)
            {
                return _loc_2;
            }
            return this.getDefaultValue(param1);
        }// end function

        private function parsingRisultato(event:Event) : void
        {
            var i:int;
            var userData:XMLList;
            var key:String;
            var value:String;
            var e:* = event;
            trace("Preferences result " + e);
            try
            {
                userData = XML(this.prefLoader.data).children();
            }
            catch (e:Error)
            {
                dataUnavailable();
                return;
            }
            var mustReload:Boolean;
            while (i < userData.length())
            {
                
                key = XML(userData[i]).localName().toString();
                value = XML(userData[i]).toString();
                if (this.getDefaultValue(key) != null)
                {
                    if (key == "config_url" && this.getValue(key) != value)
                    {
                        mustReload;
                    }
                    LocalPreferences.getInstance().storageSet(key, value);
                }
                i = i++;
            }
            if (mustReload)
            {
                this.performRequest();
            }
            else
            {
                this.loaded = true;
                dispatchEvent(new Event(PREFERENCES_LOADED));
            }
            return;
        }// end function

        private function dataUnavailable(event:Event = null) : void
        {
            trace("remote Preferences: data unavailable");
            if (this.getDefaultValue("config_url") != this.getValue("config_url"))
            {
                LocalPreferences.getInstance().storageSet("config_url", this.getDefaultValue("config_url"));
                this.performRequest();
            }
            else
            {
                this.loaded = true;
                dispatchEvent(new Event(PREFERENCES_LOADED));
            }
            return;
        }// end function

        private function performRequest() : void
        {
            var _loc_1:* = new URLRequest(this.getValue("config_url"));
            _loc_1.cacheResponse = false;
            _loc_1.useCache = false;
            _loc_1.userAgent = this.getValue("user_agent");
            _loc_1.requestHeaders.push(new URLRequestHeader("Referer", "http://www.vodafone.it/"));
            this.prefLoader = new URLLoader();
            this.prefLoader.addEventListener(Event.COMPLETE, this.parsingRisultato);
            this.prefLoader.addEventListener(IOErrorEvent.IO_ERROR, this.dataUnavailable);
            this.prefLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.dataUnavailable);
            this.prefLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, this.genericHttpStatusHandler);
            this.prefLoader.load(_loc_1);
            return;
        }// end function

        private function getDefaultValue(param1:String) : String
        {
            switch(param1)
            {
                case "active":
                {
                }
                case "session_keepalive":
                {
                }
                case "log_url":
                {
                }
                case "user_agent":
                {
                }
                case "server_url":
                {
                }
                case "userdata_url":
                {
                }
                case "credito_url":
                {
                }
                case "infoconto_url":
                {
                }
                case "omnione_url":
                {
                }
                case "swap_url":
                {
                }
                case "logout_url":
                {
                }
                case "help_url":
                {
                }
                case "config_url":
                {
                }
                case "user_password_url":
                {
                }
                case "user_register_url":
                {
                }
                case "update_url":
                {
                }
                case "update_days":
                {
                }
                case "sms_precheck":
                {
                }
                case "sms_prepare":
                {
                }
                case "sms_send":
                {
                }
                case "banner_landing":
                {
                }
                case "banner_url":
                {
                }
                case "infoconto_validity":
                {
                }
                case "omnione_validity":
                {
                }
                case "rss_feeds":
                {
                }
                case "rss_feed_update_time":
                {
                }
                case "versionblock":
                {
                }
                case "vodafone_one_url":
                {
                }
                case "infoconto_more_url":
                {
                }
                case "v1_more_url":
                {
                }
                case "blinkDownloadLink":
                {
                }
                case "blinkDownloadIconVisible":
                {
                }
                case "blinkDownloadIconOn":
                {
                }
                case "server_url_portal":
                {
                }
                case "userdata_url_portal":
                {
                }
                case "swap_url_portal":
                {
                }
                default:
                {
                    break;
                }
            }
            switch(param1)
            {
                case "active":
                {
                }
                case "session_keepalive":
                {
                }
                case "log_url":
                {
                }
                case "user_agent":
                {
                }
                case "server_url":
                {
                }
                case "userdata_url":
                {
                }
                case "credito_url":
                {
                }
                case "infoconto_url":
                {
                }
                case "omnione_url":
                {
                }
                case "swap_url":
                {
                }
                case "logout_url":
                {
                }
                case "help_url":
                {
                }
                case "config_url":
                {
                }
                case "user_password_url":
                {
                }
                case "user_register_url":
                {
                }
                case "update_url":
                {
                }
                case "update_days":
                {
                }
                case "sms_precheck":
                {
                }
                case "sms_prepare":
                {
                }
                case "sms_send":
                {
                }
                case "banner_landing":
                {
                }
                case "banner_url":
                {
                }
                case "infoconto_validity":
                {
                }
                case "omnione_validity":
                {
                }
                case "rss_feeds":
                {
                }
                case "rss_feed_update_time":
                {
                }
                case "versionblock":
                {
                }
                case "vodafone_one_url":
                {
                }
                case "infoconto_more_url":
                {
                }
                case "v1_more_url":
                {
                }
                case "blinkDownloadLink":
                {
                }
                case "blinkDownloadIconVisible":
                {
                }
                case "blinkDownloadIconOn":
                {
                }
                case "server_url_portal":
                {
                }
                case "userdata_url_portal":
                {
                }
                case "swap_url_portal":
                {
                }
                default:
                {
                    break;
                }
            }
            return null;
        }// end function

        private function genericHttpStatusHandler(event:HTTPStatusEvent) : void
        {
            trace("Remote Preferences: " + event);
            if (event.status >= 500)
            {
                this.dataUnavailable();
            }
            else if (event.status >= 400)
            {
                this.dataUnavailable();
            }
            return;
        }// end function

        public function kill() : void
        {
            try
            {
                this.prefLoader.close();
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        public static function getInstance() : RemotePreferences
        {
            if (selfInstance == null)
            {
                selfInstance = new RemotePreferences;
            }
            return selfInstance;
        }// end function

    }
}
