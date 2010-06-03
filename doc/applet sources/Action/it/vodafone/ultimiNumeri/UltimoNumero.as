package it.vodafone.ultimiNumeri
{
    import flash.display.*;
    import flash.events.*;
    import flash.ui.*;
    import flash.utils.*;
    import it.vodafone.rubrica.*;
    import it.vodafone.tooltip.*;
    import mx.binding.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.skins.*;
    import mx.states.*;
    import mx.styles.*;

    public class UltimoNumero extends Canvas implements IBindingClient
    {
        private var _94756344close:Button;
        private var _embed_css_______img_rubrica_tastino_rubrica_over_png_2105458430:Class;
        private var _embed_css____rubrica_aggiungi_ultimo_rubrica_png_1652301806:Class;
        private var _embed__font_defFont_medium_italic_2028228629:Class;
        private var _embed_css____rubrica_tastino_rubrica_over_png_454975747:Class;
        private var _embed__font_defFont_medium_normal_759203218:Class;
        private var _embed_css____rubrica_matita_gray_png_1796589621:Class;
        private var _embed_css____rubrica_tastino_ultimi_over_png_964028153:Class;
        private var _embed_css____v1_6_options_zero_png_1246442480:Class;
        private var _embed_css_______img_rubrica_tastino_ultimi_over_png_2008771874:Class;
        public var _UltimoNumero_RemoveChild1:RemoveChild;
        public var _UltimoNumero_RemoveChild2:RemoveChild;
        private var _embed_css_new_gray_png_2044589479:Class;
        private var _embed_mxml__________img_rubrica_chiudi_red_png_547352636:Class;
        private var _846912525addRubrica:Button;
        private var _embed_css_new_white_png_730022019:Class;
        var _bindingsByDestination:Object;
        private var _embed_css_new_red_png_732240187:Class;
        private var _embed__font_defFont_bold_normal_606214327:Class;
        private var _441974271box_pencil:Box;
        private var _inRubrica:Boolean = false;
        private var _embed_css_options_png_1474387353:Class;
        private var _embed_css_login_png_1222187874:Class;
        private var _embed_css____rubrica_spunta_ok_gray_png_1104226581:Class;
        private var _embed_css____rubrica_tastino_ultimi_png_1445431594:Class;
        private var _1381067850nome_txt:Label;
        private var _prevNameText:String;
        private var _embed_css____rubrica_tastino_rubrica_png_1712337664:Class;
        private var _1081247946matita:Button;
        var _watchers:Array;
        public var _UltimoNumero_SetProperty1:SetProperty;
        private var _249143097cancass_pencile:Canvas;
        private var _prevPhoneNumberText:String;
        private var _isEditMode:Object = false;
        private var _embed_css_campo_png_306194249:Class;
        private var _embed_css____rubrica_aggiungi_ultimo_rubrica_over_png_301954929:Class;
        private var _embed_css_close_png_456345135:Class;
        private var _embed_css____rubrica_matita_red_png_507272915:Class;
        var _bindingsBeginWithWord:Object;
        private var _embed_css____rubrica_spunta_ok_red_png_1127504823:Class;
        private var _1267551932_itemData:UltimoNumeroElement;
        private var _embed_css____v1_6_close_zero_png_636215014:Class;
        private var _embed_css_window_png_1571993685:Class;
        private var _embed_mxml__________img_rubrica_chiudi_gray_png_1610796422:Class;
        private var _1087927382box_input:Box;
        private var _1654887475numero_txt:Label;
        private var _embed_css_dim1_png_1026764538:Class;
        var _bindings:Array;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var _embed__font_defFont_bold_italic_162026115:Class;
        static var _UltimoNumero_StylesInit_done:Boolean = false;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public function UltimoNumero()
        {
            this._documentDescriptor_ = new UIComponentDescriptor({type:Canvas, propertiesFactory:function () : Object
            {
                return {width:243, height:16, childDescriptors:[new UIComponentDescriptor({type:Box, id:"box_input", events:{mouseDown:"__box_input_mouseDown", toolTipCreate:"__box_input_toolTipCreate", mouseOver:"__box_input_mouseOver", mouseOut:"__box_input_mouseOut"}, stylesFactory:function () : void
                {
                    this.horizontalGap = 2;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {toolTip:" ", direction:"horizontal", width:200, height:16, buttonMode:true, useHandCursor:true, mouseChildren:false, y:0, childDescriptors:[new UIComponentDescriptor({type:Label, id:"nome_txt", stylesFactory:function () : void
                    {
                        this.paddingLeft = 3;
                        this.paddingTop = 1;
                        this.fontFamily = "Arial";
                        this.fontSize = 11;
                        return;
                    }// end function
                    , propertiesFactory:function () : Object
                    {
                        return {x:0, y:0, width:129, height:17};
                    }// end function
                    }), new UIComponentDescriptor({type:Label, id:"numero_txt", stylesFactory:function () : void
                    {
                        this.paddingTop = 1;
                        this.fontFamily = "Arial";
                        this.fontSize = 11;
                        this.color = 734012;
                        return;
                    }// end function
                    , propertiesFactory:function () : Object
                    {
                        return {width:80, height:17};
                    }// end function
                    })]};
                }// end function
                }), new UIComponentDescriptor({type:Box, id:"box_pencil", stylesFactory:function () : void
                {
                    this.horizontalGap = 2;
                    this.themeColor = 13369858;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {x:214, direction:"horizontal", width:27, height:14, buttonMode:true, useHandCursor:true, y:3};
                }// end function
                }), new UIComponentDescriptor({type:Canvas, id:"cancass_pencile", propertiesFactory:function () : Object
                {
                    return {width:41, height:16, x:200, childDescriptors:[new UIComponentDescriptor({type:Button, id:"matita", events:{toolTipCreate:"__matita_toolTipCreate", click:"__matita_click"}, stylesFactory:function () : void
                    {
                        this.themeColor = 13369858;
                        return;
                    }// end function
                    , propertiesFactory:function () : Object
                    {
                        return {toolTip:" ", x:14, y:2, styleName:"matitaButton", label:"Button", width:12, height:13};
                    }// end function
                    }), new UIComponentDescriptor({type:Button, id:"addRubrica", events:{toolTipCreate:"__addRubrica_toolTipCreate", click:"__addRubrica_click"}, stylesFactory:function () : void
                    {
                        this.themeColor = 13369858;
                        return;
                    }// end function
                    , propertiesFactory:function () : Object
                    {
                        return {toolTip:" ", styleName:"addRubricaButton", label:"Button", width:12, height:13, x:14, y:1};
                    }// end function
                    }), new UIComponentDescriptor({type:Button, id:"close", events:{toolTipCreate:"__close_toolTipCreate", click:"__close_click"}, stylesFactory:function () : void
                    {
                        this.upSkin = _embed_mxml__________img_rubrica_chiudi_gray_png_1610796422;
                        this.disabledIcon = _embed_mxml__________img_rubrica_chiudi_gray_png_1610796422;
                        this.overSkin = _embed_mxml__________img_rubrica_chiudi_red_png_547352636;
                        this.downSkin = _embed_mxml__________img_rubrica_chiudi_red_png_547352636;
                        return;
                    }// end function
                    , propertiesFactory:function () : Object
                    {
                        return {toolTip:" ", x:27, y:3, label:"Button", width:11, height:11};
                    }// end function
                    })]};
                }// end function
                }), new UIComponentDescriptor({type:HRule, propertiesFactory:function () : Object
                {
                    return {x:0, y:0, width:243, height:1};
                }// end function
                })]};
            }// end function
            });
            this._embed__font_defFont_bold_italic_162026115 = UltimoNumero__embed__font_defFont_bold_italic_162026115;
            this._embed__font_defFont_bold_normal_606214327 = UltimoNumero__embed__font_defFont_bold_normal_606214327;
            this._embed__font_defFont_medium_italic_2028228629 = UltimoNumero__embed__font_defFont_medium_italic_2028228629;
            this._embed__font_defFont_medium_normal_759203218 = UltimoNumero__embed__font_defFont_medium_normal_759203218;
            this._embed_css_______img_rubrica_tastino_rubrica_over_png_2105458430 = UltimoNumero__embed_css_______img_rubrica_tastino_rubrica_over_png_2105458430;
            this._embed_css_______img_rubrica_tastino_ultimi_over_png_2008771874 = UltimoNumero__embed_css_______img_rubrica_tastino_ultimi_over_png_2008771874;
            this._embed_css____rubrica_aggiungi_ultimo_rubrica_over_png_301954929 = UltimoNumero__embed_css____rubrica_aggiungi_ultimo_rubrica_over_png_301954929;
            this._embed_css____rubrica_aggiungi_ultimo_rubrica_png_1652301806 = UltimoNumero__embed_css____rubrica_aggiungi_ultimo_rubrica_png_1652301806;
            this._embed_css____rubrica_matita_gray_png_1796589621 = UltimoNumero__embed_css____rubrica_matita_gray_png_1796589621;
            this._embed_css____rubrica_matita_red_png_507272915 = UltimoNumero__embed_css____rubrica_matita_red_png_507272915;
            this._embed_css____rubrica_spunta_ok_gray_png_1104226581 = UltimoNumero__embed_css____rubrica_spunta_ok_gray_png_1104226581;
            this._embed_css____rubrica_spunta_ok_red_png_1127504823 = UltimoNumero__embed_css____rubrica_spunta_ok_red_png_1127504823;
            this._embed_css____rubrica_tastino_rubrica_over_png_454975747 = UltimoNumero__embed_css____rubrica_tastino_rubrica_over_png_454975747;
            this._embed_css____rubrica_tastino_rubrica_png_1712337664 = UltimoNumero__embed_css____rubrica_tastino_rubrica_png_1712337664;
            this._embed_css____rubrica_tastino_ultimi_over_png_964028153 = UltimoNumero__embed_css____rubrica_tastino_ultimi_over_png_964028153;
            this._embed_css____rubrica_tastino_ultimi_png_1445431594 = UltimoNumero__embed_css____rubrica_tastino_ultimi_png_1445431594;
            this._embed_css____v1_6_close_zero_png_636215014 = UltimoNumero__embed_css____v1_6_close_zero_png_636215014;
            this._embed_css____v1_6_options_zero_png_1246442480 = UltimoNumero__embed_css____v1_6_options_zero_png_1246442480;
            this._embed_css_campo_png_306194249 = UltimoNumero__embed_css_campo_png_306194249;
            this._embed_css_close_png_456345135 = UltimoNumero__embed_css_close_png_456345135;
            this._embed_css_dim1_png_1026764538 = UltimoNumero__embed_css_dim1_png_1026764538;
            this._embed_css_login_png_1222187874 = UltimoNumero__embed_css_login_png_1222187874;
            this._embed_css_new_gray_png_2044589479 = UltimoNumero__embed_css_new_gray_png_2044589479;
            this._embed_css_new_red_png_732240187 = UltimoNumero__embed_css_new_red_png_732240187;
            this._embed_css_new_white_png_730022019 = UltimoNumero__embed_css_new_white_png_730022019;
            this._embed_css_options_png_1474387353 = UltimoNumero__embed_css_options_png_1474387353;
            this._embed_css_window_png_1571993685 = UltimoNumero__embed_css_window_png_1571993685;
            this._embed_mxml__________img_rubrica_chiudi_gray_png_1610796422 = UltimoNumero__embed_mxml__________img_rubrica_chiudi_gray_png_1610796422;
            this._embed_mxml__________img_rubrica_chiudi_red_png_547352636 = UltimoNumero__embed_mxml__________img_rubrica_chiudi_red_png_547352636;
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
            .mx_internal::_UltimoNumero_StylesInit();
            this.width = 243;
            this.height = 16;
            this.tabEnabled = false;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.states = [this._UltimoNumero_State1_c()];
            this._UltimoNumero_SetProperty1_i();
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

        public function init() : void
        {
            this.currentState = "";
            this.tabChildren = false;
            this.addEventListener(KeyboardEvent.KEY_DOWN, this.keyPressed);
            return;
        }// end function

        public function __box_input_mouseOut(event:MouseEvent) : void
        {
            this.textOut();
            return;
        }// end function

        private function _UltimoNumero_RemoveChild2_i() : RemoveChild
        {
            var _loc_1:* = new RemoveChild();
            this._UltimoNumero_RemoveChild2 = _loc_1;
            BindingManager.executeBindings(this, "_UltimoNumero_RemoveChild2", this._UltimoNumero_RemoveChild2);
            return _loc_1;
        }// end function

        public function __addRubrica_click(event:MouseEvent) : void
        {
            this.addMode();
            return;
        }// end function

        public function __matita_click(event:MouseEvent) : void
        {
            this.editMode();
            return;
        }// end function

        public function get matita() : Button
        {
            return this._1081247946matita;
        }// end function

        public function __addRubrica_toolTipCreate(event:ToolTipEvent) : void
        {
            var _loc_2:* = new CustomToolTip();
            _loc_2.text = this.setTextEditButton();
            event.toolTip = _loc_2;
            return;
        }// end function

        public function __matita_toolTipCreate(event:ToolTipEvent) : void
        {
            var _loc_2:* = new CustomToolTip();
            _loc_2.text = this.setTextEditButton();
            event.toolTip = _loc_2;
            return;
        }// end function

        private function _UltimoNumero_RemoveChild1_i() : RemoveChild
        {
            var _loc_1:* = new RemoveChild();
            this._UltimoNumero_RemoveChild1 = _loc_1;
            BindingManager.executeBindings(this, "_UltimoNumero_RemoveChild1", this._UltimoNumero_RemoveChild1);
            return _loc_1;
        }// end function

        public function get itemData() : UltimoNumeroElement
        {
            return this._itemData;
        }// end function

        public function setModality(param1:Boolean) : void
        {
            this._isEditMode = param1;
            return;
        }// end function

        public function __box_input_mouseDown(event:MouseEvent) : void
        {
            this.selectElement();
            return;
        }// end function

        public function selectElement() : void
        {
            dispatchEvent(new UltimoNumeroEvent(UltimoNumeroEvent.SELECT_ELEMENT, "", this._itemData));
            return;
        }// end function

        public function get box_input() : Box
        {
            return this._1087927382box_input;
        }// end function

        private function _UltimoNumero_bindingExprs() : void
        {
            var _loc_1:* = undefined;
            _loc_1 = this.cancass_pencile;
            _loc_1 = this.box_input;
            _loc_1 = RubricaElement.truncateText(this._itemData.name);
            _loc_1 = this._itemData.phoneNumber;
            _loc_1 = this._isEditMode;
            _loc_1 = !this._isEditMode;
            return;
        }// end function

        private function _UltimoNumero_bindingsSetup() : Array
        {
            var binding:Binding;
            var result:Array;
            binding = new Binding(this, function () : DisplayObject
            {
                return cancass_pencile;
            }// end function
            , function (param1:DisplayObject) : void
            {
                _UltimoNumero_RemoveChild1.target = param1;
                return;
            }// end function
            , "_UltimoNumero_RemoveChild1.target");
            result[0] = binding;
            binding = new Binding(this, function () : DisplayObject
            {
                return box_input;
            }// end function
            , function (param1:DisplayObject) : void
            {
                _UltimoNumero_RemoveChild2.target = param1;
                return;
            }// end function
            , "_UltimoNumero_RemoveChild2.target");
            result[1] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = RubricaElement.truncateText(this._itemData.name);
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                nome_txt.htmlText = param1;
                return;
            }// end function
            , "nome_txt.htmlText");
            result[2] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = this._itemData.phoneNumber;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                numero_txt.htmlText = param1;
                return;
            }// end function
            , "numero_txt.htmlText");
            result[3] = binding;
            binding = new Binding(this, function () : Boolean
            {
                return _isEditMode;
            }// end function
            , function (param1:Boolean) : void
            {
                matita.visible = param1;
                return;
            }// end function
            , "matita.visible");
            result[4] = binding;
            binding = new Binding(this, function () : Boolean
            {
                return !_isEditMode;
            }// end function
            , function (param1:Boolean) : void
            {
                addRubrica.visible = param1;
                return;
            }// end function
            , "addRubrica.visible");
            result[5] = binding;
            return result;
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

        private function set _itemData(param1:UltimoNumeroElement) : void
        {
            var _loc_2:* = this._1267551932_itemData;
            if (_loc_2 !== param1)
            {
                this._1267551932_itemData = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_itemData", _loc_2, param1));
            }
            return;
        }// end function

        function _UltimoNumero_StylesInit() : void
        {
            var style:CSSStyleDeclaration;
            var effects:Array;
            if (mx_internal::_UltimoNumero_StylesInit_done)
            {
                return;
            }
            mx_internal::_UltimoNumero_StylesInit_done = true;
            style = StyleManager.getStyleDeclaration(".windowCanvas");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".windowCanvas", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.right = 0;
                this.top = 0;
                this.left = 0;
                this.bottom = 0;
                this.backgroundImage = _embed_css_window_png_1571993685;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".linkRegistrati");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".linkRegistrati", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 0;
                this.textAlign = "left";
                this.selectionColor = 16777215;
                this.paddingLeft = 0;
                this.fontWeight = "normal";
                this.cornerRadius = 0;
                this.paddingRight = 0;
                this.rollOverColor = 16777215;
                this.fontSize = 10;
                this.horizontalGap = 0;
                this.paddingBottom = 0;
                this.fontFamily = "defFont";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".rubricaButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".rubricaButton", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.skin = ProgrammaticSkin;
                this.borderRight = 0;
                this.paddingLeft = 0;
                this.selectedOverIcon = _embed_css_______img_rubrica_tastino_rubrica_over_png_2105458430;
                this.overIcon = _embed_css____rubrica_tastino_rubrica_over_png_454975747;
                this.marginRight = 0;
                this.paddingBottom = 0;
                this.selectedDownIcon = _embed_css_______img_rubrica_tastino_rubrica_over_png_2105458430;
                this.marginBottom = 0;
                this.borderLeft = 0;
                this.paddingTop = 0;
                this.borderTop = 0;
                this.paddingRight = 0;
                this.borderBottom = 0;
                this.icon = _embed_css____rubrica_tastino_rubrica_png_1712337664;
                this.marginLeft = 0;
                this.selectedUpIcon = _embed_css_______img_rubrica_tastino_rubrica_over_png_2105458430;
                this.marginTop = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".noEmbeddedFont");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".noEmbeddedFont", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.fontFamily = "Arial,Helvetica,sans-serif";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".close");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".close", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.upSkin = _embed_css_close_png_456345135;
                this.downSkin = _embed_css_close_png_456345135;
                this.overSkin = _embed_css_close_png_456345135;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".newWhite");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".newWhite", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.upSkin = _embed_css_new_white_png_730022019;
                this.downSkin = _embed_css_new_red_png_732240187;
                this.overSkin = _embed_css_new_red_png_732240187;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".loginButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".loginButton", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.upSkin = _embed_css_login_png_1222187874;
                this.downSkin = _embed_css_login_png_1222187874;
                this.overSkin = _embed_css_login_png_1222187874;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".addRubricaButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".addRubricaButton", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.skin = ProgrammaticSkin;
                this.borderRight = 0;
                this.paddingLeft = 0;
                this.selectedOverIcon = _embed_css____rubrica_aggiungi_ultimo_rubrica_over_png_301954929;
                this.overIcon = _embed_css____rubrica_aggiungi_ultimo_rubrica_over_png_301954929;
                this.position = "absolute";
                this.marginRight = 0;
                this.paddingBottom = 0;
                this.selectedDownIcon = _embed_css____rubrica_aggiungi_ultimo_rubrica_over_png_301954929;
                this.marginBottom = 0;
                this.borderLeft = 0;
                this.paddingTop = 0;
                this.borderTop = 0;
                this.paddingRight = 0;
                this.borderBottom = 0;
                this.icon = _embed_css____rubrica_aggiungi_ultimo_rubrica_png_1652301806;
                this.marginLeft = 0;
                this.selectedUpIcon = _embed_css____rubrica_aggiungi_ultimo_rubrica_over_png_301954929;
                this.marginTop = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".rubricaButtonOpen");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".rubricaButtonOpen", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.skin = ProgrammaticSkin;
                this.borderRight = 0;
                this.paddingLeft = 0;
                this.selectedOverIcon = _embed_css_______img_rubrica_tastino_rubrica_over_png_2105458430;
                this.overIcon = _embed_css____rubrica_tastino_rubrica_over_png_454975747;
                this.marginRight = 0;
                this.paddingBottom = 0;
                this.selectedDownIcon = _embed_css_______img_rubrica_tastino_rubrica_over_png_2105458430;
                this.marginBottom = 0;
                this.borderLeft = 0;
                this.paddingTop = 0;
                this.borderTop = 0;
                this.paddingRight = 0;
                this.borderBottom = 0;
                this.icon = _embed_css____rubrica_tastino_rubrica_over_png_454975747;
                this.marginLeft = 0;
                this.selectedUpIcon = _embed_css_______img_rubrica_tastino_rubrica_over_png_2105458430;
                this.marginTop = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".options");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".options", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.upSkin = _embed_css_options_png_1474387353;
                this.downSkin = _embed_css_options_png_1474387353;
                this.overSkin = _embed_css_options_png_1474387353;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".spuntaIconaButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".spuntaIconaButton", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.skin = ProgrammaticSkin;
                this.borderRight = 0;
                this.paddingLeft = 0;
                this.selectedOverIcon = _embed_css____rubrica_spunta_ok_red_png_1127504823;
                this.overIcon = _embed_css____rubrica_spunta_ok_red_png_1127504823;
                this.position = "absolute";
                this.marginRight = 0;
                this.paddingBottom = 0;
                this.selectedDownIcon = _embed_css____rubrica_spunta_ok_red_png_1127504823;
                this.marginBottom = 0;
                this.borderLeft = 0;
                this.paddingTop = 0;
                this.borderTop = 0;
                this.paddingRight = 0;
                this.borderBottom = 0;
                this.icon = _embed_css____rubrica_spunta_ok_gray_png_1104226581;
                this.marginLeft = 0;
                this.selectedUpIcon = _embed_css____rubrica_spunta_ok_red_png_1127504823;
                this.marginTop = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".loginUser");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".loginUser", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 4;
                this.paddingLeft = 6;
                this.fontSize = 11;
                this.backgroundImage = _embed_css_campo_png_306194249;
                this.focusAlpha = 0;
                this.borderStyle = "none";
                this.fontFamily = "Arial,Helvetica,sans-serif";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".linkHelp");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".linkHelp", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 0;
                this.textAlign = "left";
                this.selectionColor = 16777215;
                this.paddingLeft = 0;
                this.fontWeight = "normal";
                this.cornerRadius = 0;
                this.paddingRight = 0;
                this.rollOverColor = 16777215;
                this.fontSize = 10;
                this.horizontalGap = 0;
                this.paddingBottom = 0;
                this.fontFamily = "defFont";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".prompt");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".prompt", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.right = 60;
                this.textAlign = "center";
                this.top = 70;
                this.fontStyle = "condensed";
                this.left = 60;
                this.bottom = 150;
                this.fontSize = 9;
                this.horizontalCenter = 0;
                this.fontFamily = "defFont";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".loginPassword");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".loginPassword", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 4;
                this.paddingLeft = 6;
                this.fontSize = 11;
                this.backgroundImage = _embed_css_campo_png_306194249;
                this.focusAlpha = 0;
                this.borderStyle = "none";
                this.fontFamily = "Arial,Helvetica,sans-serif";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".linkDimenticati");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".linkDimenticati", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.paddingTop = 0;
                this.textAlign = "left";
                this.selectionColor = 16777215;
                this.paddingLeft = 0;
                this.fontWeight = "normal";
                this.cornerRadius = 0;
                this.paddingRight = 0;
                this.rollOverColor = 16777215;
                this.fontSize = 10;
                this.horizontalGap = 0;
                this.paddingBottom = 0;
                this.fontFamily = "defFont";
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".closeZero");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".closeZero", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.upSkin = _embed_css____v1_6_close_zero_png_636215014;
                this.downSkin = _embed_css____v1_6_close_zero_png_636215014;
                this.overSkin = _embed_css____v1_6_close_zero_png_636215014;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".optionsZero");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".optionsZero", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.upSkin = _embed_css____v1_6_options_zero_png_1246442480;
                this.downSkin = _embed_css____v1_6_options_zero_png_1246442480;
                this.overSkin = _embed_css____v1_6_options_zero_png_1246442480;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".ultimiNumeriButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".ultimiNumeriButton", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.skin = ProgrammaticSkin;
                this.borderRight = 0;
                this.paddingLeft = 0;
                this.selectedOverIcon = _embed_css_______img_rubrica_tastino_ultimi_over_png_2008771874;
                this.overIcon = _embed_css____rubrica_tastino_ultimi_over_png_964028153;
                this.marginRight = 0;
                this.paddingBottom = 0;
                this.selectedDownIcon = _embed_css_______img_rubrica_tastino_ultimi_over_png_2008771874;
                this.marginBottom = 0;
                this.borderLeft = 0;
                this.paddingTop = 0;
                this.borderTop = 0;
                this.paddingRight = 0;
                this.borderBottom = 0;
                this.icon = _embed_css____rubrica_tastino_ultimi_png_1445431594;
                this.marginLeft = 0;
                this.selectedUpIcon = _embed_css_______img_rubrica_tastino_ultimi_over_png_2008771874;
                this.marginTop = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".newGray");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".newGray", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.upSkin = _embed_css_new_gray_png_2044589479;
                this.downSkin = _embed_css_new_red_png_732240187;
                this.overSkin = _embed_css_new_red_png_732240187;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".rememberMe");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".rememberMe", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.fontSize = 9;
                this.fontFamily = "defFont";
                return;
            }// end function
            ;
            }
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
                this.borderRight = 0;
                this.paddingLeft = 0;
                this.selectedOverIcon = _embed_css____rubrica_matita_red_png_507272915;
                this.overIcon = _embed_css____rubrica_matita_red_png_507272915;
                this.position = "absolute";
                this.marginRight = 0;
                this.paddingBottom = 0;
                this.selectedDownIcon = _embed_css____rubrica_matita_red_png_507272915;
                this.marginBottom = 0;
                this.borderLeft = 0;
                this.paddingTop = 0;
                this.borderTop = 0;
                this.paddingRight = 0;
                this.borderBottom = 0;
                this.icon = _embed_css____rubrica_matita_gray_png_1796589621;
                this.marginLeft = 0;
                this.selectedUpIcon = _embed_css____rubrica_matita_red_png_507272915;
                this.marginTop = 0;
                return;
            }// end function
            ;
            }
            style = StyleManager.getStyleDeclaration(".popupCanvas");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".popupCanvas", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.right = 0;
                this.top = 0;
                this.left = 0;
                this.bottom = 0;
                this.backgroundImage = _embed_css_dim1_png_1026764538;
                return;
            }// end function
            ;
            }
            return;
        }// end function

        public function set cancass_pencile(param1:Canvas) : void
        {
            var _loc_2:* = this._249143097cancass_pencile;
            if (_loc_2 !== param1)
            {
                this._249143097cancass_pencile = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cancass_pencile", _loc_2, param1));
            }
            return;
        }// end function

        override public function initialize() : void
        {
            var target:UltimoNumero;
            var watcherSetupUtilClass:Object;
            .mx_internal::setDocumentDescriptor(this._documentDescriptor_);
            var bindings:* = this._UltimoNumero_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_it_vodafone_ultimiNumeri_UltimoNumeroWatcherSetupUtil");
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

        private function _UltimoNumero_State1_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "empty";
            _loc_1.overrides = [this._UltimoNumero_RemoveChild1_i(), this._UltimoNumero_RemoveChild2_i()];
            return _loc_1;
        }// end function

        public function get nome_txt() : Label
        {
            return this._1381067850nome_txt;
        }// end function

        public function __box_input_mouseOver(event:MouseEvent) : void
        {
            this.textOver();
            return;
        }// end function

        private function _UltimoNumero_SetProperty1_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            this._UltimoNumero_SetProperty1 = _loc_1;
            _loc_1.name = "height";
            _loc_1.value = 16.75;
            return _loc_1;
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

        public function textOver() : void
        {
            this.setFocus();
            this._prevNameText = this.nome_txt.htmlText;
            this._prevPhoneNumberText = this.numero_txt.htmlText;
            this.nome_txt.htmlText = "<font color=\'#FF0000\'>" + RubricaElement.truncateText(this._itemData.name) + "</font>";
            this.numero_txt.htmlText = "<font color=\'#FF0000\'>" + this._itemData.phoneNumber + "</font>";
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

        public function __close_click(event:MouseEvent) : void
        {
            this.deleteElement();
            return;
        }// end function

        public function set itemData(param1:UltimoNumeroElement) : void
        {
            this._itemData = param1;
            this._inRubrica = this._itemData.name != "";
            this._prevNameText = this._itemData.name;
            this._prevPhoneNumberText = this._itemData.phoneNumber;
            return;
        }// end function

        public function __box_input_toolTipCreate(event:ToolTipEvent) : void
        {
            var _loc_2:* = new CustomToolTip();
            _loc_2.text = CustomToolTip.SELEZIONA_TT;
            event.toolTip = _loc_2;
            return;
        }// end function

        public function keyPressed(event:KeyboardEvent) : void
        {
            switch(event.charCode)
            {
                case Keyboard.ENTER:
                {
                    event.stopImmediatePropagation();
                    this.selectElement();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function get cancass_pencile() : Canvas
        {
            return this._249143097cancass_pencile;
        }// end function

        private function editMode() : void
        {
            trace("UltimoNumero, editMode");
            this.dispatchEvent(new UltimoNumeroEvent(UltimoNumeroEvent.EDIT_EVENT, "", this._itemData));
            return;
        }// end function

        private function deleteElement() : void
        {
            dispatchEvent(new UltimoNumeroEvent(UltimoNumeroEvent.DELETE_EVENT, "", this._itemData));
            return;
        }// end function

        public function __close_toolTipCreate(event:ToolTipEvent) : void
        {
            var _loc_2:* = new CustomToolTip();
            _loc_2.text = CustomToolTip.DELETE_ULTIMI_NUMERI;
            event.toolTip = _loc_2;
            return;
        }// end function

        public function get numero_txt() : Label
        {
            return this._1654887475numero_txt;
        }// end function

        private function get _itemData() : UltimoNumeroElement
        {
            return this._1267551932_itemData;
        }// end function

        public function textOut() : void
        {
            this.nome_txt.htmlText = this._prevNameText;
            this.numero_txt.htmlText = this._prevPhoneNumberText;
            return;
        }// end function

        private function addMode() : void
        {
            trace("UltimoNumero, addMode");
            this.dispatchEvent(new UltimoNumeroEvent(UltimoNumeroEvent.ADD_EVENT, "", this._itemData));
            return;
        }// end function

        private function setTextEditButton() : String
        {
            if (this._inRubrica)
            {
                return CustomToolTip.EDIT_ULTIMI_NUMERI_TT;
            }
            return CustomToolTip.ADD_ULTIMI_NUMERI_TT;
        }// end function

        public function set addRubrica(param1:Button) : void
        {
            var _loc_2:* = this._846912525addRubrica;
            if (_loc_2 !== param1)
            {
                this._846912525addRubrica = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "addRubrica", _loc_2, param1));
            }
            return;
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

        public function get addRubrica() : Button
        {
            return this._846912525addRubrica;
        }// end function

        public function get close() : Button
        {
            return this._94756344close;
        }// end function

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
        {
            UltimoNumero._watcherSetupUtil = param1;
            return;
        }// end function

    }
}
