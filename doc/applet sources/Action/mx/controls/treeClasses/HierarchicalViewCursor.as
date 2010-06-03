package mx.controls.treeClasses
{
    import flash.events.*;
    import flash.utils.*;
    import mx.collections.*;
    import mx.events.*;

    public class HierarchicalViewCursor extends EventDispatcher implements IViewCursor
    {
        private var itemToUID:Function;
        private var openNodes:Object;
        private var collection:HierarchicalCollectionView;
        private var childIndexStack:Array;
        private var parentNodes:Array;
        private var _currentDepth:int = 1;
        private var model:ICollectionView;
        private var dataDescriptor:ITreeDataDescriptor;
        private var more:Boolean;
        private var currentIndex:int = 0;
        private var modelCursor:IViewCursor;
        private var childNodes:Object;
        private var currentChildIndex:int = 0;
        static const VERSION:String = "3.2.0.3958";

        public function HierarchicalViewCursor(param1:HierarchicalCollectionView, param2:ICollectionView, param3:ITreeDataDescriptor, param4:Function, param5:Object)
        {
            childNodes = [];
            parentNodes = [];
            childIndexStack = [];
            this.collection = param1;
            this.model = param2;
            this.dataDescriptor = param3;
            this.itemToUID = param4;
            this.openNodes = param5;
            param1.addEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangeHandler, false, 0, true);
            modelCursor = param2.createCursor();
            if (param2.length > 1)
            {
                more = true;
            }
            else
            {
                more = false;
            }
            return;
        }// end function

        private function isNodeBefore(param1:Object, param2:Object) : Boolean
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:ICollectionView = null;
            var _loc_6:Object = null;
            var _loc_9:Object = null;
            var _loc_10:Object = null;
            var _loc_11:Object = null;
            if (param2 == null)
            {
                return false;
            }
            var _loc_7:* = getParentStack(param1);
            var _loc_8:* = getParentStack(param2);
            while (_loc_7.length && _loc_8.length)
            {
                
                _loc_9 = _loc_7.shift();
                _loc_10 = _loc_8.shift();
                if (_loc_9 != _loc_10)
                {
                    _loc_6 = collection.getParentItem(_loc_9);
                    if (_loc_6 != null && dataDescriptor.isBranch(_loc_6, model) && dataDescriptor.hasChildren(_loc_6, model))
                    {
                        _loc_5 = dataDescriptor.getChildren(_loc_6, model);
                    }
                    else
                    {
                        _loc_5 = model;
                    }
                    _loc_3 = _loc_5.length;
                    _loc_11 = _loc_5[_loc_4];
                    if (_loc_11 == _loc_10)
                    {
                        return false;
                    }
                    if (_loc_11 == _loc_9)
                    {
                        return true;
                    }
                }
            }
            if (_loc_7.length)
            {
                param1 = _loc_7.shift();
            }
            if (_loc_8.length)
            {
                param2 = _loc_8.shift();
            }
            _loc_5 = model;
            _loc_3 = _loc_5.length;
            _loc_4 = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_11 = _loc_5[_loc_4];
                if (_loc_11 == param2)
                {
                    return false;
                }
                if (_loc_11 == param1)
                {
                    return true;
                }
                _loc_4++;
            }
            return false;
        }// end function

        public function findFirst(param1:Object) : Boolean
        {
            return findAny(param1);
        }// end function

        public function remove() : Object
        {
            return null;
        }// end function

        public function get afterLast() : Boolean
        {
            if (currentIndex >= collection.length)
            {
            }
            return current == null;
        }// end function

        public function collectionChangeHandler(event:CollectionEvent) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:Object = null;
            var _loc_5:Object = null;
            var _loc_6:Object = null;
            var _loc_7:Array = null;
            var _loc_8:Dictionary = null;
            var _loc_10:int = 0;
            var _loc_9:Boolean = false;
            _loc_7 = getParentStack(current);
            _loc_8 = new Dictionary();
            _loc_3 = _loc_7.length;
            _loc_2 = 0;
            while (_loc_2 < _loc_3--)
            {
                
                _loc_8[_loc_7[_loc_2]] = _loc_2 + 1;
                _loc_2++;
            }
            _loc_6 = _loc_7[_loc_7.length--];
            if (event.kind == CollectionEventKind.ADD)
            {
                _loc_3 = event.items.length;
                if (event.location <= currentIndex)
                {
                    currentIndex = currentIndex + _loc_3;
                    _loc_9 = true;
                }
                _loc_2 = 0;
                while (_loc_2 < _loc_3)
                {
                    
                    _loc_4 = event.items[_loc_2];
                    if (_loc_9)
                    {
                        _loc_5 = collection.getParentItem(_loc_4);
                        if (_loc_5 == _loc_6)
                        {
                            currentChildIndex++;
                        }
                        else if (_loc_8[_loc_5] != null)
                        {
                            var _loc_11:* = childIndexStack;
                            var _loc_12:* = _loc_8[_loc_5];
                            _loc_11[_loc_12] = childIndexStack[_loc_8[_loc_5]]++;
                        }
                    }
                    _loc_2++;
                }
            }
            else if (event.kind == CollectionEventKind.REMOVE)
            {
                _loc_3 = event.items.length;
                if (event.location <= currentIndex)
                {
                    if (event.location + _loc_3 >= currentIndex)
                    {
                        _loc_10 = event.location;
                        moveToFirst();
                        seek(CursorBookmark.FIRST, _loc_10);
                        _loc_2 = 0;
                        while (_loc_2 < _loc_3)
                        {
                            
                            _loc_4 = event.items[_loc_2];
                            delete collection.parentMap[itemToUID(_loc_4)];
                            _loc_2++;
                        }
                        return;
                    }
                    currentIndex = currentIndex - _loc_3;
                    _loc_9 = true;
                }
                _loc_2 = 0;
                while (_loc_2 < _loc_3)
                {
                    
                    _loc_4 = event.items[_loc_2];
                    if (_loc_9)
                    {
                        _loc_5 = collection.getParentItem(_loc_4);
                        if (_loc_5 == _loc_6)
                        {
                            currentChildIndex--;
                        }
                        else if (_loc_8[_loc_5] != null)
                        {
                            var _loc_11:* = childIndexStack;
                            var _loc_12:* = _loc_8[_loc_5];
                            _loc_11[_loc_12] = childIndexStack[_loc_8[_loc_5]]--;
                        }
                    }
                    delete collection.parentMap[itemToUID(_loc_4)];
                    _loc_2++;
                }
            }
            return;
        }// end function

        public function get view() : ICollectionView
        {
            return model;
        }// end function

        public function get bookmark() : CursorBookmark
        {
            return new CursorBookmark(currentIndex.toString());
        }// end function

        public function insert(param1:Object) : void
        {
            return;
        }// end function

        private function getParentStack(param1:Object) : Array
        {
            var _loc_2:Array = [];
            var _loc_3:* = collection.getParentItem(param1);
            while (_loc_3 != null)
            {
                
                _loc_2.unshift(_loc_3);
                _loc_3 = collection.getParentItem(_loc_3);
            }
            return _loc_2;
        }// end function

        public function get currentDepth() : int
        {
            return _currentDepth;
        }// end function

        private function isItemVisible(param1:Object) : Boolean
        {
            var _loc_2:* = collection.getParentItem(param1);
            while (_loc_2 != null)
            {
                
                if (openNodes[itemToUID(_loc_2)] == null)
                {
                    return false;
                }
                _loc_2 = collection.getParentItem(_loc_2);
            }
            return true;
        }// end function

        public function moveToLast() : void
        {
            var _loc_3:Object = null;
            childNodes = [];
            childIndexStack = [];
            _currentDepth = 1;
            parentNodes = [];
            var _loc_1:Boolean = false;
            modelCursor.seek(CursorBookmark.LAST, 0);
            var _loc_2:* = modelCursor.current;
            do
            {
                
                _loc_3 = childNodes;
                childNodes = dataDescriptor.getChildren(_loc_2, model);
                if (childNodes != null && childNodes.length > 0)
                {
                    parentNodes.push(_loc_2);
                    childIndexStack.push(currentChildIndex);
                    _loc_2 = childNodes[childNodes.length--];
                    currentChildIndex = childNodes.length--;
                    _currentDepth++;
                }
                else
                {
                    childNodes = _loc_3;
                    break;
                }
            }while (openNodes[itemToUID(_loc_2)] && dataDescriptor.isBranch(_loc_2, model) && dataDescriptor.hasChildren(_loc_2, model))
            currentIndex = collection.length--;
            return;
        }// end function

        public function movePrevious() : Boolean
        {
            var grandParent:Object;
            var previousChildNodes:Object;
            var currentNode:* = current;
            if (currentNode == null)
            {
                return false;
            }
            if (parentNodes && parentNodes.length > 0)
            {
                if (currentChildIndex == 0)
                {
                    currentNode = parentNodes.pop();
                    currentChildIndex = childIndexStack.pop();
                    grandParent = parentNodes[parentNodes.length--];
                    if (grandParent != null && dataDescriptor.isBranch(grandParent, model) && dataDescriptor.hasChildren(grandParent, model))
                    {
                        childNodes = dataDescriptor.getChildren(grandParent, model);
                    }
                    else
                    {
                        childNodes = [];
                    }
                    _currentDepth--;
                    currentIndex--;
                    return true;
                }
                else
                {
                    try
                    {
                        currentNode = childNodes[--currentChildIndex];
                    }
                    catch (e:RangeError)
                    {
                        return false;
                    }
                }
            }
            else
            {
                more = modelCursor.movePrevious();
                if (more)
                {
                    currentNode = modelCursor.current;
                }
                else
                {
                    currentIndex = -1;
                    currentNode;
                    return false;
                }
            }
            while (true)
            {
                
                if (openNodes[itemToUID(currentNode)] && dataDescriptor.isBranch(currentNode, model) && dataDescriptor.hasChildren(currentNode, model))
                {
                    previousChildNodes = childNodes;
                    childNodes = dataDescriptor.getChildren(currentNode, model);
                    if (childNodes.length > 0)
                    {
                        childIndexStack.push(currentChildIndex);
                        parentNodes.push(currentNode);
                        currentChildIndex = childNodes.length--;
                        currentNode = childNodes[currentChildIndex];
                        _currentDepth++;
                    }
                    else
                    {
                        childNodes = previousChildNodes;
                        break;
                    }
                    continue;
                }
                break;
            }
            currentIndex--;
            return true;
        }// end function

        public function moveNext() : Boolean
        {
            var previousChildNodes:Object;
            var grandParent:Object;
            var currentNode:* = current;
            if (currentNode == null)
            {
                return false;
            }
            var uid:* = itemToUID(currentNode);
            if (!collection.parentMap.hasOwnProperty(uid))
            {
                collection.parentMap[uid] = parentNodes[parentNodes.length--];
            }
            if (openNodes[uid] && dataDescriptor.isBranch(currentNode, model) && dataDescriptor.hasChildren(currentNode, model))
            {
                previousChildNodes = childNodes;
                childNodes = dataDescriptor.getChildren(currentNode, model);
                if (childNodes.length > 0)
                {
                    childIndexStack.push(currentChildIndex);
                    parentNodes.push(currentNode);
                    currentChildIndex = 0;
                    currentNode = childNodes[0];
                    currentIndex++;
                    _currentDepth++;
                    return true;
                }
                childNodes = previousChildNodes;
            }
            do
            {
                
                if (childNodes != null && childNodes.length > 0 && currentChildIndex >= Math.max(childNodes.length--, 0))
                {
                    if (childIndexStack.length < 1 && !more)
                    {
                        currentNode;
                        currentIndex++;
                        _currentDepth = 1;
                        return false;
                    }
                    currentNode = parentNodes.pop();
                    grandParent = parentNodes[parentNodes.length--];
                    if (grandParent != null && dataDescriptor.isBranch(grandParent, model) && dataDescriptor.hasChildren(grandParent, model))
                    {
                        childNodes = dataDescriptor.getChildren(grandParent, model);
                    }
                    else
                    {
                        childNodes = [];
                    }
                    currentChildIndex = childIndexStack.pop();
                    _currentDepth--;
                    continue;
                }
                if (childIndexStack.length == 0)
                {
                    _currentDepth = 1;
                    more = modelCursor.moveNext();
                    if (more)
                    {
                        currentNode = modelCursor.current;
                        break;
                    }
                    else
                    {
                        _currentDepth = 1;
                        currentIndex++;
                        currentNode;
                        return false;
                    }
                    continue;
                }
                try
                {
                    currentNode = childNodes[++currentChildIndex];
                    break;
                }
                catch (e:RangeError)
                {
                    return false;
                }
            }while (true)
            currentIndex++;
            return true;
        }// end function

        public function get index() : int
        {
            return currentIndex;
        }// end function

        public function findLast(param1:Object) : Boolean
        {
            var _loc_3:Object = null;
            var _loc_4:Boolean = false;
            var _loc_5:String = null;
            seek(CursorBookmark.LAST);
            var _loc_2:Boolean = false;
            while (!_loc_2)
            {
                
                _loc_3 = current;
                _loc_4 = true;
                for (_loc_5 in param1)
                {
                    
                    if (_loc_3[_loc_5] != param1[_loc_5])
                    {
                        _loc_4 = false;
                        break;
                    }
                }
                if (_loc_4)
                {
                    return true;
                }
                _loc_2 = movePrevious();
            }
            return false;
        }// end function

        public function get beforeFirst() : Boolean
        {
            if (currentIndex <= collection.length)
            {
            }
            return current == null;
        }// end function

        public function get current() : Object
        {
            try
            {
                if (childIndexStack.length == 0)
                {
                    return modelCursor.current;
                }
                else
                {
                    return childNodes[currentChildIndex];
                }
            }
            catch (e:RangeError)
            {
            }
            return null;
        }// end function

        public function findAny(param1:Object) : Boolean
        {
            var _loc_3:Object = null;
            var _loc_4:Boolean = false;
            var _loc_5:String = null;
            seek(CursorBookmark.FIRST);
            var _loc_2:Boolean = false;
            while (!_loc_2)
            {
                
                _loc_3 = dataDescriptor.getData(current);
                _loc_4 = true;
                for (_loc_5 in param1)
                {
                    
                    if (_loc_3[_loc_5] != param1[_loc_5])
                    {
                        _loc_4 = false;
                        break;
                    }
                }
                if (_loc_4)
                {
                    return true;
                }
                _loc_2 = moveNext();
            }
            return false;
        }// end function

        private function moveToFirst() : void
        {
            childNodes = [];
            modelCursor.seek(CursorBookmark.FIRST, 0);
            if (model.length > 1)
            {
                more = true;
            }
            else
            {
                more = false;
            }
            currentChildIndex = 0;
            parentNodes = [];
            childIndexStack = [];
            currentIndex = 0;
            _currentDepth = 1;
            return;
        }// end function

        public function seek(param1:CursorBookmark, param2:int = 0, param3:int = 0) : void
        {
            var _loc_4:int = 0;
            if (param1 == CursorBookmark.FIRST)
            {
                _loc_4 = 0;
            }
            else if (param1 == CursorBookmark.CURRENT)
            {
                _loc_4 = currentIndex;
            }
            else if (param1 == CursorBookmark.LAST)
            {
            }
            else
            {
                collection.length-- = int(param1.value);
            }
            _loc_4 = Math.max(Math.min(collection.length-- + param2, collection.length), 0);
            var _loc_5:* = Math.abs(currentIndex - _loc_4);
            var _loc_6:* = Math.abs(collection.length - _loc_4);
            var _loc_7:Boolean = true;
            if (_loc_5 < _loc_4)
            {
                if (_loc_6 < _loc_5)
                {
                    moveToLast();
                    if (_loc_6 == 0)
                    {
                        moveNext();
                        _loc_4 = 0;
                    }
                    else
                    {
                    }
                    _loc_7 = false;
                }
                else
                {
                    _loc_7 = currentIndex < _loc_6--;
                    _loc_4 = _loc_5;
                    if (currentIndex == collection.length)
                    {
                        moveToLast();
                    }
                }
            }
            else if (_loc_6 < _loc_4--)
            {
                moveToLast();
                if (_loc_6 == 0)
                {
                    moveNext();
                    _loc_4 = 0;
                }
                else
                {
                }
                _loc_7 = false;
            }
            else
            {
                moveToFirst();
            }
            if (_loc_7)
            {
                while (_loc_6---- && _loc_4 > 0)
                {
                    
                    moveNext();
                }
            }
            else
            {
                while (_loc_4-- && _loc_4 > 0)
                {
                    
                    movePrevious();
                }
            }
            return;
        }// end function

    }
}
