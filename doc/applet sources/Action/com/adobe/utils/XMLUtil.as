package com.adobe.utils
{

    public class XMLUtil extends Object
    {
        public static const ATTRIBUTE:String = "attribute";
        public static const COMMENT:String = "comment";
        public static const PROCESSING_INSTRUCTION:String = "processing-instruction";
        public static const TEXT:String = "text";
        public static const ELEMENT:String = "element";

        public function XMLUtil()
        {
            return;
        }// end function

        public static function isValidXML(param1:String) : Boolean
        {
            var xml:XML;
            var data:* = param1;
            try
            {
                xml = new XML(data);
            }
            catch (e:Error)
            {
                return false;
            }
            if (xml.nodeKind() != ELEMENT)
            {
                return false;
            }
            return true;
        }// end function

        static function getSiblingByIndex(param1:XML, param2:int) : XML
        {
            var out:XML;
            var x:* = param1;
            var count:* = param2;
            try
            {
                out = x.parent().children()[x.childIndex() + count];
            }
            catch (e:Error)
            {
                return null;
            }
            return out;
        }// end function

        public static function getPreviousSibling(param1:XML) : XML
        {
            return getSiblingByIndex(param1, -1);
        }// end function

        public static function getNextSibling(param1:XML) : XML
        {
            return getSiblingByIndex(param1, 1);
        }// end function

    }
}
