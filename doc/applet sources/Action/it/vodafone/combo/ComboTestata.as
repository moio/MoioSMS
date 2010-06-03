package it.vodafone.combo
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import it.vodafone.*;
    import mx.binding.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.managers.*;
    import mx.states.*;

    public class ComboTestata extends Canvas implements IBindingClient, IFocusManagerComponent
    {
        private var _107002ldr:Loading;
        private var _documentDescriptor_:UIComponentDescriptor;
        public var _ComboTestata_RemoveChild1:RemoveChild;
        public var _ComboTestata_Label1:Label;
        private var dropdown:ComboTestataSelect;
        var _watchers:Array;
        private var _embed_mxml__________img_v1_back_popup_r_png_717450896:Class;
        private var _embed_mxml__________img_v1_back_popup_png_735332462:Class;
        private var _1093105693_selectedNumber:String;
        private var _1763739238_dataProvider:Array;
        var _bindingsByDestination:Object;
        var _bindingsBeginWithWord:Object;
        private var _652640504_selectedIndex:int;
        private var _1110417475label1:Label;
        var _bindings:Array;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public function ComboTestata()
        {
            this._documentDescriptor_ = new UIComponentDescriptor({type:Canvas, propertiesFactory:function () : Object
            {
                return {width:119, height:20, childDescriptors:[new UIComponentDescriptor({type:Label, id:"label1", stylesFactory:function () : void
                {
                    this.fontFamily = "defFont";
                    this.fontWeight = "bold";
                    this.fontSize = 15;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {x:5, y:-1, mouseEnabled:false};
                }// end function
                })]};
            }// end function
            });
            this._embed_mxml__________img_v1_back_popup_png_735332462 = ComboTestata__embed_mxml__________img_v1_back_popup_png_735332462;
            this._embed_mxml__________img_v1_back_popup_r_png_717450896 = ComboTestata__embed_mxml__________img_v1_back_popup_r_png_717450896;
            this._bindings = [];
            this._watchers = [];
            this._bindingsByDestination = {};
            this._bindingsBeginWithWord = {};
            mx_internal::_document = this;
            this.width = 119;
            this.height = 20;
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            this.tabEnabled = true;
            this.focusEnabled = true;
            this.states = [this._ComboTestata_State1_c(), this._ComboTestata_State2_c()];
            this.addEventListener("creationComplete", this.___ComboTestata_Canvas1_creationComplete);
            this.addEventListener("keyFocusChange", this.___ComboTestata_Canvas1_keyFocusChange);
            return;
        }// end function

        public function set ldr(param1:Loading) : void
        {
            var _loc_2:* = this._107002ldr;
            if (_loc_2 !== param1)
            {
                this._107002ldr = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ldr", _loc_2, param1));
            }
            return;
        }// end function

        private function removePopup(event:Event) : void
        {
            PopUpManager.removePopUp(this.dropdown);
            this.dropdown = null;
            return;
        }// end function

        public function get ldr() : Loading
        {
            return this._107002ldr;
        }// end function

        override public function initialize() : void
        {
            var target:ComboTestata;
            var watcherSetupUtilClass:Object;
            .mx_internal::setDocumentDescriptor(this._documentDescriptor_);
            var bindings:* = this._ComboTestata_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_it_vodafone_combo_ComboTestataWatcherSetupUtil");
                var _loc_2:* = watcherSetupUtilClass;
                _loc_2.watcherSetupUtilClass["init"](null);
            }
            _watcherSetupUtil.setup(this, function (param1:String)
            {
                return target[param1];
            }// end function
            , bindings, watchers);
            var i:uint;
            while (i < bindings.length)
            {
                
                Binding(bindings[i]).execute();
                i = i++;
            }
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            super.initialize();
            return;
        }// end function

        private function _ComboTestata_SetEventHandler1_c() : SetEventHandler
        {
            var _loc_1:* = new SetEventHandler();
            _loc_1.name = "mouseOver";
            _loc_1.addEventListener("handler", this.___ComboTestata_SetEventHandler1_handler);
            return _loc_1;
        }// end function

        private function get _dataProvider() : Array
        {
            return this._1763739238_dataProvider;
        }// end function

        private function set _1436069623selectedIndex(param1:int) : void
        {
            this._selectedIndex = param1;
            this.updateDisplay();
            return;
        }// end function

        private function init() : void
        {
            this.addEventListener(MouseEvent.CLICK, this.processClick);
            this.addEventListener(FocusEvent.FOCUS_IN, this.focusInHandler2);
            ServerBridge.getServerBridgeInstance().addEventListener(ServerBridge.SESSION_EXPIRED, this.removePopup);
            ServerBridge.getServerBridgeInstance().addEventListener(ServerBridge.LOGGINGOUT, this.removePopup);
            return;
        }// end function

        public function ___ComboTestata_Canvas1_keyFocusChange(event:FocusEvent) : void
        {
            this.kfe(event);
            return;
        }// end function

        private function _ComboTestata_bindingsSetup() : Array
        {
            var binding:Binding;
            var result:Array;
            binding = new Binding(this, function () : DisplayObject
            {
                return label1;
            }// end function
            , function (param1:DisplayObject) : void
            {
                _ComboTestata_RemoveChild1.target = param1;
                return;
            }// end function
            , "_ComboTestata_RemoveChild1.target");
            result[0] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = _selectedNumber;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                _ComboTestata_Label1.text = param1;
                return;
            }// end function
            , "_ComboTestata_Label1.text");
            result[1] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = _selectedNumber;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                label1.text = param1;
                return;
            }// end function
            , "label1.text");
            result[2] = binding;
            return result;
        }// end function

        private function userSelect(event:Event) : void
        {
            var _loc_2:* = this.dropdown.selectedData;
            var _loc_3:int = 0;
            while (_loc_3 < this._dataProvider.length)
            {
                
                if (this._dataProvider[_loc_3].toString() == _loc_2)
                {
                    this._selectedIndex = _loc_3;
                }
                _loc_3++;
            }
            this.removePopup(null);
            dispatchEvent(new Event("change"));
            return;
        }// end function

        public function ___ComboTestata_Canvas1_creationComplete(event:FlexEvent) : void
        {
            this.init();
            return;
        }// end function

        private function set _dataProvider(param1:Array) : void
        {
            var _loc_2:* = this._1763739238_dataProvider;
            if (_loc_2 !== param1)
            {
                this._1763739238_dataProvider = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_dataProvider", _loc_2, param1));
            }
            return;
        }// end function

        private function _ComboTestata_SetStyle2_c() : SetStyle
        {
            var _loc_1:* = new SetStyle();
            _loc_1.name = "backgroundImage";
            _loc_1.value = this._embed_mxml__________img_v1_back_popup_r_png_717450896;
            return _loc_1;
        }// end function

        private function _ComboTestata_State2_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "multi_r";
            _loc_1.basedOn = "multi";
            _loc_1.overrides = [this._ComboTestata_SetStyle2_c(), this._ComboTestata_SetEventHandler2_c()];
            return _loc_1;
        }// end function

        private function _ComboTestata_SetProperty2_c() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "useHandCursor";
            _loc_1.value = true;
            return _loc_1;
        }// end function

        private function _ComboTestata_Label1_i() : Label
        {
            var _loc_1:* = new Label();
            this._ComboTestata_Label1 = _loc_1;
            _loc_1.x = 3;
            _loc_1.y = 0;
            _loc_1.width = 98;
            _loc_1.height = 18;
            _loc_1.mouseChildren = false;
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontWeight", "bold");
            _loc_1.setStyle("fontSize", 15);
            _loc_1.id = "_ComboTestata_Label1";
            BindingManager.executeBindings(this, "_ComboTestata_Label1", this._ComboTestata_Label1);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _ComboTestata_RemoveChild1_i() : RemoveChild
        {
            var _loc_1:* = new RemoveChild();
            this._ComboTestata_RemoveChild1 = _loc_1;
            BindingManager.executeBindings(this, "_ComboTestata_RemoveChild1", this._ComboTestata_RemoveChild1);
            return _loc_1;
        }// end function

        private function updateDisplay() : void
        {
            var _loc_1:String = null;
            if (this._dataProvider != null)
            {
                if (this._selectedIndex >= this._dataProvider.length)
                {
                    this._selectedIndex = 0;
                }
                _loc_1 = this._dataProvider[this._selectedIndex].toString();
                this._selectedNumber = _loc_1.substr(0, 3) + " " + _loc_1.substr(3);
                if (this._dataProvider.length > 1)
                {
                    currentState = "multi";
                }
                else
                {
                    currentState = "";
                }
            }
            return;
        }// end function

        public function get label1() : Label
        {
            return this._1110417475label1;
        }// end function

        private function set _selectedNumber(param1:String) : void
        {
            var _loc_2:* = this._1093105693_selectedNumber;
            if (_loc_2 !== param1)
            {
                this._1093105693_selectedNumber = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_selectedNumber", _loc_2, param1));
            }
            return;
        }// end function

        private function _ComboTestata_bindingExprs() : void
        {
            var _loc_1:* = undefined;
            _loc_1 = this.label1;
            _loc_1 = this._selectedNumber;
            _loc_1 = this._selectedNumber;
            return;
        }// end function

        public function get selectedItem() : Object
        {
            if (this._selectedIndex >= this._dataProvider.length)
            {
                return null;
            }
            return this._dataProvider[this._selectedIndex];
        }// end function

        private function _ComboTestata_SetEventHandler2_c() : SetEventHandler
        {
            var _loc_1:* = new SetEventHandler();
            _loc_1.name = "mouseOut";
            _loc_1.addEventListener("handler", this.___ComboTestata_SetEventHandler2_handler);
            return _loc_1;
        }// end function

        private function processClick(event:MouseEvent) : void
        {
            if (this.ldr != null)
            {
                return;
            }
            if (this._dataProvider.length > 1 && this.dropdown == null)
            {
                this.dropdown = new ComboTestataSelect();
                this.dropdown.addEventListener("mouseDownOutside", this.removePopup);
                this.dropdown.addEventListener("user_selection", this.userSelect);
                this.dropdown.x = this.x;
                this.dropdown.y = this.y + 55;
                this.dropdown.updateList(this._dataProvider);
                PopUpManager.addPopUp(this.dropdown, this);
            }
            return;
        }// end function

        public function ___ComboTestata_SetEventHandler1_handler(param1:Object) : void
        {
            currentState = "multi_r";
            return;
        }// end function

        public function ___ComboTestata_SetEventHandler2_handler(param1:Object) : void
        {
            currentState = "multi";
            return;
        }// end function

        private function focusInHandler2(event:FocusEvent) : void
        {
            this.processClick(null);
            return;
        }// end function

        private function _ComboTestata_AddChild1_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._ComboTestata_Label1_i);
            return _loc_1;
        }// end function

        public function kfe(event:FocusEvent) : void
        {
            this.removePopup(null);
            return;
        }// end function

        public function set selectedIndex(param1:int) : void
        {
            var _loc_2:* = this.selectedIndex;
            if (_loc_2 !== param1)
            {
                this._1436069623selectedIndex = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "selectedIndex", _loc_2, param1));
            }
            return;
        }// end function

        private function _ComboTestata_SetProperty1_c() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "buttonMode";
            _loc_1.value = true;
            return _loc_1;
        }// end function

        private function get _selectedNumber() : String
        {
            return this._1093105693_selectedNumber;
        }// end function

        private function _ComboTestata_SetStyle1_c() : SetStyle
        {
            var _loc_1:* = new SetStyle();
            _loc_1.name = "backgroundImage";
            _loc_1.value = this._embed_mxml__________img_v1_back_popup_png_735332462;
            return _loc_1;
        }// end function

        public function set dataProvider(param1:Array) : void
        {
            this._dataProvider = param1;
            this.updateDisplay();
            return;
        }// end function

        public function get selectedIndex() : int
        {
            return this._selectedIndex;
        }// end function

        private function get _selectedIndex() : int
        {
            return this._652640504_selectedIndex;
        }// end function

        public function set label1(param1:Label) : void
        {
            var _loc_2:* = this._1110417475label1;
            if (_loc_2 !== param1)
            {
                this._1110417475label1 = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "label1", _loc_2, param1));
            }
            return;
        }// end function

        private function _ComboTestata_State1_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "multi";
            _loc_1.overrides = [this._ComboTestata_RemoveChild1_i(), this._ComboTestata_AddChild1_c(), this._ComboTestata_SetStyle1_c(), this._ComboTestata_SetProperty1_c(), this._ComboTestata_SetProperty2_c(), this._ComboTestata_SetEventHandler1_c()];
            return _loc_1;
        }// end function

        private function set _selectedIndex(param1:int) : void
        {
            var _loc_2:* = this._652640504_selectedIndex;
            if (_loc_2 !== param1)
            {
                this._652640504_selectedIndex = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_selectedIndex", _loc_2, param1));
            }
            return;
        }// end function

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
        {
            ComboTestata._watcherSetupUtil = param1;
            return;
        }// end function

    }
}
