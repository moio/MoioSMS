package air.update.core
{
    import air.update.descriptors.*;
    import air.update.events.*;
    import air.update.logging.*;
    import air.update.net.*;
    import air.update.states.*;
    import air.update.utils.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.net.*;

    public class UpdaterHSM extends HSM
    {
        private var descriptorURL:URLRequest;
        private var unpackager:AIRUnpackager;
        private var descriptorFile:File;
        private var _descriptor:UpdateDescriptor;
        private var requestedFile:File;
        private var requestedURL:String;
        private var downloader:FileDownloader;
        private var updateFile:File;
        private var updateURL:URLRequest;
        private var _applicationDescriptor:ApplicationDescriptor;
        private var _configuration:UpdaterConfiguration;
        public static const EVENT_FILE:String = "check.file";
        public static const EVENT_CHECK:String = "updater.check";
        public static const EVENT_STATE_CLEAR_TRIGGER:String = "state_clear.trigger";
        public static const EVENT_DOWNLOAD:String = "updater.download";
        public static const EVENT_INSTALL_TRIGGER:String = "install.trigger";
        private static var logger:Logger = Logger.getLogger("air.update.core.UpdaterHSM");
        public static const EVENT_VERIFIED:String = "check.verified";
        public static const EVENT_INSTALL:String = "updater.install";
        public static const EVENT_ASYNC:String = "check.async";
        public static const EVENT_FILE_INSTALL_TRIGGER:String = "file_install.trigger";

        public function UpdaterHSM()
        {
            super(stateReady);
            return;
        }// end function

        protected function stateInitialized(event:Event) : void
        {
            logger.finest("stateInitialized: " + event.type);
            switch(event.type)
            {
                case HSMEvent.ENTER:
                {
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

        protected function stateDownloading(event:Event) : void
        {
            if (event.type != ProgressEvent.PROGRESS)
            {
                logger.finest("stateDownloading: " + event.type);
            }
            switch(event.type)
            {
                case HSMEvent.ENTER:
                {
                    downloader = new FileDownloader(updateURL, updateFile);
                    downloader.addEventListener(DownloadErrorEvent.DOWNLOAD_ERROR, dispatch);
                    downloader.addEventListener(UpdateEvent.DOWNLOAD_START, dispatch);
                    downloader.addEventListener(ProgressEvent.PROGRESS, dispatch);
                    downloader.addEventListener(UpdateEvent.DOWNLOAD_COMPLETE, dispatch);
                    downloader.download();
                    break;
                }
                case UpdateEvent.DOWNLOAD_START:
                {
                    dispatchEvent(event.clone());
                    break;
                }
                case ProgressEvent.PROGRESS:
                {
                    dispatchEvent(event.clone());
                    break;
                }
                case DownloadErrorEvent.DOWNLOAD_ERROR:
                {
                    dispatchEvent(event.clone());
                    transition(stateErrored);
                    break;
                }
                case UpdateEvent.DOWNLOAD_COMPLETE:
                {
                    downloader = null;
                    transition(stateDownloaded);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function getUpdateState() : int
        {
            var _loc_1:int = -1;
            switch(stateHSM)
            {
                case stateInitialized:
                {
                    _loc_1 = UpdateState.READY;
                    break;
                }
                case stateBeforeChecking:
                {
                    _loc_1 = UpdateState.BEFORE_CHECKING;
                    break;
                }
                case stateChecking:
                {
                    _loc_1 = UpdateState.CHECKING;
                    break;
                }
                case stateAvailable:
                case stateAvailableFile:
                {
                    _loc_1 = UpdateState.AVAILABLE;
                    break;
                }
                case stateDownloading:
                {
                    _loc_1 = UpdateState.DOWNLOADING;
                    break;
                }
                case stateDownloaded:
                {
                    _loc_1 = UpdateState.DOWNLOADED;
                    break;
                }
                case stateInstalling:
                {
                    _loc_1 = UpdateState.INSTALLING;
                    break;
                }
                case statePendingInstall:
                {
                    _loc_1 = UpdateState.PENDING_INSTALLING;
                    break;
                }
                case stateReady:
                {
                    _loc_1 = UpdateState.READY;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_1;
        }// end function

        private function fileUnpackaged() : void
        {
            var xml:XML;
            logger.finer("Parsing file descriptor");
            try
            {
                xml = unpackager.descriptorXML;
                _applicationDescriptor = new ApplicationDescriptor(xml);
                _applicationDescriptor.validate();
                if (VersionUtils.getApplicationID() != _applicationDescriptor.id)
                {
                    throw new Error("Different applicationID", Constants.ERROR_DIFFERENT_APPLICATION_ID);
                }
                if (!isNewerVersion(VersionUtils.getApplicationVersion(), _applicationDescriptor.version))
                {
                    dispatchEvent(new StatusFileUpdateEvent(StatusFileUpdateEvent.FILE_UPDATE_STATUS, false, false, false, _applicationDescriptor.version, requestedFile.nativePath));
                    transition(stateReady);
                    return;
                }
                transition(stateAvailableFile);
            }
            catch (e:Error)
            {
                logger.fine("Error validating file descriptor: " + e);
                dispatchEvent(new StatusFileUpdateErrorEvent(StatusFileUpdateErrorEvent.FILE_UPDATE_ERROR, false, false, e.message, e.errorID));
                transition(stateErrored);
            }
            return;
        }// end function

        private function isNewerVersion(param1:String, param2:String) : Boolean
        {
            if (configuration)
            {
                return configuration.isNewerVersionFunction(param1, param2);
            }
            return VersionUtils.isNewerVersion(param1, param2);
        }// end function

        protected function stateDownloaded(event:Event) : void
        {
            var descriptor:ApplicationDescriptor;
            var event:* = event;
            logger.finest("stateDownloaded: " + event.type);
            switch(event.type)
            {
                case HSMEvent.ENTER:
                {
                    unpackager = new AIRUnpackager();
                    unpackager.addEventListener(Event.COMPLETE, dispatch);
                    unpackager.addEventListener(ErrorEvent.ERROR, dispatch);
                    unpackager.addEventListener(IOErrorEvent.IO_ERROR, dispatch);
                    unpackager.unpackageAsync(updateFile.url);
                    break;
                }
                case ErrorEvent.ERROR:
                case IOErrorEvent.IO_ERROR:
                {
                    unpackager.cancel();
                    unpackager = null;
                    dispatchEvent(new DownloadErrorEvent(DownloadErrorEvent.DOWNLOAD_ERROR, false, false, "", Constants.ERROR_AIR_UNPACKAGING, ErrorEvent(event).errorID));
                    transition(stateErrored);
                    break;
                }
                case Event.COMPLETE:
                {
                    unpackager.cancel();
                    descriptor = new ApplicationDescriptor(unpackager.descriptorXML);
                    try
                    {
                        descriptor.validate();
                    }
                    catch (e:Error)
                    {
                        unpackager = null;
                        dispatchEvent(new DownloadErrorEvent(DownloadErrorEvent.DOWNLOAD_ERROR, false, false, "", Constants.ERROR_VALIDATE, e.errorID));
                        transition(stateErrored);
                        return;
                    }
                    if (descriptor.id != VersionUtils.getApplicationID())
                    {
                        dispatchEvent(new DownloadErrorEvent(DownloadErrorEvent.DOWNLOAD_ERROR, false, false, "Different applicationID", Constants.ERROR_VALIDATE, Constants.ERROR_DIFFERENT_APPLICATION_ID));
                        transition(stateErrored);
                        return;
                    }
                    if (_descriptor.version != descriptor.version)
                    {
                        dispatchEvent(new DownloadErrorEvent(DownloadErrorEvent.DOWNLOAD_ERROR, false, false, "Version mismatch", Constants.ERROR_VALIDATE, Constants.ERROR_VERSION_MISMATCH));
                        transition(stateErrored);
                        return;
                    }
                    if (!isNewerVersion(VersionUtils.getApplicationVersion(), descriptor.version))
                    {
                        dispatchEvent(new DownloadErrorEvent(DownloadErrorEvent.DOWNLOAD_ERROR, false, false, "Not a newer version", Constants.ERROR_VALIDATE, Constants.ERROR_NOT_NEW_VERSION));
                        transition(stateErrored);
                        return;
                    }
                    dispatch(new Event(EVENT_VERIFIED));
                    break;
                }
                case EVENT_VERIFIED:
                {
                    if (dispatchEvent(new UpdateEvent(UpdateEvent.DOWNLOAD_COMPLETE, false, true)))
                    {
                        transition(stateInstalling);
                        return;
                    }
                    break;
                }
                case EVENT_INSTALL:
                {
                    transition(stateInstalling);
                    break;
                }
                default:
                {
                    break;
                }
            }
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
                case EVENT_ASYNC:
                {
                    updateURL = new URLRequest(requestedURL);
                    updateFile = FileUtils.getLocalDescriptorFile();
                    transitionAsync(stateBeforeChecking);
                    break;
                }
                case EVENT_FILE:
                {
                    transitionAsync(stateUnpackaging);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function stateChecking(event:Event) : void
        {
            logger.finest("stateChecking: " + event.type);
            switch(event.type)
            {
                case HSMEvent.ENTER:
                {
                    downloader = new FileDownloader(updateURL, updateFile);
                    downloader.addEventListener(DownloadErrorEvent.DOWNLOAD_ERROR, dispatch);
                    downloader.addEventListener(ProgressEvent.PROGRESS, dispatch);
                    downloader.addEventListener(UpdateEvent.DOWNLOAD_COMPLETE, dispatch);
                    downloader.download();
                    break;
                }
                case UpdateEvent.DOWNLOAD_START:
                {
                    break;
                }
                case ProgressEvent.PROGRESS:
                {
                    break;
                }
                case DownloadErrorEvent.DOWNLOAD_ERROR:
                {
                    dispatchEvent(new StatusUpdateErrorEvent(StatusUpdateErrorEvent.UPDATE_ERROR, false, false, DownloadErrorEvent(event).text, DownloadErrorEvent(event).errorID, DownloadErrorEvent(event).subErrorID));
                    transition(stateErrored);
                    break;
                }
                case UpdateEvent.DOWNLOAD_COMPLETE:
                {
                    downloader = null;
                    descriptorDownloaded();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function startTimer(param1:Number = -1) : void
        {
            return;
        }// end function

        public function installFile(param1:File) : void
        {
            requestedFile = param1;
            dispatch(new Event(EVENT_FILE));
            return;
        }// end function

        protected function stateAvailable(event:Event) : void
        {
            logger.finest("stateAvailable: " + event.type);
            switch(event.type)
            {
                case HSMEvent.ENTER:
                {
                    if (dispatchEvent(new StatusUpdateEvent(StatusUpdateEvent.UPDATE_STATUS, false, true, true, descriptor.version, descriptor.description)))
                    {
                        transition(stateDownloading);
                        return;
                    }
                    break;
                }
                case EVENT_DOWNLOAD:
                {
                    transition(stateDownloading);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function stateUnpackaging(event:Event) : void
        {
            logger.finest("stateUnpackaging: " + event.type);
            switch(event.type)
            {
                case HSMEvent.ENTER:
                {
                    unpackager = new AIRUnpackager();
                    unpackager.addEventListener(Event.COMPLETE, dispatch);
                    unpackager.addEventListener(ErrorEvent.ERROR, dispatch);
                    unpackager.addEventListener(IOErrorEvent.IO_ERROR, dispatch);
                    unpackager.unpackageAsync(requestedFile.url);
                    break;
                }
                case Event.COMPLETE:
                {
                    unpackager.cancel();
                    fileUnpackaged();
                    unpackager = null;
                    break;
                }
                case ErrorEvent.ERROR:
                case IOErrorEvent.IO_ERROR:
                {
                    unpackager.cancel();
                    unpackager = null;
                    dispatchEvent(new StatusFileUpdateErrorEvent(StatusFileUpdateErrorEvent.FILE_UPDATE_ERROR, false, false, "", ErrorEvent(event).errorID));
                    transition(stateErrored);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function installUpdate() : void
        {
            logger.finest("Installing update");
            dispatchEvent(new Event(EVENT_INSTALL_TRIGGER));
            return;
        }// end function

        protected function stateCancelled(event:Event) : void
        {
            logger.finest("stateCancelled: " + event.type);
            switch(event.type)
            {
                case HSMEvent.ENTER:
                {
                    dispatchEvent(new Event(EVENT_STATE_CLEAR_TRIGGER));
                    if (downloader)
                    {
                        downloader.cancel();
                        downloader = null;
                    }
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

        public function checkAsync(param1:String) : void
        {
            requestedURL = param1;
            dispatch(new Event(EVENT_ASYNC));
            return;
        }// end function

        protected function stateErrored(event:Event) : void
        {
            logger.finest("stateErrored: " + event.type);
            switch(event.type)
            {
                case HSMEvent.ENTER:
                {
                    dispatchEvent(new Event(EVENT_STATE_CLEAR_TRIGGER));
                    if (downloader)
                    {
                        downloader.cancel();
                        downloader = null;
                    }
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

        protected function stateInstalling(event:Event) : void
        {
            logger.finest("stateInstalling: " + event.type);
            switch(event.type)
            {
                case HSMEvent.ENTER:
                {
                    if (!dispatchEvent(new UpdateEvent(UpdateEvent.BEFORE_INSTALL, false, true)))
                    {
                        transition(statePendingInstall);
                        return;
                    }
                    installUpdate();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function stateAvailableFile(event:Event) : void
        {
            logger.finest("stateAvailableFile: " + event.type + " file: " + requestedFile.url);
            switch(event.type)
            {
                case HSMEvent.ENTER:
                {
                    if (dispatchEvent(new StatusFileUpdateEvent(StatusFileUpdateEvent.FILE_UPDATE_STATUS, false, true, true, _applicationDescriptor.version, requestedFile.nativePath)))
                    {
                        transition(stateInstallingFile);
                        return;
                    }
                    break;
                }
                case EVENT_INSTALL:
                {
                    transition(stateInstallingFile);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function get applicationDescriptor() : ApplicationDescriptor
        {
            return _applicationDescriptor;
        }// end function

        private function installFileUpdate() : void
        {
            logger.finest("Installing file update");
            dispatchEvent(new Event(EVENT_FILE_INSTALL_TRIGGER));
            return;
        }// end function

        public function set configuration(param1:UpdaterConfiguration) : void
        {
            _configuration = param1;
            return;
        }// end function

        public function get airFile() : File
        {
            return requestedFile;
        }// end function

        public function get descriptor() : UpdateDescriptor
        {
            return _descriptor;
        }// end function

        protected function stateBeforeChecking(event:Event) : void
        {
            var _loc_2:UpdateEvent = null;
            logger.finest("stateBeforeChecking: " + event.type);
            switch(event.type)
            {
                case HSMEvent.ENTER:
                {
                    _loc_2 = new UpdateEvent(UpdateEvent.CHECK_FOR_UPDATE, false, true);
                    dispatchEvent(_loc_2);
                    if (!_loc_2.isDefaultPrevented())
                    {
                        transition(stateChecking);
                        return;
                    }
                    logger.finer("CheckForUpdate cancelled");
                    break;
                }
                case EVENT_CHECK:
                {
                    transition(stateChecking);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function stateInstallingFile(event:Event) : void
        {
            logger.finest("stateInstallingFile: " + event.type);
            switch(event.type)
            {
                case HSMEvent.ENTER:
                {
                    installFileUpdate();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function statePendingInstall(event:Event) : void
        {
            logger.finest("statePendingInstall: " + event.type);
            switch(event.type)
            {
                case HSMEvent.ENTER:
                {
                    return;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function get configuration() : UpdaterConfiguration
        {
            return _configuration;
        }// end function

        public function cancel() : void
        {
            transition(stateCancelled);
            return;
        }// end function

        private function descriptorDownloaded() : void
        {
            var xml:XML;
            logger.finer("Parsing descriptor");
            try
            {
                xml = FileUtils.readXMLFromFile(updateFile);
                _descriptor = new UpdateDescriptor(xml);
                _descriptor.validate();
                if (!isNewerVersion(VersionUtils.getApplicationVersion(), _descriptor.version))
                {
                    dispatchEvent(new StatusUpdateEvent(StatusUpdateEvent.UPDATE_STATUS));
                    transition(stateReady);
                    return;
                }
                updateFile = FileUtils.getLocalUpdateFile();
                updateURL = new URLRequest(descriptor.url);
                transition(stateAvailable);
            }
            catch (e:Error)
            {
                logger.fine("Error loading/validating downloaded descriptor: " + e);
                dispatchEvent(new StatusUpdateErrorEvent(StatusUpdateErrorEvent.UPDATE_ERROR, false, false, e.message, e.errorID));
                transition(stateErrored);
            }
            return;
        }// end function

    }
}
