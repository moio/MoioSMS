package mx.collections
{
    import flash.events.*;
    import flash.utils.*;
    import mx.events.*;
    import mx.resources.*;
    import mx.utils.*;

    public class XMLListAdapter extends EventDispatcher implements IList, IXMLNotifiable
    {
        private var uidCounter:int = 0;
        private var _dispatchEvents:int = 0;
        private var _busy:int = 0;
        private var seedUID:String;
        private var _source:XMLList;
        private var resourceManager:IResourceManager;
        static const VERSION:String = "3.2.0.3958";

        public function XMLListAdapter(param1:XMLList = null)
        {
            resourceManager = ResourceManager.getInstance();
            disableEvents();
            this.source = param1;
            enableEvents();
            return;
        }// end function

        public function setItemAt(param1:Object, param2:int) : Object
        {
            var _loc_4:String = null;
            var _loc_5:CollectionEvent = null;
            var _loc_6:PropertyChangeEvent = null;
            if (param2 < 0 || param2 >= length)
            {
                _loc_4 = resourceManager.getString("collections", "outOfBounds", [param2]);
                throw new RangeError(_loc_4);
            }
            var _loc_3:* = source[param2];
            source[param2] = param1;
            stopTrackUpdates(_loc_3);
            startTrackUpdates(param1, seedUID + uidCounter.toString());
            uidCounter++;
            if (_dispatchEvents == 0)
            {
                _loc_5 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _loc_5.kind = CollectionEventKind.REPLACE;
                _loc_6 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_6.kind = PropertyChangeEventKind.UPDATE;
                _loc_6.oldValue = _loc_3;
                _loc_6.newValue = param1;
                _loc_5.location = param2;
                _loc_5.items.push(_loc_6);
                dispatchEvent(_loc_5);
            }
            return _loc_3;
        }// end function

        protected function startTrackUpdates(param1:Object, param2:String) : void
        {
            XMLNotifier.getInstance().watchXML(param1, this, param2);
            return;
        }// end function

        public function removeAll() : void
        {
            var _loc_1:int = 0;
            var _loc_2:CollectionEvent = null;
            if (length > 0)
            {
                while (_loc_1-- >= 0)
                {
                    
                    stopTrackUpdates(source[length--]);
                    delete source[_loc_1];
                }
                if (_dispatchEvents == 0)
                {
                    _loc_2 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                    _loc_2.kind = CollectionEventKind.RESET;
                    dispatchEvent(_loc_2);
                }
            }
            return;
        }// end function

        protected function itemUpdateHandler(event:PropertyChangeEvent) : void
        {
            var _loc_2:CollectionEvent = null;
            if (_dispatchEvents == 0)
            {
                _loc_2 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _loc_2.kind = CollectionEventKind.UPDATE;
                _loc_2.items.push(event);
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function getItemIndex(param1:Object) : int
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:Object = null;
            if (param1 is XML && source.contains(XML(param1)))
            {
                _loc_2 = length;
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    _loc_4 = source[_loc_3];
                    if (_loc_4 === param1)
                    {
                        return _loc_3;
                    }
                    _loc_3++;
                }
            }
            return -1;
        }// end function

        public function removeItemAt(param1:int) : Object
        {
            var _loc_3:String = null;
            var _loc_4:CollectionEvent = null;
            if (param1 < 0 || param1 >= length)
            {
                _loc_3 = resourceManager.getString("collections", "outOfBounds", [param1]);
                throw new RangeError(_loc_3);
            }
            setBusy();
            var _loc_2:* = source[param1];
            delete source[param1];
            stopTrackUpdates(_loc_2);
            if (_dispatchEvents == 0)
            {
                _loc_4 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _loc_4.kind = CollectionEventKind.REMOVE;
                _loc_4.location = param1;
                _loc_4.items.push(_loc_2);
                dispatchEvent(_loc_4);
            }
            clearBusy();
            return _loc_2;
        }// end function

        public function addItem(param1:Object) : void
        {
            addItemAt(param1, length);
            return;
        }// end function

        public function get source() : XMLList
        {
            return _source;
        }// end function

        public function toArray() : Array
        {
            var _loc_1:* = source;
            var _loc_2:* = _loc_1.length();
            var _loc_3:Array = [];
            var _loc_4:int = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_3[_loc_4] = _loc_1[_loc_4];
                _loc_4++;
            }
            return _loc_3;
        }// end function

        protected function disableEvents() : void
        {
            _dispatchEvents--;
            return;
        }// end function

        public function xmlNotification(param1:Object, param2:String, param3:Object, param4:Object, param5:Object) : void
        {
            var _loc_6:String = null;
            var _loc_7:Object = null;
            var _loc_8:Object = null;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            switch(param2)
            {
                case "attributeAdded":
                {
                    break;
                }
                case "attributeChanged":
                {
                    break;
                }
                case "attributeRemoved":
                {
                    break;
                }
                case "nodeAdded":
                {
                    break;
                }
                case "nodeChanged":
                {
                    break;
                }
                case "nodeRemoved":
                {
                    break;
                }
                case "textSet":
                {
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            if (param2 == "textSet")
            {
                if (_loc_9 != undefined)
                {
                    if (_loc_10 === param1)
                    {
                    }
                }
            }
            itemUpdated(param1, _loc_6, _loc_7, _loc_8);
            return;
        }// end function

        public function addItemAt(param1:Object, param2:int) : void
        {
            var _loc_3:String = null;
            var _loc_4:CollectionEvent = null;
            if (param2 < 0 || param2 > length)
            {
                _loc_3 = resourceManager.getString("collections", "outOfBounds", [param2]);
                throw new RangeError(_loc_3);
            }
            if (!(param1 is XML) && param1 is XMLList && param1.length() != 1)
            {
                _loc_3 = resourceManager.getString("collections", "invalidType");
                throw new Error(_loc_3);
            }
            setBusy();
            if (param2 == 0)
            {
                source[0] = length > 0 ? (param1 + source[0]) : (param1);
            }
            else
            {
                source[param2--] = source[param2--] + param1;
            }
            startTrackUpdates(param1, seedUID + uidCounter.toString());
            uidCounter++;
            if (_dispatchEvents == 0)
            {
                _loc_4 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _loc_4.kind = CollectionEventKind.ADD;
                _loc_4.items.push(param1);
                _loc_4.location = param2;
                dispatchEvent(_loc_4);
            }
            clearBusy();
            return;
        }// end function

        public function getItemAt(param1:int, param2:int = 0) : Object
        {
            var _loc_3:String = null;
            if (param1 < 0 || param1 >= length)
            {
                _loc_3 = resourceManager.getString("collections", "outOfBounds", [param1]);
                throw new RangeError(_loc_3);
            }
            return source[param1];
        }// end function

        override public function toString() : String
        {
            if (source)
            {
                return source.toString();
            }
            return getQualifiedClassName(this);
        }// end function

        public function get length() : int
        {
            return source.length();
        }// end function

        public function itemUpdated(param1:Object, param2:Object = null, param3:Object = null, param4:Object = null) : void
        {
            var _loc_5:* = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE).kind = PropertyChangeEventKind.UPDATE;
            _loc_5.source = param1;
            _loc_5.property = param2;
            _loc_5.oldValue = param3;
            _loc_5.newValue = param4;
            itemUpdateHandler(_loc_5);
            return;
        }// end function

        protected function stopTrackUpdates(param1:Object) : void
        {
            XMLNotifier.getInstance().unwatchXML(param1, this);
            return;
        }// end function

        private function clearBusy() : void
        {
            _busy++;
            if (_busy > 0)
            {
                _busy = 0;
            }
            return;
        }// end function

        public function set source(param1:XMLList) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:CollectionEvent = null;
            if (_source && _source.length())
            {
                _loc_3 = _source.length();
                _loc_2 = 0;
                while (_loc_2 < _loc_3)
                {
                    
                    stopTrackUpdates(_source[_loc_2]);
                    _loc_2++;
                }
            }
            _source = param1 ? (param1) : (XMLList(new XMLList("")));
            seedUID = UIDUtil.createUID();
            uidCounter = 0;
            _loc_3 = _source.length();
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                startTrackUpdates(_source[_loc_2], seedUID + uidCounter.toString());
                uidCounter++;
                _loc_2++;
            }
            if (_dispatchEvents == 0)
            {
                _loc_4 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _loc_4.kind = CollectionEventKind.RESET;
                dispatchEvent(_loc_4);
            }
            return;
        }// end function

        public function busy() : Boolean
        {
            return _busy != 0;
        }// end function

        private function setBusy() : void
        {
            _busy--;
            return;
        }// end function

        protected function enableEvents() : void
        {
            _dispatchEvents++;
            if (_dispatchEvents > 0)
            {
                _dispatchEvents = 0;
            }
            return;
        }// end function

    }
}
