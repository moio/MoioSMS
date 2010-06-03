package air.update.ui
{
    import air.update.logging.*;
    import flash.desktop.*;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import flash.utils.*;

    public class EmbeddedUILoader extends EventDispatcher
    {
        private var loader:Loader;
        private var _initialized:Boolean;
        private var uiPath:String;
        private var DialogBytes:Class;
        private var uiWindow:NativeWindow;
        private var appUpdater:UpdaterUI;
        private var isExiting:Boolean;
        private var applicationDialogs:Object;
        private static var logger:Logger = Logger.getLogger("air.update.ui.EmbeddedUILoader");

        public function EmbeddedUILoader()
        {
            DialogBytes = EmbeddedUILoader_DialogBytes;
            watchOpenedWindows();
            NativeApplication.nativeApplication.addEventListener(Event.EXITING, onExiting, false, int.MAX_VALUE);
            return;
        }// end function

        public function addResources(param1:String, param2:Object) : void
        {
            if (applicationDialogs != null)
            {
                applicationDialogs.addResources(param1, param2);
            }
            return;
        }// end function

        public function setLocaleChain(param1:Array) : void
        {
            if (applicationDialogs != null)
            {
                applicationDialogs.setLocaleChain(param1);
            }
            return;
        }// end function

        private function onWindowClose(event:Event) : void
        {
            if (uiWindow != null && !uiWindow.closed && NativeApplication.nativeApplication.openedWindows.length == 1)
            {
                logger.fine("UpdateUI is last window standing. Action: Close & Exit");
                onExiting(event);
            }
            else
            {
                watchOpenedWindows();
            }
            return;
        }// end function

        private function watchOpenedWindows() : void
        {
            var _loc_2:NativeWindow = null;
            logger.fine("Check opened windows");
            var _loc_1:uint = 0;
            while (_loc_1++ < NativeApplication.nativeApplication.openedWindows.length)
            {
                
                _loc_2 = NativeApplication.nativeApplication.openedWindows[_loc_1];
                logger.fine("Opened window [" + _loc_1 + "] " + (_loc_2.title ? (_loc_2.title) : ("-- no title --")));
                if (_loc_2 == uiWindow)
                {
                    continue;
                }
                _loc_2.removeEventListener(Event.CLOSE, onWindowClose);
                if (!_loc_2.closed)
                {
                    _loc_2.addEventListener(Event.CLOSE, onWindowClose);
                }
            }
            return;
        }// end function

        public function showWindow() : void
        {
            if (uiWindow != null)
            {
                logger.fine("window already created");
                return;
            }
            isExiting = false;
            logger.fine("Creating UI window");
            var screenX:* = Capabilities.screenResolutionX;
            var screenY:* = Capabilities.screenResolutionY;
            var options:* = new NativeWindowInitOptions();
            options.resizable = false;
            options.maximizable = false;
            uiWindow = new NativeWindow(options);
            uiWindow.addEventListener(Event.CLOSING, function (event:Event) : void
            {
                logger.fine("Closing UI window." + (isExiting ? (" Exiting") : (" Not exiting, just hide")));
                if (!isExiting)
                {
                    event.preventDefault();
                }
                else
                {
                    uiWindow = null;
                }
                if (appUpdater.currentState != "PENDING_INSTALLING")
                {
                    appUpdater.cancelUpdate();
                }
                return;
            }// end function
            );
            uiWindow.visible = false;
            uiWindow.width = 1024;
            uiWindow.height = 800;
            uiWindow.x = (screenX - 530) / 2;
            uiWindow.y = (screenY - 230) / 2;
            uiWindow.stage.align = StageAlign.TOP_LEFT;
            uiWindow.stage.scaleMode = StageScaleMode.NO_SCALE;
            uiWindow.stage.addChild(loader);
            return;
        }// end function

        private function onUILoadError(event:Event) : void
        {
            logger.severe("SWF Loading complete");
            dispatchEvent(event);
            return;
        }// end function

        public function getLocaleChain() : Array
        {
            if (applicationDialogs == null)
            {
                return [];
            }
            return applicationDialogs.getLocaleChain();
        }// end function

        private function removeCloseListeners() : void
        {
            var _loc_2:NativeWindow = null;
            var _loc_1:uint = 0;
            while (_loc_1++ < NativeApplication.nativeApplication.openedWindows.length)
            {
                
                _loc_2 = NativeApplication.nativeApplication.openedWindows[_loc_1];
                _loc_2.removeEventListener(Event.CLOSE, onWindowClose);
            }
            return;
        }// end function

        public function get initialized() : Boolean
        {
            return _initialized;
        }// end function

        public function hideWindow() : void
        {
            logger.fine("Hide window");
            if (uiWindow != null)
            {
                uiWindow.visible = false;
            }
            return;
        }// end function

        private function onExiting(event:Event) : void
        {
            logger.fine("Exiting: " + uiWindow);
            isExiting = true;
            if (uiWindow != null && !uiWindow.closed)
            {
                if (this.appUpdater.currentState != "PENDING_INSTALLING")
                {
                    this.appUpdater.cancelUpdate();
                }
                uiWindow.close();
                uiWindow = null;
            }
            return;
        }// end function

        private function onUILoadInit(event:Event) : void
        {
            logger.fine("SWF Loading complete. Waiting for ApplicationComplete");
            loader.content.addEventListener("applicationComplete", onUIApplicationComplete);
            return;
        }// end function

        public function load() : void
        {
            if (loader != null)
            {
                return;
            }
            loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.INIT, onUILoadInit);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onUILoadError);
            var _loc_1:* = new DialogBytes() as ByteArray;
            if (_loc_1.length == 0)
            {
                dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
                return;
            }
            var _loc_2:* = new LoaderContext(false, ApplicationDomain.currentDomain);
            _loc_2.allowLoadBytesCodeExecution = true;
            showWindow();
            loader.loadBytes(_loc_1, _loc_2);
            return;
        }// end function

        public function set applicationUpdater(param1:UpdaterUI) : void
        {
            appUpdater = param1;
            return;
        }// end function

        private function onUIApplicationComplete(event:Event) : void
        {
            logger.fine("Application loading complete.");
            applicationDialogs = (event.target as Object).application;
            applicationDialogs.setApplicationUpdater(appUpdater);
            _initialized = true;
            dispatchEvent(new Event(Event.COMPLETE));
            return;
        }// end function

        public function unload() : void
        {
            logger.fine("unload " + uiWindow);
            appUpdater.cancelUpdate();
            applicationDialogs.setApplicationUpdater(null);
            if (uiWindow != null && !uiWindow.closed)
            {
                uiWindow.close();
                uiWindow = null;
            }
            return;
        }// end function

    }
}
