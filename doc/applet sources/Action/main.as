package 
{
    import air.update.*;
    import air.update.events.*;
    import flash.desktop.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import it.vodafone.*;
    import it.vodafone.rubrica.*;
    import it.vodafone.tooltip.*;
    import it.vodafone.ultimiNumeri.*;
    import main.*;
    import mx.binding.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.effects.*;
    import mx.events.*;
    import mx.skins.*;
    import mx.states.*;
    import mx.styles.*;
    import ws.tink.flex.pv3dEffects.*;

    public class main extends WindowedApplication implements IBindingClient
    {
        private var _embed_css____rubrica_aggiungi_ultimo_rubrica_png_1652301806:Class;
        private var loginServer:SharedLoginServer;
        private var _embed__font_defFont_medium_italic_2028228629:Class;
        private var _embed__font_defFont_medium_normal_759203218:Class;
        private var _embed_css____rubrica_tastino_rubrica_over_png_454975747:Class;
        private var _embed_css_new_gray_png_2044589479:Class;
        private var _embed_css____v1_6_options_zero_png_1246442480:Class;
        private var _1135485221globalCanvas:Canvas;
        private var _1091436750fadeOut:Fade;
        private var _embed_css_______img_rubrica_tastino_ultimi_over_png_2008771874:Class;
        private var _1741315137wcanvOptions:Canvas;
        private var _91898745rss_title_3_sl:Boolean = true;
        private var _1641862820_rememberMe:Boolean = false;
        var _bindingsByDestination:Object;
        private var _embed_css_new_red_png_732240187:Class;
        private var _embed_mxml_img_v1_prosegui_over_png_1077431317:Class;
        private var _1683524142_hidePass:Boolean = false;
        private var _1025775738rss_1_enabled:CheckBox;
        private var _1560317351wcanvas_console:Canvas;
        private var _190846612_autostart:Boolean;
        public var _main_Button4:Button;
        private var _embed_mxml_img_v1_option_ok_over_png_316945757:Class;
        private var loginClient:SharedLoginClient;
        private var _91868997rss_title_2_tx:String;
        private var _607862791b_logout:Image;
        private var _466098402rss_title_2:Label;
        private var _embed_css_arrow_up_png_1142671346:Class;
        public var _main_Fade3:Fade;
        public var _main_Fade4:Fade;
        public var _main_Fade5:Fade;
        public var _main_Fade6:Fade;
        private var _578057586bottone_termini:Button;
        private var _345717368rss_3_enabled:CheckBox;
        private var _243068592rss_title_1_visible:Boolean = false;
        public const SKIN_TYPE:String = "vodafone_skin";
        private var _1913677749t_logout:Label;
        private var _1398377218b_help:Image;
        private var _embed_css____rubrica_matita_red_png_507272915:Class;
        public var _main_Flip3:Flip;
        public var _main_Flip4:Flip;
        public var _main_Flip5:Flip;
        public var _main_Flip6:Flip;
        private var _1557004716f_password:TextInput;
        private var iconaNewBlinkTimer:Timer;
        private var _1255263375f_username:TextInput;
        private var _1205641071infoConto:Infoconto;
        private var _embed_css_dim1_png_1026764538:Class;
        private var _2050523055rss_title_2_visible:Boolean = false;
        private var _107002ldr:Loading;
        private var _1588188905c_remember:CheckBox;
        private var _embed_css_______img_rubrica_tastino_rubrica_over_png_2105458430:Class;
        private var _embed_mxml_img_v1_login_over_png_245792827:Class;
        private var lastBannerClick:BannerClick;
        private var _1010307135check_termini:CheckBox;
        public var _main_Label13:Label;
        private var _1381897832msisdnList:Array;
        private var _1374471120optionsOut:Flip;
        private var _embed_css_scrolltrack_png_1509241237:Class;
        private var _embed__font_defFont_bold_normal_606214327:Class;
        private var _91928579rss_title_4_tx:String;
        private var _embed_css_options_png_1474387353:Class;
        private var _1461737095rss_2_enabled:CheckBox;
        private var _embed_css____rubrica_spunta_ok_gray_png_1104226581:Class;
        private var _1714148973displayName:String = "";
        private var _embed_mxml_img_v1_option_ok_png_840615663:Class;
        public var _main_AddChild1:AddChild;
        public var _main_AddChild2:AddChild;
        public var _main_AddChild3:AddChild;
        public var _main_AddChild4:AddChild;
        private var _796454899t_version:Label;
        private var _1758954514loginSlave:Boolean = false;
        public const ZEROLIMITS_SKIN:String = "zerolimits_skin";
        private var _embed_mxml_img_v1_freccina_login_png_570740061:Class;
        private var _396033716b_login:Button;
        private var pageRequested:String;
        private var _71871425b_options:Button;
        private var _embed_css_close_png_456345135:Class;
        private var _2084539083skinCanvas:Skin;
        private var iconaNewBlinkWhite:Boolean = true;
        var _bindingsBeginWithWord:Object;
        private var _1687781461selectedMsisdn:String = null;
        private var bannerRetryTimer:Timer;
        private var _embed_css____rubrica_spunta_ok_red_png_1127504823:Class;
        private var _358164447buttonGlow:Glow;
        private var _embed_css_window_png_1571993685:Class;
        private var _embed_css_arrow_down_png_1542550259:Class;
        private var _466098400rss_title_4:Label;
        private var _466098403rss_title_1:Label;
        private var _1590523544windowCanvas:Canvas;
        private var _1282133823fadeIn:Fade;
        public const VODAFONE_SKIN:String = "vodafone_skin";
        private var _embed_css____rubrica_matita_gray_png_1796589621:Class;
        private var _114009sms:Sms;
        private var _1370464685rss_title_4_visible:Boolean = false;
        private var _1299247999zoomOutWidow:Zoom;
        private var _91868954rss_title_2_sl:Boolean = true;
        private var _1307503610_password:String = "Inserisci la tua password";
        private var _91839163rss_title_1_sl:Boolean = true;
        private var _338968969consoleOut:Flip;
        private var _embed_css_login_png_1222187874:Class;
        private var _863918239tt_new:Canvas;
        private var _91898788rss_title_3_tx:String;
        private var _436989778rss_title_3_visible:Boolean = false;
        private var _93444163b_new:Button;
        private var _175195595_username:String = "Inserisci il tuo username";
        private var _1689282334optionAutostart:CheckBox;
        private var _embed_css____v1_6_close_zero_png_636215014:Class;
        private var dockImage:BitmapData;
        private var _1422453572testata:Testata;
        private var _91928536rss_title_4_sl:Boolean = true;
        private var _702682069saldoPunti:SaldoPunti;
        private var _embed_css____rubrica_tastino_ultimi_over_png_964028153:Class;
        private var _592730680wcanvasTerms:Canvas;
        private var _338645904showZoom:Zoom;
        private var conn:LocalConnection;
        private var _1166016655wcanvas:Canvas;
        private var _1484112759appVersion:String = "";
        private var _1496811007rssArea:Rss;
        private var _466098401rss_title_3:Label;
        private var _2141795465rss_4_enabled:CheckBox;
        private var _embed_css_new_white_png_730022019:Class;
        private var appUpdater:ApplicationUpdaterUI;
        private var _embed_css_thumb_png_1954105055:Class;
        private var _embed_css____rubrica_tastino_ultimi_png_1445431594:Class;
        public var _main_Sequence1:Sequence;
        public var _main_Sequence2:Sequence;
        var _watchers:Array;
        private var _embed_css____rubrica_tastino_rubrica_png_1712337664:Class;
        private var _883052500t_help:Label;
        private var _1556188706optionRemember:CheckBox;
        private var _embed_css_campo_png_306194249:Class;
        private var _embed_css____rubrica_aggiungi_ultimo_rubrica_over_png_301954929:Class;
        private var _embed_mxml_img_v1_login_png_750310895:Class;
        private var _embed_mxml_img_v1_linea_fondo_png_902459519:Class;
        private var _embed_mxml_img_v1_prosegui_png_1090252319:Class;
        var _bindings:Array;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var _embed__font_defFont_bold_italic_162026115:Class;
        private var _91839206rss_title_1_tx:String;
        static var _main_StylesInit_done:Boolean = false;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public function main()
        {
            this._documentDescriptor_ = new UIComponentDescriptor({type:WindowedApplication, propertiesFactory:function () : Object
            {
                return {width:268, height:378, childDescriptors:[new UIComponentDescriptor({type:Canvas, id:"globalCanvas", propertiesFactory:function () : Object
                {
                    return {percentWidth:100, percentHeight:100, x:0, y:0, verticalScrollPolicy:"off", horizontalScrollPolicy:"off", childDescriptors:[new UIComponentDescriptor({type:Canvas, id:"windowCanvas", propertiesFactory:function () : Object
                    {
                        return {childDescriptors:[new UIComponentDescriptor({type:Skin, id:"skinCanvas"})]};
                    }// end function
                    })]};
                }// end function
                })]};
            }// end function
            });
            this._1381897832msisdnList = new Array();
            this.appUpdater = new ApplicationUpdaterUI();
            this.loginServer = new SharedLoginServer();
            this.loginClient = new SharedLoginClient();
            this.bannerRetryTimer = new Timer(2000, 30);
            this._embed__font_defFont_bold_italic_162026115 = main__embed__font_defFont_bold_italic_162026115;
            this._embed__font_defFont_bold_normal_606214327 = main__embed__font_defFont_bold_normal_606214327;
            this._embed__font_defFont_medium_italic_2028228629 = main__embed__font_defFont_medium_italic_2028228629;
            this._embed__font_defFont_medium_normal_759203218 = main__embed__font_defFont_medium_normal_759203218;
            this._embed_css_______img_rubrica_tastino_rubrica_over_png_2105458430 = main__embed_css_______img_rubrica_tastino_rubrica_over_png_2105458430;
            this._embed_css_______img_rubrica_tastino_ultimi_over_png_2008771874 = main__embed_css_______img_rubrica_tastino_ultimi_over_png_2008771874;
            this._embed_css____rubrica_aggiungi_ultimo_rubrica_over_png_301954929 = main__embed_css____rubrica_aggiungi_ultimo_rubrica_over_png_301954929;
            this._embed_css____rubrica_aggiungi_ultimo_rubrica_png_1652301806 = main__embed_css____rubrica_aggiungi_ultimo_rubrica_png_1652301806;
            this._embed_css____rubrica_matita_gray_png_1796589621 = main__embed_css____rubrica_matita_gray_png_1796589621;
            this._embed_css____rubrica_matita_red_png_507272915 = main__embed_css____rubrica_matita_red_png_507272915;
            this._embed_css____rubrica_spunta_ok_gray_png_1104226581 = main__embed_css____rubrica_spunta_ok_gray_png_1104226581;
            this._embed_css____rubrica_spunta_ok_red_png_1127504823 = main__embed_css____rubrica_spunta_ok_red_png_1127504823;
            this._embed_css____rubrica_tastino_rubrica_over_png_454975747 = main__embed_css____rubrica_tastino_rubrica_over_png_454975747;
            this._embed_css____rubrica_tastino_rubrica_png_1712337664 = main__embed_css____rubrica_tastino_rubrica_png_1712337664;
            this._embed_css____rubrica_tastino_ultimi_over_png_964028153 = main__embed_css____rubrica_tastino_ultimi_over_png_964028153;
            this._embed_css____rubrica_tastino_ultimi_png_1445431594 = main__embed_css____rubrica_tastino_ultimi_png_1445431594;
            this._embed_css____v1_6_close_zero_png_636215014 = main__embed_css____v1_6_close_zero_png_636215014;
            this._embed_css____v1_6_options_zero_png_1246442480 = main__embed_css____v1_6_options_zero_png_1246442480;
            this._embed_css_arrow_down_png_1542550259 = main__embed_css_arrow_down_png_1542550259;
            this._embed_css_arrow_up_png_1142671346 = main__embed_css_arrow_up_png_1142671346;
            this._embed_css_campo_png_306194249 = main__embed_css_campo_png_306194249;
            this._embed_css_close_png_456345135 = main__embed_css_close_png_456345135;
            this._embed_css_dim1_png_1026764538 = main__embed_css_dim1_png_1026764538;
            this._embed_css_login_png_1222187874 = main__embed_css_login_png_1222187874;
            this._embed_css_new_gray_png_2044589479 = main__embed_css_new_gray_png_2044589479;
            this._embed_css_new_red_png_732240187 = main__embed_css_new_red_png_732240187;
            this._embed_css_new_white_png_730022019 = main__embed_css_new_white_png_730022019;
            this._embed_css_options_png_1474387353 = main__embed_css_options_png_1474387353;
            this._embed_css_scrolltrack_png_1509241237 = main__embed_css_scrolltrack_png_1509241237;
            this._embed_css_thumb_png_1954105055 = main__embed_css_thumb_png_1954105055;
            this._embed_css_window_png_1571993685 = main__embed_css_window_png_1571993685;
            this._embed_mxml_img_v1_freccina_login_png_570740061 = main__embed_mxml_img_v1_freccina_login_png_570740061;
            this._embed_mxml_img_v1_linea_fondo_png_902459519 = main__embed_mxml_img_v1_linea_fondo_png_902459519;
            this._embed_mxml_img_v1_login_over_png_245792827 = main__embed_mxml_img_v1_login_over_png_245792827;
            this._embed_mxml_img_v1_login_png_750310895 = main__embed_mxml_img_v1_login_png_750310895;
            this._embed_mxml_img_v1_option_ok_over_png_316945757 = main__embed_mxml_img_v1_option_ok_over_png_316945757;
            this._embed_mxml_img_v1_option_ok_png_840615663 = main__embed_mxml_img_v1_option_ok_png_840615663;
            this._embed_mxml_img_v1_prosegui_over_png_1077431317 = main__embed_mxml_img_v1_prosegui_over_png_1077431317;
            this._embed_mxml_img_v1_prosegui_png_1090252319 = main__embed_mxml_img_v1_prosegui_png_1090252319;
            this._bindings = [];
            this._watchers = [];
            this._bindingsByDestination = {};
            this._bindingsBeginWithWord = {};
            mx_internal::_document = this;
            .mx_internal::_main_StylesInit();
            this.layout = "absolute";
            this.width = 268;
            this.height = 378;
            this.currentState = "Startup";
            this.states = [this._main_State1_c(), this._main_State2_c(), this._main_State3_c(), this._main_State4_c(), this._main_State5_c()];
            this.transitions = [this._main_Transition1_c(), this._main_Transition2_c(), this._main_Transition3_c(), this._main_Transition4_c(), this._main_Transition5_c(), this._main_Transition6_c(), this._main_Transition7_c()];
            this._main_Glow1_i();
            this._main_Flip1_i();
            this._main_Fade2_i();
            this._main_Fade1_i();
            this._main_Flip2_i();
            this._main_Zoom1_i();
            this.addEventListener("creationComplete", this.___main_WindowedApplication1_creationComplete);
            return;
        }// end function

        private function performCleanup(event:Event = null) : void
        {
            currentState = "Startup";
            if (ServerBridge.getServerBridgeInstance().isLogged)
            {
                trace("Main - Waiting for logout");
                ServerBridge.getServerBridgeInstance().addEventListener(ServerBridge.LOGGED_OUT, this.performCleanup);
            }
            else
            {
                trace("Main - application terminating by USER req");
                this.applicationExit();
                NativeApplication.nativeApplication.exit();
            }
            return;
        }// end function

        private function _main_Text4_c() : Text
        {
            var _loc_1:* = new Text();
            _loc_1.x = 57;
            _loc_1.y = 108;
            _loc_1.text = "www.vodafone.it";
            _loc_1.selectable = false;
            _loc_1.width = 103;
            _loc_1.height = 27;
            _loc_1.setStyle("fontSize", 12);
            _loc_1.setStyle("fontWeight", "bold");
            _loc_1.setStyle("color", 16711680);
            _loc_1.setStyle("fontFamily", "defFont");
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function set rssArea(param1:Rss) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1496811007rssArea;
            if (_loc_2 !== param1)
            {
                this._1496811007rssArea = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rssArea", _loc_2, param1));
            }
            return;
        }// end function

        public function get b_logout() : Image
        {
            return this._607862791b_logout;
        }// end function

        private function get rss_title_4_tx() : String
        {
            return this._91928579rss_title_4_tx;
        }// end function

        public function ___main_State5_enterState(event:FlexEvent) : void
        {
            this.setBaseSkin();
            return;
        }// end function

        public function ___main_Label2_click(event:MouseEvent) : void
        {
            this.goSite("password");
            return;
        }// end function

        public function get t_version() : Label
        {
            return this._796454899t_version;
        }// end function

        public function set b_logout(param1:Image) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._607862791b_logout;
            if (_loc_2 !== param1)
            {
                this._607862791b_logout = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "b_logout", _loc_2, param1));
            }
            return;
        }// end function

        public function __f_password_change(event:Event) : void
        {
            this.switchPasswordField();
            return;
        }// end function

        private function loginError(event:Event) : void
        {
            trace("Main - Login error");
            dispatchEvent(new DisplayErrorEvent("Verifica che username e password siano stati inseriti correttamente."));
            return;
        }// end function

        private function _main_Zoom2_i() : Zoom
        {
            var _loc_1:* = new Zoom();
            this.showZoom = _loc_1;
            _loc_1.alphaFrom = 0;
            _loc_1.alphaTo = 1;
            _loc_1.scaleFrom = 0;
            _loc_1.scaleTo = 1;
            _loc_1.rotationXFrom = 90;
            _loc_1.rotationXTo = 0;
            _loc_1.duration = 700;
            _loc_1.transparent = true;
            BindingManager.executeBindings(this, "showZoom", this.showZoom);
            return _loc_1;
        }// end function

        private function _main_Fade5_i() : Fade
        {
            var _loc_1:* = new Fade();
            this._main_Fade5 = _loc_1;
            _loc_1.duration = 500;
            _loc_1.alphaFrom = 1;
            _loc_1.alphaTo = 0;
            BindingManager.executeBindings(this, "_main_Fade5", this._main_Fade5);
            return _loc_1;
        }// end function

        public function set t_version(param1:Label) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._796454899t_version;
            if (_loc_2 !== param1)
            {
                this._796454899t_version = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "t_version", _loc_2, param1));
            }
            return;
        }// end function

        private function _main_Transition4_c() : Transition
        {
            var _loc_1:* = new Transition();
            _loc_1.fromState = "Options";
            _loc_1.toState = "Login";
            _loc_1.effect = this._main_Flip3_i();
            return _loc_1;
        }// end function

        public function get t_help() : Label
        {
            return this._883052500t_help;
        }// end function

        private function cleanField(param1:String) : void
        {
            if (param1 == "username" && this.f_username.text == "Inserisci il tuo username")
            {
                this.f_username.text = "";
            }
            else if (param1 == "password" && this.f_password.text == "Inserisci la tua password")
            {
                this.f_password.text = "";
            }
            return;
        }// end function

        private function _main_Text3_c() : Text
        {
            var _loc_1:* = new Text();
            _loc_1.x = 42;
            _loc_1.y = 93;
            _loc_1.text = "Inserisci username e password di ";
            _loc_1.selectable = false;
            _loc_1.width = 185;
            _loc_1.height = 43;
            _loc_1.setStyle("fontSize", 12);
            _loc_1.setStyle("fontWeight", "bold");
            _loc_1.setStyle("color", 734012);
            _loc_1.setStyle("fontFamily", "defFont");
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function set optionRemember(param1:CheckBox) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1556188706optionRemember;
            if (_loc_2 !== param1)
            {
                this._1556188706optionRemember = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "optionRemember", _loc_2, param1));
            }
            return;
        }// end function

        public function get wcanvOptions() : Canvas
        {
            return this._1741315137wcanvOptions;
        }// end function

        private function switchPasswordField() : void
        {
            if (this.f_password.text == "Inserisci la tua password")
            {
                this.f_password.displayAsPassword = false;
            }
            else
            {
                this.f_password.displayAsPassword = true;
            }
            return;
        }// end function

        private function _main_Flip6_i() : Flip
        {
            var _loc_1:* = new Flip();
            this._main_Flip6 = _loc_1;
            _loc_1.hideMethod = "alpha";
            _loc_1.constrain = true;
            _loc_1.type = "show";
            _loc_1.direction = "right";
            _loc_1.transparent = true;
            _loc_1.duration = 500;
            _loc_1.addEventListener("effectEnd", this.___main_Flip6_effectEnd);
            BindingManager.executeBindings(this, "_main_Flip6", this._main_Flip6);
            return _loc_1;
        }// end function

        public function __f_username_focusIn(event:FocusEvent) : void
        {
            this.cleanField("username");
            return;
        }// end function

        private function goSite(param1:String) : void
        {
            if (param1 == "register")
            {
                navigateToURL(new URLRequest(RemotePreferences.getInstance().getValue("user_register_url")));
            }
            else if (param1 == "password")
            {
                navigateToURL(new URLRequest(RemotePreferences.getInstance().getValue("user_password_url")));
            }
            else if (param1 == "help")
            {
                navigateToURL(new URLRequest(RemotePreferences.getInstance().getValue("help_url")));
            }
            return;
        }// end function

        private function get rss_title_2_visible() : Boolean
        {
            return this._2050523055rss_title_2_visible;
        }// end function

        private function noSimError(event:Event) : void
        {
            trace("Main - No sim");
            dispatchEvent(new DisplayErrorEvent("E\' necessario associare un numero Vodafone al profilo di registrazione."));
            return;
        }// end function

        private function _main_Infoconto1_i() : Infoconto
        {
            var _loc_1:* = new Infoconto();
            this.infoConto = _loc_1;
            _loc_1.y = 94;
            _loc_1.x = 13;
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.id = "infoConto";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _main_Label9_i() : Label
        {
            var _loc_1:* = new Label();
            this.rss_title_1 = _loc_1;
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 10);
            _loc_1.setStyle("color", 0);
            _loc_1.setStyle("left", "37");
            _loc_1.setStyle("top", "169");
            _loc_1.id = "rss_title_1";
            BindingManager.executeBindings(this, "rss_title_1", this.rss_title_1);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _main_CheckBox8_i() : CheckBox
        {
            var _loc_1:* = new CheckBox();
            this.check_termini = _loc_1;
            _loc_1.x = 20;
            _loc_1.y = 277;
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 10);
            _loc_1.setStyle("fillAlphas", [1, 1]);
            _loc_1.setStyle("fillColors", [16777215, 16185078]);
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.addEventListener("click", this.__check_termini_click);
            _loc_1.id = "check_termini";
            BindingManager.executeBindings(this, "check_termini", this.check_termini);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function set rss_title_4_tx(param1:String) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._91928579rss_title_4_tx;
            if (_loc_2 !== param1)
            {
                this._91928579rss_title_4_tx = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rss_title_4_tx", _loc_2, param1));
            }
            return;
        }// end function

        public function get selectedMsisdn() : String
        {
            return this._1687781461selectedMsisdn;
        }// end function

        public function set t_help(param1:Label) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._883052500t_help;
            if (_loc_2 !== param1)
            {
                this._883052500t_help = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "t_help", _loc_2, param1));
            }
            return;
        }// end function

        private function _main_Zoom1_i() : Zoom
        {
            var _loc_1:* = new Zoom();
            this.zoomOutWidow = _loc_1;
            _loc_1.alphaFrom = 1;
            _loc_1.alphaTo = 0;
            _loc_1.scaleFrom = 1;
            _loc_1.scaleTo = 0;
            _loc_1.rotationXFrom = 0;
            _loc_1.rotationXTo = 90;
            _loc_1.duration = 700;
            _loc_1.transparent = true;
            _loc_1.addEventListener("effectEnd", this.__zoomOutWidow_effectEnd);
            BindingManager.executeBindings(this, "zoomOutWidow", this.zoomOutWidow);
            return _loc_1;
        }// end function

        private function _main_Glow1_i() : Glow
        {
            var _loc_1:* = new Glow();
            this.buttonGlow = _loc_1;
            _loc_1.color = 16711680;
            _loc_1.alphaFrom = 1;
            _loc_1.alphaTo = 0;
            _loc_1.duration = 1500;
            return _loc_1;
        }// end function

        public function __t_logout_click(event:MouseEvent) : void
        {
            this.logout();
            return;
        }// end function

        public function get b_new() : Button
        {
            return this._93444163b_new;
        }// end function

        private function set _username(param1:String) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._175195595_username;
            if (_loc_2 !== param1)
            {
                this._175195595_username = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_username", _loc_2, param1));
            }
            return;
        }// end function

        private function _main_Fade4_i() : Fade
        {
            var _loc_1:* = new Fade();
            this._main_Fade4 = _loc_1;
            _loc_1.duration = 500;
            _loc_1.alphaFrom = 0;
            _loc_1.alphaTo = 1;
            BindingManager.executeBindings(this, "_main_Fade4", this._main_Fade4);
            return _loc_1;
        }// end function

        private function _main_Label17_c() : Label
        {
            var _loc_1:* = new Label();
            _loc_1.text = "Accetto i termini e le condizioni";
            _loc_1.y = 279;
            _loc_1.x = 36;
            _loc_1.setStyle("fontWeight", "normal");
            _loc_1.setStyle("color", 3355443);
            _loc_1.setStyle("fontFamily", "defFont");
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _main_Transition3_c() : Transition
        {
            var _loc_1:* = new Transition();
            _loc_1.fromState = "Terms";
            _loc_1.toState = "Login";
            _loc_1.effect = this._main_Sequence2_i();
            return _loc_1;
        }// end function

        public function get showZoom() : Zoom
        {
            return this._338645904showZoom;
        }// end function

        private function networkError(event:Event) : void
        {
            trace("Main - Server error");
            dispatchEvent(new DisplayErrorEvent("Connessione non disponibile."));
            return;
        }// end function

        private function serverError(event:Event = null) : void
        {
            trace("Main - Server error");
            dispatchEvent(new DisplayErrorEvent("Il servizio non è al momento disponibile."));
            return;
        }// end function

        public function set b_new(param1:Button) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._93444163b_new;
            if (_loc_2 !== param1)
            {
                this._93444163b_new = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "b_new", _loc_2, param1));
            }
            return;
        }// end function

        private function performLogin() : void
        {
            var blocchiversioni:XML;
            var vv:XMLList;
            var i:int;
            this.loginClient.stopSearching();
            if (RemotePreferences.getInstance().getValue("active") == "0")
            {
                dispatchEvent(new DisplayErrorEvent("Il servizio non è al momento disponibile."));
                return;
            }
            try
            {
                blocchiversioni = XML(RemotePreferences.getInstance().getValue("versionblock"));
                trace("blocchiversioni: " + blocchiversioni);
                vv = blocchiversioni.child("version");
                i;
                while (i < vv.length())
                {
                    
                    if (vv[i].toString() == this.appVersion)
                    {
                        dispatchEvent(new DisplayErrorEvent("E’ necessario aggiornare l’applicazione. Chiudi e riavvia.", DisplayErrorEvent.CLOSE_EVENT));
                        return;
                    }
                    i = i++;
                }
            }
            catch (e:Event)
            {
                trace("Main - Errore in versionblock");
            }
            if (this.f_username.text.length == 0 || this.f_username.text == "Inserisci il tuo username")
            {
                dispatchEvent(new DisplayErrorEvent("Inserisci Username"));
                return;
            }
            if (this.f_password.text.length == 0 || this.f_password.text == "Inserisci la tua password")
            {
                dispatchEvent(new DisplayErrorEvent("Inserisci Password"));
                return;
            }
            this._rememberMe = this.c_remember.selected;
            this._username = this.f_username.text;
            this._password = this.f_password.text;
            this.showLoading();
            this.loginCheckPreferences();
            return;
        }// end function

        private function _main_Text2_c() : Text
        {
            var _loc_1:* = new Text();
            _loc_1.x = 43;
            _loc_1.y = 190;
            _loc_1.text = "Password";
            _loc_1.selectable = false;
            _loc_1.setStyle("color", 16711680);
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 11);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _main_Flip5_i() : Flip
        {
            var _loc_1:* = new Flip();
            this._main_Flip5 = _loc_1;
            _loc_1.hideMethod = "alpha";
            _loc_1.constrain = true;
            _loc_1.type = "show";
            _loc_1.direction = "left";
            _loc_1.transparent = true;
            _loc_1.duration = 500;
            _loc_1.addEventListener("effectEnd", this.___main_Flip5_effectEnd);
            BindingManager.executeBindings(this, "_main_Flip5", this._main_Flip5);
            return _loc_1;
        }// end function

        private function _main_Label8_c() : Label
        {
            var _loc_1:* = new Label();
            _loc_1.text = "Abilita avvio automatico";
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 10);
            _loc_1.setStyle("color", 0);
            _loc_1.setStyle("left", "33");
            _loc_1.setStyle("top", "93");
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function get rss_4_enabled() : CheckBox
        {
            return this._2141795465rss_4_enabled;
        }// end function

        public function set wcanvOptions(param1:Canvas) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1741315137wcanvOptions;
            if (_loc_2 !== param1)
            {
                this._1741315137wcanvOptions = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "wcanvOptions", _loc_2, param1));
            }
            return;
        }// end function

        public function set wcanvasTerms(param1:Canvas) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._592730680wcanvasTerms;
            if (_loc_2 !== param1)
            {
                this._592730680wcanvasTerms = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "wcanvasTerms", _loc_2, param1));
            }
            return;
        }// end function

        public function get f_username() : TextInput
        {
            return this._1255263375f_username;
        }// end function

        private function _main_CheckBox7_i() : CheckBox
        {
            var _loc_1:* = new CheckBox();
            this.rss_4_enabled = _loc_1;
            _loc_1.setStyle("left", "10");
            _loc_1.setStyle("top", "232");
            _loc_1.setStyle("fillAlphas", [1, 1, 1, 1]);
            _loc_1.setStyle("fillColors", [16777215, 16185078]);
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.id = "rss_4_enabled";
            BindingManager.executeBindings(this, "rss_4_enabled", this.rss_4_enabled);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _main_Transition2_c() : Transition
        {
            var _loc_1:* = new Transition();
            _loc_1.fromState = "Login";
            _loc_1.toState = "Console";
            _loc_1.effect = this._main_Sequence1_i();
            return _loc_1;
        }// end function

        public function __bottone_termini_click(event:MouseEvent) : void
        {
            this.goLoginPane();
            return;
        }// end function

        public function get wcanvas() : Canvas
        {
            return this._1166016655wcanvas;
        }// end function

        private function _main_Fade3_i() : Fade
        {
            var _loc_1:* = new Fade();
            this._main_Fade3 = _loc_1;
            _loc_1.duration = 500;
            _loc_1.alphaFrom = 1;
            _loc_1.alphaTo = 0;
            BindingManager.executeBindings(this, "_main_Fade3", this._main_Fade3);
            return _loc_1;
        }// end function

        private function set rss_title_2_visible(param1:Boolean) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._2050523055rss_title_2_visible;
            if (_loc_2 !== param1)
            {
                this._2050523055rss_title_2_visible = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rss_title_2_visible", _loc_2, param1));
            }
            return;
        }// end function

        private function switchMsisdnOk(event:Event) : void
        {
            ServerBridge.getServerBridgeInstance().removeEventListener(ServerBridge.USER_DATA_LOADED, this.switchMsisdnOk);
            ServerBridge.getServerBridgeInstance().precheckSMS();
            this.hideLoading();
            return;
        }// end function

        private function set rss_title_4_visible(param1:Boolean) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1370464685rss_title_4_visible;
            if (_loc_2 !== param1)
            {
                this._1370464685rss_title_4_visible = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rss_title_4_visible", _loc_2, param1));
            }
            return;
        }// end function

        public function __sms_sms_sending(event:Event) : void
        {
            this.showLoading();
            return;
        }// end function

        public function set f_password(param1:TextInput) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1557004716f_password;
            if (_loc_2 !== param1)
            {
                this._1557004716f_password = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "f_password", _loc_2, param1));
            }
            return;
        }// end function

        public function __zoomOutWidow_effectEnd(event:EffectEvent) : void
        {
            this.performCleanup();
            return;
        }// end function

        private function _main_Label16_c() : Label
        {
            var _loc_1:* = new Label();
            _loc_1.x = 16;
            _loc_1.y = 64;
            _loc_1.text = "Condizioni Contrattuali";
            _loc_1.setStyle("fontWeight", "bold");
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 11);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _main_Text1_c() : Text
        {
            var _loc_1:* = new Text();
            _loc_1.x = 43;
            _loc_1.y = 149;
            _loc_1.text = "Username";
            _loc_1.selectable = false;
            _loc_1.setStyle("color", 16711680);
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 11);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _main_Image8_c() : Image
        {
            var _loc_1:* = new Image();
            _loc_1.scaleContent = false;
            _loc_1.autoLoad = true;
            _loc_1.source = this._embed_mxml_img_v1_linea_fondo_png_902459519;
            _loc_1.useHandCursor = true;
            _loc_1.buttonMode = true;
            _loc_1.x = 3;
            _loc_1.y = 321;
            _loc_1.visible = false;
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _main_Flip4_i() : Flip
        {
            var _loc_1:* = new Flip();
            this._main_Flip4 = _loc_1;
            _loc_1.hideMethod = "alpha";
            _loc_1.constrain = true;
            _loc_1.type = "show";
            _loc_1.direction = "right";
            _loc_1.transparent = true;
            _loc_1.duration = 500;
            _loc_1.addEventListener("effectEnd", this.___main_Flip4_effectEnd);
            BindingManager.executeBindings(this, "_main_Flip4", this._main_Flip4);
            return _loc_1;
        }// end function

        public function set selectedMsisdn(param1:String) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1687781461selectedMsisdn;
            if (_loc_2 !== param1)
            {
                this._1687781461selectedMsisdn = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "selectedMsisdn", _loc_2, param1));
            }
            return;
        }// end function

        private function _main_Label7_c() : Label
        {
            var _loc_1:* = new Label();
            _loc_1.text = "Ricordami su questo computer";
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 10);
            _loc_1.setStyle("color", 0);
            _loc_1.setStyle("left", "33");
            _loc_1.setStyle("top", "73");
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function clickSuLogoFooter() : void
        {
            if (ServerBridge.getServerBridgeInstance().isLogged)
            {
                dispatchEvent(new BannerClick("http://www.vodafone.it/190/trilogy/jsp/dispatcher.do?ty_key=pri_HP_Teens&tk=HPPrivatit"));
            }
            else
            {
                navigateToURL(new URLRequest("http://www.vodafone.it/190/trilogy/jsp/dispatcher.do?ty_key=pri_HP_Teens&tk=HPPrivati"));
            }
            return;
        }// end function

        private function iconaNewBlink() : void
        {
            if (RemotePreferences.getInstance().getValue("blinkDownloadIconVisible") == "1")
            {
                this.b_new.visible = true;
                if (RemotePreferences.getInstance().getValue("blinkDownloadIconOn") == "on")
                {
                    this.iconaNewBlinkTimer = new Timer(1000);
                    this.iconaNewBlinkTimer.addEventListener("timer", this.iconaNewBlinkHandler);
                    this.iconaNewBlinkTimer.start();
                }
            }
            else
            {
                this.b_new.visible = false;
            }
            return;
        }// end function

        public function get testata() : Testata
        {
            return this._1422453572testata;
        }// end function

        private function _main_CheckBox6_i() : CheckBox
        {
            var _loc_1:* = new CheckBox();
            this.rss_3_enabled = _loc_1;
            _loc_1.setStyle("left", "10");
            _loc_1.setStyle("top", "210");
            _loc_1.setStyle("fillAlphas", [1, 1]);
            _loc_1.setStyle("fillColors", [16777215, 16185078]);
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.id = "rss_3_enabled";
            BindingManager.executeBindings(this, "rss_3_enabled", this.rss_3_enabled);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function processError(event:DisplayErrorEvent) : void
        {
            if (this.ldr == null)
            {
                this.ldr = new Loading();
                this.ldr.alpha = 0;
                this.ldr.y = 58;
                this.ldr.errore(event._messaggio);
                this.globalCanvas.addChild(this.ldr);
                this.ldr.addEventListener(MouseEvent.MOUSE_DOWN, this.startMove);
                this.ldr.addEventListener(MouseEvent.MOUSE_UP, this.savePosition);
                this.fadeIn.target = this.ldr;
                this.fadeIn.play();
            }
            this.ldr.errore(event._messaggio, event._option);
            this.ldr.addEventListener("user_ok", this.clickSuError);
            this.ldr.addEventListener("user_retry", this.clickSuRetry);
            this.ldr.addEventListener("exit_widget", this.exitWidget);
            return;
        }// end function

        public function set displayName(param1:String) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1714148973displayName;
            if (_loc_2 !== param1)
            {
                this._1714148973displayName = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "displayName", _loc_2, param1));
            }
            return;
        }// end function

        private function _main_AddChildAction2_c() : AddChildAction
        {
            var _loc_1:* = new AddChildAction();
            return _loc_1;
        }// end function

        private function logoutComplete(event:Event = null) : void
        {
            trace("main, logoutComplete");
            ServerBridge.getServerBridgeInstance().removeEventListener(ServerBridge.LOGGED_OUT, this.logoutComplete);
            this._username = "Inserisci il tuo username";
            this._password = "Inserisci la tua password";
            if (this.ldr != null)
            {
                this.globalCanvas.removeChild(this.ldr);
            }
            this.ldr = null;
            currentState = "Login";
            LocalPreferences.getInstance().autologin = false;
            this.switchPasswordField();
            this.cancelOptions();
            return;
        }// end function

        public function ___main_Button4_click(event:MouseEvent) : void
        {
            this.saveOptions();
            return;
        }// end function

        public function set showZoom(param1:Zoom) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._338645904showZoom;
            if (_loc_2 !== param1)
            {
                this._338645904showZoom = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showZoom", _loc_2, param1));
            }
            return;
        }// end function

        public function __b_new_initialize(event:FlexEvent) : void
        {
            this.iconaNewBlink();
            return;
        }// end function

        public function set consoleOut(param1:Flip) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._338968969consoleOut;
            if (_loc_2 !== param1)
            {
                this._338968969consoleOut = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "consoleOut", _loc_2, param1));
            }
            return;
        }// end function

        private function setOptionsButtonColorSkin() : void
        {
            switch(this.SKIN_TYPE)
            {
                case this.VODAFONE_SKIN:
                {
                    this.b_options.styleName = "options";
                    break;
                }
                case this.ZEROLIMITS_SKIN:
                {
                    this.b_options.styleName = "optionsZero";
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function __b_login_click(event:MouseEvent) : void
        {
            this.performLogin();
            return;
        }// end function

        private function _main_Parallel2_c() : Parallel
        {
            var _loc_1:* = new Parallel();
            _loc_1.children = [this._main_Fade6_i()];
            return _loc_1;
        }// end function

        private function _main_Fade2_i() : Fade
        {
            var _loc_1:* = new Fade();
            this.fadeIn = _loc_1;
            _loc_1.duration = 400;
            _loc_1.alphaFrom = 0;
            _loc_1.alphaTo = 1;
            return _loc_1;
        }// end function

        private function _main_AddChild4_i() : AddChild
        {
            var _loc_1:* = new AddChild();
            this._main_AddChild4 = _loc_1;
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._main_Canvas5_i);
            BindingManager.executeBindings(this, "_main_AddChild4", this._main_AddChild4);
            return _loc_1;
        }// end function

        private function _main_RemoveChildAction2_c() : RemoveChildAction
        {
            var _loc_1:* = new RemoveChildAction();
            return _loc_1;
        }// end function

        private function exitWidget(event:Event = null) : void
        {
            ServerBridge.getServerBridgeInstance().logout();
            this.zoomOutWidow.play();
            return;
        }// end function

        private function _main_Sequence2_i() : Sequence
        {
            var _loc_1:* = new Sequence();
            this._main_Sequence2 = _loc_1;
            _loc_1.children = [this._main_Fade5_i(), this._main_RemoveChildAction2_c(), this._main_AddChildAction2_c(), this._main_Parallel2_c()];
            BindingManager.executeBindings(this, "_main_Sequence2", this._main_Sequence2);
            return _loc_1;
        }// end function

        public function get b_help() : Image
        {
            return this._1398377218b_help;
        }// end function

        private function _main_Transition1_c() : Transition
        {
            var _loc_1:* = new Transition();
            _loc_1.fromState = "Startup";
            _loc_1.toState = "*";
            _loc_1.effect = this._main_Zoom2_i();
            return _loc_1;
        }// end function

        public function get fadeIn() : Fade
        {
            return this._1282133823fadeIn;
        }// end function

        private function _main_Flip3_i() : Flip
        {
            var _loc_1:* = new Flip();
            this._main_Flip3 = _loc_1;
            _loc_1.hideMethod = "alpha";
            _loc_1.constrain = true;
            _loc_1.type = "show";
            _loc_1.direction = "right";
            _loc_1.transparent = true;
            _loc_1.duration = 500;
            _loc_1.addEventListener("effectEnd", this.___main_Flip3_effectEnd);
            BindingManager.executeBindings(this, "_main_Flip3", this._main_Flip3);
            return _loc_1;
        }// end function

        private function _main_Label15_i() : Label
        {
            var _loc_1:* = new Label();
            this.t_logout = _loc_1;
            _loc_1.text = "Logout";
            _loc_1.useHandCursor = true;
            _loc_1.buttonMode = true;
            _loc_1.mouseChildren = false;
            _loc_1.y = 324;
            _loc_1.x = 177;
            _loc_1.setStyle("fontWeight", "normal");
            _loc_1.setStyle("color", 3355443);
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.addEventListener("click", this.__t_logout_click);
            _loc_1.id = "t_logout";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function ___main_Flip4_effectEnd(event:EffectEvent) : void
        {
            this.wcanvas.alpha = 1;
            return;
        }// end function

        public function __f_password_enter(event:FlexEvent) : void
        {
            this.performLogin();
            return;
        }// end function

        public function init() : void
        {
            var loader:Loader;
            trace("SKIN_TYPE: " + this.SKIN_TYPE);
            NativeApplication.nativeApplication.addEventListener(Event.EXITING, this.applicationExiting);
            var appDescriptor:* = NativeApplication.nativeApplication.applicationDescriptor;
            var ns:* = appDescriptor.namespace();
            this.appVersion = ns::version;
            this.addEventListener(DisplayErrorEvent.ERROR_EVENT, this.processError);
            this.addEventListener(BannerClick.BANNER_CLICK, this.manageBannerClick);
            this.addEventListener(TabIndexManager.ENEBLE_TAB_EVENT, this.enableTab);
            this.addEventListener(TabIndexManager.DISABLE_TAB_EVENT, this.disableTab);
            this.addEventListener(MouseEvent.MOUSE_DOWN, this.childDownOutside);
            RemotePreferences.getInstance();
            if (NativeApplication.supportsSystemTrayIcon)
            {
                loader = new Loader();
                loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.prepareForSystray);
                loader.load(new URLRequest("app:/img/icons/VF_STK_4Col_W_16x16.png"));
            }
            if (LocalPreferences.getInstance().storageGet("xpos") != null)
            {
                this.nativeWindow.x = Number(LocalPreferences.getInstance().storageGet("xpos"));
            }
            if (LocalPreferences.getInstance().storageGet("ypos") != null)
            {
                this.nativeWindow.y = Number(LocalPreferences.getInstance().storageGet("ypos"));
            }
            if (LocalPreferences.getInstance().storageGet("autostart") == null)
            {
                LocalPreferences.getInstance().storageSet("autostart", "1", false);
            }
            try
            {
                if (LocalPreferences.getInstance().storageGet("autostart") == "1" && NativeApplication.nativeApplication.startAtLogin == false)
                {
                    NativeApplication.nativeApplication.startAtLogin = true;
                }
                else if (LocalPreferences.getInstance().storageGet("autostart") != "1" && NativeApplication.nativeApplication.startAtLogin == true)
                {
                    NativeApplication.nativeApplication.startAtLogin = false;
                }
                this._autostart = NativeApplication.nativeApplication.startAtLogin;
            }
            catch (e:Error)
            {
                try
                {
                }
                if (LocalPreferences.getInstance().autologin)
                {
                    this._rememberMe = true;
                    this._hidePass = true;
                    this._username = LocalPreferences.getInstance().username;
                    this._password = LocalPreferences.getInstance().password;
                }
            }
            catch (e:Error)
            {
            }
            this.windowCanvas.addEventListener(MouseEvent.MOUSE_DOWN, this.startMove);
            this.windowCanvas.addEventListener(MouseEvent.MOUSE_UP, this.savePosition);
            if (LocalPreferences.getInstance().storageGet("termsapproved") == null || LocalPreferences.getInstance().storageGet("termsapproved") != "1")
            {
                currentState = "Terms";
            }
            else
            {
                this.goLoginPane();
            }
            return;
        }// end function

        public function __f_password_focusIn(event:FocusEvent) : void
        {
            this.cleanField("password");
            return;
        }// end function

        private function _main_Label6_c() : Label
        {
            var _loc_1:* = new Label();
            _loc_1.text = "Impostazioni";
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 13);
            _loc_1.setStyle("fontWeight", "bold");
            _loc_1.setStyle("color", 3355443);
            _loc_1.setStyle("left", "10");
            _loc_1.setStyle("top", "20");
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _main_CheckBox5_i() : CheckBox
        {
            var _loc_1:* = new CheckBox();
            this.rss_2_enabled = _loc_1;
            _loc_1.setStyle("left", "10");
            _loc_1.setStyle("top", "188");
            _loc_1.setStyle("fillAlphas", [1, 1, 1, 1]);
            _loc_1.setStyle("fillColors", [16777215, 16185078]);
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.id = "rss_2_enabled";
            BindingManager.executeBindings(this, "rss_2_enabled", this.rss_2_enabled);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _main_Fade1_i() : Fade
        {
            var _loc_1:* = new Fade();
            this.fadeOut = _loc_1;
            _loc_1.duration = 400;
            _loc_1.alphaFrom = 1;
            _loc_1.alphaTo = 0;
            return _loc_1;
        }// end function

        private function _main_Image7_i() : Image
        {
            var _loc_1:* = new Image();
            this.b_logout = _loc_1;
            _loc_1.scaleContent = false;
            _loc_1.autoLoad = true;
            _loc_1.source = this._embed_mxml_img_v1_freccina_login_png_570740061;
            _loc_1.useHandCursor = true;
            _loc_1.buttonMode = true;
            _loc_1.x = 174;
            _loc_1.y = 330;
            _loc_1.id = "b_logout";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _main_AddChildAction1_c() : AddChildAction
        {
            var _loc_1:* = new AddChildAction();
            return _loc_1;
        }// end function

        public function set rss_2_enabled(param1:CheckBox) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1461737095rss_2_enabled;
            if (_loc_2 !== param1)
            {
                this._1461737095rss_2_enabled = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rss_2_enabled", _loc_2, param1));
            }
            return;
        }// end function

        private function _main_Parallel1_c() : Parallel
        {
            var _loc_1:* = new Parallel();
            _loc_1.children = [this._main_Fade4_i()];
            return _loc_1;
        }// end function

        public function set rss_4_enabled(param1:CheckBox) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._2141795465rss_4_enabled;
            if (_loc_2 !== param1)
            {
                this._2141795465rss_4_enabled = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rss_4_enabled", _loc_2, param1));
            }
            return;
        }// end function

        public function set f_username(param1:TextInput) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1255263375f_username;
            if (_loc_2 !== param1)
            {
                this._1255263375f_username = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "f_username", _loc_2, param1));
            }
            return;
        }// end function

        private function _main_RemoveChildAction1_c() : RemoveChildAction
        {
            var _loc_1:* = new RemoveChildAction();
            return _loc_1;
        }// end function

        private function set _autostart(param1:Boolean) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._190846612_autostart;
            if (_loc_2 !== param1)
            {
                this._190846612_autostart = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_autostart", _loc_2, param1));
            }
            return;
        }// end function

        private function _main_Sequence1_i() : Sequence
        {
            var _loc_1:* = new Sequence();
            this._main_Sequence1 = _loc_1;
            _loc_1.children = [this._main_Fade3_i(), this._main_RemoveChildAction1_c(), this._main_AddChildAction1_c(), this._main_Parallel1_c()];
            BindingManager.executeBindings(this, "_main_Sequence1", this._main_Sequence1);
            return _loc_1;
        }// end function

        public function get skinCanvas() : Skin
        {
            return this._2084539083skinCanvas;
        }// end function

        function _main_StylesInit() : void
        {
            var style:CSSStyleDeclaration;
            var effects:Array;
            if (mx_internal::_main_StylesInit_done)
            {
                return;
            }
            mx_internal::_main_StylesInit_done = true;
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
            style = StyleManager.getStyleDeclaration("Application");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("Application", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.padding = 0;
                this.marginRight = 0;
                this.backgroundImage = "";
                this.marginLeft = 0;
                this.marginTop = 0;
                this.showFlexChrome = false;
                this.marginBottom = 0;
                this.backgroundColor = "";
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
            style = StyleManager.getStyleDeclaration("Window");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("Window", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.padding = 0;
                this.marginRight = 0;
                this.backgroundImage = "";
                this.marginLeft = 0;
                this.marginTop = 0;
                this.showFlexChrome = false;
                this.marginBottom = 0;
                this.backgroundColor = "";
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
            style = StyleManager.getStyleDeclaration("VScrollBar");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("VScrollBar", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.thumbUpSkin = _embed_css_thumb_png_1954105055;
                this.downArrowUpSkin = _embed_css_arrow_down_png_1542550259;
                this.upArrowDisabledSkin = _embed_css_arrow_up_png_1142671346;
                this.thumbDownSkin = _embed_css_thumb_png_1954105055;
                this.downArrowOverSkin = _embed_css_arrow_down_png_1542550259;
                this.upArrowUpSkin = _embed_css_arrow_up_png_1142671346;
                this.trackSkin = _embed_css_scrolltrack_png_1509241237;
                this.upArrowOverSkin = _embed_css_arrow_up_png_1142671346;
                this.thumbOverSkin = _embed_css_thumb_png_1954105055;
                this.upArrowDownSkin = _embed_css_arrow_up_png_1142671346;
                this.downArrowDownSkin = _embed_css_arrow_down_png_1542550259;
                this.downArrowDisabledSkin = _embed_css_arrow_down_png_1542550259;
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
            style = StyleManager.getStyleDeclaration("WindowedApplication");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("WindowedApplication", style, false);
            }
            if (style.factory == null)
            {
                style.factory = function () : void
            {
                this.padding = 0;
                this.marginRight = 0;
                this.backgroundImage = "";
                this.marginLeft = 0;
                this.marginTop = 0;
                this.showFlexChrome = false;
                this.marginBottom = 0;
                this.backgroundColor = "";
                return;
            }// end function
            ;
            }
            var _loc_2:* = StyleManager;
            _loc_2.mx_internal::initProtoChainRoots();
            return;
        }// end function

        private function _main_Label14_i() : Label
        {
            var _loc_1:* = new Label();
            this.t_help = _loc_1;
            _loc_1.text = "Help";
            _loc_1.useHandCursor = true;
            _loc_1.buttonMode = true;
            _loc_1.mouseChildren = false;
            _loc_1.y = 324;
            _loc_1.x = 43;
            _loc_1.setStyle("fontWeight", "normal");
            _loc_1.setStyle("color", 3355443);
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.addEventListener("click", this.__t_help_click);
            _loc_1.id = "t_help";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _main_AddChild3_i() : AddChild
        {
            var _loc_1:* = new AddChild();
            this._main_AddChild3 = _loc_1;
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._main_Canvas4_i);
            BindingManager.executeBindings(this, "_main_AddChild3", this._main_AddChild3);
            return _loc_1;
        }// end function

        private function _main_Flip2_i() : Flip
        {
            var _loc_1:* = new Flip();
            this.optionsOut = _loc_1;
            _loc_1.constrain = true;
            _loc_1.type = "hide";
            _loc_1.direction = "right";
            _loc_1.transparent = true;
            _loc_1.duration = 500;
            _loc_1.addEventListener("effectEnd", this.__optionsOut_effectEnd);
            BindingManager.executeBindings(this, "optionsOut", this.optionsOut);
            return _loc_1;
        }// end function

        private function _main_Image6_i() : Image
        {
            var _loc_1:* = new Image();
            this.b_help = _loc_1;
            _loc_1.scaleContent = false;
            _loc_1.autoLoad = true;
            _loc_1.source = this._embed_mxml_img_v1_freccina_login_png_570740061;
            _loc_1.useHandCursor = true;
            _loc_1.buttonMode = true;
            _loc_1.x = 40;
            _loc_1.y = 330;
            _loc_1.id = "b_help";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function get rss_title_1_visible() : Boolean
        {
            return this._243068592rss_title_1_visible;
        }// end function

        private function _main_Label5_i() : Label
        {
            var _loc_1:* = new Label();
            this.t_version = _loc_1;
            _loc_1.y = 42;
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 10);
            _loc_1.setStyle("textAlign", "right");
            _loc_1.setStyle("right", "9");
            _loc_1.addEventListener("initialize", this.__t_version_initialize);
            _loc_1.id = "t_version";
            BindingManager.executeBindings(this, "t_version", this.t_version);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _main_CheckBox4_i() : CheckBox
        {
            var _loc_1:* = new CheckBox();
            this.rss_1_enabled = _loc_1;
            _loc_1.setStyle("left", "10");
            _loc_1.setStyle("top", "167");
            _loc_1.setStyle("fillAlphas", [1, 1, 1, 1]);
            _loc_1.setStyle("fillColors", [16777215, 16185078]);
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.id = "rss_1_enabled";
            BindingManager.executeBindings(this, "rss_1_enabled", this.rss_1_enabled);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function set wcanvas(param1:Canvas) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1166016655wcanvas;
            if (_loc_2 !== param1)
            {
                this._1166016655wcanvas = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "wcanvas", _loc_2, param1));
            }
            return;
        }// end function

        public function get sms() : Sms
        {
            return this._114009sms;
        }// end function

        public function ___main_State3_enterState(event:FlexEvent) : void
        {
            this.setBaseSkin();
            return;
        }// end function

        private function setupOptions() : void
        {
            return;
        }// end function

        public function get windowCanvas() : Canvas
        {
            return this._1590523544windowCanvas;
        }// end function

        private function set _rememberMe(param1:Boolean) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1641862820_rememberMe;
            if (_loc_2 !== param1)
            {
                this._1641862820_rememberMe = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_rememberMe", _loc_2, param1));
            }
            return;
        }// end function

        private function _main_Button5_i() : Button
        {
            var _loc_1:* = new Button();
            this.bottone_termini = _loc_1;
            _loc_1.buttonMode = true;
            _loc_1.useHandCursor = true;
            _loc_1.enabled = false;
            _loc_1.setStyle("left", "168");
            _loc_1.setStyle("top", "298");
            _loc_1.setStyle("upSkin", this._embed_mxml_img_v1_prosegui_png_1090252319);
            _loc_1.setStyle("overSkin", this._embed_mxml_img_v1_prosegui_over_png_1077431317);
            _loc_1.setStyle("downSkin", this._embed_mxml_img_v1_prosegui_png_1090252319);
            _loc_1.setStyle("disabledSkin", this._embed_mxml_img_v1_prosegui_png_1090252319);
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.addEventListener("click", this.__bottone_termini_click);
            _loc_1.id = "bottone_termini";
            BindingManager.executeBindings(this, "bottone_termini", this.bottone_termini);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _main_AddChild2_i() : AddChild
        {
            var _loc_1:* = new AddChild();
            this._main_AddChild2 = _loc_1;
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._main_Canvas2_i);
            BindingManager.executeBindings(this, "_main_AddChild2", this._main_AddChild2);
            return _loc_1;
        }// end function

        private function set rss_title_1_sl(param1:Boolean) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._91839163rss_title_1_sl;
            if (_loc_2 !== param1)
            {
                this._91839163rss_title_1_sl = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rss_title_1_sl", _loc_2, param1));
            }
            return;
        }// end function

        public function set testata(param1:Testata) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1422453572testata;
            if (_loc_2 !== param1)
            {
                this._1422453572testata = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "testata", _loc_2, param1));
            }
            return;
        }// end function

        private function _main_Label13_i() : Label
        {
            var _loc_1:* = new Label();
            this._main_Label13 = _loc_1;
            _loc_1.y = 42;
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 10);
            _loc_1.setStyle("color", 3355443);
            _loc_1.setStyle("textAlign", "right");
            _loc_1.setStyle("right", "9");
            _loc_1.id = "_main_Label13";
            BindingManager.executeBindings(this, "_main_Label13", this._main_Label13);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function get bottone_termini() : Button
        {
            return this._578057586bottone_termini;
        }// end function

        private function _main_Flip1_i() : Flip
        {
            var _loc_1:* = new Flip();
            this.consoleOut = _loc_1;
            _loc_1.constrain = true;
            _loc_1.type = "hide";
            _loc_1.direction = "left";
            _loc_1.transparent = true;
            _loc_1.duration = 500;
            _loc_1.addEventListener("effectEnd", this.__consoleOut_effectEnd);
            BindingManager.executeBindings(this, "consoleOut", this.consoleOut);
            return _loc_1;
        }// end function

        public function set fadeIn(param1:Fade) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1282133823fadeIn;
            if (_loc_2 !== param1)
            {
                this._1282133823fadeIn = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fadeIn", _loc_2, param1));
            }
            return;
        }// end function

        private function logout() : void
        {
            trace("logout");
            this.showLoading();
            this.loginSlave = false;
            this.loginServer.stop();
            ServerBridge.getServerBridgeInstance().addEventListener(ServerBridge.LOGGED_OUT, this.logoutComplete);
            ServerBridge.getServerBridgeInstance().logout();
            return;
        }// end function

        private function _main_Label4_c() : Label
        {
            var _loc_1:* = new Label();
            _loc_1.text = "Registrati";
            _loc_1.buttonMode = true;
            _loc_1.useHandCursor = true;
            _loc_1.mouseChildren = false;
            _loc_1.setStyle("textAlign", "left");
            _loc_1.setStyle("fontWeight", "normal");
            _loc_1.setStyle("textDecoration", "normal");
            _loc_1.setStyle("left", "176");
            _loc_1.setStyle("top", "269");
            _loc_1.setStyle("color", 3355443);
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.addEventListener("click", this.___main_Label4_click);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _main_Image5_c() : Image
        {
            var _loc_1:* = new Image();
            _loc_1.scaleContent = true;
            _loc_1.maintainAspectRatio = false;
            _loc_1.autoLoad = true;
            _loc_1.source = "img/v1/sfondo_tool_tip.png";
            _loc_1.x = 0;
            _loc_1.y = 0;
            _loc_1.width = 95;
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _main_Canvas5_i() : Canvas
        {
            var _loc_1:* = new Canvas();
            this.wcanvasTerms = _loc_1;
            _loc_1.x = 0;
            _loc_1.y = 0;
            _loc_1.percentWidth = 100;
            _loc_1.percentHeight = 100;
            _loc_1.id = "wcanvasTerms";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            _loc_1.addChild(this._main_TextArea1_c());
            _loc_1.addChild(this._main_CheckBox8_i());
            _loc_1.addChild(this._main_Button5_i());
            _loc_1.addChild(this._main_Label16_c());
            _loc_1.addChild(this._main_Image8_c());
            _loc_1.addChild(this._main_Label17_c());
            return _loc_1;
        }// end function

        private function hideLoading() : void
        {
            if (this.ldr == null)
            {
                return;
            }
            if (this.ldr.statoerrore)
            {
                return;
            }
            this.fadeOut.target = this.ldr;
            this.fadeOut.addEventListener(EffectEvent.EFFECT_END, this.loadingEffectComplete);
            this.fadeOut.play();
            return;
        }// end function

        public function get b_login() : Button
        {
            return this._396033716b_login;
        }// end function

        private function _main_Button4_i() : Button
        {
            var _loc_1:* = new Button();
            this._main_Button4 = _loc_1;
            _loc_1.buttonMode = true;
            _loc_1.useHandCursor = true;
            _loc_1.setStyle("left", "176");
            _loc_1.setStyle("top", "278");
            _loc_1.setStyle("upSkin", this._embed_mxml_img_v1_option_ok_png_840615663);
            _loc_1.setStyle("overSkin", this._embed_mxml_img_v1_option_ok_over_png_316945757);
            _loc_1.setStyle("downSkin", this._embed_mxml_img_v1_option_ok_png_840615663);
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.addEventListener("click", this.___main_Button4_click);
            _loc_1.id = "_main_Button4";
            BindingManager.executeBindings(this, "_main_Button4", this._main_Button4);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function get wcanvas_console() : Canvas
        {
            return this._1560317351wcanvas_console;
        }// end function

        public function __consoleOut_effectEnd(event:EffectEvent) : void
        {
            this.globalCanvas.alpha = 0;
            currentState = "Options";
            this.setupOptions();
            return;
        }// end function

        public function __sms_sms_sending_complete(event:Event) : void
        {
            this.hideLoading();
            return;
        }// end function

        private function _main_CheckBox3_i() : CheckBox
        {
            var _loc_1:* = new CheckBox();
            this.optionAutostart = _loc_1;
            _loc_1.setStyle("left", "10");
            _loc_1.setStyle("top", "91");
            _loc_1.setStyle("fillAlphas", [1, 1]);
            _loc_1.setStyle("fillColors", [16777215, 16185078]);
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.id = "optionAutostart";
            BindingManager.executeBindings(this, "optionAutostart", this.optionAutostart);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function get msisdnList() : Array
        {
            return this._1381897832msisdnList;
        }// end function

        private function tryCommunicating(event:Event) : void
        {
            trace(ServerBridge.getServerBridgeInstance()._sessione);
            trace(ServerBridge.getServerBridgeInstance()._MD);
            this.conn.send("_banner_connection", "redirect", ServerBridge.getServerBridgeInstance()._sessione, ServerBridge.getServerBridgeInstance()._MD, this.pageRequested);
            return;
        }// end function

        public function __f_username_click(event:MouseEvent) : void
        {
            this.cleanField("username");
            return;
        }// end function

        private function _main_AddChild1_i() : AddChild
        {
            var _loc_1:* = new AddChild();
            this._main_AddChild1 = _loc_1;
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._main_Canvas1_i);
            BindingManager.executeBindings(this, "_main_AddChild1", this._main_AddChild1);
            return _loc_1;
        }// end function

        public function set globalCanvas(param1:Canvas) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1135485221globalCanvas;
            if (_loc_2 !== param1)
            {
                this._1135485221globalCanvas = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "globalCanvas", _loc_2, param1));
            }
            return;
        }// end function

        private function _main_Canvas4_i() : Canvas
        {
            var _loc_1:* = new Canvas();
            this.wcanvOptions = _loc_1;
            _loc_1.x = 0;
            _loc_1.y = 0;
            _loc_1.percentWidth = 100;
            _loc_1.percentHeight = 100;
            _loc_1.setStyle("borderColor", 12040892);
            _loc_1.id = "wcanvOptions";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            _loc_1.addChild(this._main_Label6_c());
            _loc_1.addChild(this._main_Label7_c());
            _loc_1.addChild(this._main_Label8_c());
            _loc_1.addChild(this._main_CheckBox2_i());
            _loc_1.addChild(this._main_CheckBox3_i());
            _loc_1.addChild(this._main_CheckBox4_i());
            _loc_1.addChild(this._main_CheckBox5_i());
            _loc_1.addChild(this._main_CheckBox6_i());
            _loc_1.addChild(this._main_CheckBox7_i());
            _loc_1.addChild(this._main_Label9_i());
            _loc_1.addChild(this._main_Label10_i());
            _loc_1.addChild(this._main_Label11_i());
            _loc_1.addChild(this._main_Label12_i());
            _loc_1.addChild(this._main_Button4_i());
            _loc_1.addChild(this._main_Label13_i());
            _loc_1.addChild(this._main_Text6_c());
            _loc_1.addChild(this._main_Label14_i());
            _loc_1.addChild(this._main_Image6_i());
            _loc_1.addChild(this._main_Label15_i());
            _loc_1.addChild(this._main_Image7_i());
            return _loc_1;
        }// end function

        public function get rss_3_enabled() : CheckBox
        {
            return this._345717368rss_3_enabled;
        }// end function

        private function savePosition(event:MouseEvent) : void
        {
            var e:* = event;
            try
            {
                LocalPreferences.getInstance().storageSet("xpos", stage.nativeWindow.x.toString(), false);
                LocalPreferences.getInstance().storageSet("ypos", stage.nativeWindow.y.toString(), false);
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        private function _main_Label12_i() : Label
        {
            var _loc_1:* = new Label();
            this.rss_title_4 = _loc_1;
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 10);
            _loc_1.setStyle("color", 0);
            _loc_1.setStyle("left", "37");
            _loc_1.setStyle("top", "234");
            _loc_1.id = "rss_title_4";
            BindingManager.executeBindings(this, "rss_title_4", this.rss_title_4);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _main_Label3_c() : Label
        {
            var _loc_1:* = new Label();
            _loc_1.text = "Help";
            _loc_1.buttonMode = true;
            _loc_1.useHandCursor = true;
            _loc_1.mouseChildren = false;
            _loc_1.setStyle("top", "324");
            _loc_1.setStyle("left", "43");
            _loc_1.setStyle("fontWeight", "normal");
            _loc_1.setStyle("color", 3355443);
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.addEventListener("click", this.___main_Label3_click);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _main_Image4_c() : Image
        {
            var _loc_1:* = new Image();
            _loc_1.scaleContent = false;
            _loc_1.autoLoad = true;
            _loc_1.source = this._embed_mxml_img_v1_linea_fondo_png_902459519;
            _loc_1.x = 3;
            _loc_1.y = 289;
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _main_Testata1_i() : Testata
        {
            var _loc_1:* = new Testata();
            this.testata = _loc_1;
            _loc_1.x = 0;
            _loc_1.y = 34;
            _loc_1.addEventListener("logout", this.__testata_logout);
            _loc_1.addEventListener("msisdnUpdated", this.__testata_msisdnUpdated);
            _loc_1.id = "testata";
            BindingManager.executeBindings(this, "testata", this.testata);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _main_CheckBox2_i() : CheckBox
        {
            var _loc_1:* = new CheckBox();
            this.optionRemember = _loc_1;
            _loc_1.setStyle("left", "10");
            _loc_1.setStyle("top", "71");
            _loc_1.setStyle("fillAlphas", [1, 1]);
            _loc_1.setStyle("fillColors", [16777215, 16185078]);
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.id = "optionRemember";
            BindingManager.executeBindings(this, "optionRemember", this.optionRemember);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function set rss_title_1_tx(param1:String) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._91839206rss_title_1_tx;
            if (_loc_2 !== param1)
            {
                this._91839206rss_title_1_tx = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rss_title_1_tx", _loc_2, param1));
            }
            return;
        }// end function

        private function corporateUser(event:Event) : void
        {
            trace("Main - Corporate user");
            dispatchEvent(new DisplayErrorEvent("Non è possibile accedere con il profilo di registrazione Business."));
            return;
        }// end function

        public function set c_remember(param1:CheckBox) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1588188905c_remember;
            if (_loc_2 !== param1)
            {
                this._1588188905c_remember = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "c_remember", _loc_2, param1));
            }
            return;
        }// end function

        private function _main_Button3_i() : Button
        {
            var _loc_1:* = new Button();
            this.b_new = _loc_1;
            _loc_1.styleName = "newWhite";
            _loc_1.buttonMode = true;
            _loc_1.useHandCursor = true;
            _loc_1.toolTip = " ";
            _loc_1.x = 200;
            _loc_1.y = 19;
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.addEventListener("click", this.__b_new_click);
            _loc_1.addEventListener("initialize", this.__b_new_initialize);
            _loc_1.addEventListener("toolTipCreate", this.__b_new_toolTipCreate);
            _loc_1.id = "b_new";
            BindingManager.executeBindings(this, "b_new", this.b_new);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function iconaNewBlinkHandler(event:TimerEvent) : void
        {
            if (this.iconaNewBlinkWhite)
            {
                this.b_new.styleName = "newGray";
            }
            else
            {
                this.b_new.styleName = "newWhite";
            }
            this.iconaNewBlinkWhite = !this.iconaNewBlinkWhite;
            return;
        }// end function

        private function get _hidePass() : Boolean
        {
            return this._1683524142_hidePass;
        }// end function

        private function _main_Label11_i() : Label
        {
            var _loc_1:* = new Label();
            this.rss_title_3 = _loc_1;
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 10);
            _loc_1.setStyle("color", 0);
            _loc_1.setStyle("left", "37");
            _loc_1.setStyle("top", "212");
            _loc_1.id = "rss_title_3";
            BindingManager.executeBindings(this, "rss_title_3", this.rss_title_3);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function get ldr() : Loading
        {
            return this._107002ldr;
        }// end function

        public function set b_help(param1:Image) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1398377218b_help;
            if (_loc_2 !== param1)
            {
                this._1398377218b_help = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "b_help", _loc_2, param1));
            }
            return;
        }// end function

        private function _main_Canvas3_i() : Canvas
        {
            var _loc_1:* = new Canvas();
            this.tt_new = _loc_1;
            _loc_1.x = 114;
            _loc_1.y = 29;
            _loc_1.visible = false;
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.id = "tt_new";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            _loc_1.addChild(this._main_Image5_c());
            _loc_1.addChild(this._main_Text5_c());
            return _loc_1;
        }// end function

        public function get rssArea() : Rss
        {
            return this._1496811007rssArea;
        }// end function

        private function _main_Label2_c() : Label
        {
            var _loc_1:* = new Label();
            _loc_1.text = "Li hai dimenticati?";
            _loc_1.buttonMode = true;
            _loc_1.useHandCursor = true;
            _loc_1.mouseChildren = false;
            _loc_1.setStyle("top", "269");
            _loc_1.setStyle("left", "43");
            _loc_1.setStyle("fontWeight", "normal");
            _loc_1.setStyle("color", 3355443);
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.addEventListener("click", this.___main_Label2_click);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function setVersionColorSkin() : void
        {
            switch(this.SKIN_TYPE)
            {
                case this.VODAFONE_SKIN:
                {
                    this.t_version.setStyle("color", 3355443);
                    break;
                }
                case this.ZEROLIMITS_SKIN:
                {
                    this.t_version.setStyle("color", 16777215);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function _main_CheckBox1_i() : CheckBox
        {
            var _loc_1:* = new CheckBox();
            this.c_remember = _loc_1;
            _loc_1.x = 40;
            _loc_1.y = 293;
            _loc_1.setStyle("fillAlphas", [1, 1]);
            _loc_1.setStyle("fillColors", [16777215, 16185078]);
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.id = "c_remember";
            BindingManager.executeBindings(this, "c_remember", this.c_remember);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _main_Image3_c() : Image
        {
            var _loc_1:* = new Image();
            _loc_1.scaleContent = false;
            _loc_1.autoLoad = true;
            _loc_1.source = this._embed_mxml_img_v1_freccina_login_png_570740061;
            _loc_1.useHandCursor = true;
            _loc_1.buttonMode = true;
            _loc_1.x = 173;
            _loc_1.y = 274;
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function performSlaveLogin(event:Event) : void
        {
            this.showLoading();
            this._rememberMe = false;
            this._hidePass = true;
            this._username = this.loginClient.username;
            this._password = this.loginClient.password;
            this.loginSlave = true;
            this.performLogin();
            return;
        }// end function

        protected function TrayIcon_Click(event:Event) : void
        {
            stage.nativeWindow.visible = true;
            if (this.rssArea != null)
            {
                this.rssArea.resumeEffect();
            }
            return;
        }// end function

        private function clickSuError(event:Event) : void
        {
            if (this.ldr == null)
            {
                return;
            }
            this.fadeOut.target = this.ldr;
            this.fadeOut.addEventListener(EffectEvent.EFFECT_END, this.loadingEffectComplete);
            this.fadeOut.play();
            return;
        }// end function

        public function ___main_WindowedApplication1_creationComplete(event:FlexEvent) : void
        {
            this.init();
            return;
        }// end function

        public function get optionRemember() : CheckBox
        {
            return this._1556188706optionRemember;
        }// end function

        private function _main_Button2_i() : Button
        {
            var _loc_1:* = new Button();
            this.b_options = _loc_1;
            _loc_1.buttonMode = true;
            _loc_1.useHandCursor = true;
            _loc_1.x = 233;
            _loc_1.y = 18;
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.addEventListener("initialize", this.__b_options_initialize);
            _loc_1.addEventListener("click", this.__b_options_click);
            _loc_1.id = "b_options";
            BindingManager.executeBindings(this, "b_options", this.b_options);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function switchMsisdn() : void
        {
            this.showLoading();
            ServerBridge.getServerBridgeInstance().addEventListener(ServerBridge.USER_DATA_LOADED, this.switchMsisdnOk);
            ServerBridge.getServerBridgeInstance().currentMsisdn = this.testata.selectedMsisdn;
            return;
        }// end function

        private function _main_Label10_i() : Label
        {
            var _loc_1:* = new Label();
            this.rss_title_2 = _loc_1;
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 10);
            _loc_1.setStyle("color", 0);
            _loc_1.setStyle("left", "37");
            _loc_1.setStyle("top", "190");
            _loc_1.id = "rss_title_2";
            BindingManager.executeBindings(this, "rss_title_2", this.rss_title_2);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function get wcanvasTerms() : Canvas
        {
            return this._592730680wcanvasTerms;
        }// end function

        public function set rss_title_1(param1:Label) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._466098403rss_title_1;
            if (_loc_2 !== param1)
            {
                this._466098403rss_title_1 = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rss_title_1", _loc_2, param1));
            }
            return;
        }// end function

        private function set rss_title_2_sl(param1:Boolean) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._91868954rss_title_2_sl;
            if (_loc_2 !== param1)
            {
                this._91868954rss_title_2_sl = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rss_title_2_sl", _loc_2, param1));
            }
            return;
        }// end function

        public function set optionAutostart(param1:CheckBox) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1689282334optionAutostart;
            if (_loc_2 !== param1)
            {
                this._1689282334optionAutostart = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "optionAutostart", _loc_2, param1));
            }
            return;
        }// end function

        private function _main_Canvas2_i() : Canvas
        {
            var _loc_1:* = new Canvas();
            this.wcanvas_console = _loc_1;
            _loc_1.x = 0;
            _loc_1.y = 0;
            _loc_1.percentWidth = 100;
            _loc_1.percentHeight = 100;
            _loc_1.id = "wcanvas_console";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            _loc_1.addChild(this._main_Testata1_i());
            _loc_1.addChild(this._main_Rss1_i());
            _loc_1.addChild(this._main_Sms1_i());
            _loc_1.addChild(this._main_Infoconto1_i());
            _loc_1.addChild(this._main_Image4_c());
            _loc_1.addChild(this._main_SaldoPunti1_i());
            _loc_1.addChild(this._main_Button2_i());
            _loc_1.addChild(this._main_Button3_i());
            _loc_1.addChild(this._main_Canvas3_i());
            return _loc_1;
        }// end function

        private function bannerStatus(event:StatusEvent) : void
        {
            switch(event.level)
            {
                case "status":
                {
                    trace("Main - LocalConnection.send() succeeded");
                    this.bannerRetryTimer.stop();
                    ServerBridge.getServerBridgeInstance().sessionExpired();
                    this.showLoading();
                    break;
                }
                case "error":
                {
                    trace("Main - LocalConnection.send() failed");
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function set rss_title_4(param1:Label) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._466098400rss_title_4;
            if (_loc_2 !== param1)
            {
                this._466098400rss_title_4 = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rss_title_4", _loc_2, param1));
            }
            return;
        }// end function

        public function set rss_title_2(param1:Label) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._466098402rss_title_2;
            if (_loc_2 !== param1)
            {
                this._466098402rss_title_2 = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rss_title_2", _loc_2, param1));
            }
            return;
        }// end function

        private function get _username() : String
        {
            return this._175195595_username;
        }// end function

        public function set rss_title_3(param1:Label) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._466098401rss_title_3;
            if (_loc_2 !== param1)
            {
                this._466098401rss_title_3 = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rss_title_3", _loc_2, param1));
            }
            return;
        }// end function

        private function loadingEffectComplete(event:Event) : void
        {
            if (this.ldr != null)
            {
                this.globalCanvas.removeChild(this.ldr);
            }
            this.ldr = null;
            return;
        }// end function

        private function _main_Label1_c() : Label
        {
            var _loc_1:* = new Label();
            _loc_1.text = "Ricordami su questo computer";
            _loc_1.y = 295;
            _loc_1.x = 58.5;
            _loc_1.setStyle("fontWeight", "normal");
            _loc_1.setStyle("color", 3355443);
            _loc_1.setStyle("fontFamily", "defFont");
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function ___main_Flip3_effectEnd(event:EffectEvent) : void
        {
            this.wcanvas.alpha = 1;
            return;
        }// end function

        private function _main_TextInput2_i() : TextInput
        {
            var _loc_1:* = new TextInput();
            this.f_password = _loc_1;
            _loc_1.styleName = "loginPassword";
            _loc_1.width = 196;
            _loc_1.y = 206;
            _loc_1.setStyle("horizontalCenter", "0");
            _loc_1.setStyle("fontSize", 11);
            _loc_1.setStyle("themeColor", 40447);
            _loc_1.addEventListener("change", this.__f_password_change);
            _loc_1.addEventListener("focusIn", this.__f_password_focusIn);
            _loc_1.addEventListener("click", this.__f_password_click);
            _loc_1.addEventListener("enter", this.__f_password_enter);
            _loc_1.id = "f_password";
            BindingManager.executeBindings(this, "f_password", this.f_password);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _main_Image2_c() : Image
        {
            var _loc_1:* = new Image();
            _loc_1.scaleContent = false;
            _loc_1.autoLoad = true;
            _loc_1.source = this._embed_mxml_img_v1_freccina_login_png_570740061;
            _loc_1.useHandCursor = true;
            _loc_1.buttonMode = true;
            _loc_1.x = 40;
            _loc_1.y = 329;
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function get rss_title_4_visible() : Boolean
        {
            return this._1370464685rss_title_4_visible;
        }// end function

        public function __testata_logout(event:Event) : void
        {
            this.logout();
            return;
        }// end function

        private function loginCheckPreferences(event:Event = null) : void
        {
            if (!RemotePreferences.getInstance().loaded)
            {
                trace("Main - Waiting for preferences");
                RemotePreferences.getInstance().addEventListener(RemotePreferences.PREFERENCES_LOADED, this.loginCheckPreferences);
                return;
            }
            RemotePreferences.getInstance().removeEventListener(RemotePreferences.PREFERENCES_LOADED, this.loginCheckPreferences);
            trace("Main - reset RubricaUser and UltimiNumeriUser");
            UltimiNumeriUser.getIstance(this._username, true);
            RubricaUser.getIstance(this._username, true);
            RubricaList.hasBeenShown = false;
            var _loc_2:* = ServerBridge.getServerBridgeInstance();
            _loc_2.addEventListener(ServerBridge.USER_DATA_LOADED, this.loginOk);
            _loc_2.addEventListener(ServerBridge.CORPORATE_ERROR, this.corporateUser);
            _loc_2.addEventListener(ServerBridge.NO_SIM_ERROR, this.noSimError);
            _loc_2.addEventListener(ServerBridge.LOGIN_ERROR, this.loginError);
            _loc_2.addEventListener(ServerBridge.SERVER_ERROR, this.serverError);
            _loc_2.removeEventListener(ServerBridge.NETWORK_ERROR, this.networkError);
            _loc_2.addEventListener(ServerBridge.NETWORK_ERROR, this.networkErrorLogin);
            _loc_2.addEventListener(ServerBridge.CHECK_USER_SECURITY_ERROR, this.logoutAfterError);
            _loc_2.login(this._username, this._password);
            return;
        }// end function

        public function get f_password() : TextInput
        {
            return this._1557004716f_password;
        }// end function

        public function closeWidget() : void
        {
            var _loc_1:NativeMenu = null;
            var _loc_2:NativeMenuItem = null;
            if (NativeApplication.supportsSystemTrayIcon)
            {
                if (this.rssArea != null)
                {
                    this.rssArea.holdEffect();
                }
                stage.nativeWindow.visible = false;
                NativeApplication.nativeApplication.icon.bitmaps = [this.dockImage];
                _loc_1 = new NativeMenu();
                _loc_2 = new NativeMenuItem("Esci da Widget vodafone.it");
                _loc_2.addEventListener(Event.SELECT, this.exitWidget);
                _loc_1.addItem(_loc_2);
                SystemTrayIcon(NativeApplication.nativeApplication.icon).menu = _loc_1;
            }
            else
            {
                if (this.rssArea != null)
                {
                    this.rssArea.holdEffect();
                }
                stage.nativeWindow.minimize();
                stage.nativeWindow.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE, this.restoreScroll);
            }
            return;
        }// end function

        private function _main_SaldoPunti1_i() : SaldoPunti
        {
            var _loc_1:* = new SaldoPunti();
            this.saldoPunti = _loc_1;
            _loc_1.y = 94;
            _loc_1.x = 138;
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.id = "saldoPunti";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function saveOptions() : void
        {
            this._rememberMe = this.optionRemember.selected;
            this._autostart = this.optionAutostart.selected;
            this.updateRememberMe();
            if (RssInterface.getInstance().feedCount >= 1)
            {
                if (this.rss_1_enabled.selected)
                {
                    RssInterface.getInstance().enableFeed(0);
                }
                else
                {
                    RssInterface.getInstance().disableFeed(0);
                }
            }
            if (RssInterface.getInstance().feedCount >= 2)
            {
                if (this.rss_2_enabled.selected)
                {
                    RssInterface.getInstance().enableFeed(1);
                }
                else
                {
                    RssInterface.getInstance().disableFeed(1);
                }
            }
            if (RssInterface.getInstance().feedCount >= 3)
            {
                if (this.rss_3_enabled.selected)
                {
                    RssInterface.getInstance().enableFeed(2);
                }
                else
                {
                    RssInterface.getInstance().disableFeed(2);
                }
            }
            if (RssInterface.getInstance().feedCount >= 4)
            {
                if (this.rss_4_enabled.selected)
                {
                    RssInterface.getInstance().enableFeed(3);
                }
                else
                {
                    RssInterface.getInstance().disableFeed(3);
                }
            }
            try
            {
                if (this.optionAutostart.selected)
                {
                    LocalPreferences.getInstance().storageSet("autostart", "1", false);
                    NativeApplication.nativeApplication.startAtLogin = true;
                }
                else
                {
                    LocalPreferences.getInstance().storageSet("autostart", "0", false);
                    NativeApplication.nativeApplication.startAtLogin = false;
                }
            }
            catch (e:Error)
            {
            }
            this.optionsOut.play();
            return;
        }// end function

        private function _main_Button1_i() : Button
        {
            var _loc_1:* = new Button();
            this.b_login = _loc_1;
            _loc_1.buttonMode = true;
            _loc_1.useHandCursor = true;
            _loc_1.x = 145;
            _loc_1.y = 239;
            _loc_1.setStyle("upSkin", this._embed_mxml_img_v1_login_png_750310895);
            _loc_1.setStyle("overSkin", this._embed_mxml_img_v1_login_over_png_245792827);
            _loc_1.setStyle("downSkin", this._embed_mxml_img_v1_login_png_750310895);
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.addEventListener("click", this.__b_login_click);
            _loc_1.id = "b_login";
            BindingManager.executeBindings(this, "b_login", this.b_login);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function set fadeOut(param1:Fade) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1091436750fadeOut;
            if (_loc_2 !== param1)
            {
                this._1091436750fadeOut = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fadeOut", _loc_2, param1));
            }
            return;
        }// end function

        private function goLoginPane() : void
        {
            LocalPreferences.getInstance().storageSet("termsapproved", "1", false);
            currentState = "Login";
            this.switchPasswordField();
            var _loc_1:* = new Timer(700, 1);
            _loc_1.addEventListener(TimerEvent.TIMER_COMPLETE, this.checkAutologin);
            _loc_1.start();
            this.appUpdater.updateURL = RemotePreferences.getInstance().getValue("update_url");
            this.appUpdater.delay = Number(RemotePreferences.getInstance().getValue("update_days"));
            this.appUpdater.addEventListener(UpdateEvent.INITIALIZED, this.onUpdate);
            this.appUpdater.isCheckForUpdateVisible = false;
            this.appUpdater.isFileUpdateVisible = false;
            this.appUpdater.isInstallUpdateVisible = false;
            this.appUpdater.initialize();
            return;
        }// end function

        public function set skinCanvas(param1:Skin) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._2084539083skinCanvas;
            if (_loc_2 !== param1)
            {
                this._2084539083skinCanvas = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "skinCanvas", _loc_2, param1));
            }
            return;
        }// end function

        public function get displayName() : String
        {
            return this._1714148973displayName;
        }// end function

        private function manageBannerClickShareSession(event:Event) : void
        {
            if (this.lastBannerClick == null)
            {
                return;
            }
            var _loc_2:* = new Date();
            navigateToURL(new URLRequest(RemotePreferences.getInstance().getValue("banner_landing") + "?" + _loc_2.time));
            this.conn = new LocalConnection();
            this.conn.allowInsecureDomain("*");
            this.conn.addEventListener(StatusEvent.STATUS, this.bannerStatus);
            if (this.lastBannerClick._destination.indexOf("?") < 0)
            {
                this.pageRequested = this.lastBannerClick._destination + "?ty_skip_md=false";
            }
            else
            {
                this.pageRequested = this.lastBannerClick._destination + "&ty_skip_md=false";
            }
            this.bannerRetryTimer.addEventListener(TimerEvent.TIMER, this.tryCommunicating);
            this.bannerRetryTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.stopTryingCommunicating);
            this.bannerRetryTimer.reset();
            this.bannerRetryTimer.start();
            return;
        }// end function

        private function setBaseSkin() : void
        {
            switch(this.SKIN_TYPE)
            {
                case this.VODAFONE_SKIN:
                {
                    this.skinCanvas.currentState = "vodafone_skin";
                    break;
                }
                case this.ZEROLIMITS_SKIN:
                {
                    this.skinCanvas.currentState = "zerolimits_skin";
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function get consoleOut() : Flip
        {
            return this._338968969consoleOut;
        }// end function

        private function _main_Image1_c() : Image
        {
            var _loc_1:* = new Image();
            _loc_1.scaleContent = false;
            _loc_1.autoLoad = true;
            _loc_1.source = this._embed_mxml_img_v1_freccina_login_png_570740061;
            _loc_1.useHandCursor = true;
            _loc_1.buttonMode = true;
            _loc_1.x = 40;
            _loc_1.y = 274;
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _main_Canvas1_i() : Canvas
        {
            var _loc_1:* = new Canvas();
            this.wcanvas = _loc_1;
            _loc_1.x = 0;
            _loc_1.y = 0;
            _loc_1.percentWidth = 100;
            _loc_1.percentHeight = 100;
            _loc_1.id = "wcanvas";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            _loc_1.addChild(this._main_Button1_i());
            _loc_1.addChild(this._main_TextInput1_i());
            _loc_1.addChild(this._main_TextInput2_i());
            _loc_1.addChild(this._main_Label1_c());
            _loc_1.addChild(this._main_CheckBox1_i());
            _loc_1.addChild(this._main_Label2_c());
            _loc_1.addChild(this._main_Label3_c());
            _loc_1.addChild(this._main_Label4_c());
            _loc_1.addChild(this._main_Label5_i());
            _loc_1.addChild(this._main_Text1_c());
            _loc_1.addChild(this._main_Text2_c());
            _loc_1.addChild(this._main_Image1_c());
            _loc_1.addChild(this._main_Image2_c());
            _loc_1.addChild(this._main_Image3_c());
            _loc_1.addChild(this._main_Text3_c());
            _loc_1.addChild(this._main_Text4_c());
            return _loc_1;
        }// end function

        private function _main_TextInput1_i() : TextInput
        {
            var _loc_1:* = new TextInput();
            this.f_username = _loc_1;
            _loc_1.styleName = "loginUser";
            _loc_1.y = 165;
            _loc_1.width = 196;
            _loc_1.setStyle("horizontalCenter", "0");
            _loc_1.setStyle("fontSize", 11);
            _loc_1.addEventListener("focusIn", this.__f_username_focusIn);
            _loc_1.addEventListener("click", this.__f_username_click);
            _loc_1.addEventListener("enter", this.__f_username_enter);
            _loc_1.id = "f_username";
            BindingManager.executeBindings(this, "f_username", this.f_username);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function get rss_2_enabled() : CheckBox
        {
            return this._1461737095rss_2_enabled;
        }// end function

        private function set rss_title_2_tx(param1:String) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._91868997rss_title_2_tx;
            if (_loc_2 !== param1)
            {
                this._91868997rss_title_2_tx = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rss_title_2_tx", _loc_2, param1));
            }
            return;
        }// end function

        public function ___main_Flip6_effectEnd(event:EffectEvent) : void
        {
            this.globalCanvas.alpha = 1;
            this.rssArea.manageScrolling();
            return;
        }// end function

        private function applicationExit() : void
        {
            RemotePreferences.getInstance().kill();
            ServerBridge.getServerBridgeInstance().kill();
            stage.nativeWindow.close();
            return;
        }// end function

        public function ___main_Label4_click(event:MouseEvent) : void
        {
            this.goSite("register");
            return;
        }// end function

        public function ___main_State1_enterState(event:FlexEvent) : void
        {
            this.setBaseSkin();
            return;
        }// end function

        private function applicationExiting(event:Event) : void
        {
            trace("Main - application terminating by OS req");
            this.applicationExit();
            return;
        }// end function

        public function set b_login(param1:Button) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._396033716b_login;
            if (_loc_2 !== param1)
            {
                this._396033716b_login = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "b_login", _loc_2, param1));
            }
            return;
        }// end function

        private function get _rememberMe() : Boolean
        {
            return this._1641862820_rememberMe;
        }// end function

        private function _main_State5_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "Terms";
            _loc_1.overrides = [this._main_AddChild4_i()];
            _loc_1.addEventListener("enterState", this.___main_State5_enterState);
            return _loc_1;
        }// end function

        private function set rss_title_3_visible(param1:Boolean) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._436989778rss_title_3_visible;
            if (_loc_2 !== param1)
            {
                this._436989778rss_title_3_visible = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rss_title_3_visible", _loc_2, param1));
            }
            return;
        }// end function

        public function __b_new_click(event:MouseEvent) : void
        {
            this.clickSuNew();
            return;
        }// end function

        private function updateRememberMe() : void
        {
            if (this._rememberMe)
            {
                LocalPreferences.getInstance().autologin = true;
                LocalPreferences.getInstance().setLoginInfo(this._username, this._password);
            }
            else
            {
                LocalPreferences.getInstance().autologin = false;
            }
            return;
        }// end function

        private function set rss_title_1_visible(param1:Boolean) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._243068592rss_title_1_visible;
            if (_loc_2 !== param1)
            {
                this._243068592rss_title_1_visible = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rss_title_1_visible", _loc_2, param1));
            }
            return;
        }// end function

        public function set sms(param1:Sms) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._114009sms;
            if (_loc_2 !== param1)
            {
                this._114009sms = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sms", _loc_2, param1));
            }
            return;
        }// end function

        public function __b_options_initialize(event:FlexEvent) : void
        {
            this.setOptionsButtonColorSkin();
            return;
        }// end function

        private function logoutAfterError(event:Event) : void
        {
            trace("logoutAfterError");
            this.showLoading();
            this.loginSlave = false;
            this.loginServer.stop();
            ServerBridge.getServerBridgeInstance().addEventListener(ServerBridge.LOGGED_OUT, this.logoutCompleteAfterError);
            ServerBridge.getServerBridgeInstance().logout();
            return;
        }// end function

        private function get rss_title_1_sl() : Boolean
        {
            return this._91839163rss_title_1_sl;
        }// end function

        public function ___main_State4_enterState(event:FlexEvent) : void
        {
            this.setOptionsSkin();
            return;
        }// end function

        private function clickSuRetry(event:Event) : void
        {
            if (this.ldr == null)
            {
                return;
            }
            this.loadingEffectComplete(null);
            this.performLogin();
            return;
        }// end function

        public function set tt_new(param1:Canvas) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._863918239tt_new;
            if (_loc_2 !== param1)
            {
                this._863918239tt_new = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tt_new", _loc_2, param1));
            }
            return;
        }// end function

        private function cancelOptions() : void
        {
            this.rss_1_enabled.selected = this.rss_title_1_sl;
            this.rss_2_enabled.selected = this.rss_title_2_sl;
            this.rss_3_enabled.selected = this.rss_title_3_sl;
            this.rss_4_enabled.selected = this.rss_title_4_sl;
            this.optionAutostart.selected = this._autostart;
            this.optionRemember.selected = this._rememberMe;
            return;
        }// end function

        private function get _autostart() : Boolean
        {
            return this._190846612_autostart;
        }// end function

        private function _main_State4_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "Options";
            _loc_1.overrides = [this._main_AddChild3_i()];
            _loc_1.addEventListener("enterState", this.___main_State4_enterState);
            return _loc_1;
        }// end function

        private function switchToOptions(param1:Boolean) : void
        {
            this.rssArea.nascondi();
            if (RssInterface.getInstance().feedCount >= 1)
            {
                this.rss_title_1_tx = RssInterface.getInstance().getTitle(0);
                this.rss_title_1_sl = RssInterface.getInstance().feedEnabled(0);
                this.rss_title_1_visible = true;
            }
            if (RssInterface.getInstance().feedCount >= 2)
            {
                this.rss_title_2_tx = RssInterface.getInstance().getTitle(1);
                this.rss_title_2_sl = RssInterface.getInstance().feedEnabled(1);
                this.rss_title_2_visible = true;
            }
            if (RssInterface.getInstance().feedCount >= 3)
            {
                this.rss_title_3_tx = RssInterface.getInstance().getTitle(2);
                this.rss_title_3_sl = RssInterface.getInstance().feedEnabled(2);
                this.rss_title_3_visible = true;
            }
            if (RssInterface.getInstance().feedCount >= 4)
            {
                this.rss_title_4_tx = RssInterface.getInstance().getTitle(3);
                this.rss_title_4_sl = RssInterface.getInstance().feedEnabled(3);
                this.rss_title_4_visible = true;
            }
            if (currentState != "Options")
            {
                this.consoleOut.play();
            }
            return;
        }// end function

        public function clickSuLogo() : void
        {
            switch(this.SKIN_TYPE)
            {
                case this.VODAFONE_SKIN:
                {
                    if (ServerBridge.getServerBridgeInstance().isLogged)
                    {
                        dispatchEvent(new BannerClick("http://www.vodafone.it"));
                    }
                    else
                    {
                        navigateToURL(new URLRequest("http://www.vodafone.it"));
                    }
                    break;
                }
                case this.ZEROLIMITS_SKIN:
                {
                    if (ServerBridge.getServerBridgeInstance().isLogged)
                    {
                        dispatchEvent(new BannerClick("http://www.vodafone.it"));
                    }
                    else
                    {
                        navigateToURL(new URLRequest("http://www.vodafone.it"));
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

        private function logoutCompleteAfterError(event:Event = null) : void
        {
            trace("main, logoutCompleteAfterError");
            ServerBridge.getServerBridgeInstance().removeEventListener(ServerBridge.LOGGED_OUT, this.logoutCompleteAfterError);
            this._username = "Inserisci il tuo username";
            this._password = "Inserisci la tua password";
            if (this.ldr != null)
            {
                this.globalCanvas.removeChild(this.ldr);
            }
            this.ldr = null;
            currentState = "Login";
            LocalPreferences.getInstance().autologin = false;
            this.switchPasswordField();
            this.serverError();
            return;
        }// end function

        public function set windowCanvas(param1:Canvas) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1590523544windowCanvas;
            if (_loc_2 !== param1)
            {
                this._1590523544windowCanvas = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "windowCanvas", _loc_2, param1));
            }
            return;
        }// end function

        public function get globalCanvas() : Canvas
        {
            return this._1135485221globalCanvas;
        }// end function

        public function set infoConto(param1:Infoconto) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1205641071infoConto;
            if (_loc_2 !== param1)
            {
                this._1205641071infoConto = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "infoConto", _loc_2, param1));
            }
            return;
        }// end function

        public function prepareForSystray(event:Event) : void
        {
            this.dockImage = event.target.content.bitmapData;
            if (NativeApplication.supportsSystemTrayIcon)
            {
                SystemTrayIcon(NativeApplication.nativeApplication.icon).tooltip = "Widget vodafone.it";
                SystemTrayIcon(NativeApplication.nativeApplication.icon).addEventListener(MouseEvent.CLICK, this.TrayIcon_Click);
            }
            return;
        }// end function

        public function __t_version_initialize(event:FlexEvent) : void
        {
            this.setVersionColorSkin();
            return;
        }// end function

        private function get rss_title_1_tx() : String
        {
            return this._91839206rss_title_1_tx;
        }// end function

        public function get c_remember() : CheckBox
        {
            return this._1588188905c_remember;
        }// end function

        public function set bottone_termini(param1:Button) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._578057586bottone_termini;
            if (_loc_2 !== param1)
            {
                this._578057586bottone_termini = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bottone_termini", _loc_2, param1));
            }
            return;
        }// end function

        private function checkAutologin(event:Event) : void
        {
            if (LocalPreferences.getInstance().autologin)
            {
                this.performLogin();
            }
            else
            {
                this.loginClient.addEventListener(SharedLoginClient.START_LOGIN, this.performSlaveLogin);
                this.loginClient.startSearching();
            }
            return;
        }// end function

        private function _main_TextArea1_c() : TextArea
        {
            var _loc_1:* = new TextArea();
            _loc_1.y = 80;
            _loc_1.width = 236;
            _loc_1.height = 197;
            _loc_1.text = "Si riportano di seguito le Condizioni Generali di Contratto del Desktop Widget Vodafone  che si applicheranno ai Clienti privati utilizzatori dello stesso. L’ accettazione  di  Termini e Condizioni’ e’ condizione essenziale per poter utilizzare l’applicativo e accedere ai servizi offerti dallo stesso.\nArt. 1 – Oggetto\n1.1 Il Desktop Widget Vodafone -  Widget vodafone.it -(di seguito DW o il “Servizio”) descritto nell\'art. 2 viene fornito da Vodafone Omnitel N.V., società soggetta a direzione e coordinamento di Vodafone Group Plc, con sede legale in Amsterdam - Olanda (di seguito \"Vodafone\").\n1.2 Il Servizio  è fornito unicamente a favore dei Clienti Consumer registrati al sito che dopo aver effettuato il download dell’applicativo lo installino sul proprio computer.\n1.3 L’utilizzo del Servizio e’ gratuito. Il  Cliente paghera’ solamente i  costi di connessione internet.\n1.5 La fruizione  dei  servizi contenuti nel DW  è subordinata alla corretta installazione dell’applicativo sul proprio computer. \n1.6 Per accedere ai servizi meglio descritti nell’art. 2 il Cliente  deve essere regolarmente registrato al sito vodafone.it. Per “regolarmente registrato” si intende l’aver associato una SIM Vodafone ad username e password dopo aver completato tutte le fasi del processo di registrazione presente su vodafone.it., Per effettuare la registrazione al sito e’ necessario collegarsi al sito www.vodafone.it e scegliere “Registrati” tra le opzioni proposte nel box di login. Dopo aver inserito il proprio numero di SIM vodafone, scelto username e password e inserito i dati richiesti nell’apposito form, il Cliente riceve due codici di sblocco, uno via SMS e uno via email (specificata nell’inserimento dati precedente). L’inserimento di questi codici di sblocco al primo accesso al sito con username e password scelte costituisce l’effettivo completamento del processo di registrazione.\n\nArt. 2 - Descrizione del Servizio\n2.1 Il Servizio è riservato ai Clienti privati titolari e/o possessori di una carta SIM Vodafone (ricaricabile o abbonamento) regolarmente registrati al sito  vodafone.it. \nPer accedere ai servizi del DW il Cliente deve effettuare la login inserendo username e password di vodafone.it. Flaggando l’apposita opzione potra’  decidere se essere riconosciuto o meno al successivo  riavvio in modo da evitare di dover re-inserire le credenziali. Tale scelta potra’  essere cambiata in qualsiasi momento modificando le impostazioni dell’applicazione.\nAl pari di quanto succede su vodafone.it, il Cliente che ha associato alla stessa registrazione piu’ SIM puo’ scegliere su quale SIM operare.\nIl Servizio  consente al Cliente di:\n-\tInviare SMS gratuiti con le stesse funzionalita’ del servizio Free SMS erogato da vodafone.it. Il Cliente  potra’ inviare giornalmente da ogni SIM fino a 10 SMS gratuiti.. Vodafone, potra’ in qualsiasi momento variare tale numero. Ogni  variazione  sara’ comunicata  nel box del Servizio dedicato a tale funzionalita’;\n-\tVerificare il traffico residuo (SIM ricaricabile) o traffico accumulato non ancora fatturato (SIM abbonamento). L’informazione sara’ accompagnata dall’ora di aggiornamento del dato stesso;\n-\tVedere il saldo punti Vodafone One qualora sia iscritto al programma Loyalty.\n-\tVisualizzare i Feed RSS : il Cliente potra’ ricevere sul DW gli aggiornamenti sulle ultime notizie/forum/blog di vodafone.it e del vodafone lab. Tali contenuti, messi a disposizione dai diversi canali di Feed RSS che il Cliente potra’ scegliere in ogni momento dalla schermata settings fra quelli messi a disposizione da vodafone, scorreranno nella parte inferiore del DW e saranno dei link alla pagina sorgente sul sito (es. il Cliente che ha scelto di visualizzare i feed RSS del Blog del vodafone lab, quando fa click con il mouse sul contenuto scorrevole relativo ad un certo post del blog causa l’apertura del browser sulla pagina del vodafone lab che contiente il post indicato), \nArt. 3 - Obblighi del Cliente - Garanzie\n3.1 Il Cliente si obbliga a fornire, ove richiesto, dati personali veritieri, completi e corretti ai fini della corretta configurazione del Servizio. \n3.2 Nell\'utilizzo del Servizio, il Cliente si obbliga a garantire e a rispettare le regole di comportamento riportate nella \"Netiquette”, presente nel portale web “Vodafone Lab” che dichiara di conoscere e accettare. \n3.3 Il Servizio è limitato ad un uso privato e personale. Non può essere venduto, copiato o distribuito in alcun modo..\n\nArt. 4 – Sicurezza\n4.1 Vodafone si impegna ad assicurare il rispetto delle misure di sicurezza che saranno conformi agli standard generalmente applicati agli stessi tipi di servizi e previsti dalla normativa vigente. Salvo il caso di mancata applicazione delle suddette misure di sicurezza riconosciute come standard, Vodafone non potrà in alcun modo essere ritenuta responsabile per eventuali danni che risultano dall\'intercettazione da parte di terzi di comunicazioni personali del Cliente e/o dal mancato rispetto del presente art. 4 da parte del Cliente.\n\nArt. 5 - Modifiche e risoluzione del contratto\n5.1 Vodafone si riserva il diritto di integrare e/o modificare in qualunque momento le presenti Condizioni Contrattuali, anche a seguito dell\'introduzione di nuove o diverse funzionalità del Servizio.\n5.2 Il presente Contratto si considererà risolto di diritto ed in via immediata in caso di inadempimento del Cliente alle obbligazioni di cui all’art. 3   (e Obblighi del Cliente - Garanzie).\n\nArt. 6 - Limitazioni di responsabilità\n6.1 Vodafone non sarà in alcun caso ritenuta responsabile nei confronti del Cliente o di terzi soggetti per eventuali danni di qualsivoglia natura derivante della modifica, interruzione o malfunzionamento del  Servizio.\n6.2 Il Cliente prende atto ed accetta che Vodafone non potrà in alcun caso considerarsi responsabile delle informazioni, dati e messaggi accessibili tramite il Servizio, la responsabilità dei quali è e rimane pertanto a carico dei soggetti che forniscono dette informazioni, dati e messaggi.\n6.3 Il Cliente sarà responsabile nei confronti di Vodafone di qualsivoglia danno derivante in capo a queste ultime a causa dell\'inadempimento agli obblighi di cui ai precedente articoli 3. In particolare, il Cliente si obbliga a tenere indenne e manlevare Vodafone nonchè i soggetti a esse collegati o da esse controllate, i loro rappresentanti, dipendenti nonchè qualsivoglia loro partner da qualsiasi obbligo risarcitorio, incluse le eventuali spese legali, che possano  essere poste  a loro carico in relazione all\'utilizzo del Servizio fatto dal Cliente. Il Cliente sarà ugualmente responsabile per l\'uso del Servizio da parte di terzi ai quali avrà autorizzato l’utilizzo.\n\nArt. 7 - Proprietà intellettuale\n7.1 Tutti diritti di proprietà intellettuale ed eventuali marchi e/o segni distintivi sul Servizio sono di proprietà di Vodafone o di terzi suoi licenzianti. Il Cliente non è in alcun modo o forma autorizzato a copiare, modificare, distribuire o concedere licenze d\'uso sul Servizio.\n\nArt. 8 - Customer care e comunicazioni\n8.1 Per qualsiasi comunicazione il Cliente  può usufruire di un Servizio d\'assistenza chiamando il Servizio Clienti di Vodafone al numero 190 (raggiungibile solo dai Clienti Vodafone).\n\nArt. 9 - Legge applicabile e foro competente\n9.1 Il presente contratto è disciplinato dalla legge italiana.\n9.2 Tutte le controversie relative alla conclusione, interpretazione, esecuzione del presente contratto sono devolute alla competenza del tribunale del foro di residenza o domicilio del Cliente.\n\nArt. 10 Informativa sul trattamento dei dati personali\n10.1 Ai sensi dell\'art. 13 del D. Lgs. n. 196/2003, ti informiamo che i dati personali da te forniti e/o acquisiti presso terzi nel corso del rapporto contrattuale oppure da te indicati contestualmente alla  registrazione ai servizi scelti, nonché i dati necessari all\'erogazione di tali servizi, ivi compresi i dati di navigazione ed i dati di traffico e fatturazione, relativi alle tue utenze cellulari registrate al sito, saranno trattati, nel rispetto delle garanzie di riservatezza e delle misure di sicurezza previste dalla normativa vigente attraverso strumenti informatici, telematici e manuali, con logiche strettamente correlate alle finalita\' del trattamento.\na) Finalità del trattamento\nI dati sono trattati per le seguenti finalità:\n1) finalità strettamente connesse e necessarie alla registrazione al sito www.vodafone.it, alla fruizione dei relativi servizi, alla eventuale esecuzione del contratto. Pertanto, l\'eventuale rifiuto a fornire tali dati potrà determinare l\'impossibilità di fruire di tali servizi;\n2) finalità funzionali alla nostra attività quali: la commercializzazione di prodotti e servizi, l\'invio di materiale pubblicitario/informativo/promozionale e di aggiornamenti su iniziative ed offerte volte a premiare i Clienti, ricerche di mercato, analisi economiche e statistiche. Tali attività potranno riguardare prodotti e servizi della nostra società nonché di società del Gruppo Vodafone o di loro Partner commerciali e potranno essere eseguite, anche attraverso un sistema automatizzato di chiamata, senza l\'intervento di un operatore, messaggi di tipo MMS (Multimedia Message Service) e SMS (Short Message Service) che potrai ricevere sulle tue utenze cellulari registrate al sito, posta e telefax. Il consenso al trattamento dei dati per le predette finalità è facoltativo e potrà essere  revocato in ogni momento accedendo alla pagina \"Modifica i tuoi dati\", chiamando il nostro Servizio Clienti al numero gratuito 190, inviando un fax al numero verde 800.034.626 oppure scrivendo a Vodafone Omnitel NV c/o Casella Postale 190 - 10015 Ivrea (TO). L\'eventuale revoca del consenso effettuata tramite il sito verrà recepita anche negli altri sistemi aziendali Vodafone dedicati ai Clienti. \n3) finalità correlate all\'adempimento di obblighi previsti da normative comunitarie e nazionali, in particolare da leggi, regolamenti e provvedimenti contingibili ed urgenti e alla tutela dell\'ordine pubblico, all\'accertamento e repressione dei reati. In relazione a tali finalità potrai ricevere, anche in deroga alla normativa vigente in materia di protezione dei dati personali SMS \"Istituzionali\", i quali potranno essere inviati in casi eccezionali e di emergenza, legati a disastri, a calamità naturali o ad altre situazioni di pericolo grave ed imminente per la popolazione. Per tali trattamenti non è necessario uno specifico consenso.\nb) Categorie di soggetti ai quali i dati possono essere comunicati o che possono venirne a conoscenza in qualità di Responsabili \nPer il perseguimento delle finalità sopra indicate, Vodafone necessita di comunicare, in Italia e all\'estero, compresi paesi non appartenenti all\'Unione Europea, i Suoi dati personali a soggetti terzi appartenenti alle seguenti categorie: \n- autorità pubbliche e organi di vigilanza e controllo;\n- società del Gruppo Vodafone;\n- società controllate, controllanti e collegate;\n- soggetti che svolgono per conto di Vodafone compiti di natura tecnica ed organizzativa;\n- soggetti che effettuano servizi di acquisizione, lavorazione ed elaborazione dei dati necessari per la fruizione dei servizi per la clientela;\n- soggetti che forniscono servizi per la gestione del sistema informativo di Vodafone;\n- soggetti che svolgono attività di trasmissione, imbustamento, trasporto e smistamento delle comunicazioni dell\'interessato;\n- soggetti che svolgono attività di assistenza alla clientela (es. call center ecc.);\n- soggetti che svolgono attività di archiviazione e data entry;\n- studi e società nell\'ambito dei rapporti di assistenza e consulenza;\n- soggetti che effettuano ricerche di mercato volte a rilevare il grado di soddisfazione della clientela;\n- soggetti che svolgono attività di promozione e vendita di prodotti e servizi di Vodafone e delle altre società del gruppo di cui Vodafone e\' parte;\n- soggetti che svolgono adempimenti di controllo, revisione e certificazione delle attività poste in essere da Vodafone anche nell\'interesse dei propri clienti e utenti;\n- soggetti che prestino servizi per la gestione del rischio del credito e il controllo delle frodi (quali centri di elaborazioni dati, banche, centrali rischio, società di recupero crediti e Studi Legali);\n- altri operatori di telecomunicazioni, per la gestione dei rapporti di interconnessione e di roaming. \nI soggetti appartenenti alle categorie sopra riportate operano come distinti Titolari del trattamento o in qualità di Responsabili o Incaricati all\'uopo nominati da Vodafone. I dati personali potranno inoltre, essere conosciuti dai dipendenti/consulenti di Vodafone i quali sono stati appositamente nominati Responsabili o Incaricati del trattamento.\nVodafone, inoltre, come Società del Gruppo Vodafone Group PLC, condivide le informazioni ed i Suoi dati personali con altre società del Gruppo Vodafone, con società controllate, collegate e controllanti allo scopo di fornire i Servizi ed al fine di ottimizzare i servizi in tutto il mondo Vodafone. Le informazioni e i dati che saranno comunicati a queste società saranno trattati con gli equivalenti livelli di protezione.\nc) Ulteriori Informazioni\nI Cookies, che rappresentano una tecnologia utilizzata dai siti web per riconoscere gli utenti all\'interno di una sessione di lavoro, non vengono utilizzati né allo scopo di tracciare la navigazione degli utenti né per raccogliere i loro dati personali, ma esclusivamente per consentire la navigazione sul sito e la fruizione dei relativi servizi.\nd) Il Titolare e i Responsabili del trattamento\nIl Titolare del trattamento è Vodafone Omnitel N.V., Società soggetta a direzione e coordinamento di Vodafone Group Plc, con sede legale in Amsterdam (Olanda) e sede amministrativa e gestionale in Ivrea (TO - Italia), Via Jervis 13. . I Responsabili della banca dati dei clienti sono le funzioni aziendali che trattano tali tipologie di dati in persona del loro responsabile pro tempore.\nL\'elenco completo dei Responsabili esterni del trattamento e dei terzi ai quali i dati potranno essere comunicati, è disponibile presso i punti vendita Vodafone One, e potrà altresì essere richiesto al nostro \"Servizio Clienti 190\".\ne) Diritti dell\'Interessato\nTi ricordiamo che ai sensi dell\'art. 7 del D. Lgs. n. 196/2003 (diritto di accesso ai dati personali ed altri diritti), in ogni momento puoi aggiornare, integrare e rettificare i tuoi dati selezionando direttamente dal sito la voce \"Modifica i tuoi dati\"; puoi chiedere la cancellazione della tua registrazione al sito www.vodafone.it inviando una e-mail all\'indirizzo cancellausername@mail.vodafone.it, utilizzando l\'indirizzo di e-mail indicato in fase di registrazione e indicando lo Username per il quale si richiede la cancellazione. Per esercitare eventuali altri diritti di accesso puoi scrivere direttamente a Vodafone Omnitel NV c/o Casella Postale 190 - 10015 Ivrea (TO) oppure inviare un fax al numero verde 800.034.626.\nArticolo 7 D. Lgs.n. 196/2003 (Diritto di accesso ai dati personali ed altri diritti)\n1. L\'interessato ha diritto di ottenere la conferma dell\'esistenza o meno di dati personali che lo riguardano, anche se non ancora registrati, e la loro comunicazione in forma intelligibile.\n2. L\'interessato ha diritto di ottenere l\'indicazione:\na) dell\'origine dei dati personali;\nb) delle finalità e modalità del trattamento;\nc) della logica applicata in caso di trattamento effettuato con l\'ausilio di strumenti elettronici;\nd) degli estremi identificativi del titolare, dei responsabili e del rappresentante designato ai sensi dell\'art. 5, comma 2;\ne) dei soggetti o delle categorie di soggetti ai quali i dati personali possono essere comunicati o che possono venire a conoscenza in qualità di rappresentante designato nel territorio dello Stato, di responsabili o incaricati.\n3. L\'interessato ha diritto di ottenere:\na) l\'aggiornamento, la rettificazione ovvero, qualora vi abbia interesse, l\'integrazione dei dati;\nb) la cancellazione, la trasformazione in forma anonima o il blocco dei dati trattati in violazione di legge, compresi quelli di cui e\' necessaria la conservazione in relazione agli scopi per i quali i dati sono stati raccolti o successivamente trattati;\nc) l\'attestazione che le operazioni di cui alle lettere a) e b) sono state portate a conoscenza, anche per quanto riguarda il loro contenuto, di coloro ai quali i dati sono stati comunicati o diffusi, eccettuato il caso in cui tale adempimento si riveli impossibile o comporta un impiego di mezzi manifestamente sproporzionato rispetto al diritto tutelato.\n4. L\'interessato ha diritto di opporsi, in tutto o in parte:\na) per motivi legittimi, al trattamento dei dati personali che lo riguardano, ancorché pertinenti allo scopo della raccolta;\nb) al trattamento di dati personali che lo riguardano, previsto a fini di informazione commerciale o di invio di materiale pubblicitario o di vendita diretta ovvero per il compimento di ricerche di mercato o di comunicazione commerciale interattiva.";
            _loc_1.editable = false;
            _loc_1.setStyle("horizontalCenter", "0");
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("themeColor", 13369858);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function set appVersion(param1:String) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1484112759appVersion;
            if (_loc_2 !== param1)
            {
                this._1484112759appVersion = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "appVersion", _loc_2, param1));
            }
            return;
        }// end function

        private function restoreScroll(event:NativeWindowDisplayStateEvent) : void
        {
            if (event.afterDisplayState == NativeWindowDisplayState.NORMAL && event.type == NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE)
            {
                if (this.rssArea != null)
                {
                    this.rssArea.resumeEffect();
                }
            }
            return;
        }// end function

        public function set zoomOutWidow(param1:Zoom) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1299247999zoomOutWidow;
            if (_loc_2 !== param1)
            {
                this._1299247999zoomOutWidow = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "zoomOutWidow", _loc_2, param1));
            }
            return;
        }// end function

        private function set rss_title_3_sl(param1:Boolean) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._91898745rss_title_3_sl;
            if (_loc_2 !== param1)
            {
                this._91898745rss_title_3_sl = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rss_title_3_sl", _loc_2, param1));
            }
            return;
        }// end function

        private function _main_State3_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "Console";
            _loc_1.overrides = [this._main_AddChild2_i()];
            _loc_1.addEventListener("enterState", this.___main_State3_enterState);
            return _loc_1;
        }// end function

        private function networkErrorLogin(event:Event) : void
        {
            trace("Main - Server error during login");
            dispatchEvent(new DisplayErrorEvent("Connessione non disponibile", DisplayErrorEvent.RETRY_EVENT));
            return;
        }// end function

        public function set rss_3_enabled(param1:CheckBox) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._345717368rss_3_enabled;
            if (_loc_2 !== param1)
            {
                this._345717368rss_3_enabled = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rss_3_enabled", _loc_2, param1));
            }
            return;
        }// end function

        public function set rss_1_enabled(param1:CheckBox) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1025775738rss_1_enabled;
            if (_loc_2 !== param1)
            {
                this._1025775738rss_1_enabled = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rss_1_enabled", _loc_2, param1));
            }
            return;
        }// end function

        private function manageBannerClick(param1:BannerClick) : void
        {
            this.lastBannerClick = param1;
            this.showLoading();
            ServerBridge.getServerBridgeInstance().addEventListener(ServerBridge.SWITCH_TO_PORTAL_COMPLETE, this.manageBannerClickShareSession);
            ServerBridge.getServerBridgeInstance().switchToPortal();
            return;
        }// end function

        public function get rss_title_1() : Label
        {
            return this._466098403rss_title_1;
        }// end function

        public function get rss_title_3() : Label
        {
            return this._466098401rss_title_3;
        }// end function

        public function get rss_title_4() : Label
        {
            return this._466098400rss_title_4;
        }// end function

        private function _main_bindingsSetup() : Array
        {
            var binding:Binding;
            var result:Array;
            binding = new Binding(this, function () : UIComponent
            {
                return windowCanvas;
            }// end function
            , function (param1:UIComponent) : void
            {
                _main_AddChild1.relativeTo = param1;
                return;
            }// end function
            , "_main_AddChild1.relativeTo");
            result[0] = binding;
            binding = new Binding(this, function () : int
            {
                return TabIndexManager.INDEX_ENTER_BUTTON;
            }// end function
            , function (param1:int) : void
            {
                b_login.tabIndex = param1;
                return;
            }// end function
            , "b_login.tabIndex");
            result[1] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = _username;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                f_username.text = param1;
                return;
            }// end function
            , "f_username.text");
            result[2] = binding;
            binding = new Binding(this, function () : int
            {
                return TabIndexManager.INDEX_USERNAME_TEXT;
            }// end function
            , function (param1:int) : void
            {
                f_username.tabIndex = param1;
                return;
            }// end function
            , "f_username.tabIndex");
            result[3] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = _password;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                f_password.text = param1;
                return;
            }// end function
            , "f_password.text");
            result[4] = binding;
            binding = new Binding(this, function () : Boolean
            {
                return _hidePass;
            }// end function
            , function (param1:Boolean) : void
            {
                f_password.displayAsPassword = param1;
                return;
            }// end function
            , "f_password.displayAsPassword");
            result[5] = binding;
            binding = new Binding(this, function () : int
            {
                return TabIndexManager.INDEX_PASSWORD_TEXT;
            }// end function
            , function (param1:int) : void
            {
                f_password.tabIndex = param1;
                return;
            }// end function
            , "f_password.tabIndex");
            result[6] = binding;
            binding = new Binding(this, function () : Boolean
            {
                return _rememberMe;
            }// end function
            , function (param1:Boolean) : void
            {
                c_remember.selected = param1;
                return;
            }// end function
            , "c_remember.selected");
            result[7] = binding;
            binding = new Binding(this, function () : int
            {
                return TabIndexManager.INDEX_LOGIN_REMEMBER;
            }// end function
            , function (param1:int) : void
            {
                c_remember.tabIndex = param1;
                return;
            }// end function
            , "c_remember.tabIndex");
            result[8] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = "Versione " + appVersion;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                t_version.text = param1;
                return;
            }// end function
            , "t_version.text");
            result[9] = binding;
            binding = new Binding(this, function () : UIComponent
            {
                return windowCanvas;
            }// end function
            , function (param1:UIComponent) : void
            {
                _main_AddChild2.relativeTo = param1;
                return;
            }// end function
            , "_main_AddChild2.relativeTo");
            result[10] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = displayName;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                testata.displayName = param1;
                return;
            }// end function
            , "testata.displayName");
            result[11] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = selectedMsisdn;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                testata.selectedMsisdn = param1;
                return;
            }// end function
            , "testata.selectedMsisdn");
            result[12] = binding;
            binding = new Binding(this, function () : Array
            {
                return msisdnList;
            }// end function
            , function (param1:Array) : void
            {
                testata.msisdnList = param1;
                return;
            }// end function
            , "testata.msisdnList");
            result[13] = binding;
            binding = new Binding(this, function () : Loading
            {
                return ldr;
            }// end function
            , function (param1:Loading) : void
            {
                testata.ldr = param1;
                return;
            }// end function
            , "testata.ldr");
            result[14] = binding;
            binding = new Binding(this, function () : Loading
            {
                return ldr;
            }// end function
            , function (param1:Loading) : void
            {
                sms.loading = param1;
                return;
            }// end function
            , "sms.loading");
            result[15] = binding;
            binding = new Binding(this, function () : int
            {
                return TabIndexManager.INDEX_OPTIONS_BUTTON;
            }// end function
            , function (param1:int) : void
            {
                b_options.tabIndex = param1;
                return;
            }// end function
            , "b_options.tabIndex");
            result[16] = binding;
            binding = new Binding(this, function () : int
            {
                return TabIndexManager.INDEX_NEW_BUTTON;
            }// end function
            , function (param1:int) : void
            {
                b_new.tabIndex = param1;
                return;
            }// end function
            , "b_new.tabIndex");
            result[17] = binding;
            binding = new Binding(this, function () : UIComponent
            {
                return windowCanvas;
            }// end function
            , function (param1:UIComponent) : void
            {
                _main_AddChild3.relativeTo = param1;
                return;
            }// end function
            , "_main_AddChild3.relativeTo");
            result[18] = binding;
            binding = new Binding(this, function () : Boolean
            {
                return _rememberMe;
            }// end function
            , function (param1:Boolean) : void
            {
                optionRemember.selected = param1;
                return;
            }// end function
            , "optionRemember.selected");
            result[19] = binding;
            binding = new Binding(this, function () : Boolean
            {
                return !loginSlave;
            }// end function
            , function (param1:Boolean) : void
            {
                optionRemember.enabled = param1;
                return;
            }// end function
            , "optionRemember.enabled");
            result[20] = binding;
            binding = new Binding(this, function () : int
            {
                return TabIndexManager.INDEX_OPTIONS_REMENBER;
            }// end function
            , function (param1:int) : void
            {
                optionRemember.tabIndex = param1;
                return;
            }// end function
            , "optionRemember.tabIndex");
            result[21] = binding;
            binding = new Binding(this, function () : Boolean
            {
                return _autostart;
            }// end function
            , function (param1:Boolean) : void
            {
                optionAutostart.selected = param1;
                return;
            }// end function
            , "optionAutostart.selected");
            result[22] = binding;
            binding = new Binding(this, function () : int
            {
                return TabIndexManager.INDEX_OPTIONS_AUTO;
            }// end function
            , function (param1:int) : void
            {
                optionAutostart.tabIndex = param1;
                return;
            }// end function
            , "optionAutostart.tabIndex");
            result[23] = binding;
            binding = new Binding(this, function () : Boolean
            {
                return rss_title_1_sl;
            }// end function
            , function (param1:Boolean) : void
            {
                rss_1_enabled.selected = param1;
                return;
            }// end function
            , "rss_1_enabled.selected");
            result[24] = binding;
            binding = new Binding(this, function () : Boolean
            {
                return rss_title_1_visible;
            }// end function
            , function (param1:Boolean) : void
            {
                rss_1_enabled.visible = param1;
                return;
            }// end function
            , "rss_1_enabled.visible");
            result[25] = binding;
            binding = new Binding(this, function () : int
            {
                return TabIndexManager.INDEX_OPTIONS_FEED1;
            }// end function
            , function (param1:int) : void
            {
                rss_1_enabled.tabIndex = param1;
                return;
            }// end function
            , "rss_1_enabled.tabIndex");
            result[26] = binding;
            binding = new Binding(this, function () : Boolean
            {
                return rss_title_2_sl;
            }// end function
            , function (param1:Boolean) : void
            {
                rss_2_enabled.selected = param1;
                return;
            }// end function
            , "rss_2_enabled.selected");
            result[27] = binding;
            binding = new Binding(this, function () : Boolean
            {
                return rss_title_2_visible;
            }// end function
            , function (param1:Boolean) : void
            {
                rss_2_enabled.visible = param1;
                return;
            }// end function
            , "rss_2_enabled.visible");
            result[28] = binding;
            binding = new Binding(this, function () : int
            {
                return TabIndexManager.INDEX_OPTIONS_FEED2;
            }// end function
            , function (param1:int) : void
            {
                rss_2_enabled.tabIndex = param1;
                return;
            }// end function
            , "rss_2_enabled.tabIndex");
            result[29] = binding;
            binding = new Binding(this, function () : Boolean
            {
                return rss_title_3_sl;
            }// end function
            , function (param1:Boolean) : void
            {
                rss_3_enabled.selected = param1;
                return;
            }// end function
            , "rss_3_enabled.selected");
            result[30] = binding;
            binding = new Binding(this, function () : Boolean
            {
                return rss_title_3_visible;
            }// end function
            , function (param1:Boolean) : void
            {
                rss_3_enabled.visible = param1;
                return;
            }// end function
            , "rss_3_enabled.visible");
            result[31] = binding;
            binding = new Binding(this, function () : int
            {
                return TabIndexManager.INDEX_OPTIONS_FEED3;
            }// end function
            , function (param1:int) : void
            {
                rss_3_enabled.tabIndex = param1;
                return;
            }// end function
            , "rss_3_enabled.tabIndex");
            result[32] = binding;
            binding = new Binding(this, function () : Boolean
            {
                return rss_title_4_sl;
            }// end function
            , function (param1:Boolean) : void
            {
                rss_4_enabled.selected = param1;
                return;
            }// end function
            , "rss_4_enabled.selected");
            result[33] = binding;
            binding = new Binding(this, function () : Boolean
            {
                return rss_title_4_visible;
            }// end function
            , function (param1:Boolean) : void
            {
                rss_4_enabled.visible = param1;
                return;
            }// end function
            , "rss_4_enabled.visible");
            result[34] = binding;
            binding = new Binding(this, function () : int
            {
                return TabIndexManager.INDEX_OPTIONS_FEED4;
            }// end function
            , function (param1:int) : void
            {
                rss_4_enabled.tabIndex = param1;
                return;
            }// end function
            , "rss_4_enabled.tabIndex");
            result[35] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = rss_title_1_tx;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                rss_title_1.text = param1;
                return;
            }// end function
            , "rss_title_1.text");
            result[36] = binding;
            binding = new Binding(this, function () : Boolean
            {
                return rss_title_1_visible;
            }// end function
            , function (param1:Boolean) : void
            {
                rss_title_1.visible = param1;
                return;
            }// end function
            , "rss_title_1.visible");
            result[37] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = rss_title_2_tx;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                rss_title_2.text = param1;
                return;
            }// end function
            , "rss_title_2.text");
            result[38] = binding;
            binding = new Binding(this, function () : Boolean
            {
                return rss_title_2_visible;
            }// end function
            , function (param1:Boolean) : void
            {
                rss_title_2.visible = param1;
                return;
            }// end function
            , "rss_title_2.visible");
            result[39] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = rss_title_3_tx;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                rss_title_3.text = param1;
                return;
            }// end function
            , "rss_title_3.text");
            result[40] = binding;
            binding = new Binding(this, function () : Boolean
            {
                return rss_title_3_visible;
            }// end function
            , function (param1:Boolean) : void
            {
                rss_title_3.visible = param1;
                return;
            }// end function
            , "rss_title_3.visible");
            result[41] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = rss_title_4_tx;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                rss_title_4.text = param1;
                return;
            }// end function
            , "rss_title_4.text");
            result[42] = binding;
            binding = new Binding(this, function () : Boolean
            {
                return rss_title_4_visible;
            }// end function
            , function (param1:Boolean) : void
            {
                rss_title_4.visible = param1;
                return;
            }// end function
            , "rss_title_4.visible");
            result[43] = binding;
            binding = new Binding(this, function () : int
            {
                return TabIndexManager.INDEX_OPTIONS_SAVE;
            }// end function
            , function (param1:int) : void
            {
                _main_Button4.tabIndex = param1;
                return;
            }// end function
            , "_main_Button4.tabIndex");
            result[44] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = "Versione " + appVersion;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                _main_Label13.text = param1;
                return;
            }// end function
            , "_main_Label13.text");
            result[45] = binding;
            binding = new Binding(this, function () : UIComponent
            {
                return windowCanvas;
            }// end function
            , function (param1:UIComponent) : void
            {
                _main_AddChild4.relativeTo = param1;
                return;
            }// end function
            , "_main_AddChild4.relativeTo");
            result[46] = binding;
            binding = new Binding(this, function () : int
            {
                return TabIndexManager.INDEX_TERMS_CHECK;
            }// end function
            , function (param1:int) : void
            {
                check_termini.tabIndex = param1;
                return;
            }// end function
            , "check_termini.tabIndex");
            result[47] = binding;
            binding = new Binding(this, function () : int
            {
                return TabIndexManager.INDEX_TERMS_OK;
            }// end function
            , function (param1:int) : void
            {
                bottone_termini.tabIndex = param1;
                return;
            }// end function
            , "bottone_termini.tabIndex");
            result[48] = binding;
            binding = new Binding(this, function () : Object
            {
                return globalCanvas;
            }// end function
            , function (param1:Object) : void
            {
                zoomOutWidow.target = param1;
                return;
            }// end function
            , "zoomOutWidow.target");
            result[49] = binding;
            binding = new Binding(this, function () : Object
            {
                return globalCanvas;
            }// end function
            , function (param1:Object) : void
            {
                consoleOut.target = param1;
                return;
            }// end function
            , "consoleOut.target");
            result[50] = binding;
            binding = new Binding(this, function () : Object
            {
                return globalCanvas;
            }// end function
            , function (param1:Object) : void
            {
                optionsOut.target = param1;
                return;
            }// end function
            , "optionsOut.target");
            result[51] = binding;
            binding = new Binding(this, function () : Object
            {
                return globalCanvas;
            }// end function
            , function (param1:Object) : void
            {
                showZoom.target = param1;
                return;
            }// end function
            , "showZoom.target");
            result[52] = binding;
            binding = new Binding(this, function () : Array
            {
                return [wcanvas, wcanvas_console];
            }// end function
            , function (param1:Array) : void
            {
                _main_Sequence1.targets = param1;
                return;
            }// end function
            , "_main_Sequence1.targets");
            result[53] = binding;
            binding = new Binding(this, function () : Object
            {
                return wcanvas;
            }// end function
            , function (param1:Object) : void
            {
                _main_Fade3.target = param1;
                return;
            }// end function
            , "_main_Fade3.target");
            result[54] = binding;
            binding = new Binding(this, function () : Object
            {
                return wcanvas_console;
            }// end function
            , function (param1:Object) : void
            {
                _main_Fade4.target = param1;
                return;
            }// end function
            , "_main_Fade4.target");
            result[55] = binding;
            binding = new Binding(this, function () : Array
            {
                return [wcanvasTerms, wcanvas];
            }// end function
            , function (param1:Array) : void
            {
                _main_Sequence2.targets = param1;
                return;
            }// end function
            , "_main_Sequence2.targets");
            result[56] = binding;
            binding = new Binding(this, function () : Object
            {
                return wcanvasTerms;
            }// end function
            , function (param1:Object) : void
            {
                _main_Fade5.target = param1;
                return;
            }// end function
            , "_main_Fade5.target");
            result[57] = binding;
            binding = new Binding(this, function () : Object
            {
                return wcanvas;
            }// end function
            , function (param1:Object) : void
            {
                _main_Fade6.target = param1;
                return;
            }// end function
            , "_main_Fade6.target");
            result[58] = binding;
            binding = new Binding(this, function () : Object
            {
                return globalCanvas;
            }// end function
            , function (param1:Object) : void
            {
                _main_Flip3.target = param1;
                return;
            }// end function
            , "_main_Flip3.target");
            result[59] = binding;
            binding = new Binding(this, function () : Object
            {
                return globalCanvas;
            }// end function
            , function (param1:Object) : void
            {
                _main_Flip4.target = param1;
                return;
            }// end function
            , "_main_Flip4.target");
            result[60] = binding;
            binding = new Binding(this, function () : Object
            {
                return globalCanvas;
            }// end function
            , function (param1:Object) : void
            {
                _main_Flip5.target = param1;
                return;
            }// end function
            , "_main_Flip5.target");
            result[61] = binding;
            binding = new Binding(this, function () : Object
            {
                return globalCanvas;
            }// end function
            , function (param1:Object) : void
            {
                _main_Flip6.target = param1;
                return;
            }// end function
            , "_main_Flip6.target");
            result[62] = binding;
            return result;
        }// end function

        private function enableTab(event:Event) : void
        {
            this.tabEnabled = true;
            this.tabChildren = true;
            return;
        }// end function

        public function get optionAutostart() : CheckBox
        {
            return this._1689282334optionAutostart;
        }// end function

        public function set msisdnList(param1:Array) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1381897832msisdnList;
            if (_loc_2 !== param1)
            {
                this._1381897832msisdnList = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "msisdnList", _loc_2, param1));
            }
            return;
        }// end function

        public function get fadeOut() : Fade
        {
            return this._1091436750fadeOut;
        }// end function

        private function loginOk(event:Event) : void
        {
            ServerBridge.getServerBridgeInstance().removeEventListener(ServerBridge.NETWORK_ERROR, this.networkErrorLogin);
            ServerBridge.getServerBridgeInstance().addEventListener(ServerBridge.NETWORK_ERROR, this.networkError);
            this.updateRememberMe();
            this.loginServer.startWithCredentials(this._username, this._password);
            this.displayName = ServerBridge.getServerBridgeInstance().displayName;
            this.selectedMsisdn = ServerBridge.getServerBridgeInstance().currentMsisdn;
            this.msisdnList = ServerBridge.getServerBridgeInstance().msisdnList;
            this.hideLoading();
            currentState = "Console";
            ServerBridge.getServerBridgeInstance().updateCredito();
            ServerBridge.getServerBridgeInstance().updateOmnione();
            this.rssArea.manageScrolling();
            return;
        }// end function

        public function __f_username_enter(event:FlexEvent) : void
        {
            this.f_password.setFocus();
            return;
        }// end function

        private function get rss_title_2_sl() : Boolean
        {
            return this._91868954rss_title_2_sl;
        }// end function

        private function clickSuNew() : void
        {
            navigateToURL(new URLRequest(RemotePreferences.getInstance().getValue("blinkDownloadLink")));
            return;
        }// end function

        public function get rss_title_2() : Label
        {
            return this._466098402rss_title_2;
        }// end function

        private function stopTryingCommunicating(event:Event) : void
        {
            trace("*** Communication with browser failed!, restoring ***");
            ServerBridge.getServerBridgeInstance().sessionExpired();
            return;
        }// end function

        private function set rss_title_3_tx(param1:String) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._91898788rss_title_3_tx;
            if (_loc_2 !== param1)
            {
                this._91898788rss_title_3_tx = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rss_title_3_tx", _loc_2, param1));
            }
            return;
        }// end function

        private function _main_State2_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "Login";
            _loc_1.overrides = [this._main_AddChild1_i()];
            _loc_1.addEventListener("enterState", this.___main_State2_enterState);
            return _loc_1;
        }// end function

        public function ___main_Label3_click(event:MouseEvent) : void
        {
            this.goSite("help");
            return;
        }// end function

        private function get rss_title_3_visible() : Boolean
        {
            return this._436989778rss_title_3_visible;
        }// end function

        public function startMove(event:MouseEvent) : void
        {
            if (!event.target.hasOwnProperty("className") || event.target.className != "UITextField" && event.target.className != "ScrollThumb" && event.target.className != "Button" || event.target.className == "UITextField" && !event.target.selectable)
            {
                stage.nativeWindow.startMove();
            }
            return;
        }// end function

        private function get rss_title_2_tx() : String
        {
            return this._91868997rss_title_2_tx;
        }// end function

        public function set wcanvas_console(param1:Canvas) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1560317351wcanvas_console;
            if (_loc_2 !== param1)
            {
                this._1560317351wcanvas_console = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "wcanvas_console", _loc_2, param1));
            }
            return;
        }// end function

        public function __testata_msisdnUpdated(event:Event) : void
        {
            this.switchMsisdn();
            return;
        }// end function

        private function _main_Transition7_c() : Transition
        {
            var _loc_1:* = new Transition();
            _loc_1.fromState = "Options";
            _loc_1.toState = "Console";
            _loc_1.effect = this._main_Flip6_i();
            return _loc_1;
        }// end function

        public function get tt_new() : Canvas
        {
            return this._863918239tt_new;
        }// end function

        public function set t_logout(param1:Label) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1913677749t_logout;
            if (_loc_2 !== param1)
            {
                this._1913677749t_logout = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "t_logout", _loc_2, param1));
            }
            return;
        }// end function

        public function get infoConto() : Infoconto
        {
            return this._1205641071infoConto;
        }// end function

        public function get appVersion() : String
        {
            return this._1484112759appVersion;
        }// end function

        private function setOptionsSkin() : void
        {
            switch(this.SKIN_TYPE)
            {
                case this.VODAFONE_SKIN:
                {
                    this.skinCanvas.currentState = "vodafone_options_skin";
                    this.t_help.y = 324;
                    this.b_help.y = 330;
                    this.t_logout.y = 324;
                    this.b_logout.y = 330;
                    break;
                }
                case this.ZEROLIMITS_SKIN:
                {
                    this.skinCanvas.currentState = "zerolimits_options_skin";
                    this.t_help.y = 352;
                    this.b_help.y = 358;
                    this.t_logout.y = 352;
                    this.b_logout.y = 358;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function showLoading() : void
        {
            if (this.ldr == null)
            {
                this.ldr = new Loading();
            }
            this.ldr.alpha = 0;
            this.ldr.y = 58;
            this.globalCanvas.addChild(this.ldr);
            this.ldr.addEventListener(MouseEvent.MOUSE_DOWN, this.startMove);
            this.ldr.addEventListener(MouseEvent.MOUSE_UP, this.savePosition);
            this.fadeIn.target = this.ldr;
            this.fadeIn.play();
            return;
        }// end function

        private function get rss_title_3_sl() : Boolean
        {
            return this._91898745rss_title_3_sl;
        }// end function

        public function set b_options(param1:Button) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._71871425b_options;
            if (_loc_2 !== param1)
            {
                this._71871425b_options = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "b_options", _loc_2, param1));
            }
            return;
        }// end function

        private function _main_Text6_c() : Text
        {
            var _loc_1:* = new Text();
            _loc_1.x = 10;
            _loc_1.y = 126;
            _loc_1.text = "Scegli i feed RSS vodafone.it da visualizzare:";
            _loc_1.width = 178;
            _loc_1.selectable = false;
            _loc_1.setStyle("fontSize", 12);
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontWeight", "bold");
            _loc_1.setStyle("color", 3355443);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function onUpdate(event:UpdateEvent) : void
        {
            var _loc_2:* = Number(RemotePreferences.getInstance().getValue("update_days"));
            var _loc_3:* = new Date();
            var _loc_4:* = _loc_3.time - 1000 * 60 * 60 * 24 * _loc_2;
            if (LocalPreferences.getInstance().storageGet("lastcheck") == null || Number(LocalPreferences.getInstance().storageGet("lastcheck")) < _loc_4)
            {
                trace("Main - checking update");
                this.appUpdater.checkNow();
                LocalPreferences.getInstance().storageSet("lastcheck", _loc_4.toString());
            }
            return;
        }// end function

        private function _main_State1_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "Startup";
            _loc_1.addEventListener("enterState", this.___main_State1_enterState);
            return _loc_1;
        }// end function

        private function disableTab(event:Event) : void
        {
            this.tabEnabled = false;
            this.tabChildren = false;
            return;
        }// end function

        public function get zoomOutWidow() : Zoom
        {
            return this._1299247999zoomOutWidow;
        }// end function

        override public function initialize() : void
        {
            var target:main;
            var watcherSetupUtilClass:Object;
            .mx_internal::setDocumentDescriptor(this._documentDescriptor_);
            var bindings:* = this._main_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_mainWatcherSetupUtil");
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

        public function __t_help_click(event:MouseEvent) : void
        {
            this.goSite("help");
            return;
        }// end function

        private function _main_Sms1_i() : Sms
        {
            var _loc_1:* = new Sms();
            this.sms = _loc_1;
            _loc_1.x = 3;
            _loc_1.y = 159;
            _loc_1.addEventListener("sms_sending", this.__sms_sms_sending);
            _loc_1.addEventListener("sms_sending_complete", this.__sms_sms_sending_complete);
            _loc_1.id = "sms";
            BindingManager.executeBindings(this, "sms", this.sms);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function set check_termini(param1:CheckBox) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1010307135check_termini;
            if (_loc_2 !== param1)
            {
                this._1010307135check_termini = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "check_termini", _loc_2, param1));
            }
            return;
        }// end function

        private function _main_Transition6_c() : Transition
        {
            var _loc_1:* = new Transition();
            _loc_1.fromState = "Console";
            _loc_1.toState = "Options";
            _loc_1.effect = this._main_Flip5_i();
            return _loc_1;
        }// end function

        private function set _hidePass(param1:Boolean) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1683524142_hidePass;
            if (_loc_2 !== param1)
            {
                this._1683524142_hidePass = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_hidePass", _loc_2, param1));
            }
            return;
        }// end function

        public function __check_termini_click(event:MouseEvent) : void
        {
            this.bottone_termini.enabled = this.check_termini.selected;
            return;
        }// end function

        private function get rss_title_3_tx() : String
        {
            return this._91898788rss_title_3_tx;
        }// end function

        public function set optionsOut(param1:Flip) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1374471120optionsOut;
            if (_loc_2 !== param1)
            {
                this._1374471120optionsOut = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "optionsOut", _loc_2, param1));
            }
            return;
        }// end function

        private function set rss_title_4_sl(param1:Boolean) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._91928536rss_title_4_sl;
            if (_loc_2 !== param1)
            {
                this._91928536rss_title_4_sl = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rss_title_4_sl", _loc_2, param1));
            }
            return;
        }// end function

        public function __b_options_click(event:MouseEvent) : void
        {
            this.switchToOptions(false);
            return;
        }// end function

        public function get rss_1_enabled() : CheckBox
        {
            return this._1025775738rss_1_enabled;
        }// end function

        public function get t_logout() : Label
        {
            return this._1913677749t_logout;
        }// end function

        public function __optionsOut_effectEnd(event:EffectEvent) : void
        {
            this.globalCanvas.alpha = 0;
            currentState = "Console";
            return;
        }// end function

        public function __f_password_click(event:MouseEvent) : void
        {
            this.cleanField("password");
            return;
        }// end function

        public function set buttonGlow(param1:Glow) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._358164447buttonGlow;
            if (_loc_2 !== param1)
            {
                this._358164447buttonGlow = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buttonGlow", _loc_2, param1));
            }
            return;
        }// end function

        public function get b_options() : Button
        {
            return this._71871425b_options;
        }// end function

        public function set saldoPunti(param1:SaldoPunti) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._702682069saldoPunti;
            if (_loc_2 !== param1)
            {
                this._702682069saldoPunti = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "saldoPunti", _loc_2, param1));
            }
            return;
        }// end function

        private function _main_Text5_c() : Text
        {
            var _loc_1:* = new Text();
            _loc_1.text = "Scopri le novità ";
            _loc_1.selectable = false;
            _loc_1.x = 6;
            _loc_1.setStyle("fontSize", 11);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function get saldoPunti() : SaldoPunti
        {
            return this._702682069saldoPunti;
        }// end function

        public function get optionsOut() : Flip
        {
            return this._1374471120optionsOut;
        }// end function

        private function get rss_title_4_sl() : Boolean
        {
            return this._91928536rss_title_4_sl;
        }// end function

        public function get check_termini() : CheckBox
        {
            return this._1010307135check_termini;
        }// end function

        public function ___main_Flip5_effectEnd(event:EffectEvent) : void
        {
            this.globalCanvas.alpha = 1;
            return;
        }// end function

        public function set loginSlave(param1:Boolean) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1758954514loginSlave;
            if (_loc_2 !== param1)
            {
                this._1758954514loginSlave = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "loginSlave", _loc_2, param1));
            }
            return;
        }// end function

        private function _main_Fade6_i() : Fade
        {
            var _loc_1:* = new Fade();
            this._main_Fade6 = _loc_1;
            _loc_1.duration = 500;
            _loc_1.alphaFrom = 0;
            _loc_1.alphaTo = 1;
            BindingManager.executeBindings(this, "_main_Fade6", this._main_Fade6);
            return _loc_1;
        }// end function

        public function get buttonGlow() : Glow
        {
            return this._358164447buttonGlow;
        }// end function

        private function _main_bindingExprs() : void
        {
            var _loc_1:* = undefined;
            _loc_1 = this.windowCanvas;
            _loc_1 = TabIndexManager.INDEX_ENTER_BUTTON;
            _loc_1 = this._username;
            _loc_1 = TabIndexManager.INDEX_USERNAME_TEXT;
            _loc_1 = this._password;
            _loc_1 = this._hidePass;
            _loc_1 = TabIndexManager.INDEX_PASSWORD_TEXT;
            _loc_1 = this._rememberMe;
            _loc_1 = TabIndexManager.INDEX_LOGIN_REMEMBER;
            _loc_1 = "Versione " + this.appVersion;
            _loc_1 = this.windowCanvas;
            _loc_1 = this.displayName;
            _loc_1 = this.selectedMsisdn;
            _loc_1 = this.msisdnList;
            _loc_1 = this.ldr;
            _loc_1 = this.ldr;
            _loc_1 = TabIndexManager.INDEX_OPTIONS_BUTTON;
            _loc_1 = TabIndexManager.INDEX_NEW_BUTTON;
            _loc_1 = this.windowCanvas;
            _loc_1 = this._rememberMe;
            _loc_1 = !this.loginSlave;
            _loc_1 = TabIndexManager.INDEX_OPTIONS_REMENBER;
            _loc_1 = this._autostart;
            _loc_1 = TabIndexManager.INDEX_OPTIONS_AUTO;
            _loc_1 = this.rss_title_1_sl;
            _loc_1 = this.rss_title_1_visible;
            _loc_1 = TabIndexManager.INDEX_OPTIONS_FEED1;
            _loc_1 = this.rss_title_2_sl;
            _loc_1 = this.rss_title_2_visible;
            _loc_1 = TabIndexManager.INDEX_OPTIONS_FEED2;
            _loc_1 = this.rss_title_3_sl;
            _loc_1 = this.rss_title_3_visible;
            _loc_1 = TabIndexManager.INDEX_OPTIONS_FEED3;
            _loc_1 = this.rss_title_4_sl;
            _loc_1 = this.rss_title_4_visible;
            _loc_1 = TabIndexManager.INDEX_OPTIONS_FEED4;
            _loc_1 = this.rss_title_1_tx;
            _loc_1 = this.rss_title_1_visible;
            _loc_1 = this.rss_title_2_tx;
            _loc_1 = this.rss_title_2_visible;
            _loc_1 = this.rss_title_3_tx;
            _loc_1 = this.rss_title_3_visible;
            _loc_1 = this.rss_title_4_tx;
            _loc_1 = this.rss_title_4_visible;
            _loc_1 = TabIndexManager.INDEX_OPTIONS_SAVE;
            _loc_1 = "Versione " + this.appVersion;
            _loc_1 = this.windowCanvas;
            _loc_1 = TabIndexManager.INDEX_TERMS_CHECK;
            _loc_1 = TabIndexManager.INDEX_TERMS_OK;
            _loc_1 = this.globalCanvas;
            _loc_1 = this.globalCanvas;
            _loc_1 = this.globalCanvas;
            _loc_1 = this.globalCanvas;
            _loc_1 = [this.wcanvas, this.wcanvas_console];
            _loc_1 = this.wcanvas;
            _loc_1 = this.wcanvas_console;
            _loc_1 = [this.wcanvasTerms, this.wcanvas];
            _loc_1 = this.wcanvasTerms;
            _loc_1 = this.wcanvas;
            _loc_1 = this.globalCanvas;
            _loc_1 = this.globalCanvas;
            _loc_1 = this.globalCanvas;
            _loc_1 = this.globalCanvas;
            return;
        }// end function

        public function __b_new_toolTipCreate(event:ToolTipEvent) : void
        {
            var _loc_2:* = new CustomToolTip();
            _loc_2.text = CustomToolTip.NEW_TT;
            event.toolTip = _loc_2;
            return;
        }// end function

        private function _main_Transition5_c() : Transition
        {
            var _loc_1:* = new Transition();
            _loc_1.fromState = "Console";
            _loc_1.toState = "Login";
            _loc_1.effect = this._main_Flip4_i();
            return _loc_1;
        }// end function

        private function childDownOutside(event:MouseEvent) : void
        {
            var _loc_2:Boolean = false;
            var _loc_3:Boolean = false;
            var _loc_4:Boolean = false;
            var _loc_5:Boolean = false;
            if (this.currentState == "Console")
            {
                _loc_2 = this.sms.ultimi_numeri_component.contains(event.target as DisplayObject);
                _loc_3 = this.sms.rubrica_component.contains(event.target as DisplayObject);
                _loc_4 = this.sms.contains(event.target as DisplayObject);
                _loc_5 = this.sms.transparence_canvass.contains(event.target as DisplayObject);
                if (!(_loc_3 || _loc_2 || _loc_4 && !_loc_5))
                {
                    this.sms.rubrica_component.close();
                    this.sms.ultimi_numeri_component.close();
                }
            }
            return;
        }// end function

        private function set _password(param1:String) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._1307503610_password;
            if (_loc_2 !== param1)
            {
                this._1307503610_password = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_password", _loc_2, param1));
            }
            return;
        }// end function

        public function get loginSlave() : Boolean
        {
            return this._1758954514loginSlave;
        }// end function

        public function ___main_State2_enterState(event:FlexEvent) : void
        {
            this.setBaseSkin();
            return;
        }// end function

        private function get _password() : String
        {
            return this._1307503610_password;
        }// end function

        private function set ldr(param1:Loading) : void
        {
            var _loc_2:Object = null;
            _loc_2 = this._107002ldr;
            if (_loc_2 !== param1)
            {
                this._107002ldr = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ldr", _loc_2, param1));
            }
            return;
        }// end function

        private function _main_Rss1_i() : Rss
        {
            var _loc_1:* = new Rss();
            this.rssArea = _loc_1;
            _loc_1.x = 0;
            _loc_1.setStyle("bottom", "40");
            _loc_1.id = "rssArea";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
        {
            _watcherSetupUtil = param1;
            return;
        }// end function

    }
}
