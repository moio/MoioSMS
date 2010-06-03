package it.vodafone
{
    import flash.desktop.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class SharedLoginClient extends EventDispatcher
    {
        private var outconn:LocalConnection;
        private var inconn:LocalConnection;
        public var username:String;
        private var pingTimer:Timer;
        public var password:String;
        private static var server:String = "it.vodafone.counterswidget";
        public static var START_LOGIN:String = "start_login";

        public function SharedLoginClient()
        {
            this.pingTimer = new Timer(5000, 0);
            this.pingTimer.addEventListener(TimerEvent.TIMER, this.trySend);
            this.outconn = new LocalConnection();
            this.outconn.addEventListener(StatusEvent.STATUS, this.onStatus);
            super(null);
            return;
        }// end function

        private function onStatus(event:StatusEvent) : void
        {
            switch(event.level)
            {
                case "status":
                {
                    trace("LocalConnection.send() succeeded");
                    break;
                }
                case "error":
                {
                    trace("LocalConnection.send() failed" + event.toString());
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function trySend(event:TimerEvent) : void
        {
            var te:* = event;
            var radd:* = "app#" + server + "." + NativeApplication.nativeApplication.publisherID + ":" + "loginServer";
            try
            {
                this.outconn.send(radd, "transferData", NativeApplication.nativeApplication.applicationID);
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        public function startLogin(param1:String, param2:String) : void
        {
            this.stopSearching();
            this.username = param1;
            this.password = param2;
            dispatchEvent(new Event(START_LOGIN));
            return;
        }// end function

        public function startSearching() : void
        {
            this.pingTimer.start();
            this.inconn = new LocalConnection();
            this.inconn.allowDomain("*");
            this.inconn.client = this;
            try
            {
                this.inconn.connect("loginClient");
            }
            catch (error:ArgumentError)
            {
                trace("Can\'t connect...the connection name is already being used by another SWF");
            }
            this.trySend(null);
            return;
        }// end function

        public function stopSearching() : void
        {
            this.pingTimer.stop();
            try
            {
                this.inconn.close();
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

    }
}
