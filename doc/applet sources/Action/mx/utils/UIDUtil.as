package mx.utils
{
    import flash.utils.*;
    import mx.core.*;

    public class UIDUtil extends Object
    {
        private static var uidDictionary:Dictionary = new Dictionary(true);
        static const VERSION:String = "3.2.0.3958";
        private static const ALPHA_CHAR_CODES:Array = [48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 65, 66, 67, 68, 69, 70];

        public function UIDUtil()
        {
            return;
        }// end function

        public static function fromByteArray(param1:ByteArray) : String
        {
            var _loc_2:Array = null;
            var _loc_3:uint = 0;
            var _loc_4:uint = 0;
            var _loc_5:int = 0;
            if (param1 != null && param1.length >= 16 && param1.bytesAvailable >= 16)
            {
                _loc_2 = new Array(36);
                _loc_3 = 0;
                _loc_4 = 0;
                while (_loc_4++ < 16)
                {
                    
                    if (_loc_4 == 4 || _loc_4 == 6 || _loc_4 == 8 || _loc_4 == 10)
                    {
                        _loc_2[++_loc_3] = 45;
                    }
                    _loc_5 = param1.readByte();
                    _loc_2[++_loc_3] = ALPHA_CHAR_CODES[(_loc_5 & 240) >>> 4];
                    _loc_2[++_loc_3] = ALPHA_CHAR_CODES[_loc_5 & 15];
                }
                return String.fromCharCode.apply(null, _loc_2);
            }
            return null;
        }// end function

        public static function isUID(param1:String) : Boolean
        {
            var _loc_2:uint = 0;
            var _loc_3:Number = NaN;
            if (param1 != null && param1.length == 36)
            {
                _loc_2 = 0;
                while (_loc_2++ < 36)
                {
                    
                    _loc_3 = param1.charCodeAt(_loc_2);
                    if (_loc_2 == 8 || _loc_2 == 13 || _loc_2 == 18 || _loc_2 == 23)
                    {
                        if (_loc_3 != 45)
                        {
                            return false;
                        }
                        continue;
                    }
                    if (_loc_3 < 48 || _loc_3 > 70 || _loc_3 > 57 && _loc_3 < 65)
                    {
                        return false;
                    }
                }
                return true;
            }
            return false;
        }// end function

        public static function createUID() : String
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_1:* = new Array(36);
            var _loc_2:int = 0;
            _loc_3 = 0;
            while (_loc_3 < 8)
            {
                
                _loc_1[++_loc_2] = ALPHA_CHAR_CODES[Math.floor(Math.random() * 16)];
                _loc_3++;
            }
            _loc_3 = 0;
            while (_loc_3 < 3)
            {
                
                _loc_1[++_loc_2] = 45;
                _loc_4 = 0;
                while (_loc_4 < 4)
                {
                    
                    _loc_1[++_loc_2] = ALPHA_CHAR_CODES[Math.floor(Math.random() * 16)];
                    _loc_4++;
                }
                _loc_3++;
            }
            _loc_1[++_loc_2] = 45;
            var _loc_5:* = new Date().getTime();
            var _loc_6:* = ("0000000" + _loc_5.toString(16).toUpperCase()).substr(-8);
            _loc_3 = 0;
            while (_loc_3 < 8)
            {
                
                _loc_1[++_loc_2] = _loc_6.charCodeAt(_loc_3);
                _loc_3++;
            }
            _loc_3 = 0;
            while (_loc_3 < 4)
            {
                
                _loc_1[++_loc_2] = ALPHA_CHAR_CODES[Math.floor(Math.random() * 16)];
                _loc_3++;
            }
            return String.fromCharCode.apply(null, _loc_1);
        }// end function

        public static function toByteArray(param1:String) : ByteArray
        {
            var _loc_2:ByteArray = null;
            var _loc_3:uint = 0;
            var _loc_4:String = null;
            var _loc_5:uint = 0;
            var _loc_6:uint = 0;
            if (isUID(param1))
            {
                _loc_2 = new ByteArray();
                _loc_3 = 0;
                while (_loc_3++ < param1.length)
                {
                    
                    _loc_4 = param1.charAt(_loc_3);
                    if (_loc_4 == "-")
                    {
                        continue;
                    }
                    _loc_5 = getDigit(_loc_4);
                    _loc_6 = getDigit(param1.charAt(_loc_3++));
                    _loc_2.writeByte((_loc_5 << 4 | _loc_6) & 255);
                }
                _loc_2.position = 0;
                return _loc_2;
            }
            return null;
        }// end function

        private static function getDigit(param1:String) : uint
        {
            switch(param1)
            {
                case "A":
                case "a":
                {
                    return 10;
                }
                case "B":
                case "b":
                {
                    return 11;
                }
                case "C":
                case "c":
                {
                    return 12;
                }
                case "D":
                case "d":
                {
                    return 13;
                }
                case "E":
                case "e":
                {
                    return 14;
                }
                case "F":
                case "f":
                {
                    return 15;
                }
                default:
                {
                    return new uint(param1);
                    break;
                }
            }
        }// end function

        public static function getUID(param1:Object) : String
        {
            var result:String;
            var xitem:XML;
            var nodeKind:String;
            var notificationFunction:Function;
            var item:* = param1;
            result;
            if (item == null)
            {
                return result;
            }
            if (item is IUID)
            {
                result = IUID(item).uid;
                if (result == null || result.length == 0)
                {
                    result = createUID();
                    IUID(item).uid = result;
                }
            }
            else if (item is IPropertyChangeNotifier && !(item is IUIComponent))
            {
                result = IPropertyChangeNotifier(item).uid;
                if (result == null || result.length == 0)
                {
                    result = createUID();
                    IPropertyChangeNotifier(item).uid = result;
                }
            }
            else
            {
                if (item is String)
                {
                    return item as String;
                }
                if (item is XMLList && item.length == 1)
                {
                    item = item[0];
                }
                if (item is XML)
                {
                    xitem = XML(item);
                    nodeKind = xitem.nodeKind();
                    if (nodeKind == "text" || nodeKind == "attribute")
                    {
                        return xitem.toString();
                    }
                    notificationFunction = xitem.notification();
                    if (!(notificationFunction is Function))
                    {
                        notificationFunction = XMLNotifier.initializeXMLForNotification();
                        xitem.setNotification(notificationFunction);
                    }
                    if (notificationFunction["uid"] == undefined)
                    {
                        var _loc_3:* = createUID();
                        notificationFunction["uid"] = createUID();
                        result = _loc_3;
                    }
                    result = notificationFunction["uid"];
                }
                else
                {
                    if ("mx_internal_uid" in item)
                    {
                        return item.mx_internal_uid;
                    }
                    if ("uid" in item)
                    {
                        return item.uid;
                    }
                    result = uidDictionary[item];
                    if (!result)
                    {
                        result = createUID();
                        try
                        {
                            item.mx_internal_uid = result;
                        }
                        catch (e:Error)
                        {
                            uidDictionary[item] = result;
                        }
                    }
                }
                ;
                var _loc_3:* = new catch1;
                item;
                result = item.toString();
            }
            return result;
        }// end function

    }
}
