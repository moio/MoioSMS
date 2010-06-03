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
    import mx.skins.*;
    import mx.states.*;
    import mx.styles.*;

    public class NomeNumero extends Canvas implements IBindingClient
    {
        private var _94756344close:Button;
        private var _276494419box_input_edit:Box;
        private var _embed_mxml__________img_rubrica_chiudi_red_png_547352636:Class;
        var _bindingsByDestination:Object;
        private var _441974271box_pencil:Box;
        public var _NomeNumero_RemoveChild1:RemoveChild;
        private var _1197660383nome_txt_edit:TextInput;
        private var _embed_css__________img_rubrica_matita_gray_png_556931013:Class;
        private var _1381067850nome_txt:Label;
        private var _prevNameText:String;
        private var _1081247946matita:Button;
        private var _embed_css__________img_rubrica_spunta_ok_red_png_1094085665:Class;
        var _watchers:Array;
        private var _prevPhoneNumberText:String;
        private var _embed_css__________img_rubrica_matita_red_png_1165110169:Class;
        var _bindingsBeginWithWord:Object;
        private var _1267551932_itemData:RubricaElement;
        private var _embed_mxml__________img_rubrica_chiudi_gray_png_1610796422:Class;
        public var _NomeNumero_SetProperty1:SetProperty;
        private var _embed_css__________img_rubrica_spunta_ok_gray_png_2016586711:Class;
        private var _1087927382box_input:Box;
        private var _1654887475numero_txt:Label;
        var _bindings:Array;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var _1441403708numero_txt_edit:TextInput;
        public static const SET_FOCUS_TO_NUMBER:String = "set_focus_to_number";
        public static const SET_FOCUS_TO_NAME:String = "set_focus_to_name";
        public static const EDIT_MODE_ENTER:String = "edit_mode_enter";
        public static const NO_EDIT_MODE_ENTER:String = "no_edit_mode_enter";
        private static var _watcherSetupUtil:IWatcherSetupUtil;
        static var _NomeNumero_StylesInit_done:Boolean = false;

        public function NomeNumero()
        {
            this._documentDescriptor_ = new UIComponentDescriptor({type:Canvas, propertiesFactory:function () : Object
            {
                return {width:232, height:16, childDescriptors:[new UIComponentDescriptor({type:Box, id:"box_pencil", stylesFactory:function () : void
                {
                    this.horizontalGap = 2;
                    this.themeColor = 13369858;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {x:200, direction:"horizontal", width:27, height:14, buttonMode:true, useHandCursor:true, y:3, childDescriptors:[new UIComponentDescriptor({type:Button, id:"matita", events:{toolTipCreate:"__matita_toolTipCreate", click:"__matita_click", mouseOut:"__matita_mouseOut"}, stylesFactory:function () : void
                    {
                        this.themeColor = 13369858;
                        return;
                    }// end function
                    , propertiesFactory:function () : Object
                    {
                        return {toolTip:" ", x:0, y:4, styleName:"matitaButton", label:"Button", width:12, height:13};
                    }// end function
                    }), new UIComponentDescriptor({type:Button, id:"close", events:{toolTipCreate:"__close_toolTipCreate", click:"__close_click", mouseOut:"__close_mouseOut"}, stylesFactory:function () : void
                    {
                        this.upSkin = _embed_mxml__________img_rubrica_chiudi_gray_png_1610796422;
                        this.disabledIcon = _embed_mxml__________img_rubrica_chiudi_gray_png_1610796422;
                        this.overSkin = _embed_mxml__________img_rubrica_chiudi_red_png_547352636;
                        this.downSkin = _embed_mxml__________img_rubrica_chiudi_red_png_547352636;
                        return;
                    }// end function
                    , propertiesFactory:function () : Object
                    {
                        return {toolTip:" ", x:10, y:6, label:"Button", width:11, height:11};
                    }// end function
                    })]};
                }// end function
                }), new UIComponentDescriptor({type:HRule, propertiesFactory:function () : Object
                {
                    return {x:0, y:0, width:231.951, height:1};
                }// end function
                })]};
            }// end function
            });
            this._embed_css__________img_rubrica_matita_gray_png_556931013 = NomeNumero__embed_css__________img_rubrica_matita_gray_png_556931013;
            this._embed_css__________img_rubrica_matita_red_png_1165110169 = NomeNumero__embed_css__________img_rubrica_matita_red_png_1165110169;
            this._embed_css__________img_rubrica_spunta_ok_gray_png_2016586711 = NomeNumero__embed_css__________img_rubrica_spunta_ok_gray_png_2016586711;
            this._embed_css__________img_rubrica_spunta_ok_red_png_1094085665 = NomeNumero__embed_css__________img_rubrica_spunta_ok_red_png_1094085665;
            this._embed_mxml__________img_rubrica_chiudi_gray_png_1610796422 = NomeNumero__embed_mxml__________img_rubrica_chiudi_gray_png_1610796422;
            this._embed_mxml__________img_rubrica_chiudi_red_png_547352636 = NomeNumero__embed_mxml__________img_rubrica_chiudi_red_png_547352636;
            this._bindings = [];
            this._watchers = [];
            this._bindingsByDestination = {};
            this._bindingsBeginWithWord = {};
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            }
            this.styleDeclaration.defaultFactory = function () : void
            {
                this.backgroundColor = 16777215;
                return;
            }// end function
            ;
            .mx_internal::_NomeNumero_StylesInit();
            this.width = 232;
            this.height = 16;
            this.tabEnabled = false;
            this.states = [this._NomeNumero_State1_c(), this._NomeNumero_State2_c(), this._NomeNumero_State3_c()];
            this._NomeNumero_SetProperty1_i();
            return;
        }// end function

        public function get box_pencil() : Box
        {
            return this._441974271box_pencil;
        }// end function

        public function set box_pencil(param1:Box) : void
        {
            var _loc_2:* = this._441974271box_pencil;
            if (_loc_2 !== param1)
            {
                this._441974271box_pencil = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "box_pencil", _loc_2, param1));
            }
            return;
        }// end function

        private function edit() : void
        {
            trace("Fatto!");
            this.matita.styleName = "spuntaIconaButton";
            this.box_input_edit.mouseChildren = true;
            this.textOut();
            this.matita.selected = false;
            var _loc_1:* = this.nome_txt_edit.text.length;
            this.nome_txt_edit.selectionEndIndex = this.nome_txt_edit.text.length;
            this.nome_txt_edit.selectionBeginIndex = _loc_1;
            this.nome_txt_edit.setFocus();
            this.dispatchEvent(new Event(EDIT_MODE_ENTER, true));
            return;
        }// end function

        public function ___NomeNumero_State3_enterState(event:FlexEvent) : void
        {
            this.edit();
            return;
        }// end function

        public function init() : void
        {
            this.currentState = "no_edit";
            this.tabChildren = false;
            this.addEventListener(KeyboardEvent.KEY_UP, this.keyPressed);
            this.addEventListener(SET_FOCUS_TO_NAME, this.setFocusToName);
            this.addEventListener(SET_FOCUS_TO_NUMBER, this.setFocusToNumber);
            return;
        }// end function

        private function _NomeNumero_TextInput2_i() : TextInput
        {
            var _loc_1:* = new TextInput();
            this.numero_txt_edit = _loc_1;
            _loc_1.tabEnabled = false;
            _loc_1.tabIndex = 2;
            _loc_1.toolTip = " ";
            _loc_1.width = 80;
            _loc_1.height = 16.75;
            _loc_1.maxChars = 100;
            _loc_1.setStyle("paddingLeft", 3);
            _loc_1.setStyle("paddingTop", 0);
            _loc_1.setStyle("fontSize", 11);
            _loc_1.setStyle("backgroundImage", "img/rubrica/numero_input.png");
            _loc_1.setStyle("borderStyle", "none");
            _loc_1.setStyle("focusAlpha", 0);
            _loc_1.setStyle("fontFamily", "Arial");
            _loc_1.addEventListener("toolTipCreate", this.__numero_txt_edit_toolTipCreate);
            _loc_1.id = "numero_txt_edit";
            BindingManager.executeBindings(this, "numero_txt_edit", this.numero_txt_edit);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _NomeNumero_State2_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "no_edit";
            _loc_1.overrides = [this._NomeNumero_AddChild1_c(), this._NomeNumero_SetStyle1_c()];
            return _loc_1;
        }// end function

        public function __box_input_mouseOut(event:MouseEvent) : void
        {
            this.textOut();
            return;
        }// end function

        private function setTextCloseButton() : String
        {
            if (this.currentState == "edit")
            {
                return CustomToolTip.EDIT_ANNULLA_RUBRICA_TT;
            }
            return CustomToolTip.CANCELLA_TT;
        }// end function

        public function __box_input_edit_mouseOver(event:MouseEvent) : void
        {
            this.textOver();
            return;
        }// end function

        public function __matita_click(event:MouseEvent) : void
        {
            this.editMode();
            return;
        }// end function

        private function _NomeNumero_Label1_i() : Label
        {
            var _loc_1:* = new Label();
            this.nome_txt = _loc_1;
            _loc_1.x = 0;
            _loc_1.y = 0;
            _loc_1.width = 115;
            _loc_1.height = 17;
            _loc_1.setStyle("paddingLeft", 3);
            _loc_1.setStyle("paddingTop", 1);
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 11);
            _loc_1.id = "nome_txt";
            BindingManager.executeBindings(this, "nome_txt", this.nome_txt);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function __numero_txt_edit_toolTipCreate(event:ToolTipEvent) : void
        {
            var _loc_2:* = new CustomToolTip();
            _loc_2.text = CustomToolTip.NUMERO_CONTATTO_TT;
            event.toolTip = _loc_2;
            return;
        }// end function

        private function _NomeNumero_AddChild2_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._NomeNumero_Box2_i);
            return _loc_1;
        }// end function

        public function get matita() : Button
        {
            return this._1081247946matita;
        }// end function

        public function get numero_txt_edit() : TextInput
        {
            return this._1441403708numero_txt_edit;
        }// end function

        private function exitEdit() : void
        {
            this.matita.styleName = "matitaButton";
            return;
        }// end function

        private function _NomeNumero_TextInput1_i() : TextInput
        {
            var _loc_1:* = new TextInput();
            this.nome_txt_edit = _loc_1;
            _loc_1.tabEnabled = false;
            _loc_1.tabIndex = 1;
            _loc_1.toolTip = " ";
            _loc_1.x = 0;
            _loc_1.y = 0;
            _loc_1.width = 115;
            _loc_1.height = 16.75;
            _loc_1.maxChars = 100;
            _loc_1.setStyle("paddingLeft", 3);
            _loc_1.setStyle("paddingTop", 0);
            _loc_1.setStyle("fontSize", 11);
            _loc_1.setStyle("backgroundImage", "img/rubrica/nome_input.png");
            _loc_1.setStyle("borderStyle", "none");
            _loc_1.setStyle("focusAlpha", 0);
            _loc_1.setStyle("backgroundAlpha", 1);
            _loc_1.setStyle("fontFamily", "Arial");
            _loc_1.addEventListener("toolTipCreate", this.__nome_txt_edit_toolTipCreate);
            _loc_1.id = "nome_txt_edit";
            BindingManager.executeBindings(this, "nome_txt_edit", this.nome_txt_edit);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _NomeNumero_RemoveChild1_i() : RemoveChild
        {
            var _loc_1:* = new RemoveChild();
            this._NomeNumero_RemoveChild1 = _loc_1;
            BindingManager.executeBindings(this, "_NomeNumero_RemoveChild1", this._NomeNumero_RemoveChild1);
            return _loc_1;
        }// end function

        public function setEditMode() : void
        {
            if (currentState == "no_edit")
            {
                this.currentState = "edit";
            }
            return;
        }// end function

        public function get box_input_edit() : Box
        {
            return this._276494419box_input_edit;
        }// end function

        public function deleteEdit(param1:Boolean = true) : void
        {
            this.nome_txt_edit.text = this._itemData.name;
            this.numero_txt_edit.text = this._itemData.phoneNumber;
            this.currentState = "no_edit";
            this.matita.selected = false;
            if (param1)
            {
                this.dispatchEvent(new Event(NO_EDIT_MODE_ENTER, true));
            }
            return;
        }// end function

        private function _NomeNumero_State1_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "empty";
            _loc_1.overrides = [this._NomeNumero_RemoveChild1_i()];
            return _loc_1;
        }// end function

        public function get nome_txt() : Label
        {
            return this._1381067850nome_txt;
        }// end function

        public function setFocusToNumber() : void
        {
            this.numero_txt_edit.setFocus();
            var _loc_1:* = this.numero_txt_edit.text.length;
            this.numero_txt_edit.selectionEndIndex = this.numero_txt_edit.text.length;
            this.numero_txt_edit.selectionBeginIndex = _loc_1;
            return;
        }// end function

        private function _NomeNumero_Box2_i() : Box
        {
            var _loc_1:* = new Box();
            this.box_input_edit = _loc_1;
            _loc_1.direction = "horizontal";
            _loc_1.width = 197.377;
            _loc_1.height = 16;
            _loc_1.buttonMode = true;
            _loc_1.useHandCursor = true;
            _loc_1.mouseChildren = false;
            _loc_1.y = 0;
            _loc_1.setStyle("horizontalGap", 2);
            _loc_1.addEventListener("mouseOver", this.__box_input_edit_mouseOver);
            _loc_1.addEventListener("mouseOut", this.__box_input_edit_mouseOut);
            _loc_1.id = "box_input_edit";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            _loc_1.addChild(this._NomeNumero_TextInput1_i());
            _loc_1.addChild(this._NomeNumero_TextInput2_i());
            return _loc_1;
        }// end function

        public function get itemData() : RubricaElement
        {
            return this._itemData;
        }// end function

        public function selectElement(param1:Boolean = false) : void
        {
            trace("NomeNumero, selectElement, " + this._itemData.name + " - " + this._itemData.phoneNumber);
            dispatchEvent(new RubricaElementEvent(RubricaElementEvent.SELECT_ELEMENT, "", this._itemData, null, param1));
            return;
        }// end function

        public function ___NomeNumero_State3_exitState(event:FlexEvent) : void
        {
            this.exitEdit();
            return;
        }// end function

        public function __matita_toolTipCreate(event:ToolTipEvent) : void
        {
            var _loc_2:* = new CustomToolTip();
            _loc_2.text = this.setTextEditButton();
            event.toolTip = _loc_2;
            return;
        }// end function

        public function set matita(param1:Button) : void
        {
            var _loc_2:* = this._1081247946matita;
            if (_loc_2 !== param1)
            {
                this._1081247946matita = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "matita", _loc_2, param1));
            }
            return;
        }// end function

        public function get box_input() : Box
        {
            return this._1087927382box_input;
        }// end function

        private function _NomeNumero_AddChild1_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._NomeNumero_Box1_i);
            return _loc_1;
        }// end function

        public function __matita_mouseOut(event:MouseEvent) : void
        {
            this.textOut();
            return;
        }// end function

        public function set numero_txt_edit(param1:TextInput) : void
        {
            var _loc_2:* = this._1441403708numero_txt_edit;
            if (_loc_2 !== param1)
            {
                this._1441403708numero_txt_edit = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "numero_txt_edit", _loc_2, param1));
            }
            return;
        }// end function

        private function _NomeNumero_SetStyle1_c() : SetStyle
        {
            var _loc_1:* = new SetStyle();
            _loc_1.name = "backgroundColor";
            _loc_1.value = 16777215;
            return _loc_1;
        }// end function

        public function __nome_txt_edit_toolTipCreate(event:ToolTipEvent) : void
        {
            var _loc_2:* = new CustomToolTip();
            _loc_2.text = CustomToolTip.NOME_CONTATTO_TT;
            event.toolTip = _loc_2;
            return;
        }// end function

        private function set _itemData(param1:RubricaElement) : void
        {
            var _loc_2:* = this._1267551932_itemData;
            if (_loc_2 !== param1)
            {
                this._1267551932_itemData = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_itemData", _loc_2, param1));
            }
            return;
        }// end function

        public function __box_input_click(event:MouseEvent) : void
        {
            this.selectElement();
            return;
        }// end function

        private function _NomeNumero_SetProperty1_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            this._NomeNumero_SetProperty1 = _loc_1;
            _loc_1.name = "height";
            _loc_1.value = 16.75;
            return _loc_1;
        }// end function

        override public function initialize() : void
        {
            var target:NomeNumero;
            var watcherSetupUtilClass:Object;
            .mx_internal::setDocumentDescriptor(this._documentDescriptor_);
            var bindings:* = this._NomeNumero_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_it_vodafone_rubrica_NomeNumeroWatcherSetupUtil");
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

        public function editElement() : void
        {
            var _loc_1:* = RubricaElement.checkName(this.nome_txt_edit.text);
            var _loc_2:* = this.nome_txt_edit.text;
            var _loc_3:* = RubricaElement.checkNumber(this.numero_txt_edit.text);
            var _loc_4:* = RubricaElement.formatPhoneNumber(this.numero_txt_edit.text);
            if (!_loc_1 && !_loc_3)
            {
                dispatchEvent(new RubricaElementEvent(RubricaElementEvent.ERROR_EDIT, AggiungiContatto.MSG_ERRORE_NOME_NUMERO));
            }
            else if (!_loc_1)
            {
                dispatchEvent(new RubricaElementEvent(RubricaElementEvent.ERROR_EDIT, AggiungiContatto.MSG_ERRORE_NOME));
            }
            else if (!_loc_3)
            {
                dispatchEvent(new RubricaElementEvent(RubricaElementEvent.ERROR_EDIT, AggiungiContatto.MSG_ERRORE_NUMERO));
            }
            else if (RubricaElement.formatPhoneNumber(this.numero_txt_edit.text).length-- > AggiungiContatto.MAX_NUMBER_LENGTH)
            {
                dispatchEvent(new RubricaElementEvent(RubricaElementEvent.ERROR_EDIT, AggiungiContatto.MSG_ERRORE_NUMERO_LUNGO));
            }
            else if (_loc_5 < AggiungiContatto.MIN_NUMBER_LENGTH)
            {
                dispatchEvent(new RubricaElementEvent(RubricaElementEvent.ERROR_EDIT, AggiungiContatto.MSG_ERRORE_NUMERO_CORTO));
            }
            else
            {
                dispatchEvent(new RubricaElementEvent(RubricaElementEvent.EDIT_EVENT, "", new RubricaElement(_loc_2, _loc_4), this._itemData));
                this.currentState = "no_edit";
                this.matita.selected = false;
                this.dispatchEvent(new Event(NO_EDIT_MODE_ENTER, true));
            }
            return;
        }// end function

        public function set numero_txt(param1:Label) : void
        {
            var _loc_2:* = this._1654887475numero_txt;
            if (_loc_2 !== param1)
            {
                this._1654887475numero_txt = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "numero_txt", _loc_2, param1));
            }
            return;
        }// end function

        private function _NomeNumero_Box1_i() : Box
        {
            var _loc_1:* = new Box();
            this.box_input = _loc_1;
            _loc_1.toolTip = " ";
            _loc_1.direction = "horizontal";
            _loc_1.width = 200;
            _loc_1.height = 16;
            _loc_1.buttonMode = true;
            _loc_1.useHandCursor = true;
            _loc_1.mouseChildren = false;
            _loc_1.y = 0;
            _loc_1.setStyle("horizontalGap", 2);
            _loc_1.addEventListener("click", this.__box_input_click);
            _loc_1.addEventListener("toolTipCreate", this.__box_input_toolTipCreate);
            _loc_1.addEventListener("mouseOver", this.__box_input_mouseOver);
            _loc_1.addEventListener("mouseOut", this.__box_input_mouseOut);
            _loc_1.id = "box_input";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            _loc_1.addChild(this._NomeNumero_Label1_i());
            _loc_1.addChild(this._NomeNumero_Label2_i());
            return _loc_1;
        }// end function

        public function __box_input_mouseOver(event:MouseEvent) : void
        {
            this.textOver();
            return;
        }// end function

        public function textOver(param1:Boolean = false) : void
        {
            if (currentState == "no_edit" && this.enabled)
            {
                if (param1)
                {
                    this.setFocus();
                }
                this._prevNameText = this._itemData.nameHtmlText;
                this._prevPhoneNumberText = this._itemData.phoneNumber;
                this.nome_txt.htmlText = "<font color=\'#FF0000\'>" + RubricaElement.truncateText(this._itemData.name) + "</font>";
                this.numero_txt.htmlText = "<font color=\'#FF0000\'>" + this._itemData.phoneNumber + "</font>";
            }
            return;
        }// end function

        private function _NomeNumero_bindingExprs() : void
        {
            var _loc_1:* = undefined;
            _loc_1 = this.box_pencil;
            _loc_1 = this._itemData.nameHtmlText;
            _loc_1 = this._itemData.phoneNumberHtmlText;
            _loc_1 = this._itemData.name;
            _loc_1 = this._itemData.phoneNumber;
            return;
        }// end function

        public function set box_input_edit(param1:Box) : void
        {
            var _loc_2:* = this._276494419box_input_edit;
            if (_loc_2 !== param1)
            {
                this._276494419box_input_edit = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "box_input_edit", _loc_2, param1));
            }
            return;
        }// end function

        public function set box_input(param1:Box) : void
        {
            var _loc_2:* = this._1087927382box_input;
            if (_loc_2 !== param1)
            {
                this._1087927382box_input = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "box_input", _loc_2, param1));
            }
            return;
        }// end function

        public function __close_mouseOut(event:MouseEvent) : void
        {
            this.textOut();
            return;
        }// end function

        public function __box_input_toolTipCreate(event:ToolTipEvent) : void
        {
            var _loc_2:* = new CustomToolTip();
            _loc_2.text = CustomToolTip.SELEZIONA_TT;
            event.toolTip = _loc_2;
            return;
        }// end function

        public function __close_click(event:MouseEvent) : void
        {
            this.deleteElement();
            return;
        }// end function

        public function set itemData(param1:RubricaElement) : void
        {
            this._itemData = param1;
            this._prevNameText = this._itemData.nameHtmlText;
            this._prevPhoneNumberText = this._itemData.phoneNumberHtmlText;
            return;
        }// end function

        private function get _itemData() : RubricaElement
        {
            return this._1267551932_itemData;
        }// end function

        public function set nome_txt_edit(param1:TextInput) : void
        {
            var _loc_2:* = this._1197660383nome_txt_edit;
            if (_loc_2 !== param1)
            {
                this._1197660383nome_txt_edit = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "nome_txt_edit", _loc_2, param1));
            }
            return;
        }// end function

        public function set nome_txt(param1:Label) : void
        {
            var _loc_2:* = this._1381067850nome_txt;
            if (_loc_2 !== param1)
            {
                this._1381067850nome_txt = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "nome_txt", _loc_2, param1));
            }
            return;
        }// end function

        public function keyPressed(event:KeyboardEvent) : void
        {
            var _loc_2:IFocusManagerComponent = null;
            switch(event.charCode)
            {
                case Keyboard.TAB:
                {
                    if (currentState == "edit")
                    {
                        _loc_2 = this.focusManager.getFocus();
                        if (_loc_2 == this.nome_txt_edit)
                        {
                            var _loc_3:* = this.numero_txt_edit.text.length;
                            this.numero_txt_edit.selectionEndIndex = this.numero_txt_edit.text.length;
                            this.numero_txt_edit.selectionBeginIndex = _loc_3;
                            this.numero_txt_edit.setFocus();
                        }
                        else
                        {
                            var _loc_3:* = this.nome_txt_edit.text.length;
                            this.nome_txt_edit.selectionEndIndex = this.nome_txt_edit.text.length;
                            this.nome_txt_edit.selectionBeginIndex = _loc_3;
                            this.nome_txt_edit.setFocus();
                        }
                    }
                    break;
                }
                case Keyboard.ENTER:
                {
                    event.stopImmediatePropagation();
                    if (currentState == "edit")
                    {
                        this.editElement();
                    }
                    else
                    {
                        this.selectElement(true);
                    }
                    break;
                }
                case Keyboard.ESCAPE:
                {
                    if (currentState == "edit")
                    {
                        this.deleteEdit();
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

        public function editMode() : void
        {
            if (currentState == "no_edit")
            {
                this.currentState = "edit";
                trace("currentState=" + this.currentState);
            }
            else
            {
                this.editElement();
            }
            return;
        }// end function

        private function deleteElement() : void
        {
            if (this.currentState == "no_edit")
            {
                dispatchEvent(new RubricaElementEvent(RubricaElementEvent.DELETE_EVENT, "", this._itemData));
            }
            else if (this.currentState == "edit")
            {
                this.deleteEdit();
            }
            return;
        }// end function

        private function _NomeNumero_Label2_i() : Label
        {
            var _loc_1:* = new Label();
            this.numero_txt = _loc_1;
            _loc_1.width = 80;
            _loc_1.height = 17;
            _loc_1.setStyle("paddingTop", 1);
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 11);
            _loc_1.setStyle("color", 734012);
            _loc_1.id = "numero_txt";
            BindingManager.executeBindings(this, "numero_txt", this.numero_txt);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _NomeNumero_State3_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "edit";
            _loc_1.overrides = [this._NomeNumero_AddChild2_c()];
            _loc_1.addEventListener("enterState", this.___NomeNumero_State3_enterState);
            _loc_1.addEventListener("exitState", this.___NomeNumero_State3_exitState);
            return _loc_1;
        }// end function

        public function setFocusToName() : void
        {
            this.nome_txt_edit.setFocus();
            var _loc_1:* = this.nome_txt_edit.text.length;
            this.nome_txt_edit.selectionEndIndex = this.nome_txt_edit.text.length;
            this.nome_txt_edit.selectionBeginIndex = _loc_1;
            return;
        }// end function

        public function __close_toolTipCreate(event:ToolTipEvent) : void
        {
            var _loc_2:* = new CustomToolTip();
            _loc_2.text = this.setTextCloseButton();
            event.toolTip = _loc_2;
            return;
        }// end function

        private function _NomeNumero_bindingsSetup() : Array
        {
            var binding:Binding;
            var result:Array;
            binding = new Binding(this, function () : DisplayObject
            {
                return box_pencil;
            }// end function
            , function (param1:DisplayObject) : void
            {
                _NomeNumero_RemoveChild1.target = param1;
                return;
            }// end function
            , "_NomeNumero_RemoveChild1.target");
            result[0] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = this._itemData.nameHtmlText;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                nome_txt.htmlText = param1;
                return;
            }// end function
            , "nome_txt.htmlText");
            result[1] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = this._itemData.phoneNumberHtmlText;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                numero_txt.htmlText = param1;
                return;
            }// end function
            , "numero_txt.htmlText");
            result[2] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = this._itemData.name;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                nome_txt_edit.text = param1;
                return;
            }// end function
            , "nome_txt_edit.text");
            result[3] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = this._itemData.phoneNumber;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                numero_txt_edit.text = param1;
                return;
            }// end function
            , "numero_txt_edit.text");
            result[4] = binding;
            return result;
        }// end function

        public function get nome_txt_edit() : TextInput
        {
            return this._1197660383nome_txt_edit;
        }// end function

        public function textOut() : void
        {
            if (currentState == "no_edit" && this.enabled)
            {
                this.nome_txt.htmlText = this._prevNameText;
                this.numero_txt.htmlText = this._prevPhoneNumberText;
            }
            return;
        }// end function

        private function setTextEditButton() : String
        {
            if (this.currentState == "edit")
            {
                return CustomToolTip.EDIT_SALVA_RUBRICA_TT;
            }
            return CustomToolTip.MODIFICA_TT;
        }// end function

        public function get numero_txt() : Label
        {
            return this._1654887475numero_txt;
        }// end function

        public function set close(param1:Button) : void
        {
            var _loc_2:* = this._94756344close;
            if (_loc_2 !== param1)
            {
                this._94756344close = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "close", _loc_2, param1));
            }
            return;
        }// end function

        public function __box_input_edit_mouseOut(event:MouseEvent) : void
        {
            this.textOut();
            return;
        }// end function

        public function get close() : Button
        {
            return this._94756344close;
        }// end function

        function _NomeNumero_StylesInit() : void
        {
            var style:CSSStyleDeclaration;
            var effects:Array;
            if (mx_internal::_NomeNumero_StylesInit_done)
            {
                return;
            }
            mx_internal::_NomeNumero_StylesInit_done = true;
            style = StyleManager.getStyleDeclaration(".matitaButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".matitaButton", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.skin = ProgrammaticSkin;
                this.selectedOverIcon = _embed_css__________img_rubrica_spunta_ok_red_png_1094085665;
                this.overIcon = _embed_css__________img_rubrica_matita_red_png_1165110169;
                this.icon = _embed_css__________img_rubrica_matita_gray_png_556931013;
                this.selectedUpIcon = _embed_css__________img_rubrica_spunta_ok_gray_png_2016586711;
                this.selectedDownIcon = _embed_css__________img_rubrica_spunta_ok_gray_png_2016586711;
                return;
            }// end function
            ;
            }
            return;
        }// end function

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
        {
            NomeNumero._watcherSetupUtil = param1;
            return;
        }// end function

    }
}
