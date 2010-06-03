package it.vodafone
{
    import flash.desktop.*;
    import flash.events.*;
    import flash.net.*;

    public class Tracciamento extends EventDispatcher
    {
        private var _sessionId:String;
        private var _username:String;
        private var _appVersion:String;
        private static var selfInstance:Tracciamento;
        public static var LOGIN_FALLITA:String = "failed_login";
        public static var SALDO_PUNTI:String = "vodafone_one";
        public static var LOGIN:String = "login_ok";
        public static var SMS_INVIATO:String = "sms_sent";
        public static var INFOCONTO:String = "infoconto";
        public static var CREDITO:String = "credito";

        public function Tracciamento()
        {
            var _loc_1:* = NativeApplication.nativeApplication.applicationDescriptor;
            var _loc_2:* = _loc_1.namespace();
            this._appVersion = _loc_2::version;
            return;
        }// end function

        public function set sessionId(param1:String) : void
        {
            this._sessionId = param1;
            return;
        }// end function

        private function generaRichiesta() : URLRequest
        {
            var _loc_1:* = new URLRequest(RemotePreferences.getInstance().getValue("log_url"));
            _loc_1.cacheResponse = false;
            _loc_1.method = URLRequestMethod.GET;
            _loc_1.useCache = false;
            _loc_1.userAgent = RemotePreferences.getInstance().getValue("user_agent");
            _loc_1.requestHeaders.push(new URLRequestHeader("Referer", "http://www.vodafone.it/"));
            return _loc_1;
        }// end function

        public function set username(param1:String) : void
        {
            this._username = param1;
            return;
        }// end function

        public function tracciaEvento(param1:String) : void
        {
            var _loc_2:* = this.generaRichiesta();
            var _loc_3:* = new URLVariables();
            _loc_3.username = this._username;
            _loc_3.op_name = param1;
            _loc_3.version = this._appVersion;
            _loc_3.sessionId = this._sessionId;
            _loc_2.data = _loc_3;
            var _loc_4:* = new URLLoader();
            new URLLoader().addEventListener(IOErrorEvent.IO_ERROR, this.catturaEvento);
            _loc_4.load(_loc_2);
            return;
        }// end function

        private function catturaEvento(event:Event) : void
        {
            return;
        }// end function

        public function tracciaSms(param1:String, param2:String) : void
        {
            var _loc_3:* = this.generaRichiesta();
            var _loc_4:* = new URLVariables();
            new URLVariables().username = this._username;
            _loc_4.op_name = SMS_INVIATO;
            _loc_4.msisdn_from = param1;
            _loc_4.msisdn_to = param2;
            _loc_3.data = _loc_4;
            var _loc_5:* = new URLLoader();
            new URLLoader().load(_loc_3);
            return;
        }// end function

        public static function getInstance() : Tracciamento
        {
            if (selfInstance == null)
            {
                selfInstance = new Tracciamento;
            }
            return selfInstance;
        }// end function

    }
}
