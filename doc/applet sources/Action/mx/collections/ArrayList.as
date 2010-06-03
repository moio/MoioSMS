package mx.collections
{
    import flash.events.*;
    import flash.utils.*;
    import mx.events.*;
    import mx.resources.*;
    import mx.utils.*;

    public class ArrayList extends EventDispatcher implements IList, IExternalizable, IPropertyChangeNotifier
    {
        private var _source:Array;
        private var _dispatchEvents:int = 0;
        private var _uid:String;
        private var resourceManager:IResourceManager;
        static const VERSION:String = "3.2.0.3958";

        public function ArrayList(param1:Array = null)
        {
            resourceManager = ResourceManager.getInstance();
            disableEvents();
            this.source = param1;
            enableEvents();
            _uid = UIDUtil.createUID();
            return;
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

        public function readExternal(param1:IDataInput) : void
        {
            source = param1.readObject();
            return;
        }// end function

        private function internalDispatchEvent(param1:String, param2:Object = null, param3:int = -1) : void
        {
            var _loc_4:CollectionEvent = null;
            var _loc_5:PropertyChangeEvent = null;
            if (_dispatchEvents == 0)
            {
                if (hasEventListener(CollectionEvent.COLLECTION_CHANGE))
                {
                    _loc_4 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                    _loc_4.kind = param1;
                    _loc_4.items.push(param2);
                    _loc_4.location = param3;
                    dispatchEvent(_loc_4);
                }
                if (hasEventListener(PropertyChangeEvent.PROPERTY_CHANGE) && param1 == CollectionEventKind.ADD || param1 == CollectionEventKind.REMOVE)
                {
                    _loc_5 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                    _loc_5.property = param3;
                    if (param1 == CollectionEventKind.ADD)
                    {
                        _loc_5.newValue = param2;
                    }
                    else
                    {
                        _loc_5.oldValue = param2;
                    }
                    dispatchEvent(_loc_5);
                }
            }
            return;
        }// end function

        public function removeAll() : void
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            if (length > 0)
            {
                _loc_1 = length;
                _loc_2 = 0;
                while (_loc_2 < _loc_1)
                {
                    
                    stopTrackUpdates(source[_loc_2]);
                    _loc_2++;
                }
                source.splice(0, length);
                internalDispatchEvent(CollectionEventKind.RESET);
            }
            return;
        }// end function

        public function removeItemAt(param1:int) : Object
        {
            var _loc_3:String = null;
            if (param1 < 0 || param1 >= length)
            {
                _loc_3 = resourceManager.getString("collections", "outOfBounds", [param1]);
                throw new RangeError(_loc_3);
            }
            var _loc_2:* = source.splice(param1, 1)[0];
            stopTrackUpdates(_loc_2);
            internalDispatchEvent(CollectionEventKind.REMOVE, _loc_2, param1);
            return _loc_2;
        }// end function

        public function get uid() : String
        {
            return _uid;
        }// end function

        public function getItemIndex(param1:Object) : int
        {
            return ArrayUtil.getItemIndex(param1, source);
        }// end function

        public function writeExternal(param1:IDataOutput) : void
        {
            param1.writeObject(_source);
            return;
        }// end function

        public function addItem(param1:Object) : void
        {
            addItemAt(param1, length);
            return;
        }// end function

        public function toArray() : Array
        {
            return source.concat();
        }// end function

        private function disableEvents() : void
        {
            _dispatchEvents--;
            return;
        }// end function

        public function get source() : Array
        {
            return _source;
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

        public function set uid(param1:String) : void
        {
            _uid = param1;
            return;
        }// end function

        public function setItemAt(param1:Object, param2:int) : Object
        {
            var _loc_4:String = null;
            var _loc_5:Boolean = false;
            var _loc_6:Boolean = false;
            var _loc_7:PropertyChangeEvent = null;
            var _loc_8:CollectionEvent = null;
            if (param2 < 0 || param2 >= length)
            {
                _loc_4 = resourceManager.getString("collections", "outOfBounds", [param2]);
                throw new RangeError(_loc_4);
            }
            var _loc_3:* = source[param2];
            source[param2] = param1;
            stopTrackUpdates(_loc_3);
            startTrackUpdates(param1);
            if (_dispatchEvents == 0)
            {
                _loc_5 = hasEventListener(CollectionEvent.COLLECTION_CHANGE);
                _loc_6 = hasEventListener(PropertyChangeEvent.PROPERTY_CHANGE);
                if (_loc_5 || _loc_6)
                {
                    _loc_7 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                    _loc_7.kind = PropertyChangeEventKind.UPDATE;
                    _loc_7.oldValue = _loc_3;
                    _loc_7.newValue = param1;
                    _loc_7.property = param2;
                }
                if (_loc_5)
                {
                    _loc_8 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                    _loc_8.kind = CollectionEventKind.REPLACE;
                    _loc_8.location = param2;
                    _loc_8.items.push(_loc_7);
                    dispatchEvent(_loc_8);
                }
                if (_loc_6)
                {
                    dispatchEvent(_loc_7);
                }
            }
            return _loc_3;
        }// end function

        public function get length() : int
        {
            if (source)
            {
                return source.length;
            }
            return 0;
        }// end function

        protected function stopTrackUpdates(param1:Object) : void
        {
            if (param1 && param1 is IEventDispatcher)
            {
                IEventDispatcher(param1).removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, itemUpdateHandler);
            }
            return;
        }// end function

        protected function itemUpdateHandler(event:PropertyChangeEvent) : void
        {
            var _loc_2:PropertyChangeEvent = null;
            var _loc_3:uint = 0;
            internalDispatchEvent(CollectionEventKind.UPDATE, event);
            if (_dispatchEvents == 0 && hasEventListener(PropertyChangeEvent.PROPERTY_CHANGE))
            {
                _loc_2 = PropertyChangeEvent(event.clone());
                _loc_3 = getItemIndex(event.target);
                _loc_2.property = _loc_3.toString() + "." + event.property;
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function addItemAt(param1:Object, param2:int) : void
        {
            var _loc_3:String = null;
            if (param2 < 0 || param2 > length)
            {
                _loc_3 = resourceManager.getString("collections", "outOfBounds", [param2]);
                throw new RangeError(_loc_3);
            }
            source.splice(param2, 0, param1);
            startTrackUpdates(param1);
            internalDispatchEvent(CollectionEventKind.ADD, param1, param2);
            return;
        }// end function

        public function removeItem(param1:Object) : Boolean
        {
            var _loc_2:* = getItemIndex(param1);
            var _loc_3:* = _loc_2 >= 0;
            if (_loc_3)
            {
                removeItemAt(_loc_2);
            }
            return _loc_3;
        }// end function

        protected function startTrackUpdates(param1:Object) : void
        {
            if (param1 && param1 is IEventDispatcher)
            {
                IEventDispatcher(param1).addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, itemUpdateHandler, false, 0, true);
            }
            return;
        }// end function

        override public function toString() : String
        {
            if (source)
            {
                return source.toString();
            }
            return getQualifiedClassName(this);
        }// end function

        private function enableEvents() : void
        {
            _dispatchEvents++;
            if (_dispatchEvents > 0)
            {
                _dispatchEvents = 0;
            }
            return;
        }// end function

        public function set source(param1:Array) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:CollectionEvent = null;
            if (_source && _source.length)
            {
                _loc_3 = _source.length;
                _loc_2 = 0;
                while (_loc_2 < _loc_3)
                {
                    
                    stopTrackUpdates(_source[_loc_2]);
                    _loc_2++;
                }
            }
            _source = param1 ? (param1) : ([]);
            _loc_3 = _source.length;
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                startTrackUpdates(_source[_loc_2]);
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

    }
}
