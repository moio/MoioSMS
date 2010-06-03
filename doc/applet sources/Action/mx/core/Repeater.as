package mx.core
{
    import flash.display.*;
    import flash.events.*;
    import mx.automation.*;
    import mx.collections.*;
    import mx.collections.errors.*;
    import mx.events.*;

    public class Repeater extends UIComponent implements IRepeater
    {
        private var _container:Container;
        private var _count:int = -1;
        private var descriptorIndex:int;
        public var childDescriptors:Array;
        var createdComponents:Array;
        private var collection:ICollectionView;
        private var _currentIndex:int;
        private var created:Boolean = false;
        private var iterator:IViewCursor;
        private var _startingIndex:int = 0;
        private var _recycleChildren:Boolean = false;
        static const VERSION:String = "3.2.0.3958";

        public function Repeater()
        {
            return;
        }// end function

        public function get container() : IContainer
        {
            return _container as IContainer;
        }// end function

        private function createComponentFromDescriptor(param1:int, param2:int, param3:Boolean) : IFlexDisplayObject
        {
            var _loc_4:* = childDescriptors[param2];
            if (!childDescriptors[param2].document)
            {
                _loc_4.document = document;
            }
            _loc_4.instanceIndices = instanceIndices ? (instanceIndices) : ([]);
            _loc_4.instanceIndices.push(param1);
            _loc_4.repeaters = repeaters;
            _loc_4.repeaters.push(this);
            _loc_4.repeaterIndices = repeaterIndices;
            _loc_4.repeaterIndices.push(startingIndex + param1);
            _loc_4.invalidateProperties();
            var _loc_5:* = Container(container).createComponentFromDescriptor(_loc_4, param3);
            _loc_4.instanceIndices = null;
            _loc_4.repeaters = null;
            _loc_4.repeaterIndices = null;
            dispatchEvent(new Event("nextRepeaterItem"));
            return _loc_5;
        }// end function

        private function responderResultHandler(param1:Object, param2:Object) : void
        {
            execute();
            return;
        }// end function

        private function removeAllChildRepeaters(param1:Container) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:Repeater = null;
            if (param1.childRepeaters)
            {
                _loc_2 = param1.childRepeaters.length;
                while (_loc_3-- >= 0)
                {
                    
                    _loc_4 = param1.childRepeaters[_loc_2--];
                    if (hasDescendant(_loc_4))
                    {
                        removeRepeater(_loc_4);
                    }
                }
            }
            return;
        }// end function

        private function recycle() : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_6:int = 0;
            var _loc_7:Repeater = null;
            var _loc_8:IRepeaterClient = null;
            var _loc_9:int = 0;
            var _loc_10:int = 0;
            var _loc_11:IRepeaterClient = null;
            var _loc_12:IRepeaterClient = null;
            dispatchEvent(new FlexEvent(FlexEvent.REPEAT_START));
            var _loc_1:int = 0;
            var _loc_5:int = 0;
            if (collection && collection.length > 0 && collection.length - startingIndex > 0)
            {
                _loc_1 = positiveMin(collection.length - startingIndex, count);
                _loc_6 = 0;
                _loc_2 = 0;
                while (_loc_2 < _loc_1)
                {
                    
                    _currentIndex = startingIndex + _loc_2;
                    dispatchEvent(new FlexEvent(FlexEvent.REPEAT));
                    if (childDescriptors)
                    {
                        _loc_3 = childDescriptors.length;
                        if (createdComponents.length >= (_loc_2 + 1) * _loc_3)
                        {
                            _loc_4 = 0;
                            while (_loc_4 < _loc_3)
                            {
                                
                                _loc_8 = createdComponents[_loc_2 * _loc_3 + _loc_4];
                                if (_loc_8 is )
                                {
                                    _loc_7 = Repeater(_loc_8);
                                    resetRepeaterIndices(_loc_7, _currentIndex);
                                    _loc_7.owner = this;
                                    _loc_7.execute();
                                }
                                else
                                {
                                    resetRepeaterIndices(_loc_8, _currentIndex);
                                    if (_loc_8 is IDeferredInstantiationUIComponent)
                                    {
                                        IDeferredInstantiationUIComponent(_loc_8).executeBindings(true);
                                    }
                                }
                                _loc_5++;
                                _loc_4++;
                            }
                        }
                        else
                        {
                            _loc_4 = 0;
                            while (_loc_4 < _loc_3)
                            {
                                
                                _loc_9 = container.numChildren;
                                _loc_10 = getIndexForFirstChild() + numCreatedChildren;
                                _loc_11 = IRepeaterClient(createComponentFromDescriptor(_loc_2, _loc_4, true));
                                createdComponents.push(_loc_11);
                                if (_loc_11 is IUIComponent)
                                {
                                    IUIComponent(_loc_11).owner = this;
                                }
                                if (_loc_11 is IAutomationObject)
                                {
                                    IAutomationObject(_loc_11).showInAutomationHierarchy = true;
                                }
                                if (_loc_11 is )
                                {
                                    _loc_7 = Repeater(_loc_11);
                                    _loc_7.reindexDescendants(_loc_9, _loc_10);
                                }
                                else
                                {
                                    container.setChildIndex(DisplayObject(_loc_11), _loc_10);
                                }
                                _loc_5++;
                                _loc_4++;
                            }
                        }
                    }
                    _loc_2++;
                }
            }
            _currentIndex = -1;
            while (createdComponents.length---- >= _loc_5)
            {
                
                _loc_12 = createdComponents.pop();
                if (_loc_12 is )
                {
                    removeRepeater(Repeater(_loc_12));
                    continue;
                }
                if (_loc_12)
                {
                    if (_loc_12 is Container)
                    {
                        removeAllChildren(Container(_loc_12));
                        removeAllChildRepeaters(Container(_loc_12));
                    }
                    if (container.contains(DisplayObject(_loc_12)))
                    {
                        container.removeChild(DisplayObject(_loc_12));
                    }
                    if (_loc_12 is IDeferredInstantiationUIComponent)
                    {
                        IDeferredInstantiationUIComponent(_loc_12).deleteReferenceOnParentDocument(IFlexDisplayObject(parentDocument));
                    }
                }
            }
            dispatchEvent(new FlexEvent(FlexEvent.REPEAT_END));
            return;
        }// end function

        public function get count() : int
        {
            return _count;
        }// end function

        private function reindexDescendants(param1:int, param2:int) : void
        {
            var _loc_5:IRepeaterClient = null;
            var _loc_3:* = container.numChildren - param1;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = IRepeaterClient(container.getChildAt(param1 + _loc_4));
                container.setChildIndex(DisplayObject(_loc_5), param2 + _loc_4);
                _loc_4++;
            }
            return;
        }// end function

        private function adjustIndices(param1:IRepeaterClient, param2:int) : void
        {
            var _loc_3:* = param1.repeaters;
            if (_loc_3 == null)
            {
                return;
            }
            var _loc_4:* = _loc_3.length;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                if (_loc_3[_loc_5] == this)
                {
                    param1.repeaterIndices[_loc_5] = param1.repeaterIndices[_loc_5] + param2;
                    param1.instanceIndices[_loc_5] = param1.instanceIndices[_loc_5] + param2;
                    break;
                }
                _loc_5++;
            }
            return;
        }// end function

        private function positiveMin(param1:int, param2:int) : int
        {
            var _loc_3:int = 0;
            if (param1 >= 0)
            {
                if (param2 >= 0)
                {
                    if (param1 < param2)
                    {
                        _loc_3 = param1;
                    }
                    else
                    {
                        _loc_3 = param2;
                    }
                }
                else
                {
                    _loc_3 = param1;
                }
            }
            else
            {
                _loc_3 = param2;
            }
            return _loc_3;
        }// end function

        function getItemAt(param1:int) : Object
        {
            var result:Object;
            var index:* = param1;
            if (iterator)
            {
                try
                {
                    iterator.seek(CursorBookmark.FIRST, index);
                    result = iterator.current;
                }
                catch (itemPendingError:ItemPendingError)
                {
                    itemPendingError.addResponder(new ItemResponder(responderResultHandler, responderFaultHandler));
                }
            }
            return result;
        }// end function

        public function set count(param1:int) : void
        {
            _count = param1;
            execute();
            dispatchEvent(new Event("countChanged"));
            return;
        }// end function

        private function addItems(param1:int, param2:int) : void
        {
            var _loc_3:int = 0;
            var _loc_6:IRepeaterClient = null;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            var _loc_10:int = 0;
            var _loc_11:int = 0;
            var _loc_12:int = 0;
            var _loc_13:IFlexDisplayObject = null;
            var _loc_14:Repeater = null;
            if (startingIndex > param2)
            {
                return;
            }
            var _loc_4:int = -1;
            var _loc_5:* = container.numChildren;
            if (param2 == collection.length--)
            {
                while (_loc_3-- >= 0)
                {
                    
                    _loc_6 = IRepeaterClient(container.getChildAt(_loc_5--));
                    _loc_7 = getRepeaterIndex(_loc_6);
                    if (_loc_7 != -1)
                    {
                        _loc_4 = _loc_3 + 1;
                        break;
                    }
                }
            }
            else
            {
                _loc_8 = param2 - param1 + 1;
                _loc_3 = 0;
                while (_loc_3 < _loc_5)
                {
                    
                    _loc_6 = IRepeaterClient(container.getChildAt(_loc_3));
                    _loc_7 = getRepeaterIndex(_loc_6);
                    if (_loc_7 != -1)
                    {
                        if (param1 <= _loc_7 && _loc_7 <= param2 && _loc_4 == -1)
                        {
                            _loc_4 = _loc_3;
                        }
                        if (_loc_7 >= param1)
                        {
                            adjustIndices(_loc_6, _loc_8);
                        }
                    }
                    _loc_3++;
                }
            }
            if (count == -1)
            {
                _loc_5 = param2;
            }
            else
            {
                _loc_5 = positiveMin((startingIndex + count)--, param2);
            }
            _loc_3 = Math.max(startingIndex, param1);
            while (_loc_3 <= _loc_5)
            {
                
                _loc_9 = childDescriptors.length;
                _currentIndex = _loc_3;
                dispatchEvent(new FlexEvent(FlexEvent.REPEAT));
                _loc_10 = 0;
                while (_loc_10 < _loc_9)
                {
                    
                    _loc_11 = container.numChildren;
                    _loc_12 = getIndexForFirstChild() + numCreatedChildren;
                    _loc_13 = createComponentFromDescriptor(_loc_3 - startingIndex, _loc_10, true);
                    createdComponents.push(_loc_13);
                    if (_loc_13 is IUIComponent)
                    {
                        IUIComponent(_loc_13).owner = this;
                    }
                    if (_loc_13 is IAutomationObject)
                    {
                        IAutomationObject(_loc_13).showInAutomationHierarchy = true;
                    }
                    if (_loc_13 is )
                    {
                        _loc_14 = Repeater(_loc_13);
                        _loc_14.owner = this;
                        _loc_14.reindexDescendants(_loc_11, _loc_12);
                    }
                    else
                    {
                        container.setChildIndex(DisplayObject(_loc_13), _loc_12);
                    }
                    _loc_10++;
                }
                _loc_3++;
            }
            _currentIndex = -1;
            return;
        }// end function

        private function get numCreatedChildren() : int
        {
            var _loc_3:IFlexDisplayObject = null;
            var _loc_4:Repeater = null;
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            while (_loc_2 < createdComponents.length)
            {
                
                _loc_3 = createdComponents[_loc_2];
                if (_loc_3 is )
                {
                    _loc_4 = Repeater(_loc_3);
                    _loc_1 = _loc_1 + _loc_4.numCreatedChildren;
                }
                else
                {
                    _loc_1 = _loc_1 + 1;
                }
                _loc_2++;
            }
            return _loc_1;
        }// end function

        private function removeChildRepeater(param1:Container, param2:Repeater) : void
        {
            var _loc_3:int = 0;
            var _loc_4:* = param1.childRepeaters.length;
            while (_loc_3 < _loc_4)
            {
                
                if (param1.repeaters[_loc_3] == param2)
                {
                    param1.repeaters.splice(_loc_3, 1);
                    break;
                }
                _loc_3++;
            }
            return;
        }// end function

        private function removeAllChildren(param1:IContainer) : void
        {
            var _loc_4:IRepeaterClient = null;
            var _loc_2:* = param1.numChildren;
            while (_loc_3-- >= 0)
            {
                
                _loc_4 = IRepeaterClient(param1.getChildAt(_loc_2--));
                if (hasDescendant(_loc_4))
                {
                    if (_loc_4 is Container)
                    {
                        removeAllChildren(Container(_loc_4));
                        removeAllChildRepeaters(Container(_loc_4));
                    }
                    param1.removeChildAt(_loc_3);
                    if (_loc_4 is IDeferredInstantiationUIComponent)
                    {
                        IDeferredInstantiationUIComponent(_loc_4).deleteReferenceOnParentDocument(IFlexDisplayObject(parentDocument));
                    }
                }
            }
            return;
        }// end function

        public function get currentItem() : Object
        {
            var result:Object;
            var message:String;
            if (_currentIndex == -1)
            {
                message = resourceManager.getString("core", "notExecuting");
                throw new Error(message);
            }
            if (iterator)
            {
                try
                {
                    iterator.seek(CursorBookmark.FIRST, _currentIndex);
                    result = iterator.current;
                }
                catch (itemPendingError:ItemPendingError)
                {
                    itemPendingError.addResponder(new ItemResponder(responderResultHandler, responderFaultHandler));
                }
            }
            return result;
        }// end function

        private function resetRepeaterIndices(param1:IRepeaterClient, param2:int) : void
        {
            var _loc_4:Container = null;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:IRepeaterClient = null;
            var _loc_3:* = param1.repeaterIndices;
            _loc_3[_loc_3.length--] = param2;
            param1.repeaterIndices = _loc_3;
            if (param1 is Container)
            {
                _loc_4 = Container(param1);
                _loc_5 = _loc_4.numChildren;
                _loc_6 = 0;
                while (_loc_6 < _loc_5)
                {
                    
                    _loc_7 = IRepeaterClient(_loc_4.getChildAt(_loc_6));
                    resetRepeaterIndices(_loc_7, param2);
                    _loc_6++;
                }
            }
            return;
        }// end function

        public function get recycleChildren() : Boolean
        {
            return _recycleChildren;
        }// end function

        private function collectionChangedHandler(event:CollectionEvent) : void
        {
            switch(event.kind)
            {
                case CollectionEventKind.UPDATE:
                {
                    break;
                }
                default:
                {
                    execute();
                    break;
                }
            }
            return;
        }// end function

        private function getIndexForRepeater(param1:Repeater, param2:LocationInfo) : void
        {
            var _loc_5:IFlexDisplayObject = null;
            var _loc_6:Repeater = null;
            var _loc_3:int = 0;
            var _loc_4:* = createdComponents.length;
            while (_loc_3 < _loc_4)
            {
                
                _loc_5 = createdComponents[_loc_3];
                if (_loc_5 == param1)
                {
                    param2.found = true;
                    break;
                }
                else if (_loc_5 is )
                {
                    _loc_6 = Repeater(_loc_5);
                    _loc_6.getIndexForRepeater(param1, param2);
                    if (param2.found)
                    {
                        break;
                    }
                }
                else
                {
                    param2.index = param2.index + 1;
                }
                _loc_3++;
            }
            return;
        }// end function

        private function hasDescendant(param1:Object) : Boolean
        {
            var _loc_2:* = param1.repeaters;
            if (_loc_2 == null)
            {
                return false;
            }
            var _loc_3:* = _loc_2.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (_loc_2[_loc_4] == this)
                {
                    return true;
                }
                _loc_4++;
            }
            return false;
        }// end function

        public function initializeRepeater(param1:IContainer, param2:Boolean) : void
        {
            _container = Container(param1);
            descriptorIndex = param1.numChildren;
            created = true;
            if (collection)
            {
                createComponentsFromDescriptors(param2);
            }
            if (owner == null)
            {
                owner = Container(param1);
            }
            return;
        }// end function

        public function get dataProvider() : Object
        {
            return collection;
        }// end function

        private function removeItems(param1:int, param2:int) : void
        {
            var _loc_3:int = 0;
            var _loc_4:IRepeaterClient = null;
            var _loc_5:int = 0;
            var _loc_6:Repeater = null;
            if (createdComponents && createdComponents.length > 0)
            {
                while (_loc_3-- >= 0)
                {
                    
                    _loc_4 = createdComponents[createdComponents.length--];
                    _loc_5 = getRepeaterIndex(_loc_4);
                    if (param1 <= _loc_5 && _loc_5 < param2 || param2 == -1 || _loc_5 >= dataProvider.length)
                    {
                        if (_loc_4 is )
                        {
                            _loc_6 = Repeater(_loc_4);
                            removeRepeater(_loc_6);
                        }
                        else if (container.contains(DisplayObject(_loc_4)))
                        {
                            container.removeChild(DisplayObject(_loc_4));
                        }
                        if (_loc_4 is IDeferredInstantiationUIComponent)
                        {
                            IDeferredInstantiationUIComponent(_loc_4).deleteReferenceOnParentDocument(IFlexDisplayObject(parentDocument));
                        }
                        createdComponents.splice(_loc_3, 1);
                        continue;
                    }
                    if (param1 <= _loc_5 && param2 != -1 && _loc_5 >= param2)
                    {
                        adjustIndices(_loc_4, param2 - param1 + 1);
                        if (_loc_4 is IDeferredInstantiationUIComponent)
                        {
                            IDeferredInstantiationUIComponent(_loc_4).executeBindings(true);
                        }
                    }
                }
            }
            return;
        }// end function

        private function getIndexForFirstChild() : int
        {
            var _loc_5:IFlexDisplayObject = null;
            var _loc_6:Repeater = null;
            var _loc_1:* = new LocationInfo();
            var _loc_2:int = 0;
            var _loc_3:* = Container(container).createdComponents;
            var _loc_4:* = _loc_3 ? (_loc_3.length) : (0);
            while (_loc_2 < _loc_4)
            {
                
                _loc_5 = Container(container).createdComponents[_loc_2];
                if (_loc_5 == this)
                {
                    _loc_1.found = true;
                    break;
                }
                else if (_loc_5 is )
                {
                    _loc_6 = Repeater(_loc_5);
                    _loc_6.getIndexForRepeater(this, _loc_1);
                    if (_loc_1.found)
                    {
                        break;
                    }
                }
                else
                {
                    _loc_1.index = _loc_1.index + 1;
                }
                _loc_2++;
            }
            return _loc_1.found ? (_loc_1.index) : (container.numChildren);
        }// end function

        private function createComponentsFromDescriptors(param1:Boolean) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:IFlexDisplayObject = null;
            dispatchEvent(new FlexEvent(FlexEvent.REPEAT_START));
            createdComponents = [];
            if (collection && collection.length > 0 && collection.length - startingIndex > 0)
            {
                _loc_2 = positiveMin(collection.length - startingIndex, count);
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    _currentIndex = startingIndex + _loc_3;
                    dispatchEvent(new FlexEvent(FlexEvent.REPEAT));
                    if (childDescriptors && childDescriptors.length > 0)
                    {
                        _loc_4 = childDescriptors.length;
                        _loc_5 = 0;
                        while (_loc_5 < _loc_4)
                        {
                            
                            _loc_6 = createComponentFromDescriptor(_loc_3, _loc_5, param1);
                            createdComponents.push(_loc_6);
                            if (_loc_6 is IUIComponent)
                            {
                                IUIComponent(_loc_6).owner = this;
                            }
                            if (_loc_6 is IAutomationObject)
                            {
                                IAutomationObject(_loc_6).showInAutomationHierarchy = true;
                            }
                            _loc_5++;
                        }
                    }
                    _loc_3++;
                }
                _currentIndex = -1;
            }
            dispatchEvent(new FlexEvent(FlexEvent.REPEAT_END));
            return;
        }// end function

        private function sort() : void
        {
            execute();
            return;
        }// end function

        private function removeRepeater(param1:Repeater) : void
        {
            param1.removeAllChildren(param1.container);
            param1.removeAllChildRepeaters(Container(param1.container));
            removeChildRepeater(Container(container), param1);
            param1.deleteReferenceOnParentDocument(IFlexDisplayObject(parentDocument));
            param1.dataProvider = null;
            return;
        }// end function

        public function executeChildBindings() : void
        {
            var _loc_3:IRepeaterClient = null;
            var _loc_1:* = container.numChildren;
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = IRepeaterClient(container.getChildAt(_loc_2));
                if (hasDescendant(_loc_3) && _loc_3 is IDeferredInstantiationUIComponent)
                {
                    IDeferredInstantiationUIComponent(_loc_3).executeBindings();
                }
                _loc_2++;
            }
            return;
        }// end function

        public function get currentIndex() : int
        {
            var _loc_1:String = null;
            if (_currentIndex == -1)
            {
                _loc_1 = resourceManager.getString("core", "notExecuting");
                throw new Error(_loc_1);
            }
            return _currentIndex;
        }// end function

        public function set startingIndex(param1:int) : void
        {
            _startingIndex = param1;
            execute();
            dispatchEvent(new Event("startingIndexChanged"));
            return;
        }// end function

        private function responderFaultHandler(param1:Object, param2:Object) : void
        {
            return;
        }// end function

        override public function toString() : String
        {
            return Object(container).toString() + "." + super.toString();
        }// end function

        private function recreate() : void
        {
            removeAllChildren(container);
            removeAllChildRepeaters(Container(container));
            var _loc_1:* = container.numChildren;
            var _loc_2:* = getIndexForFirstChild();
            createComponentsFromDescriptors(true);
            if (_loc_1 != _loc_2)
            {
                reindexDescendants(_loc_1, _loc_2);
            }
            return;
        }// end function

        public function get startingIndex() : int
        {
            return _startingIndex;
        }// end function

        private function getRepeaterIndex(param1:IRepeaterClient) : int
        {
            var _loc_2:* = param1.repeaters;
            if (_loc_2 == null)
            {
                return -1;
            }
            var _loc_3:* = _loc_2.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (_loc_2[_loc_4] == this)
                {
                    return param1.repeaterIndices[_loc_4];
                }
                _loc_4++;
            }
            return -1;
        }// end function

        private function execute() : void
        {
            if (!created)
            {
                return;
            }
            if (recycleChildren && createdComponents && createdComponents.length > 0)
            {
                recycle();
            }
            else
            {
                recreate();
            }
            return;
        }// end function

        override public function set showInAutomationHierarchy(param1:Boolean) : void
        {
            return;
        }// end function

        public function set recycleChildren(param1:Boolean) : void
        {
            _recycleChildren = param1;
            return;
        }// end function

        public function set dataProvider(param1:Object) : void
        {
            var _loc_3:XMLList = null;
            var _loc_4:Array = null;
            var _loc_2:Boolean = false;
            if (collection)
            {
                _loc_2 = true;
                collection.removeEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangedHandler);
                collection = null;
                iterator = null;
            }
            if (param1 is Array)
            {
                collection = new ArrayCollection(param1 as Array);
            }
            else if (param1 is ICollectionView)
            {
                collection = ICollectionView(param1);
            }
            else if (param1 is IList)
            {
                collection = new ListCollectionView(IList(param1));
            }
            else if (param1 is XMLList)
            {
                collection = new XMLListCollection(param1 as XMLList);
            }
            else if (param1 is XML)
            {
                _loc_3 = new XMLList();
                _loc_3 = _loc_3 + param1;
                collection = new XMLListCollection(_loc_3);
            }
            else if (param1 != null)
            {
                _loc_4 = [param1];
                collection = new ArrayCollection(_loc_4);
            }
            if (collection)
            {
                collection.addEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangedHandler, false, 0, true);
                iterator = collection.createCursor();
            }
            dispatchEvent(new Event("collectionChange"));
            if (collection || _loc_2)
            {
                execute();
            }
            return;
        }// end function

        private function updateItems(param1:int, param2:int) : void
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:IRepeaterClient = null;
            var _loc_6:int = 0;
            if (recycleChildren)
            {
                _loc_3 = container.numChildren;
                _loc_4 = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    _loc_5 = IRepeaterClient(container.getChildAt(_loc_4));
                    _loc_6 = getRepeaterIndex(_loc_5);
                    if (_loc_6 != -1 && param1 <= _loc_6 && _loc_6 <= param2)
                    {
                        if (_loc_5 is IDeferredInstantiationUIComponent)
                        {
                            IDeferredInstantiationUIComponent(_loc_5).executeBindings(true);
                        }
                    }
                    _loc_4++;
                }
            }
            else
            {
                removeItems(param1, param2);
                addItems(param1, param2);
            }
            return;
        }// end function

    }
}
