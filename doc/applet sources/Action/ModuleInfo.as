package 
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    import mx.core.*;
    import mx.events.*;

    private class ModuleInfo extends EventDispatcher
    {
        private var _error:Boolean = false;
        private var loader:Loader;
        private var factoryInfo:FactoryInfo;
        private var limbo:Dictionary;
        private var _loaded:Boolean = false;
        private var _ready:Boolean = false;
        private var numReferences:int = 0;
        private var _url:String;
        private var _setup:Boolean = false;

        private function ModuleInfo(param1:String)
        {
            _url = param1;
            return;
        }// end function

        private function clearLoader() : void
        {
            if (loader)
            {
                if (loader.contentLoaderInfo)
                {
                    loader.contentLoaderInfo.removeEventListener(Event.INIT, initHandler);
                    loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
                    loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
                    loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
                    loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
                }
                try
                {
                    if (loader.content)
                    {
                        loader.content.removeEventListener("ready", readyHandler);
                        loader.content.removeEventListener("error", moduleErrorHandler);
                    }
                }
                catch (error:Error)
                {
                }
                if (_loaded)
                {
                    try
                    {
                        loader.close();
                    }
                    catch (error:Error)
                    {
                    }
                    try
                    {
                    }
                    loader.unload();
                }
                catch (error:Error)
                {
                }
                loader = null;
            }
            return;
        }// end function

        public function get size() : int
        {
            if (!limbo)
            {
            }
            return factoryInfo ? (factoryInfo.bytesTotal) : (0);
        }// end function

        public function get loaded() : Boolean
        {
            return !limbo ? (_loaded) : (false);
        }// end function

        public function release() : void
        {
            if (_ready && !limbo)
            {
                limbo = new Dictionary(true);
                limbo[factoryInfo] = 1;
                factoryInfo = null;
            }
            else
            {
                unload();
            }
            return;
        }// end function

        public function get error() : Boolean
        {
            return !limbo ? (_error) : (false);
        }// end function

        public function get factory() : IFlexModuleFactory
        {
            if (!limbo)
            {
            }
            return factoryInfo ? (factoryInfo.factory) : (null);
        }// end function

        public function completeHandler(event:Event) : void
        {
            var _loc_2:* = new ModuleEvent(ModuleEvent.PROGRESS, event.bubbles, event.cancelable);
            _loc_2.bytesLoaded = loader.contentLoaderInfo.bytesLoaded;
            _loc_2.bytesTotal = loader.contentLoaderInfo.bytesTotal;
            dispatchEvent(_loc_2);
            return;
        }// end function

        public function publish(param1:IFlexModuleFactory) : void
        {
            if (factoryInfo)
            {
                return;
            }
            if (_url.indexOf("published://") != 0)
            {
                return;
            }
            factoryInfo = new FactoryInfo();
            factoryInfo.factory = param1;
            _loaded = true;
            _setup = true;
            _ready = true;
            _error = false;
            dispatchEvent(new ModuleEvent(ModuleEvent.SETUP));
            dispatchEvent(new ModuleEvent(ModuleEvent.PROGRESS));
            dispatchEvent(new ModuleEvent(ModuleEvent.READY));
            return;
        }// end function

        public function initHandler(event:Event) : void
        {
            var moduleEvent:ModuleEvent;
            var event:* = event;
            factoryInfo = new FactoryInfo();
            try
            {
                factoryInfo.factory = loader.content as IFlexModuleFactory;
            }
            catch (error:Error)
            {
            }
            if (!factoryInfo.factory)
            {
                moduleEvent = new ModuleEvent(ModuleEvent.ERROR, event.bubbles, event.cancelable);
                moduleEvent.bytesLoaded = 0;
                moduleEvent.bytesTotal = 0;
                moduleEvent.errorText = "SWF is not a loadable module";
                dispatchEvent(moduleEvent);
                return;
            }
            loader.content.addEventListener("ready", readyHandler);
            loader.content.addEventListener("error", moduleErrorHandler);
            try
            {
                factoryInfo.applicationDomain = loader.contentLoaderInfo.applicationDomain;
            }
            catch (error:Error)
            {
            }
            _setup = true;
            dispatchEvent(new ModuleEvent(ModuleEvent.SETUP));
            return;
        }// end function

        public function resurrect() : void
        {
            var _loc_1:Object = null;
            if (!factoryInfo && limbo)
            {
                for (_loc_1 in limbo)
                {
                    
                    factoryInfo = _loc_1 as FactoryInfo;
                    break;
                }
                limbo = null;
            }
            if (!factoryInfo)
            {
                if (_loaded)
                {
                    dispatchEvent(new ModuleEvent(ModuleEvent.UNLOAD));
                }
                loader = null;
                _loaded = false;
                _setup = false;
                _ready = false;
                _error = false;
            }
            return;
        }// end function

        public function errorHandler(event:ErrorEvent) : void
        {
            _error = true;
            var _loc_2:* = new ModuleEvent(ModuleEvent.ERROR, event.bubbles, event.cancelable);
            _loc_2.bytesLoaded = 0;
            _loc_2.bytesTotal = 0;
            _loc_2.errorText = event.text;
            dispatchEvent(_loc_2);
            return;
        }// end function

        public function get ready() : Boolean
        {
            return !limbo ? (_ready) : (false);
        }// end function

        private function loadBytes(param1:ApplicationDomain, param2:ByteArray) : void
        {
            var _loc_3:* = new LoaderContext();
            _loc_3.applicationDomain = param1 ? (param1) : (new ApplicationDomain(ApplicationDomain.currentDomain));
            if ("allowLoadBytesCodeExecution" in _loc_3)
            {
                _loc_3["allowLoadBytesCodeExecution"] = true;
            }
            loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.INIT, initHandler);
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
            loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
            loader.loadBytes(param2, _loc_3);
            return;
        }// end function

        public function removeReference() : void
        {
            numReferences--;
            if (numReferences == 0)
            {
                release();
            }
            return;
        }// end function

        public function addReference() : void
        {
            numReferences++;
            return;
        }// end function

        public function progressHandler(event:ProgressEvent) : void
        {
            var _loc_2:* = new ModuleEvent(ModuleEvent.PROGRESS, event.bubbles, event.cancelable);
            _loc_2.bytesLoaded = event.bytesLoaded;
            _loc_2.bytesTotal = event.bytesTotal;
            dispatchEvent(_loc_2);
            return;
        }// end function

        public function load(param1:ApplicationDomain = null, param2:SecurityDomain = null, param3:ByteArray = null) : void
        {
            if (_loaded)
            {
                return;
            }
            _loaded = true;
            limbo = null;
            if (param3)
            {
                loadBytes(param1, param3);
                return;
            }
            if (_url.indexOf("published://") == 0)
            {
                return;
            }
            var _loc_4:* = new URLRequest(_url);
            var _loc_5:* = new LoaderContext();
            new LoaderContext().applicationDomain = param1 ? (param1) : (new ApplicationDomain(ApplicationDomain.currentDomain));
            _loc_5.securityDomain = param2;
            if (param2 == null && Security.sandboxType == Security.REMOTE)
            {
                _loc_5.securityDomain = SecurityDomain.currentDomain;
            }
            loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.INIT, initHandler);
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
            loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
            loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
            loader.load(_loc_4, _loc_5);
            return;
        }// end function

        public function get url() : String
        {
            return _url;
        }// end function

        public function get applicationDomain() : ApplicationDomain
        {
            if (!limbo)
            {
            }
            return factoryInfo ? (factoryInfo.applicationDomain) : (null);
        }// end function

        public function moduleErrorHandler(event:Event) : void
        {
            var _loc_2:ModuleEvent = null;
            _ready = true;
            factoryInfo.bytesTotal = loader.contentLoaderInfo.bytesTotal;
            clearLoader();
            if (event is ModuleEvent)
            {
                _loc_2 = ModuleEvent(event);
            }
            else
            {
                _loc_2 = new ModuleEvent(ModuleEvent.ERROR);
            }
            dispatchEvent(_loc_2);
            return;
        }// end function

        public function readyHandler(event:Event) : void
        {
            _ready = true;
            factoryInfo.bytesTotal = loader.contentLoaderInfo.bytesTotal;
            clearLoader();
            dispatchEvent(new ModuleEvent(ModuleEvent.READY));
            return;
        }// end function

        public function get setup() : Boolean
        {
            return !limbo ? (_setup) : (false);
        }// end function

        public function unload() : void
        {
            clearLoader();
            if (_loaded)
            {
                dispatchEvent(new ModuleEvent(ModuleEvent.UNLOAD));
            }
            limbo = null;
            factoryInfo = null;
            _loaded = false;
            _setup = false;
            _ready = false;
            _error = false;
            return;
        }// end function

    }
}
