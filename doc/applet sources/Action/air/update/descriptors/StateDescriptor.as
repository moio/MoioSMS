package air.update.descriptors
{
    import air.update.logging.*;
    import air.update.utils.*;
    import flash.filesystem.*;

    public class StateDescriptor extends Object
    {
        private var defaultNS:Namespace;
        private var xml:XML;
        private static var logger:Logger = Logger.getLogger("air.update.descriptors.StateDescriptor");
        public static const NAMESPACE_STATE_1_0:Namespace = new Namespace("http://ns.adobe.com/air/framework/update/state/1.0");

        public function StateDescriptor(param1:XML)
        {
            this.xml = param1;
            defaultNS = param1.namespace();
            return;
        }// end function

        public function set lastCheckDate(param1:Date) : void
        {
            default xml namespace = StateDescriptor.NAMESPACE_STATE_1_0;
            xml.lastCheck = param1.toString();
            return;
        }// end function

        public function set previousVersion(param1:String) : void
        {
            default xml namespace = StateDescriptor.NAMESPACE_STATE_1_0;
            xml.previousVersion = param1;
            return;
        }// end function

        private function fileToString_defaultEmpty(param1:File) : String
        {
            default xml namespace = defaultNS;
            if (param1 && param1.nativePath)
            {
                return param1.nativePath;
            }
            return "";
        }// end function

        public function get storage() : File
        {
            default xml namespace = StateDescriptor.NAMESPACE_STATE_1_0;
            return stringToFile_defaultNull(xml.storage.toString());
        }// end function

        public function get failedUpdates() : Array
        {
            var _loc_2:XML = null;
            default xml namespace = StateDescriptor.NAMESPACE_STATE_1_0;
            var _loc_1:* = new Array();
            for each (_loc_2 in xml.failed.*)
            {
                
                _loc_1.push(_loc_2);
            }
            return _loc_1;
        }// end function

        public function removeAllFailedUpdates() : void
        {
            default xml namespace = StateDescriptor.NAMESPACE_STATE_1_0;
            xml.failed = <failed/>;
            return;
        }// end function

        public function validate() : void
        {
            default xml namespace = defaultNS;
            if (!isThisVersion(defaultNS))
            {
                throw new Error("unknown state version", Constants.ERROR_STATE_UNKNOWN);
            }
            if (xml.lastCheck.toString() == "")
            {
                throw new Error("lastCheck must have a non-empty value", Constants.ERROR_LAST_CHECK_MISSING);
            }
            if (!validateDate(xml.lastCheck.toString()))
            {
                throw new Error("Invalid date format for state/lastCheck", Constants.ERROR_LAST_CHECK_INVALID);
            }
            if (xml.previousVersion.toString() != "" && !validateText(xml.previousVersion))
            {
                throw new Error("Illegal value for state/previousVersion", Constants.ERROR_PREV_VERSION_INVALID);
            }
            if (xml.currentVersion.toString() != "" && !validateText(xml.currentVersion))
            {
                throw new Error("Illegal value for state/currentVersion", Constants.ERROR_CURRENT_VERSION_INVALID);
            }
            if (xml.storage.toString() != "" && !validateText(xml.storage) || !validateFile(xml.storage.toString()))
            {
                throw new Error("Illegal value for state/storage", Constants.ERROR_STORAGE_INVALID);
            }
            if (["", "true", "false"].indexOf(xml.updaterLaunched.toString()) == -1)
            {
                throw new Error("Illegal value \"" + xml.updaterLaunched.toString() + "\" for state/updaterLaunched.", Constants.ERROR_LAUNCHED_INVALID);
            }
            if (!validateFailed(xml.failed))
            {
                throw new Error("Illegal values for state/failed", Constants.ERROR_FAILED_INVALID);
            }
            var _loc_1:int = 0;
            if (previousVersion != "")
            {
                _loc_1++;
            }
            if (currentVersion != "")
            {
                _loc_1++;
            }
            if (storage)
            {
                _loc_1++;
            }
            if (_loc_1 > 0 && _loc_1 != 3)
            {
                throw new Error("All state/previousVersion, state/currentVersion, state/storage, state/updaterLaunched  must be set", Constants.ERROR_VERSIONS_INVALID);
            }
            return;
        }// end function

        public function get currentVersion() : String
        {
            default xml namespace = StateDescriptor.NAMESPACE_STATE_1_0;
            return xml.currentVersion.toString();
        }// end function

        public function get lastCheckDate() : Date
        {
            default xml namespace = StateDescriptor.NAMESPACE_STATE_1_0;
            return stringToDate_defaultNull(xml.lastCheck.toString());
        }// end function

        public function getXML() : XML
        {
            default xml namespace = StateDescriptor.NAMESPACE_STATE_1_0;
            return xml;
        }// end function

        private function validateText(param1:XMLList) : Boolean
        {
            default xml namespace = defaultNS;
            if (!param1.hasSimpleContent())
            {
                return false;
            }
            if (param1.length() > 1)
            {
                return false;
            }
            return true;
        }// end function

        private function validateDate(param1:String) : Boolean
        {
            var n:Number;
            var dateString:* = param1;
            default xml namespace = defaultNS;
            var result:Boolean;
            try
            {
                n = Date.parse(dateString);
                if (!isNaN(n))
                {
                    result;
                }
            }
            catch (err:Error)
            {
                result;
            }
            return result;
        }// end function

        private function stringToBoolean_defaultFalse(param1:String) : Boolean
        {
            default xml namespace = defaultNS;
            switch(param1)
            {
                case "true":
                case "1":
                {
                    return true;
                }
                case "":
                case "false":
                case "0":
                {
                    return false;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function addFailedUpdate(param1:String) : void
        {
            default xml namespace = StateDescriptor.NAMESPACE_STATE_1_0;
            if (xml.failed.length() == 0)
            {
                xml.failed = <failed/>;
            }
            xml.failed.appendChild(new XML("<version>" + param1 + "</version>"));
            return;
        }// end function

        public function get previousVersion() : String
        {
            default xml namespace = StateDescriptor.NAMESPACE_STATE_1_0;
            return xml.previousVersion.toString();
        }// end function

        private function stringToDate_defaultNull(param1:String) : Date
        {
            default xml namespace = defaultNS;
            var _loc_2:Date = null;
            if (param1)
            {
                _loc_2 = new Date(param1);
            }
            return _loc_2;
        }// end function

        private function stringToFile_defaultNull(param1:String) : File
        {
            default xml namespace = defaultNS;
            if (!param1)
            {
                return null;
            }
            return new File(param1);
        }// end function

        private function validateFile(param1:String) : Boolean
        {
            var file:File;
            var fileString:* = param1;
            default xml namespace = defaultNS;
            var result:Boolean;
            try
            {
                file = new File(fileString);
                result;
            }
            catch (err:Error)
            {
                result;
            }
            return result;
        }// end function

        public function set storage(param1:File) : void
        {
            default xml namespace = StateDescriptor.NAMESPACE_STATE_1_0;
            xml.storage = fileToString_defaultEmpty(param1);
            return;
        }// end function

        private function validateFailed(param1:XMLList) : Boolean
        {
            var _loc_3:XML = null;
            default xml namespace = defaultNS;
            if (param1.length() > 1)
            {
                return false;
            }
            var _loc_2:* = param1.*;
            for each (_loc_3 in _loc_2)
            {
                
                if (_loc_3.name() == null)
                {
                    return false;
                }
                if (_loc_3.name().localName != "version")
                {
                    return false;
                }
                if (!_loc_3.hasSimpleContent())
                {
                    return false;
                }
            }
            return true;
        }// end function

        public function get updaterLaunched() : Boolean
        {
            default xml namespace = StateDescriptor.NAMESPACE_STATE_1_0;
            return stringToBoolean_defaultFalse(xml.updaterLaunched.toString());
        }// end function

        public function set updaterLaunched(param1:Boolean) : void
        {
            default xml namespace = StateDescriptor.NAMESPACE_STATE_1_0;
            xml.updaterLaunched = param1.toString();
            return;
        }// end function

        public function set currentVersion(param1:String) : void
        {
            default xml namespace = StateDescriptor.NAMESPACE_STATE_1_0;
            xml.currentVersion = param1;
            return;
        }// end function

        public static function isThisVersion(param1:Namespace) : Boolean
        {
            if (param1)
            {
            }
            return param1.uri == NAMESPACE_STATE_1_0.uri;
        }// end function

        public static function defaultState() : StateDescriptor
        {
            default xml namespace = StateDescriptor.NAMESPACE_STATE_1_0;
            var _loc_1:* = new XML("<state>\r\n\t\t\t\t\t" + ("<lastCheck>" + new Date() + "</lastCheck>") + "\r\n\t\t\t\t</state>");
            return new StateDescriptor(_loc_1);
        }// end function

    }
}
