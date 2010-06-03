package air.update.descriptors
{
    import flash.display.*;
    import flash.geom.*;

    public class ApplicationDescriptor extends Object
    {
        private var m_defaultNs:Namespace;
        private var m_xml:XML;
        private var m_name:String;
        private var m_description:String;
        public static const ICON_IMAGES:Object = {image16x16:16, image32x32:32, image48x48:48, image128x128:128};

        public function ApplicationDescriptor(param1:XML)
        {
            m_xml = param1;
            m_defaultNs = m_xml.namespace();
            return;
        }// end function

        public function get initialWindowX() : Number
        {
            default xml namespace = m_defaultNs;
            return convertLocation(m_xml.initialWindow.x.toString());
        }// end function

        public function get initialWindowContent() : String
        {
            default xml namespace = m_defaultNs;
            return m_xml.initialWindow.content;
        }// end function

        public function get filename() : String
        {
            default xml namespace = m_defaultNs;
            return m_xml.filename.toString();
        }// end function

        public function get minimumPatchLevel() : int
        {
            default xml namespace = m_defaultNs;
            return m_xml.@minimumPatchLevel;
        }// end function

        public function get name() : String
        {
            default xml namespace = m_defaultNs;
            return m_name == "" ? (filename) : (m_name);
        }// end function

        private function stringToBoolean_defaultTrue(param1:String) : Boolean
        {
            default xml namespace = m_defaultNs;
            switch(param1)
            {
                case "":
                case "true":
                case "1":
                {
                    return true;
                }
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
            return true;
        }// end function

        public function get initialWindowMinimizable() : Boolean
        {
            default xml namespace = m_defaultNs;
            return stringToBoolean_defaultTrue(m_xml.initialWindow.minimizable.toString());
        }// end function

        public function get copyright() : String
        {
            default xml namespace = m_defaultNs;
            return m_xml.copyright.toString();
        }// end function

        public function get initialWindowMaxSize() : Point
        {
            default xml namespace = m_defaultNs;
            return convertDimensionPoint(m_xml.initialWindow.maxSize.toString());
        }// end function

        public function get initialWindowWidth() : Number
        {
            default xml namespace = m_defaultNs;
            return convertDimension(m_xml.initialWindow.width.toString());
        }// end function

        public function get initialWindowY() : Number
        {
            default xml namespace = m_defaultNs;
            return convertLocation(m_xml.initialWindow.y.toString());
        }// end function

        public function validate() : void
        {
            default xml namespace = m_defaultNs;
            if (filename == "")
            {
                throw new Error("application filename must have a non-empty value.");
            }
            if (!/^([^\*\"\/:<>\?\\\|\. ]|[^\*\"\/:<>\?\\\| ][^\*\"\/:<>\?\\\|]*[^\*\"\/:<>\?\\\|\. ])$/.test(filename))
            {
                throw new Error("invalid application filename");
            }
            if (m_xml.initialWindow.content.toString() == "")
            {
                throw new Error("initialWindow/content must have a non-empty value.");
            }
            if (installFolder != "" && !/^([^\*\"\/:<>\?\\\|\. ]|[^\*\"\/:<>\?\\\| ][^\*\":<>\?\\\|]*[^\*\":<>\?\\\|\. ])$/.test(installFolder))
            {
                throw new Error("invalid install folder");
            }
            if (programMenuFolder != "" && !/^([^\*\"\/:<>\?\\\|\. ]|[^\*\"\/:<>\?\\\| ][^\*\":<>\?\\\|]*[^\*\":<>\?\\\|\. ])$/.test(programMenuFolder))
            {
                throw new Error("invalid program menu folder");
            }
            if (["", NativeWindowSystemChrome.NONE, NativeWindowSystemChrome.STANDARD].indexOf(m_xml.initialWindow.systemChrome.toString()) == -1)
            {
                throw new Error("Illegal value \"" + m_xml.initialWindow.systemChrome.toString() + "\" for application/initialWindow/systemChrome.");
            }
            if (["", "true", "false", "1", "0"].indexOf(m_xml.initialWindow.transparent.toString()) == -1)
            {
                throw new Error("Illegal value \"" + m_xml.initialWindow.transparent.toString() + "\" for application/initialWindow/transparent.");
            }
            if (["", "true", "false", "1", "0"].indexOf(m_xml.initialWindow.visible.toString()) == -1)
            {
                throw new Error("Illegal value \"" + m_xml.initialWindow.visible.toString() + "\" for application/initialWindow/visible.");
            }
            if (["", "true", "false", "1", "0"].indexOf(m_xml.initialWindow.minimizable.toString()) == -1)
            {
                throw new Error("Illegal value \"" + m_xml.initialWindow.minimizable.toString() + "\" for application/initialWindow/minimizable.");
            }
            if (["", "true", "false", "1", "0"].indexOf(m_xml.initialWindow.maximizable.toString()) == -1)
            {
                throw new Error("Illegal value \"" + m_xml.initialWindow.maximizable.toString() + "\" for application/initialWindow/maximizable.");
            }
            if (["", "true", "false", "1", "0"].indexOf(m_xml.initialWindow.resizable.toString()) == -1)
            {
                throw new Error("Illegal value \"" + m_xml.initialWindow.resizable.toString() + "\" for application/initialWindow/resizeable.");
            }
            if (["", "true", "false", "1", "0"].indexOf(m_xml.initialWindow.closeable.toString()) == -1)
            {
                throw new Error("Illegal value \"" + m_xml.initialWindow.closeable.toString() + "\" for application/initialWindow/closeable.");
            }
            if (initialWindowTransparent && initialWindowSystemChrome != NativeWindowSystemChrome.NONE)
            {
                throw new Error("Illegal window settings.  Transparent windows are only supported when systemChrome is set to \"none\".");
            }
            if (!validateDimension(m_xml.initialWindow.width.toString()))
            {
                throw new Error("Illegal value \"" + m_xml.initialWindow.width.toString() + "\" for application/initialWindow/width.");
            }
            if (!validateDimension(m_xml.initialWindow.height.toString()))
            {
                throw new Error("Illegal value \"" + m_xml.initialWindow.height.toString() + "\" for application/initialWindow/height.");
            }
            if (!validateLocation(m_xml.initialWindow.x.toString()))
            {
                throw new Error("Illegal value \"" + m_xml.initialWindow.x.toString() + "\" for application/initialWindow/x.");
            }
            if (!validateLocation(m_xml.initialWindow.y.toString()))
            {
                throw new Error("Illegal value \"" + m_xml.initialWindow.y.toString() + "\" for application/initialWindow/y.");
            }
            if (!validateDimensionPair(m_xml.initialWindow.minSize.toString()))
            {
                throw new Error("Illegal value \"" + m_xml.initialWindow.minSize.toString() + "\" for application/initialWindow/minSize.");
            }
            if (!validateDimensionPair(m_xml.initialWindow.maxSize.toString()))
            {
                throw new Error("Illegal value \"" + m_xml.initialWindow.maxSize.toString() + "\" for application/initialWindow/maxSize.");
            }
            if (!validateLocalizedText(m_xml.name, m_defaultNs))
            {
                throw new Error("Illegal values for application/name.");
            }
            if (!validateLocalizedText(m_xml.description, m_defaultNs))
            {
                throw new Error("Illegal values for application/description.");
            }
            if (!/^[A-Za-z0-9\-\.]{1,212}$/.test(id))
            {
                throw new Error("invalid application identifier");
            }
            return;
        }// end function

        public function get version() : String
        {
            default xml namespace = m_defaultNs;
            return m_xml.version.toString();
        }// end function

        public function get namespace() : Namespace
        {
            default xml namespace = m_defaultNs;
            return m_xml.namespace();
        }// end function

        public function get fileTypes() : XMLList
        {
            default xml namespace = m_defaultNs;
            return m_xml.fileTypes.elements();
        }// end function

        public function get initialWindowCloseable() : Boolean
        {
            default xml namespace = m_defaultNs;
            return stringToBoolean_defaultTrue(m_xml.initialWindow.closeable.toString());
        }// end function

        public function get initialWindowMaximizable() : Boolean
        {
            default xml namespace = m_defaultNs;
            return stringToBoolean_defaultTrue(m_xml.initialWindow.maximizable.toString());
        }// end function

        public function get programMenuFolder() : String
        {
            default xml namespace = m_defaultNs;
            return m_xml.programMenuFolder.toString();
        }// end function

        public function get initialWindowHeight() : Number
        {
            default xml namespace = m_defaultNs;
            return convertDimension(m_xml.initialWindow.height.toString());
        }// end function

        public function get initialWindowTitle() : String
        {
            default xml namespace = m_defaultNs;
            var _loc_1:* = m_xml.initialWindow.title.toString();
            if (_loc_1 == "")
            {
                _loc_1 = name;
            }
            return _loc_1;
        }// end function

        private function stringToBoolean_defaultFalse(param1:String) : Boolean
        {
            default xml namespace = m_defaultNs;
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

        public function hasCustomUpdateUI() : Boolean
        {
            default xml namespace = m_defaultNs;
            return stringToBoolean_defaultFalse(m_xml.customUpdateUI.toString());
        }// end function

        public function get installFolder() : String
        {
            default xml namespace = m_defaultNs;
            return m_xml.installFolder.toString();
        }// end function

        public function get id() : String
        {
            default xml namespace = m_defaultNs;
            return m_xml.id.toString();
        }// end function

        public function get initialWindowTransparent() : Boolean
        {
            default xml namespace = m_defaultNs;
            return stringToBoolean_defaultFalse(m_xml.initialWindow.transparent.toString());
        }// end function

        public function getIcon(param1:String) : String
        {
            default xml namespace = m_defaultNs;
            return m_xml.icon.elements(new QName(m_defaultNs, param1)).toString();
        }// end function

        public function get initialWindowResizable() : Boolean
        {
            default xml namespace = m_defaultNs;
            return stringToBoolean_defaultTrue(m_xml.initialWindow.resizable.toString());
        }// end function

        public function get description() : String
        {
            default xml namespace = m_defaultNs;
            return m_description;
        }// end function

        public function get initialWindowSystemChrome() : String
        {
            default xml namespace = m_defaultNs;
            var _loc_1:* = m_xml.initialWindow.systemChrome.toString();
            var _loc_2:* = NativeWindowSystemChrome.STANDARD;
            switch(_loc_1)
            {
                case NativeWindowSystemChrome.STANDARD:
                case NativeWindowSystemChrome.NONE:
                {
                    _loc_2 = _loc_1;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function get initialWindowVisible() : Boolean
        {
            default xml namespace = m_defaultNs;
            return stringToBoolean_defaultFalse(m_xml.initialWindow.visible.toString());
        }// end function

        public function get initialWindowMinSize() : Point
        {
            default xml namespace = m_defaultNs;
            return convertDimensionPoint(m_xml.initialWindow.minSize.toString());
        }// end function

        private static function validateDimension(param1:String) : Boolean
        {
            var dimensionNumber:Number;
            var dimensionString:* = param1;
            default xml namespace = result;
            var result:Boolean;
            if (dimensionString.length > 0)
            {
                try
                {
                    dimensionNumber = Number(dimensionString);
                    if (dimensionNumber >= 0)
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

        private static function convertDimension(param1:String) : Number
        {
            var _loc_3:uint = 0;
            default xml namespace = _loc_2;
            var _loc_2:Number = -1;
            if (param1.length > 0)
            {
                _loc_3 = uint(param1);
                _loc_2 = Number(_loc_3);
            }
            return _loc_2;
        }// end function

        private static function convertLocation(param1:String) : Number
        {
            var _loc_3:int = 0;
            default xml namespace = _loc_2;
            var _loc_2:Number = -1;
            if (param1.length > 0)
            {
                _loc_3 = int(param1);
                _loc_2 = Number(_loc_3);
            }
            return _loc_2;
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
                
                if (_loc_5.name() == null || _loc_5.name().localName != "text")
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

        private static function validateDimensionPair(param1:String) : Boolean
        {
            var _loc_3:Point = null;
            default xml namespace = _loc_2;
            var _loc_2:Boolean = false;
            if (param1.length > 0)
            {
                _loc_3 = convertDimensionPoint(param1);
                if (_loc_3 != null && _loc_3.x != -1 && _loc_3.y != -1)
                {
                    _loc_2 = true;
                }
            }
            else
            {
                _loc_2 = true;
            }
            return _loc_2;
        }// end function

        private static function validateLocation(param1:String) : Boolean
        {
            var dimensionNumber:Number;
            var inputString:* = param1;
            default xml namespace = result;
            var result:Boolean;
            if (inputString.length > 0)
            {
                try
                {
                    dimensionNumber = Number(inputString);
                    if (!isNaN(dimensionNumber))
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

        private static function convertDimensionPoint(param1:String) : Point
        {
            var list:Array;
            var x:Number;
            var y:Number;
            var pt:Point;
            var dimensionString:* = param1;
            default xml namespace = result;
            var result:Point;
            if (dimensionString.length > 0)
            {
                try
                {
                    list = dimensionString.split(/ +/);
                    if (list.length == 2)
                    {
                        x = convertDimension(String(list[0]));
                        y = convertDimension(String(list[1]));
                        pt = new Point();
                        pt.x = x;
                        pt.y = y;
                        result = pt;
                    }
                }
                catch (e:Error)
                {
                    result;
                }
            }
            return result;
        }// end function

    }
}
