package air.update.descriptors
{
    import air.update.utils.*;

    public class ConfigurationDescriptor extends Object
    {
        private var defaultNS:Namespace;
        private var xml:XML;
        public static const DIALOG_INSTALL_UPDATE:String = "installupdate";
        public static const DIALOG_DOWNLOAD_UPDATE:String = "downloadupdate";
        public static const DIALOG_DOWNLOAD_PROGRESS:String = "downloadprogress";
        public static const DIALOG_CHECK_FOR_UPDATE:String = "checkforupdate";
        public static const NAMESPACE_CONFIGURATION_1_0:Namespace = new Namespace("http://ns.adobe.com/air/framework/update/configuration/1.0");
        public static const DIALOG_UNEXPECTED_ERROR:String = "unexpectederror";
        public static const DIALOG_FILE_UPDATE:String = "fileupdate";

        public function ConfigurationDescriptor(param1:XML)
        {
            this.xml = param1;
            defaultNS = param1.namespace();
            return;
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

        public function get defaultUI() : Array
        {
            var _loc_2:XML = null;
            var _loc_3:Object = null;
            default xml namespace = defaultNS;
            var _loc_1:* = new Array();
            for each (_loc_2 in xml.defaultUI.*)
            {
                
                _loc_3 = {name:_loc_2.@name, visible:stringToBoolean_defaultFalse(_loc_2.@visible)};
                _loc_1.push(_loc_3);
            }
            return _loc_1;
        }// end function

        public function validate() : void
        {
            default xml namespace = defaultNS;
            if (!isThisVersion(defaultNS))
            {
                throw new Error("unknown configuration version", Constants.ERROR_CONFIGURATION_UNKNOWN);
            }
            if (url == "")
            {
                throw new Error("configuration url must have a non-empty value", Constants.ERROR_URL_MISSING);
            }
            if (!validateInterval(xml.delay.toString()))
            {
                throw new Error("Illegal value \"" + xml.delay.toString() + "\" for configuration/delay", Constants.ERROR_DELAY_INVALID);
            }
            if (!validateDefaultUI(xml.defaultUI))
            {
                throw new Error("Illegal values for configuration/defaultUI", Constants.ERROR_DEFAULTUI_INVALID);
            }
            return;
        }// end function

        public function get checkInterval() : Number
        {
            default xml namespace = defaultNS;
            return convertInterval(xml.delay.toString());
        }// end function

        public function get url() : String
        {
            default xml namespace = defaultNS;
            return xml.url.toString();
        }// end function

        private static function validateDefaultUI(param1:XMLList) : Boolean
        {
            var _loc_3:XML = null;
            default xml namespace = _loc_2;
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
                if (_loc_3.name().localName != "dialog")
                {
                    return false;
                }
                if ([DIALOG_CHECK_FOR_UPDATE, DIALOG_DOWNLOAD_UPDATE, DIALOG_DOWNLOAD_PROGRESS, DIALOG_INSTALL_UPDATE, DIALOG_FILE_UPDATE, DIALOG_UNEXPECTED_ERROR].indexOf(_loc_3.@name.toString().toLowerCase()) == -1)
                {
                    return false;
                }
                if (["true", "false"].indexOf(_loc_3.@visible.toString()) == -1)
                {
                    return false;
                }
                if (_loc_3.hasComplexContent())
                {
                    return false;
                }
            }
            return true;
        }// end function

        public static function isThisVersion(param1:Namespace) : Boolean
        {
            if (param1)
            {
            }
            return param1.uri == NAMESPACE_CONFIGURATION_1_0.uri;
        }// end function

        private static function validateInterval(param1:String) : Boolean
        {
            var intervalNumber:Number;
            var intervalString:* = param1;
            default xml namespace = result;
            var result:Boolean;
            if (intervalString.length > 0)
            {
                try
                {
                    intervalNumber = Number(intervalString);
                    if (intervalNumber >= 0)
                    {
                        result;
                    }
                }
                catch (theException)
                {
                    result;
                }
            }
            else
            {
                result;
            }
            return result;
        }// end function

        private static function convertInterval(param1:String) : Number
        {
            default xml namespace = _loc_2;
            var _loc_2:Number = -1;
            if (param1.length > 0)
            {
                _loc_2 = Number(param1);
            }
            return _loc_2;
        }// end function

    }
}
