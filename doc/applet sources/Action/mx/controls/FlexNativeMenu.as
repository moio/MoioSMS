package mx.controls
{
    import flash.display.*;
    import flash.events.*;
    import flash.ui.*;
    import flash.utils.*;
    import flash.xml.*;
    import mx.collections.*;
    import mx.collections.errors.*;
    import mx.controls.menuClasses.*;
    import mx.controls.treeClasses.*;
    import mx.core.*;
    import mx.events.*;

    public class FlexNativeMenu extends EventDispatcher implements ILayoutManagerClient, IFlexContextMenu
    {
        private var _labelField:String = "label";
        private var _initialized:Boolean = false;
        private var _keyEquivalentFunction:Function;
        private var keyEquivalentFieldChanged:Boolean = false;
        private var _mnemonicIndexFunction:Function;
        private var showRootChanged:Boolean = false;
        private var _mnemonicIndexField:String = "mnemonicIndex";
        private var invalidatePropertiesFlag:Boolean = false;
        private var _hasRoot:Boolean = false;
        private var labelFieldChanged:Boolean = false;
        private var _keyEquivalentModifiersFunction:Function;
        private var dataProviderChanged:Boolean = false;
        private var _nestLevel:int = 1;
        private var _processedDescriptors:Boolean = false;
        private var _updateCompletePendingFlag:Boolean = false;
        private var mnemonicIndexFieldChanged:Boolean = false;
        private var _nativeMenu:NativeMenu;
        private var dataDescriptorChanged:Boolean = false;
        private var _dataDescriptor:IMenuDataDescriptor;
        private var _showRoot:Boolean = true;
        var _rootModel:ICollectionView;
        private var _labelFunction:Function;
        private var keyEquivalentModifiersFunctionChanged:Boolean = false;
        private var _keyEquivalentField:String = "keyEquivalent";
        static const VERSION:String = "3.2.0.3958";
        private static var MNEMONIC_INDEX_CHARACTER:String = "_";

        public function FlexNativeMenu()
        {
            _nativeMenu = new NativeMenu();
            _dataDescriptor = new DefaultDataDescriptor();
            _keyEquivalentModifiersFunction = keyEquivalentModifiersDefaultFunction;
            _nativeMenu.addEventListener(Event.DISPLAYING, menuDisplayHandler, false, 0, true);
            return;
        }// end function

        public function get nestLevel() : int
        {
            return _nestLevel;
        }// end function

        public function get nativeMenu() : NativeMenu
        {
            return _nativeMenu;
        }// end function

        public function set nestLevel(param1:int) : void
        {
            _nestLevel = param1;
            invalidateProperties();
            return;
        }// end function

        public function get updateCompletePendingFlag() : Boolean
        {
            return _updateCompletePendingFlag;
        }// end function

        public function get mnemonicIndexFunction() : Function
        {
            return _mnemonicIndexFunction;
        }// end function

        public function get keyEquivalentFunction() : Function
        {
            return _keyEquivalentFunction;
        }// end function

        protected function parseLabelToMnemonicIndex(param1:String) : int
        {
            var _loc_7:String = null;
            var _loc_8:int = 0;
            var _loc_2:* = new RegExp(MNEMONIC_INDEX_CHARACTER + MNEMONIC_INDEX_CHARACTER, "g");
            var _loc_3:* = param1.split(_loc_2);
            var _loc_4:* = _loc_3.length;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            while (_loc_6 < _loc_4)
            {
                
                _loc_7 = String(_loc_3[_loc_6]);
                _loc_8 = _loc_7.indexOf(MNEMONIC_INDEX_CHARACTER);
                if (_loc_8 >= 0)
                {
                    return _loc_8 + _loc_5;
                }
                _loc_5 = _loc_5 + (_loc_7.length + MNEMONIC_INDEX_CHARACTER.length);
                _loc_6++;
            }
            return -1;
        }// end function

        public function validateSize(param1:Boolean = false) : void
        {
            return;
        }// end function

        public function set updateCompletePendingFlag(param1:Boolean) : void
        {
            _updateCompletePendingFlag = param1;
            return;
        }// end function

        private function clearMenu(param1:NativeMenu) : void
        {
            var _loc_2:* = param1.numItems;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                param1.removeItemAt(0);
                _loc_3++;
            }
            return;
        }// end function

        public function set mnemonicIndexFunction(param1:Function) : void
        {
            if (_mnemonicIndexFunction != param1)
            {
                _mnemonicIndexFunction = param1;
                mnemonicIndexFieldChanged = true;
                invalidateProperties();
                dispatchEvent(new Event("mnemonicIndexFunctionChanged"));
            }
            return;
        }// end function

        public function get keyEquivalentField() : String
        {
            return _keyEquivalentField;
        }// end function

        public function set mnemonicIndexField(param1:String) : void
        {
            if (_mnemonicIndexField != param1)
            {
                _mnemonicIndexField = param1;
                mnemonicIndexFieldChanged = true;
                invalidateProperties();
                dispatchEvent(new Event("mnemonicIndexFieldChanged"));
            }
            return;
        }// end function

        private function itemSelectHandler(event:Event) : void
        {
            var _loc_5:Boolean = false;
            var _loc_2:* = event.target as NativeMenuItem;
            var _loc_3:* = dataDescriptor.getType(_loc_2.data).toLowerCase();
            if (_loc_3 == "check")
            {
                _loc_5 = !dataDescriptor.isToggled(_loc_2.data);
                _loc_2.checked = _loc_5;
                dataDescriptor.setToggled(_loc_2.data, _loc_5);
            }
            var _loc_4:* = new FlexNativeMenuEvent(FlexNativeMenuEvent.ITEM_CLICK);
            new FlexNativeMenuEvent(FlexNativeMenuEvent.ITEM_CLICK).nativeMenu = _loc_2.menu;
            _loc_4.index = _loc_2.menu.getItemIndex(_loc_2);
            _loc_4.nativeMenuItem = _loc_2;
            _loc_4.label = _loc_2.label;
            _loc_4.item = _loc_2.data;
            dispatchEvent(_loc_4);
            return;
        }// end function

        public function get keyEquivalentModifiersFunction() : Function
        {
            return _keyEquivalentModifiersFunction;
        }// end function

        public function set keyEquivalentFunction(param1:Function) : void
        {
            if (_keyEquivalentFunction != param1)
            {
                _keyEquivalentFunction = param1;
                keyEquivalentFieldChanged = true;
                invalidateProperties();
                dispatchEvent(new Event("keyEquivalentFunctionChanged"));
            }
            return;
        }// end function

        private function keyEquivalentModifiersDefaultFunction(param1:Object) : Array
        {
            var i:int;
            var modifier:*;
            var data:* = param1;
            var modifiers:Array;
            var xmlModifiers:Array;
            var objectModifiers:Array;
            var keyboardModifiers:Array;
            if (data is XML)
            {
                i;
                while (i < xmlModifiers.length)
                {
                    
                    try
                    {
                        modifier = data[xmlModifiers[i]];
                        if (modifier[0] == true)
                        {
                            modifiers.push(keyboardModifiers[i]);
                        }
                    }
                    catch (e:Error)
                    {
                    }
                    i = i++;
                }
            }
            else if (data is Object)
            {
                i;
                while (i < objectModifiers.length)
                {
                    
                    try
                    {
                        modifier = data[objectModifiers[i]];
                        if (String(modifier).toLowerCase() == "true")
                        {
                            modifiers.push(keyboardModifiers[i]);
                        }
                    }
                    catch (e:Error)
                    {
                    }
                    i = i++;
                }
            }
            return modifiers;
        }// end function

        private function menuDisplayHandler(event:Event) : void
        {
            var _loc_2:* = event.target as NativeMenu;
            var _loc_3:* = new FlexNativeMenuEvent(FlexNativeMenuEvent.MENU_SHOW);
            _loc_3.nativeMenu = _loc_2;
            dispatchEvent(_loc_3);
            return;
        }// end function

        private function populateMenu(param1:NativeMenu, param2:ICollectionView) : NativeMenu
        {
            var menu:* = param1;
            var collection:* = param2;
            var collectionLength:* = collection.length;
            var i:int;
            while (i < collectionLength)
            {
                
                try
                {
                    insertMenuItem(menu, i, collection[i]);
                }
                catch (e:ItemPendingError)
                {
                }
                i = i++;
            }
            return menu;
        }// end function

        public function set processedDescriptors(param1:Boolean) : void
        {
            _processedDescriptors = param1;
            return;
        }// end function

        public function get labelField() : String
        {
            return _labelField;
        }// end function

        public function set dataDescriptor(param1:IMenuDataDescriptor) : void
        {
            _dataDescriptor = param1;
            dataDescriptorChanged = true;
            return;
        }// end function

        private function createMenu() : NativeMenu
        {
            var _loc_1:* = new NativeMenu();
            _loc_1.addEventListener(Event.DISPLAYING, menuDisplayHandler, false, 0, true);
            return _loc_1;
        }// end function

        private function collectionChangeHandler(event:CollectionEvent) : void
        {
            if (event.kind == CollectionEventKind.ADD)
            {
                dataProviderChanged = true;
                invalidateProperties();
            }
            else if (event.kind == CollectionEventKind.REMOVE)
            {
                dataProviderChanged = true;
                invalidateProperties();
            }
            else if (event.kind == CollectionEventKind.REFRESH)
            {
                dataProviderChanged = true;
                dataProvider = dataProvider;
                invalidateProperties();
            }
            else if (event.kind == CollectionEventKind.RESET)
            {
                dataProviderChanged = true;
                invalidateProperties();
            }
            else if (event.kind == CollectionEventKind.UPDATE)
            {
                dataProviderChanged = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function set dataProvider(param1:Object) : void
        {
            var _loc_3:XMLList = null;
            var _loc_4:Array = null;
            if (mx_internal::_rootModel)
            {
                mx_internal::_rootModel.removeEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangeHandler);
            }
            if (typeof(param1) == "string")
            {
                param1 = new XML(param1);
            }
            else if (param1 is XMLNode)
            {
                param1 = new XML(XMLNode(param1).toString());
            }
            else if (param1 is XMLList)
            {
                param1 = new XMLListCollection(param1 as XMLList);
            }
            if (param1 is XML)
            {
                _hasRoot = true;
                _loc_3 = new XMLList();
                _loc_3 = _loc_3 + param1;
                mx_internal::_rootModel = new XMLListCollection(_loc_3);
            }
            else if (param1 is ICollectionView)
            {
                mx_internal::_rootModel = ICollectionView(param1);
                if (mx_internal::_rootModel.length == 1)
                {
                    _hasRoot = true;
                }
            }
            else if (param1 is Array)
            {
                mx_internal::_rootModel = new ArrayCollection(param1 as Array);
            }
            else if (param1 is Object)
            {
                _hasRoot = true;
                _loc_4 = [];
                _loc_4.push(param1);
                mx_internal::_rootModel = new ArrayCollection(_loc_4);
            }
            else
            {
                mx_internal::_rootModel = new ArrayCollection();
            }
            mx_internal::_rootModel.addEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangeHandler, false, 0, true);
            dataProviderChanged = true;
            invalidateProperties();
            var _loc_2:* = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
            _loc_2.kind = CollectionEventKind.RESET;
            collectionChangeHandler(_loc_2);
            dispatchEvent(_loc_2);
            return;
        }// end function

        public function get showRoot() : Boolean
        {
            return _showRoot;
        }// end function

        public function validateDisplayList() : void
        {
            return;
        }// end function

        protected function parseLabelToString(param1:String) : String
        {
            var _loc_7:String = null;
            var _loc_2:* = new RegExp(MNEMONIC_INDEX_CHARACTER, "g");
            var _loc_3:* = new RegExp(MNEMONIC_INDEX_CHARACTER + MNEMONIC_INDEX_CHARACTER, "g");
            var _loc_4:* = param1.split(_loc_3);
            var _loc_5:* = param1.split(_loc_3).length;
            var _loc_6:int = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_7 = String(_loc_4[_loc_6]);
                _loc_4[_loc_6] = _loc_7.replace(_loc_2, "");
                _loc_6++;
            }
            return _loc_4.join(MNEMONIC_INDEX_CHARACTER);
        }// end function

        public function set keyEquivalentModifiersFunction(param1:Function) : void
        {
            if (_keyEquivalentModifiersFunction != param1)
            {
                _keyEquivalentModifiersFunction = param1;
                keyEquivalentModifiersFunctionChanged = true;
                invalidateProperties();
                dispatchEvent(new Event("keyEquivalentModifiersFunctionChanged"));
            }
            return;
        }// end function

        public function get hasRoot() : Boolean
        {
            return _hasRoot;
        }// end function

        public function set keyEquivalentField(param1:String) : void
        {
            if (_keyEquivalentField != param1)
            {
                _keyEquivalentField = param1;
                keyEquivalentFieldChanged = true;
                invalidateProperties();
                dispatchEvent(new Event("keyEquivalentFieldChanged"));
            }
            return;
        }// end function

        protected function itemToLabel(param1:Object) : String
        {
            var data:* = param1;
            if (data == null)
            {
                return " ";
            }
            if (labelFunction != null)
            {
                return labelFunction(data);
            }
            if (data is XML)
            {
                try
                {
                    if (data[labelField].length() != 0)
                    {
                        data = data[labelField];
                    }
                }
                catch (e:Error)
                {
                }
            }
            else if (data is Object)
            {
                try
                {
                    if (data[labelField] != null)
                    {
                        data = data[labelField];
                    }
                }
                catch (e:Error)
                {
                }
            }
            else if (data is String)
            {
                return String(data);
            }
            try
            {
                return data.toString();
            }
            catch (e:Error)
            {
            }
            return " ";
        }// end function

        public function set initialized(param1:Boolean) : void
        {
            _initialized = param1;
            return;
        }// end function

        public function get mnemonicIndexField() : String
        {
            return _mnemonicIndexField;
        }// end function

        public function get processedDescriptors() : Boolean
        {
            return _processedDescriptors;
        }// end function

        public function get dataDescriptor() : IMenuDataDescriptor
        {
            return IMenuDataDescriptor(_dataDescriptor);
        }// end function

        public function get dataProvider() : Object
        {
            if (mx_internal::_rootModel)
            {
                return mx_internal::_rootModel;
            }
            return null;
        }// end function

        public function display(param1:Stage, param2:int, param3:int) : void
        {
            nativeMenu.display(param1, param2, param3);
            return;
        }// end function

        protected function commitProperties() : void
        {
            var _loc_1:ICollectionView = null;
            var _loc_2:* = undefined;
            if (showRootChanged)
            {
                if (!_hasRoot)
                {
                    showRootChanged = false;
                }
            }
            if (dataProviderChanged || showRootChanged || labelFieldChanged || dataDescriptorChanged)
            {
                dataProviderChanged = false;
                showRootChanged = false;
                labelFieldChanged = false;
                dataDescriptorChanged = false;
                if (mx_internal::_rootModel && !_showRoot && _hasRoot)
                {
                    _loc_2 = mx_internal::_rootModel.createCursor().current;
                    if (_loc_2 != null && _dataDescriptor.isBranch(_loc_2, mx_internal::_rootModel) && _dataDescriptor.hasChildren(_loc_2, mx_internal::_rootModel))
                    {
                        _loc_1 = _dataDescriptor.getChildren(_loc_2, mx_internal::_rootModel);
                    }
                }
                clearMenu(_nativeMenu);
                if (mx_internal::_rootModel)
                {
                    if (!_loc_1)
                    {
                        _loc_1 = mx_internal::_rootModel;
                    }
                    _loc_1.addEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangeHandler, false, EventPriority.DEFAULT_HANDLER, true);
                    populateMenu(_nativeMenu, _loc_1);
                }
                dispatchEvent(new Event("nativeMenuChange"));
            }
            return;
        }// end function

        public function unsetContextMenu(param1:InteractiveObject) : void
        {
            param1.contextMenu = null;
            return;
        }// end function

        public function invalidateProperties() : void
        {
            var _loc_1:Timer = null;
            if (!invalidatePropertiesFlag && nestLevel > 0)
            {
                invalidatePropertiesFlag = true;
                if (mx_internal::layoutManager)
                {
                    mx_internal::layoutManager.invalidateProperties(this);
                }
                else
                {
                    _loc_1 = new Timer(100, 1);
                    _loc_1.addEventListener(TimerEvent.TIMER, validatePropertiesTimerHandler);
                    _loc_1.start();
                }
            }
            return;
        }// end function

        public function set labelField(param1:String) : void
        {
            if (_labelField != param1)
            {
                _labelField = param1;
                labelFieldChanged = true;
                invalidateProperties();
                dispatchEvent(new Event("labelFieldChanged"));
            }
            return;
        }// end function

        public function get initialized() : Boolean
        {
            return _initialized;
        }// end function

        public function validatePropertiesTimerHandler(event:TimerEvent) : void
        {
            validateProperties();
            return;
        }// end function

        public function set labelFunction(param1:Function) : void
        {
            if (_labelFunction != param1)
            {
                _labelFunction = param1;
                labelFieldChanged = true;
                invalidateProperties();
                dispatchEvent(new Event("labelFunctionChanged"));
            }
            return;
        }// end function

        protected function itemToKeyEquivalentModifiers(param1:Object) : Array
        {
            if (param1 == null)
            {
                return [];
            }
            if (keyEquivalentModifiersFunction != null)
            {
                return keyEquivalentModifiersFunction(param1);
            }
            return [];
        }// end function

        protected function itemToKeyEquivalent(param1:Object) : String
        {
            var data:* = param1;
            if (data == null)
            {
                return "";
            }
            if (keyEquivalentFunction != null)
            {
                return keyEquivalentFunction(data);
            }
            if (data is XML)
            {
                try
                {
                    if (data[keyEquivalentField].length() != 0)
                    {
                        data = data[keyEquivalentField];
                        return data.toString();
                    }
                }
                catch (e:Error)
                {
                }
            }
            else if (data is Object)
            {
                try
                {
                    if (data[keyEquivalentField] != null)
                    {
                        data = data[keyEquivalentField];
                        return data.toString();
                    }
                }
                catch (e:Error)
                {
                }
            }
            return "";
        }// end function

        public function validateNow() : void
        {
            if (invalidatePropertiesFlag)
            {
                validateProperties();
            }
            return;
        }// end function

        private function insertMenuItem(param1:NativeMenu, param2:int, param3:Object) : void
        {
            var _loc_7:String = null;
            var _loc_8:int = 0;
            if (dataProviderChanged)
            {
                commitProperties();
                return;
            }
            var _loc_4:* = dataDescriptor.getType(param3).toLowerCase();
            var _loc_5:* = dataDescriptor.getType(param3).toLowerCase() == "separator";
            var _loc_6:* = new NativeMenuItem("", _loc_5);
            if (!_loc_5)
            {
                _loc_6.enabled = dataDescriptor.isEnabled(param3);
                if (_loc_4 == "check")
                {
                }
                _loc_6.checked = dataDescriptor.isToggled(param3);
                _loc_6.data = dataDescriptor.getData(param3, mx_internal::_rootModel);
                _loc_6.keyEquivalent = itemToKeyEquivalent(param3);
                _loc_6.keyEquivalentModifiers = itemToKeyEquivalentModifiers(param3);
                _loc_7 = itemToLabel(param3);
                _loc_8 = itemToMnemonicIndex(param3);
                if (_loc_8 >= 0)
                {
                    _loc_6.label = parseLabelToString(_loc_7);
                    _loc_6.mnemonicIndex = _loc_8;
                }
                else
                {
                    _loc_6.label = parseLabelToString(_loc_7);
                    _loc_6.mnemonicIndex = parseLabelToMnemonicIndex(_loc_7);
                }
                _loc_6.addEventListener(Event.SELECT, itemSelectHandler, false, 0, true);
                if (dataDescriptor.isBranch(param3, mx_internal::_rootModel) && dataDescriptor.hasChildren(param3, mx_internal::_rootModel))
                {
                    _loc_6.submenu = createMenu();
                    populateMenu(_loc_6.submenu, dataDescriptor.getChildren(param3, mx_internal::_rootModel));
                }
            }
            param1.addItem(_loc_6);
            return;
        }// end function

        public function setContextMenu(param1:InteractiveObject) : void
        {
            var _loc_2:ISystemManager = null;
            param1.contextMenu = nativeMenu;
            if (param1 is Application)
            {
                _loc_2 = Application(param1).systemManager;
                if (_loc_2 is InteractiveObject)
                {
                    InteractiveObject(_loc_2).contextMenu = nativeMenu;
                }
            }
            return;
        }// end function

        protected function itemToMnemonicIndex(param1:Object) : int
        {
            var mnemonicIndex:int;
            var data:* = param1;
            if (data == null)
            {
                return -1;
            }
            if (mnemonicIndexFunction != null)
            {
                return mnemonicIndexFunction(data);
            }
            if (data is XML)
            {
                try
                {
                    if (data[mnemonicIndexField].length() != 0)
                    {
                        mnemonicIndex = data[mnemonicIndexField];
                        return mnemonicIndex;
                    }
                }
                catch (e:Error)
                {
                }
            }
            else if (data is Object)
            {
                try
                {
                    if (data[mnemonicIndexField] != null)
                    {
                        mnemonicIndex = data[mnemonicIndexField];
                        return mnemonicIndex;
                    }
                }
                catch (e:Error)
                {
                }
            }
            return -1;
        }// end function

        public function validateProperties() : void
        {
            if (invalidatePropertiesFlag)
            {
                commitProperties();
                invalidatePropertiesFlag = false;
            }
            return;
        }// end function

        public function get labelFunction() : Function
        {
            return _labelFunction;
        }// end function

        public function set showRoot(param1:Boolean) : void
        {
            if (_showRoot != param1)
            {
                showRootChanged = true;
                _showRoot = param1;
                invalidateProperties();
            }
            return;
        }// end function

    }
}
