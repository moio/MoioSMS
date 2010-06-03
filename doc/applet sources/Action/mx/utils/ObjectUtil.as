package mx.utils
{
    import flash.utils.*;
    import flash.xml.*;
    import mx.collections.*;

    public class ObjectUtil extends Object
    {
        private static var defaultToStringExcludes:Array = ["password", "credentials"];
        private static var CLASS_INFO_CACHE:Object = {};
        private static var refCount:int = 0;
        static const VERSION:String = "3.2.0.3958";

        public function ObjectUtil()
        {
            return;
        }// end function

        public static function isSimple(param1:Object) : Boolean
        {
            var _loc_2:* = typeof(param1);
            switch(_loc_2)
            {
                case "number":
                case "string":
                case "boolean":
                {
                    return true;
                }
                case "object":
                {
                    if (!(param1 is Date))
                    {
                    }
                    return param1 is Array;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        private static function internalToString(param1:Object, param2:int = 0, param3:Dictionary = null, param4:Array = null, param5:Array = null) : String
        {
            var str:String;
            var classInfo:Object;
            var properties:Array;
            var id:Object;
            var isArray:Boolean;
            var isDict:Boolean;
            var prop:*;
            var j:int;
            var value:* = param1;
            var indent:* = param2;
            var refs:* = param3;
            var namespaceURIs:* = param4;
            var exclude:* = param5;
            var type:* = value == null ? ("null") : (typeof(value));
            switch(type)
            {
                case "boolean":
                case "number":
                {
                    return value.toString();
                }
                case "string":
                {
                    return "\"" + value.toString() + "\"";
                }
                case "object":
                {
                    if (value is Date)
                    {
                        return value.toString();
                    }
                    if (value is XMLNode)
                    {
                        return value.toString();
                    }
                    if (value is Class)
                    {
                        return "(" + getQualifiedClassName(value) + ")";
                    }
                    classInfo = getClassInfo(value, exclude, {includeReadOnly:true, uris:namespaceURIs});
                    properties = classInfo.properties;
                    str = "(" + classInfo.name + ")";
                    if (refs == null)
                    {
                        refs = new Dictionary(true);
                    }
                    id = refs[value];
                    if (id != null)
                    {
                        str = str + ("#" + int(id));
                        return str;
                    }
                    if (value != null)
                    {
                        str = str + ("#" + refCount.toString());
                        refs[value] = refCount;
                        refCount++;
                    }
                    isArray = value is Array;
                    isDict = value is Dictionary;
                    indent = indent + 2;
                    j;
                    while (j < properties.length)
                    {
                        
                        str = newline(str, indent);
                        prop = properties[j];
                        if (isArray)
                        {
                            str = str + "[";
                        }
                        else if (isDict)
                        {
                            str = str + "{";
                        }
                        if (isDict)
                        {
                            str = str + internalToString(prop, indent, refs, namespaceURIs, exclude);
                        }
                        else
                        {
                            str = str + prop.toString();
                        }
                        if (isArray)
                        {
                            str = str + "] ";
                        }
                        else if (isDict)
                        {
                            str = str + "} = ";
                        }
                        else
                        {
                            str = str + " = ";
                        }
                        try
                        {
                            str = str + internalToString(value[prop], indent, refs, namespaceURIs, exclude);
                        }
                        catch (e:Error)
                        {
                            str = str + "?";
                        }
                        j = j++;
                    }
                    indent = indent - 2;
                    return str;
                }
                case "xml":
                {
                    return value.toString();
                }
                default:
                {
                    return "(" + type + ")";
                    break;
                }
            }
        }// end function

        public static function getClassInfo(param1:Object, param2:Array = null, param3:Object = null) : Object
        {
            var n:int;
            var i:int;
            var result:Object;
            var cacheKey:String;
            var className:String;
            var classAlias:String;
            var properties:XMLList;
            var prop:XML;
            var metadataInfo:Object;
            var classInfo:XML;
            var numericIndex:Boolean;
            var key:*;
            var p:String;
            var pi:Number;
            var uris:Array;
            var uri:String;
            var qName:QName;
            var j:int;
            var obj:* = param1;
            var excludes:* = param2;
            var options:* = param3;
            if (obj is ObjectProxy)
            {
                obj = object_proxy::object;
            }
            if (options == null)
            {
                options;
            }
            var propertyNames:Array;
            var dynamic:Boolean;
            if (typeof(obj) == "xml")
            {
                className;
                properties = obj.text();
                if (properties.length())
                {
                    propertyNames.push("*");
                }
                properties = obj.attributes();
            }
            else
            {
                classInfo = DescribeTypeCache.describeType(obj).typeDescription;
                className = classInfo.@name.toString();
                classAlias = classInfo.@alias.toString();
                dynamic = classInfo.@isDynamic.toString() == "true";
                if (options.includeReadOnly)
                {
                    var _loc_6:int = 0;
                    var _loc_7:* = classInfo..accessor;
                    var _loc_5:* = new XMLList("");
                    for each (_loc_8 in _loc_7)
                    {
                        
                        var _loc_9:* = _loc_7[_loc_6];
                        with (_loc_7[_loc_6])
                        {
                            if (@access != "writeonly")
                            {
                                _loc_5[_loc_6] = _loc_8;
                            }
                        }
                    }
                    properties = _loc_5 + classInfo..variable;
                }
                else
                {
                    var _loc_6:int = 0;
                    var _loc_7:* = classInfo..accessor;
                    var _loc_5:* = new XMLList("");
                    for each (_loc_8 in _loc_7)
                    {
                        
                        var _loc_9:* = _loc_7[_loc_6];
                        with (_loc_7[_loc_6])
                        {
                            if (@access == "readwrite")
                            {
                                _loc_5[_loc_6] = _loc_8;
                            }
                        }
                    }
                    properties = _loc_5 + classInfo..variable;
                }
                numericIndex;
            }
            if (!dynamic)
            {
                cacheKey = getCacheKey(obj, excludes, options);
                result = CLASS_INFO_CACHE[cacheKey];
                if (result != null)
                {
                    return result;
                }
            }
            result;
            result["name"] = className;
            result["alias"] = classAlias;
            result["properties"] = propertyNames;
            result["dynamic"] = dynamic;
            var _loc_5:* = recordMetadata(properties);
            metadataInfo = recordMetadata(properties);
            result["metadata"] = _loc_5;
            var excludeObject:Object;
            if (excludes)
            {
                n = excludes.length;
                i;
                while (i < n)
                {
                    
                    excludeObject[excludes[i]] = 1;
                    i = i++;
                }
            }
            var isArray:* = className == "Array";
            var isDict:* = className == "flash.utils::Dictionary";
            if (isDict)
            {
                var _loc_5:int = 0;
                var _loc_6:* = obj;
                while (_loc_6 in _loc_5)
                {
                    
                    key = _loc_6[_loc_5];
                    propertyNames.push(key);
                }
            }
            else if (dynamic)
            {
                var _loc_5:int = 0;
                var _loc_6:* = obj;
                while (_loc_6 in _loc_5)
                {
                    
                    p = _loc_6[_loc_5];
                    if (excludeObject[p] != 1)
                    {
                        if (isArray)
                        {
                            pi = parseInt(p);
                            if (isNaN(pi))
                            {
                                propertyNames.push(new QName("", p));
                            }
                            else
                            {
                                propertyNames.push(pi);
                            }
                            continue;
                        }
                        propertyNames.push(new QName("", p));
                    }
                }
                if (isArray)
                {
                }
                numericIndex = !isNaN(Number(p));
            }
            if (isArray || isDict || className == "Object")
            {
            }
            else if (className == "XML")
            {
                n = properties.length();
                i;
                while (i < n)
                {
                    
                    p = properties[i].name();
                    if (excludeObject[p] != 1)
                    {
                        propertyNames.push(new QName("", "@" + p));
                    }
                    i = i++;
                }
            }
            else
            {
                n = properties.length();
                uris = options.uris;
                i;
                while (i < n)
                {
                    
                    prop = properties[i];
                    p = prop.@name.toString();
                    uri = prop.@uri.toString();
                    if (excludeObject[p] == 1)
                    {
                    }
                    else if (!options.includeTransient && internalHasMetadata(metadataInfo, p, "Transient"))
                    {
                    }
                    else if (uris != null)
                    {
                        if (uris.length == 1 && uris[0] == "*")
                        {
                            qName = new QName(uri, p);
                            try
                            {
                                propertyNames.push();
                            }
                            catch (e:Error)
                            {
                            }
                        }
                        else
                        {
                            j;
                            while (j < uris.length)
                            {
                                
                                uri = uris[j];
                                if (prop.@uri.toString() == uri)
                                {
                                    qName = new QName(uri, p);
                                    try
                                    {
                                        propertyNames.push(qName);
                                    }
                                    catch (e:Error)
                                    {
                                    }
                                }
                                j = j++;
                            }
                        }
                    }
                    else if (uri.length == 0)
                    {
                        qName = new QName(uri, p);
                        try
                        {
                            propertyNames.push(qName);
                        }
                        catch (e:Error)
                        {
                        }
                    }
                    i = i++;
                }
            }
            propertyNames.sort(Array.CASEINSENSITIVE | (numericIndex ? (Array.NUMERIC) : (0)));
            if (!isDict)
            {
                i;
                while (i < propertyNames.length--)
                {
                    
                    if (propertyNames[i].toString() == propertyNames[i + 1].toString())
                    {
                        propertyNames.splice(i, 1);
                        i = i--;
                    }
                    i = i++;
                }
            }
            if (!dynamic)
            {
                cacheKey = getCacheKey(obj, excludes, options);
                CLASS_INFO_CACHE[cacheKey] = result;
            }
            return result;
        }// end function

        private static function arrayCompare(param1:Array, param2:Array, param3:int, param4:int, param5:Dictionary) : int
        {
            var _loc_7:Object = null;
            var _loc_6:int = 0;
            if (param1.length != param2.length)
            {
                if (param1.length < param2.length)
                {
                    _loc_6 = -1;
                }
                else
                {
                    _loc_6 = 1;
                }
            }
            else
            {
                for (_loc_7 in param1)
                {
                    
                    if (param2.hasOwnProperty(_loc_7))
                    {
                        _loc_6 = internalCompare(param1[_loc_7], param2[_loc_7], param3, param4, param5);
                        if (_loc_6 != 0)
                        {
                            return _loc_6;
                        }
                        continue;
                    }
                    return -1;
                }
                for (_loc_7 in param2)
                {
                    
                    if (!param1.hasOwnProperty(_loc_7))
                    {
                        return 1;
                    }
                }
            }
            return _loc_6;
        }// end function

        public static function stringCompare(param1:String, param2:String, param3:Boolean = false) : int
        {
            if (param1 == null && param2 == null)
            {
                return 0;
            }
            if (param1 == null)
            {
                return 1;
            }
            if (param2 == null)
            {
                return -1;
            }
            if (param3)
            {
                param1 = param1.toLocaleLowerCase();
                param2 = param2.toLocaleLowerCase();
            }
            var _loc_4:* = param1.localeCompare(param2);
            if (param1.localeCompare(param2) < -1)
            {
                _loc_4 = -1;
            }
            else if (_loc_4 > 1)
            {
                _loc_4 = 1;
            }
            return _loc_4;
        }// end function

        public static function dateCompare(param1:Date, param2:Date) : int
        {
            if (param1 == null && param2 == null)
            {
                return 0;
            }
            if (param1 == null)
            {
                return 1;
            }
            if (param2 == null)
            {
                return -1;
            }
            var _loc_3:* = param1.getTime();
            var _loc_4:* = param2.getTime();
            if (_loc_3 < _loc_4)
            {
                return -1;
            }
            if (_loc_3 > _loc_4)
            {
                return 1;
            }
            return 0;
        }// end function

        public static function numericCompare(param1:Number, param2:Number) : int
        {
            if (isNaN(param1) && isNaN(param2))
            {
                return 0;
            }
            if (isNaN(param1))
            {
                return 1;
            }
            if (isNaN(param2))
            {
                return -1;
            }
            if (param1 < param2)
            {
                return -1;
            }
            if (param1 > param2)
            {
                return 1;
            }
            return 0;
        }// end function

        private static function newline(param1:String, param2:int = 0) : String
        {
            var _loc_3:* = param1;
            _loc_3 = _loc_3 + "\n";
            var _loc_4:int = 0;
            while (_loc_4 < param2)
            {
                
                _loc_3 = _loc_3 + " ";
                _loc_4++;
            }
            return _loc_3;
        }// end function

        private static function recordMetadata(param1:XMLList) : Object
        {
            var prop:XML;
            var propName:String;
            var metadataList:XMLList;
            var metadata:Object;
            var md:XML;
            var mdName:String;
            var argsList:XMLList;
            var value:Object;
            var arg:XML;
            var existing:Object;
            var argKey:String;
            var argValue:String;
            var existingArray:Array;
            var properties:* = param1;
            var result:Object;
            try
            {
                var _loc_3:int = 0;
                var _loc_4:* = properties;
                while (_loc_4 in _loc_3)
                {
                    
                    prop = _loc_4[_loc_3];
                    propName = prop.attribute("name").toString();
                    metadataList = prop.metadata;
                    if (metadataList.length() > 0)
                    {
                        if (result == null)
                        {
                            result;
                        }
                        metadata;
                        result[propName] = metadata;
                        var _loc_5:int = 0;
                        var _loc_6:* = metadataList;
                        while (_loc_6 in _loc_5)
                        {
                            
                            md = _loc_6[_loc_5];
                            mdName = md.attribute("name").toString();
                            argsList = md.arg;
                            value;
                            var _loc_7:int = 0;
                            var _loc_8:* = argsList;
                            while (_loc_8 in _loc_7)
                            {
                                
                                arg = _loc_8[_loc_7];
                                argKey = arg.attribute("key").toString();
                                if (argKey != null)
                                {
                                    argValue = arg.attribute("value").toString();
                                    value[argKey] = argValue;
                                }
                            }
                            existing = metadata[mdName];
                            if (existing != null)
                            {
                                if (existing is Array)
                                {
                                    existingArray = existing as Array;
                                }
                                else
                                {
                                    existingArray;
                                }
                                existingArray.push(value);
                                existing = existingArray;
                            }
                            else
                            {
                                existing = value;
                            }
                            metadata[mdName] = existing;
                        }
                    }
                }
            }
            catch (e:Error)
            {
            }
            return result;
        }// end function

        public static function compare(param1:Object, param2:Object, param3:int = -1) : int
        {
            return internalCompare(param1, param2, 0, param3, new Dictionary(true));
        }// end function

        private static function listCompare(param1:IList, param2:IList, param3:int, param4:int, param5:Dictionary) : int
        {
            var _loc_7:int = 0;
            var _loc_6:int = 0;
            if (param1.length != param2.length)
            {
                if (param1.length < param2.length)
                {
                    _loc_6 = -1;
                }
                else
                {
                    _loc_6 = 1;
                }
            }
            else
            {
                _loc_7 = 0;
                while (_loc_7 < param1.length)
                {
                    
                    _loc_6 = internalCompare(param1.getItemAt(_loc_7), param2.getItemAt(_loc_7), param3 + 1, param4, param5);
                    if (_loc_6 != 0)
                    {
                        _loc_7 = param1.length;
                    }
                    _loc_7++;
                }
            }
            return _loc_6;
        }// end function

        private static function internalCompare(param1:Object, param2:Object, param3:int, param4:int, param5:Dictionary) : int
        {
            var _loc_9:int = 0;
            var _loc_10:Boolean = false;
            var _loc_11:Boolean = false;
            var _loc_12:Array = null;
            var _loc_13:Array = null;
            var _loc_14:QName = null;
            var _loc_15:Object = null;
            var _loc_16:Object = null;
            var _loc_17:int = 0;
            if (param1 == null && param2 == null)
            {
                return 0;
            }
            if (param1 == null)
            {
                return 1;
            }
            if (param2 == null)
            {
                return -1;
            }
            if (param1 is ObjectProxy)
            {
                param1 = object_proxy::object;
            }
            if (param2 is ObjectProxy)
            {
                param2 = object_proxy::object;
            }
            var _loc_6:* = typeof(param1);
            var _loc_7:* = typeof(param2);
            var _loc_8:int = 0;
            if (_loc_6 == _loc_7)
            {
                switch(_loc_6)
                {
                    case "boolean":
                    {
                        _loc_8 = numericCompare(Number(param1), Number(param2));
                        break;
                    }
                    case "number":
                    {
                        _loc_8 = numericCompare(param1 as Number, param2 as Number);
                        break;
                    }
                    case "string":
                    {
                        _loc_8 = stringCompare(param1 as String, param2 as String);
                        break;
                    }
                    case "object":
                    {
                        _loc_9 = param4 > 0 ? (param4--) : (param4);
                        _loc_10 = param5[param1];
                        _loc_11 = param5[param2];
                        if (_loc_10 && !_loc_11)
                        {
                            return 1;
                        }
                        if (_loc_11 && !_loc_10)
                        {
                            return -1;
                        }
                        if (_loc_11 && _loc_10)
                        {
                            return 0;
                        }
                        param5[param1] = true;
                        param5[param2] = true;
                        if (param4 != -1 && param3 > param4)
                        {
                            _loc_8 = stringCompare(param1.toString(), param2.toString());
                        }
                        else if (param1 is Array && param2 is Array)
                        {
                            _loc_8 = arrayCompare(param1 as Array, param2 as Array, param3, param4, param5);
                        }
                        else if (param1 is Date && param2 is Date)
                        {
                            _loc_8 = dateCompare(param1 as Date, param2 as Date);
                        }
                        else if (param1 is IList && param2 is IList)
                        {
                            _loc_8 = listCompare(param1 as IList, param2 as IList, param3, param4, param5);
                        }
                        else if (param1 is ByteArray && param2 is ByteArray)
                        {
                            _loc_8 = byteArrayCompare(param1 as ByteArray, param2 as ByteArray);
                        }
                        else if (getQualifiedClassName(param1) == getQualifiedClassName(param2))
                        {
                            _loc_12 = getClassInfo(param1).properties;
                            if (getQualifiedClassName(param1) == "Object")
                            {
                                _loc_13 = getClassInfo(param2).properties;
                                _loc_8 = arrayCompare(_loc_12, _loc_13, param3, _loc_9, param5);
                            }
                            if (_loc_8 != 0)
                            {
                                return _loc_8;
                            }
                            _loc_17 = 0;
                            while (_loc_17 < _loc_12.length)
                            {
                                
                                _loc_14 = _loc_12[_loc_17];
                                _loc_15 = param1[_loc_14];
                                _loc_16 = param2[_loc_14];
                                _loc_8 = internalCompare(_loc_15, _loc_16, param3 + 1, _loc_9, param5);
                                if (_loc_8 != 0)
                                {
                                    _loc_17 = _loc_12.length;
                                }
                                _loc_17++;
                            }
                        }
                        else
                        {
                            return 1;
                        }
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            else
            {
                return stringCompare(_loc_6, _loc_7);
            }
            return _loc_8;
        }// end function

        public static function hasMetadata(param1:Object, param2:String, param3:String, param4:Array = null, param5:Object = null) : Boolean
        {
            var _loc_6:* = getClassInfo(param1, param4, param5);
            var _loc_7:* = getClassInfo(param1, param4, param5)["metadata"];
            return internalHasMetadata(_loc_7, param2, param3);
        }// end function

        private static function internalHasMetadata(param1:Object, param2:String, param3:String) : Boolean
        {
            var _loc_4:Object = null;
            if (param1 != null)
            {
                _loc_4 = param1[param2];
                if (_loc_4 != null)
                {
                    if (_loc_4[param3] != null)
                    {
                        return true;
                    }
                }
            }
            return false;
        }// end function

        public static function toString(param1:Object, param2:Array = null, param3:Array = null) : String
        {
            if (param3 == null)
            {
                param3 = defaultToStringExcludes;
            }
            refCount = 0;
            return internalToString(param1, 0, null, param2, param3);
        }// end function

        private static function byteArrayCompare(param1:ByteArray, param2:ByteArray) : int
        {
            var _loc_4:int = 0;
            var _loc_3:int = 0;
            if (param1.length != param2.length)
            {
                if (param1.length < param2.length)
                {
                    _loc_3 = -1;
                }
                else
                {
                    _loc_3 = 1;
                }
            }
            else
            {
                param1.position = 0;
                param2.position = 0;
                _loc_4 = 0;
                while (_loc_4 < param1.length)
                {
                    
                    _loc_3 = numericCompare(param1.readByte(), param2.readByte());
                    if (_loc_3 != 0)
                    {
                        _loc_4 = param1.length;
                    }
                    _loc_4++;
                }
            }
            return _loc_3;
        }// end function

        public static function copy(param1:Object) : Object
        {
            var _loc_2:* = new ByteArray();
            _loc_2.writeObject(param1);
            _loc_2.position = 0;
            var _loc_3:* = _loc_2.readObject();
            return _loc_3;
        }// end function

        private static function getCacheKey(param1:Object, param2:Array = null, param3:Object = null) : String
        {
            var _loc_5:uint = 0;
            var _loc_6:String = null;
            var _loc_7:String = null;
            var _loc_8:String = null;
            var _loc_4:* = getQualifiedClassName(param1);
            if (param2 != null)
            {
                _loc_5 = 0;
                while (_loc_5++ < param2.length)
                {
                    
                    _loc_6 = param2[_loc_5] as String;
                    if (_loc_6 != null)
                    {
                        _loc_4 = _loc_4 + _loc_6;
                    }
                }
            }
            if (param3 != null)
            {
                for (_loc_7 in param3)
                {
                    
                    _loc_4 = _loc_4 + _loc_7;
                    _loc_8 = param3[_loc_7] as String;
                    if (_loc_8 != null)
                    {
                        _loc_4 = _loc_4 + _loc_8;
                    }
                }
            }
            return _loc_4;
        }// end function

    }
}
