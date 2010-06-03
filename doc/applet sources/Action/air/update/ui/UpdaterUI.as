package air.update.ui
{
    import air.update.*;
    import air.update.events.*;
    import flash.events.*;
    import flash.filesystem.*;

    public class UpdaterUI extends ApplicationUpdater
    {
        private var uiLoader:EmbeddedUILoader;

        public function UpdaterUI()
        {
            return;
        }// end function

        override public function installFromAIRFile(param1:File) : void
        {
            showUI();
            super.installFromAIRFile(param1);
            return;
        }// end function

        public function get isFileUpdateVisible() : Boolean
        {
            return configuration.isFileUpdateVisible;
        }// end function

        public function addResources(param1:String, param2:Object) : void
        {
            if (uiLoader && uiLoader.initialized)
            {
                uiLoader.addResources(param1, param2);
            }
            return;
        }// end function

        public function get isUnexpectedErrorVisible() : Boolean
        {
            return configuration.isUnexpectedErrorVisible;
        }// end function

        public function set isFileUpdateVisible(param1:Boolean) : void
        {
            configuration.isFileUpdateVisible = param1;
            return;
        }// end function

        public function set isUnexpectedErrorVisible(param1:Boolean) : void
        {
            configuration.isUnexpectedErrorVisible = param1;
            return;
        }// end function

        override public function installUpdate() : void
        {
            hideUI();
            super.installUpdate();
            return;
        }// end function

        override public function checkForUpdate() : void
        {
            hideUI();
            super.checkForUpdate();
            return;
        }// end function

        private function onUILoadComplete(event:Event) : void
        {
            dispatch(new UpdateEvent(UpdateEvent.INITIALIZED));
            return;
        }// end function

        public function get isDownloadProgressVisible() : Boolean
        {
            return configuration.isDownloadProgressVisible;
        }// end function

        public function set localeChain(param1:Array) : void
        {
            if (uiLoader && uiLoader.initialized)
            {
                uiLoader.setLocaleChain(param1);
            }
            return;
        }// end function

        public function get localeChain() : Array
        {
            if (uiLoader && uiLoader.initialized)
            {
                return uiLoader.getLocaleChain();
            }
            return [];
        }// end function

        public function get isInstallUpdateVisible() : Boolean
        {
            return configuration.isInstallUpdateVisible;
        }// end function

        private function hideUI() : void
        {
            if (uiLoader && uiLoader.initialized)
            {
                uiLoader.hideWindow();
            }
            return;
        }// end function

        private function showUI() : void
        {
            if (uiLoader && uiLoader.initialized)
            {
                uiLoader.showWindow();
            }
            return;
        }// end function

        override public function cancelUpdate() : void
        {
            hideUI();
            super.cancelUpdate();
            return;
        }// end function

        public function set isDownloadProgressVisible(param1:Boolean) : void
        {
            configuration.isDownloadProgressVisible = param1;
            return;
        }// end function

        public function set isDownloadUpdateVisible(param1:Boolean) : void
        {
            configuration.isDownloadUpdateVisible = param1;
            return;
        }// end function

        public function set isInstallUpdateVisible(param1:Boolean) : void
        {
            configuration.isInstallUpdateVisible = param1;
            return;
        }// end function

        override public function downloadUpdate() : void
        {
            hideUI();
            super.downloadUpdate();
            return;
        }// end function

        override public function checkNow() : void
        {
            showUI();
            super.checkNow();
            return;
        }// end function

        public function get isDownloadUpdateVisible() : Boolean
        {
            return configuration.isDownloadUpdateVisible;
        }// end function

        override protected function onInitializationComplete() : void
        {
            uiLoader = new EmbeddedUILoader();
            uiLoader.applicationUpdater = this;
            uiLoader.addEventListener(IOErrorEvent.IO_ERROR, function (event:Event) : void
            {
                throw new Error("Cannot load UI");
            }// end function
            );
            uiLoader.addEventListener(Event.COMPLETE, onUILoadComplete);
            uiLoader.load();
            return;
        }// end function

        public function set isCheckForUpdateVisible(param1:Boolean) : void
        {
            configuration.isCheckForUpdateVisible = param1;
            return;
        }// end function

        public function get isCheckForUpdateVisible() : Boolean
        {
            return configuration.isCheckForUpdateVisible;
        }// end function

    }
}
