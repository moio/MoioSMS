package it.vodafone.ultimiNumeri
{
    import flash.events.*;
    import flash.utils.*;
    import it.vodafone.*;
    import mx.binding.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.states.*;

    public class UltimiNumeri extends Canvas implements IBindingClient
    {
        var _bindingsByDestination:Object;
        var _bindings:Array;
        private var _embed_mxml__________img_rubrica_no_over_png_2044496354:Class;
        var _watchers:Array;
        private var elementToDelete:UltimoNumeroElement;
        private var _embed_mxml__________img_rubrica_si_png_1431565008:Class;
        private var _1582617761_currentUltimiNumeriUserList:Array;
        private var _isOpen:Boolean = false;
        private var _1100282223lista_ultimi_numeri:UltimiNumeriList;
        public var _UltimiNumeri_Label1:Label;
        private var _embed_mxml__________img_rubrica_si_over_png_2027862492:Class;
        var _bindingsBeginWithWord:Object;
        private var _2016966808_ultimiNumeriUser:UltimiNumeriUser;
        private var _1159380522_errorText:String = "";
        private var _embed_mxml__________img_rubrica_no_png_1428828418:Class;
        public var _UltimiNumeri_Text1:Text;
        private var _embed_mxml__________img_v1_sms_alert_png_380015296:Class;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var _1185250762image1:Image;
        private static var _watcherSetupUtil:IWatcherSetupUtil;
        public static const ITEM_LAST_NUMBER_CREATED_EVENT:String = "item_last_number_created_event";
        private static const MSG_ULTIMI_NUMERI_EMPTY:String = "Non sono presenti Ultimi numeri";
        public static const ITEM_LAST_NUMBER_SELECTED_EVENT:String = "item_last_number_selected_event";

        public function UltimiNumeri()
        {
            this._documentDescriptor_ = new UIComponentDescriptor({type:Canvas, propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:Image, id:"image1", propertiesFactory:function () : Object
                {
                    return {x:0, y:0, width:245, height:85, source:"img/rubrica/box_red.png", scaleContent:false, autoLoad:true};
                }// end function
                })]};
            }// end function
            });
            this._embed_mxml__________img_rubrica_no_over_png_2044496354 = UltimiNumeri__embed_mxml__________img_rubrica_no_over_png_2044496354;
            this._embed_mxml__________img_rubrica_no_png_1428828418 = UltimiNumeri__embed_mxml__________img_rubrica_no_png_1428828418;
            this._embed_mxml__________img_rubrica_si_over_png_2027862492 = UltimiNumeri__embed_mxml__________img_rubrica_si_over_png_2027862492;
            this._embed_mxml__________img_rubrica_si_png_1431565008 = UltimiNumeri__embed_mxml__________img_rubrica_si_png_1431565008;
            this._embed_mxml__________img_v1_sms_alert_png_380015296 = UltimiNumeri__embed_mxml__________img_v1_sms_alert_png_380015296;
            this._bindings = [];
            this._watchers = [];
            this._bindingsByDestination = {};
            this._bindingsBeginWithWord = {};
            mx_internal::_document = this;
            this.mouseEnabled = false;
            this.tabEnabled = false;
            this.tabChildren = false;
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            this.states = [this._UltimiNumeri_State1_c(), this._UltimiNumeri_State2_c(), this._UltimiNumeri_State3_c()];
            this.addEventListener("addedToStage", this.___UltimiNumeri_Canvas1_addedToStage);
            this.addEventListener("mouseDownOutside", this.___UltimiNumeri_Canvas1_mouseDownOutside);
            return;
        }// end function

        private function _UltimiNumeri_Label1_i() : Label
        {
            var _loc_1:* = new Label();
            this._UltimiNumeri_Label1 = _loc_1;
            _loc_1.x = 6;
            _loc_1.y = 7;
            _loc_1.width = 231;
            _loc_1.height = 51;
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 11);
            _loc_1.setStyle("textAlign", "center");
            _loc_1.id = "_UltimiNumeri_Label1";
            BindingManager.executeBindings(this, "_UltimiNumeri_Label1", this._UltimiNumeri_Label1);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function get ultimiNumeriUser() : UltimiNumeriUser
        {
            return this._ultimiNumeriUser;
        }// end function

        public function get lista_ultimi_numeri() : UltimiNumeriList
        {
            return this._1100282223lista_ultimi_numeri;
        }// end function

        public function set ultimiNumeriUser(param1:UltimiNumeriUser) : void
        {
            this._ultimiNumeriUser = param1;
            return;
        }// end function

        public function get isOpen() : Boolean
        {
            return this._isOpen;
        }// end function

        override public function initialize() : void
        {
            var target:UltimiNumeri;
            var watcherSetupUtilClass:Object;
            .mx_internal::setDocumentDescriptor(this._documentDescriptor_);
            var bindings:* = this._UltimiNumeri_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_it_vodafone_ultimiNumeri_UltimiNumeriWatcherSetupUtil");
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

        public function editElement(param1:UltimoNumeroElement) : void
        {
            return;
        }// end function

        public function addElement(param1:UltimoNumeroElement) : void
        {
            this._ultimiNumeriUser.addElement(param1);
            this._currentUltimiNumeriUserList = this._ultimiNumeriUser.list;
            if (this.currentState != "list")
            {
                this.setState();
                this.lista_ultimi_numeri.drawList();
            }
            return;
        }// end function

        private function init() : void
        {
            this._ultimiNumeriUser = UltimiNumeriUser.getIstance(ServerBridge.getServerBridgeInstance().username.toUpperCase());
            this._currentUltimiNumeriUserList = this._ultimiNumeriUser.list;
            this.setState();
            this.addEventListener(UltimoNumeroEvent.DELETE_EVENT, this.confirmDeleteElement);
            return;
        }// end function

        private function _UltimiNumeri_Button1_c() : Button
        {
            var _loc_1:* = new Button();
            _loc_1.y = 52;
            _loc_1.buttonMode = true;
            _loc_1.useHandCursor = true;
            _loc_1.setStyle("upSkin", this._embed_mxml__________img_rubrica_no_png_1428828418);
            _loc_1.setStyle("horizontalCenter", "-51");
            _loc_1.setStyle("overSkin", this._embed_mxml__________img_rubrica_no_over_png_2044496354);
            _loc_1.setStyle("downSkin", this._embed_mxml__________img_rubrica_no_png_1428828418);
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.addEventListener("click", this.___UltimiNumeri_Button1_click);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _UltimiNumeri_State1_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "list";
            _loc_1.overrides = [this._UltimiNumeri_AddChild1_c()];
            return _loc_1;
        }// end function

        public function ___UltimiNumeri_Button2_click(event:MouseEvent) : void
        {
            this.deleteElement();
            return;
        }// end function

        private function _UltimiNumeri_State3_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "empty";
            _loc_1.overrides = [this._UltimiNumeri_AddChild3_c()];
            return _loc_1;
        }// end function

        public function set lista_ultimi_numeri(param1:UltimiNumeriList) : void
        {
            var _loc_2:* = this._1100282223lista_ultimi_numeri;
            if (_loc_2 !== param1)
            {
                this._1100282223lista_ultimi_numeri = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lista_ultimi_numeri", _loc_2, param1));
            }
            return;
        }// end function

        private function listOpenCloseEvent() : void
        {
            if (this._isOpen)
            {
                dispatchEvent(new Event(Sms.ULTIMI_NUMERI_OPENED, true));
            }
            else
            {
                dispatchEvent(new Event(Sms.ULTIMI_NUMERI_CLOSED, true));
            }
            return;
        }// end function

        public function ___UltimiNumeri_Canvas1_addedToStage(event:Event) : void
        {
            this.init();
            return;
        }// end function

        private function get _currentUltimiNumeriUserList() : Array
        {
            return this._1582617761_currentUltimiNumeriUserList;
        }// end function

        private function _UltimiNumeri_AddChild1_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._UltimiNumeri_UltimiNumeriList1_i);
            return _loc_1;
        }// end function

        private function _UltimiNumeri_AddChild3_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._UltimiNumeri_Canvas3_c);
            return _loc_1;
        }// end function

        private function set _errorText(param1:String) : void
        {
            var _loc_2:* = this._1159380522_errorText;
            if (_loc_2 !== param1)
            {
                this._1159380522_errorText = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_errorText", _loc_2, param1));
            }
            return;
        }// end function

        private function _UltimiNumeri_Canvas3_c() : Canvas
        {
            var _loc_1:* = new Canvas();
            _loc_1.x = 1;
            _loc_1.y = 0;
            _loc_1.width = 243.5;
            _loc_1.height = 84;
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            _loc_1.addChild(this._UltimiNumeri_Label1_i());
            return _loc_1;
        }// end function

        public function showElement() : void
        {
            try
            {
                this.lista_ultimi_numeri.visible = true;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        public function get image1() : Image
        {
            return this._1185250762image1;
        }// end function

        private function set _currentUltimiNumeriUserList(param1:Array) : void
        {
            var _loc_2:* = this._1582617761_currentUltimiNumeriUserList;
            if (_loc_2 !== param1)
            {
                this._1582617761_currentUltimiNumeriUserList = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_currentUltimiNumeriUserList", _loc_2, param1));
            }
            return;
        }// end function

        public function open() : void
        {
            this.setState();
            if (this.currentState != "error_confirm")
            {
                this._isOpen = true;
                this.visible = this._isOpen;
            }
            this.listOpenCloseEvent();
            return;
        }// end function

        private function _UltimiNumeri_Text1_i() : Text
        {
            var _loc_1:* = new Text();
            this._UltimiNumeri_Text1 = _loc_1;
            _loc_1.width = 228;
            _loc_1.selectable = false;
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 11);
            _loc_1.setStyle("textAlign", "center");
            _loc_1.setStyle("horizontalCenter", "0");
            _loc_1.setStyle("verticalCenter", "-20");
            _loc_1.setStyle("color", 16777215);
            _loc_1.id = "_UltimiNumeri_Text1";
            BindingManager.executeBindings(this, "_UltimiNumeri_Text1", this._UltimiNumeri_Text1);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function ___UltimiNumeri_Canvas1_mouseDownOutside(event:FlexMouseEvent) : void
        {
            this.close();
            return;
        }// end function

        public function openClose() : void
        {
            this.setState();
            this._isOpen = !this._isOpen;
            this.visible = this._isOpen;
            this.listOpenCloseEvent();
            return;
        }// end function

        public function setState(param1:Boolean = true) : void
        {
            var _loc_2:UltimiNumeriUser = null;
            trace("UltimiNumeri, setState() - BEGIN");
            if (!param1)
            {
                this.currentState = "";
            }
            else
            {
                _loc_2 = UltimiNumeriUser.getIstance(ServerBridge.getServerBridgeInstance().username.toUpperCase());
                trace("UltimiNumeri, setState(): ultimi.list.length =" + _loc_2.list.length);
                if (_loc_2.list.length == 0)
                {
                    this.currentState = "empty";
                }
                else
                {
                    this.currentState = "list";
                }
            }
            trace("UltimiNumeri, setState() - END");
            return;
        }// end function

        private function set _ultimiNumeriUser(param1:UltimiNumeriUser) : void
        {
            var _loc_2:* = this._2016966808_ultimiNumeriUser;
            if (_loc_2 !== param1)
            {
                this._2016966808_ultimiNumeriUser = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_ultimiNumeriUser", _loc_2, param1));
            }
            return;
        }// end function

        public function deleteElement() : void
        {
            this._ultimiNumeriUser.deleteElement(this.elementToDelete);
            this._currentUltimiNumeriUserList = this._ultimiNumeriUser.list;
            this.setState();
            this.lista_ultimi_numeri.drawList();
            return;
        }// end function

        private function _UltimiNumeri_UltimiNumeriList1_i() : UltimiNumeriList
        {
            var _loc_1:* = new UltimiNumeriList();
            this.lista_ultimi_numeri = _loc_1;
            _loc_1.x = 1;
            _loc_1.y = 2;
            _loc_1.id = "lista_ultimi_numeri";
            BindingManager.executeBindings(this, "lista_ultimi_numeri", this.lista_ultimi_numeri);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function get _errorText() : String
        {
            return this._1159380522_errorText;
        }// end function

        private function _UltimiNumeri_Button2_c() : Button
        {
            var _loc_1:* = new Button();
            _loc_1.y = 52;
            _loc_1.buttonMode = true;
            _loc_1.useHandCursor = true;
            _loc_1.setStyle("upSkin", this._embed_mxml__________img_rubrica_si_png_1431565008);
            _loc_1.setStyle("horizontalCenter", "50");
            _loc_1.setStyle("overSkin", this._embed_mxml__________img_rubrica_si_over_png_2027862492);
            _loc_1.setStyle("downSkin", this._embed_mxml__________img_rubrica_si_png_1431565008);
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.addEventListener("click", this.___UltimiNumeri_Button2_click);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _UltimiNumeri_State2_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "error_confirm";
            _loc_1.overrides = [this._UltimiNumeri_AddChild2_c()];
            return _loc_1;
        }// end function

        public function ___UltimiNumeri_Button1_click(event:MouseEvent) : void
        {
            this.setState();
            return;
        }// end function

        private function get _ultimiNumeriUser() : UltimiNumeriUser
        {
            return this._2016966808_ultimiNumeriUser;
        }// end function

        public function confirmDeleteElement(event:UltimoNumeroEvent) : void
        {
            currentState = "error_confirm";
            this._errorText = "Sei sicuro di voler cancellare il contatto da Ultimi numeri?";
            this.elementToDelete = event.data;
            return;
        }// end function

        public function set image1(param1:Image) : void
        {
            var _loc_2:* = this._1185250762image1;
            if (_loc_2 !== param1)
            {
                this._1185250762image1 = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "image1", _loc_2, param1));
            }
            return;
        }// end function

        private function _UltimiNumeri_bindingsSetup() : Array
        {
            var binding:Binding;
            var result:Array;
            binding = new Binding(this, function () : Array
            {
                return _currentUltimiNumeriUserList;
            }// end function
            , function (param1:Array) : void
            {
                lista_ultimi_numeri.dataProvider = param1;
                return;
            }// end function
            , "lista_ultimi_numeri.dataProvider");
            result[0] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = _errorText;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                _UltimiNumeri_Text1.text = param1;
                return;
            }// end function
            , "_UltimiNumeri_Text1.text");
            result[1] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = MSG_ULTIMI_NUMERI_EMPTY;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                _UltimiNumeri_Label1.text = param1;
                return;
            }// end function
            , "_UltimiNumeri_Label1.text");
            result[2] = binding;
            return result;
        }// end function

        public function close() : void
        {
            trace("UltimiNumeri, close");
            this._isOpen = false;
            this.visible = this._isOpen;
            this.listOpenCloseEvent();
            return;
        }// end function

        private function _UltimiNumeri_AddChild2_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._UltimiNumeri_Canvas2_c);
            return _loc_1;
        }// end function

        private function _UltimiNumeri_bindingExprs() : void
        {
            var _loc_1:* = undefined;
            _loc_1 = this._currentUltimiNumeriUserList;
            _loc_1 = this._errorText;
            _loc_1 = MSG_ULTIMI_NUMERI_EMPTY;
            return;
        }// end function

        private function _UltimiNumeri_Canvas2_c() : Canvas
        {
            var _loc_1:* = new Canvas();
            _loc_1.x = 1;
            _loc_1.y = 0;
            _loc_1.width = 243.5;
            _loc_1.height = 84;
            _loc_1.setStyle("backgroundImage", this._embed_mxml__________img_v1_sms_alert_png_380015296);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            _loc_1.addChild(this._UltimiNumeri_Text1_i());
            _loc_1.addChild(this._UltimiNumeri_Button1_c());
            _loc_1.addChild(this._UltimiNumeri_Button2_c());
            return _loc_1;
        }// end function

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
        {
            UltimiNumeri._watcherSetupUtil = param1;
            return;
        }// end function

    }
}
