package air.update
{
    import air.update.core.*;
    import air.update.events.*;
    import air.update.logging.*;
    import air.update.states.*;
    import air.update.utils.*;
    import flash.desktop.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.utils.*;

    public class ApplicationUpdater extends HSM
    {
        protected var state:UpdaterState;
        private var _isFirstRun:Boolean = false;
        private var _previousVersion:String = "";
        private var _wasPendingUpdate:Boolean = false;
        private var installFile:File = null;
        protected var updaterHSM:UpdaterHSM;
        private var _previousStorage:File = null;
        private var isInitialized:Boolean = false;
        private var timer:Timer;
        protected var configuration:UpdaterConfiguration;
        private static var logger:Logger = Logger.getLogger("air.update.ApplicationUpdater");
        private static const EVENT_CHECK_URL:String = "check.url";
        private static const EVENT_INITIALIZE:String = "initialize";
        private static const EVENT_CHECK_FILE:String = "check.file";

        public function ApplicationUpdater()
        {
            super(stateUninitialized);
            init();
            configuration = new UpdaterConfiguration();
            state = new UpdaterState();
            updaterHSM = new UpdaterHSM();
            updaterHSM.configuration = configuration;
            updaterHSM.addEventListener(UpdateEvent.CHECK_FOR_UPDATE, dispatch);
            updaterHSM.addEventListener(StatusUpdateEvent.UPDATE_STATUS, dispatch);
            updaterHSM.addEventListener(UpdateEvent.DOWNLOAD_START, dispatch);
            updaterHSM.addEventListener(ProgressEvent.PROGRESS, dispatch);
            updaterHSM.addEventListener(UpdateEvent.DOWNLOAD_COMPLETE, dispatch);
            updaterHSM.addEventListener(UpdateEvent.BEFORE_INSTALL, dispatch);
            updaterHSM.addEventListener(StatusUpdateErrorEvent.UPDATE_ERROR, dispatch);
            updaterHSM.addEventListener(DownloadErrorEvent.DOWNLOAD_ERROR, dispatch);
            updaterHSM.addEventListener(UpdaterHSM.EVENT_INSTALL_TRIGGER, dispatch);
            updaterHSM.addEventListener(UpdaterHSM.EVENT_FILE_INSTALL_TRIGGER, dispatch);
            updaterHSM.addEventListener(UpdaterHSM.EVENT_STATE_CLEAR_TRIGGER, onStateClear);
            updaterHSM.addEventListener(ErrorEvent.ERROR, dispatch);
            updaterHSM.addEventListener(StatusFileUpdateEvent.FILE_UPDATE_STATUS, dispatch);
            updaterHSM.addEventListener(StatusFileUpdateErrorEvent.FILE_UPDATE_ERROR, dispatch);
            timer = new Timer(0);
            timer.addEventListener(TimerEvent.TIMER, onTimer);
            return;
        }// end function

        public function get delay() : Number
        {
            return configuration.delay;
        }// end function

        public function get isFirstRun() : Boolean
        {
            return _isFirstRun;
        }// end function

        public function set delay(param1:Number) : void
        {
            configuration.delay = param1;
            if (isInitialized)
            {
                handlePeriodicalCheck();
            }
            return;
        }// end function

        protected function stateUninitialized(event:Event) : void
        {
            logger.finest("stateUninitialized: " + event.type);
            switch(event.type)
            {
                case HSMEvent.ENTER:
                {
                    isInitialized = false;
                    break;
                }
                case EVENT_INITIALIZE:
                {
                    transition(stateInitializing);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function get isNewerVersionFunction() : Function
        {
            return configuration.isNewerVersionFunction;
        }// end function

        public function initialize() : void
        {
            dispatch(new Event(EVENT_INITIALIZE));
            return;
        }// end function

        protected function stateReady(event:Event) : void
        {
            logger.finest("stateReady: " + event.type);
            switch(event.type)
            {
                case HSMEvent.ENTER:
                {
                    break;
                }
                case EVENT_CHECK_URL:
                {
                    transition(stateRunning);
                    dispatch(event);
                    break;
                }
                case EVENT_CHECK_FILE:
                {
                    transition(stateRunning);
                    dispatch(event);
                    break;
                }
                case ErrorEvent.ERROR:
                {
                    dispatchEvent(event);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function set isNewerVersionFunction(param1:Function) : void
        {
            configuration.isNewerVersionFunction = param1;
            return;
        }// end function

        protected function handleFirstRun() : Boolean
        {
            var updateFile:File;
            var updater:Updater;
            var result:Boolean;
            if (!state.descriptor.currentVersion)
            {
                return true;
            }
            if (state.descriptor.updaterLaunched)
            {
                _wasPendingUpdate = true;
                if (state.descriptor.currentVersion == VersionUtils.getApplicationVersion())
                {
                    _isFirstRun = true;
                    _previousVersion = state.descriptor.previousVersion;
                    if (state.descriptor.storage.nativePath != File.applicationStorageDirectory.nativePath)
                    {
                        _previousStorage = state.descriptor.storage;
                    }
                    state.removeAllFailedUpdates();
                    state.resetUpdateData();
                    state.removePreviousStorageData(_previousStorage);
                    state.saveToStorage();
                }
                else if (state.descriptor.previousVersion == VersionUtils.getApplicationVersion())
                {
                    state.addFailedUpdate(state.descriptor.currentVersion);
                    state.resetUpdateData();
                    state.saveToStorage();
                }
                else
                {
                    _wasPendingUpdate = false;
                    state.removeAllFailedUpdates();
                    state.resetUpdateData();
                    state.saveToStorage();
                }
            }
            else if (state.descriptor.previousVersion == VersionUtils.getApplicationVersion())
            {
                updateFile = FileUtils.getLocalUpdateFile();
                if (!updateFile.exists)
                {
                    state.resetUpdateData();
                    return true;
                }
                try
                {
                    state.descriptor.updaterLaunched = true;
                    state.saveToStorage();
                    state.saveToDocuments();
                    updater = new Updater();
                    updater.update(updateFile, state.descriptor.currentVersion);
                    result;
                }
                catch (e:Error)
                {
                    logger.warning("The application cannot be updated when is launched from ADL." + e.message);
                    state.resetUpdateData();
                    state.saveToStorage();
                }
            }
            else if (state.descriptor.currentVersion == VersionUtils.getApplicationVersion())
            {
                state.removeAllFailedUpdates();
                state.resetUpdateData();
                state.saveToStorage();
            }
            else
            {
                state.removeAllFailedUpdates();
                state.resetUpdateData();
                state.saveToStorage();
            }
            return result;
        }// end function

        public function get currentVersion() : String
        {
            return VersionUtils.getApplicationVersion();
        }// end function

        protected function onFileInstall() : void
        {
            var updater:Updater;
            var updateFile:* = updaterHSM.airFile;
            if (!updateFile.exists)
            {
                logger.finest("Update file doesn\'t exist at update");
                state.resetUpdateData();
                state.saveToStorage();
                updaterHSM.cancel();
                throw new Error("Missing update file at install time", Constants.ERROR_APPLICATION_UPDATE_NO_FILE);
            }
            try
            {
                state.descriptor.updaterLaunched = true;
                state.saveToStorage();
                state.saveToDocuments();
                updater = new Updater();
                updater.update(updateFile, updaterHSM.applicationDescriptor.version);
            }
            catch (e:Error)
            {
                logger.warning("The application cannot be updated (file)." + e.message);
                state.resetUpdateData();
                state.saveToStorage();
                updaterHSM.cancel();
                throw new Error("Cannot update (from file)", Constants.ERROR_APPLICATION_UPDATE);
            }
            return;
        }// end function

        public function get configurationFile() : File
        {
            return configuration.configurationFile;
        }// end function

        protected function dispatchProxy(event:Event) : void
        {
            if (event.type != ProgressEvent.PROGRESS)
            {
                logger.info("Dispatching event ", event);
            }
            if (!dispatchEvent(event))
            {
                event.preventDefault();
            }
            return;
        }// end function

        protected function onTimer(event:TimerEvent) : void
        {
            var _loc_2:* = timer.currentCount == timer.repeatCount;
            handlePeriodicalCheck();
            if (_loc_2)
            {
                dispatch(new Event(EVENT_CHECK_URL));
            }
            return;
        }// end function

        public function get updateDescriptor() : XML
        {
            if (updaterHSM.descriptor)
            {
                return updaterHSM.descriptor.getXML();
            }
            return null;
        }// end function

        public function set configurationFile(param1:File) : void
        {
            configuration.configurationFile = param1;
            return;
        }// end function

        public function checkNow() : void
        {
            dispatch(new Event(EVENT_CHECK_URL));
            return;
        }// end function

        public function get currentState() : String
        {
            if (!isInitialized)
            {
                return UpdateState.getStateName(UpdateState.UNINITIALIZED);
            }
            return UpdateState.getStateName(updaterHSM.getUpdateState());
        }// end function

        public function get previousApplicationStorageDirectory() : File
        {
            return _previousStorage;
        }// end function

        protected function onInitializationComplete() : void
        {
            dispatch(new UpdateEvent(UpdateEvent.INITIALIZED));
            return;
        }// end function

        protected function onInstall() : void
        {
            var updater:Updater;
            var updateFile:* = FileUtils.getLocalUpdateFile();
            if (!updateFile.exists)
            {
                logger.finest("Update file doesn\'t exist at update");
                state.resetUpdateData();
                state.saveToStorage();
                updaterHSM.cancel();
                throw new Error("Missing update file  at install time", Constants.ERROR_APPLICATION_UPDATE_NO_FILE);
            }
            try
            {
                state.descriptor.updaterLaunched = true;
                state.saveToStorage();
                state.saveToDocuments();
                updater = new Updater();
                updater.update(updateFile, updaterHSM.descriptor.version);
            }
            catch (e:Error)
            {
                logger.warning("The application cannot be updated (url)." + e.message);
                state.resetUpdateData();
                state.saveToStorage();
                updaterHSM.cancel();
                throw new Error("Cannot update (from remote)", Constants.ERROR_APPLICATION_UPDATE);
            }
            return;
        }// end function

        protected function stateCancelled(event:Event) : void
        {
            logger.finest("stateCancelled: " + event.type);
            switch(event.type)
            {
                case HSMEvent.ENTER:
                {
                    updaterHSM.cancel();
                    transition(stateReady);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function installFromAIRFile(param1:File) : void
        {
            installFile = param1;
            dispatch(new Event(EVENT_CHECK_FILE));
            updaterHSM.installFile(param1);
            return;
        }// end function

        public function installUpdate() : void
        {
            dispatch(new Event(UpdaterHSM.EVENT_INSTALL));
            return;
        }// end function

        protected function onFileStatus(event:StatusFileUpdateEvent) : void
        {
            if (event.available)
            {
                state.descriptor.previousVersion = VersionUtils.getApplicationVersion();
                state.descriptor.currentVersion = event.version;
                state.descriptor.storage = File.applicationStorageDirectory;
                state.saveToStorage();
            }
            dispatchProxy(event);
            return;
        }// end function

        protected function onInitialize() : void
        {
            configuration.validate();
            state.load();
            if (handleFirstRun())
            {
                onInitializationComplete();
            }
            return;
        }// end function

        public function checkForUpdate() : void
        {
            dispatch(new Event(UpdaterHSM.EVENT_CHECK));
            return;
        }// end function

        public function set updateURL(param1:String) : void
        {
            configuration.updateURL = param1;
            return;
        }// end function

        public function get wasPendingUpdate() : Boolean
        {
            return _wasPendingUpdate;
        }// end function

        protected function handlePeriodicalCheck() : void
        {
            var _loc_2:Number = NaN;
            var _loc_3:Number = NaN;
            logger.finest("PeriodicalCheck: " + configuration.delay);
            if (configuration.delay == 0)
            {
                return;
            }
            timer.reset();
            timer.repeatCount = 1;
            var _loc_1:* = new Date().time - state.descriptor.lastCheckDate.time;
            logger.finest("Difference: " + _loc_1 + " > " + configuration.delayAsMilliseconds + "(" + state.descriptor.lastCheckDate + ")");
            if (_loc_1 > configuration.delayAsMilliseconds)
            {
                timer.delay = 1;
            }
            else
            {
                _loc_2 = configuration.delayAsMilliseconds - _loc_1;
                _loc_3 = Math.floor(_loc_2 / Constants.DAY_IN_MILLISECONDS) + 1;
                if (_loc_2 > Constants.DAY_IN_MILLISECONDS)
                {
                    _loc_2 = Constants.DAY_IN_MILLISECONDS;
                }
                timer.delay = _loc_2;
                timer.repeatCount = _loc_3;
            }
            timer.start();
            logger.finest("PeriodicalCheck: started with delay: " + timer.delay + " and count: " + timer.repeatCount);
            return;
        }// end function

        protected function onDownloadComplete(event:UpdateEvent) : void
        {
            state.descriptor.previousVersion = VersionUtils.getApplicationVersion();
            state.descriptor.currentVersion = updaterHSM.descriptor.version;
            state.descriptor.storage = File.applicationStorageDirectory;
            state.saveToStorage();
            dispatchProxy(event);
            return;
        }// end function

        public function get previousVersion() : String
        {
            return _previousVersion;
        }// end function

        public function cancelUpdate() : void
        {
            transition(stateCancelled);
            return;
        }// end function

        public function get updateURL() : String
        {
            return configuration.updateURL;
        }// end function

        public function downloadUpdate() : void
        {
            dispatch(new Event(UpdaterHSM.EVENT_DOWNLOAD));
            return;
        }// end function

        protected function stateRunning(event:Event) : void
        {
            logger.finest("stateRunning: " + event.type);
            switch(event.type)
            {
                case HSMEvent.ENTER:
                {
                    break;
                }
                case EVENT_CHECK_URL:
                {
                    state.descriptor.lastCheckDate = new Date();
                    state.saveToStorage();
                    handlePeriodicalCheck();
                    updaterHSM.checkAsync(configuration.updateURL);
                    break;
                }
                case EVENT_CHECK_FILE:
                {
                    updaterHSM.installFile(installFile);
                    break;
                }
                case UpdaterHSM.EVENT_CHECK:
                case UpdaterHSM.EVENT_DOWNLOAD:
                case UpdaterHSM.EVENT_INSTALL:
                {
                    updaterHSM.dispatch(event);
                    break;
                }
                case UpdateEvent.CHECK_FOR_UPDATE:
                case StatusUpdateEvent.UPDATE_STATUS:
                case UpdateEvent.DOWNLOAD_START:
                case ProgressEvent.PROGRESS:
                case UpdateEvent.BEFORE_INSTALL:
                {
                    dispatchProxy(event);
                    break;
                }
                case StatusUpdateErrorEvent.UPDATE_ERROR:
                case DownloadErrorEvent.DOWNLOAD_ERROR:
                case StatusFileUpdateErrorEvent.FILE_UPDATE_ERROR:
                case ErrorEvent.ERROR:
                {
                    dispatchProxy(event);
                    transition(stateReady);
                    break;
                }
                case StatusFileUpdateEvent.FILE_UPDATE_STATUS:
                {
                    onFileStatus(event as StatusFileUpdateEvent);
                    break;
                }
                case UpdateEvent.DOWNLOAD_COMPLETE:
                {
                    onDownloadComplete(event as UpdateEvent);
                    break;
                }
                case UpdaterHSM.EVENT_INSTALL_TRIGGER:
                {
                    onInstall();
                    break;
                }
                case UpdaterHSM.EVENT_FILE_INSTALL_TRIGGER:
                {
                    onFileInstall();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function onStateClear(event:Event) : void
        {
            state.resetUpdateData();
            state.saveToStorage();
            return;
        }// end function

        protected function stateInitializing(event:Event) : void
        {
            logger.finest("stateInitializing: " + event.type);
            switch(event.type)
            {
                case HSMEvent.ENTER:
                {
                    onInitialize();
                    break;
                }
                case UpdateEvent.INITIALIZED:
                {
                    isInitialized = true;
                    transition(stateReady);
                    dispatchEvent(event);
                    handlePeriodicalCheck();
                    break;
                }
                case ErrorEvent.ERROR:
                {
                    transition(stateUninitialized);
                    dispatchEvent(event.clone());
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
