package air.update
{
    import air.update.events.*;
    import air.update.logging.*;
    import air.update.states.*;
    import air.update.ui.*;
    import flash.events.*;
    import flash.filesystem.*;

    public class ApplicationUpdaterUI extends EventDispatcher
    {
        private var isUpdaterUIInitialized:Boolean;
        private var applicationUpdater:UpdaterUI;
        private static var logger:Logger = Logger.getLogger("air.update.ApplicationUpdaterUI");

        public function ApplicationUpdaterUI() : void
        {
            applicationUpdater = new UpdaterUI();
            applicationUpdater.addEventListener(UpdateEvent.INITIALIZED, dispatchProxy);
            applicationUpdater.addEventListener(ErrorEvent.ERROR, dispatchError);
            applicationUpdater.addEventListener(UpdateEvent.CHECK_FOR_UPDATE, dispatchProxy);
            applicationUpdater.addEventListener(StatusUpdateEvent.UPDATE_STATUS, dispatchProxy);
            applicationUpdater.addEventListener(UpdateEvent.DOWNLOAD_START, dispatchProxy);
            applicationUpdater.addEventListener(ProgressEvent.PROGRESS, dispatchProxy);
            applicationUpdater.addEventListener(UpdateEvent.DOWNLOAD_COMPLETE, dispatchProxy);
            applicationUpdater.addEventListener(UpdateEvent.BEFORE_INSTALL, dispatchProxy);
            applicationUpdater.addEventListener(StatusUpdateErrorEvent.UPDATE_ERROR, dispatchProxy);
            applicationUpdater.addEventListener(DownloadErrorEvent.DOWNLOAD_ERROR, dispatchProxy);
            applicationUpdater.addEventListener(StatusFileUpdateEvent.FILE_UPDATE_STATUS, dispatchProxy);
            applicationUpdater.addEventListener(StatusFileUpdateErrorEvent.FILE_UPDATE_ERROR, dispatchProxy);
            return;
        }// end function

        public function get delay() : Number
        {
            return applicationUpdater.delay;
        }// end function

        public function addResources(param1:String, param2:Object) : void
        {
            applicationUpdater.addResources(param1, param2);
            return;
        }// end function

        public function get isFirstRun() : Boolean
        {
            return applicationUpdater.isFirstRun;
        }// end function

        public function set delay(param1:Number) : void
        {
            applicationUpdater.delay = param1;
            return;
        }// end function

        public function get localeChain() : Array
        {
            return applicationUpdater.localeChain;
        }// end function

        public function installFromAIRFile(param1:File) : void
        {
            applicationUpdater.installFromAIRFile(param1);
            return;
        }// end function

        public function get isFileUpdateVisible() : Boolean
        {
            return applicationUpdater.isFileUpdateVisible;
        }// end function

        public function set updateURL(param1:String) : void
        {
            applicationUpdater.updateURL = param1;
            return;
        }// end function

        public function get isNewerVersionFunction() : Function
        {
            return applicationUpdater.isNewerVersionFunction;
        }// end function

        public function set localeChain(param1:Array) : void
        {
            applicationUpdater.localeChain = param1;
            return;
        }// end function

        public function initialize() : void
        {
            applicationUpdater.initialize();
            return;
        }// end function

        public function set isUnexpectedErrorVisible(param1:Boolean) : void
        {
            applicationUpdater.isUnexpectedErrorVisible = param1;
            return;
        }// end function

        public function get configurationFile() : File
        {
            return applicationUpdater.configurationFile;
        }// end function

        public function get isDownloadProgressVisible() : Boolean
        {
            return applicationUpdater.isDownloadProgressVisible;
        }// end function

        protected function dispatchProxy(event:Event) : void
        {
            if (event.type == UpdateEvent.INITIALIZED)
            {
                isUpdaterUIInitialized = true;
            }
            if (event is ErrorEvent)
            {
                if (hasEventListener(event.type))
                {
                    dispatchEvent(event);
                }
            }
            else
            {
                dispatchEvent(event);
            }
            return;
        }// end function

        public function set isFileUpdateVisible(param1:Boolean) : void
        {
            applicationUpdater.isFileUpdateVisible = param1;
            return;
        }// end function

        public function get wasPendingUpdate() : Boolean
        {
            return applicationUpdater.wasPendingUpdate;
        }// end function

        public function get updateDescriptor() : XML
        {
            return applicationUpdater.updateDescriptor;
        }// end function

        public function set isNewerVersionFunction(param1:Function) : void
        {
            applicationUpdater.isNewerVersionFunction = param1;
            return;
        }// end function

        public function get isUnexpectedErrorVisible() : Boolean
        {
            return applicationUpdater.isUnexpectedErrorVisible;
        }// end function

        public function get currentVersion() : String
        {
            return applicationUpdater.currentVersion;
        }// end function

        public function get previousVersion() : String
        {
            return applicationUpdater.previousVersion;
        }// end function

        public function cancelUpdate() : void
        {
            applicationUpdater.cancelUpdate();
            return;
        }// end function

        public function set configurationFile(param1:File) : void
        {
            applicationUpdater.configurationFile = param1;
            return;
        }// end function

        public function get isUpdateInProgress() : Boolean
        {
            return applicationUpdater.currentState != UpdateState.getStateName(UpdateState.READY);
        }// end function

        public function get updateURL() : String
        {
            return applicationUpdater.updateURL;
        }// end function

        public function get isInstallUpdateVisible() : Boolean
        {
            return applicationUpdater.isInstallUpdateVisible;
        }// end function

        public function get previousApplicationStorageDirectory() : File
        {
            return applicationUpdater.previousApplicationStorageDirectory;
        }// end function

        public function set isDownloadProgressVisible(param1:Boolean) : void
        {
            applicationUpdater.isDownloadProgressVisible = param1;
            return;
        }// end function

        protected function dispatchError(event:ErrorEvent) : void
        {
            if (!isUpdaterUIInitialized)
            {
                dispatchEvent(event);
            }
            return;
        }// end function

        public function set isInstallUpdateVisible(param1:Boolean) : void
        {
            applicationUpdater.isInstallUpdateVisible = param1;
            return;
        }// end function

        public function set isDownloadUpdateVisible(param1:Boolean) : void
        {
            applicationUpdater.isDownloadUpdateVisible = param1;
            return;
        }// end function

        public function get isDownloadUpdateVisible() : Boolean
        {
            return applicationUpdater.isDownloadUpdateVisible;
        }// end function

        public function set isCheckForUpdateVisible(param1:Boolean) : void
        {
            applicationUpdater.isCheckForUpdateVisible = param1;
            return;
        }// end function

        public function checkNow() : void
        {
            applicationUpdater.checkNow();
            return;
        }// end function

        public function get isCheckForUpdateVisible() : Boolean
        {
            return applicationUpdater.isCheckForUpdateVisible;
        }// end function

    }
}
