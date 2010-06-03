package mx.collections
{

    public class XMLListCollection extends ListCollectionView
    {
        static const VERSION:String = "3.2.0.3958";

        public function XMLListCollection(param1:XMLList = null)
        {
            this.source = param1;
            return;
        }// end function

        public function child(param1:Object) : XMLList
        {
            var propertyName:* = param1;
            return execXMLListFunction(function (param1:Object) : XMLList
            {
                return param1.child(propertyName);
            }// end function
            );
        }// end function

        private function execXMLListFunction(param1:Function) : XMLList
        {
            var _loc_2:int = 0;
            var _loc_3:XMLList = null;
            var _loc_4:int = 0;
            var _loc_5:Object = null;
            if (!localIndex)
            {
                return this.param1(source);
            }
            _loc_2 = localIndex.length;
            _loc_3 = new XMLList("");
            _loc_4 = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_5 = localIndex[_loc_4];
                _loc_3 = _loc_3 + this.param1(_loc_5);
                _loc_4++;
            }
            return _loc_3;
        }// end function

        override public function toString() : String
        {
            var _loc_1:String = null;
            var _loc_2:int = 0;
            if (!localIndex)
            {
                return source.toString();
            }
            _loc_1 = "";
            _loc_2 = 0;
            while (_loc_2 < localIndex.length)
            {
                
                if (_loc_2 > 0)
                {
                    _loc_1 = _loc_1 + "\n";
                }
                _loc_1 = _loc_1 + localIndex[_loc_2].toString();
                _loc_2++;
            }
            return _loc_1;
        }// end function

        public function text() : XMLList
        {
            return execXMLListFunction(function (param1:Object) : XMLList
            {
                return param1.text();
            }// end function
            );
        }// end function

        public function toXMLString() : String
        {
            var _loc_1:String = null;
            var _loc_2:int = 0;
            if (!localIndex)
            {
                return source.toXMLString();
            }
            _loc_1 = "";
            _loc_2 = 0;
            while (_loc_2 < localIndex.length)
            {
                
                if (_loc_2 > 0)
                {
                    _loc_1 = _loc_1 + "\n";
                }
                _loc_1 = _loc_1 + localIndex[_loc_2].toXMLString();
                _loc_2++;
            }
            return _loc_1;
        }// end function

        public function copy() : XMLList
        {
            return execXMLListFunction(function (param1:Object) : XMLList
            {
                return XMLList(param1.copy());
            }// end function
            );
        }// end function

        public function set source(param1:XMLList) : void
        {
            if (list)
            {
                XMLListAdapter(list).source = null;
            }
            list = new XMLListAdapter(param1);
            return;
        }// end function

        public function attributes() : XMLList
        {
            return execXMLListFunction(function (param1:Object) : XMLList
            {
                return param1.attributes();
            }// end function
            );
        }// end function

        public function get source() : XMLList
        {
            return list ? (XMLListAdapter(list).source) : (null);
        }// end function

        public function attribute(param1:Object) : XMLList
        {
            var attributeName:* = param1;
            return execXMLListFunction(function (param1:Object) : XMLList
            {
                return param1.attribute(attributeName);
            }// end function
            );
        }// end function

        public function descendants(param1:Object = "*") : XMLList
        {
            var name:* = param1;
            return execXMLListFunction(function (param1:Object) : XMLList
            {
                return param1.descendants(name);
            }// end function
            );
        }// end function

        public function elements(param1:String = "*") : XMLList
        {
            var name:* = param1;
            return execXMLListFunction(function (param1:Object) : XMLList
            {
                return param1.elements(name);
            }// end function
            );
        }// end function

        public function children() : XMLList
        {
            return execXMLListFunction(function (param1:Object) : XMLList
            {
                return param1.children();
            }// end function
            );
        }// end function

    }
}
