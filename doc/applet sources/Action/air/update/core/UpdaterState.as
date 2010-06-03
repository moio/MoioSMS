package air.update.core
{
    import air.update.descriptors.*;
    import air.update.logging.*;
    import air.update.utils.*;
    import flash.filesystem.*;

    public class UpdaterState extends Object
    {
        private var _descriptor:StateDescriptor;
        private static var logger:Logger = Logger.getLogger("air.update.core.UpdaterState");

        public function UpdaterState()
        {
            return;
        }// end function

        public function removeAllFailedUpdates() : void
        {
            descriptor.removeAllFailedUpdates();
            return;
        }// end function

        public function resetUpdateData() : void
        {
            descriptor.currentVersion = "";
            descriptor.previousVersion = "";
            descriptor.storage = null;
            FileUtils.deleteFile(FileUtils.getLocalUpdateFile());
            FileUtils.deleteFile(FileUtils.getLocalDescriptorFile());
            descriptor.updaterLaunched = false;
            return;
        }// end function

        public function load() : void
        {
            var xml:XML;
            var storageFile:* = FileUtils.getStorageStateFile();
            var documentsFile:* = FileUtils.getDocumentsStateFile();
            if (!storageFile.exists)
            {
                if (!documentsFile.exists)
                {
                    _descriptor = StateDescriptor.defaultState();
                    saveToStorage();
                }
                else
                {
                    try
                    {
                        xml = FileUtils.readXMLFromFile(documentsFile);
                        _descriptor = new StateDescriptor(xml);
                        _descriptor.validate();
                        saveToStorage();
                    }
                    catch (e:Error)
                    {
                        logger.fine("Invalid state: " + e);
                        _descriptor = StateDescriptor.defaultState();
                        saveToStorage();
                    }
                }
            }
            else
            {
                try
                {
                    xml = FileUtils.readXMLFromFile(storageFile);
                    _descriptor = new StateDescriptor(xml);
                    _descriptor.validate();
                }
                catch (e:Error)
                {
                    logger.fine("Invalid state: " + e);
                    _descriptor = StateDescriptor.defaultState();
                    saveToStorage();
                }
            }
            var updateFile:* = FileUtils.getLocalUpdateFile();
            if (descriptor.currentVersion && !updateFile.exists && !descriptor.updaterLaunched)
            {
                logger.fine("Missing update file");
                _descriptor = StateDescriptor.defaultState();
                saveToStorage();
            }
            FileUtils.deleteFile(documentsFile);
            return;
        }// end function

        public function addFailedUpdate(param1:String) : void
        {
            descriptor.addFailedUpdate(param1);
            return;
        }// end function

        public function saveToDocuments() : void
        {
            var _loc_1:* = FileUtils.getDocumentsStateFile();
            FileUtils.saveXMLToFile(_descriptor.getXML(), _loc_1);
            return;
        }// end function

        public function removePreviousStorageData(param1:File) : void
        {
            if (!param1 || !param1.exists)
            {
                return;
            }
            var _loc_2:* = param1.resolvePath(Constants.UPDATER_FOLDER + "/" + Constants.STATE_FILE);
            FileUtils.deleteFile(_loc_2);
            _loc_2 = param1.resolvePath(Constants.UPDATER_FOLDER + "/" + Constants.UPDATE_LOCAL_FILE);
            FileUtils.deleteFile(_loc_2);
            _loc_2 = param1.resolvePath(Constants.UPDATER_FOLDER + "/" + Constants.DESCRIPTOR_LOCAL_FILE);
            FileUtils.deleteFile(_loc_2);
            _loc_2 = param1.resolvePath(Constants.UPDATER_FOLDER);
            FileUtils.deleteFolder(_loc_2);
            return;
        }// end function

        public function saveToStorage() : void
        {
            var _loc_1:* = FileUtils.getStorageStateFile();
            FileUtils.saveXMLToFile(_descriptor.getXML(), _loc_1);
            return;
        }// end function

        public function get descriptor() : StateDescriptor
        {
            return _descriptor;
        }// end function

    }
}
