package it.vodafone.rubrica
{
    import flash.display.*;
    import flash.events.*;
    import flash.ui.*;
    import flash.utils.*;
    import it.vodafone.tooltip.*;
    import mx.binding.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.states.*;

    public class AggiungiContatto extends Canvas implements IBindingClient
    {
        private var _documentDescriptor_:UIComponentDescriptor;
        public var rubricaRef:Rubrica;
        private var _241352511button1:Button;
        private var _embed_mxml__________img_rubrica_chiudi_red_png_547352636:Class;
        var _bindingsByDestination:Object;
        private var _1110417475label1:Label;
        public var _AggiungiContatto_AddChild11:AddChild;
        private var _embed_mxml__________img_rubrica_piu_aggiungi_red_png_1075548036:Class;
        private var _1185250762image1:Image;
        private var _1381067850nome_txt:TextInput;
        private var _embed_mxml__________img_rubrica_spunta_ok_red_png_1209008546:Class;
        private var _1110417476label0:Label;
        var _watchers:Array;
        private var _embed_mxml__________img_rubrica_piu_aggiungi_png_634541872:Class;
        var _bindingsBeginWithWord:Object;
        private var _embed_mxml__________img_rubrica_chiudi_gray_png_1610796422:Class;
        private var _1654887475numero_txt:TextInput;
        var _bindings:Array;
        private var _embed_mxml__________img_rubrica_spunta_ok_gray_png_1990416960:Class;
        public var _AggiungiContatto_RemoveChild1:RemoveChild;
        public var _AggiungiContatto_RemoveChild2:RemoveChild;
        public static const MSG_ERRORE_NUMERO:String = "Per aggiungere un contatto nella Rubrica, inserisci il numero di cellulare.";
        public static const MAX_NUMBER_LENGTH:Number = 10;
        public static const MSG_ERRORE_NOME_NUMERO:String = "Per aggiungere un contatto nella Rubrica, inserisci il nome e il numero di cellulare.";
        public static const MSG_ERRORE_NUMERO_CORTO:String = "Il numero inserito è troppo corto. Verifica che abbia almeno 9 cifre. ";
        public static const MSG_ERRORE_NUMERO_LUNGO:String = "Il numero inserito è troppo lungo. Verifica che non abbia più di 10 cifre.";
        public static const MIN_NUMBER_LENGTH:Number = 9;
        private static var _watcherSetupUtil:IWatcherSetupUtil;
        public static const MSG_ERRORE_NOME:String = "Per aggiungere un contatto nella Rubrica, inserisci il nome.";

        public function AggiungiContatto()
        {
            this._documentDescriptor_ = new UIComponentDescriptor({type:Canvas, propertiesFactory:function () : Object
            {
                return {width:243, height:17, childDescriptors:[new UIComponentDescriptor({type:Image, id:"image1", propertiesFactory:function () : Object
                {
                    return {x:0, y:0, width:245, height:17, source:"img/rubrica/box_aggiungi_contatto.png"};
                }// end function
                }), new UIComponentDescriptor({type:TextInput, id:"nome_txt", events:{focusIn:"__nome_txt_focusIn", click:"__nome_txt_click", toolTipCreate:"__nome_txt_toolTipCreate"}, stylesFactory:function () : void
                {
                    this.backgroundImage = "img/rubrica/nome_input.png";
                    this.borderStyle = "none";
                    this.focusAlpha = 0;
                    this.paddingLeft = 3;
                    this.paddingTop = 0;
                    this.fontFamily = "Arial";
                    this.fontSize = 11;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {x:0, y:0, width:115, height:16, toolTip:" ", maxChars:100};
                }// end function
                }), new UIComponentDescriptor({type:TextInput, id:"numero_txt", events:{focusIn:"__numero_txt_focusIn", click:"__numero_txt_click", toolTipCreate:"__numero_txt_toolTipCreate"}, stylesFactory:function () : void
                {
                    this.backgroundImage = "img/rubrica/numero_input.png";
                    this.borderStyle = "none";
                    this.focusAlpha = 0;
                    this.paddingLeft = 3;
                    this.paddingTop = 0;
                    this.fontFamily = "Arial";
                    this.fontSize = 11;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {x:118, y:0, width:80, height:16, toolTip:" ", maxChars:100};
                }// end function
                })]};
            }// end function
            });
            this._embed_mxml__________img_rubrica_chiudi_gray_png_1610796422 = AggiungiContatto__embed_mxml__________img_rubrica_chiudi_gray_png_1610796422;
            this._embed_mxml__________img_rubrica_chiudi_red_png_547352636 = AggiungiContatto__embed_mxml__________img_rubrica_chiudi_red_png_547352636;
            this._embed_mxml__________img_rubrica_piu_aggiungi_png_634541872 = AggiungiContatto__embed_mxml__________img_rubrica_piu_aggiungi_png_634541872;
            this._embed_mxml__________img_rubrica_piu_aggiungi_red_png_1075548036 = AggiungiContatto__embed_mxml__________img_rubrica_piu_aggiungi_red_png_1075548036;
            this._embed_mxml__________img_rubrica_spunta_ok_gray_png_1990416960 = AggiungiContatto__embed_mxml__________img_rubrica_spunta_ok_gray_png_1990416960;
            this._embed_mxml__________img_rubrica_spunta_ok_red_png_1209008546 = AggiungiContatto__embed_mxml__________img_rubrica_spunta_ok_red_png_1209008546;
            this._bindings = [];
            this._watchers = [];
            this._bindingsByDestination = {};
            this._bindingsBeginWithWord = {};
            mx_internal::_document = this;
            this.width = 243;
            this.height = 17;
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            this.states = [this._AggiungiContatto_State1_c(), this._AggiungiContatto_State2_c(), this._AggiungiContatto_State3_c()];
            this.addEventListener("addedToStage", this.___AggiungiContatto_Canvas1_addedToStage);
            return;
        }// end function

        public function ___AggiungiContatto_Button2_toolTipCreate(event:ToolTipEvent) : void
        {
            var _loc_2:* = new CustomToolTip();
            _loc_2.text = CustomToolTip.EDIT_SALVA_RUBRICA_TT;
            event.toolTip = _loc_2;
            return;
        }// end function

        public function ___AggiungiContatto_Button6_toolTipCreate(event:ToolTipEvent) : void
        {
            var _loc_2:* = new CustomToolTip();
            _loc_2.text = CustomToolTip.ADD_SALVA_RUBRICA_TT;
            event.toolTip = _loc_2;
            return;
        }// end function

        public function __nome_txt_focusIn(event:FocusEvent) : void
        {
            this.resetTextName();
            return;
        }// end function

        public function ___AggiungiContatto_Button3_click(event:MouseEvent) : void
        {
            this.back();
            return;
        }// end function

        private function _AggiungiContatto_Button4_i() : Button
        {
            var _loc_1:* = new Button();
            this.button1 = _loc_1;
            _loc_1.x = 139;
            _loc_1.y = 35;
            _loc_1.label = "Button";
            _loc_1.width = 11;
            _loc_1.height = 11;
            _loc_1.setStyle("skin", this._embed_mxml__________img_rubrica_chiudi_gray_png_1610796422);
            _loc_1.setStyle("fontFamily", "Arial");
            _loc_1.setStyle("fontSize", 11);
            _loc_1.id = "button1";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function init() : void
        {
            this.addEventListener(KeyboardEvent.KEY_DOWN, this.keyPressed);
            return;
        }// end function

        public function ___AggiungiContatto_Button7_click(event:MouseEvent) : void
        {
            this.back();
            return;
        }// end function

        private function _AggiungiContatto_SetProperty3_c() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "height";
            _loc_1.value = 17;
            return _loc_1;
        }// end function

        private function _AggiungiContatto_AddChild3_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._AggiungiContatto_Image1_c);
            return _loc_1;
        }// end function

        private function _AggiungiContatto_Label3_c() : Label
        {
            var _loc_1:* = new Label();
            _loc_1.x = 10;
            _loc_1.y = 32;
            _loc_1.width = 231;
            _loc_1.height = 16.5;
            _loc_1.text = "Seleziona     per salvare e     per annullare.";
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 11);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _AggiungiContatto_RemoveChild2_i() : RemoveChild
        {
            var _loc_1:* = new RemoveChild();
            this._AggiungiContatto_RemoveChild2 = _loc_1;
            BindingManager.executeBindings(this, "_AggiungiContatto_RemoveChild2", this._AggiungiContatto_RemoveChild2);
            return _loc_1;
        }// end function

        public function ___AggiungiContatto_Label1_click(event:MouseEvent) : void
        {
            this.insertClick();
            return;
        }// end function

        private function _AggiungiContatto_AddChild7_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._AggiungiContatto_Label3_c);
            return _loc_1;
        }// end function

        private function _AggiungiContatto_bindingExprs() : void
        {
            var _loc_1:* = undefined;
            _loc_1 = this.nome_txt;
            _loc_1 = this.numero_txt;
            _loc_1 = this.button1;
            _loc_1 = RubricaElement.INSERT_NAME;
            _loc_1 = RubricaElement.INSERT_NUMBER;
            return;
        }// end function

        private function initEdit() : void
        {
            return;
        }// end function

        public function get image1() : Image
        {
            return this._1185250762image1;
        }// end function

        public function get button1() : Button
        {
            return this._241352511button1;
        }// end function

        private function _AggiungiContatto_AddChild11_i() : AddChild
        {
            var _loc_1:* = new AddChild();
            this._AggiungiContatto_AddChild11 = _loc_1;
            _loc_1.position = "before";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._AggiungiContatto_Label5_i);
            BindingManager.executeBindings(this, "_AggiungiContatto_AddChild11", this._AggiungiContatto_AddChild11);
            return _loc_1;
        }// end function

        public function ___AggiungiContatto_Button3_toolTipCreate(event:ToolTipEvent) : void
        {
            var _loc_2:* = new CustomToolTip();
            _loc_2.text = CustomToolTip.EDIT_ANNULLA_RUBRICA_TT;
            event.toolTip = _loc_2;
            return;
        }// end function

        public function ___AggiungiContatto_Button7_toolTipCreate(event:ToolTipEvent) : void
        {
            var _loc_2:* = new CustomToolTip();
            _loc_2.text = CustomToolTip.ADD_ANNULLA_RUBRICA_TT;
            event.toolTip = _loc_2;
            return;
        }// end function

        public function __nome_txt_click(event:MouseEvent) : void
        {
            this.resetTextName();
            return;
        }// end function

        private function _AggiungiContatto_Button7_c() : Button
        {
            var _loc_1:* = new Button();
            _loc_1.toolTip = " ";
            _loc_1.x = 225;
            _loc_1.y = 3;
            _loc_1.label = "Button";
            _loc_1.width = 11;
            _loc_1.height = 11;
            _loc_1.setStyle("upSkin", this._embed_mxml__________img_rubrica_chiudi_gray_png_1610796422);
            _loc_1.setStyle("overSkin", this._embed_mxml__________img_rubrica_chiudi_red_png_547352636);
            _loc_1.setStyle("downSkin", this._embed_mxml__________img_rubrica_chiudi_red_png_547352636);
            _loc_1.addEventListener("toolTipCreate", this.___AggiungiContatto_Button7_toolTipCreate);
            _loc_1.addEventListener("click", this.___AggiungiContatto_Button7_click);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _AggiungiContatto_Button3_c() : Button
        {
            var _loc_1:* = new Button();
            _loc_1.toolTip = " ";
            _loc_1.x = 225;
            _loc_1.y = 3;
            _loc_1.label = "Button";
            _loc_1.width = 11;
            _loc_1.height = 11;
            _loc_1.setStyle("upSkin", this._embed_mxml__________img_rubrica_chiudi_gray_png_1610796422);
            _loc_1.setStyle("overSkin", this._embed_mxml__________img_rubrica_chiudi_red_png_547352636);
            _loc_1.setStyle("downSkin", this._embed_mxml__________img_rubrica_chiudi_red_png_547352636);
            _loc_1.addEventListener("toolTipCreate", this.___AggiungiContatto_Button3_toolTipCreate);
            _loc_1.addEventListener("click", this.___AggiungiContatto_Button3_click);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function insertClick() : void
        {
            if (this.rubricaRef.rubricaUser.list.length > 0)
            {
                this.rubricaRef.setState();
                this.currentState = "Edit";
            }
            else
            {
                this.rubricaRef.setState(false);
                this.currentState = "EditEmpty";
            }
            return;
        }// end function

        public function get nome_txt() : TextInput
        {
            return this._1381067850nome_txt;
        }// end function

        public function ___AggiungiContatto_State2_enterState(event:FlexEvent) : void
        {
            this.initEdit();
            return;
        }// end function

        private function cleanFieldName() : void
        {
            if (this.nome_txt.text == RubricaElement.INSERT_NAME)
            {
                this.nome_txt.text = "";
            }
            return;
        }// end function

        private function _AggiungiContatto_AddChild2_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._AggiungiContatto_Button1_c);
            return _loc_1;
        }// end function

        private function _AggiungiContatto_Label2_c() : Label
        {
            var _loc_1:* = new Label();
            _loc_1.x = 10;
            _loc_1.y = 18;
            _loc_1.width = 231;
            _loc_1.height = 16.5;
            _loc_1.text = "Inserisci il nome e il numero.";
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 11);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _AggiungiContatto_RemoveChild1_i() : RemoveChild
        {
            var _loc_1:* = new RemoveChild();
            this._AggiungiContatto_RemoveChild1 = _loc_1;
            BindingManager.executeBindings(this, "_AggiungiContatto_RemoveChild1", this._AggiungiContatto_RemoveChild1);
            return _loc_1;
        }// end function

        private function _AggiungiContatto_AddChild6_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._AggiungiContatto_Label2_c);
            return _loc_1;
        }// end function

        private function _AggiungiContatto_SetProperty2_c() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "height";
            _loc_1.value = 83;
            return _loc_1;
        }// end function

        public function ___AggiungiContatto_Canvas1_addedToStage(event:Event) : void
        {
            this.init();
            return;
        }// end function

        private function _AggiungiContatto_State3_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "Edit";
            _loc_1.overrides = [this._AggiungiContatto_AddChild12_c(), this._AggiungiContatto_AddChild13_c(), this._AggiungiContatto_SetProperty3_c()];
            _loc_1.addEventListener("enterState", this.___AggiungiContatto_State3_enterState);
            return _loc_1;
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

        public function __nome_txt_toolTipCreate(event:ToolTipEvent) : void
        {
            var _loc_2:* = new CustomToolTip();
            _loc_2.text = CustomToolTip.NOME_CONTATTO_TT;
            event.toolTip = _loc_2;
            return;
        }// end function

        public function __numero_txt_click(event:MouseEvent) : void
        {
            this.resetTextNum();
            return;
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

        private function _AggiungiContatto_AddChild10_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._AggiungiContatto_Button5_c);
            return _loc_1;
        }// end function

        private function save() : void
        {
            var _loc_1:* = RubricaElement.checkName(this.nome_txt.text);
            var _loc_2:* = this.nome_txt.text;
            var _loc_3:* = RubricaElement.checkNumber(this.numero_txt.text);
            var _loc_4:* = RubricaElement.formatPhoneNumber(this.numero_txt.text);
            this.currentState = "Info";
            if (!_loc_1 && !_loc_3)
            {
                dispatchEvent(new RubricaElementEvent(RubricaElementEvent.ERROR_INSERT, MSG_ERRORE_NOME_NUMERO));
            }
            else if (!_loc_1)
            {
                dispatchEvent(new RubricaElementEvent(RubricaElementEvent.ERROR_INSERT, MSG_ERRORE_NOME));
            }
            else if (!_loc_3)
            {
                dispatchEvent(new RubricaElementEvent(RubricaElementEvent.ERROR_INSERT, MSG_ERRORE_NUMERO));
            }
            else if (RubricaElement.formatPhoneNumber(this.numero_txt.text).length-- > MAX_NUMBER_LENGTH)
            {
                dispatchEvent(new RubricaElementEvent(RubricaElementEvent.ERROR_INSERT, MSG_ERRORE_NUMERO_LUNGO));
            }
            else if (_loc_5 < MIN_NUMBER_LENGTH)
            {
                dispatchEvent(new RubricaElementEvent(RubricaElementEvent.ERROR_INSERT, MSG_ERRORE_NUMERO_CORTO));
            }
            else
            {
                dispatchEvent(new RubricaElementEvent(RubricaElementEvent.ADD_EVENT, "", new RubricaElement(_loc_2, _loc_4)));
                this.nome_txt.text = RubricaElement.INSERT_NAME;
                this.numero_txt.text = RubricaElement.INSERT_NUMBER;
                var _loc_6:* = this.numero_txt.text.length;
                this.numero_txt.selectionEndIndex = this.numero_txt.text.length;
                this.numero_txt.selectionBeginIndex = _loc_6;
            }
            return;
        }// end function

        public function set button1(param1:Button) : void
        {
            var _loc_2:* = this._241352511button1;
            if (_loc_2 !== param1)
            {
                this._241352511button1 = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "button1", _loc_2, param1));
            }
            return;
        }// end function

        public function set label0(param1:Label) : void
        {
            var _loc_2:* = this._1110417476label0;
            if (_loc_2 !== param1)
            {
                this._1110417476label0 = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "label0", _loc_2, param1));
            }
            return;
        }// end function

        private function _AggiungiContatto_Button2_c() : Button
        {
            var _loc_1:* = new Button();
            _loc_1.toolTip = " ";
            _loc_1.x = 206;
            _loc_1.y = 3;
            _loc_1.label = "Button";
            _loc_1.width = 14;
            _loc_1.height = 12;
            _loc_1.setStyle("upSkin", this._embed_mxml__________img_rubrica_spunta_ok_gray_png_1990416960);
            _loc_1.setStyle("overSkin", this._embed_mxml__________img_rubrica_spunta_ok_red_png_1209008546);
            _loc_1.setStyle("downSkin", this._embed_mxml__________img_rubrica_spunta_ok_red_png_1209008546);
            _loc_1.addEventListener("toolTipCreate", this.___AggiungiContatto_Button2_toolTipCreate);
            _loc_1.addEventListener("click", this.___AggiungiContatto_Button2_click);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function ___AggiungiContatto_Button1_click(event:MouseEvent) : void
        {
            this.insertClick();
            return;
        }// end function

        override public function initialize() : void
        {
            var target:AggiungiContatto;
            var watcherSetupUtilClass:Object;
            .mx_internal::setDocumentDescriptor(this._documentDescriptor_);
            var bindings:* = this._AggiungiContatto_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_it_vodafone_rubrica_AggiungiContattoWatcherSetupUtil");
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

        private function _AggiungiContatto_Button6_c() : Button
        {
            var _loc_1:* = new Button();
            _loc_1.toolTip = " ";
            _loc_1.x = 206;
            _loc_1.y = 3;
            _loc_1.label = "Button";
            _loc_1.width = 14;
            _loc_1.height = 12;
            _loc_1.setStyle("upSkin", this._embed_mxml__________img_rubrica_spunta_ok_gray_png_1990416960);
            _loc_1.setStyle("overSkin", this._embed_mxml__________img_rubrica_spunta_ok_red_png_1209008546);
            _loc_1.setStyle("downSkin", this._embed_mxml__________img_rubrica_spunta_ok_red_png_1209008546);
            _loc_1.addEventListener("toolTipCreate", this.___AggiungiContatto_Button6_toolTipCreate);
            _loc_1.addEventListener("click", this.___AggiungiContatto_Button6_click);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _AggiungiContatto_bindingsSetup() : Array
        {
            var binding:Binding;
            var result:Array;
            binding = new Binding(this, function () : DisplayObject
            {
                return nome_txt;
            }// end function
            , function (param1:DisplayObject) : void
            {
                _AggiungiContatto_RemoveChild1.target = param1;
                return;
            }// end function
            , "_AggiungiContatto_RemoveChild1.target");
            result[0] = binding;
            binding = new Binding(this, function () : DisplayObject
            {
                return numero_txt;
            }// end function
            , function (param1:DisplayObject) : void
            {
                _AggiungiContatto_RemoveChild2.target = param1;
                return;
            }// end function
            , "_AggiungiContatto_RemoveChild2.target");
            result[1] = binding;
            binding = new Binding(this, function () : UIComponent
            {
                return button1;
            }// end function
            , function (param1:UIComponent) : void
            {
                _AggiungiContatto_AddChild11.relativeTo = param1;
                return;
            }// end function
            , "_AggiungiContatto_AddChild11.relativeTo");
            result[2] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = RubricaElement.INSERT_NAME;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                nome_txt.text = param1;
                return;
            }// end function
            , "nome_txt.text");
            result[3] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = RubricaElement.INSERT_NUMBER;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                numero_txt.text = param1;
                return;
            }// end function
            , "numero_txt.text");
            result[4] = binding;
            return result;
        }// end function

        public function __numero_txt_focusIn(event:FocusEvent) : void
        {
            this.resetTextNum();
            return;
        }// end function

        private function _AggiungiContatto_SetProperty1_c() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            _loc_1.name = "height";
            _loc_1.value = 17;
            return _loc_1;
        }// end function

        private function _AggiungiContatto_AddChild1_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._AggiungiContatto_Label1_c);
            return _loc_1;
        }// end function

        private function _AggiungiContatto_Label1_c() : Label
        {
            var _loc_1:* = new Label();
            _loc_1.x = 86;
            _loc_1.y = 0;
            _loc_1.text = "Aggiungi nuovo contatto";
            _loc_1.mouseChildren = false;
            _loc_1.useHandCursor = true;
            _loc_1.buttonMode = true;
            _loc_1.width = 128.55;
            _loc_1.height = 16;
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("textAlign", "right");
            _loc_1.setStyle("fontSize", 10);
            _loc_1.addEventListener("click", this.___AggiungiContatto_Label1_click);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _AggiungiContatto_AddChild5_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._AggiungiContatto_Button3_c);
            return _loc_1;
        }// end function

        private function _AggiungiContatto_State2_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "EditEmpty";
            _loc_1.overrides = [this._AggiungiContatto_AddChild3_c(), this._AggiungiContatto_AddChild4_c(), this._AggiungiContatto_AddChild5_c(), this._AggiungiContatto_AddChild6_c(), this._AggiungiContatto_AddChild7_c(), this._AggiungiContatto_AddChild8_c(), this._AggiungiContatto_AddChild9_c(), this._AggiungiContatto_AddChild10_c(), this._AggiungiContatto_SetProperty2_c(), this._AggiungiContatto_AddChild11_i()];
            _loc_1.addEventListener("enterState", this.___AggiungiContatto_State2_enterState);
            return _loc_1;
        }// end function

        private function _AggiungiContatto_AddChild9_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._AggiungiContatto_Button4_i);
            return _loc_1;
        }// end function

        private function _AggiungiContatto_Label5_i() : Label
        {
            var _loc_1:* = new Label();
            this.label0 = _loc_1;
            _loc_1.x = 11;
            _loc_1.y = 62;
            _loc_1.width = 231;
            _loc_1.height = 22;
            _loc_1.text = "numeri Vodafone. ";
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 11);
            _loc_1.id = "label0";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function set numero_txt(param1:TextInput) : void
        {
            var _loc_2:* = this._1654887475numero_txt;
            if (_loc_2 !== param1)
            {
                this._1654887475numero_txt = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "numero_txt", _loc_2, param1));
            }
            return;
        }// end function

        public function set nome_txt(param1:TextInput) : void
        {
            var _loc_2:* = this._1381067850nome_txt;
            if (_loc_2 !== param1)
            {
                this._1381067850nome_txt = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "nome_txt", _loc_2, param1));
            }
            return;
        }// end function

        public function __numero_txt_toolTipCreate(event:ToolTipEvent) : void
        {
            var _loc_2:* = new CustomToolTip();
            _loc_2.text = CustomToolTip.NUMERO_CONTATTO_TT;
            event.toolTip = _loc_2;
            return;
        }// end function

        public function ___AggiungiContatto_State3_enterState(event:FlexEvent) : void
        {
            this.initEdit();
            return;
        }// end function

        public function get label1() : Label
        {
            return this._1110417475label1;
        }// end function

        private function _AggiungiContatto_AddChild13_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._AggiungiContatto_Button7_c);
            return _loc_1;
        }// end function

        public function ___AggiungiContatto_Button1_toolTipCreate(event:ToolTipEvent) : void
        {
            var _loc_2:* = new CustomToolTip();
            _loc_2.text = CustomToolTip.ADD_RUBRICA_TT;
            event.toolTip = _loc_2;
            return;
        }// end function

        public function keyPressed(event:KeyboardEvent) : void
        {
            var _loc_2:IFocusManagerComponent = null;
            switch(event.charCode)
            {
                case Keyboard.TAB:
                {
                    if (currentState == "Edit" || currentState == "EditEmpty")
                    {
                        _loc_2 = this.focusManager.getFocus();
                        if (_loc_2 == this.nome_txt)
                        {
                            var _loc_3:* = this.numero_txt.text.length;
                            this.numero_txt.selectionEndIndex = this.numero_txt.text.length;
                            this.numero_txt.selectionBeginIndex = _loc_3;
                            this.numero_txt.setFocus();
                        }
                        else
                        {
                            var _loc_3:* = this.nome_txt.text.length;
                            this.nome_txt.selectionEndIndex = this.nome_txt.text.length;
                            this.nome_txt.selectionBeginIndex = _loc_3;
                            this.nome_txt.setFocus();
                        }
                    }
                    break;
                }
                case Keyboard.ENTER:
                {
                    if (currentState == "Edit" || currentState == "EditEmpty")
                    {
                        this.save();
                    }
                    break;
                }
                case Keyboard.ESCAPE:
                {
                    if (currentState == "Edit" || currentState == "EditEmpty")
                    {
                        this.nome_txt.text = RubricaElement.INSERT_NAME;
                        this.numero_txt.text = RubricaElement.INSERT_NUMBER;
                        var _loc_3:* = this.numero_txt.text.length;
                        this.numero_txt.selectionEndIndex = this.numero_txt.text.length;
                        this.numero_txt.selectionBeginIndex = _loc_3;
                        this.setFocus();
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function _AggiungiContatto_Button1_c() : Button
        {
            var _loc_1:* = new Button();
            _loc_1.toolTip = " ";
            _loc_1.x = 218;
            _loc_1.y = 3;
            _loc_1.label = "Button";
            _loc_1.width = 10;
            _loc_1.height = 10;
            _loc_1.tabEnabled = false;
            _loc_1.useHandCursor = true;
            _loc_1.buttonMode = true;
            _loc_1.setStyle("upSkin", this._embed_mxml__________img_rubrica_piu_aggiungi_png_634541872);
            _loc_1.setStyle("overSkin", this._embed_mxml__________img_rubrica_piu_aggiungi_red_png_1075548036);
            _loc_1.setStyle("downSkin", this._embed_mxml__________img_rubrica_piu_aggiungi_red_png_1075548036);
            _loc_1.addEventListener("toolTipCreate", this.___AggiungiContatto_Button1_toolTipCreate);
            _loc_1.addEventListener("click", this.___AggiungiContatto_Button1_click);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function resetTextName() : void
        {
            if (this.nome_txt.text == RubricaElement.INSERT_NAME)
            {
                this.nome_txt.text = "";
            }
            return;
        }// end function

        private function resetTextNum() : void
        {
            if (this.numero_txt.text == RubricaElement.INSERT_NUMBER)
            {
                this.numero_txt.text = "";
            }
            return;
        }// end function

        public function get label0() : Label
        {
            return this._1110417476label0;
        }// end function

        public function ___AggiungiContatto_Button2_click(event:MouseEvent) : void
        {
            this.save();
            return;
        }// end function

        public function ___AggiungiContatto_Button6_click(event:MouseEvent) : void
        {
            this.save();
            return;
        }// end function

        private function _AggiungiContatto_Button5_c() : Button
        {
            var _loc_1:* = new Button();
            _loc_1.x = 60;
            _loc_1.y = 34;
            _loc_1.label = "Button";
            _loc_1.width = 14;
            _loc_1.height = 12;
            _loc_1.setStyle("skin", this._embed_mxml__________img_rubrica_spunta_ok_gray_png_1990416960);
            _loc_1.setStyle("fontFamily", "Arial");
            _loc_1.setStyle("fontSize", 11);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function get numero_txt() : TextInput
        {
            return this._1654887475numero_txt;
        }// end function

        private function _AggiungiContatto_Image1_c() : Image
        {
            var _loc_1:* = new Image();
            _loc_1.width = 241;
            _loc_1.height = 66;
            _loc_1.source = "img/rubrica/fondo_msg_bianco.png";
            _loc_1.scaleContent = false;
            _loc_1.y = 17;
            _loc_1.x = 1;
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function cleanFieldNumber() : void
        {
            if (this.numero_txt.text == RubricaElement.INSERT_NUMBER)
            {
                this.numero_txt.text = "";
            }
            return;
        }// end function

        private function _AggiungiContatto_AddChild4_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._AggiungiContatto_Button2_c);
            return _loc_1;
        }// end function

        private function _AggiungiContatto_State1_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "Info";
            _loc_1.overrides = [this._AggiungiContatto_AddChild1_c(), this._AggiungiContatto_AddChild2_c(), this._AggiungiContatto_SetProperty1_c(), this._AggiungiContatto_RemoveChild1_i(), this._AggiungiContatto_RemoveChild2_i()];
            return _loc_1;
        }// end function

        private function _AggiungiContatto_AddChild8_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._AggiungiContatto_Label4_i);
            return _loc_1;
        }// end function

        private function back() : void
        {
            this.rubricaRef.setState();
            this.currentState = "Info";
            this.nome_txt.text = RubricaElement.INSERT_NAME;
            this.numero_txt.text = RubricaElement.INSERT_NUMBER;
            var _loc_1:* = this.numero_txt.text.length;
            this.numero_txt.selectionEndIndex = this.numero_txt.text.length;
            this.numero_txt.selectionBeginIndex = _loc_1;
            return;
        }// end function

        private function _AggiungiContatto_AddChild12_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._AggiungiContatto_Button6_c);
            return _loc_1;
        }// end function

        private function _AggiungiContatto_Label4_i() : Label
        {
            var _loc_1:* = new Label();
            this.label1 = _loc_1;
            _loc_1.x = 10;
            _loc_1.y = 47;
            _loc_1.width = 231;
            _loc_1.height = 22;
            _loc_1.text = "Ti ricordiamo che potrai inviare SMS solo a ";
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 11);
            _loc_1.id = "label1";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
        {
            AggiungiContatto._watcherSetupUtil = param1;
            return;
        }// end function

    }
}
