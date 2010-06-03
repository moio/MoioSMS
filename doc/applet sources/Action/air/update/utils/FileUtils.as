package air.update.utils
{
    import air.update.logging.*;
    import flash.filesystem.*;
    import flash.utils.*;

    final public class FileUtils extends Object
    {
        private static var logger:Logger = Logger.getLogger("air.update.utils.FileUtils");

        public function FileUtils()
        {
            return;
        }// end function

        public static function readUTFBytesFromFile(param1:File) : String
        {
            var _loc_2:* = new FileStream();
            _loc_2.open(param1, FileMode.READ);
            var _loc_3:* = _loc_2.readUTFBytes(_loc_2.bytesAvailable);
            _loc_2.close();
            return _loc_3;
        }// end function

        public static function readByteArrayFromFile(param1:File) : ByteArray
        {
            var _loc_2:* = new FileStream();
            _loc_2.open(param1, FileMode.READ);
            var _loc_3:* = new ByteArray();
            _loc_2.readBytes(_loc_3, 0, param1.size);
            _loc_2.close();
            return _loc_3;
        }// end function

        public static function deleteFile(param1:File) : void
        {
            var file:* = param1;
            if (!file.exists)
            {
                return;
            }
            if (file.isDirectory)
            {
                return;
            }
            try
            {
                file.deleteFile();
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        public static function getStorageStateFile() : File
        {
            return File.applicationStorageDirectory.resolvePath(Constants.UPDATER_FOLDER + "/" + Constants.STATE_FILE);
        }// end function

        public static function getDocumentsStateFile() : File
        {
            return new File(File.applicationStorageDirectory.nativePath + "/../../" + VersionUtils.getApplicationID() + "_" + Constants.STATE_FILE);
        }// end function

        public static function getLocalDescriptorFile() : File
        {
            return File.applicationStorageDirectory.resolvePath(Constants.UPDATER_FOLDER + "/" + Constants.DESCRIPTOR_LOCAL_FILE);
        }// end function

        public static function readXMLFromFile(param1:File) : XML
        {
            return new XML(readByteArrayFromFile(param1).toString());
        }// end function

        public static function getFilenameFromURL(param1:String) : String
        {
            var _loc_2:* = param1.lastIndexOf("/");
            if (_loc_2 == -1)
            {
                logger.finest("Cannot get filename from \"" + param1 + "\"");
                return "";
            }
            return param1.substr(_loc_2 + 1);
        }// end function

        public static function saveXMLToFile(param1:XML, param2:File) : void
        {
            var _loc_3:* = new FileStream();
            _loc_3.open(param2, FileMode.WRITE);
            _loc_3.writeUTFBytes(param1.toXMLString());
            _loc_3.close();
            return;
        }// end function

        public static function deleteFolder(param1:File) : void
        {
            var file:* = param1;
            if (!file.exists)
            {
                return;
            }
            if (!file.isDirectory)
            {
                return;
            }
            try
            {
                file.deleteDirectory(false);
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        public static function getLocalUpdateFile() : File
        {
            return File.applicationStorageDirectory.resolvePath(Constants.UPDATER_FOLDER + "/" + Constants.UPDATE_LOCAL_FILE);
        }// end function

    }
}
