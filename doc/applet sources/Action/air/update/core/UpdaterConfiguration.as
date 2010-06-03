package air.update.core
{
    import air.update.descriptors.*;
    import air.update.logging.*;
    import air.update.utils.*;
    import flash.filesystem.*;

    public class UpdaterConfiguration extends Object
    {
        private var _delay:Number;
        private var configurationDescriptor:ConfigurationDescriptor;
        private var _isFileUpdateVisible:int;
        private var _configurationFile:File;
        private var _isDownloadProgressVisible:int;
        private var _isUnexpectedErrorVisible:int;
        private var _updateURL:String;
        private var _isNewerVersionFunction:Function;
        private var _isInstallUpdateVisible:int;
        private var _isDownloadUpdateVisible:int;
        private var _isCheckForUpdateVisible:int;
        private static var logger:Logger = Logger.getLogger("air.update.core.UpdaterConfiguration");

        public function UpdaterConfiguration()
        {
            _delay = -1;
            _isCheckForUpdateVisible = -1;
            _isDownloadUpdateVisible = -1;
            _isDownloadProgressVisible = -1;
            _isInstallUpdateVisible = -1;
            _isFileUpdateVisible = -1;
            _isUnexpectedErrorVisible = -1;
            _isNewerVersionFunction = VersionUtils.isNewerVersion;
            return;
        }// end function

        public function get delay() : Number
        {
            if (_delay < 0)
            {
                if (configurationDescriptor && configurationDescriptor.checkInterval >= 0)
                {
                    return configurationDescriptor.checkInterval;
                }
                return 0;
            }
            return _delay;
        }// end function

        public function set delay(param1:Number) : void
        {
            _delay = param1;
            return;
        }// end function

        public function get delayAsMilliseconds() : Number
        {
            return delay * Constants.DAY_IN_MILLISECONDS;
        }// end function

        public function set updateURL(param1:String) : void
        {
            _updateURL = param1;
            return;
        }// end function

        public function get isNewerVersionFunction() : Function
        {
            return _isNewerVersionFunction;
        }// end function

        public function set isUnexpectedErrorVisible(param1:Boolean) : void
        {
            _isUnexpectedErrorVisible = param1 ? (1) : (0);
            return;
        }// end function

        public function get configurationFile() : File
        {
            return _configurationFile;
        }// end function

        public function set isFileUpdateVisible(param1:Boolean) : void
        {
            _isFileUpdateVisible = param1 ? (1) : (0);
            return;
        }// end function

        public function get isCheckForUpdateVisible() : Boolean
        {
            if (_isCheckForUpdateVisible >= 0)
            {
                return _isCheckForUpdateVisible == 1;
            }
            var _loc_1:* = dialogVisibilityInConfiguration(ConfigurationDescriptor.DIALOG_CHECK_FOR_UPDATE);
            if (_loc_1 >= 0)
            {
                return _loc_1 == 1;
            }
            return true;
        }// end function

        public function get isDownloadUpdateVisible() : Boolean
        {
            if (_isDownloadUpdateVisible >= 0)
            {
                return _isDownloadUpdateVisible == 1;
            }
            var _loc_1:* = dialogVisibilityInConfiguration(ConfigurationDescriptor.DIALOG_DOWNLOAD_UPDATE);
            if (_loc_1 >= 0)
            {
                return _loc_1 == 1;
            }
            return true;
        }// end function

        public function set isNewerVersionFunction(param1:Function) : void
        {
            _isNewerVersionFunction = param1;
            return;
        }// end function

        public function get isFileUpdateVisible() : Boolean
        {
            if (_isFileUpdateVisible >= 0)
            {
                return _isFileUpdateVisible == 1;
            }
            var _loc_1:* = dialogVisibilityInConfiguration(ConfigurationDescriptor.DIALOG_FILE_UPDATE);
            if (_loc_1 >= 0)
            {
                return _loc_1 == 1;
            }
            return true;
        }// end function

        public function set isInstallUpdateVisible(param1:Boolean) : void
        {
            _isInstallUpdateVisible = param1 ? (1) : (0);
            return;
        }// end function

        public function set isDownloadProgressVisible(param1:Boolean) : void
        {
            _isDownloadProgressVisible = param1 ? (1) : (0);
            return;
        }// end function

        public function get isDownloadProgressVisible() : Boolean
        {
            if (_isDownloadProgressVisible >= 0)
            {
                return _isDownloadProgressVisible == 1;
            }
            var _loc_1:* = dialogVisibilityInConfiguration(ConfigurationDescriptor.DIALOG_DOWNLOAD_PROGRESS);
            if (_loc_1 >= 0)
            {
                return _loc_1 == 1;
            }
            return true;
        }// end function

        public function validate() : void
        {
            var _loc_1:XML = null;
            if (configurationFile)
            {
                if (!configurationFile.exists)
                {
                    throw new Error("Configuration file \"" + configurationFile.nativePath + "\" does not exists on disk", Constants.ERROR_CONFIGURATION_FILE_MISSING);
                }
                _loc_1 = FileUtils.readXMLFromFile(configurationFile);
                configurationDescriptor = new ConfigurationDescriptor(_loc_1);
                configurationDescriptor.validate();
            }
            if (!_updateURL && !configurationDescriptor)
            {
                throw new Error("Update URL not set", Constants.ERROR_UPDATE_URL_MISSING);
            }
            return;
        }// end function

        public function set configurationFile(param1:File) : void
        {
            _configurationFile = param1;
            return;
        }// end function

        public function get updateURL() : String
        {
            return _updateURL ? (_updateURL) : (configurationDescriptor.url);
        }// end function

        public function get isUnexpectedErrorVisible() : Boolean
        {
            if (_isUnexpectedErrorVisible >= 0)
            {
                return _isUnexpectedErrorVisible == 1;
            }
            var _loc_1:* = dialogVisibilityInConfiguration(ConfigurationDescriptor.DIALOG_UNEXPECTED_ERROR);
            if (_loc_1 >= 0)
            {
                return _loc_1 == 1;
            }
            return true;
        }// end function

        public function set isDownloadUpdateVisible(param1:Boolean) : void
        {
            _isDownloadUpdateVisible = param1 ? (1) : (0);
            return;
        }// end function

        public function get isInstallUpdateVisible() : Boolean
        {
            if (_isInstallUpdateVisible >= 0)
            {
                return _isInstallUpdateVisible == 1;
            }
            var _loc_1:* = dialogVisibilityInConfiguration(ConfigurationDescriptor.DIALOG_INSTALL_UPDATE);
            if (_loc_1 >= 0)
            {
                return _loc_1 == 1;
            }
            return true;
        }// end function

        public function set isCheckForUpdateVisible(param1:Boolean) : void
        {
            _isCheckForUpdateVisible = param1 ? (1) : (0);
            return;
        }// end function

        private function dialogVisibilityInConfiguration(param1:String) : int
        {
            var _loc_4:Object = null;
            if (!configurationDescriptor)
            {
                return -1;
            }
            var _loc_2:* = configurationDescriptor.defaultUI;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_4 = _loc_2[_loc_3];
                if (param1.toLowerCase() == _loc_4.name.toLowerCase())
                {
                    return _loc_4.visible ? (1) : (0);
                }
                _loc_3++;
            }
            return -1;
        }// end function

    }
}
