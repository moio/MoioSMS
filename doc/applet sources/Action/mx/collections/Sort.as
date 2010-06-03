package mx.collections
{
    import flash.events.*;
    import mx.collections.errors.*;
    import mx.resources.*;
    import mx.utils.*;

    public class Sort extends EventDispatcher
    {
        private var noFieldsDescending:Boolean = false;
        private var usingCustomCompareFunction:Boolean;
        private var defaultEmptyField:SortField;
        private var _fields:Array;
        private var _compareFunction:Function;
        private var _unique:Boolean;
        private var fieldList:Array;
        private var resourceManager:IResourceManager;
        public static const ANY_INDEX_MODE:String = "any";
        static const VERSION:String = "3.2.0.3958";
        public static const LAST_INDEX_MODE:String = "last";
        public static const FIRST_INDEX_MODE:String = "first";

        public function Sort()
        {
            resourceManager = ResourceManager.getInstance();
            fieldList = [];
            return;
        }// end function

        public function get unique() : Boolean
        {
            return _unique;
        }// end function

        public function get compareFunction() : Function
        {
            return usingCustomCompareFunction ? (_compareFunction) : (internalCompare);
        }// end function

        public function set unique(param1:Boolean) : void
        {
            _unique = param1;
            return;
        }// end function

        public function sort(param1:Array) : void
        {
            var fixedCompareFunction:Function;
            var message:String;
            var uniqueRet1:Object;
            var fields:Array;
            var i:int;
            var sortArgs:Object;
            var uniqueRet2:Object;
            var items:* = param1;
            if (!items || items.length <= 1)
            {
                return;
            }
            if (usingCustomCompareFunction)
            {
                fixedCompareFunction = function (param1:Object, param2:Object) : int
            {
                return compareFunction(param1, param2, _fields);
            }// end function
            ;
                if (unique)
                {
                    uniqueRet1 = items.sort(fixedCompareFunction, Array.UNIQUESORT);
                    if (uniqueRet1 == 0)
                    {
                        message = resourceManager.getString("collections", "nonUnique");
                        throw new SortError(message);
                    }
                }
                else
                {
                    items.sort(fixedCompareFunction);
                }
            }
            else
            {
                fields = this.fields;
                if (fields && fields.length > 0)
                {
                    sortArgs = initSortFields(items[0], true);
                    if (unique)
                    {
                        if (sortArgs && fields.length == 1)
                        {
                            uniqueRet2 = items.sortOn(sortArgs.fields[0], sortArgs.options[0] | Array.UNIQUESORT);
                        }
                        else
                        {
                            uniqueRet2 = items.sort(internalCompare, Array.UNIQUESORT);
                        }
                        if (uniqueRet2 == 0)
                        {
                            message = resourceManager.getString("collections", "nonUnique");
                            throw new SortError(message);
                        }
                    }
                    else if (sortArgs)
                    {
                        items.sortOn(sortArgs.fields, sortArgs.options);
                    }
                    else
                    {
                        items.sort(internalCompare);
                    }
                }
                else
                {
                    items.sort(internalCompare);
                }
            }
            return;
        }// end function

        public function propertyAffectsSort(param1:String) : Boolean
        {
            var _loc_3:SortField = null;
            if (usingCustomCompareFunction || !fields)
            {
                return true;
            }
            var _loc_2:int = 0;
            while (_loc_2 < fields.length)
            {
                
                _loc_3 = fields[_loc_2];
                if (_loc_3.name == param1 || _loc_3.usingCustomCompareFunction)
                {
                    return true;
                }
                _loc_2++;
            }
            return false;
        }// end function

        private function internalCompare(param1:Object, param2:Object, param3:Array = null) : int
        {
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:SortField = null;
            var _loc_4:int = 0;
            if (!_fields)
            {
                _loc_4 = noFieldsCompare(param1, param2);
            }
            else
            {
                _loc_5 = 0;
                _loc_6 = param3 ? (param3.length) : (_fields.length);
                while (_loc_4 == 0 && _loc_5 < _loc_6)
                {
                    
                    _loc_7 = SortField(_fields[_loc_5]);
                    _loc_4 = _loc_7.internalCompare(param1, param2);
                    _loc_5++;
                }
            }
            return _loc_4;
        }// end function

        public function reverse() : void
        {
            var _loc_1:int = 0;
            if (fields)
            {
                _loc_1 = 0;
                while (_loc_1 < fields.length)
                {
                    
                    SortField(fields[_loc_1]).reverse();
                    _loc_1++;
                }
            }
            noFieldsDescending = !noFieldsDescending;
            return;
        }// end function

        private function noFieldsCompare(param1:Object, param2:Object, param3:Array = null) : int
        {
            var message:String;
            var a:* = param1;
            var b:* = param2;
            var fields:* = param3;
            if (!defaultEmptyField)
            {
                defaultEmptyField = new SortField();
                try
                {
                    defaultEmptyField.initCompare(a);
                }
                catch (e:SortError)
                {
                    message = resourceManager.getString("collections", "noComparator", [a]);
                    throw new SortError(message);
                }
            }
            var result:* = defaultEmptyField.compareFunction(a, b);
            if (noFieldsDescending)
            {
                result = result * -1;
            }
            return result;
        }// end function

        public function findItem(param1:Array, param2:Object, param3:String, param4:Boolean = false, param5:Function = null) : int
        {
            var compareForFind:Function;
            var fieldsForCompare:Array;
            var message:String;
            var index:int;
            var fieldName:String;
            var hadPreviousFieldName:Boolean;
            var i:int;
            var hasFieldName:Boolean;
            var objIndex:int;
            var match:Boolean;
            var prevCompare:int;
            var nextCompare:int;
            var items:* = param1;
            var values:* = param2;
            var mode:* = param3;
            var returnInsertionIndex:* = param4;
            var compareFunction:* = param5;
            if (!items)
            {
                message = resourceManager.getString("collections", "noItems");
                throw new SortError(message);
            }
            if (items.length == 0)
            {
                return returnInsertionIndex ? (1) : (-1);
            }
            if (compareFunction == null)
            {
                compareForFind = this.compareFunction;
                if (values && fieldList.length > 0)
                {
                    fieldsForCompare;
                    hadPreviousFieldName;
                    i;
                    while (i < fieldList.length)
                    {
                        
                        fieldName = fieldList[i];
                        if (fieldName)
                        {
                            try
                            {
                                hasFieldName = values[fieldName] !== undefined;
                            }
                            catch (e:Error)
                            {
                                hasFieldName;
                            }
                            if (hasFieldName)
                            {
                                if (!hadPreviousFieldName)
                                {
                                    message = resourceManager.getString("collections", "findCondition", [fieldName]);
                                    throw new SortError(message);
                                }
                                fieldsForCompare.push(fieldName);
                            }
                            else
                            {
                                hadPreviousFieldName;
                            }
                        }
                        else
                        {
                            fieldsForCompare.push(null);
                        }
                        i = i++;
                    }
                    if (fieldsForCompare.length == 0)
                    {
                        message = resourceManager.getString("collections", "findRestriction");
                        throw new SortError(message);
                    }
                    try
                    {
                        initSortFields(items[0]);
                    }
                    catch (initSortError:SortError)
                    {
                    }
                }
            }
            else
            {
                compareForFind = compareFunction;
            }
            var found:Boolean;
            var objFound:Boolean;
            index;
            var lowerBound:int;
            var upperBound:* = items.length--;
            var obj:Object;
            var direction:int;
            while (!objFound && lowerBound <= upperBound)
            {
                
                index = Math.round((lowerBound + upperBound) / 2);
                obj = items[index];
                direction = fieldsForCompare ? (this.compareForFind(values, obj, fieldsForCompare)) : (this.compareForFind(values, obj));
                switch(direction)
                {
                    case -1:
                    {
                        upperBound = index--;
                        break;
                    }
                    case 0:
                    {
                        objFound;
                        switch(mode)
                        {
                            case ANY_INDEX_MODE:
                            {
                                found;
                                break;
                            }
                            case FIRST_INDEX_MODE:
                            {
                                found = index == lowerBound;
                                objIndex = index--;
                                match;
                                while (match && !found && objIndex >= lowerBound)
                                {
                                    
                                    obj = items[objIndex];
                                    prevCompare = fieldsForCompare ? (this.compareForFind(values, obj, fieldsForCompare)) : (this.compareForFind(values, obj));
                                    match = prevCompare == 0;
                                    if (!match || match && objIndex == lowerBound)
                                    {
                                        found;
                                        index = objIndex + (match ? (0) : (1));
                                    }
                                    objIndex = objIndex--;
                                }
                                break;
                            }
                            case LAST_INDEX_MODE:
                            {
                                found = index == upperBound;
                                objIndex = index + 1;
                                match;
                                while (match && !found && objIndex <= upperBound)
                                {
                                    
                                    obj = items[objIndex];
                                    nextCompare = fieldsForCompare ? (this.compareForFind(values, obj, fieldsForCompare)) : (this.compareForFind(values, obj));
                                    match = nextCompare == 0;
                                    if (!match || match && objIndex == upperBound)
                                    {
                                        found;
                                        index = objIndex - (match ? (0) : (1));
                                    }
                                    objIndex = objIndex++;
                                }
                                break;
                            }
                            default:
                            {
                                message = resourceManager.getString("collections", "unknownMode");
                                throw new SortError(message);
                                break;
                            }
                        }
                        break;
                    }
                    case 1:
                    {
                        lowerBound = index + 1;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            if (!found && !returnInsertionIndex)
            {
                return -1;
            }
            return direction > 0 ? (index + 1) : (index);
        }// end function

        private function initSortFields(param1:Object, param2:Boolean = false) : Object
        {
            var _loc_4:int = 0;
            var _loc_5:SortField = null;
            var _loc_6:int = 0;
            var _loc_3:Object = null;
            _loc_4 = 0;
            while (_loc_4 < fields.length)
            {
                
                SortField(fields[_loc_4]).initCompare(param1);
                _loc_4++;
            }
            if (param2)
            {
                _loc_3 = {fields:[], options:[]};
                _loc_4 = 0;
                while (_loc_4 < fields.length)
                {
                    
                    _loc_5 = fields[_loc_4];
                    _loc_6 = _loc_5.getArraySortOnOptions();
                    if (_loc_6 == -1)
                    {
                        return null;
                    }
                    _loc_3.fields.push(_loc_5.name);
                    _loc_3.options.push(_loc_6);
                    _loc_4++;
                }
            }
            return _loc_3;
        }// end function

        public function set fields(param1:Array) : void
        {
            var _loc_2:SortField = null;
            var _loc_3:int = 0;
            _fields = param1;
            fieldList = [];
            if (_fields)
            {
                _loc_3 = 0;
                while (_loc_3 < _fields.length)
                {
                    
                    _loc_2 = SortField(_fields[_loc_3]);
                    fieldList.push(_loc_2.name);
                    _loc_3++;
                }
            }
            dispatchEvent(new Event("fieldsChanged"));
            return;
        }// end function

        public function get fields() : Array
        {
            return _fields;
        }// end function

        public function set compareFunction(param1:Function) : void
        {
            _compareFunction = param1;
            usingCustomCompareFunction = _compareFunction != null;
            return;
        }// end function

        override public function toString() : String
        {
            return ObjectUtil.toString(this);
        }// end function

    }
}
