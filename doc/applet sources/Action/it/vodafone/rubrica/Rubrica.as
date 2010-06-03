package it.vodafone.rubrica
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

    public class Rubrica extends Canvas implements IBindingClient
    {
        private var _embed_mxml__________img_v1_indietro_over_png_457269170:Class;
        private var _866811904_rubricaUser:RubricaUser;
        private var elementToDelete:RubricaElement;
        private var elementInEditMode:NomeNumero = null;
        public var _Rubrica_Text1:Text;
        public var _Rubrica_Text2:Text;
        public var _Rubrica_Text3:Text;
        private var _embed_mxml__________img_rubrica_si_over_png_2027862492:Class;
        var _bindingsByDestination:Object;
        private var _embed_mxml__________img_v1_indietro_png_162148050:Class;
        public var _Rubrica_SetProperty1:SetProperty;
        public var _Rubrica_SetProperty4:SetProperty;
        public var _Rubrica_SetProperty2:SetProperty;
        public var _Rubrica_SetProperty3:SetProperty;
        private var _embed_mxml__________img_v1_sms_alert_png_380015296:Class;
        private var _1185250762image1:Image;
        private var _493066397_currentRubricaUserList:Array;
        private var _embed_mxml__________img_rubrica_no_over_png_2044496354:Class;
        var _watchers:Array;
        private var _errorElement:RubricaElement;
        private var _1902945048lista_rubrica:RubricaList;
        private var _1798963228aggiungi_contatto:AggiungiContatto;
        private var _embed_mxml__________img_rubrica_si_png_1431565008:Class;
        var _bindingsBeginWithWord:Object;
        private var _1159380522_errorText:String = "";
        private var _embed_mxml__________img_rubrica_no_png_1428828418:Class;
        var _bindings:Array;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var _487812267testo_empty:Label;
        public static const ITEM_SELECTED_EVENT:String = "item_selected_event";
        private static const MSG_ERRORE_NUMERO_PRESENTE:String = "Il numero è già presente nella Rubrica.";
        private static const MSG_RUBRICA_EMPTY:String = "La Rubrica è vuota. \nSeleziona \"Aggiungi nuovo contatto\" \ne inserisci il nome e il numero.";
        private static var _isOpen:Boolean = false;
        public static const ITEM_CREATED_EVENT:String = "item_created_event";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public function Rubrica()
        {
            this._documentDescriptor_ = new UIComponentDescriptor({type:Canvas, propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:Image, id:"image1", propertiesFactory:function () : Object
                {
                    return {x:0, y:0, width:245, height:85, source:"img/rubrica/box_red.png", scaleContent:false, autoLoad:true};
                }// end function
                }), new UIComponentDescriptor({type:AggiungiContatto, id:"aggiungi_contatto", propertiesFactory:function () : Object
                {
                    return {x:1, y:1, currentState:"Info", width:243, height:16};
                }// end function
                })]};
            }// end function
            });
            this._embed_mxml__________img_rubrica_no_over_png_2044496354 = Rubrica__embed_mxml__________img_rubrica_no_over_png_2044496354;
            this._embed_mxml__________img_rubrica_no_png_1428828418 = Rubrica__embed_mxml__________img_rubrica_no_png_1428828418;
            this._embed_mxml__________img_rubrica_si_over_png_2027862492 = Rubrica__embed_mxml__________img_rubrica_si_over_png_2027862492;
            this._embed_mxml__________img_rubrica_si_png_1431565008 = Rubrica__embed_mxml__________img_rubrica_si_png_1431565008;
            this._embed_mxml__________img_v1_indietro_over_png_457269170 = Rubrica__embed_mxml__________img_v1_indietro_over_png_457269170;
            this._embed_mxml__________img_v1_indietro_png_162148050 = Rubrica__embed_mxml__________img_v1_indietro_png_162148050;
            this._embed_mxml__________img_v1_sms_alert_png_380015296 = Rubrica__embed_mxml__________img_v1_sms_alert_png_380015296;
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
            this.states = [this._Rubrica_State1_c(), this._Rubrica_State2_c(), this._Rubrica_State3_c(), this._Rubrica_State4_c(), this._Rubrica_State5_c()];
            this.addEventListener("addedToStage", this.___Rubrica_Canvas1_addedToStage);
            return;
        }// end function

        private function get _rubricaUser() : RubricaUser
        {
            return this._866811904_rubricaUser;
        }// end function

        private function set _rubricaUser(param1:RubricaUser) : void
        {
            var _loc_2:* = this._866811904_rubricaUser;
            if (_loc_2 !== param1)
            {
                this._866811904_rubricaUser = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_rubricaUser", _loc_2, param1));
            }
            return;
        }// end function

        public function ___Rubrica_State4_enterState(event:FlexEvent) : void
        {
            this.swapChildren(this.testo_empty, this.aggiungi_contatto);
            return;
        }// end function

        private function _Rubrica_State2_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "error";
            _loc_1.overrides = [this._Rubrica_AddChild2_c()];
            return _loc_1;
        }// end function

        private function init() : void
        {
            this._rubricaUser = RubricaUser.getIstance(ServerBridge.getServerBridgeInstance().username.toUpperCase());
            this._currentRubricaUserList = this._rubricaUser.list;
            trace("Rubrica, init()");
            this.setState();
            this.addEventListener(RubricaElementEvent.ADD_EVENT, this.addElement);
            this.addEventListener(RubricaElementEvent.DELETE_EVENT, this.confirmDeleteElement);
            this.addEventListener(RubricaElementEvent.EDIT_EVENT, this.editElement);
            this.addEventListener(RubricaElementEvent.ERROR_INSERT, this.displayError);
            this.addEventListener(RubricaElementEvent.ERROR_EDIT, this.displayErrorEdit);
            return;
        }// end function

        private function _Rubrica_Label1_i() : Label
        {
            var _loc_1:* = new Label();
            this.testo_empty = _loc_1;
            _loc_1.x = 6;
            _loc_1.y = 23;
            _loc_1.width = 231;
            _loc_1.height = 51;
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 11);
            _loc_1.id = "testo_empty";
            BindingManager.executeBindings(this, "testo_empty", this.testo_empty);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _Rubrica_AddChild5_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._Rubrica_Canvas4_c);
            return _loc_1;
        }// end function

        private function _Rubrica_SetProperty2_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            this._Rubrica_SetProperty2 = _loc_1;
            _loc_1.name = "width";
            _loc_1.value = 243.014;
            BindingManager.executeBindings(this, "_Rubrica_SetProperty2", this._Rubrica_SetProperty2);
            return _loc_1;
        }// end function

        private function _Rubrica_AddChild1_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._Rubrica_RubricaList1_i);
            return _loc_1;
        }// end function

        public function get lista_rubrica() : RubricaList
        {
            return this._1902945048lista_rubrica;
        }// end function

        public function addElement(event:RubricaElementEvent) : void
        {
            if (this._rubricaUser.isInList(event.data.phoneNumber) == -1)
            {
                this._rubricaUser.addElement(event.data);
                this._currentRubricaUserList = this._rubricaUser.list;
                this.setState();
                if (this.currentState == "list")
                {
                    this.lista_rubrica.drawListExtended("", true);
                }
            }
            else
            {
                this._errorElement = event.data;
                this.currentState = "error";
                this._errorText = MSG_ERRORE_NUMERO_PRESENTE;
            }
            return;
        }// end function

        public function get aggiungi_contatto() : AggiungiContatto
        {
            return this._1798963228aggiungi_contatto;
        }// end function

        private function _Rubrica_bindingExprs() : void
        {
            var _loc_1:* = undefined;
            _loc_1 = this._currentRubricaUserList;
            _loc_1 = this._errorText;
            _loc_1 = this._errorText;
            _loc_1 = MSG_RUBRICA_EMPTY;
            _loc_1 = this.aggiungi_contatto;
            _loc_1 = this.aggiungi_contatto;
            _loc_1 = this.aggiungi_contatto;
            _loc_1 = this.image1;
            _loc_1 = this._errorText;
            _loc_1 = this;
            return;
        }// end function

        private function _Rubrica_Text3_i() : Text
        {
            var _loc_1:* = new Text();
            this._Rubrica_Text3 = _loc_1;
            _loc_1.width = 228;
            _loc_1.selectable = false;
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 11);
            _loc_1.setStyle("textAlign", "center");
            _loc_1.setStyle("horizontalCenter", "0");
            _loc_1.setStyle("verticalCenter", "-20");
            _loc_1.setStyle("color", 16777215);
            _loc_1.id = "_Rubrica_Text3";
            BindingManager.executeBindings(this, "_Rubrica_Text3", this._Rubrica_Text3);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function checkDrawList() : void
        {
            trace("Rubrica, checkDrawList() - BEGIN");
            trace("Rubrica, checkDrawList() - RubricaList.hasBeenShown: " + RubricaList.hasBeenShown);
            if (!RubricaList.hasBeenShown)
            {
                trace("Rubrica, checkDrawList() - DRAW");
                this.lista_rubrica.drawList("");
            }
            trace("Rubrica, checkDrawList() - END");
            return;
        }// end function

        public function set lista_rubrica(param1:RubricaList) : void
        {
            var _loc_2:* = this._1902945048lista_rubrica;
            if (_loc_2 !== param1)
            {
                this._1902945048lista_rubrica = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lista_rubrica", _loc_2, param1));
            }
            return;
        }// end function

        public function get image1() : Image
        {
            return this._1185250762image1;
        }// end function

        public function set aggiungi_contatto(param1:AggiungiContatto) : void
        {
            var _loc_2:* = this._1798963228aggiungi_contatto;
            if (_loc_2 !== param1)
            {
                this._1798963228aggiungi_contatto = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "aggiungi_contatto", _loc_2, param1));
            }
            return;
        }// end function

        public function showElement(param1:String = "") : void
        {
            var s:* = param1;
            try
            {
                this.lista_rubrica.visible = true;
            }
            catch (e:Error)
            {
            }
            this._currentRubricaUserList = this.rubricaUser.search(s, true);
            return;
        }// end function

        private function rubricaOpencloseEvent() : void
        {
            trace("Rubrica, rubricaOpencloseEvent");
            if (_isOpen)
            {
                dispatchEvent(new Event(TabIndexManager.DISABLE_TAB_EVENT, true));
                dispatchEvent(new Event(Sms.RUBRICA_OPENED, true));
            }
            else
            {
                dispatchEvent(new Event(TabIndexManager.ENEBLE_TAB_EVENT, true));
                dispatchEvent(new Event(Sms.RUBRICA_CLOSED, true));
            }
            return;
        }// end function

        private function _Rubrica_RubricaList1_i() : RubricaList
        {
            var _loc_1:* = new RubricaList();
            this.lista_rubrica = _loc_1;
            _loc_1.x = 1;
            _loc_1.y = 17;
            _loc_1.id = "lista_rubrica";
            BindingManager.executeBindings(this, "lista_rubrica", this.lista_rubrica);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _Rubrica_bindingsSetup() : Array
        {
            var binding:Binding;
            var result:Array;
            binding = new Binding(this, function () : Array
            {
                return _currentRubricaUserList;
            }// end function
            , function (param1:Array) : void
            {
                lista_rubrica.dataProvider = param1;
                return;
            }// end function
            , "lista_rubrica.dataProvider");
            result[0] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = _errorText;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                _Rubrica_Text1.text = param1;
                return;
            }// end function
            , "_Rubrica_Text1.text");
            result[1] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = _errorText;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                _Rubrica_Text2.text = param1;
                return;
            }// end function
            , "_Rubrica_Text2.text");
            result[2] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = MSG_RUBRICA_EMPTY;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                testo_empty.text = param1;
                return;
            }// end function
            , "testo_empty.text");
            result[3] = binding;
            binding = new Binding(this, function () : Object
            {
                return aggiungi_contatto;
            }// end function
            , function (param1:Object) : void
            {
                _Rubrica_SetProperty1.target = param1;
                return;
            }// end function
            , "_Rubrica_SetProperty1.target");
            result[4] = binding;
            binding = new Binding(this, function () : Object
            {
                return aggiungi_contatto;
            }// end function
            , function (param1:Object) : void
            {
                _Rubrica_SetProperty2.target = param1;
                return;
            }// end function
            , "_Rubrica_SetProperty2.target");
            result[5] = binding;
            binding = new Binding(this, function () : Object
            {
                return aggiungi_contatto;
            }// end function
            , function (param1:Object) : void
            {
                _Rubrica_SetProperty3.target = param1;
                return;
            }// end function
            , "_Rubrica_SetProperty3.target");
            result[6] = binding;
            binding = new Binding(this, function () : Object
            {
                return image1;
            }// end function
            , function (param1:Object) : void
            {
                _Rubrica_SetProperty4.target = param1;
                return;
            }// end function
            , "_Rubrica_SetProperty4.target");
            result[7] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = _errorText;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                _Rubrica_Text3.text = param1;
                return;
            }// end function
            , "_Rubrica_Text3.text");
            result[8] = binding;
            binding = new Binding(this, function () : Rubrica
            {
                return this;
            }// end function
            , function (param1:Rubrica) : void
            {
                aggiungi_contatto.rubricaRef = param1;
                return;
            }// end function
            , "aggiungi_contatto.rubricaRef");
            result[9] = binding;
            return result;
        }// end function

        public function ___Rubrica_Button2_click(event:MouseEvent) : void
        {
            this.cancelErrorEdit();
            return;
        }// end function

        public function open() : void
        {
            trace("Rubrica, open");
            if (this.currentState == "error" || this.currentState == "error_confirm")
            {
                this.setState();
            }
            else
            {
                _isOpen = true;
                this.visible = _isOpen;
            }
            this.rubricaOpencloseEvent();
            return;
        }// end function

        private function _Rubrica_Button4_c() : Button
        {
            var _loc_1:* = new Button();
            _loc_1.y = 52;
            _loc_1.buttonMode = true;
            _loc_1.useHandCursor = true;
            _loc_1.setStyle("upSkin", this._embed_mxml__________img_rubrica_si_png_1431565008);
            _loc_1.setStyle("horizontalCenter", "54");
            _loc_1.setStyle("overSkin", this._embed_mxml__________img_rubrica_si_over_png_2027862492);
            _loc_1.setStyle("downSkin", this._embed_mxml__________img_rubrica_si_png_1431565008);
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.addEventListener("click", this.___Rubrica_Button4_click);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _Rubrica_SetProperty1_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            this._Rubrica_SetProperty1 = _loc_1;
            _loc_1.name = "x";
            _loc_1.value = 1;
            BindingManager.executeBindings(this, "_Rubrica_SetProperty1", this._Rubrica_SetProperty1);
            return _loc_1;
        }// end function

        public function setState(param1:Boolean = true) : void
        {
            if (!param1)
            {
                this.currentState = "";
            }
            else if (this._rubricaUser.isEmpty)
            {
                this.currentState = "empty";
            }
            else
            {
                this.currentState = "list";
            }
            return;
        }// end function

        private function _Rubrica_State5_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "error_confirm";
            _loc_1.overrides = [this._Rubrica_AddChild5_c()];
            return _loc_1;
        }// end function

        private function _Rubrica_AddChild4_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._Rubrica_Label1_i);
            return _loc_1;
        }// end function

        private function _Rubrica_State1_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "list";
            _loc_1.overrides = [this._Rubrica_AddChild1_c()];
            _loc_1.addEventListener("enterState", this.___Rubrica_State1_enterState);
            return _loc_1;
        }// end function

        private function _Rubrica_Canvas4_c() : Canvas
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
            _loc_1.addChild(this._Rubrica_Text3_i());
            _loc_1.addChild(this._Rubrica_Button3_c());
            _loc_1.addChild(this._Rubrica_Button4_c());
            return _loc_1;
        }// end function

        private function _Rubrica_Text2_i() : Text
        {
            var _loc_1:* = new Text();
            this._Rubrica_Text2 = _loc_1;
            _loc_1.width = 228;
            _loc_1.selectable = false;
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 11);
            _loc_1.setStyle("textAlign", "center");
            _loc_1.setStyle("horizontalCenter", "0");
            _loc_1.setStyle("verticalCenter", "-20");
            _loc_1.setStyle("color", 16777215);
            _loc_1.id = "_Rubrica_Text2";
            BindingManager.executeBindings(this, "_Rubrica_Text2", this._Rubrica_Text2);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function displayError(event:RubricaElementEvent) : void
        {
            currentState = "error";
            this._errorText = event.message;
            return;
        }// end function

        private function get _currentRubricaUserList() : Array
        {
            return this._493066397_currentRubricaUserList;
        }// end function

        private function _Rubrica_Button3_c() : Button
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
            _loc_1.addEventListener("click", this.___Rubrica_Button3_click);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function set rubricaUser(param1:RubricaUser) : void
        {
            this._rubricaUser = param1;
            return;
        }// end function

        public function ___Rubrica_Button3_click(event:MouseEvent) : void
        {
            this.setState();
            return;
        }// end function

        public function set testo_empty(param1:Label) : void
        {
            var _loc_2:* = this._487812267testo_empty;
            if (_loc_2 !== param1)
            {
                this._487812267testo_empty = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "testo_empty", _loc_2, param1));
            }
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

        override public function initialize() : void
        {
            var target:Rubrica;
            var watcherSetupUtilClass:Object;
            .mx_internal::setDocumentDescriptor(this._documentDescriptor_);
            var bindings:* = this._Rubrica_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_it_vodafone_rubrica_RubricaWatcherSetupUtil");
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

        private function _Rubrica_State4_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "empty";
            _loc_1.overrides = [this._Rubrica_AddChild4_c(), this._Rubrica_SetProperty1_i(), this._Rubrica_SetProperty2_i(), this._Rubrica_SetProperty3_i(), this._Rubrica_SetProperty4_i()];
            _loc_1.addEventListener("enterState", this.___Rubrica_State4_enterState);
            return _loc_1;
        }// end function

        public function editElement(event:RubricaElementEvent) : void
        {
            var _loc_2:* = event.oldData.phoneNumber != event.data.phoneNumber;
            var _loc_3:* = this._rubricaUser.isInList(event.data.phoneNumber) != -1;
            if (_loc_2 && _loc_3)
            {
                this.elementInEditMode = this.lista_rubrica.elementInEditMode;
                currentState = "error_edit";
                this._errorText = MSG_ERRORE_NUMERO_PRESENTE;
            }
            else
            {
                this._rubricaUser.editElement(event.oldData, event.data);
                this.setState();
                this._currentRubricaUserList = this._rubricaUser.list;
                if (this.currentState == "list")
                {
                    this.lista_rubrica.drawListExtended(event.data.phoneNumber, true);
                }
            }
            return;
        }// end function

        public function ___Rubrica_Canvas1_addedToStage(event:Event) : void
        {
            this.init();
            return;
        }// end function

        public function get isOpen() : Boolean
        {
            return _isOpen;
        }// end function

        private function _Rubrica_Canvas3_c() : Canvas
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
            _loc_1.addChild(this._Rubrica_Text2_i());
            _loc_1.addChild(this._Rubrica_Button2_c());
            return _loc_1;
        }// end function

        private function _Rubrica_SetProperty4_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            this._Rubrica_SetProperty4 = _loc_1;
            _loc_1.name = "width";
            _loc_1.value = 245;
            BindingManager.executeBindings(this, "_Rubrica_SetProperty4", this._Rubrica_SetProperty4);
            return _loc_1;
        }// end function

        private function _Rubrica_AddChild3_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._Rubrica_Canvas3_c);
            return _loc_1;
        }// end function

        private function displayErrorEdit(event:RubricaElementEvent) : void
        {
            trace("displayErrorEdit");
            this.elementInEditMode = this.lista_rubrica.elementInEditMode;
            currentState = "error_edit";
            this._errorText = event.message;
            return;
        }// end function

        private function _Rubrica_Text1_i() : Text
        {
            var _loc_1:* = new Text();
            this._Rubrica_Text1 = _loc_1;
            _loc_1.width = 228;
            _loc_1.selectable = false;
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 11);
            _loc_1.setStyle("textAlign", "center");
            _loc_1.setStyle("horizontalCenter", "0");
            _loc_1.setStyle("verticalCenter", "-20");
            _loc_1.setStyle("color", 16777215);
            _loc_1.id = "_Rubrica_Text1";
            BindingManager.executeBindings(this, "_Rubrica_Text1", this._Rubrica_Text1);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function get testo_empty() : Label
        {
            return this._487812267testo_empty;
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

        private function cancelError() : void
        {
            this.setState();
            this.aggiungi_contatto.currentState = "Edit";
            switch(this._errorText)
            {
                case MSG_ERRORE_NUMERO_PRESENTE:
                {
                    if (this._errorElement != null)
                    {
                        this.aggiungi_contatto.nome_txt.text = this._errorElement.name;
                        this.aggiungi_contatto.numero_txt.text = this._errorElement.phoneNumber;
                    }
                    this.aggiungi_contatto.numero_txt.setFocus();
                    var _loc_1:* = this.aggiungi_contatto.numero_txt.text.length;
                    this.aggiungi_contatto.numero_txt.selectionEndIndex = this.aggiungi_contatto.numero_txt.text.length;
                    this.aggiungi_contatto.numero_txt.selectionBeginIndex = _loc_1;
                    break;
                }
                case AggiungiContatto.MSG_ERRORE_NUMERO_CORTO:
                {
                    this.aggiungi_contatto.numero_txt.setFocus();
                    var _loc_1:* = this.aggiungi_contatto.numero_txt.text.length;
                    this.aggiungi_contatto.numero_txt.selectionEndIndex = this.aggiungi_contatto.numero_txt.text.length;
                    this.aggiungi_contatto.numero_txt.selectionBeginIndex = _loc_1;
                    break;
                }
                case AggiungiContatto.MSG_ERRORE_NUMERO_LUNGO:
                {
                    this.aggiungi_contatto.numero_txt.setFocus();
                    var _loc_1:* = this.aggiungi_contatto.numero_txt.text.length;
                    this.aggiungi_contatto.numero_txt.selectionEndIndex = this.aggiungi_contatto.numero_txt.text.length;
                    this.aggiungi_contatto.numero_txt.selectionBeginIndex = _loc_1;
                    break;
                }
                case AggiungiContatto.MSG_ERRORE_NOME:
                {
                    this.aggiungi_contatto.nome_txt.setFocus();
                    var _loc_1:* = this.aggiungi_contatto.nome_txt.text.length;
                    this.aggiungi_contatto.nome_txt.selectionEndIndex = this.aggiungi_contatto.nome_txt.text.length;
                    this.aggiungi_contatto.nome_txt.selectionBeginIndex = _loc_1;
                    break;
                }
                case AggiungiContatto.MSG_ERRORE_NUMERO:
                {
                    this.aggiungi_contatto.numero_txt.setFocus();
                    var _loc_1:* = this.aggiungi_contatto.numero_txt.text.length;
                    this.aggiungi_contatto.numero_txt.selectionEndIndex = this.aggiungi_contatto.numero_txt.text.length;
                    this.aggiungi_contatto.numero_txt.selectionBeginIndex = _loc_1;
                    break;
                }
                case AggiungiContatto.MSG_ERRORE_NOME_NUMERO:
                {
                    this.aggiungi_contatto.nome_txt.setFocus();
                    var _loc_1:* = this.aggiungi_contatto.nome_txt.text.length;
                    this.aggiungi_contatto.nome_txt.selectionEndIndex = this.aggiungi_contatto.nome_txt.text.length;
                    this.aggiungi_contatto.nome_txt.selectionBeginIndex = _loc_1;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._errorText = "";
            this._errorElement = null;
            return;
        }// end function

        private function _Rubrica_Button2_c() : Button
        {
            var _loc_1:* = new Button();
            _loc_1.y = 52;
            _loc_1.buttonMode = true;
            _loc_1.useHandCursor = true;
            _loc_1.setStyle("upSkin", this._embed_mxml__________img_v1_indietro_png_162148050);
            _loc_1.setStyle("horizontalCenter", "0");
            _loc_1.setStyle("overSkin", this._embed_mxml__________img_v1_indietro_over_png_457269170);
            _loc_1.setStyle("downSkin", this._embed_mxml__________img_v1_indietro_png_162148050);
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.addEventListener("click", this.___Rubrica_Button2_click);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function get rubricaUser() : RubricaUser
        {
            return this._rubricaUser;
        }// end function

        public function ___Rubrica_Button4_click(event:MouseEvent) : void
        {
            this.deleteElement();
            return;
        }// end function

        private function set _currentRubricaUserList(param1:Array) : void
        {
            var _loc_2:* = this._493066397_currentRubricaUserList;
            if (_loc_2 !== param1)
            {
                this._493066397_currentRubricaUserList = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_currentRubricaUserList", _loc_2, param1));
            }
            return;
        }// end function

        private function _Rubrica_State3_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "error_edit";
            _loc_1.overrides = [this._Rubrica_AddChild3_c()];
            return _loc_1;
        }// end function

        public function deleteElement() : void
        {
            this._rubricaUser.deleteElement(this.elementToDelete);
            this._currentRubricaUserList = this._rubricaUser.list;
            this.setState();
            if (this.currentState == "list")
            {
                this.lista_rubrica.drawListExtended("", true);
            }
            return;
        }// end function

        private function _Rubrica_Canvas2_c() : Canvas
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
            _loc_1.addChild(this._Rubrica_Text1_i());
            _loc_1.addChild(this._Rubrica_Button1_c());
            return _loc_1;
        }// end function

        public function openClose() : void
        {
            trace("Rubrica, openClose");
            if (this.currentState == "error" || this.currentState == "error_confirm")
            {
                this.setState();
            }
            _isOpen = !_isOpen;
            this.visible = _isOpen;
            this.rubricaOpencloseEvent();
            return;
        }// end function

        private function get _errorText() : String
        {
            return this._1159380522_errorText;
        }// end function

        private function _Rubrica_SetProperty3_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            this._Rubrica_SetProperty3 = _loc_1;
            _loc_1.name = "height";
            _loc_1.value = 17.0034;
            BindingManager.executeBindings(this, "_Rubrica_SetProperty3", this._Rubrica_SetProperty3);
            return _loc_1;
        }// end function

        private function cancelErrorEdit() : void
        {
            trace("cancelErrorEdit");
            this.setState();
            if (this.elementInEditMode != null)
            {
                this.elementInEditMode.setEditMode();
                switch(this._errorText)
                {
                    case MSG_ERRORE_NUMERO_PRESENTE:
                    {
                        this.elementInEditMode.setFocusToNumber();
                        break;
                    }
                    case AggiungiContatto.MSG_ERRORE_NUMERO_CORTO:
                    {
                        this.elementInEditMode.setFocusToNumber();
                        break;
                    }
                    case AggiungiContatto.MSG_ERRORE_NUMERO_LUNGO:
                    {
                        this.elementInEditMode.setFocusToNumber();
                        break;
                    }
                    case AggiungiContatto.MSG_ERRORE_NOME:
                    {
                        this.elementInEditMode.setFocusToName();
                        break;
                    }
                    case AggiungiContatto.MSG_ERRORE_NUMERO:
                    {
                        this.elementInEditMode.setFocusToNumber();
                        break;
                    }
                    case AggiungiContatto.MSG_ERRORE_NOME_NUMERO:
                    {
                        this.elementInEditMode.setFocusToName();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            this._errorText = "";
            return;
        }// end function

        private function _Rubrica_AddChild2_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._Rubrica_Canvas2_c);
            return _loc_1;
        }// end function

        public function ___Rubrica_State1_enterState(event:FlexEvent) : void
        {
            this.checkDrawList();
            return;
        }// end function

        public function confirmDeleteElement(event:RubricaElementEvent) : void
        {
            currentState = "error_confirm";
            this._errorText = "Sei sicuro di voler cancellare " + event.data.name + " dalla Rubrica?";
            this.elementToDelete = event.data;
            return;
        }// end function

        public function close() : void
        {
            trace("Rubrica, close");
            _isOpen = false;
            this.visible = _isOpen;
            this.rubricaOpencloseEvent();
            return;
        }// end function

        private function _Rubrica_Button1_c() : Button
        {
            var _loc_1:* = new Button();
            _loc_1.y = 52;
            _loc_1.buttonMode = true;
            _loc_1.useHandCursor = true;
            _loc_1.setStyle("upSkin", this._embed_mxml__________img_v1_indietro_png_162148050);
            _loc_1.setStyle("horizontalCenter", "0");
            _loc_1.setStyle("overSkin", this._embed_mxml__________img_v1_indietro_over_png_457269170);
            _loc_1.setStyle("downSkin", this._embed_mxml__________img_v1_indietro_png_162148050);
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.addEventListener("click", this.___Rubrica_Button1_click);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function ___Rubrica_Button1_click(event:MouseEvent) : void
        {
            this.cancelError();
            return;
        }// end function

        public function setToAggiungiConttatto(param1:String, param2:Boolean = false) : void
        {
            if (this.rubricaUser.list.length > 0)
            {
                this.aggiungi_contatto.currentState = "Edit";
            }
            else
            {
                this.aggiungi_contatto.currentState = "EditEmpty";
            }
            this._currentRubricaUserList = this._rubricaUser.list;
            if (this.currentState == "list")
            {
                this.lista_rubrica.drawList();
            }
            var _loc_3:* = this.aggiungi_contatto.nome_txt.text.length;
            this.aggiungi_contatto.nome_txt.selectionEndIndex = this.aggiungi_contatto.nome_txt.text.length;
            this.aggiungi_contatto.nome_txt.selectionBeginIndex = _loc_3;
            this.aggiungi_contatto.numero_txt.text = param1;
            if (param2)
            {
                this.aggiungi_contatto.nome_txt.setFocus();
            }
            return;
        }// end function

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
        {
            Rubrica._watcherSetupUtil = param1;
            return;
        }// end function

    }
}
