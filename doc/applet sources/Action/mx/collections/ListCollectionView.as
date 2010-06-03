package mx.collections
{
    import flash.events.*;
    import flash.utils.*;
    import mx.collections.errors.*;
    import mx.events.*;
    import mx.resources.*;
    import mx.utils.*;

    public class ListCollectionView extends Proxy implements ICollectionView, IList, IMXMLObject
    {
        private var autoUpdateCounter:int;
        private var _list:IList;
        private var _filterFunction:Function;
        protected var localIndex:Array;
        var dispatchResetEvent:Boolean = true;
        private var pendingUpdates:Array;
        private var resourceManager:IResourceManager;
        private var eventDispatcher:EventDispatcher;
        private var revision:int;
        private var _sort:Sort;
        static const VERSION:String = "3.2.0.3958";

        public function ListCollectionView(param1:IList = null)
        {
            resourceManager = ResourceManager.getInstance();
            eventDispatcher = new EventDispatcher(this);
            this.list = param1;
            return;
        }// end function

        private function handlePendingUpdates() : void
        {
            var _loc_1:Array = null;
            var _loc_2:CollectionEvent = null;
            var _loc_3:int = 0;
            var _loc_4:CollectionEvent = null;
            var _loc_5:int = 0;
            if (pendingUpdates)
            {
                _loc_1 = pendingUpdates;
                pendingUpdates = null;
                _loc_3 = 0;
                while (_loc_3 < _loc_1.length)
                {
                    
                    _loc_4 = _loc_1[_loc_3];
                    if (_loc_4.kind == CollectionEventKind.UPDATE)
                    {
                        if (!_loc_2)
                        {
                            _loc_2 = _loc_4;
                        }
                        else
                        {
                            _loc_5 = 0;
                            while (_loc_5 < _loc_4.items.length)
                            {
                                
                                _loc_2.items.push(_loc_4.items[_loc_5]);
                                _loc_5++;
                            }
                        }
                    }
                    else
                    {
                        listChangeHandler(_loc_4);
                    }
                    _loc_3++;
                }
                if (_loc_2)
                {
                    listChangeHandler(_loc_2);
                }
            }
            return;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            eventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        private function replaceItemsInView(param1:Array, param2:int, param3:Boolean = true) : void
        {
            var _loc_4:int = 0;
            var _loc_5:Array = null;
            var _loc_6:Array = null;
            var _loc_7:int = 0;
            var _loc_8:PropertyChangeEvent = null;
            var _loc_9:CollectionEvent = null;
            if (localIndex)
            {
                _loc_4 = param1.length;
                _loc_5 = [];
                _loc_6 = [];
                _loc_7 = 0;
                while (_loc_7 < _loc_4)
                {
                    
                    _loc_8 = param1[_loc_7];
                    _loc_5.push(_loc_8.oldValue);
                    _loc_6.push(_loc_8.newValue);
                    _loc_7++;
                }
                removeItemsFromView(_loc_5, param2, param3);
                addItemsToView(_loc_6, param2, param3);
            }
            else
            {
                _loc_9 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _loc_9.kind = CollectionEventKind.REPLACE;
                _loc_9.location = param2;
                _loc_9.items = param1;
                dispatchEvent(_loc_9);
            }
            return;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return eventDispatcher.willTrigger(param1);
        }// end function

        private function getFilteredItemIndex(param1:Object) : int
        {
            var _loc_4:Object = null;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_2:* = list.getItemIndex(param1);
            if (_loc_2 == 0)
            {
                return 0;
            }
            while (_loc_3-- >= 0)
            {
                
                _loc_4 = list.getItemAt(_loc_2--);
                if (filterFunction(_loc_4))
                {
                    _loc_5 = localIndex.length;
                    _loc_6 = 0;
                    while (_loc_6 < _loc_5)
                    {
                        
                        if (localIndex[_loc_6] == _loc_4)
                        {
                            return _loc_6 + 1;
                        }
                        _loc_6++;
                    }
                }
            }
            return 0;
        }// end function

        function findItem(param1:Object, param2:String, param3:Boolean = false) : int
        {
            var _loc_4:String = null;
            if (!sort)
            {
                _loc_4 = resourceManager.getString("collections", "itemNotFound");
                throw new CollectionViewError(_loc_4);
            }
            if (localIndex.length == 0)
            {
                return param3 ? (0) : (-1);
            }
            return sort.findItem(localIndex, param1, param2, param3);
        }// end function

        override function nextName(param1:int) : String
        {
            return (param1--).toString();
        }// end function

        public function removeAll() : void
        {
            var _loc_2:int = 0;
            var _loc_1:* = length;
            if (_loc_1 > 0)
            {
                if (localIndex)
                {
                    while (_loc_2-- >= 0)
                    {
                        
                        removeItemAt(_loc_1--);
                    }
                }
                else
                {
                    list.removeAll();
                }
            }
            return;
        }// end function

        override function hasProperty(param1) : Boolean
        {
            var n:Number;
            var name:* = param1;
            if (name is QName)
            {
                name = name.localName;
            }
            var index:int;
            try
            {
                n = parseInt(String(name));
                if (!isNaN(n))
                {
                    index = int(n);
                }
            }
            catch (e:Error)
            {
            }
            if (index == -1)
            {
                return false;
            }
            if (index >= 0)
            {
            }
            return index < length;
        }// end function

        public function getItemAt(param1:int, param2:int = 0) : Object
        {
            var _loc_3:String = null;
            if (param1 < 0 || param1 >= length)
            {
                _loc_3 = resourceManager.getString("collections", "outOfBounds", [param1]);
                throw new RangeError(_loc_3);
            }
            if (localIndex)
            {
                return localIndex[param1];
            }
            if (list)
            {
                return list.getItemAt(param1, param2);
            }
            return null;
        }// end function

        private function moveItemInView(param1:Object, param2:Boolean = true, param3:Array = null) : void
        {
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:CollectionEvent = null;
            if (localIndex)
            {
                _loc_4 = -1;
                _loc_5 = 0;
                while (_loc_5 < localIndex.length)
                {
                    
                    if (localIndex[_loc_5] == param1)
                    {
                        _loc_4 = _loc_5;
                        break;
                    }
                    _loc_5++;
                }
                if (_loc_4 > -1)
                {
                    localIndex.splice(_loc_4, 1);
                }
                _loc_6 = addItemsToView([param1], _loc_4, false);
                if (param2)
                {
                    _loc_7 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                    _loc_7.items.push(param1);
                    if (param3 && _loc_6 == _loc_4 && _loc_6 > -1)
                    {
                        param3.push(param1);
                        return;
                    }
                    if (_loc_6 > -1 && _loc_4 > -1)
                    {
                        _loc_7.kind = CollectionEventKind.MOVE;
                        _loc_7.location = _loc_6;
                        _loc_7.oldLocation = _loc_4;
                    }
                    else if (_loc_6 > -1)
                    {
                        _loc_7.kind = CollectionEventKind.ADD;
                        _loc_7.location = _loc_6;
                    }
                    else if (_loc_4 > -1)
                    {
                        _loc_7.kind = CollectionEventKind.REMOVE;
                        _loc_7.location = _loc_4;
                    }
                    else
                    {
                        param2 = false;
                    }
                    if (param2)
                    {
                        dispatchEvent(_loc_7);
                    }
                }
            }
            return;
        }// end function

        public function contains(param1:Object) : Boolean
        {
            return getItemIndex(param1) != -1;
        }// end function

        public function get sort() : Sort
        {
            return _sort;
        }// end function

        private function removeItemsFromView(param1:Array, param2:int, param3:Boolean = true) : void
        {
            var _loc_6:int = 0;
            var _loc_7:Object = null;
            var _loc_8:int = 0;
            var _loc_9:CollectionEvent = null;
            var _loc_4:* = localIndex ? ([]) : (param1);
            var _loc_5:* = param2;
            if (localIndex)
            {
                _loc_6 = 0;
                while (_loc_6 < param1.length)
                {
                    
                    _loc_7 = param1[_loc_6];
                    _loc_8 = getItemIndex(_loc_7);
                    if (_loc_8 > -1)
                    {
                        localIndex.splice(_loc_8, 1);
                        _loc_4.push(_loc_7);
                        _loc_5 = _loc_8;
                    }
                    _loc_6++;
                }
            }
            if (param3 && _loc_4.length > 0)
            {
                _loc_9 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _loc_9.kind = CollectionEventKind.REMOVE;
                if (localIndex)
                {
                }
                _loc_9.location = _loc_4.length == 1 ? (_loc_5) : (-1);
                _loc_9.items = _loc_4;
                dispatchEvent(_loc_9);
            }
            return;
        }// end function

        public function get list() : IList
        {
            return _list;
        }// end function

        public function addItemAt(param1:Object, param2:int) : void
        {
            var _loc_4:String = null;
            if (param2 < 0 || !list || param2 > length)
            {
                _loc_4 = resourceManager.getString("collections", "outOfBounds", [param2]);
                throw new RangeError(_loc_4);
            }
            var _loc_3:* = param2;
            if (localIndex && sort)
            {
                _loc_3 = list.length;
            }
            else if (localIndex && filterFunction != null)
            {
                if (_loc_3 == localIndex.length)
                {
                    _loc_3 = list.length;
                }
                else
                {
                    _loc_3 = list.getItemIndex(localIndex[param2]);
                }
            }
            list.addItemAt(param1, _loc_3);
            return;
        }// end function

        public function itemUpdated(param1:Object, param2:Object = null, param3:Object = null, param4:Object = null) : void
        {
            list.itemUpdated(param1, param2, param3, param4);
            return;
        }// end function

        private function populateLocalIndex() : void
        {
            if (list)
            {
                localIndex = list.toArray();
            }
            else
            {
                localIndex = [];
            }
            return;
        }// end function

        private function handlePropertyChangeEvents(param1:Array) : void
        {
            var _loc_3:Array = null;
            var _loc_4:Object = null;
            var _loc_5:int = 0;
            var _loc_6:Array = null;
            var _loc_7:int = 0;
            var _loc_8:PropertyChangeEvent = null;
            var _loc_9:Object = null;
            var _loc_10:Boolean = false;
            var _loc_11:int = 0;
            var _loc_12:int = 0;
            var _loc_13:CollectionEvent = null;
            var _loc_2:* = param1;
            if (sort || filterFunction != null)
            {
                _loc_3 = [];
                _loc_5 = 0;
                while (_loc_5 < param1.length)
                {
                    
                    _loc_8 = param1[_loc_5];
                    if (_loc_8.target)
                    {
                        _loc_9 = _loc_8.target;
                        _loc_10 = _loc_8.target != _loc_8.source;
                    }
                    else
                    {
                        _loc_9 = _loc_8.source;
                        _loc_10 = false;
                    }
                    _loc_11 = 0;
                    while (_loc_11 < _loc_3.length)
                    {
                        
                        if (_loc_3[_loc_11].item == _loc_9)
                        {
                            break;
                        }
                        _loc_11++;
                    }
                    if (_loc_11 < _loc_3.length)
                    {
                        _loc_4 = _loc_3[_loc_11];
                    }
                    else
                    {
                        _loc_4 = {item:_loc_9, move:_loc_10, event:_loc_8};
                        _loc_3.push(_loc_4);
                    }
                    if (_loc_4.move || filterFunction || !_loc_8.property || sort)
                    {
                    }
                    _loc_4.move = sort.propertyAffectsSort(String(_loc_8.property));
                    _loc_5++;
                }
                _loc_2 = [];
                _loc_5 = 0;
                while (_loc_5 < _loc_3.length)
                {
                    
                    _loc_4 = _loc_3[_loc_5];
                    if (_loc_4.move)
                    {
                        moveItemInView(_loc_4.item, _loc_4.item, _loc_2);
                    }
                    else
                    {
                        _loc_2.push(_loc_4.item);
                    }
                    _loc_5++;
                }
                _loc_6 = [];
                _loc_7 = 0;
                while (_loc_7 < _loc_2.length)
                {
                    
                    _loc_12 = 0;
                    while (_loc_12 < _loc_3.length)
                    {
                        
                        if (_loc_2[_loc_7] == _loc_3[_loc_12].item)
                        {
                            _loc_6.push(_loc_3[_loc_12].event);
                        }
                        _loc_12++;
                    }
                    _loc_7++;
                }
                _loc_2 = _loc_6;
            }
            if (_loc_2.length > 0)
            {
                _loc_13 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _loc_13.kind = CollectionEventKind.UPDATE;
                _loc_13.items = _loc_2;
                dispatchEvent(_loc_13);
            }
            return;
        }// end function

        public function set sort(param1:Sort) : void
        {
            _sort = param1;
            dispatchEvent(new Event("sortChanged"));
            return;
        }// end function

        override function nextValue(param1:int)
        {
            return getItemAt(param1--);
        }// end function

        public function setItemAt(param1:Object, param2:int) : Object
        {
            var _loc_4:String = null;
            var _loc_5:Object = null;
            if (param2 < 0 || !list || param2 >= length)
            {
                _loc_4 = resourceManager.getString("collections", "outOfBounds", [param2]);
                throw new RangeError(_loc_4);
            }
            var _loc_3:* = param2;
            if (localIndex)
            {
                if (param2 > localIndex.length)
                {
                    _loc_3 = list.length;
                }
                else
                {
                    _loc_5 = localIndex[param2];
                    _loc_3 = list.getItemIndex(_loc_5);
                }
            }
            return list.setItemAt(param1, _loc_3);
        }// end function

        function getBookmark(param1:int) : ListCollectionViewBookmark
        {
            var value:Object;
            var message:String;
            var index:* = param1;
            if (index < 0 || index > length)
            {
                message = resourceManager.getString("collections", "invalidIndex", [index]);
                throw new CollectionViewError(message);
            }
            try
            {
                value = getItemAt(index);
            }
            catch (e:Error)
            {
                value;
            }
            return new ListCollectionViewBookmark(value, this, revision, index);
        }// end function

        private function addItemsToView(param1:Array, param2:int, param3:Boolean = true) : int
        {
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_9:Object = null;
            var _loc_10:String = null;
            var _loc_11:CollectionEvent = null;
            var _loc_4:* = localIndex ? ([]) : (param1);
            var _loc_5:* = param2;
            var _loc_6:Boolean = true;
            if (localIndex)
            {
                _loc_7 = param2;
                _loc_8 = 0;
                while (_loc_8 < param1.length)
                {
                    
                    _loc_9 = param1[_loc_8];
                    if (filterFunction == null || filterFunction(_loc_9))
                    {
                        if (sort)
                        {
                            _loc_7 = findItem(_loc_9, Sort.ANY_INDEX_MODE, true);
                            if (_loc_6)
                            {
                                _loc_5 = _loc_7;
                                _loc_6 = false;
                            }
                        }
                        else
                        {
                            _loc_7 = getFilteredItemIndex(_loc_9);
                            if (_loc_6)
                            {
                                _loc_5 = _loc_7;
                                _loc_6 = false;
                            }
                        }
                        if (sort && sort.unique && sort.compareFunction(_loc_9, localIndex[_loc_7]) == 0)
                        {
                            _loc_10 = resourceManager.getString("collections", "incorrectAddition");
                            throw new CollectionViewError(_loc_10);
                        }
                        localIndex.splice(_loc_7++, 0, _loc_9);
                        _loc_4.push(_loc_9);
                    }
                    else
                    {
                        _loc_5 = -1;
                    }
                    _loc_8++;
                }
            }
            if (localIndex && _loc_4.length > 1)
            {
                _loc_5 = -1;
            }
            if (param3 && _loc_4.length > 0)
            {
                _loc_11 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _loc_11.kind = CollectionEventKind.ADD;
                _loc_11.location = _loc_5;
                _loc_11.items = _loc_4;
                dispatchEvent(_loc_11);
            }
            return _loc_5;
        }// end function

        public function dispatchEvent(event:Event) : Boolean
        {
            return eventDispatcher.dispatchEvent(event);
        }// end function

        public function set list(param1:IList) : void
        {
            var _loc_2:Boolean = false;
            var _loc_3:Boolean = false;
            if (_list != param1)
            {
                if (_list)
                {
                    _list.removeEventListener(CollectionEvent.COLLECTION_CHANGE, listChangeHandler);
                    _loc_2 = _list.length > 0;
                }
                _list = param1;
                if (_list)
                {
                    _list.addEventListener(CollectionEvent.COLLECTION_CHANGE, listChangeHandler, false, 0, true);
                    _loc_3 = _list.length > 0;
                }
                if (_loc_2 || _loc_3)
                {
                    reset();
                }
                dispatchEvent(new Event("listChanged"));
            }
            return;
        }// end function

        function getBookmarkIndex(param1:CursorBookmark) : int
        {
            var _loc_3:String = null;
            if (!(param1 is ListCollectionViewBookmark) || ListCollectionViewBookmark(param1).view != this)
            {
                _loc_3 = resourceManager.getString("collections", "bookmarkNotFound");
                throw new CollectionViewError(_loc_3);
            }
            var _loc_2:* = ListCollectionViewBookmark(param1);
            if (_loc_2.viewRevision != revision)
            {
                if (_loc_2.index < 0 || _loc_2.index >= length || getItemAt(_loc_2.index) != _loc_2.value)
                {
                    _loc_2.index = getItemIndex(_loc_2.value);
                }
                _loc_2.viewRevision = revision;
            }
            return _loc_2.index;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            eventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function getItemIndex(param1:Object) : int
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            if (sort)
            {
                _loc_3 = sort.findItem(localIndex, param1, Sort.FIRST_INDEX_MODE);
                if (_loc_3 == -1)
                {
                    return -1;
                }
                _loc_4 = sort.findItem(localIndex, param1, Sort.LAST_INDEX_MODE);
                _loc_2 = _loc_3;
                while (_loc_2 <= _loc_4)
                {
                    
                    if (localIndex[_loc_2] == param1)
                    {
                        return _loc_2;
                    }
                    _loc_2++;
                }
                return -1;
            }
            else if (filterFunction != null)
            {
                _loc_5 = localIndex.length;
                _loc_2 = 0;
                while (_loc_2 < _loc_5)
                {
                    
                    if (localIndex[_loc_2] == param1)
                    {
                        return _loc_2;
                    }
                    _loc_2++;
                }
                return -1;
            }
            return list.getItemIndex(param1);
        }// end function

        public function removeItemAt(param1:int) : Object
        {
            var _loc_3:String = null;
            var _loc_4:Object = null;
            if (param1 < 0 || param1 >= length)
            {
                _loc_3 = resourceManager.getString("collections", "outOfBounds", [param1]);
                throw new RangeError(_loc_3);
            }
            var _loc_2:* = param1;
            if (localIndex)
            {
                _loc_4 = localIndex[param1];
                _loc_2 = list.getItemIndex(_loc_4);
            }
            return list.removeItemAt(_loc_2);
        }// end function

        override function getProperty(param1)
        {
            var n:Number;
            var message:String;
            var name:* = param1;
            if (name is QName)
            {
                name = name.localName;
            }
            var index:int;
            try
            {
                n = parseInt(String(name));
                if (!isNaN(n))
                {
                    index = int(n);
                }
            }
            catch (e:Error)
            {
            }
            if (index == -1)
            {
                message = resourceManager.getString("collections", "unknownProperty", [name]);
                throw new Error(message);
            }
            return getItemAt(index);
        }// end function

        public function enableAutoUpdate() : void
        {
            if (autoUpdateCounter > 0)
            {
                autoUpdateCounter--;
                if (autoUpdateCounter == 0)
                {
                    handlePendingUpdates();
                }
            }
            return;
        }// end function

        function reset() : void
        {
            var _loc_1:CollectionEvent = null;
            internalRefresh(false);
            if (dispatchResetEvent)
            {
                _loc_1 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _loc_1.kind = CollectionEventKind.RESET;
                dispatchEvent(_loc_1);
            }
            return;
        }// end function

        public function toArray() : Array
        {
            var _loc_1:Array = null;
            if (localIndex)
            {
                _loc_1 = localIndex.concat();
            }
            else
            {
                _loc_1 = list.toArray();
            }
            return _loc_1;
        }// end function

        override function callProperty(param1, ... args)
        {
            return null;
        }// end function

        public function initialized(param1:Object, param2:String) : void
        {
            refresh();
            return;
        }// end function

        override function setProperty(param1, param2) : void
        {
            var n:Number;
            var message:String;
            var name:* = param1;
            var value:* = param2;
            if (name is QName)
            {
                name = name.localName;
            }
            var index:int;
            try
            {
                n = parseInt(String(name));
                if (!isNaN(n))
                {
                    index = int(n);
                }
            }
            catch (e:Error)
            {
            }
            if (index == -1)
            {
                message = resourceManager.getString("collections", "unknownProperty", [name]);
                throw new Error(message);
            }
            setItemAt(value, index);
            return;
        }// end function

        public function addItem(param1:Object) : void
        {
            addItemAt(param1, length);
            return;
        }// end function

        private function internalRefresh(param1:Boolean) : Boolean
        {
            var tmp:Array;
            var len:int;
            var i:int;
            var item:Object;
            var refreshEvent:CollectionEvent;
            var dispatch:* = param1;
            if (sort || filterFunction != null)
            {
                try
                {
                    populateLocalIndex();
                }
                catch (pending:ItemPendingError)
                {
                    pending.addResponder(new ItemResponder(function (param1:Object, param2:Object = null) : void
            {
                internalRefresh(dispatch);
                return;
            }// end function
            , function (param1:Object, param2:Object = null) : void
            {
                return;
            }// end function
            ));
                    return false;
                }
                if (filterFunction != null)
                {
                    tmp;
                    len = localIndex.length;
                    i;
                    while (i < len)
                    {
                        
                        item = localIndex[i];
                        if (filterFunction(item))
                        {
                            tmp.push(item);
                        }
                        i = i++;
                    }
                    localIndex = tmp;
                }
                if (sort)
                {
                    sort.sort(localIndex);
                    dispatch;
                }
            }
            else if (localIndex)
            {
                localIndex = null;
            }
            revision++;
            pendingUpdates = null;
            if (dispatch)
            {
                refreshEvent = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                refreshEvent.kind = CollectionEventKind.REFRESH;
                dispatchEvent(refreshEvent);
            }
            return true;
        }// end function

        public function set filterFunction(param1:Function) : void
        {
            _filterFunction = param1;
            dispatchEvent(new Event("filterFunctionChanged"));
            return;
        }// end function

        public function refresh() : Boolean
        {
            return internalRefresh(true);
        }// end function

        public function get filterFunction() : Function
        {
            return _filterFunction;
        }// end function

        public function createCursor() : IViewCursor
        {
            return new ListCollectionViewCursor(this);
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return eventDispatcher.hasEventListener(param1);
        }// end function

        public function get length() : int
        {
            if (localIndex)
            {
                return localIndex.length;
            }
            if (list)
            {
                return list.length;
            }
            return 0;
        }// end function

        override function nextNameIndex(param1:int) : int
        {
            return param1 < length ? (param1 + 1) : (0);
        }// end function

        public function disableAutoUpdate() : void
        {
            autoUpdateCounter++;
            return;
        }// end function

        public function toString() : String
        {
            if (localIndex)
            {
                return ObjectUtil.toString(localIndex);
            }
            if (list && Object(list).toString)
            {
                return Object(list).toString();
            }
            return getQualifiedClassName(this);
        }// end function

        private function listChangeHandler(event:CollectionEvent) : void
        {
            if (autoUpdateCounter > 0)
            {
                if (!pendingUpdates)
                {
                    pendingUpdates = [];
                }
                pendingUpdates.push(event);
            }
            else
            {
                switch(event.kind)
                {
                    case CollectionEventKind.ADD:
                    {
                        addItemsToView(event.items, event.location);
                        break;
                    }
                    case CollectionEventKind.RESET:
                    {
                        reset();
                        break;
                    }
                    case CollectionEventKind.REMOVE:
                    {
                        removeItemsFromView(event.items, event.location);
                        break;
                    }
                    case CollectionEventKind.REPLACE:
                    {
                        replaceItemsInView(event.items, event.location);
                        break;
                    }
                    case CollectionEventKind.UPDATE:
                    {
                        handlePropertyChangeEvents(event.items);
                        break;
                    }
                    default:
                    {
                        dispatchEvent(event);
                        break;
                    }
                }
            }
            return;
        }// end function

    }
}
