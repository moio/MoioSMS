package mx.collections
{
    import flash.events.*;
    import mx.collections.errors.*;
    import mx.resources.*;
    import mx.utils.*;

    public class SortField extends EventDispatcher
    {
        private var _caseInsensitive:Boolean;
        private var _numeric:Object;
        private var _descending:Boolean;
        private var _compareFunction:Function;
        private var _usingCustomCompareFunction:Boolean;
        private var _name:String;
        private var resourceManager:IResourceManager;
        static const VERSION:String = "3.2.0.3958";

        public function SortField(param1:String = null, param2:Boolean = false, param3:Boolean = false, param4:Object = null)
        {
            resourceManager = ResourceManager.getInstance();
            _name = param1;
            _caseInsensitive = param2;
            _descending = param3;
            _numeric = param4;
            _compareFunction = stringCompare;
            return;
        }// end function

        public function get caseInsensitive() : Boolean
        {
            return _caseInsensitive;
        }// end function

        function get usingCustomCompareFunction() : Boolean
        {
            return _usingCustomCompareFunction;
        }// end function

        public function set caseInsensitive(param1:Boolean) : void
        {
            if (param1 != _caseInsensitive)
            {
                _caseInsensitive = param1;
                dispatchEvent(new Event("caseInsensitiveChanged"));
            }
            return;
        }// end function

        public function get name() : String
        {
            return _name;
        }// end function

        public function get numeric() : Object
        {
            return _numeric;
        }// end function

        public function set name(param1:String) : void
        {
            _name = param1;
            dispatchEvent(new Event("nameChanged"));
            return;
        }// end function

        private function numericCompare(param1:Object, param2:Object) : int
        {
            var fa:Number;
            var fb:Number;
            var a:* = param1;
            var b:* = param2;
            try
            {
                fa = _name == null ? (Number(a)) : (Number(a[_name]));
            }
            catch (error:Error)
            {
                try
                {
                }
                fb = _name == null ? (Number(b)) : (Number(b[_name]));
            }
            catch (error:Error)
            {
            }
            return ObjectUtil.numericCompare(fa, fb);
        }// end function

        public function set numeric(param1:Object) : void
        {
            if (_numeric != param1)
            {
                _numeric = param1;
                dispatchEvent(new Event("numericChanged"));
            }
            return;
        }// end function

        private function stringCompare(param1:Object, param2:Object) : int
        {
            var fa:String;
            var fb:String;
            var a:* = param1;
            var b:* = param2;
            try
            {
                fa = _name == null ? (String(a)) : (String(a[_name]));
            }
            catch (error:Error)
            {
                try
                {
                }
                fb = _name == null ? (String(b)) : (String(b[_name]));
            }
            catch (error:Error)
            {
            }
            return ObjectUtil.stringCompare(fa, fb, _caseInsensitive);
        }// end function

        public function get compareFunction() : Function
        {
            return _compareFunction;
        }// end function

        public function reverse() : void
        {
            descending = !descending;
            return;
        }// end function

        function getArraySortOnOptions() : int
        {
            if (usingCustomCompareFunction || name == null || _compareFunction == xmlCompare || _compareFunction == dateCompare)
            {
                return -1;
            }
            var _loc_1:int = 0;
            if (caseInsensitive)
            {
                _loc_1 = _loc_1 | Array.CASEINSENSITIVE;
            }
            if (descending)
            {
                _loc_1 = _loc_1 | Array.DESCENDING;
            }
            if (numeric == true || _compareFunction == numericCompare)
            {
                _loc_1 = _loc_1 | Array.NUMERIC;
            }
            return _loc_1;
        }// end function

        private function dateCompare(param1:Object, param2:Object) : int
        {
            var fa:Date;
            var fb:Date;
            var a:* = param1;
            var b:* = param2;
            try
            {
                fa = _name == null ? (a as Date) : (a[_name] as Date);
            }
            catch (error:Error)
            {
                try
                {
                }
                fb = _name == null ? (b as Date) : (b[_name] as Date);
            }
            catch (error:Error)
            {
            }
            return ObjectUtil.dateCompare(fa, fb);
        }// end function

        function internalCompare(param1:Object, param2:Object) : int
        {
            var _loc_3:* = compareFunction(param1, param2);
            if (descending)
            {
                _loc_3 = _loc_3 * -1;
            }
            return _loc_3;
        }// end function

        override public function toString() : String
        {
            return ObjectUtil.toString(this);
        }// end function

        private function nullCompare(param1:Object, param2:Object) : int
        {
            var value:Object;
            var left:Object;
            var right:Object;
            var message:String;
            var a:* = param1;
            var b:* = param2;
            var found:Boolean;
            if (a == null && b == null)
            {
                return 0;
            }
            if (_name)
            {
                try
                {
                    left = a[_name];
                }
                catch (error:Error)
                {
                    try
                    {
                    }
                    right = b[_name];
                }
                catch (error:Error)
                {
                }
            }
            if (left == null && right == null)
            {
                return 0;
            }
            if (left == null)
            {
                left = a;
            }
            if (right == null)
            {
                right = b;
            }
            var typeLeft:* = typeof(left);
            var typeRight:* = typeof(right);
            if (typeLeft == "string" || typeRight == "string")
            {
                found;
                _compareFunction = stringCompare;
            }
            else if (typeLeft == "object" || typeRight == "object")
            {
                if (left is Date || right is Date)
                {
                    found;
                    _compareFunction = dateCompare;
                }
            }
            else if (typeLeft == "xml" || typeRight == "xml")
            {
                found;
                _compareFunction = xmlCompare;
            }
            else if (typeLeft == "number" || typeRight == "number" || typeLeft == "boolean" || typeRight == "boolean")
            {
                found;
                _compareFunction = numericCompare;
            }
            if (found)
            {
                return _compareFunction(left, right);
            }
            message = resourceManager.getString("collections", "noComparatorSortField", [name]);
            throw new SortError(message);
        }// end function

        public function set descending(param1:Boolean) : void
        {
            if (_descending != param1)
            {
                _descending = param1;
                dispatchEvent(new Event("descendingChanged"));
            }
            return;
        }// end function

        function initCompare(param1:Object) : void
        {
            var value:Object;
            var typ:String;
            var test:String;
            var obj:* = param1;
            if (!usingCustomCompareFunction)
            {
                if (numeric == true)
                {
                    _compareFunction = numericCompare;
                }
                else if (caseInsensitive || numeric == false)
                {
                    _compareFunction = stringCompare;
                }
                else
                {
                    if (_name)
                    {
                        try
                        {
                            value = obj[_name];
                        }
                        catch (error:Error)
                        {
                        }
                    }
                    if (value == null)
                    {
                        value = obj;
                    }
                    typ = typeof(value);
                    switch(typ)
                    {
                        case "string":
                        {
                            _compareFunction = stringCompare;
                            break;
                        }
                        case "object":
                        {
                            if (value is Date)
                            {
                                _compareFunction = dateCompare;
                            }
                            else
                            {
                                _compareFunction = stringCompare;
                                try
                                {
                                    test = value.toString();
                                }
                                catch (error2:Error)
                                {
                                }
                                if (!test || test == "[object Object]")
                                {
                                    _compareFunction = nullCompare;
                                }
                            }
                            break;
                        }
                        case "xml":
                        {
                            _compareFunction = xmlCompare;
                            break;
                        }
                        case "boolean":
                        case "number":
                        {
                            _compareFunction = numericCompare;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
            }
            return;
        }// end function

        public function get descending() : Boolean
        {
            return _descending;
        }// end function

        public function set compareFunction(param1:Function) : void
        {
            _compareFunction = param1;
            _usingCustomCompareFunction = param1 != null;
            return;
        }// end function

        private function xmlCompare(param1:Object, param2:Object) : int
        {
            var sa:String;
            var sb:String;
            var a:* = param1;
            var b:* = param2;
            try
            {
                sa = _name == null ? (a.toString()) : (a[_name].toString());
            }
            catch (error:Error)
            {
                try
                {
                }
                sb = _name == null ? (b.toString()) : (b[_name].toString());
            }
            catch (error:Error)
            {
            }
            if (numeric == true)
            {
                return ObjectUtil.numericCompare(parseFloat(sa), parseFloat(sb));
            }
            return ObjectUtil.stringCompare(sa, sb, _caseInsensitive);
        }// end function

    }
}
