package 
{
    import flash.events.*;
    import mx.collections.*;
    import mx.collections.errors.*;
    import mx.events.*;
    import mx.resources.*;

    private class ListCollectionViewCursor extends EventDispatcher implements IViewCursor
    {
        private var _view:ListCollectionView;
        private var invalid:Boolean;
        private var resourceManager:IResourceManager;
        private var currentIndex:int;
        private var currentValue:Object;
        private static const BEFORE_FIRST_INDEX:int = -1;
        private static const AFTER_LAST_INDEX:int = -2;

        private function ListCollectionViewCursor(param1:ListCollectionView)
        {
            var view:* = param1;
            resourceManager = ResourceManager.getInstance();
            _view = view;
            _view.addEventListener(CollectionEvent.COLLECTION_CHANGE, collectionEventHandler, false, 0, true);
            currentIndex = view.length > 0 ? (0) : (AFTER_LAST_INDEX);
            if (currentIndex == 0)
            {
                try
                {
                    setCurrent(view.getItemAt(0), false);
                }
                catch (e:ItemPendingError)
                {
                    currentIndex = BEFORE_FIRST_INDEX;
                    setCurrent(null, false);
                }
            }
            return;
        }// end function

        public function findAny(param1:Object) : Boolean
        {
            var index:int;
            var values:* = param1;
            checkValid();
            var lcView:* = ListCollectionView(view);
            try
            {
                index = lcView.findItem(values, Sort.ANY_INDEX_MODE);
            }
            catch (e:SortError)
            {
                throw new CursorError(e.message);
            }
            if (index > -1)
            {
                currentIndex = index;
                setCurrent(lcView.getItemAt(currentIndex));
            }
            return index > -1;
        }// end function

        public function remove() : Object
        {
            var oldIndex:int;
            var message:String;
            if (beforeFirst || afterLast)
            {
                message = resourceManager.getString("collections", "invalidRemove");
                throw new CursorError(message);
            }
            oldIndex = currentIndex;
            currentIndex++;
            if (currentIndex >= view.length)
            {
                currentIndex = AFTER_LAST_INDEX;
                setCurrent(null);
            }
            else
            {
                try
                {
                    setCurrent(ListCollectionView(view).getItemAt(currentIndex));
                }
                catch (e:ItemPendingError)
                {
                    setCurrent(null, false);
                    ListCollectionView(view).removeItemAt(oldIndex);
                    throw e;
                }
            }
            var removed:* = ListCollectionView(view).removeItemAt(oldIndex);
            return removed;
        }// end function

        private function setCurrent(param1:Object, param2:Boolean = true) : void
        {
            currentValue = param1;
            if (param2)
            {
                dispatchEvent(new FlexEvent(FlexEvent.CURSOR_UPDATE));
            }
            return;
        }// end function

        public function seek(param1:CursorBookmark, param2:int = 0, param3:int = 0) : void
        {
            var message:String;
            var bookmark:* = param1;
            var offset:* = param2;
            var prefetch:* = param3;
            checkValid();
            if (view.length == 0)
            {
                currentIndex = AFTER_LAST_INDEX;
                setCurrent(null, false);
                return;
            }
            var newIndex:* = currentIndex;
            if (bookmark == CursorBookmark.FIRST)
            {
                newIndex;
            }
            else if (bookmark == CursorBookmark.LAST)
            {
                newIndex = view.length--;
            }
            else if (bookmark != CursorBookmark.CURRENT)
            {
                try
                {
                    newIndex = ListCollectionView(view).getBookmarkIndex(bookmark);
                    if (newIndex < 0)
                    {
                        setCurrent(null);
                        message = resourceManager.getString("collections", "bookmarkInvalid");
                        throw new CursorError(message);
                    }
                }
                catch (bmError:CollectionViewError)
                {
                    message = resourceManager.getString("collections", "bookmarkInvalid");
                    throw new CursorError(message);
                }
            }
            newIndex = newIndex + offset;
            var newCurrent:Object;
            if (newIndex >= view.length)
            {
                currentIndex = AFTER_LAST_INDEX;
            }
            else if (newIndex < 0)
            {
                currentIndex = BEFORE_FIRST_INDEX;
            }
            else
            {
                newCurrent = ListCollectionView(view).getItemAt(newIndex, prefetch);
                currentIndex = newIndex;
            }
            setCurrent(newCurrent);
            return;
        }// end function

        public function insert(param1:Object) : void
        {
            var _loc_2:int = 0;
            var _loc_3:String = null;
            if (afterLast)
            {
                _loc_2 = view.length;
            }
            else if (beforeFirst)
            {
                if (view.length > 0)
                {
                    _loc_3 = resourceManager.getString("collections", "invalidInsert");
                    throw new CursorError(_loc_3);
                }
                _loc_2 = 0;
            }
            else
            {
                _loc_2 = currentIndex;
            }
            ListCollectionView(view).addItemAt(param1, _loc_2);
            return;
        }// end function

        public function get afterLast() : Boolean
        {
            checkValid();
            if (currentIndex != AFTER_LAST_INDEX)
            {
            }
            return view.length == 0;
        }// end function

        private function checkValid() : void
        {
            var _loc_1:String = null;
            if (invalid)
            {
                _loc_1 = resourceManager.getString("collections", "invalidCursor");
                throw new CursorError(_loc_1);
            }
            return;
        }// end function

        private function collectionEventHandler(event:CollectionEvent) : void
        {
            var event:* = event;
            switch(event.kind)
            {
                case CollectionEventKind.ADD:
                {
                    if (event.location <= currentIndex)
                    {
                        currentIndex = currentIndex + event.items.length;
                    }
                    break;
                }
                case CollectionEventKind.REMOVE:
                {
                    if (event.location < currentIndex)
                    {
                        currentIndex = currentIndex - event.items.length;
                    }
                    else if (event.location == currentIndex)
                    {
                        if (currentIndex < view.length)
                        {
                            try
                            {
                                setCurrent(ListCollectionView(view).getItemAt(currentIndex));
                            }
                            catch (error:ItemPendingError)
                            {
                                setCurrent(null, false);
                            }
                        }
                        else
                        {
                            currentIndex = AFTER_LAST_INDEX;
                            setCurrent(null);
                        }
                    }
                    break;
                }
                case CollectionEventKind.MOVE:
                {
                    if (event.oldLocation == currentIndex)
                    {
                        currentIndex = event.location;
                    }
                    else
                    {
                        if (event.oldLocation < currentIndex)
                        {
                            currentIndex = currentIndex - event.items.length;
                        }
                        if (event.location <= currentIndex)
                        {
                            currentIndex = currentIndex + event.items.length;
                        }
                    }
                    break;
                }
                case CollectionEventKind.REFRESH:
                {
                    if (!(beforeFirst || afterLast))
                    {
                        currentIndex = ListCollectionView(view).getItemIndex(currentValue);
                        if (currentIndex == -1)
                        {
                            setCurrent(null);
                        }
                    }
                    break;
                }
                case CollectionEventKind.REPLACE:
                {
                    if (event.location == currentIndex)
                    {
                        try
                        {
                            setCurrent(ListCollectionView(view).getItemAt(currentIndex));
                        }
                        catch (error:ItemPendingError)
                        {
                            setCurrent(null, false);
                        }
                    }
                    break;
                }
                case CollectionEventKind.RESET:
                {
                    currentIndex = BEFORE_FIRST_INDEX;
                    setCurrent(null);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function moveNext() : Boolean
        {
            if (afterLast)
            {
                return false;
            }
            var _loc_1:* = beforeFirst ? (0) : (currentIndex + 1);
            if (_loc_1 >= view.length)
            {
                _loc_1 = AFTER_LAST_INDEX;
                setCurrent(null);
            }
            else
            {
                setCurrent(ListCollectionView(view).getItemAt(_loc_1));
            }
            currentIndex = _loc_1;
            return !afterLast;
        }// end function

        public function get view() : ICollectionView
        {
            checkValid();
            return _view;
        }// end function

        public function movePrevious() : Boolean
        {
            if (beforeFirst)
            {
                return false;
            }
            var _loc_1:* = afterLast ? (view.length--) : (currentIndex--);
            if (_loc_1 == -1)
            {
                _loc_1 = BEFORE_FIRST_INDEX;
                setCurrent(null);
            }
            else
            {
                setCurrent(ListCollectionView(view).getItemAt(_loc_1));
            }
            currentIndex = _loc_1;
            return !beforeFirst;
        }// end function

        public function findLast(param1:Object) : Boolean
        {
            var index:int;
            var values:* = param1;
            checkValid();
            var lcView:* = ListCollectionView(view);
            try
            {
                index = lcView.findItem(values, Sort.LAST_INDEX_MODE);
            }
            catch (sortError:SortError)
            {
                throw new CursorError(sortError.message);
            }
            if (index > -1)
            {
                currentIndex = index;
                setCurrent(lcView.getItemAt(currentIndex));
            }
            return index > -1;
        }// end function

        public function get beforeFirst() : Boolean
        {
            checkValid();
            if (currentIndex != BEFORE_FIRST_INDEX)
            {
            }
            return view.length == 0;
        }// end function

        public function get bookmark() : CursorBookmark
        {
            checkValid();
            if (view.length == 0 || beforeFirst)
            {
                return CursorBookmark.FIRST;
            }
            if (afterLast)
            {
                return CursorBookmark.LAST;
            }
            return ListCollectionView(view).getBookmark(currentIndex);
        }// end function

        public function findFirst(param1:Object) : Boolean
        {
            var index:int;
            var values:* = param1;
            checkValid();
            var lcView:* = ListCollectionView(view);
            try
            {
                index = lcView.findItem(values, Sort.FIRST_INDEX_MODE);
            }
            catch (sortError:SortError)
            {
                throw new CursorError(sortError.message);
            }
            if (index > -1)
            {
                currentIndex = index;
                setCurrent(lcView.getItemAt(currentIndex));
            }
            return index > -1;
        }// end function

        public function get current() : Object
        {
            checkValid();
            return currentValue;
        }// end function

    }
}
