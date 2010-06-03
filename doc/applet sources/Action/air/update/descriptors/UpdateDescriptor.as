package air.update.descriptors
{
    import air.update.utils.*;

    public class UpdateDescriptor extends Object
    {
        private var defaultNS:Namespace;
        private var xml:XML;
        public static const NAMESPACE_UPDATE_1_0:Namespace = new Namespace("http://ns.adobe.com/air/framework/update/description/1.0");

        public function UpdateDescriptor(param1:XML)
        {
            this.xml = param1;
            defaultNS = param1.namespace();
            return;
        }// end function

        public function getXML() : XML
        {
            default xml namespace = defaultNS;
            return xml;
        }// end function

        public function get version() : String
        {
            default xml namespace = defaultNS;
            return xml.version.toString();
        }// end function

        public function get description() : Array
        {
            default xml namespace = defaultNS;
            return UpdateDescriptor.getLocalizedText(xml.description, defaultNS);
        }// end function

        public function validate() : void
        {
            default xml namespace = defaultNS;
            if (!isThisVersion(defaultNS))
            {
                throw new Error("unknown update version", Constants.ERROR_UPDATE_UNKNOWN);
            }
            if (version == "")
            {
                throw new Error("update version must have a non-empty value", Constants.ERROR_VERSION_MISSING);
            }
            if (url == "")
            {
                throw new Error("update url must have a non-empty value", Constants.ERROR_URL_MISSING);
            }
            if (!validateLocalizedText(xml.description, defaultNS))
            {
                throw new Error("Illegal values for update/description", Constants.ERROR_DESCRIPTION_INVALID);
            }
            return;
        }// end function

        public function get url() : String
        {
            default xml namespace = defaultNS;
            return xml.url.toString();
        }// end function

        public static function getLocalizedText(param1:XMLList, param2:Namespace) : Array
        {
            var _loc_5:XMLList = null;
            var _loc_6:XML = null;
            default xml namespace = param2;
            var _loc_3:* = new Namespace("http://www.w3.org/XML/1998/namespace");
            var _loc_4:Array = [];
            if (param1.hasSimpleContent())
            {
                _loc_4 = [["", param1.toString()]];
            }
            else
            {
                _loc_5 = param2::text;
                for each (_loc_6 in _loc_5)
                {
                    
                    _loc_4.push([_loc_3::@lang.toString(), _loc_6[0].toString()]);
                }
            }
            return _loc_4;
        }// end function

        private static function validateLocalizedText(param1:XMLList, param2:Namespace) : Boolean
        {
            var _loc_5:XML = null;
            default xml namespace = param2;
            var _loc_3:* = new Namespace("http://www.w3.org/XML/1998/namespace");
            if (param1.hasSimpleContent())
            {
                return true;
            }
            if (param1.length() > 1)
            {
                return false;
            }
            var _loc_4:* = param1.*;
            for each (_loc_5 in _loc_4)
            {
                
                if (_loc_5.name() == null)
                {
                    return false;
                }
                if (_loc_5.name().localName != "text")
                {
                    return false;
                }
                if (_loc_3::@lang.length() == 0)
                {
                    return false;
                }
                if (!_loc_5.hasSimpleContent())
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
            return param1.uri == NAMESPACE_UPDATE_1_0.uri;
        }// end function

    }
}
