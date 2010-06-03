package it.vodafone
{
    import flash.events.*;
    import flash.ui.*;
    import flash.utils.*;
    import it.vodafone.rubrica.*;
    import it.vodafone.tooltip.*;
    import it.vodafone.ultimiNumeri.*;
    import mx.binding.*;
    import mx.collections.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.skins.*;
    import mx.states.*;
    import mx.styles.*;
    import mx.utils.*;

    public class Sms extends Canvas implements IBindingClient
    {
        private var _embed_css____rubrica_aggiungi_ultimo_rubrica_png_1652301806:Class;
        private var _embed_css____rubrica_tastino_rubrica_over_png_454975747:Class;
        private var _embed__font_defFont_medium_italic_2028228629:Class;
        private var _embed__font_defFont_medium_normal_759203218:Class;
        private var _embed_css____rubrica_matita_gray_png_1796589621:Class;
        private var _embed_css____v1_6_options_zero_png_1246442480:Class;
        private var _embed_mxml_______img_v1_bt_invia_over_png_351165109:Class;
        private var lastStatus:int = 0;
        private var _embed_mxml_______img_rubrica_salva_numero_png_393824601:Class;
        private var base64Dec:Base64Decoder;
        private var _embed_css_new_gray_png_2044589479:Class;
        private var _381878489maxChars:String = "360";
        private var _embed_css_______img_rubrica_tastino_ultimi_over_png_458293130:Class;
        private var _embed_mxml_______img_v1_sf_testo_png_652117877:Class;
        var _bindingsByDestination:Object;
        private const _defaultTextNumero:String = "Nome o Numero Vodafone";
        private var _embed_mxml_______img_v1_captcha_text_box_png_174853629:Class;
        private var _1110417475label1:Label;
        private var _947861995f_numero:TextInput;
        private var _embed_mxml_______img_v1_sms_alert_png_311204495:Class;
        private var _1442688484currentChars:String = "0";
        private var timerRetry:Timer;
        private var _embed_css_new_red_png_732240187:Class;
        private var _embed_mxml_______img_v1_bt_invia_png_374427265:Class;
        private var _embed_css_login_png_1222187874:Class;
        public var _Sms_SetProperty2:SetProperty;
        public var _Sms_SetProperty3:SetProperty;
        public var _Sms_SetProperty4:SetProperty;
        public var _Sms_SetProperty5:SetProperty;
        public var _Sms_SetProperty6:SetProperty;
        public var _Sms_SetProperty7:SetProperty;
        public var _Sms_Text2:Text;
        public var _Sms_Text3:Text;
        private var _1600092163_loading:Loading;
        public var _Sms_SetProperty1:SetProperty;
        public var _Sms_Text5:Text;
        private var _embed_css_______img_rubrica_tastino_rubrica_over_png_1439062842:Class;
        private var _1081150123maxSms:String = "10";
        private var _110256293text2:Text;
        private var _embed_css____rubrica_matita_red_png_507272915:Class;
        private var _1980093870rubrica_component:Rubrica;
        private var _embed_css____v1_6_close_zero_png_636215014:Class;
        private var _embed_css_dim1_png_1026764538:Class;
        private var _embed_mxml_______img_v1_bt_ok_over_png_1456551835:Class;
        private var _embed_css____rubrica_tastino_ultimi_over_png_964028153:Class;
        private var _2106634404i_captcha:Image;
        private var _241352511button1:Button;
        private var _userAlertVisible:Boolean = false;
        private var _embed_mxml_______img_v1_bt_ok_png_656072527:Class;
        public var _Sms_Label2:Label;
        private var _1165958089testo_sms:TextArea;
        public var _Sms_Label4:Label;
        private var _1060936799f_captcha:TextInput;
        private var _embed_css_new_white_png_730022019:Class;
        private var _embed__font_defFont_bold_normal_606214327:Class;
        private var _1778446965ultimi_numeri_component:UltimiNumeri;
        private var _1458435989button_ultimi:Button;
        private var _sendPhoneNumber:String;
        private var _embed_css_options_png_1474387353:Class;
        private var _embed_css____rubrica_spunta_ok_gray_png_1104226581:Class;
        private const _defaultTextSms:String = "Scrivi qui il tuo SMS";
        private var _embed_css____rubrica_tastino_ultimi_png_1445431594:Class;
        var _watchers:Array;
        private var _embed_css____rubrica_tastino_rubrica_png_1712337664:Class;
        private var specialChar:ArrayCollection;
        private var _159365177button_rubrica:Button;
        private var _embed_css_close_png_456345135:Class;
        private var _193290069bt_send:Button;
        private var _embed_css_campo_png_306194249:Class;
        private var _embed_mxml_______img_rubrica_salva_numero_over_png_1678637297:Class;
        private var _embed_css____rubrica_aggiungi_ultimo_rubrica_over_png_301954929:Class;
        var _bindingsBeginWithWord:Object;
        private var _embed_mxml_______img_rubrica_textinput_ricerca_short_png_557458897:Class;
        private var _embed_css____rubrica_spunta_ok_red_png_1127504823:Class;
        private var _947543008transparence_canvass:Canvas;
        private var _embed_css_window_png_1571993685:Class;
        private var _1159380522_errorText:String = "";
        var _bindings:Array;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var _embed__font_defFont_bold_italic_162026115:Class;
        private static var _watcherSetupUtil:IWatcherSetupUtil;
        public static const ULTIMI_NUMERI_OPENED:String = "ultimi_numeri_opened";
        static var _Sms_StylesInit_done:Boolean = false;
        public static const RUBRICA_OPENED:String = "rubrica_opened";
        public static const RUBRICA_CLOSED:String = "rubrica_closed";
        public static const SET_FOCUS_TO_TEXT_NUMBER:String = "set_focus_to_text_number";
        public static const ULTIMI_NUMERI_CLOSED:String = "ultimi_numeri_closed";

        public function Sms()
        {
            this._documentDescriptor_ = new UIComponentDescriptor({type:Canvas, propertiesFactory:function () : Object
            {
                return {width:260, height:125, childDescriptors:[new UIComponentDescriptor({type:TextInput, id:"f_numero", events:{change:"__f_numero_change", focusIn:"__f_numero_focusIn", click:"__f_numero_click"}, stylesFactory:function () : void
                {
                    this.backgroundImage = _embed_mxml_______img_rubrica_textinput_ricerca_short_png_557458897;
                    this.borderStyle = "none";
                    this.paddingLeft = 4;
                    this.fontFamily = "Arial";
                    this.fontSize = 11;
                    this.paddingTop = 3;
                    this.focusAlpha = 0;
                    this.themeColor = 16711680;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {x:8, y:17, width:195, height:22, maxChars:100, styleName:"noEmbeddedFont"};
                }// end function
                }), new UIComponentDescriptor({type:TextArea, id:"testo_sms", events:{change:"__testo_sms_change", focusIn:"__testo_sms_focusIn", click:"__testo_sms_click"}, stylesFactory:function () : void
                {
                    this.borderStyle = "none";
                    this.backgroundImage = _embed_mxml_______img_v1_sf_testo_png_652117877;
                    this.paddingTop = 3;
                    this.paddingLeft = 4;
                    this.focusAlpha = 0;
                    this.fontFamily = "Arial";
                    this.fontSize = 11;
                    this.themeColor = 16711680;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {x:8, y:44, width:245, height:51, wordWrap:true, verticalScrollPolicy:"auto", styleName:"noEmbeddedFont"};
                }// end function
                }), new UIComponentDescriptor({type:Label, id:"label1", stylesFactory:function () : void
                {
                    this.fontFamily = "defFont";
                    this.fontSize = 10;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {x:6, y:97.9, width:169};
                }// end function
                }), new UIComponentDescriptor({type:Image, propertiesFactory:function () : Object
                {
                    return {x:227, y:18, width:2, height:20, source:"img/rubrica/separatore_tastini.png", scaleContent:false, autoLoad:true};
                }// end function
                }), new UIComponentDescriptor({type:Button, id:"button1", events:{click:"__button1_click"}, stylesFactory:function () : void
                {
                    this.upSkin = _embed_mxml_______img_v1_bt_invia_png_374427265;
                    this.overSkin = _embed_mxml_______img_v1_bt_invia_over_png_351165109;
                    this.downSkin = _embed_mxml_______img_v1_bt_invia_png_374427265;
                    this.themeColor = 13369858;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {y:103, buttonMode:true, useHandCursor:true, x:171};
                }// end function
                }), new UIComponentDescriptor({type:Button, id:"button_ultimi", events:{click:"__button_ultimi_click", toolTipCreate:"__button_ultimi_toolTipCreate"}, stylesFactory:function () : void
                {
                    this.themeColor = 13369858;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {x:229, y:18, buttonMode:true, useHandCursor:true, styleName:"ultimiNumeriButton", toolTip:" ", alpha:1};
                }// end function
                }), new UIComponentDescriptor({type:Button, id:"button_rubrica", events:{click:"__button_rubrica_click", toolTipCreate:"__button_rubrica_toolTipCreate"}, stylesFactory:function () : void
                {
                    this.themeColor = 13369858;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {x:203, y:18, buttonMode:true, useHandCursor:true, styleName:"rubricaButton", toolTip:" ", alpha:1};
                }// end function
                }), new UIComponentDescriptor({type:Label, id:"_Sms_Label2", stylesFactory:function () : void
                {
                    this.fontFamily = "defFont";
                    this.fontSize = 9;
                    this.fontWeight = "normal";
                    this.color = 16777215;
                    this.textAlign = "center";
                    this.left = "7";
                    this.right = "7";
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {y:158};
                }// end function
                }), new UIComponentDescriptor({type:Label, stylesFactory:function () : void
                {
                    this.fontFamily = "defFont";
                    this.color = 16711680;
                    this.fontSize = 14;
                    this.fontWeight = "bold";
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {x:4, y:-3, text:"Invia SMS gratis!", height:21, width:126};
                }// end function
                }), new UIComponentDescriptor({type:Label, id:"_Sms_Label4", stylesFactory:function () : void
                {
                    this.fontFamily = "defFont";
                    this.fontSize = 11;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {x:127, y:0};
                }// end function
                }), new UIComponentDescriptor({type:Rubrica, id:"rubrica_component", propertiesFactory:function () : Object
                {
                    return {x:8, y:38, visible:false};
                }// end function
                }), new UIComponentDescriptor({type:Canvas, id:"transparence_canvass", stylesFactory:function () : void
                {
                    this.backgroundAlpha = 0;
                    this.backgroundColor = 65280;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {x:0, y:0, width:260, height:18};
                }// end function
                }), new UIComponentDescriptor({type:UltimiNumeri, id:"ultimi_numeri_component", propertiesFactory:function () : Object
                {
                    return {x:8, y:38, visible:false};
                }// end function
                })]};
            }// end function
            });
            this.specialChar = new ArrayCollection([{ch:"à ", v:2}, {ch:"è ", v:2}, {ch:"ì ", v:2}, {ch:"ò ", v:2}, {ch:"ù ", v:2}, {ch:"é ", v:2}]);
            this._embed__font_defFont_bold_italic_162026115 = Sms__embed__font_defFont_bold_italic_162026115;
            this._embed__font_defFont_bold_normal_606214327 = Sms__embed__font_defFont_bold_normal_606214327;
            this._embed__font_defFont_medium_italic_2028228629 = Sms__embed__font_defFont_medium_italic_2028228629;
            this._embed__font_defFont_medium_normal_759203218 = Sms__embed__font_defFont_medium_normal_759203218;
            this._embed_css_______img_rubrica_tastino_rubrica_over_png_1439062842 = Sms__embed_css_______img_rubrica_tastino_rubrica_over_png_1439062842;
            this._embed_css_______img_rubrica_tastino_ultimi_over_png_458293130 = Sms__embed_css_______img_rubrica_tastino_ultimi_over_png_458293130;
            this._embed_css____rubrica_aggiungi_ultimo_rubrica_over_png_301954929 = Sms__embed_css____rubrica_aggiungi_ultimo_rubrica_over_png_301954929;
            this._embed_css____rubrica_aggiungi_ultimo_rubrica_png_1652301806 = Sms__embed_css____rubrica_aggiungi_ultimo_rubrica_png_1652301806;
            this._embed_css____rubrica_matita_gray_png_1796589621 = Sms__embed_css____rubrica_matita_gray_png_1796589621;
            this._embed_css____rubrica_matita_red_png_507272915 = Sms__embed_css____rubrica_matita_red_png_507272915;
            this._embed_css____rubrica_spunta_ok_gray_png_1104226581 = Sms__embed_css____rubrica_spunta_ok_gray_png_1104226581;
            this._embed_css____rubrica_spunta_ok_red_png_1127504823 = Sms__embed_css____rubrica_spunta_ok_red_png_1127504823;
            this._embed_css____rubrica_tastino_rubrica_over_png_454975747 = Sms__embed_css____rubrica_tastino_rubrica_over_png_454975747;
            this._embed_css____rubrica_tastino_rubrica_png_1712337664 = Sms__embed_css____rubrica_tastino_rubrica_png_1712337664;
            this._embed_css____rubrica_tastino_ultimi_over_png_964028153 = Sms__embed_css____rubrica_tastino_ultimi_over_png_964028153;
            this._embed_css____rubrica_tastino_ultimi_png_1445431594 = Sms__embed_css____rubrica_tastino_ultimi_png_1445431594;
            this._embed_css____v1_6_close_zero_png_636215014 = Sms__embed_css____v1_6_close_zero_png_636215014;
            this._embed_css____v1_6_options_zero_png_1246442480 = Sms__embed_css____v1_6_options_zero_png_1246442480;
            this._embed_css_campo_png_306194249 = Sms__embed_css_campo_png_306194249;
            this._embed_css_close_png_456345135 = Sms__embed_css_close_png_456345135;
            this._embed_css_dim1_png_1026764538 = Sms__embed_css_dim1_png_1026764538;
            this._embed_css_login_png_1222187874 = Sms__embed_css_login_png_1222187874;
            this._embed_css_new_gray_png_2044589479 = Sms__embed_css_new_gray_png_2044589479;
            this._embed_css_new_red_png_732240187 = Sms__embed_css_new_red_png_732240187;
            this._embed_css_new_white_png_730022019 = Sms__embed_css_new_white_png_730022019;
            this._embed_css_options_png_1474387353 = Sms__embed_css_options_png_1474387353;
            this._embed_css_window_png_1571993685 = Sms__embed_css_window_png_1571993685;
            this._embed_mxml_______img_rubrica_salva_numero_over_png_1678637297 = Sms__embed_mxml_______img_rubrica_salva_numero_over_png_1678637297;
            this._embed_mxml_______img_rubrica_salva_numero_png_393824601 = Sms__embed_mxml_______img_rubrica_salva_numero_png_393824601;
            this._embed_mxml_______img_rubrica_textinput_ricerca_short_png_557458897 = Sms__embed_mxml_______img_rubrica_textinput_ricerca_short_png_557458897;
            this._embed_mxml_______img_v1_bt_invia_over_png_351165109 = Sms__embed_mxml_______img_v1_bt_invia_over_png_351165109;
            this._embed_mxml_______img_v1_bt_invia_png_374427265 = Sms__embed_mxml_______img_v1_bt_invia_png_374427265;
            this._embed_mxml_______img_v1_bt_ok_over_png_1456551835 = Sms__embed_mxml_______img_v1_bt_ok_over_png_1456551835;
            this._embed_mxml_______img_v1_bt_ok_png_656072527 = Sms__embed_mxml_______img_v1_bt_ok_png_656072527;
            this._embed_mxml_______img_v1_captcha_text_box_png_174853629 = Sms__embed_mxml_______img_v1_captcha_text_box_png_174853629;
            this._embed_mxml_______img_v1_sf_testo_png_652117877 = Sms__embed_mxml_______img_v1_sf_testo_png_652117877;
            this._embed_mxml_______img_v1_sms_alert_png_311204495 = Sms__embed_mxml_______img_v1_sms_alert_png_311204495;
            this._bindings = [];
            this._watchers = [];
            this._bindingsByDestination = {};
            this._bindingsBeginWithWord = {};
            mx_internal::_document = this;
            .mx_internal::_Sms_StylesInit();
            this.width = 260;
            this.height = 125;
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            this.states = [this._Sms_State1_c(), this._Sms_State2_c(), this._Sms_State3_c(), this._Sms_State4_c(), this._Sms_State5_c(), this._Sms_State6_c(), this._Sms_State7_c()];
            this.addEventListener("addedToStage", this.___Sms_Canvas1_addedToStage);
            return;
        }// end function

        private function errorOk() : void
        {
            currentState = "";
            var _loc_1:Boolean = true;
            this.button_ultimi.tabEnabled = true;
            var _loc_1:* = _loc_1;
            this.button_rubrica.tabEnabled = _loc_1;
            this.button1.tabEnabled = _loc_1;
            this.userAlertClosed(null);
            return;
        }// end function

        private function convertchars(param1:String) : String
        {
            if (param1 == null || param1 == "")
            {
                return "";
            }
            var _loc_2:String = "";
            var _loc_3:int = 0;
            while (_loc_3 < param1.length)
            {
                
                if (param1.charAt(_loc_3) == "è ")
                {
                    _loc_2 = _loc_2 + "e\'";
                }
                else if (param1.charAt(_loc_3) == "é ")
                {
                    _loc_2 = _loc_2 + "e\'";
                }
                else if (param1.charAt(_loc_3) == "ò ")
                {
                    _loc_2 = _loc_2 + "o\'";
                }
                else if (param1.charAt(_loc_3) == "à ")
                {
                    _loc_2 = _loc_2 + "a\'";
                }
                else if (param1.charAt(_loc_3) == "ù ")
                {
                    _loc_2 = _loc_2 + "u\'";
                }
                else if (param1.charAt(_loc_3) == "ì ")
                {
                    _loc_2 = _loc_2 + "i\'";
                }
                else
                {
                    _loc_2 = _loc_2 + param1.charAt(_loc_3);
                }
                _loc_3++;
            }
            return _loc_2;
        }// end function

        public function get f_numero() : TextInput
        {
            return this._947861995f_numero;
        }// end function

        private function _Sms_AddChild3_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._Sms_Canvas4_c);
            return _loc_1;
        }// end function

        function _Sms_StylesInit() : void
        {
            var style:CSSStyleDeclaration;
            var effects:Array;
            if (mx_internal::_Sms_StylesInit_done)
            {
                return;
            }
            mx_internal::_Sms_StylesInit_done = true;
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
                this.selectedOverIcon = _embed_css_______img_rubrica_tastino_rubrica_over_png_1439062842;
                this.overIcon = _embed_css____rubrica_tastino_rubrica_over_png_454975747;
                this.marginRight = 0;
                this.paddingBottom = 0;
                this.selectedDownIcon = _embed_css_______img_rubrica_tastino_rubrica_over_png_1439062842;
                this.marginBottom = 0;
                this.borderLeft = 0;
                this.paddingTop = 0;
                this.borderTop = 0;
                this.paddingRight = 0;
                this.borderBottom = 0;
                this.icon = _embed_css____rubrica_tastino_rubrica_png_1712337664;
                this.marginLeft = 0;
                this.selectedUpIcon = _embed_css_______img_rubrica_tastino_rubrica_over_png_1439062842;
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
                this.selectedOverIcon = _embed_css_______img_rubrica_tastino_rubrica_over_png_1439062842;
                this.overIcon = _embed_css____rubrica_tastino_rubrica_over_png_454975747;
                this.marginRight = 0;
                this.paddingBottom = 0;
                this.selectedDownIcon = _embed_css_______img_rubrica_tastino_rubrica_over_png_1439062842;
                this.marginBottom = 0;
                this.borderLeft = 0;
                this.paddingTop = 0;
                this.borderTop = 0;
                this.paddingRight = 0;
                this.borderBottom = 0;
                this.icon = _embed_css____rubrica_tastino_rubrica_over_png_454975747;
                this.marginLeft = 0;
                this.selectedUpIcon = _embed_css_______img_rubrica_tastino_rubrica_over_png_1439062842;
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
                this.selectedOverIcon = _embed_css_______img_rubrica_tastino_ultimi_over_png_458293130;
                this.overIcon = _embed_css____rubrica_tastino_ultimi_over_png_964028153;
                this.marginRight = 0;
                this.paddingBottom = 0;
                this.selectedDownIcon = _embed_css_______img_rubrica_tastino_ultimi_over_png_458293130;
                this.marginBottom = 0;
                this.borderLeft = 0;
                this.paddingTop = 0;
                this.borderTop = 0;
                this.paddingRight = 0;
                this.borderBottom = 0;
                this.icon = _embed_css____rubrica_tastino_ultimi_png_1445431594;
                this.marginLeft = 0;
                this.selectedUpIcon = _embed_css_______img_rubrica_tastino_ultimi_over_png_458293130;
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

        private function _Sms_Canvas8_c() : Canvas
        {
            var _loc_1:* = new Canvas();
            _loc_1.x = 7;
            _loc_1.y = 16;
            _loc_1.width = 247;
            _loc_1.height = 106;
            _loc_1.setStyle("backgroundImage", this._embed_mxml_______img_v1_sms_alert_png_311204495);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            _loc_1.addChild(this._Sms_Text7_c());
            _loc_1.addChild(this._Sms_Button5_c());
            _loc_1.addChild(this._Sms_Button6_c());
            return _loc_1;
        }// end function

        private function openCloseRubrica(event:Event = null) : void
        {
            trace("Sms, openCloseRubrica");
            this.rubrica_component.openClose();
            trace("Sms, openCloseRubrica: rubrica_component.isOpen=" + this.rubrica_component.isOpen);
            trace("Sms, openCloseRubrica: ultimi_numeri_component.isOpen=" + this.ultimi_numeri_component.isOpen);
            if (this.rubrica_component.isOpen)
            {
                this.ultimi_numeri_component.close();
                trace("Sms, openCloseRubrica: rubrica_component.isOpen=" + this.rubrica_component.isOpen);
                trace("Sms, openCloseRubrica: ultimi_numeri_component.isOpen=" + this.ultimi_numeri_component.isOpen);
            }
            return;
        }// end function

        private function ultimiNumeriOpened(event:Event) : void
        {
            trace("Sms, ultimiNumeriOpened: button_ultimi.selected=true");
            this.button_ultimi.selected = true;
            var _loc_2:Boolean = false;
            this.button1.tabEnabled = false;
            this.testo_sms.tabEnabled = _loc_2;
            return;
        }// end function

        public function set f_numero(param1:TextInput) : void
        {
            var _loc_2:* = this._947861995f_numero;
            if (_loc_2 !== param1)
            {
                this._947861995f_numero = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "f_numero", _loc_2, param1));
            }
            return;
        }// end function

        private function _Sms_Text3_i() : Text
        {
            var _loc_1:* = new Text();
            this._Sms_Text3 = _loc_1;
            _loc_1.width = 228;
            _loc_1.selectable = false;
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 11);
            _loc_1.setStyle("textAlign", "center");
            _loc_1.setStyle("horizontalCenter", "0");
            _loc_1.setStyle("verticalCenter", "-20");
            _loc_1.setStyle("color", 16777215);
            _loc_1.id = "_Sms_Text3";
            BindingManager.executeBindings(this, "_Sms_Text3", this._Sms_Text3);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function switchMsisdn(event:Event) : void
        {
            this.lastStatus = 0;
            ServerBridge.getServerBridgeInstance().precheckSMS();
            return;
        }// end function

        private function _Sms_SetProperty3_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            this._Sms_SetProperty3 = _loc_1;
            _loc_1.name = "y";
            _loc_1.value = 101;
            BindingManager.executeBindings(this, "_Sms_SetProperty3", this._Sms_SetProperty3);
            return _loc_1;
        }// end function

        private function setTextToolTip() : String
        {
            if (!this.rubrica_component.isOpen)
            {
                return CustomToolTip.OPEN_RUBRICA_TT;
            }
            return CustomToolTip.CLOSE_RUBRICA_TT;
        }// end function

        public function __testo_sms_focusIn(event:FocusEvent) : void
        {
            this.resetTextSMS();
            return;
        }// end function

        public function __button_rubrica_toolTipCreate(event:ToolTipEvent) : void
        {
            var _loc_2:* = new CustomToolTip();
            _loc_2.text = this.setTextToolTip();
            event.toolTip = _loc_2;
            return;
        }// end function

        public function get testo_sms() : TextArea
        {
            return this._1165958089testo_sms;
        }// end function

        public function set transparence_canvass(param1:Canvas) : void
        {
            var _loc_2:* = this._947543008transparence_canvass;
            if (_loc_2 !== param1)
            {
                this._947543008transparence_canvass = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "transparence_canvass", _loc_2, param1));
            }
            return;
        }// end function

        public function __bt_send_click(event:MouseEvent) : void
        {
            this.sendSmsCaptcha();
            return;
        }// end function

        public function ___Sms_Button5_click(event:MouseEvent) : void
        {
            this.sentOk();
            return;
        }// end function

        private function sessionRestored(event:Event) : void
        {
            ServerBridge.getServerBridgeInstance().precheckSMS();
            return;
        }// end function

        public function get transparence_canvass() : Canvas
        {
            return this._947543008transparence_canvass;
        }// end function

        private function smserror(event:Event) : void
        {
            this.lastStatus = 0;
            this._errorText = ServerBridge.getServerBridgeInstance().lastSmsError;
            currentState = "error";
            var _loc_2:Boolean = false;
            this.button_ultimi.tabEnabled = false;
            var _loc_2:* = _loc_2;
            this.button_rubrica.tabEnabled = _loc_2;
            this.button1.tabEnabled = _loc_2;
            return;
        }// end function

        public function get rubrica_component() : Rubrica
        {
            return this._1980093870rubrica_component;
        }// end function

        private function _Sms_AddChild2_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._Sms_Canvas3_c);
            return _loc_1;
        }// end function

        private function rubricaClosed(event:Event) : void
        {
            trace("Sms, rubricaClosed: removeEventListener TEXT_INPUT");
            this.testo_sms.removeEventListener(TextEvent.TEXT_INPUT, this.textInputChange);
            trace("Sms, rubricaClosed: button_rubrica.selected=false");
            this.button_rubrica.selected = false;
            this.testo_sms.setFocus();
            return;
        }// end function

        private function _Sms_Canvas7_c() : Canvas
        {
            var _loc_1:* = new Canvas();
            _loc_1.x = 7;
            _loc_1.y = 17;
            _loc_1.width = 247;
            _loc_1.height = 102;
            _loc_1.setStyle("backgroundImage", this._embed_mxml_______img_v1_sms_alert_png_311204495);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            _loc_1.addChild(this._Sms_Text6_c());
            _loc_1.addChild(this._Sms_Button4_c());
            return _loc_1;
        }// end function

        private function setFocusToTextNumber(event:Event) : void
        {
            var _loc_2:* = this.f_numero.text.length;
            this.f_numero.selectionEndIndex = this.f_numero.text.length;
            this.f_numero.selectionBeginIndex = _loc_2;
            this.f_numero.setFocus();
            return;
        }// end function

        private function _Sms_Text2_i() : Text
        {
            var _loc_1:* = new Text();
            this._Sms_Text2 = _loc_1;
            _loc_1.width = 228;
            _loc_1.selectable = false;
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 11);
            _loc_1.setStyle("textAlign", "center");
            _loc_1.setStyle("horizontalCenter", "0");
            _loc_1.setStyle("verticalCenter", "-20");
            _loc_1.setStyle("color", 16777215);
            _loc_1.id = "_Sms_Text2";
            BindingManager.executeBindings(this, "_Sms_Text2", this._Sms_Text2);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _Sms_State7_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "sent_add";
            _loc_1.overrides = [this._Sms_AddChild8_c(), this._Sms_SetProperty7_i()];
            return _loc_1;
        }// end function

        private function _Sms_SetProperty2_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            this._Sms_SetProperty2 = _loc_1;
            _loc_1.name = "y";
            _loc_1.value = 101;
            BindingManager.executeBindings(this, "_Sms_SetProperty2", this._Sms_SetProperty2);
            return _loc_1;
        }// end function

        public function set testo_sms(param1:TextArea) : void
        {
            var _loc_2:* = this._1165958089testo_sms;
            if (_loc_2 !== param1)
            {
                this._1165958089testo_sms = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "testo_sms", _loc_2, param1));
            }
            return;
        }// end function

        public function set loading(param1:Loading) : void
        {
            this._loading = param1;
            if (param1 != null)
            {
                param1.addEventListener("user_ok", this.userAlertClosed);
            }
            return;
        }// end function

        private function networkError(event:Event) : void
        {
            this.lastStatus = 0;
            this.timerRetry = new Timer(30000, 1);
            this.timerRetry.addEventListener(TimerEvent.TIMER_COMPLETE, this.retryPrecheck);
            this.timerRetry.start();
            this._errorText = "Connessione non disponibile.";
            currentState = "fatalError";
            var _loc_2:Boolean = false;
            this.button_ultimi.tabEnabled = false;
            var _loc_2:* = _loc_2;
            this.button_rubrica.tabEnabled = _loc_2;
            this.button1.tabEnabled = _loc_2;
            return;
        }// end function

        public function __button_ultimi_click(event:MouseEvent) : void
        {
            this.openCloseUltimi();
            return;
        }// end function

        private function pesaLettera(param1:String) : Number
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.specialChar.length)
            {
                
                if (this.specialChar[_loc_2].ch == param1)
                {
                    return this.specialChar[_loc_2].v;
                }
                _loc_2++;
            }
            return 1;
        }// end function

        private function sendSmsCaptcha() : void
        {
            ServerBridge.getServerBridgeInstance().sendSmsWithCaptcha(this.f_numero.text.replace(" ", ""), this.testo_sms.text, this.f_captcha.text);
            this.lastStatus = 2;
            currentState = "loading";
            var _loc_1:Boolean = false;
            this.button_ultimi.tabEnabled = false;
            var _loc_1:* = _loc_1;
            this.button_rubrica.tabEnabled = _loc_1;
            this.button1.tabEnabled = _loc_1;
            return;
        }// end function

        private function serverError(event:Event) : void
        {
            this.lastStatus = 0;
            this.timerRetry = new Timer(30000, 1);
            this.timerRetry.addEventListener(TimerEvent.TIMER_COMPLETE, this.retryPrecheck);
            this.timerRetry.start();
            this._errorText = "Il servizio non è al momento disponibile.";
            currentState = "fatalError";
            var _loc_2:Boolean = false;
            this.button_ultimi.tabEnabled = false;
            var _loc_2:* = _loc_2;
            this.button_rubrica.tabEnabled = _loc_2;
            this.button1.tabEnabled = _loc_2;
            return;
        }// end function

        private function smsSent(event:Event) : void
        {
            this._sendPhoneNumber = this.f_numero.text;
            if (this.rubrica_component.rubricaUser.isInList(RubricaElement.formatPhoneNumber(this.f_numero.text)) == -1)
            {
                currentState = "sent_add";
            }
            else
            {
                currentState = "sent";
            }
            trace("Sms, smsSent, to: " + this._sendPhoneNumber);
            trace("Sms, smsSent, to formatted:" + RubricaElement.formatPhoneNumber(this._sendPhoneNumber));
            this.ultimi_numeri_component.addElement(new UltimoNumeroElement("", RubricaElement.formatPhoneNumber(this._sendPhoneNumber)));
            var _loc_2:Boolean = false;
            this.button_ultimi.tabEnabled = false;
            var _loc_2:* = _loc_2;
            this.button_rubrica.tabEnabled = _loc_2;
            this.button1.tabEnabled = _loc_2;
            this._userAlertVisible = true;
            this.testo_sms.text = this._defaultTextSms;
            this.f_numero.text = this._defaultTextNumero;
            this.lastStatus = 0;
            this.ricalcolaCaratteri();
            return;
        }// end function

        public function ___Sms_Button2_click(event:MouseEvent) : void
        {
            this.errorOk();
            return;
        }// end function

        private function editNumberFromUltimi(event:UltimoNumeroEvent) : void
        {
            trace("Sms, editNumberFromUltimi");
            currentState = "";
            this.userAlertClosed(null);
            var _loc_4:Boolean = true;
            this.button_ultimi.tabEnabled = true;
            var _loc_4:* = _loc_4;
            this.button_rubrica.tabEnabled = _loc_4;
            this.button1.tabEnabled = _loc_4;
            this.ultimi_numeri_component.close();
            this.rubrica_component.open();
            this.rubrica_component.showElement("");
            var _loc_2:* = RubricaUser.getIstance(ServerBridge.getServerBridgeInstance().username.toUpperCase());
            var _loc_3:* = this.rubrica_component.rubricaUser.isInList(event.data.phoneNumber);
            if (_loc_3 > -1)
            {
                this.rubrica_component.lista_rubrica.editModeEnteredByPosition(_loc_3);
            }
            else
            {
                trace("Sms, editNumberFromUltimi: si è verificato un errore, non è stato trovato l\'elemento in rubrica per il quale è richiesta la modifica");
            }
            return;
        }// end function

        private function _Sms_AddChild1_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._Sms_Canvas2_c);
            return _loc_1;
        }// end function

        private function _Sms_Button6_c() : Button
        {
            var _loc_1:* = new Button();
            _loc_1.y = 66;
            _loc_1.buttonMode = true;
            _loc_1.useHandCursor = true;
            _loc_1.tabEnabled = true;
            _loc_1.setStyle("upSkin", this._embed_mxml_______img_rubrica_salva_numero_png_393824601);
            _loc_1.setStyle("horizontalCenter", "49");
            _loc_1.setStyle("overSkin", this._embed_mxml_______img_rubrica_salva_numero_over_png_1678637297);
            _loc_1.setStyle("downSkin", this._embed_mxml_______img_rubrica_salva_numero_png_393824601);
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.addEventListener("click", this.___Sms_Button6_click);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function resetTextSMS() : void
        {
            if (this.testo_sms.text == this._defaultTextSms)
            {
                this.testo_sms.text = "";
            }
            return;
        }// end function

        private function openCloseRubricaAndSetFocus(event:Event = null) : void
        {
            this.testo_sms.setFocus();
            this.rubrica_component.openClose();
            return;
        }// end function

        private function _Sms_Text1_c() : Text
        {
            var _loc_1:* = new Text();
            _loc_1.text = "Inserisci il codice che visualizzi in basso nel box e seleziona Invia.";
            _loc_1.width = 178;
            _loc_1.selectable = false;
            _loc_1.height = 42;
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 11);
            _loc_1.setStyle("textAlign", "center");
            _loc_1.setStyle("horizontalCenter", "0");
            _loc_1.setStyle("top", "5");
            _loc_1.setStyle("color", 16777215);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _Sms_Canvas6_c() : Canvas
        {
            var _loc_1:* = new Canvas();
            _loc_1.x = 7;
            _loc_1.y = 17;
            _loc_1.width = 247;
            _loc_1.height = 102;
            _loc_1.setStyle("backgroundImage", this._embed_mxml_______img_v1_sms_alert_png_311204495);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            _loc_1.addChild(this._Sms_Text5_i());
            return _loc_1;
        }// end function

        private function inizializza() : void
        {
            currentState = "";
            var _loc_1:Boolean = true;
            this.button_ultimi.tabEnabled = true;
            var _loc_1:* = _loc_1;
            this.button_rubrica.tabEnabled = _loc_1;
            this.button1.tabEnabled = _loc_1;
            ServerBridge.getServerBridgeInstance().addEventListener(ServerBridge.SMS_CAPTCHA, this.displayCaptcha);
            ServerBridge.getServerBridgeInstance().addEventListener(ServerBridge.USER_DATA_LOADED, this.switchMsisdn);
            ServerBridge.getServerBridgeInstance().addEventListener(ServerBridge.SMS_ERROR, this.smserror);
            ServerBridge.getServerBridgeInstance().addEventListener(ServerBridge.SMS_FATAL_ERROR, this.smsfatalerror);
            ServerBridge.getServerBridgeInstance().addEventListener(ServerBridge.SMS_PRECHECK_COMPLETE, this.smsPrecheck);
            ServerBridge.getServerBridgeInstance().addEventListener(ServerBridge.SMS_SENT, this.smsSent);
            ServerBridge.getServerBridgeInstance().addEventListener(ServerBridge.SMS_NO_MORE_MSG, this.smsfatalerror);
            ServerBridge.getServerBridgeInstance().addEventListener(ServerBridge.NETWORK_ERROR, this.networkError);
            ServerBridge.getServerBridgeInstance().addEventListener(ServerBridge.SERVER_ERROR, this.serverError);
            ServerBridge.getServerBridgeInstance().addEventListener(ServerBridge.SESSION_EXPIRED, this.sessionExpired);
            ServerBridge.getServerBridgeInstance().addEventListener(ServerBridge.SESSION_RESTORED, this.sessionRestored);
            ServerBridge.getServerBridgeInstance().addEventListener(ServerBridge.LOGGED_OUT, this.clearFields);
            if (LocalPreferences.getInstance().storageGet("sms_max_chars") != null)
            {
                this.maxChars = LocalPreferences.getInstance().storageGet("sms_max_chars");
            }
            if (LocalPreferences.getInstance().storageGet("max_sms") != null)
            {
                this.maxSms = LocalPreferences.getInstance().storageGet("max_sms");
            }
            ServerBridge.getServerBridgeInstance().precheckSMS();
            this.addEventListener(UltimoNumeroEvent.SELECT_ELEMENT, this.selectPhoneNumberUltimi);
            this.addEventListener(UltimoNumeroEvent.ADD_EVENT, this.addNumberFromUltimi);
            this.addEventListener(UltimoNumeroEvent.EDIT_EVENT, this.editNumberFromUltimi);
            this.addEventListener(RubricaElementEvent.SELECT_ELEMENT, this.selectPhoneNumber);
            this.f_numero.addEventListener(KeyboardEvent.KEY_UP, this.reportKeyDown, true);
            this.addEventListener(SET_FOCUS_TO_TEXT_NUMBER, this.setFocusToTextNumber);
            this.addEventListener(RUBRICA_OPENED, this.rubricaOpened);
            this.addEventListener(RUBRICA_CLOSED, this.rubricaClosed);
            this.addEventListener(ULTIMI_NUMERI_OPENED, this.ultimiNumeriOpened);
            this.addEventListener(ULTIMI_NUMERI_CLOSED, this.ultimiNumeriClosed);
            return;
        }// end function

        public function __testo_sms_change(event:Event) : void
        {
            this.ricalcolaCaratteri(event);
            return;
        }// end function

        private function _Sms_SetProperty1_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            this._Sms_SetProperty1 = _loc_1;
            _loc_1.name = "y";
            _loc_1.value = 101;
            BindingManager.executeBindings(this, "_Sms_SetProperty1", this._Sms_SetProperty1);
            return _loc_1;
        }// end function

        public function set bt_send(param1:Button) : void
        {
            var _loc_2:* = this._193290069bt_send;
            if (_loc_2 !== param1)
            {
                this._193290069bt_send = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bt_send", _loc_2, param1));
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

        private function textInputChange(event:TextEvent) : void
        {
            if (event.text.charCodeAt(0) == 10)
            {
                event.preventDefault();
            }
            return;
        }// end function

        private function _Sms_State6_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "sent";
            _loc_1.overrides = [this._Sms_AddChild7_c(), this._Sms_SetProperty6_i()];
            return _loc_1;
        }// end function

        public function __button1_click(event:MouseEvent) : void
        {
            this.sendSms();
            return;
        }// end function

        private function setSmsError(param1:String) : void
        {
            this.lastStatus = 0;
            this._errorText = param1;
            currentState = "error";
            var _loc_2:Boolean = false;
            this.button_ultimi.tabEnabled = false;
            var _loc_2:* = _loc_2;
            this.button_rubrica.tabEnabled = _loc_2;
            this.button1.tabEnabled = _loc_2;
            return;
        }// end function

        public function get i_captcha() : Image
        {
            return this._2106634404i_captcha;
        }// end function

        public function get text2() : Text
        {
            return this._110256293text2;
        }// end function

        private function sendSms() : void
        {
            this.button1.drawFocus(false);
            if (this.testo_sms.text.length <= 0 || this.testo_sms.text == this._defaultTextSms)
            {
                this.setSmsError("Scrivi il testo del messaggio.");
                return;
            }
            var _loc_1:* = this.f_numero.text.replace(" ", "").length;
            if (this.f_numero.text == this._defaultTextNumero || this.f_numero.text == "")
            {
                this.setSmsError("Inserisci il numero di cellulare del destinatario.");
                return;
            }
            if (_loc_1 < 9 || _loc_1 > 10)
            {
                this.setSmsError("Il numero di cellulare deve essere di nove o dieci cifre e contenere solo caratteri numerici.");
                return;
            }
            this.lastStatus = 1;
            ServerBridge.getServerBridgeInstance().precheckSMS();
            currentState = "loading";
            var _loc_2:Boolean = false;
            this.button_ultimi.tabEnabled = false;
            var _loc_2:* = _loc_2;
            this.button_rubrica.tabEnabled = _loc_2;
            this.button1.tabEnabled = _loc_2;
            return;
        }// end function

        private function set maxSms(param1:String) : void
        {
            var _loc_2:* = this._1081150123maxSms;
            if (_loc_2 !== param1)
            {
                this._1081150123maxSms = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "maxSms", _loc_2, param1));
            }
            return;
        }// end function

        private function smsPrecheck(event:Event) : void
        {
            if (ServerBridge.getServerBridgeInstance().lastSmsErrorCode == 0)
            {
                currentState = "";
                var _loc_2:Boolean = true;
                this.button_ultimi.tabEnabled = true;
                var _loc_2:* = _loc_2;
                this.button_rubrica.tabEnabled = _loc_2;
                this.button1.tabEnabled = _loc_2;
            }
            this.maxChars = ServerBridge.getServerBridgeInstance().smsMaxLength.toString();
            this.maxSms = ServerBridge.getServerBridgeInstance().smsThresold.toString();
            if (this.maxSms == "NaN")
            {
                this.maxSms = "10";
            }
            if (this.maxChars == "0")
            {
                this.maxChars = "360";
            }
            if (this.lastStatus == 1 || this.lastStatus == 2)
            {
                this.lastStatus = 1;
                ServerBridge.getServerBridgeInstance().sendSMS(this.f_numero.text.replace(" ", ""), this.testo_sms.text);
            }
            return;
        }// end function

        private function _Sms_Button5_c() : Button
        {
            var _loc_1:* = new Button();
            _loc_1.y = 68;
            _loc_1.buttonMode = true;
            _loc_1.useHandCursor = true;
            _loc_1.tabEnabled = true;
            _loc_1.setStyle("upSkin", this._embed_mxml_______img_v1_bt_ok_png_656072527);
            _loc_1.setStyle("horizontalCenter", "-61");
            _loc_1.setStyle("overSkin", this._embed_mxml_______img_v1_bt_ok_over_png_1456551835);
            _loc_1.setStyle("downSkin", this._embed_mxml_______img_v1_bt_ok_png_656072527);
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.addEventListener("click", this.___Sms_Button5_click);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function __f_numero_click(event:MouseEvent) : void
        {
            this.resetTextNum();
            return;
        }// end function

        private function resetTextNum() : void
        {
            if (this.f_numero.text == this._defaultTextNumero)
            {
                this.f_numero.text = "";
            }
            return;
        }// end function

        public function set rubrica_component(param1:Rubrica) : void
        {
            var _loc_2:* = this._1980093870rubrica_component;
            if (_loc_2 !== param1)
            {
                this._1980093870rubrica_component = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rubrica_component", _loc_2, param1));
            }
            return;
        }// end function

        public function __f_captcha_enter(event:FlexEvent) : void
        {
            this.sendSmsCaptcha();
            return;
        }// end function

        private function _Sms_Canvas5_c() : Canvas
        {
            var _loc_1:* = new Canvas();
            _loc_1.x = 7;
            _loc_1.y = 17;
            _loc_1.width = 247;
            _loc_1.height = 102;
            _loc_1.setStyle("backgroundImage", this._embed_mxml_______img_v1_sms_alert_png_311204495);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _Sms_AddChild8_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._Sms_Canvas8_c);
            return _loc_1;
        }// end function

        private function _Sms_Image1_i() : Image
        {
            var _loc_1:* = new Image();
            this.i_captcha = _loc_1;
            _loc_1.autoLoad = true;
            _loc_1.scaleContent = true;
            _loc_1.width = 120;
            _loc_1.height = 30;
            _loc_1.setStyle("left", "9");
            _loc_1.setStyle("top", "47");
            _loc_1.id = "i_captcha";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function get maxChars() : String
        {
            return this._381878489maxChars;
        }// end function

        private function _Sms_State5_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "fatalError";
            _loc_1.overrides = [this._Sms_AddChild6_c(), this._Sms_SetProperty5_i()];
            return _loc_1;
        }// end function

        public function __button_rubrica_click(event:MouseEvent) : void
        {
            this.openCloseRubrica();
            return;
        }// end function

        private function _Sms_Button4_c() : Button
        {
            var _loc_1:* = new Button();
            _loc_1.y = 68;
            _loc_1.buttonMode = true;
            _loc_1.useHandCursor = true;
            _loc_1.tabEnabled = true;
            _loc_1.setStyle("upSkin", this._embed_mxml_______img_v1_bt_ok_png_656072527);
            _loc_1.setStyle("horizontalCenter", "-1");
            _loc_1.setStyle("overSkin", this._embed_mxml_______img_v1_bt_ok_over_png_1456551835);
            _loc_1.setStyle("downSkin", this._embed_mxml_______img_v1_bt_ok_png_656072527);
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.addEventListener("click", this.___Sms_Button4_click);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function ___Sms_Button4_click(event:MouseEvent) : void
        {
            this.sentOk();
            return;
        }// end function

        public function set ultimi_numeri_component(param1:UltimiNumeri) : void
        {
            var _loc_2:* = this._1778446965ultimi_numeri_component;
            if (_loc_2 !== param1)
            {
                this._1778446965ultimi_numeri_component = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ultimi_numeri_component", _loc_2, param1));
            }
            return;
        }// end function

        private function _Sms_Canvas4_c() : Canvas
        {
            var _loc_1:* = new Canvas();
            _loc_1.x = 7;
            _loc_1.y = 17;
            _loc_1.width = 247;
            _loc_1.height = 102;
            _loc_1.setStyle("backgroundImage", this._embed_mxml_______img_v1_sms_alert_png_311204495);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            _loc_1.addChild(this._Sms_Text3_i());
            _loc_1.addChild(this._Sms_Button3_c());
            return _loc_1;
        }// end function

        private function retryPrecheck(event:Event) : void
        {
            ServerBridge.getServerBridgeInstance().precheckSMS();
            return;
        }// end function

        private function userAlertClosed(event:Event) : void
        {
            this._userAlertVisible = false;
            if (ServerBridge.getServerBridgeInstance().lastSmsErrorCode == 107)
            {
                currentState = "fatalError";
                var _loc_2:Boolean = false;
                this.button_ultimi.tabEnabled = false;
                var _loc_2:* = _loc_2;
                this.button_rubrica.tabEnabled = _loc_2;
                this.button1.tabEnabled = _loc_2;
            }
            return;
        }// end function

        private function formatTextNum() : void
        {
            if (RubricaUser.isPhoneNumber(this.f_numero.text))
            {
                this.f_numero.text = RubricaElement.formatPhoneNumber(this.f_numero.text);
            }
            return;
        }// end function

        private function addNumberFromUltimi(event:UltimoNumeroEvent) : void
        {
            trace("Sms, addNumberFromUltimi");
            currentState = "";
            var _loc_2:Boolean = true;
            this.button_ultimi.tabEnabled = true;
            var _loc_2:* = _loc_2;
            this.button_rubrica.tabEnabled = _loc_2;
            this.button1.tabEnabled = _loc_2;
            this.userAlertClosed(null);
            this.ultimi_numeri_component.close();
            this.rubrica_component.open();
            this.rubrica_component.setToAggiungiConttatto(event.data.phoneNumber, true);
            return;
        }// end function

        private function saveNumber() : void
        {
            currentState = "";
            var _loc_1:Boolean = true;
            this.button_ultimi.tabEnabled = true;
            var _loc_1:* = _loc_1;
            this.button_rubrica.tabEnabled = _loc_1;
            this.button1.tabEnabled = _loc_1;
            this.userAlertClosed(null);
            if (this.ultimi_numeri_component.isOpen)
            {
                this.ultimi_numeri_component.close();
            }
            this.rubrica_component.open();
            this.rubrica_component.setToAggiungiConttatto(this._sendPhoneNumber);
            this._sendPhoneNumber = "";
            return;
        }// end function

        private function _Sms_Text7_c() : Text
        {
            var _loc_1:* = new Text();
            _loc_1.text = "Il messaggio è stato inviato.";
            _loc_1.width = 199.2;
            _loc_1.selectable = false;
            _loc_1.height = 39;
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 11);
            _loc_1.setStyle("textAlign", "center");
            _loc_1.setStyle("horizontalCenter", "-2");
            _loc_1.setStyle("verticalCenter", "-15");
            _loc_1.setStyle("color", 16777215);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _Sms_State4_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "loading";
            _loc_1.overrides = [this._Sms_AddChild4_c(), this._Sms_SetProperty4_i(), this._Sms_AddChild5_c()];
            return _loc_1;
        }// end function

        private function _Sms_SetProperty7_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            this._Sms_SetProperty7 = _loc_1;
            _loc_1.name = "y";
            _loc_1.value = 101;
            BindingManager.executeBindings(this, "_Sms_SetProperty7", this._Sms_SetProperty7);
            return _loc_1;
        }// end function

        private function ultimiNumeriClosed(event:Event) : void
        {
            trace("Sms, ultimiNumeriClosed: button_ultimi.selected=false");
            this.button_ultimi.selected = false;
            var _loc_2:Boolean = true;
            this.button1.tabEnabled = true;
            this.testo_sms.tabEnabled = _loc_2;
            return;
        }// end function

        private function _Sms_AddChild7_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._Sms_Canvas7_c);
            return _loc_1;
        }// end function

        private function ricalcolaCaratteri(event:Event = null) : void
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_2:* = this.testo_sms.text;
            if (_loc_2 == this._defaultTextSms)
            {
                this.currentChars = "0";
            }
            else
            {
                _loc_3 = 0;
                _loc_4 = 0;
                while (_loc_4 < _loc_2.length)
                {
                    
                    _loc_3 = _loc_3 + this.pesaLettera(_loc_2.charAt(_loc_4));
                    _loc_4++;
                }
                this.currentChars = _loc_3.toString();
            }
            return;
        }// end function

        public function set button_ultimi(param1:Button) : void
        {
            var _loc_2:* = this._1458435989button_ultimi;
            if (_loc_2 !== param1)
            {
                this._1458435989button_ultimi = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "button_ultimi", _loc_2, param1));
            }
            return;
        }// end function

        public function __f_numero_change(event:Event) : void
        {
            this.changeTextNum();
            return;
        }// end function

        private function setTextToolTipUltimi() : String
        {
            if (!this.ultimi_numeri_component.isOpen)
            {
                return CustomToolTip.OPEN_ULTIMI_NUMERI_TT;
            }
            return CustomToolTip.CLOSE_ULTIMI_NUMERI_TT;
        }// end function

        private function _Sms_bindingExprs() : void
        {
            var _loc_1:* = undefined;
            _loc_1 = this.button1;
            _loc_1 = this._errorText;
            _loc_1 = this.button1;
            _loc_1 = this._errorText;
            _loc_1 = this.button1;
            _loc_1 = this.button1;
            _loc_1 = this._errorText;
            _loc_1 = this.button1;
            _loc_1 = this.button1;
            _loc_1 = this.button1;
            _loc_1 = this._defaultTextNumero;
            _loc_1 = TabIndexManager.INDEX_SMS_NUMBER_TEXT;
            _loc_1 = Number(this.maxChars);
            _loc_1 = this._defaultTextSms;
            _loc_1 = TabIndexManager.INDEX_SMS_TEXT;
            _loc_1 = this.currentChars + "/" + this.maxChars + " caratteri";
            _loc_1 = TabIndexManager.INDEX_SMS_SEND_BUTTON;
            _loc_1 = TabIndexManager.INDEX_ULTIMI_BUTTON;
            _loc_1 = TabIndexManager.INDEX_RUBRICA_BUTTON;
            _loc_1 = "Oggi per te " + this.maxSms + " SMS gratis";
            _loc_1 = "Oggi per te " + this.maxSms + " SMS gratis";
            return;
        }// end function

        public function get button1() : Button
        {
            return this._241352511button1;
        }// end function

        private function _Sms_Button3_c() : Button
        {
            var _loc_1:* = new Button();
            _loc_1.y = 68;
            _loc_1.buttonMode = true;
            _loc_1.useHandCursor = true;
            _loc_1.tabEnabled = true;
            _loc_1.setStyle("upSkin", this._embed_mxml_______img_v1_bt_ok_png_656072527);
            _loc_1.setStyle("horizontalCenter", "0");
            _loc_1.setStyle("overSkin", this._embed_mxml_______img_v1_bt_ok_over_png_1456551835);
            _loc_1.setStyle("downSkin", this._embed_mxml_______img_v1_bt_ok_png_656072527);
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.addEventListener("click", this.___Sms_Button3_click);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function set i_captcha(param1:Image) : void
        {
            var _loc_2:* = this._2106634404i_captcha;
            if (_loc_2 !== param1)
            {
                this._2106634404i_captcha = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "i_captcha", _loc_2, param1));
            }
            return;
        }// end function

        private function changeTextNum() : void
        {
            if (this.f_numero.text.length > 0 && this.f_numero.text != this._defaultTextNumero)
            {
                if (this.ultimi_numeri_component.isOpen)
                {
                    this.ultimi_numeri_component.close();
                }
                this.rubrica_component.open();
            }
            this.rubrica_component.showElement(this.f_numero.text);
            return;
        }// end function

        public function set text2(param1:Text) : void
        {
            var _loc_2:* = this._110256293text2;
            if (_loc_2 !== param1)
            {
                this._110256293text2 = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "text2", _loc_2, param1));
            }
            return;
        }// end function

        public function set f_captcha(param1:TextInput) : void
        {
            var _loc_2:* = this._1060936799f_captcha;
            if (_loc_2 !== param1)
            {
                this._1060936799f_captcha = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "f_captcha", _loc_2, param1));
            }
            return;
        }// end function

        public function get bt_send() : Button
        {
            return this._193290069bt_send;
        }// end function

        private function openCloseUltimi(event:Event = null) : void
        {
            trace("Sms, openCloseUltimi");
            if (this.ultimi_numeri_component.lista_ultimi_numeri != null)
            {
                this.ultimi_numeri_component.lista_ultimi_numeri.drawList();
            }
            this.ultimi_numeri_component.openClose();
            trace("Sms, openCloseUltimi: rubrica_component.isOpen=" + this.rubrica_component.isOpen);
            trace("Sms, openCloseUltimi: ultimi_numeri_component.isOpen=" + this.ultimi_numeri_component.isOpen);
            if (this.ultimi_numeri_component.isOpen)
            {
                this.rubrica_component.close();
                trace("Sms, openCloseUltimi: rubrica_component.isOpen=" + this.rubrica_component.isOpen);
                trace("Sms, openCloseUltimi: ultimi_numeri_component.isOpen=" + this.ultimi_numeri_component.isOpen);
            }
            return;
        }// end function

        private function displayCaptcha(event:Event) : void
        {
            var _loc_2:ByteArray = null;
            if (currentState != "captcha_error" && ServerBridge.getServerBridgeInstance().lastSmsErrorCode == 116)
            {
                this._errorText = "Verifica il codice inserito e invia il tuo SMS.";
                currentState = "captcha_error";
                var _loc_3:Boolean = false;
                this.button_ultimi.tabEnabled = false;
                var _loc_3:* = _loc_3;
                this.button_rubrica.tabEnabled = _loc_3;
                this.button1.tabEnabled = _loc_3;
                this.lastStatus = 1;
                return;
            }
            currentState = "captcha";
            var _loc_3:Boolean = false;
            this.button_ultimi.tabEnabled = false;
            var _loc_3:* = _loc_3;
            this.button_rubrica.tabEnabled = _loc_3;
            this.button1.tabEnabled = _loc_3;
            this.f_captcha.text = "";
            this.f_captcha.maxChars = ServerBridge.getServerBridgeInstance().captchLength;
            this.base64Dec = new Base64Decoder();
            this.base64Dec.decode(ServerBridge.getServerBridgeInstance().captcha);
            _loc_2 = this.base64Dec.toByteArray();
            this.i_captcha.load(_loc_2);
            return;
        }// end function

        private function _Sms_Canvas3_c() : Canvas
        {
            var _loc_1:* = new Canvas();
            _loc_1.x = 7;
            _loc_1.y = 17;
            _loc_1.width = 247;
            _loc_1.height = 102;
            _loc_1.setStyle("backgroundImage", this._embed_mxml_______img_v1_sms_alert_png_311204495);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            _loc_1.addChild(this._Sms_Text2_i());
            _loc_1.addChild(this._Sms_Button2_c());
            return _loc_1;
        }// end function

        private function get maxSms() : String
        {
            return this._1081150123maxSms;
        }// end function

        private function rubricaOpened(event:Event) : void
        {
            trace("Sms, rubricaOpened: addEventListener TEXT_INPUT");
            this.testo_sms.addEventListener(TextEvent.TEXT_INPUT, this.textInputChange);
            trace("Sms, rubricaOpened: button_rubrica.selected=true");
            this.button_rubrica.selected = true;
            return;
        }// end function

        private function _Sms_AddChild6_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._Sms_Canvas6_c);
            return _loc_1;
        }// end function

        private function clearFields(event:Event) : void
        {
            this.f_numero.text = this._defaultTextNumero;
            this.testo_sms.text = this._defaultTextSms;
            this.ricalcolaCaratteri();
            return;
        }// end function

        private function _Sms_Text6_c() : Text
        {
            var _loc_1:* = new Text();
            _loc_1.text = "Il messaggio è stato inviato.";
            _loc_1.width = 199.2;
            _loc_1.selectable = false;
            _loc_1.height = 39;
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 11);
            _loc_1.setStyle("textAlign", "center");
            _loc_1.setStyle("horizontalCenter", "0");
            _loc_1.setStyle("verticalCenter", "-15");
            _loc_1.setStyle("color", 16777215);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _Sms_State3_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "captcha_error";
            _loc_1.overrides = [this._Sms_AddChild3_c(), this._Sms_SetProperty3_i()];
            return _loc_1;
        }// end function

        private function _Sms_SetProperty6_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            this._Sms_SetProperty6 = _loc_1;
            _loc_1.name = "y";
            _loc_1.value = 101;
            BindingManager.executeBindings(this, "_Sms_SetProperty6", this._Sms_SetProperty6);
            return _loc_1;
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

        private function _Sms_Button2_c() : Button
        {
            var _loc_1:* = new Button();
            _loc_1.y = 68;
            _loc_1.buttonMode = true;
            _loc_1.useHandCursor = true;
            _loc_1.tabEnabled = true;
            _loc_1.setStyle("upSkin", this._embed_mxml_______img_v1_bt_ok_png_656072527);
            _loc_1.setStyle("horizontalCenter", "0");
            _loc_1.setStyle("overSkin", this._embed_mxml_______img_v1_bt_ok_over_png_1456551835);
            _loc_1.setStyle("downSkin", this._embed_mxml_______img_v1_bt_ok_png_656072527);
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.addEventListener("click", this.___Sms_Button2_click);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function selectPhoneNumberUltimi(event:UltimoNumeroEvent) : void
        {
            this.ultimi_numeri_component.showElement();
            if (event.data != null)
            {
                this.f_numero.text = event.data.phoneNumber;
            }
            var _loc_2:* = this.testo_sms.text.length;
            this.testo_sms.selectionEndIndex = this.testo_sms.text.length;
            this.testo_sms.selectionBeginIndex = _loc_2;
            this.testo_sms.setFocus();
            if (this.ultimi_numeri_component.isOpen)
            {
                this.openCloseUltimi();
            }
            return;
        }// end function

        public function ___Sms_Button6_click(event:MouseEvent) : void
        {
            this.saveNumber();
            return;
        }// end function

        public function get ultimi_numeri_component() : UltimiNumeri
        {
            return this._1778446965ultimi_numeri_component;
        }// end function

        override public function initialize() : void
        {
            var target:Sms;
            var watcherSetupUtilClass:Object;
            .mx_internal::setDocumentDescriptor(this._documentDescriptor_);
            var bindings:* = this._Sms_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_it_vodafone_SmsWatcherSetupUtil");
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

        private function _Sms_bindingsSetup() : Array
        {
            var binding:Binding;
            var result:Array;
            binding = new Binding(this, function () : Object
            {
                return button1;
            }// end function
            , function (param1:Object) : void
            {
                _Sms_SetProperty1.target = param1;
                return;
            }// end function
            , "_Sms_SetProperty1.target");
            result[0] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = _errorText;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                _Sms_Text2.text = param1;
                return;
            }// end function
            , "_Sms_Text2.text");
            result[1] = binding;
            binding = new Binding(this, function () : Object
            {
                return button1;
            }// end function
            , function (param1:Object) : void
            {
                _Sms_SetProperty2.target = param1;
                return;
            }// end function
            , "_Sms_SetProperty2.target");
            result[2] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = _errorText;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                _Sms_Text3.text = param1;
                return;
            }// end function
            , "_Sms_Text3.text");
            result[3] = binding;
            binding = new Binding(this, function () : Object
            {
                return button1;
            }// end function
            , function (param1:Object) : void
            {
                _Sms_SetProperty3.target = param1;
                return;
            }// end function
            , "_Sms_SetProperty3.target");
            result[4] = binding;
            binding = new Binding(this, function () : Object
            {
                return button1;
            }// end function
            , function (param1:Object) : void
            {
                _Sms_SetProperty4.target = param1;
                return;
            }// end function
            , "_Sms_SetProperty4.target");
            result[5] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = _errorText;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                _Sms_Text5.text = param1;
                return;
            }// end function
            , "_Sms_Text5.text");
            result[6] = binding;
            binding = new Binding(this, function () : Object
            {
                return button1;
            }// end function
            , function (param1:Object) : void
            {
                _Sms_SetProperty5.target = param1;
                return;
            }// end function
            , "_Sms_SetProperty5.target");
            result[7] = binding;
            binding = new Binding(this, function () : Object
            {
                return button1;
            }// end function
            , function (param1:Object) : void
            {
                _Sms_SetProperty6.target = param1;
                return;
            }// end function
            , "_Sms_SetProperty6.target");
            result[8] = binding;
            binding = new Binding(this, function () : Object
            {
                return button1;
            }// end function
            , function (param1:Object) : void
            {
                _Sms_SetProperty7.target = param1;
                return;
            }// end function
            , "_Sms_SetProperty7.target");
            result[9] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = _defaultTextNumero;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                f_numero.text = param1;
                return;
            }// end function
            , "f_numero.text");
            result[10] = binding;
            binding = new Binding(this, function () : int
            {
                return TabIndexManager.INDEX_SMS_NUMBER_TEXT;
            }// end function
            , function (param1:int) : void
            {
                f_numero.tabIndex = param1;
                return;
            }// end function
            , "f_numero.tabIndex");
            result[11] = binding;
            binding = new Binding(this, function () : int
            {
                return Number(maxChars);
            }// end function
            , function (param1:int) : void
            {
                testo_sms.maxChars = param1;
                return;
            }// end function
            , "testo_sms.maxChars");
            result[12] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = _defaultTextSms;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                testo_sms.text = param1;
                return;
            }// end function
            , "testo_sms.text");
            result[13] = binding;
            binding = new Binding(this, function () : int
            {
                return TabIndexManager.INDEX_SMS_TEXT;
            }// end function
            , function (param1:int) : void
            {
                testo_sms.tabIndex = param1;
                return;
            }// end function
            , "testo_sms.tabIndex");
            result[14] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = currentChars + "/" + maxChars + " caratteri";
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                label1.text = param1;
                return;
            }// end function
            , "label1.text");
            result[15] = binding;
            binding = new Binding(this, function () : int
            {
                return TabIndexManager.INDEX_SMS_SEND_BUTTON;
            }// end function
            , function (param1:int) : void
            {
                button1.tabIndex = param1;
                return;
            }// end function
            , "button1.tabIndex");
            result[16] = binding;
            binding = new Binding(this, function () : int
            {
                return TabIndexManager.INDEX_ULTIMI_BUTTON;
            }// end function
            , function (param1:int) : void
            {
                button_ultimi.tabIndex = param1;
                return;
            }// end function
            , "button_ultimi.tabIndex");
            result[17] = binding;
            binding = new Binding(this, function () : int
            {
                return TabIndexManager.INDEX_RUBRICA_BUTTON;
            }// end function
            , function (param1:int) : void
            {
                button_rubrica.tabIndex = param1;
                return;
            }// end function
            , "button_rubrica.tabIndex");
            result[18] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = "Oggi per te " + maxSms + " SMS gratis";
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                _Sms_Label2.text = param1;
                return;
            }// end function
            , "_Sms_Label2.text");
            result[19] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = "Oggi per te " + maxSms + " SMS gratis";
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                _Sms_Label4.text = param1;
                return;
            }// end function
            , "_Sms_Label4.text");
            result[20] = binding;
            return result;
        }// end function

        private function sentOk() : void
        {
            currentState = "";
            var _loc_1:Boolean = true;
            this.button_ultimi.tabEnabled = true;
            var _loc_1:* = _loc_1;
            this.button_rubrica.tabEnabled = _loc_1;
            this.button1.tabEnabled = _loc_1;
            this.userAlertClosed(null);
            if (this.rubrica_component.lista_rubrica != null)
            {
                this.rubrica_component.lista_rubrica.drawList();
            }
            return;
        }// end function

        public function set button_rubrica(param1:Button) : void
        {
            var _loc_2:* = this._159365177button_rubrica;
            if (_loc_2 !== param1)
            {
                this._159365177button_rubrica = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "button_rubrica", _loc_2, param1));
            }
            return;
        }// end function

        private function _Sms_Canvas2_c() : Canvas
        {
            var _loc_1:* = new Canvas();
            _loc_1.x = 7;
            _loc_1.y = 17;
            _loc_1.width = 247;
            _loc_1.height = 102;
            _loc_1.setStyle("backgroundImage", this._embed_mxml_______img_v1_sms_alert_png_311204495);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            _loc_1.addChild(this._Sms_Text1_c());
            _loc_1.addChild(this._Sms_Image1_i());
            _loc_1.addChild(this._Sms_TextInput1_i());
            _loc_1.addChild(this._Sms_Button1_i());
            return _loc_1;
        }// end function

        public function get button_ultimi() : Button
        {
            return this._1458435989button_ultimi;
        }// end function

        private function smsfatalerror(event:Event) : void
        {
            this.lastStatus = 0;
            this._errorText = ServerBridge.getServerBridgeInstance().lastSmsError;
            if (this._userAlertVisible == false)
            {
                currentState = "fatalError";
                var _loc_2:Boolean = false;
                this.button_ultimi.tabEnabled = false;
                var _loc_2:* = _loc_2;
                this.button_rubrica.tabEnabled = _loc_2;
                this.button1.tabEnabled = _loc_2;
            }
            return;
        }// end function

        private function _Sms_AddChild5_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._Sms_Text4_i);
            return _loc_1;
        }// end function

        public function get f_captcha() : TextInput
        {
            return this._1060936799f_captcha;
        }// end function

        public function __testo_sms_click(event:MouseEvent) : void
        {
            this.resetTextSMS();
            return;
        }// end function

        private function _Sms_State2_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "error";
            _loc_1.overrides = [this._Sms_AddChild2_c(), this._Sms_SetProperty2_i()];
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

        private function _Sms_Text5_i() : Text
        {
            var _loc_1:* = new Text();
            this._Sms_Text5 = _loc_1;
            _loc_1.width = 226;
            _loc_1.selectable = false;
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 11);
            _loc_1.setStyle("textAlign", "center");
            _loc_1.setStyle("horizontalCenter", "0");
            _loc_1.setStyle("verticalCenter", "0");
            _loc_1.setStyle("color", 16777215);
            _loc_1.id = "_Sms_Text5";
            BindingManager.executeBindings(this, "_Sms_Text5", this._Sms_Text5);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function ___Sms_Canvas1_addedToStage(event:Event) : void
        {
            this.inizializza();
            return;
        }// end function

        private function _Sms_SetProperty5_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            this._Sms_SetProperty5 = _loc_1;
            _loc_1.name = "y";
            _loc_1.value = 101;
            BindingManager.executeBindings(this, "_Sms_SetProperty5", this._Sms_SetProperty5);
            return _loc_1;
        }// end function

        public function __button_ultimi_toolTipCreate(event:ToolTipEvent) : void
        {
            var _loc_2:* = new CustomToolTip();
            _loc_2.text = this.setTextToolTipUltimi();
            event.toolTip = _loc_2;
            return;
        }// end function

        private function sessionExpired(event:Event) : void
        {
            this.lastStatus = 0;
            trace("Sessione expired");
            return;
        }// end function

        private function set maxChars(param1:String) : void
        {
            var _loc_2:* = this._381878489maxChars;
            if (_loc_2 !== param1)
            {
                this._381878489maxChars = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "maxChars", _loc_2, param1));
            }
            return;
        }// end function

        private function selectPhoneNumber(event:RubricaElementEvent) : void
        {
            this.rubrica_component.showElement();
            if (event.data != null)
            {
                this.f_numero.text = event.data.phoneNumber;
            }
            var _loc_2:* = this.testo_sms.text.length;
            this.testo_sms.selectionEndIndex = this.testo_sms.text.length;
            this.testo_sms.selectionBeginIndex = _loc_2;
            this.testo_sms.setFocus();
            if (this.rubrica_component.isOpen)
            {
                this.openCloseRubrica();
            }
            return;
        }// end function

        private function _Sms_Button1_i() : Button
        {
            var _loc_1:* = new Button();
            this.bt_send = _loc_1;
            _loc_1.y = 80;
            _loc_1.buttonMode = true;
            _loc_1.useHandCursor = true;
            _loc_1.setStyle("upSkin", this._embed_mxml_______img_v1_bt_invia_png_374427265);
            _loc_1.setStyle("horizontalCenter", "0");
            _loc_1.setStyle("overSkin", this._embed_mxml_______img_v1_bt_invia_over_png_351165109);
            _loc_1.setStyle("downSkin", this._embed_mxml_______img_v1_bt_invia_png_374427265);
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.addEventListener("click", this.__bt_send_click);
            _loc_1.id = "bt_send";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function ___Sms_Button3_click(event:MouseEvent) : void
        {
            this.displayCaptcha(null);
            return;
        }// end function

        private function set currentChars(param1:String) : void
        {
            var _loc_2:* = this._1442688484currentChars;
            if (_loc_2 !== param1)
            {
                this._1442688484currentChars = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "currentChars", _loc_2, param1));
            }
            return;
        }// end function

        private function reportKeyDown(event:KeyboardEvent) : void
        {
            var _loc_2:String = null;
            var _loc_3:Boolean = false;
            var _loc_4:RubricaElement = null;
            var _loc_5:RubricaElementEvent = null;
            var _loc_6:Number = NaN;
            trace("reportKeyDown: keyCode=" + event.keyCode);
            trace("reportKeyDown, rubrica_component.isOpen: " + this.rubrica_component.isOpen);
            trace("reportKeyDown, ultimi_numeri_component.isOpen: " + this.ultimi_numeri_component.isOpen);
            switch(event.keyCode)
            {
                case Keyboard.DOWN:
                {
                    trace("reportKeyDown: DOWN");
                    if (this.rubrica_component.isOpen)
                    {
                        this.rubrica_component.lista_rubrica.setFocusFirstElement();
                    }
                    break;
                }
                case Keyboard.ESCAPE:
                {
                    trace("reportKeyDown: ESCAPE");
                    if (this.rubrica_component.isOpen)
                    {
                        this.rubrica_component.close();
                    }
                    break;
                }
                case Keyboard.ENTER:
                {
                    trace("reportKeyDown: ENTER");
                    if (!(this.rubrica_component.isOpen || this.ultimi_numeri_component.isOpen))
                    {
                        trace("reportKeyDown: Rubrica NOT isOpen AND UltimiNumeri NOT isOpen");
                        var _loc_7:* = this.testo_sms.text.length;
                        this.testo_sms.selectionEndIndex = this.testo_sms.text.length;
                        this.testo_sms.selectionBeginIndex = _loc_7;
                        this.testo_sms.setFocus();
                    }
                    else if (this.rubrica_component.isOpen && this.rubrica_component.rubricaUser.isEmpty)
                    {
                        trace("reportKeyDown: Rubrica isOpen AND isEmpty");
                        var _loc_7:* = this.testo_sms.text.length;
                        this.testo_sms.selectionEndIndex = this.testo_sms.text.length;
                        this.testo_sms.selectionBeginIndex = _loc_7;
                        this.rubrica_component.close();
                        this.testo_sms.setFocus();
                    }
                    else if (this.rubrica_component.isOpen && this.rubrica_component.rubricaUser.isEmpty == false)
                    {
                        trace("reportKeyDown: Rubrica isOpen AND NOT isEmpty");
                        _loc_2 = this.f_numero.text;
                        _loc_3 = RubricaUser.isPhoneNumber(this.f_numero.text.toLowerCase());
                        if (_loc_3)
                        {
                            _loc_2 = RubricaElement.formatPhoneNumberNoSpace(_loc_2);
                            if (_loc_2.length > 3)
                            {
                                _loc_2 = RubricaElement.insertSpace(_loc_2);
                            }
                            trace("reportKeyDown, formatPhoneNumber:\'" + _loc_2 + "\'");
                            _loc_4 = new RubricaElement("", _loc_2);
                            if (this.rubrica_component.rubricaUser.isInList(_loc_2) > -1)
                            {
                                trace("reportKeyDown, PERFECT MATCH");
                                _loc_5 = new RubricaElementEvent(RubricaElementEvent.SELECT_ELEMENT, "", _loc_4, null, true);
                                this.selectPhoneNumber(_loc_5);
                            }
                            else
                            {
                                _loc_6 = this.rubrica_component.rubricaUser.isNumberPartiallyInList(_loc_2);
                                if (_loc_6 > -1)
                                {
                                    trace("reportKeyDown, PARTIAL MATCH: pos=" + _loc_6 + " di " + this.rubrica_component.rubricaUser.list.length);
                                    _loc_4 = new RubricaElement(this.rubrica_component.rubricaUser.list[_loc_6].name, this.rubrica_component.rubricaUser.list[_loc_6].phoneNumber);
                                    this.selectPhoneNumber(new RubricaElementEvent(RubricaElementEvent.SELECT_ELEMENT, "", _loc_4, null, true));
                                }
                                else
                                {
                                    trace("reportKeyDown, NO MATCH");
                                    this.selectPhoneNumber(new RubricaElementEvent(RubricaElementEvent.SELECT_ELEMENT, "", _loc_4, null, true));
                                }
                            }
                        }
                        else
                        {
                            this.rubrica_component.lista_rubrica.selectFirstElement();
                        }
                    }
                    else if (this.ultimi_numeri_component.isOpen)
                    {
                        trace("reportKeyDown: UltimiNumeri isOpen");
                        this.selectPhoneNumberUltimi(new UltimoNumeroEvent(UltimoNumeroEvent.SELECT_ELEMENT, "", null, true));
                    }
                    else
                    {
                        trace("reportKeyDown: UltimiNumeri NOT isOpen");
                        this.selectPhoneNumberUltimi(new UltimoNumeroEvent(UltimoNumeroEvent.SELECT_ELEMENT, "", null, true));
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

        public function get button_rubrica() : Button
        {
            return this._159365177button_rubrica;
        }// end function

        public function __f_numero_focusIn(event:FocusEvent) : void
        {
            this.resetTextNum();
            return;
        }// end function

        public function get label1() : Label
        {
            return this._1110417475label1;
        }// end function

        private function get _errorText() : String
        {
            return this._1159380522_errorText;
        }// end function

        private function _Sms_AddChild4_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._Sms_Canvas5_c);
            return _loc_1;
        }// end function

        private function get currentChars() : String
        {
            return this._1442688484currentChars;
        }// end function

        private function _Sms_State1_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "captcha";
            _loc_1.overrides = [this._Sms_AddChild1_c(), this._Sms_SetProperty1_i()];
            return _loc_1;
        }// end function

        private function _Sms_TextInput1_i() : TextInput
        {
            var _loc_1:* = new TextInput();
            this.f_captcha = _loc_1;
            _loc_1.y = 47;
            _loc_1.width = 100;
            _loc_1.height = 20;
            _loc_1.styleName = "noEmbeddedFont";
            _loc_1.setStyle("horizontalCenter", "64");
            _loc_1.setStyle("borderStyle", "none");
            _loc_1.setStyle("textAlign", "center");
            _loc_1.setStyle("paddingTop", 3);
            _loc_1.setStyle("fontFamily", "Arial");
            _loc_1.setStyle("fontSize", 11);
            _loc_1.setStyle("color", 3355443);
            _loc_1.setStyle("focusAlpha", 0);
            _loc_1.setStyle("backgroundImage", this._embed_mxml_______img_v1_captcha_text_box_png_174853629);
            _loc_1.addEventListener("enter", this.__f_captcha_enter);
            _loc_1.id = "f_captcha";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _Sms_SetProperty4_i() : SetProperty
        {
            var _loc_1:* = new SetProperty();
            this._Sms_SetProperty4 = _loc_1;
            _loc_1.name = "y";
            _loc_1.value = 101;
            BindingManager.executeBindings(this, "_Sms_SetProperty4", this._Sms_SetProperty4);
            return _loc_1;
        }// end function

        private function set _loading(param1:Loading) : void
        {
            var _loc_2:* = this._1600092163_loading;
            if (_loc_2 !== param1)
            {
                this._1600092163_loading = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_loading", _loc_2, param1));
            }
            return;
        }// end function

        private function _Sms_Text4_i() : Text
        {
            var _loc_1:* = new Text();
            this.text2 = _loc_1;
            _loc_1.text = "Loading...";
            _loc_1.selectable = false;
            _loc_1.width = 103;
            _loc_1.height = 27;
            _loc_1.x = 94;
            _loc_1.y = 55;
            _loc_1.setStyle("fontSize", 12);
            _loc_1.setStyle("fontWeight", "bold");
            _loc_1.setStyle("color", 16777215);
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.id = "text2";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function get _loading() : Loading
        {
            return this._1600092163_loading;
        }// end function

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
        {
            Sms._watcherSetupUtil = param1;
            return;
        }// end function

    }
}
