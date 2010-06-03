package it.vodafone
{
    import flash.desktop.*;
    import flash.events.*;
    import flash.net.*;

    public class SharedLoginServer extends EventDispatcher
    {
        private var started:Boolean = false;
        private var _password:String;
        private var _conn:LocalConnection;
        private var _username:String;
        private var outconn:LocalConnection;
        private static var allowedAddresses:String = "it.vodafone.counterswidget";

        public function SharedLoginServer()
        {
            this.outconn = new LocalConnection();
            this.outconn.addEventListener(StatusEvent.STATUS, this.onStatus);
            super(null);
            return;
        }// end function

        public function startWithCredentials(param1:String, param2:String) : void
        {
            var username:* = param1;
            var password:* = param2;
            this._username = username;
            this._password = password;
            this._conn = new LocalConnection();
            this._conn.allowDomain("app#" + allowedAddresses + "." + NativeApplication.nativeApplication.publisherID);
            this._conn.client = this;
            try
            {
                this._conn.connect("loginServer");
                this.started = true;
            }
            catch (error:ArgumentError)
            {
                trace("Can\'t connect...the connection name is already being used by another SWF");
            }
            return;
        }// end function

        public function stop() : void
        {
            if (!this.started)
            {
                return;
            }
            try
            {
                this._conn.close();
            }
            catch (e:Error)
            {
            }
            this._username = null;
            this._password = null;
            return;
        }// end function

        private function onStatus(event:StatusEvent) : void
        {
            switch(event.level)
            {
                case "status":
                {
                    break;
                }
                case "error":
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function transferData(param1:String) : void
        {
            var remoteParty:* = param1;
            remoteParty = remoteParty + ("." + NativeApplication.nativeApplication.publisherID);
            try
            {
                this.outconn.send("app#" + remoteParty + ":loginClient", "startLogin", this._username, this._password);
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

    }
}
