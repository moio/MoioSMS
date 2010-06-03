package mx.controls.treeClasses
{
    import flash.events.*;
    import flash.utils.*;
    import mx.collections.*;
    import mx.collections.errors.*;
    import mx.core.*;
    import mx.events.*;
    import mx.utils.*;

    public class HierarchicalCollectionView extends EventDispatcher implements ICollectionView, IXMLNotifiable
    {
        private var itemToUID:Function;
        public var openNodes:Object;
        private var dataDescriptor:ITreeDataDescriptor;
        private var currentLength:int;
        private var parentNode:XML;
        public var parentMap:Object;
        private var cursor:HierarchicalViewCursor;
        private var childrenMap:Dictionary;
        private var treeData:ICollectionView;
        static const VERSION:String = "3.2.0.3958";

        public function HierarchicalCollectionView(param1:ICollectionView, param2:ITreeDataDescriptor, param3:Function, param4:Object = null)
        {
            parentMap = {};
            childrenMap = new Dictionary(true);
            treeData = param1;
            treeData.addEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangeHandler, false, EventPriority.DEFAULT_HANDLER, true);
            addEventListener(CollectionEvent.COLLECTION_CHANGE, expandEventHandler, false, 0, true);
            dataDescriptor = param2;
            this.itemToUID = param3;
            openNodes = param4;
            currentLength = calculateLength();
            return;
        }// end function

        public function nestedCollectionChangeHandler(event:CollectionEvent) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:String = null;
            var _loc_6:Object = null;
            var _loc_7:Object = null;
            var _loc_8:Array = null;
            var _loc_9:CollectionEvent = null;
            var _loc_10:CollectionEvent = null;
            var _loc_11:int = 0;
            if (event is CollectionEvent)
            {
                _loc_10 = CollectionEvent(event);
                if (_loc_10.kind == mx_internal::EXPAND)
                {
                    event.stopImmediatePropagation();
                }
                else if (_loc_10.kind == CollectionEventKind.ADD)
                {
                    updateLength();
                    _loc_3 = _loc_10.items.length;
                    _loc_9 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE, false, true, _loc_10.kind);
                    _loc_2 = 0;
                    while (_loc_2 < _loc_3)
                    {
                        
                        _loc_7 = _loc_10.items[_loc_2];
                        if (_loc_7 is XML)
                        {
                            startTrackUpdates(_loc_7);
                        }
                        _loc_6 = getParentItem(_loc_7);
                        if (_loc_6 != null)
                        {
                            getVisibleNodes(_loc_7, _loc_6, _loc_9.items);
                        }
                        _loc_2++;
                    }
                    _loc_9.location = getVisibleLocationInSubCollection(_loc_6, _loc_10.location);
                    dispatchEvent(_loc_9);
                }
                else if (_loc_10.kind == CollectionEventKind.REMOVE)
                {
                    _loc_3 = _loc_10.items.length;
                    _loc_9 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE, false, true, _loc_10.kind);
                    _loc_2 = 0;
                    while (_loc_2 < _loc_3)
                    {
                        
                        _loc_7 = _loc_10.items[_loc_2];
                        if (_loc_7 is XML)
                        {
                            stopTrackUpdates(_loc_7);
                        }
                        _loc_6 = getParentItem(_loc_7);
                        if (_loc_6 != null)
                        {
                            getVisibleNodes(_loc_7, _loc_6, _loc_9.items);
                        }
                        _loc_2++;
                    }
                    _loc_9.location = getVisibleLocationInSubCollection(_loc_6, _loc_10.location);
                    currentLength = currentLength - _loc_9.items.length;
                    dispatchEvent(_loc_9);
                }
                else if (_loc_10.kind == CollectionEventKind.UPDATE)
                {
                    dispatchEvent(event);
                }
                else if (_loc_10.kind == CollectionEventKind.REPLACE)
                {
                    _loc_3 = _loc_10.items.length;
                    _loc_9 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE, false, true, CollectionEventKind.REMOVE);
                    _loc_2 = 0;
                    while (_loc_2 < _loc_3)
                    {
                        
                        _loc_7 = _loc_10.items[_loc_2].oldValue;
                        _loc_6 = getParentItem(_loc_7);
                        if (_loc_6 != null)
                        {
                            getVisibleNodes(_loc_7, _loc_6, _loc_9.items);
                        }
                        _loc_2++;
                    }
                    _loc_11 = 0;
                    _loc_2 = 0;
                    while (_loc_2 < _loc_3)
                    {
                        
                        _loc_7 = _loc_10.items[_loc_2].oldValue;
                        if (_loc_7 is XML)
                        {
                            stopTrackUpdates(_loc_7);
                        }
                        while (_loc_9.items[_loc_11] != _loc_7)
                        {
                            
                            _loc_11++;
                        }
                        _loc_9.items.splice(_loc_11, 1);
                        _loc_2++;
                    }
                    if (_loc_9.items.length)
                    {
                        currentLength = currentLength - _loc_9.items.length;
                        dispatchEvent(_loc_9);
                    }
                    dispatchEvent(event);
                }
                else if (_loc_10.kind == CollectionEventKind.RESET)
                {
                    updateLength();
                    _loc_9 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE, false, true, CollectionEventKind.REFRESH);
                    dispatchEvent(_loc_9);
                }
            }
            return;
        }// end function

        private function getVisibleLocationInSubCollection(param1:Object, param2:int) : int
        {
            var _loc_5:ICollectionView = null;
            var _loc_6:IViewCursor = null;
            var _loc_3:* = param2;
            var _loc_4:* = param1;
            param1 = getParentItem(param1);
            while (param1 != null)
            {
                
                _loc_5 = childrenMap[param1];
                _loc_6 = _loc_5.createCursor();
                while (!_loc_6.afterLast)
                {
                    
                    if (_loc_6.current == _loc_4)
                    {
                        _loc_3++;
                        break;
                    }
                    _loc_3 = _loc_3 + (calculateLength(_loc_6.current, param1) + 1);
                    _loc_6.moveNext();
                }
                _loc_4 = param1;
                param1 = getParentItem(param1);
            }
            _loc_6 = treeData.createCursor();
            while (!_loc_6.afterLast)
            {
                
                if (_loc_6.current == _loc_4)
                {
                    _loc_3++;
                    break;
                }
                _loc_3 = _loc_3 + (calculateLength(_loc_6.current, param1) + 1);
                _loc_6.moveNext();
            }
            return _loc_3;
        }// end function

        public function expandEventHandler(event:CollectionEvent) : void
        {
            var _loc_2:CollectionEvent = null;
            if (event is CollectionEvent)
            {
                _loc_2 = CollectionEvent(event);
                if (_loc_2.kind == mx_internal::EXPAND)
                {
                    event.stopImmediatePropagation();
                    updateLength();
                }
            }
            return;
        }// end function

        private function updateLength(param1:Object = null, param2:Object = null) : void
        {
            currentLength = calculateLength();
            return;
        }// end function

        private function startTrackUpdates(param1:Object) : void
        {
            XMLNotifier.getInstance().watchXML(param1, this);
            return;
        }// end function

        private function getVisibleLocation(param1:int) : int
        {
            var _loc_2:int = 0;
            var _loc_3:* = treeData.createCursor();
            var _loc_4:int = 0;
            while (_loc_4 < param1 && !_loc_3.afterLast)
            {
                
                _loc_2 = _loc_2 + (calculateLength(_loc_3.current, null) + 1);
                _loc_3.moveNext();
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public function describeData() : Object
        {
            return null;
        }// end function

        public function get sort() : Sort
        {
            return null;
        }// end function

        public function contains(param1:Object) : Boolean
        {
            var _loc_2:* = createCursor();
            var _loc_3:Boolean = false;
            while (!_loc_3)
            {
                
                if (_loc_2.current == param1)
                {
                    return true;
                }
                _loc_3 = _loc_2.moveNext();
            }
            return false;
        }// end function

        private function stopTrackUpdates(param1:Object) : void
        {
            XMLNotifier.getInstance().unwatchXML(param1, this);
            return;
        }// end function

        public function xmlNotification(param1:Object, param2:String, param3:Object, param4:Object, param5:Object) : void
        {
            var _loc_6:String = null;
            var _loc_7:Object = null;
            var _loc_8:Object = null;
            var _loc_9:XMLListCollection = null;
            var _loc_10:int = 0;
            var _loc_11:CollectionEvent = null;
            var _loc_12:XMLListAdapter = null;
            var _loc_13:* = undefined;
            var _loc_14:* = undefined;
            var _loc_15:XMLList = null;
            var _loc_16:XMLListCollection = null;
            var _loc_17:int = 0;
            var _loc_18:int = 0;
            if (param1 === param3)
            {
                switch(param2)
                {
                    case "nodeAdded":
                    {
                        for (_loc_13 in childrenMap)
                        {
                            
                            if (_loc_13 === param1)
                            {
                                _loc_12 = childrenMap[_loc_13].list as XMLListAdapter;
                                break;
                            }
                        }
                        if (!_loc_12 && param3 is XML && XML(param3).children().length() == 1)
                        {
                            _loc_12 = (getChildren(param3) as XMLListCollection).list as XMLListAdapter;
                        }
                        if (_loc_12 && !_loc_12.busy())
                        {
                            if (childrenMap[_loc_13] === treeData)
                            {
                                _loc_9 = treeData as XMLListCollection;
                                if (parentNode)
                                {
                                    mx_internal::dispatchResetEvent = false;
                                    _loc_9.source = parentNode.*;
                                }
                            }
                            else
                            {
                                _loc_9 = getChildren(_loc_13) as XMLListCollection;
                            }
                            if (_loc_9)
                            {
                                _loc_10 = param4.childIndex();
                                _loc_11 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                                _loc_11.kind = CollectionEventKind.ADD;
                                _loc_11.location = _loc_10;
                                _loc_11.items = [param4];
                                _loc_9.dispatchEvent(_loc_11);
                            }
                        }
                        break;
                    }
                    case "nodeRemoved":
                    {
                        for (_loc_14 in childrenMap)
                        {
                            
                            if (_loc_14 === param1)
                            {
                                _loc_9 = childrenMap[_loc_14];
                                _loc_12 = _loc_9.list as XMLListAdapter;
                                if (_loc_12 && !_loc_12.busy())
                                {
                                    _loc_15 = _loc_9.source as XMLList;
                                    if (childrenMap[_loc_14] === treeData)
                                    {
                                        _loc_9 = treeData as XMLListCollection;
                                        if (parentNode)
                                        {
                                            mx_internal::dispatchResetEvent = false;
                                            _loc_9.source = parentNode.*;
                                        }
                                    }
                                    else
                                    {
                                        _loc_16 = _loc_9;
                                        _loc_9 = getChildren(_loc_14) as XMLListCollection;
                                        if (!_loc_9)
                                        {
                                            _loc_16.addEventListener(CollectionEvent.COLLECTION_CHANGE, nestedCollectionChangeHandler, false, 0, true);
                                            _loc_11 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                                            _loc_11.kind = CollectionEventKind.REMOVE;
                                            _loc_11.location = 0;
                                            _loc_11.items = [param4];
                                            _loc_16.dispatchEvent(_loc_11);
                                            _loc_16.removeEventListener(CollectionEvent.COLLECTION_CHANGE, nestedCollectionChangeHandler);
                                        }
                                    }
                                    if (_loc_9)
                                    {
                                        _loc_17 = _loc_15.length();
                                        _loc_18 = 0;
                                        while (_loc_18 < _loc_17)
                                        {
                                            
                                            if (_loc_15[_loc_18] === param4)
                                            {
                                                _loc_11 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                                                _loc_11.kind = CollectionEventKind.REMOVE;
                                                _loc_11.location = _loc_10;
                                                _loc_11.items = [param4];
                                                _loc_9.dispatchEvent(_loc_11);
                                                break;
                                            }
                                            _loc_18++;
                                        }
                                    }
                                }
                                break;
                            }
                        }
                        break;
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
            }
            return;
        }// end function

        public function itemUpdated(param1:Object, param2:Object = null, param3:Object = null, param4:Object = null) : void
        {
            var _loc_5:* = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
            new CollectionEvent(CollectionEvent.COLLECTION_CHANGE).kind = CollectionEventKind.UPDATE;
            var _loc_6:* = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE).property = param2;
            _loc_6.oldValue = param3;
            _loc_6.newValue = param4;
            _loc_5.items.push(_loc_6);
            dispatchEvent(_loc_5);
            return;
        }// end function

        public function enableAutoUpdate() : void
        {
            return;
        }// end function

        public function set sort(param1:Sort) : void
        {
            return;
        }// end function

        public function getParentItem(param1:Object)
        {
            var _loc_2:* = itemToUID(param1);
            if (parentMap.hasOwnProperty(_loc_2))
            {
                return parentMap[_loc_2];
            }
            return undefined;
        }// end function

        private function getVisibleNodes(param1:Object, param2:Object, param3:Array) : void
        {
            var _loc_4:ICollectionView = null;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            param3.push(param1);
            var _loc_5:* = itemToUID(param1);
            parentMap[_loc_5] = param2;
            if (openNodes[_loc_5] && dataDescriptor.isBranch(param1, treeData) && dataDescriptor.hasChildren(param1, treeData))
            {
                _loc_4 = getChildren(param1);
                if (_loc_4 != null)
                {
                    _loc_6 = _loc_4.length;
                    _loc_7 = 0;
                    while (_loc_7 < _loc_6)
                    {
                        
                        getVisibleNodes(_loc_4[_loc_7], param1, param3);
                        _loc_7++;
                    }
                }
            }
            return;
        }// end function

        public function refresh() : Boolean
        {
            var _loc_1:* = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
            _loc_1.kind = CollectionEventKind.REFRESH;
            dispatchEvent(_loc_1);
            return true;
        }// end function

        public function get length() : int
        {
            return currentLength;
        }// end function

        public function set filterFunction(param1:Function) : void
        {
            return;
        }// end function

        public function calculateLength(param1:Object = null, param2:Object = null) : int
        {
            var length:int;
            var childNodes:ICollectionView;
            var modelOffset:int;
            var modelCursor:IViewCursor;
            var parNode:*;
            var uid:String;
            var numChildren:int;
            var i:int;
            var node:* = param1;
            var parent:* = param2;
            length;
            var firstNode:Boolean;
            if (node == null)
            {
                modelOffset;
                modelCursor = treeData.createCursor();
                if (modelCursor.beforeFirst)
                {
                    return treeData.length;
                }
                do
                {
                    
                    node = modelCursor.current;
                    if (node is XML)
                    {
                        if (firstNode)
                        {
                            firstNode;
                            parNode = node.parent();
                            if (parNode)
                            {
                                startTrackUpdates(parNode);
                                childrenMap[parNode] = treeData;
                                parentNode = parNode;
                            }
                        }
                        startTrackUpdates(node);
                    }
                    if (node === null)
                    {
                        length = length + 1;
                    }
                    else
                    {
                        length = length + (calculateLength(node, null) + 1);
                    }
                    modelOffset = modelOffset++;
                    try
                    {
                        modelCursor.moveNext();
                    }
                    catch (e:ItemPendingError)
                    {
                        length = length + (treeData.length - modelOffset);
                        return length;
                    }
                }while (!modelCursor.afterLast)
            }
            else
            {
                uid = itemToUID(node);
                parentMap[uid] = parent;
                if (node != null && openNodes[uid] && dataDescriptor.isBranch(node, treeData) && dataDescriptor.hasChildren(node, treeData))
                {
                    childNodes = getChildren(node);
                    if (childNodes != null)
                    {
                        numChildren = childNodes.length;
                        i;
                        while (i < numChildren)
                        {
                            
                            if (node is XML)
                            {
                                startTrackUpdates(childNodes[i]);
                            }
                            length = length + (calculateLength(childNodes[i], node) + 1);
                            i = i++;
                        }
                    }
                }
            }
            return length;
        }// end function

        public function disableAutoUpdate() : void
        {
            return;
        }// end function

        public function createCursor() : IViewCursor
        {
            return new HierarchicalViewCursor(this, treeData, dataDescriptor, itemToUID, openNodes);
        }// end function

        private function getChildren(param1:Object) : ICollectionView
        {
            var _loc_2:* = dataDescriptor.getChildren(param1, treeData);
            var _loc_3:* = childrenMap[param1];
            if (_loc_3 != _loc_2)
            {
                if (_loc_3 != null)
                {
                    _loc_3.removeEventListener(CollectionEvent.COLLECTION_CHANGE, nestedCollectionChangeHandler);
                }
                if (_loc_2)
                {
                    _loc_2.addEventListener(CollectionEvent.COLLECTION_CHANGE, nestedCollectionChangeHandler, false, 0, true);
                    childrenMap[param1] = _loc_2;
                }
                else
                {
                    delete childrenMap[param1];
                }
            }
            return _loc_2;
        }// end function

        public function get filterFunction() : Function
        {
            return null;
        }// end function

        public function collectionChangeHandler(event:CollectionEvent) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:String = null;
            var _loc_6:Object = null;
            var _loc_7:Object = null;
            var _loc_8:Array = null;
            var _loc_9:CollectionEvent = null;
            var _loc_10:CollectionEvent = null;
            var _loc_11:int = 0;
            if (event is CollectionEvent)
            {
                _loc_10 = CollectionEvent(event);
                if (_loc_10.kind == CollectionEventKind.RESET)
                {
                    updateLength();
                    dispatchEvent(event);
                }
                else if (_loc_10.kind == CollectionEventKind.ADD)
                {
                    _loc_3 = _loc_10.items.length;
                    _loc_9 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE, false, true, _loc_10.kind);
                    _loc_9.location = getVisibleLocation(_loc_10.location);
                    _loc_2 = 0;
                    while (_loc_2 < _loc_3)
                    {
                        
                        _loc_7 = _loc_10.items[_loc_2];
                        if (_loc_7 is XML)
                        {
                            startTrackUpdates(_loc_7);
                        }
                        getVisibleNodes(_loc_7, null, _loc_9.items);
                        _loc_2++;
                    }
                    currentLength = currentLength + _loc_9.items.length;
                    dispatchEvent(_loc_9);
                }
                else if (_loc_10.kind == CollectionEventKind.REMOVE)
                {
                    _loc_3 = _loc_10.items.length;
                    _loc_9 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE, false, true, _loc_10.kind);
                    _loc_9.location = getVisibleLocation(_loc_10.location);
                    _loc_2 = 0;
                    while (_loc_2 < _loc_3)
                    {
                        
                        _loc_7 = _loc_10.items[_loc_2];
                        if (_loc_7 is XML)
                        {
                            stopTrackUpdates(_loc_7);
                        }
                        getVisibleNodes(_loc_7, null, _loc_9.items);
                        _loc_2++;
                    }
                    currentLength = currentLength - _loc_9.items.length;
                    dispatchEvent(_loc_9);
                }
                else if (_loc_10.kind == CollectionEventKind.UPDATE)
                {
                    dispatchEvent(event);
                }
                else if (_loc_10.kind == CollectionEventKind.REPLACE)
                {
                    _loc_3 = _loc_10.items.length;
                    _loc_9 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE, false, true, CollectionEventKind.REMOVE);
                    _loc_2 = 0;
                    while (_loc_2 < _loc_3)
                    {
                        
                        _loc_7 = _loc_10.items[_loc_2].oldValue;
                        if (_loc_7 is XML)
                        {
                            stopTrackUpdates(_loc_7);
                        }
                        getVisibleNodes(_loc_7, null, _loc_9.items);
                        _loc_2++;
                    }
                    _loc_11 = 0;
                    _loc_2 = 0;
                    while (_loc_2 < _loc_3)
                    {
                        
                        _loc_7 = _loc_10.items[_loc_2].oldValue;
                        while (_loc_9.items[_loc_11] != _loc_7)
                        {
                            
                            _loc_11++;
                        }
                        _loc_9.items.splice(_loc_11, 1);
                        _loc_2++;
                    }
                    if (_loc_9.items.length)
                    {
                        currentLength = currentLength - _loc_9.items.length;
                        dispatchEvent(_loc_9);
                    }
                    dispatchEvent(event);
                }
            }
            return;
        }// end function

    }
}
