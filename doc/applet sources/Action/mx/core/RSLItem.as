package mx.core
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import mx.events.*;
    import mx.utils.*;

    public class RSLItem extends Object
    {
        protected var chainedSecurityErrorHandler:Function;
        public var total:uint = 0;
        public var loaded:uint = 0;
        private var completed:Boolean = false;
        protected var chainedRSLErrorHandler:Function;
        protected var chainedIOErrorHandler:Function;
        protected var chainedCompleteHandler:Function;
        private var errorText:String;
        protected var chainedProgressHandler:Function;
        public var urlRequest:URLRequest;
        public var rootURL:String;
        protected var url:String;
        static const VERSION:String = "3.2.0.3958";

        public function RSLItem(param1:String, param2:String = null)
        {
            this.url = param1;
            this.rootURL = param2;
            return;
        }// end function

        public function itemProgressHandler(event:ProgressEvent) : void
        {
            loaded = event.bytesLoaded;
            total = event.bytesTotal;
            if (chainedProgressHandler != null)
            {
                chainedProgressHandler(event);
            }
            return;
        }// end function

        public function itemErrorHandler(event:ErrorEvent) : void
        {
            errorText = decodeURI(event.text);
            completed = true;
            loaded = 0;
            total = 0;
            trace(errorText);
            if (event.type == IOErrorEvent.IO_ERROR && chainedIOErrorHandler != null)
            {
                chainedIOErrorHandler(event);
            }
            else if (event.type == SecurityErrorEvent.SECURITY_ERROR && chainedSecurityErrorHandler != null)
            {
                chainedSecurityErrorHandler(event);
            }
            else if (event.type == RSLEvent.RSL_ERROR && chainedRSLErrorHandler != null)
            {
                chainedRSLErrorHandler(event);
            }
            return;
        }// end function

        public function load(param1:Function, param2:Function, param3:Function, param4:Function, param5:Function) : void
        {
            chainedProgressHandler = param1;
            chainedCompleteHandler = param2;
            chainedIOErrorHandler = param3;
            chainedSecurityErrorHandler = param4;
            chainedRSLErrorHandler = param5;
            var _loc_6:* = new Loader();
            var _loc_7:* = new LoaderContext();
            urlRequest = new URLRequest(LoaderUtil.createAbsoluteURL(rootURL, url));
            _loc_6.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, itemProgressHandler);
            _loc_6.contentLoaderInfo.addEventListener(Event.COMPLETE, itemCompleteHandler);
            _loc_6.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, itemErrorHandler);
            _loc_6.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, itemErrorHandler);
            _loc_7.applicationDomain = ApplicationDomain.currentDomain;
            _loc_6.load(urlRequest, _loc_7);
            return;
        }// end function

        public function itemCompleteHandler(event:Event) : void
        {
            completed = true;
            if (chainedCompleteHandler != null)
            {
                chainedCompleteHandler(event);
            }
            return;
        }// end function

    }
}
