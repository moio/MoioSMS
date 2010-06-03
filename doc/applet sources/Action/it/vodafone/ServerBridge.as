package it.vodafone
{
    import com.adobe.crypto.*;
    import com.etree.utils.crypt.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class ServerBridge extends EventDispatcher
    {
        private var _token:String = "";
        private var lastErrorMsg:String;
        private var _status:String;
        public var lastError:Number;
        private var vodafoneOneList:Array;
        public var smsMaxLength:int;
        private var omnioneLoader:URLLoader;
        private var _infocontoScaricati:Array;
        private var _username:String;
        public var _MD:String = "";
        private var creditoLoader:URLLoader;
        private var _receiver:String;
        private const useSecurityToken:Boolean = true;
        private var switchLoader:URLLoader;
        public var captcha:String;
        private var _userData:XML;
        private var infocontoLoader:URLLoader;
        public var smsThresold:Number;
        public var captchLength:Number;
        private var _saldiPunti:Array;
        private var _currentMsisdn:String;
        private var precheckLoader:URLLoader;
        private var _message:String;
        private var smsLoader:URLLoader;
        private var logoutTimer:Timer;
        private var loginLoader:URLLoader;
        private var keepAliveTimer:Timer;
        private var oldMsisdn:String = "";
        public var _sessione:String = "";
        private var _password:String;
        private static var selfInstance:ServerBridge;
        public static var LOGGED:String = "logged";
        public static var LOGGINGOUT:String = "logging_out";
        public static var LOADING_INFOCONTO:String = "loading_infoconto";
        public static var SMS_NO_MORE_MSG:String = "sms_no_more_msg";
        public static var SESSION_EXPIRED:String = "sessione_expired";
        public static var SESSION_RESTORED:String = "sessione_restored";
        public static var USER_DATA_LOADED:String = "user_data_loaded";
        public static var SMS_FATAL_ERROR:String = "sms_fatal_error";
        public static var CHECK_USER_SECURITY_ERROR:String = "check_user_security_error";
        public static var VALORE_INFOCONTO:int = 1;
        public static var SWITCH_TO_PORTAL_COMPLETE:String = "switch_to_portal_complete";
        public static var INFOCONTO_LOADED:String = "infoconto_loaded";
        public static var SWITCH_TO_PORTAL_FAILED:String = "switch_to_portal_failed";
        public static var UNLOGGED:String = "unlogged";
        public static var LOGGED_OUT_AFTER_ERROR:String = "logged_out_after_error";
        public static var VALORE_CREDITO:int = 0;
        public static var NO_SIM_ERROR:String = "no_sim";
        public static var SMS_CAPTCHA:String = "sms_captcha";
        public static var LOADING_OMNIONE:String = "loading_omnione";
        public static var SERVER_ERROR:String = "server_error";
        public static var SMS_SENT:String = "sms_sent";
        public static var LOGIN_COMPLETE:String = "login_complete";
        public static var LOGGED_OUT:String = "logged_out";
        public static var LOGIN_ERROR:String = "login_error";
        public static var SMS_PRECHECK_COMPLETE:String = "sms_precheck_complete";
        public static var CORPORATE_ERROR:String = "corporate_account";
        public static var OMNIONE_LOADED:String = "omnione_loaded";
        public static var SMS_ERROR:String = "sms_error";
        public static var NETWORK_ERROR:String = "network_error";

        public function ServerBridge(param1:IEventDispatcher = null)
        {
            super(param1);
            trace("ServerBridge : ServerBridge");
            this._status = UNLOGGED;
            this._infocontoScaricati = new Array();
            this._saldiPunti = new Array();
            this.setupKeepalive();
            return;
        }// end function

        public function get oraPunti() : String
        {
            var _loc_1:int = 0;
            while (_loc_1 < this._saldiPunti.length)
            {
                
                if (OmnioneCache(this._saldiPunti[_loc_1]).numero == this._currentMsisdn)
                {
                    return OmnioneCache(this._saldiPunti[_loc_1]).oraAggiornamento;
                }
                _loc_1++;
            }
            return "";
        }// end function

        private function httpLogoutBusinessStatusHandler(event:HTTPStatusEvent) : void
        {
            trace("ServerBridge : httpLogoutBusinessStatusHandler = " + event);
            this._status = UNLOGGED;
            dispatchEvent(new Event(CORPORATE_ERROR));
            return;
        }// end function

        private function sendSmsComplete(event:Event) : void
        {
            var i:int;
            var xmldata:XMLList;
            var e:* = event;
            trace("ServerBridge : sendSmsComplete , smsLoader.data = " + this.smsLoader.data);
            try
            {
                xmldata = XML(this.smsLoader.data).child("e");
            }
            catch (e:Error)
            {
                dispatchEvent(new Event(SMS_FATAL_ERROR));
                lastErrorMsg = "Servizio momentaneamente non disponibile";
                lastError = 999;
                return;
            }
            this.lastError = 0;
            this.lastErrorMsg = "";
            this.captcha = null;
            while (i < xmldata.length())
            {
                
                if (xmldata[i].attribute("n")[0] == "ERRORCODE" && xmldata[i].attribute("v")[0] == "102")
                {
                    this.sessionExpired();
                    return;
                }
                if (xmldata[i].attribute("n")[0] == "ERRORCODE" && xmldata[i].attribute("v")[0] != "0")
                {
                    this.lastError = Number(xmldata[i].attribute("v")[0]);
                }
                else if (xmldata[i].attribute("n")[0] == "SMSDAYTHRESHOLD")
                {
                    this.smsThresold = Number(xmldata[i].attribute("v")[0]);
                }
                else if (xmldata[i].attribute("n")[0] == "MSGMAXLENGTH")
                {
                    this.smsMaxLength = Number(xmldata[i].attribute("v")[0]);
                }
                else if (xmldata[i].attribute("n")[0] == "RETURNMSG")
                {
                }
                else if (xmldata[i].attribute("n")[0] == "CODEIMG")
                {
                    this.captcha = xmldata[i].toString();
                }
                else if (xmldata[i].attribute("n")[0] == "CODEMAXLENGTH")
                {
                    this.captchLength = Number(xmldata[i].attribute("v")[0].toString());
                }
                i = i++;
            }
            if (this.lastError != 0)
            {
                this.processError(this.lastError);
            }
            if (this.captcha)
            {
                dispatchEvent(new Event(SMS_CAPTCHA));
            }
            else if (this.lastError == 0)
            {
                this.sendSmsWithCaptcha(this._receiver, this._message);
            }
            this.keepAliveReset();
            return;
        }// end function

        private function sessionExpiredHold(event:Event) : void
        {
            trace("ServerBridge  : sessionExpiredHold");
            var _loc_2:* = new Timer(1000 * 5, 1);
            _loc_2.addEventListener(TimerEvent.TIMER, this.sessionExpiredClean);
            _loc_2.start();
            return;
        }// end function

        public function abortLogin(param1:String) : void
        {
            trace("ServerBridge : abortLogin, kind = " + param1);
            if (this.loginLoader != null)
            {
                this.loginLoader.close();
            }
            var _loc_2:* = new Date();
            var _loc_3:* = new URLRequest(RemotePreferences.getInstance().getValue("logout_url") + "?" + _loc_2.time);
            _loc_3.cacheResponse = false;
            _loc_3.useCache = false;
            _loc_3.userAgent = RemotePreferences.getInstance().getValue("user_agent");
            _loc_3.requestHeaders.push(new URLRequestHeader("Referer", "http://www.vodafone.it/"));
            this.loginLoader = new URLLoader();
            this.loginLoader.addEventListener(IOErrorEvent.IO_ERROR, this.systemOffline);
            this.loginLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.systemOffline);
            if (param1 == CORPORATE_ERROR)
            {
                this.loginLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, this.httpLogoutBusinessStatusHandler);
            }
            else
            {
                this.loginLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, this.httpLogoutNosimStatusHandler);
            }
            this.loginLoader.load(_loc_3);
            this._status = LOGGINGOUT;
            return;
        }// end function

        public function switchToPortal() : void
        {
            trace("*** *** ServerBridge : switchToPortal *** ***");
            this.keepAliveReset();
            var _loc_1:* = new Date();
            var _loc_2:* = new URLRequest(RemotePreferences.getInstance().getValue("userdata_url") + "?deleteCookies=true&" + _loc_1.time);
            _loc_2.followRedirects = false;
            _loc_2.cacheResponse = false;
            _loc_2.useCache = false;
            _loc_2.userAgent = RemotePreferences.getInstance().getValue("user_agent");
            _loc_2.requestHeaders.push(new URLRequestHeader("Referer", "http://www.vodafone.it/"));
            this.switchLoader = new URLLoader();
            this.switchLoader.addEventListener(Event.COMPLETE, this.switchResponseDelete);
            this.switchLoader.addEventListener(IOErrorEvent.IO_ERROR, this.systemOffline);
            this.switchLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.systemOffline);
            this.switchLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, this.switchHttpStatusHandler);
            this.switchLoader.load(_loc_2);
            return;
        }// end function

        private function genericHttpStatusHandler(event:HTTPStatusEvent) : void
        {
            trace("ServerBridge : genericHttpStatusHandler = " + event);
            if (event.status >= 500)
            {
                this.serverError();
            }
            else if (event.status >= 400)
            {
                this.serverError();
            }
            return;
        }// end function

        public function get punti() : String
        {
            if (!this.simVodafoneOne(this._currentMsisdn))
            {
                return "non_iscritto";
            }
            var _loc_1:int = 0;
            while (_loc_1 < this._saldiPunti.length)
            {
                
                if (OmnioneCache(this._saldiPunti[_loc_1]).numero == this._currentMsisdn)
                {
                    return OmnioneCache(this._saldiPunti[_loc_1]).punti;
                }
                _loc_1++;
            }
            return null;
        }// end function

        private function precheckReceived(event:Event) : void
        {
            var i:int;
            var xmldata:XMLList;
            var e:* = event;
            trace("ServerBridge : precheckReceived");
            try
            {
                xmldata = XML(this.precheckLoader.data).child("e");
            }
            catch (e:Error)
            {
                lastErrorMsg = "Servizio momentaneamente non disponibile";
                lastError = 999;
                dispatchEvent(new Event(SMS_FATAL_ERROR));
                return;
            }
            this.lastError = 0;
            this.lastErrorMsg = "";
            while (i < xmldata.length())
            {
                
                if (xmldata[i].attribute("n")[0] == "ERRORCODE" && xmldata[i].attribute("v")[0] == "102")
                {
                    this.sessionExpired();
                    return;
                }
                if (xmldata[i].attribute("n")[0] == "ERRORCODE" && xmldata[i].attribute("v")[0] != "0")
                {
                    this.lastError = Number(xmldata[i].attribute("v")[0]);
                }
                if (xmldata[i].attribute("n")[0] == "SMSDAYTHRESHOLD")
                {
                    this.smsThresold = Number(xmldata[i].attribute("v")[0]);
                }
                if (xmldata[i].attribute("n")[0] == "MSGMAXLENGTH")
                {
                    this.smsMaxLength = Number(xmldata[i].attribute("v")[0]);
                }
                if (xmldata[i].attribute("n")[0] == "RETURNMSG")
                {
                }
                i = i++;
            }
            if (this.lastError != 0)
            {
                this.processError(this.lastError);
            }
            dispatchEvent(new Event(SMS_PRECHECK_COMPLETE));
            return;
        }// end function

        public function get isLogged() : Boolean
        {
            return this._status == LOGGED;
        }// end function

        private function forceLogout(event:Event) : void
        {
            trace("ServerBridge : forceLogout= " + event);
            if (this._status != LOGGED && this._status != LOGGINGOUT)
            {
                return;
            }
            this.kill();
            this._status = UNLOGGED;
            dispatchEvent(new Event(LOGGED_OUT));
            return;
        }// end function

        public function kill() : void
        {
            trace("ServerBridge : kill");
            try
            {
                this.loginLoader.close();
            }
            catch (e:Error)
            {
                try
                {
                }
                this.infocontoLoader.close();
            }
            catch (e:Error)
            {
                try
                {
                }
                this.creditoLoader.close();
            }
            catch (e:Error)
            {
                try
                {
                }
                this.omnioneLoader.close();
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        public function sendSmsWithCaptcha(param1:String, param2:String, param3:String = null) : void
        {
            var receiver:* = param1;
            var message:* = param2;
            var captcha:* = param3;
            trace("ServerBridge : sendSmsWithCaptcha");
            try
            {
                if (this.smsLoader != null)
                {
                    this.smsLoader.close();
                }
            }
            catch (e:Error)
            {
            }
            this.smsLoader = new URLLoader();
            var richiesta:* = new URLRequest(RemotePreferences.getInstance().getValue("sms_send"));
            richiesta.cacheResponse = false;
            richiesta.useCache = false;
            richiesta.userAgent = RemotePreferences.getInstance().getValue("user_agent");
            richiesta.requestHeaders.push(new URLRequestHeader("Referer", "http://www.vodafone.it/"));
            var datiPost:* = new URLVariables();
            datiPost.receiverNumber = receiver;
            datiPost.message = message;
            if (captcha)
            {
                datiPost.verifyCode = captcha;
            }
            richiesta.data = datiPost;
            richiesta.method = URLRequestMethod.POST;
            this.smsLoader = new URLLoader();
            this.smsLoader.addEventListener(IOErrorEvent.IO_ERROR, this.smsSystemOffline);
            this.smsLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.smsSystemOffline);
            this.smsLoader.addEventListener(Event.COMPLETE, this.sendSmsFinalComplete);
            this.smsLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, this.smsHttpStatusHandler);
            this.smsLoader.load(richiesta);
            return;
        }// end function

        public function set currentMsisdn(param1:String) : void
        {
            var dttime:Date;
            var richiestaLogin:URLRequest;
            var datiPost:URLVariables;
            var msisdn:* = param1;
            trace("ServerBridge : currentMsisdn , msisdn = " + msisdn);
            if (this._status != LOGGED)
            {
                return;
            }
            var listaNumeri:* = this.msisdnList;
            if (listaNumeri.indexOf(msisdn) >= 0 && msisdn != this._currentMsisdn)
            {
                try
                {
                    if (this.loginLoader != null)
                    {
                        this.loginLoader.close();
                    }
                }
                catch (e:Error)
                {
                    try
                    {
                    }
                    if (this.infocontoLoader != null)
                    {
                        this.infocontoLoader.close();
                    }
                }
                catch (e:Error)
                {
                    try
                    {
                    }
                    if (this.omnioneLoader != null)
                    {
                        this.omnioneLoader.close();
                    }
                }
                catch (e:Error)
                {
                }
                dttime = new Date();
                richiestaLogin = new URLRequest(RemotePreferences.getInstance().getValue("swap_url") + "?" + dttime.time);
                richiestaLogin.cacheResponse = false;
                datiPost = new URLVariables();
                datiPost.ty_sim = msisdn;
                datiPost.swap_sim_link = msisdn;
                richiestaLogin.data = datiPost;
                richiestaLogin.method = URLRequestMethod.POST;
                richiestaLogin.useCache = false;
                richiestaLogin.userAgent = RemotePreferences.getInstance().getValue("user_agent");
                richiestaLogin.requestHeaders.push(new URLRequestHeader("Referer", "http://www.vodafone.it/"));
                this.loginLoader = new URLLoader();
                this.loginLoader.addEventListener(IOErrorEvent.IO_ERROR, this.systemOffline);
                this.loginLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.systemOffline);
                this.loginLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, this.switchMsisdnStatusHandler);
                this.loginLoader.load(richiestaLogin);
            }
            return;
        }// end function

        public function login(param1:String, param2:String) : void
        {
            var username:* = param1;
            var password:* = param2;
            trace("ServerBridge , login user: " + username);
            this._username = username;
            this._password = password;
            if (this.logoutTimer != null)
            {
                this.logoutTimer.reset();
            }
            if (this.loginLoader != null)
            {
                try
                {
                    this.loginLoader.close();
                }
                catch (error:Error)
                {
                    trace("Main - login - warning: error closing URLLoader. " + error.name + "[" + error.errorID + "]: " + error.message);
                }
            }
            var dttime:* = new Date();
            var richiestaLogin:* = new URLRequest(RemotePreferences.getInstance().getValue("server_url") + "?" + dttime.time);
            richiestaLogin.cacheResponse = false;
            var datiPost:* = new URLVariables();
            datiPost.password = this._password;
            datiPost.username = this._username;
            richiestaLogin.data = datiPost;
            richiestaLogin.method = URLRequestMethod.POST;
            richiestaLogin.useCache = false;
            richiestaLogin.userAgent = RemotePreferences.getInstance().getValue("user_agent");
            richiestaLogin.requestHeaders.push(new URLRequestHeader("Referer", "http://www.vodafone.it/"));
            this.loginLoader = new URLLoader();
            this.loginLoader.addEventListener(IOErrorEvent.IO_ERROR, this.systemOffline);
            this.loginLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.systemOffline);
            this.loginLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, this.httpLoginStatusHandler);
            this.loginLoader.load(richiestaLogin);
            return;
        }// end function

        private function setupKeepalive() : void
        {
            trace("ServerBridge : setupKeepalive");
            this.keepAliveTimer = new Timer(1000 * 60 * 15, 4 * Number(RemotePreferences.getInstance().getValue("session_keepalive")));
            this.keepAliveTimer.addEventListener(TimerEvent.TIMER, this.tickleServer);
            return;
        }// end function

        public function get displayName() : String
        {
            if (this._status == UNLOGGED)
            {
                return "";
            }
            return this._userData.child("user")[0].child("first-name")[0];
        }// end function

        public function retrieveUserData() : Boolean
        {
            trace("ServerBridge : retrieveUserData");
            this.loginLoader.close();
            var _loc_1:* = new Date().getTime();
            this._token = MD5.hash(this._username + _loc_1);
            var _loc_2:* = new URLRequest(RemotePreferences.getInstance().getValue("userdata_url") + "?token=" + this._token);
            _loc_2.cacheResponse = false;
            _loc_2.useCache = false;
            _loc_2.userAgent = RemotePreferences.getInstance().getValue("user_agent");
            _loc_2.requestHeaders.push(new URLRequestHeader("Referer", "http://www.vodafone.it/"));
            this.loginLoader = new URLLoader();
            this.loginLoader.addEventListener(Event.COMPLETE, this.userDataResult);
            this.loginLoader.addEventListener(IOErrorEvent.IO_ERROR, this.systemOffline);
            this.loginLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.systemOffline);
            this.loginLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, this.genericHttpStatusHandler);
            this.loginLoader.load(_loc_2);
            return true;
        }// end function

        public function get lastSmsErrorCode() : Number
        {
            return this.lastError;
        }// end function

        private function switchMsisdnStatusHandler(event:HTTPStatusEvent) : void
        {
            trace("ServerBridge : switchMsisdnStatusHandler = " + event);
            if (event.status >= 500)
            {
                this.serverError();
            }
            else if (event.status >= 400)
            {
                this.serverError();
            }
            else
            {
                this.retrieveUserData();
            }
            return;
        }// end function

        private function switchHttpStatusHandler(event:HTTPStatusEvent) : void
        {
            trace("ServerBridge : switchHttpStatusHandler - httpLoginStatusHandler= " + event);
            trace("loginLoader.data: " + this.switchLoader.data);
            var _loc_2:Number = 0;
            while (_loc_2++ < event.responseHeaders.length)
            {
                
                trace("ServerBridge : switchHttpStatusHandler, " + event.responseHeaders[_loc_2].name + " = " + event.responseHeaders[_loc_2].value);
            }
            if (event.status >= 500)
            {
                this.sessionExpired();
            }
            else if (event.status >= 400)
            {
                this.sessionExpired();
            }
            return;
        }// end function

        private function serverError() : void
        {
            trace("ServerBridge : serverError");
            dispatchEvent(new Event(SERVER_ERROR));
            this._status = UNLOGGED;
            return;
        }// end function

        public function logout() : void
        {
            trace("ServerBridge : logout , _status = " + this._status);
            if (this._status == UNLOGGED)
            {
                dispatchEvent(new Event(LOGGED_OUT));
                return;
            }
            if (this.loginLoader != null)
            {
                this.loginLoader.close();
            }
            var _loc_1:* = new Date();
            var _loc_2:* = new URLRequest(RemotePreferences.getInstance().getValue("logout_url") + "?" + _loc_1.time);
            _loc_2.cacheResponse = false;
            _loc_2.useCache = false;
            _loc_2.userAgent = RemotePreferences.getInstance().getValue("user_agent");
            _loc_2.requestHeaders.push(new URLRequestHeader("Referer", "http://www.vodafone.it/"));
            this.loginLoader = new URLLoader();
            this.loginLoader.addEventListener(IOErrorEvent.IO_ERROR, this.systemOffline);
            this.loginLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.systemOffline);
            this.loginLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, this.httpLogoutStatusHandler);
            this.loginLoader.load(_loc_2);
            this.logoutTimer = new Timer(15000, 1);
            this.logoutTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.forceLogout);
            this.logoutTimer.start();
            this._status = LOGGINGOUT;
            return;
        }// end function

        private function httpLogoutErrorHandler(param1:Error) : void
        {
            trace("ServerBridge : httpLogoutErrorHandler: " + param1);
            this._status = UNLOGGED;
            dispatchEvent(new Event(LOGGED_OUT));
            return;
        }// end function

        public function updateCredito(param1:Boolean = false) : void
        {
            var force:* = param1;
            trace("ServerBridge : updateCredito");
            if (this._status == UNLOGGED || this._currentMsisdn == null)
            {
                return;
            }
            var j:int;
            while (j < this._infocontoScaricati.length)
            {
                
                if (!NumberDataCache(this._infocontoScaricati[j]).expired || !force && NumberDataCache(this._infocontoScaricati[j]).numero == this._currentMsisdn)
                {
                    dispatchEvent(new Event(INFOCONTO_LOADED));
                    return;
                }
                j = j++;
            }
            dispatchEvent(new Event(LOADING_INFOCONTO));
            try
            {
                if (this.infocontoLoader != null)
                {
                    this.infocontoLoader.close();
                }
            }
            catch (e:Error)
            {
            }
            this.infocontoLoader = new URLLoader();
            var richiesta:* = new URLRequest(RemotePreferences.getInstance().getValue("infoconto_url"));
            richiesta.cacheResponse = false;
            richiesta.useCache = false;
            richiesta.userAgent = RemotePreferences.getInstance().getValue("user_agent");
            richiesta.requestHeaders.push(new URLRequestHeader("Referer", "http://www.vodafone.it/"));
            this.infocontoLoader = new URLLoader();
            this.infocontoLoader.addEventListener(IOErrorEvent.IO_ERROR, this.systemOffline);
            this.infocontoLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.systemOffline);
            this.infocontoLoader.addEventListener(Event.COMPLETE, this.creditoCaricato);
            this.infocontoLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, this.genericHttpStatusHandler);
            this.infocontoLoader.load(richiesta);
            try
            {
                if (this.creditoLoader != null)
                {
                    this.creditoLoader.close();
                }
            }
            catch (e:Error)
            {
            }
            richiesta = new URLRequest(RemotePreferences.getInstance().getValue("credito_url"));
            this.creditoLoader = new URLLoader();
            richiesta.cacheResponse = false;
            richiesta.useCache = false;
            richiesta.userAgent = RemotePreferences.getInstance().getValue("user_agent");
            richiesta.requestHeaders.push(new URLRequestHeader("Referer", "http://www.vodafone.it/"));
            this.creditoLoader = new URLLoader();
            this.creditoLoader.addEventListener(IOErrorEvent.IO_ERROR, this.systemOffline);
            this.creditoLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.systemOffline);
            this.creditoLoader.addEventListener(Event.COMPLETE, this.creditoCaricato);
            this.creditoLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, this.genericHttpStatusHandler);
            this.creditoLoader.load(richiesta);
            return;
        }// end function

        private function switchFailed(param1:Error = null) : void
        {
            trace("*** SwitchFailed! *** Starting restore ***");
            dispatchEvent(new Event(SWITCH_TO_PORTAL_FAILED));
            this.sessionExpired();
            return;
        }// end function

        public function get credito() : String
        {
            var _loc_1:int = 0;
            while (_loc_1 < this._infocontoScaricati.length)
            {
                
                if (NumberDataCache(this._infocontoScaricati[_loc_1]).numero == this._currentMsisdn)
                {
                    return NumberDataCache(this._infocontoScaricati[_loc_1]).credito;
                }
                _loc_1++;
            }
            return null;
        }// end function

        public function get msisdnList() : Array
        {
            var listaDati:XMLList;
            var k:int;
            trace("ServerBridge : msisdnList");
            var ris:* = new Array();
            try
            {
                this.vodafoneOneList = new Array();
                if (this._userData.child("user")[0].child("all-vod-sims").length() > 0)
                {
                    listaDati = this._userData.child("user")[0].child("all-vod-sims")[0].child("vod-sim");
                    k;
                    while (k < listaDati.length())
                    {
                        
                        if (listaDati[k].isBlocked == "false")
                        {
                            ris.push(listaDati[k].msisdn.toString());
                        }
                        if (listaDati[k].vodafoneOne == "Y")
                        {
                            this.vodafoneOneList.push(listaDati[k].msisdn.toString());
                        }
                        k = k++;
                    }
                }
            }
            catch (e:Error)
            {
            }
            return ris;
        }// end function

        private function userDataResult(event:Event) : void
        {
            var usernameCheckUser:String;
            var listaNumeri:Array;
            var e:* = event;
            trace("ServerBridge : userDataResult = " + e);
            this.keepAliveReset();
            Tracciamento.getInstance().username = this._username;
            try
            {
                this._userData = XML(this.loginLoader.data);
                trace(this._userData);
                this._sessione = this._userData.child("session-id")[0];
                Tracciamento.getInstance().sessionId = this._sessione;
            }
            catch (e:Error)
            {
                serverError();
                return;
            }
            if (this._status == LOGGED && this._userData.child("logged-in")[0] != "true")
            {
                this.sessionExpired();
                return;
            }
            if (this._userData.child("logged-in")[0] != "true")
            {
                trace("ServerBridge : userDataResult, Login failed");
                this._status = UNLOGGED;
                this._sessione = "";
                Tracciamento.getInstance().tracciaEvento(Tracciamento.LOGIN_FALLITA);
                dispatchEvent(new Event(LOGIN_ERROR));
                return;
            }
            if (this._userData.child("user").length() == 0)
            {
                this.serverError();
                return;
            }
            if (this.useSecurityToken)
            {
                try
                {
                    usernameCheckUser = this._userData.child("security")[0].child("username")[0].toString().toUpperCase();
                    if (usernameCheckUser != this._username.toUpperCase() || this._userData.child("security")[0].child("token")[0] != this._token)
                    {
                        Tracciamento.getInstance().tracciaEvento(Tracciamento.LOGIN_FALLITA);
                        dispatchEvent(new Event(CHECK_USER_SECURITY_ERROR));
                        return;
                    }
                }
                catch (e:Error)
                {
                    Tracciamento.getInstance().tracciaEvento(Tracciamento.LOGIN_FALLITA);
                    dispatchEvent(new Event(CHECK_USER_SECURITY_ERROR));
                    return;
                }
            }
            var _userOptions:* = this._userData.child("user")[0];
            if (this._userData.child("logged-in")[0] == "true" && _userOptions.child("is-consumer")[0] == "true" && this.msisdnList.length == 0)
            {
                trace("ServerBridge : userDataResult, NOT Logged: nessuna SIM associata");
                Tracciamento.getInstance().tracciaEvento(Tracciamento.LOGIN_FALLITA);
                this.abortLogin(NO_SIM_ERROR);
            }
            else if (this._userData.child("logged-in")[0] == "true" && _userOptions.child("is-consumer")[0] == "true" && _userOptions.child("is-blocked")[0] == "false")
            {
                trace("ServerBridge : userDataResult, Logged");
                if (this._status == UNLOGGED)
                {
                    trace("ServerBridge : userDataResult, Tacciamento.LOGIN");
                    Tracciamento.getInstance().tracciaEvento(Tracciamento.LOGIN);
                    dispatchEvent(new Event(LOGIN_COMPLETE));
                }
                this._status = LOGGED;
                if (_userOptions.child("current-msisdn").length() == 0)
                {
                    listaNumeri = this.msisdnList;
                    if (listaNumeri.length > 0)
                    {
                        this._currentMsisdn = listaNumeri[0];
                    }
                }
                else
                {
                    this._currentMsisdn = _userOptions.child("current-msisdn")[0];
                }
                this._MD = this._userData.child("cauthcookie")[0];
                if (this._MD == null)
                {
                    this._MD = "";
                }
                if (this.oldMsisdn != "" && this.oldMsisdn != this._currentMsisdn)
                {
                    this.currentMsisdn = this.oldMsisdn;
                }
                else if (this.oldMsisdn != "")
                {
                    this.oldMsisdn = "";
                    dispatchEvent(new Event(SESSION_RESTORED));
                    dispatchEvent(new Event(USER_DATA_LOADED));
                }
                else
                {
                    dispatchEvent(new Event(USER_DATA_LOADED));
                }
            }
            else if (this._userData.child("logged-in")[0] == "true" && _userOptions.child("is-consumer")[0] == "false" && _userOptions.child("is-blocked")[0] == "false")
            {
                trace("ServerBridge : userDataResult, NOT Logged:corporate");
                Tracciamento.getInstance().tracciaEvento(Tracciamento.LOGIN_FALLITA);
                this.abortLogin(CORPORATE_ERROR);
            }
            return;
        }// end function

        private function sendSmsFinalComplete(event:Event) : void
        {
            var i:int;
            var xmldata:XMLList;
            var e:* = event;
            trace("ServerBridge : sendSmsFinalComplete , smsLoader.data = " + this.smsLoader.data);
            try
            {
                xmldata = XML(this.smsLoader.data).child("e");
            }
            catch (e:Error)
            {
                dispatchEvent(new Event(SMS_FATAL_ERROR));
                lastErrorMsg = "Servizio momentaneamente non disponibile";
                lastError = 999;
                return;
            }
            this.lastError = 0;
            this.captcha = null;
            while (i < xmldata.length())
            {
                
                if (xmldata[i].attribute("n")[0] == "ERRORCODE" && xmldata[i].attribute("v")[0] == "102")
                {
                    this.sessionExpired();
                    return;
                }
                if (xmldata[i].attribute("n")[0] == "ERRORCODE" && xmldata[i].attribute("v")[0] != "0")
                {
                    this.lastError = Number(xmldata[i].attribute("v")[0]);
                }
                else if (xmldata[i].attribute("n")[0] == "SMSDAYTHRESHOLD")
                {
                    this.smsThresold = Number(xmldata[i].attribute("v")[0]);
                }
                else if (xmldata[i].attribute("n")[0] == "MSGMAXLENGTH")
                {
                    this.smsMaxLength = Number(xmldata[i].attribute("v")[0]);
                }
                else if (xmldata[i].attribute("n")[0] == "RETURNMSG")
                {
                }
                else if (xmldata[i].attribute("n")[0] == "CODEIMG")
                {
                    this.captcha = xmldata[i].toString();
                }
                else if (xmldata[i].attribute("n")[0] == "CODEMAXLENGTH")
                {
                    this.captchLength = Number(xmldata[i].attribute("v")[0].toString());
                }
                i = i++;
            }
            if (this.captcha)
            {
                this.lastError = 116;
            }
            if (this.lastError == 0)
            {
                dispatchEvent(new Event(SMS_SENT));
                Tracciamento.getInstance().tracciaSms(this._currentMsisdn, this._receiver);
                this.addSmsCount(Math.ceil(this._message.length / 160));
            }
            else
            {
                this.processError(this.lastError);
                if (this.lastError == 116)
                {
                    dispatchEvent(new Event(SMS_CAPTCHA));
                }
            }
            this.keepAliveReset();
            return;
        }// end function

        private function switchResponseDelete(event:Event) : void
        {
            trace("ServerBridge : switchResponseDelete = " + event);
            var _loc_2:* = new Date();
            var _loc_3:* = new URLRequest(RemotePreferences.getInstance().getValue("server_url_portal") + "?" + _loc_2.time);
            _loc_3.cacheResponse = false;
            var _loc_4:* = new URLVariables();
            new URLVariables().password = this._password;
            _loc_4.username = this._username;
            _loc_3.data = _loc_4;
            _loc_3.method = URLRequestMethod.POST;
            _loc_3.cacheResponse = false;
            _loc_3.useCache = false;
            _loc_3.userAgent = RemotePreferences.getInstance().getValue("user_agent");
            _loc_3.requestHeaders.push(new URLRequestHeader("Referer", "http://www.vodafone.it/"));
            this.switchLoader = new URLLoader();
            this.switchLoader.addEventListener(Event.COMPLETE, this.switchResponseLogin);
            this.switchLoader.addEventListener(IOErrorEvent.IO_ERROR, this.systemOffline);
            this.switchLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.systemOffline);
            this.switchLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, this.switchHttpStatusHandler);
            this.switchLoader.load(_loc_3);
            return;
        }// end function

        private function switchResponseUserdata(event:Event) : void
        {
            var _uData:XML;
            var e:* = event;
            trace("ServerBridge : switchResponseUserdata = " + e);
            try
            {
                _uData = XML(this.switchLoader.data);
            }
            catch (e:Error)
            {
                switchFailed();
                return;
            }
            if (_uData.child("logged-in")[0] != "true")
            {
                trace("ServerBridge : switchResponseUserdata, Login failed");
                this.switchFailed();
                return;
            }
            if (_uData.child("user").length() == 0)
            {
                this.switchFailed();
                return;
            }
            if (this.useSecurityToken)
            {
                try
                {
                    if (_uData.child("security")[0].child("username")[0].toString().toUpperCase() != this._username.toUpperCase() || _uData.child("security")[0].child("token")[0] != this._token)
                    {
                        this.switchFailed();
                        return;
                    }
                }
                catch (e:Error)
                {
                    switchFailed();
                    return;
                }
            }
            var _userOptions:* = _uData.child("user")[0];
            if (_uData.child("logged-in")[0] == "true" && _userOptions.child("is-consumer")[0] == "true" && _userOptions.child("is-blocked")[0] == "false")
            {
                trace("ServerBridge : switchResponseUserdata, Logged");
                this._sessione = _uData.child("session-id")[0];
                this._MD = _uData.child("cauthcookie")[0];
                if (this._MD == null)
                {
                    this._MD = "";
                }
                dispatchEvent(new Event(SWITCH_TO_PORTAL_COMPLETE));
            }
            else if (_uData.child("logged-in")[0] == "true" && _userOptions.child("is-consumer")[0] == "false" && _userOptions.child("is-blocked")[0] == "false")
            {
                trace("ServerBridge : switchResponseUserdata, NOT Logged:corporate");
                this.switchFailed();
            }
            return;
        }// end function

        private function creditoCaricato(event:Event) : void
        {
            var _loc_6:String = null;
            trace("ServerBridge : creditoCaricato");
            var _loc_2:* = URLLoader(event.target);
            var _loc_3:* = XML(_loc_2.data);
            var _loc_4:* = _loc_3.child("e");
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4.length())
            {
                
                if (_loc_4[_loc_5].attribute("n").length() > 0 && _loc_4[_loc_5].attribute("v").length() > 0)
                {
                    if (_loc_4[_loc_5].attribute("n")[0] == "TRAFFICO_NON_FATTURATO")
                    {
                        this.aggiungiNumberData(new NumberDataCache(this._currentMsisdn, VALORE_INFOCONTO, _loc_4[_loc_5].attribute("v")[0]));
                        Tracciamento.getInstance().tracciaEvento(Tracciamento.INFOCONTO);
                        dispatchEvent(new Event(INFOCONTO_LOADED));
                    }
                    else if (_loc_4[_loc_5].attribute("n")[0] == "CREDITO_RESIDUO")
                    {
                        _loc_6 = Crypter.decrypt(_loc_4[_loc_5].attribute("v")[0], this._sessione);
                        this.aggiungiNumberData(new NumberDataCache(this._currentMsisdn, VALORE_CREDITO, _loc_6));
                        Tracciamento.getInstance().tracciaEvento(Tracciamento.CREDITO);
                        dispatchEvent(new Event(INFOCONTO_LOADED));
                    }
                    else
                    {
                        if (_loc_4[_loc_5].attribute("n")[0] == "ERROR_200")
                        {
                            this.sessionExpired();
                            return;
                        }
                        if (_loc_4[_loc_5].attribute("n")[0] == "ERROR_600")
                        {
                            this.sessionExpired();
                            return;
                        }
                    }
                }
                _loc_5++;
            }
            this.keepAliveReset();
            return;
        }// end function

        public function sessionExpired() : void
        {
            trace("ServerBridge : sessionExpired");
            if (this.oldMsisdn != "")
            {
                this.oldMsisdn = this._currentMsisdn;
            }
            this.oldMsisdn = this._currentMsisdn;
            dispatchEvent(new Event(SESSION_EXPIRED));
            if (this.loginLoader != null)
            {
                this.loginLoader.close();
            }
            var _loc_1:* = new Date();
            var _loc_2:* = new URLRequest(RemotePreferences.getInstance().getValue("userdata_url") + "?deleteCookies=true&" + _loc_1.time);
            _loc_2.cacheResponse = false;
            _loc_2.useCache = false;
            _loc_2.followRedirects = false;
            _loc_2.userAgent = RemotePreferences.getInstance().getValue("user_agent");
            _loc_2.requestHeaders.push(new URLRequestHeader("Referer", "http://www.vodafone.it/"));
            this.loginLoader = new URLLoader();
            this.loginLoader.addEventListener(IOErrorEvent.IO_ERROR, this.systemOffline);
            this.loginLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.systemOffline);
            this.loginLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, this.sessionExpiredHold);
            this.loginLoader.load(_loc_2);
            return;
        }// end function

        public function sendSMS(param1:String, param2:String) : void
        {
            var receiver:* = param1;
            var message:* = param2;
            trace("ServerBridge : sendSMS");
            try
            {
                if (this.smsLoader != null)
                {
                    this.smsLoader.close();
                }
            }
            catch (e:Error)
            {
            }
            this._receiver = receiver;
            this._message = message;
            this.smsLoader = new URLLoader();
            var availableChars:* = this.smsMaxLength - message.length;
            var richiesta:* = new URLRequest(RemotePreferences.getInstance().getValue("sms_prepare"));
            richiesta.cacheResponse = false;
            richiesta.useCache = false;
            richiesta.userAgent = RemotePreferences.getInstance().getValue("user_agent");
            richiesta.requestHeaders.push(new URLRequestHeader("Referer", "http://www.vodafone.it/"));
            var datiPost:* = new URLVariables();
            datiPost.receiverNumber = receiver;
            datiPost.message = message;
            datiPost.availableChars = availableChars.toString();
            richiesta.data = datiPost;
            richiesta.method = URLRequestMethod.POST;
            this.smsLoader = new URLLoader();
            this.smsLoader.addEventListener(IOErrorEvent.IO_ERROR, this.smsSystemOffline);
            this.smsLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.smsSystemOffline);
            this.smsLoader.addEventListener(Event.COMPLETE, this.sendSmsComplete);
            this.smsLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, this.smsHttpStatusHandler);
            this.smsLoader.load(richiesta);
            return;
        }// end function

        public function updateOmnione(param1:Boolean = false) : void
        {
            var force:* = param1;
            trace("ServerBridge : updateOmnione");
            if (this._status == UNLOGGED || this._currentMsisdn == null)
            {
                return;
            }
            if (!this.simVodafoneOne(this._currentMsisdn))
            {
                dispatchEvent(new Event(OMNIONE_LOADED));
                return;
            }
            var j:int;
            while (j < this._saldiPunti.length)
            {
                
                if (!OmnioneCache(this._saldiPunti[j]).expired || !force && OmnioneCache(this._saldiPunti[j]).numero == this._currentMsisdn)
                {
                    dispatchEvent(new Event(OMNIONE_LOADED));
                    return;
                }
                j = j++;
            }
            dispatchEvent(new Event(LOADING_OMNIONE));
            try
            {
                if (this.omnioneLoader != null)
                {
                    this.omnioneLoader.close();
                }
            }
            catch (e:Error)
            {
            }
            this.omnioneLoader = new URLLoader();
            var richiesta:* = new URLRequest(RemotePreferences.getInstance().getValue("omnione_url"));
            richiesta.cacheResponse = false;
            richiesta.useCache = false;
            richiesta.userAgent = RemotePreferences.getInstance().getValue("user_agent");
            richiesta.requestHeaders.push(new URLRequestHeader("Referer", "http://www.vodafone.it/"));
            this.omnioneLoader = new URLLoader();
            this.omnioneLoader.addEventListener(IOErrorEvent.IO_ERROR, this.systemOffline);
            this.omnioneLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.systemOffline);
            this.omnioneLoader.addEventListener(Event.COMPLETE, this.omnioneCaricato);
            this.omnioneLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, this.genericHttpStatusHandler);
            this.omnioneLoader.load(richiesta);
            return;
        }// end function

        private function systemOffline(event:Event) : void
        {
            trace("ServerBridge : systemOffline");
            dispatchEvent(new Event(NETWORK_ERROR));
            return;
        }// end function

        private function httpLoginStatusHandler(event:HTTPStatusEvent) : void
        {
            trace("ServerBridge : httpLoginStatusHandler= " + event);
            trace("loginLoader.data: " + this.loginLoader.data);
            var _loc_2:Number = 0;
            while (_loc_2++ < event.responseHeaders.length)
            {
                
                trace("ServerBridge : httpLoginStatusHandler, " + event.responseHeaders[_loc_2].name + " = " + event.responseHeaders[_loc_2].value);
            }
            if (event.status >= 500)
            {
                this.serverError();
            }
            else if (event.status >= 400)
            {
                this.serverError();
            }
            else if (event.status == 200)
            {
                this.retrieveUserData();
            }
            return;
        }// end function

        private function tickleServer(event:Event) : void
        {
            trace("ServerBridge : tickleServer");
            if (this._status == LOGGED)
            {
                this.retrieveUserData();
            }
            return;
        }// end function

        private function aggiungiNumberData(param1:NumberDataCache) : void
        {
            var _loc_2:* = new Array();
            var _loc_3:int = 0;
            while (_loc_3 < this._infocontoScaricati.length)
            {
                
                if (NumberDataCache(this._infocontoScaricati[_loc_3]).numero != param1.numero)
                {
                    _loc_2.push(this._infocontoScaricati[_loc_3]);
                }
                _loc_3++;
            }
            _loc_2.push(param1);
            this._infocontoScaricati = _loc_2;
            return;
        }// end function

        private function smsUsed() : Number
        {
            var _loc_5:Array = null;
            trace("ServerBridge : smsUsed");
            var _loc_1:* = LocalPreferences.getInstance().storageGet("sms_count");
            if (_loc_1 == null || _loc_1 == "")
            {
                return 0;
            }
            var _loc_2:* = _loc_1.split(";");
            var _loc_3:* = new Date();
            var _loc_4:int = 0;
            while (_loc_4 < _loc_2.length)
            {
                
                _loc_5 = String(_loc_2[_loc_4]).split("|");
                if (_loc_5[0] == this._currentMsisdn && _loc_5[2] == _loc_3.date.toString() + _loc_3.month.toString())
                {
                    return Number(_loc_5[1]);
                }
                _loc_4++;
            }
            return 0;
        }// end function

        private function setSmsCount(param1:int) : void
        {
            var _loc_5:Array = null;
            var _loc_6:int = 0;
            var _loc_7:Array = null;
            trace("ServerBridge : setSmsCount");
            var _loc_2:String = "";
            var _loc_3:* = new Date();
            var _loc_4:* = LocalPreferences.getInstance().storageGet("sms_count");
            if (LocalPreferences.getInstance().storageGet("sms_count") != null && _loc_4 != "")
            {
                _loc_5 = _loc_4.split(";");
                _loc_6 = 0;
                while (_loc_6 < _loc_5.length)
                {
                    
                    _loc_7 = String(_loc_5[_loc_6]).split("|");
                    if (_loc_7[0] != this._currentMsisdn && _loc_7[2] == _loc_3.date.toString() + _loc_3.month.toString())
                    {
                        if (_loc_2 != "")
                        {
                            _loc_2 = _loc_2 + ";";
                        }
                        _loc_2 = _loc_2 + _loc_5[_loc_6];
                    }
                    _loc_6++;
                }
            }
            if (_loc_2 != "")
            {
                _loc_2 = _loc_2 + ";";
            }
            _loc_2 = _loc_2 + (this.currentMsisdn + "|" + param1.toString() + "|" + _loc_3.date.toString() + _loc_3.month.toString());
            LocalPreferences.getInstance().storageSet("sms_count", _loc_2);
            return;
        }// end function

        public function get tipoCredito() : int
        {
            var _loc_1:int = 0;
            while (_loc_1 < this._infocontoScaricati.length)
            {
                
                if (NumberDataCache(this._infocontoScaricati[_loc_1]).numero == this._currentMsisdn)
                {
                    return NumberDataCache(this._infocontoScaricati[_loc_1]).tipo;
                }
                _loc_1++;
            }
            return -1;
        }// end function

        private function omnioneCaricato(event:Event) : void
        {
            var _loc_6:String = null;
            trace("ServerBridge : omnioneCaricato");
            var _loc_2:* = URLLoader(event.target);
            var _loc_3:* = XML(_loc_2.data);
            var _loc_4:* = _loc_3.child("e");
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4.length())
            {
                
                if (_loc_4[_loc_5].attribute("n").length() > 0 && _loc_4[_loc_5].attribute("v").length() > 0)
                {
                    if (_loc_4[_loc_5].attribute("n")[0] == "SALDO_PUNTI")
                    {
                        _loc_6 = Crypter.decrypt(_loc_4[_loc_5].attribute("v")[0], this._sessione);
                        this.aggiungiSaldoPunti(new OmnioneCache(this._currentMsisdn, _loc_6));
                        Tracciamento.getInstance().tracciaEvento(Tracciamento.SALDO_PUNTI);
                        dispatchEvent(new Event(OMNIONE_LOADED));
                    }
                    else if (_loc_4[_loc_5].attribute("n")[0] == "ERROR_100")
                    {
                        this.sessionExpired();
                        return;
                    }
                }
                _loc_5++;
            }
            this.keepAliveReset();
            return;
        }// end function

        public function get currentMsisdn() : String
        {
            trace("ServerBridge : currentMsisdn");
            if (this._status != LOGGED)
            {
                return "";
            }
            return this._currentMsisdn;
        }// end function

        public function get hasMoreSms() : Boolean
        {
            if (this.smsUsed() >= this.smsThresold)
            {
                return false;
            }
            return true;
        }// end function

        public function precheckSMS() : void
        {
            trace("ServerBridge : precheckSMS");
            if (this._status != LOGGED)
            {
                return;
            }
            try
            {
                if (this.precheckLoader != null)
                {
                    this.precheckLoader.close();
                }
            }
            catch (e:Error)
            {
            }
            this.precheckLoader = new URLLoader();
            dttime = new Date();
            var richiesta:* = new URLRequest(RemotePreferences.getInstance().getValue("sms_precheck") + "&" + dttime.time);
            richiesta.cacheResponse = false;
            richiesta.useCache = false;
            richiesta.userAgent = RemotePreferences.getInstance().getValue("user_agent");
            richiesta.requestHeaders.push(new URLRequestHeader("Referer", "http://www.vodafone.it/"));
            this.precheckLoader = new URLLoader();
            this.precheckLoader.addEventListener(IOErrorEvent.IO_ERROR, this.smsSystemOffline);
            this.precheckLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.smsSystemOffline);
            this.precheckLoader.addEventListener(Event.COMPLETE, this.precheckReceived);
            this.precheckLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, this.smsHttpStatusHandler);
            this.precheckLoader.load(richiesta);
            return;
        }// end function

        public function get username() : String
        {
            return this._username;
        }// end function

        public function get oraCredito() : String
        {
            var _loc_1:int = 0;
            while (_loc_1 < this._infocontoScaricati.length)
            {
                
                if (NumberDataCache(this._infocontoScaricati[_loc_1]).numero == this._currentMsisdn)
                {
                    return NumberDataCache(this._infocontoScaricati[_loc_1]).oraAggiornamento;
                }
                _loc_1++;
            }
            return "";
        }// end function

        private function processError(param1:Number) : void
        {
            trace("ServerBridge : processError");
            switch(param1)
            {
                case 100:
                {
                    this.lastErrorMsg = "Il servizio non è al momento disponibile.";
                    dispatchEvent(new Event(SMS_ERROR));
                    break;
                }
                case 108:
                {
                    this.lastErrorMsg = "E\' stato raggiunto il numero massimo di SMS verso il numero destinatario.";
                    dispatchEvent(new Event(SMS_ERROR));
                    break;
                }
                case 109:
                {
                    this.lastErrorMsg = "Attenzione! Per proseguire, scrivi il testo del messaggio.";
                    dispatchEvent(new Event(SMS_ERROR));
                    break;
                }
                case 110:
                {
                    this.lastErrorMsg = "Hai superato il numero di caratteri disponibili.";
                    dispatchEvent(new Event(SMS_ERROR));
                    break;
                }
                case 111:
                {
                    this.lastErrorMsg = "Inserisci il numero di cellulare del destinatario.";
                    dispatchEvent(new Event(SMS_ERROR));
                    break;
                }
                case 112:
                {
                    this.lastErrorMsg = "Il numero di cellulare deve essere di nove o dieci cifre e contenere solo caratteri numerici.";
                    dispatchEvent(new Event(SMS_ERROR));
                    break;
                }
                case 113:
                {
                    this.lastErrorMsg = "Ti ricordiamo che puoi inviare SMS via Web solo a numeri di cellulare Vodafone.";
                    dispatchEvent(new Event(SMS_ERROR));
                    break;
                }
                case 114:
                {
                    this.lastErrorMsg = "Verifica il numero mittente";
                    dispatchEvent(new Event(SMS_ERROR));
                    break;
                }
                case 116:
                {
                    this.lastErrorMsg = "Verifica il codice inserito e invia il tuo SMS.";
                    dispatchEvent(new Event(SMS_ERROR));
                    break;
                }
                case 107:
                {
                    this.setSmsCount(this.smsThresold);
                    this.lastErrorMsg = "Hai raggiunto il numero massimo di SMS a tua disposizione oggi.";
                    dispatchEvent(new Event(SMS_NO_MORE_MSG));
                    break;
                }
                case 101:
                {
                    this.lastErrorMsg = "Il servizio non è al momento disponibile.";
                    dispatchEvent(new Event(SMS_FATAL_ERROR));
                    break;
                }
                case 103:
                {
                    this.lastErrorMsg = "Siamo spiacenti. Il tuo profilo di registrazione non è abilitato a questo servizio.";
                    dispatchEvent(new Event(SMS_FATAL_ERROR));
                    break;
                }
                case 104:
                {
                    this.lastErrorMsg = "Il servizio non è al momento disponibile.";
                    dispatchEvent(new Event(SMS_FATAL_ERROR));
                    break;
                }
                case 105:
                {
                    this.lastErrorMsg = "Il servizio non è al momento disponibile.";
                    dispatchEvent(new Event(SMS_FATAL_ERROR));
                    break;
                }
                case 106:
                {
                    this.lastErrorMsg = "Contenuto non disponibile.";
                    dispatchEvent(new Event(SMS_FATAL_ERROR));
                    break;
                }
                case 115:
                {
                    this.lastErrorMsg = "Attenzione! Errore SIM.";
                    dispatchEvent(new Event(SMS_FATAL_ERROR));
                    break;
                }
                case 117:
                {
                    this.lastErrorMsg = "Contenuto non disponibile.";
                    dispatchEvent(new Event(SMS_FATAL_ERROR));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function sessionExpiredClean(event:Event) : void
        {
            trace("ServerBridge  : sessionExpiredClean");
            this.login(this._username, this._password);
            return;
        }// end function

        private function smsSystemOffline(event:Event) : void
        {
            this.systemOffline(event);
            return;
        }// end function

        public function get lastSmsError() : String
        {
            return this.lastErrorMsg;
        }// end function

        private function httpLogoutStatusHandler(event:HTTPStatusEvent) : void
        {
            trace("ServerBridge : httpLogoutStatusHandler= " + event);
            this._status = UNLOGGED;
            dispatchEvent(new Event(LOGGED_OUT));
            return;
        }// end function

        private function keepAliveReset() : void
        {
            trace("ServerBridge : keepAliveReset");
            this.keepAliveTimer.reset();
            this.keepAliveTimer.start();
            return;
        }// end function

        private function switchResponseLogin(event:Event) : void
        {
            trace("ServerBridge : switchResponseLogin = " + event);
            var _loc_2:* = new Date();
            var _loc_3:* = new URLRequest(RemotePreferences.getInstance().getValue("swap_url_portal") + "?" + _loc_2.time);
            _loc_3.cacheResponse = false;
            _loc_3.useCache = false;
            _loc_3.userAgent = RemotePreferences.getInstance().getValue("user_agent");
            _loc_3.requestHeaders.push(new URLRequestHeader("Referer", "http://www.vodafone.it/"));
            var _loc_4:* = new URLVariables();
            new URLVariables().ty_sim = this._currentMsisdn;
            _loc_4.swap_sim_link = this._currentMsisdn;
            _loc_3.data = _loc_4;
            _loc_3.method = URLRequestMethod.POST;
            this.switchLoader = new URLLoader();
            this.switchLoader.addEventListener(Event.COMPLETE, this.switchResponseChangeSim);
            this.switchLoader.addEventListener(IOErrorEvent.IO_ERROR, this.systemOffline);
            this.switchLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.systemOffline);
            this.switchLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, this.switchHttpStatusHandler);
            this.switchLoader.load(_loc_3);
            return;
        }// end function

        private function switchResponseChangeSim(event:Event) : void
        {
            trace("ServerBridge : switchResponseChangeSim = " + event);
            var _loc_2:* = new Date().getTime();
            this._token = MD5.hash(this._username + _loc_2);
            var _loc_3:* = new URLRequest(RemotePreferences.getInstance().getValue("userdata_url_portal") + "?token=" + this._token);
            _loc_3.cacheResponse = false;
            _loc_3.useCache = false;
            _loc_3.userAgent = RemotePreferences.getInstance().getValue("user_agent");
            _loc_3.requestHeaders.push(new URLRequestHeader("Referer", "http://www.vodafone.it/"));
            this.switchLoader = new URLLoader();
            this.switchLoader.addEventListener(Event.COMPLETE, this.switchResponseUserdata);
            this.switchLoader.addEventListener(IOErrorEvent.IO_ERROR, this.systemOffline);
            this.switchLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.systemOffline);
            this.switchLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, this.switchHttpStatusHandler);
            this.switchLoader.load(_loc_3);
            return;
        }// end function

        private function smsHttpStatusHandler(event:HTTPStatusEvent) : void
        {
            trace("ServerBridge : smsHttpStatusHandler = " + event);
            if (event.status >= 400)
            {
                this.lastErrorMsg = "Servizio momentaneamente non disponibile";
                this.lastError = 999;
                dispatchEvent(new Event(SMS_FATAL_ERROR));
            }
            return;
        }// end function

        private function aggiungiSaldoPunti(param1:OmnioneCache) : void
        {
            trace("ServerBridge : aggiungiSaldoPunti");
            var _loc_2:* = new Array();
            var _loc_3:int = 0;
            while (_loc_3 < this._saldiPunti.length)
            {
                
                if (OmnioneCache(this._saldiPunti[_loc_3]).numero != param1.numero)
                {
                    _loc_2.push(this._saldiPunti[_loc_3]);
                }
                _loc_3++;
            }
            _loc_2.push(param1);
            this._saldiPunti = _loc_2;
            return;
        }// end function

        private function simVodafoneOne(param1:String) : Boolean
        {
            trace("ServerBridge : simVodafoneOne");
            return this.vodafoneOneList.indexOf(param1) >= 0;
        }// end function

        private function httpLogoutNosimStatusHandler(event:HTTPStatusEvent) : void
        {
            trace("ServerBridge : httpLogoutNosimStatusHandler = " + event);
            this._status = UNLOGGED;
            dispatchEvent(new Event(NO_SIM_ERROR));
            return;
        }// end function

        private function addSmsCount(param1:int) : void
        {
            trace("ServerBridge : addSmsCount");
            var _loc_2:* = param1 + this.smsUsed();
            this.setSmsCount(_loc_2);
            if (_loc_2 >= this.smsThresold)
            {
                this.precheckSMS();
            }
            return;
        }// end function

        public static function getServerBridgeInstance() : ServerBridge
        {
            if (selfInstance == null)
            {
                selfInstance = new ServerBridge;
            }
            return selfInstance;
        }// end function

    }
}
