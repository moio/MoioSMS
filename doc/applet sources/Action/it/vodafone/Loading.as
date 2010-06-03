package it.vodafone
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import mx.binding.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.states.*;
    import mx.styles.*;

    public class Loading extends Canvas implements IBindingClient
    {
        private var _550778329canvas1:Canvas;
        private var _241352512button2:Button;
        private var _embed_mxml_______img_v1_indietro_over_png_120939871:Class;
        private var _110256292text1:Text;
        private var _241352511button1:Button;
        private var _embed_mxml_______img_v1_indietro_png_492784317:Class;
        private var _241352510button0:Button;
        var _bindingsByDestination:Object;
        private var _embed_mxml_______img_v1_chiudi_over_png_1529219873:Class;
        private var _110256294text3:Text;
        public var _Loading_RemoveChild1:RemoveChild;
        public var _Loading_RemoveChild2:RemoveChild;
        private var _244391974testoErrore:String = "";
        public var _Loading_AddChild2:AddChild;
        public var _Loading_AddChild3:AddChild;
        public var _Loading_AddChild4:AddChild;
        public var _Loading_AddChild1:AddChild;
        public const ZEROLIMITS_SKIN:String = "zerolimits_skin";
        public var _Loading_AddChild5:AddChild;
        public var _Loading_SetStyle1:SetStyle;
        public var _Loading_SetStyle2:SetStyle;
        public var _Loading_SetStyle3:SetStyle;
        var _watchers:Array;
        private var _110256293text2:Text;
        public const SKIN_TYPE:String = "vodafone_skin";
        private var _embed_mxml_______img_v1_chiudi_png_31337789:Class;
        var _bindingsBeginWithWord:Object;
        private var _embed_mxml_______img_v1_riprova_png_23985567:Class;
        private var _embed_mxml_______img_v1_riprova_over_png_1077833397:Class;
        public const VODAFONE_SKIN:String = "vodafone_skin";
        var _bindings:Array;
        private var _documentDescriptor_:UIComponentDescriptor;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public function Loading()
        {
            this._documentDescriptor_ = new UIComponentDescriptor({type:Canvas, propertiesFactory:function () : Object
            {
                return {width:268, height:290, childDescriptors:[new UIComponentDescriptor({type:Canvas, id:"canvas1", events:{initialize:"__canvas1_initialize"}, stylesFactory:function () : void
                {
                    this.backgroundColor = 3355443;
                    this.backgroundAlpha = 0.95;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {horizontalScrollPolicy:"off", height:272, y:9, width:248, x:10, childDescriptors:[new UIComponentDescriptor({type:Text, id:"text2", stylesFactory:function () : void
                    {
                        this.fontSize = 12;
                        this.fontWeight = "bold";
                        this.color = 16777215;
                        this.fontFamily = "defFont";
                        return;
                    }// end function
                    , propertiesFactory:function () : Object
                    {
                        return {text:"Loading...", selectable:false, width:103, height:27, x:94, y:125};
                    }// end function
                    })]};
                }// end function
                })]};
            }// end function
            });
            this._embed_mxml_______img_v1_chiudi_over_png_1529219873 = Loading__embed_mxml_______img_v1_chiudi_over_png_1529219873;
            this._embed_mxml_______img_v1_chiudi_png_31337789 = Loading__embed_mxml_______img_v1_chiudi_png_31337789;
            this._embed_mxml_______img_v1_indietro_over_png_120939871 = Loading__embed_mxml_______img_v1_indietro_over_png_120939871;
            this._embed_mxml_______img_v1_indietro_png_492784317 = Loading__embed_mxml_______img_v1_indietro_png_492784317;
            this._embed_mxml_______img_v1_riprova_over_png_1077833397 = Loading__embed_mxml_______img_v1_riprova_over_png_1077833397;
            this._embed_mxml_______img_v1_riprova_png_23985567 = Loading__embed_mxml_______img_v1_riprova_png_23985567;
            this._bindings = [];
            this._watchers = [];
            this._bindingsByDestination = {};
            this._bindingsBeginWithWord = {};
            mx_internal::_document = this;
            this.width = 268;
            this.height = 290;
            this.states = [this._Loading_State1_c(), this._Loading_State2_c(), this._Loading_State3_c()];
            return;
        }// end function

        public function clickRetry() : void
        {
            dispatchEvent(new Event("user_retry"));
            return;
        }// end function

        private function _Loading_AddChild3_i() : AddChild
        {
            var _loc_1:* = new AddChild();
            this._Loading_AddChild3 = _loc_1;
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._Loading_Text2_i);
            BindingManager.executeBindings(this, "_Loading_AddChild3", this._Loading_AddChild3);
            return _loc_1;
        }// end function

        private function _Loading_Text1_i() : Text
        {
            var _loc_1:* = new Text();
            this.text1 = _loc_1;
            _loc_1.width = 200;
            _loc_1.selectable = false;
            _loc_1.setStyle("horizontalCenter", "0");
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 11);
            _loc_1.setStyle("color", 16777215);
            _loc_1.setStyle("textAlign", "center");
            _loc_1.setStyle("bottom", "119");
            _loc_1.id = "text1";
            BindingManager.executeBindings(this, "text1", this.text1);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _Loading_SetStyle3_i() : SetStyle
        {
            var _loc_1:* = new SetStyle();
            this._Loading_SetStyle3 = _loc_1;
            _loc_1.name = "bottom";
            _loc_1.value = 11;
            BindingManager.executeBindings(this, "_Loading_SetStyle3", this._Loading_SetStyle3);
            return _loc_1;
        }// end function

        private function _Loading_Button2_i() : Button
        {
            var _loc_1:* = new Button();
            this.button2 = _loc_1;
            _loc_1.setStyle("horizontalCenter", "0");
            _loc_1.setStyle("verticalCenter", "35");
            _loc_1.setStyle("upSkin", this._embed_mxml_______img_v1_chiudi_png_31337789);
            _loc_1.setStyle("downSkin", this._embed_mxml_______img_v1_chiudi_png_31337789);
            _loc_1.setStyle("overSkin", this._embed_mxml_______img_v1_chiudi_over_png_1529219873);
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.addEventListener("click", this.__button2_click);
            _loc_1.id = "button2";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function get button0() : Button
        {
            return this._241352510button0;
        }// end function

        private function _Loading_AddChild2_i() : AddChild
        {
            var _loc_1:* = new AddChild();
            this._Loading_AddChild2 = _loc_1;
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._Loading_Button1_i);
            BindingManager.executeBindings(this, "_Loading_AddChild2", this._Loading_AddChild2);
            return _loc_1;
        }// end function

        public function get button1() : Button
        {
            return this._241352511button1;
        }// end function

        public function get button2() : Button
        {
            return this._241352512button2;
        }// end function

        public function set text1(param1:Text) : void
        {
            var _loc_2:* = this._110256292text1;
            if (_loc_2 !== param1)
            {
                this._110256292text1 = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "text1", _loc_2, param1));
            }
            return;
        }// end function

        private function _Loading_SetStyle2_i() : SetStyle
        {
            var _loc_1:* = new SetStyle();
            this._Loading_SetStyle2 = _loc_1;
            _loc_1.name = "fontWeight";
            _loc_1.value = "normal";
            BindingManager.executeBindings(this, "_Loading_SetStyle2", this._Loading_SetStyle2);
            return _loc_1;
        }// end function

        public function set text3(param1:Text) : void
        {
            var _loc_2:* = this._110256294text3;
            if (_loc_2 !== param1)
            {
                this._110256294text3 = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "text3", _loc_2, param1));
            }
            return;
        }// end function

        public function clickClose() : void
        {
            dispatchEvent(new Event("exit_widget"));
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

        public function errore(param1:String, param2:int = 1) : void
        {
            this.testoErrore = param1;
            if (param2 == 2)
            {
                currentState = "errore_retry";
            }
            else if (param2 == 3)
            {
                currentState = "errore_blacklist";
            }
            else
            {
                currentState = "errore";
            }
            return;
        }// end function

        private function _Loading_RemoveChild2_i() : RemoveChild
        {
            var _loc_1:* = new RemoveChild();
            this._Loading_RemoveChild2 = _loc_1;
            BindingManager.executeBindings(this, "_Loading_RemoveChild2", this._Loading_RemoveChild2);
            return _loc_1;
        }// end function

        private function _Loading_Button1_i() : Button
        {
            var _loc_1:* = new Button();
            this.button1 = _loc_1;
            _loc_1.setStyle("horizontalCenter", "0");
            _loc_1.setStyle("verticalCenter", "35");
            _loc_1.setStyle("upSkin", this._embed_mxml_______img_v1_indietro_png_492784317);
            _loc_1.setStyle("downSkin", this._embed_mxml_______img_v1_indietro_png_492784317);
            _loc_1.setStyle("overSkin", this._embed_mxml_______img_v1_indietro_over_png_120939871);
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.addEventListener("click", this.__button1_click);
            _loc_1.id = "button1";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _Loading_State3_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "errore_retry";
            _loc_1.basedOn = "errore";
            _loc_1.overrides = [this._Loading_SetStyle1_i(), this._Loading_AddChild5_i(), this._Loading_SetStyle2_i(), this._Loading_SetStyle3_i()];
            return _loc_1;
        }// end function

        public function __button0_click(event:MouseEvent) : void
        {
            this.clickRetry();
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

        public function set button2(param1:Button) : void
        {
            var _loc_2:* = this._241352512button2;
            if (_loc_2 !== param1)
            {
                this._241352512button2 = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "button2", _loc_2, param1));
            }
            return;
        }// end function

        private function _Loading_AddChild5_i() : AddChild
        {
            var _loc_1:* = new AddChild();
            this._Loading_AddChild5 = _loc_1;
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._Loading_Button3_i);
            BindingManager.executeBindings(this, "_Loading_AddChild5", this._Loading_AddChild5);
            return _loc_1;
        }// end function

        public function set button0(param1:Button) : void
        {
            var _loc_2:* = this._241352510button0;
            if (_loc_2 !== param1)
            {
                this._241352510button0 = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "button0", _loc_2, param1));
            }
            return;
        }// end function

        public function clickOk() : void
        {
            dispatchEvent(new Event("user_ok"));
            return;
        }// end function

        private function _Loading_AddChild1_i() : AddChild
        {
            var _loc_1:* = new AddChild();
            this._Loading_AddChild1 = _loc_1;
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._Loading_Text1_i);
            BindingManager.executeBindings(this, "_Loading_AddChild1", this._Loading_AddChild1);
            return _loc_1;
        }// end function

        private function _Loading_SetStyle1_i() : SetStyle
        {
            var _loc_1:* = new SetStyle();
            this._Loading_SetStyle1 = _loc_1;
            _loc_1.name = "horizontalCenter";
            _loc_1.value = -45;
            BindingManager.executeBindings(this, "_Loading_SetStyle1", this._Loading_SetStyle1);
            return _loc_1;
        }// end function

        override public function initialize() : void
        {
            var target:Loading;
            var watcherSetupUtilClass:Object;
            .mx_internal::setDocumentDescriptor(this._documentDescriptor_);
            var bindings:* = this._Loading_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_it_vodafone_LoadingWatcherSetupUtil");
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

        public function __canvas1_initialize(event:FlexEvent) : void
        {
            this.setCanvasSkin();
            return;
        }// end function

        public function get text1() : Text
        {
            return this._110256292text1;
        }// end function

        private function _Loading_RemoveChild1_i() : RemoveChild
        {
            var _loc_1:* = new RemoveChild();
            this._Loading_RemoveChild1 = _loc_1;
            BindingManager.executeBindings(this, "_Loading_RemoveChild1", this._Loading_RemoveChild1);
            return _loc_1;
        }// end function

        public function get text3() : Text
        {
            return this._110256294text3;
        }// end function

        private function _Loading_State2_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "errore_blacklist";
            _loc_1.overrides = [this._Loading_AddChild3_i(), this._Loading_AddChild4_i(), this._Loading_RemoveChild2_i()];
            return _loc_1;
        }// end function

        public function get text2() : Text
        {
            return this._110256293text2;
        }// end function

        private function _Loading_bindingsSetup() : Array
        {
            var binding:Binding;
            var result:Array;
            binding = new Binding(this, function () : UIComponent
            {
                return canvas1;
            }// end function
            , function (param1:UIComponent) : void
            {
                _Loading_AddChild1.relativeTo = param1;
                return;
            }// end function
            , "_Loading_AddChild1.relativeTo");
            result[0] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = testoErrore;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                text1.text = param1;
                return;
            }// end function
            , "text1.text");
            result[1] = binding;
            binding = new Binding(this, function () : UIComponent
            {
                return canvas1;
            }// end function
            , function (param1:UIComponent) : void
            {
                _Loading_AddChild2.relativeTo = param1;
                return;
            }// end function
            , "_Loading_AddChild2.relativeTo");
            result[2] = binding;
            binding = new Binding(this, function () : DisplayObject
            {
                return text2;
            }// end function
            , function (param1:DisplayObject) : void
            {
                _Loading_RemoveChild1.target = param1;
                return;
            }// end function
            , "_Loading_RemoveChild1.target");
            result[3] = binding;
            binding = new Binding(this, function () : UIComponent
            {
                return canvas1;
            }// end function
            , function (param1:UIComponent) : void
            {
                _Loading_AddChild3.relativeTo = param1;
                return;
            }// end function
            , "_Loading_AddChild3.relativeTo");
            result[4] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = testoErrore;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                text3.text = param1;
                return;
            }// end function
            , "text3.text");
            result[5] = binding;
            binding = new Binding(this, function () : UIComponent
            {
                return canvas1;
            }// end function
            , function (param1:UIComponent) : void
            {
                _Loading_AddChild4.relativeTo = param1;
                return;
            }// end function
            , "_Loading_AddChild4.relativeTo");
            result[6] = binding;
            binding = new Binding(this, function () : DisplayObject
            {
                return text2;
            }// end function
            , function (param1:DisplayObject) : void
            {
                _Loading_RemoveChild2.target = param1;
                return;
            }// end function
            , "_Loading_RemoveChild2.target");
            result[7] = binding;
            binding = new Binding(this, function () : IStyleClient
            {
                return button1;
            }// end function
            , function (param1:IStyleClient) : void
            {
                _Loading_SetStyle1.target = param1;
                return;
            }// end function
            , "_Loading_SetStyle1.target");
            result[8] = binding;
            binding = new Binding(this, function () : UIComponent
            {
                return canvas1;
            }// end function
            , function (param1:UIComponent) : void
            {
                _Loading_AddChild5.relativeTo = param1;
                return;
            }// end function
            , "_Loading_AddChild5.relativeTo");
            result[9] = binding;
            binding = new Binding(this, function () : IStyleClient
            {
                return text1;
            }// end function
            , function (param1:IStyleClient) : void
            {
                _Loading_SetStyle2.target = param1;
                return;
            }// end function
            , "_Loading_SetStyle2.target");
            result[10] = binding;
            binding = new Binding(this, function () : IStyleClient
            {
                return canvas1;
            }// end function
            , function (param1:IStyleClient) : void
            {
                _Loading_SetStyle3.target = param1;
                return;
            }// end function
            , "_Loading_SetStyle3.target");
            result[11] = binding;
            return result;
        }// end function

        public function __button1_click(event:MouseEvent) : void
        {
            this.clickOk();
            return;
        }// end function

        public function set canvas1(param1:Canvas) : void
        {
            var _loc_2:* = this._550778329canvas1;
            if (_loc_2 !== param1)
            {
                this._550778329canvas1 = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "canvas1", _loc_2, param1));
            }
            return;
        }// end function

        private function set testoErrore(param1:String) : void
        {
            var _loc_2:* = this._244391974testoErrore;
            if (_loc_2 !== param1)
            {
                this._244391974testoErrore = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "testoErrore", _loc_2, param1));
            }
            return;
        }// end function

        public function get statoerrore() : Boolean
        {
            if (currentState != "errore")
            {
                return false;
            }
            return true;
        }// end function

        private function _Loading_AddChild4_i() : AddChild
        {
            var _loc_1:* = new AddChild();
            this._Loading_AddChild4 = _loc_1;
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._Loading_Button2_i);
            BindingManager.executeBindings(this, "_Loading_AddChild4", this._Loading_AddChild4);
            return _loc_1;
        }// end function

        private function _Loading_bindingExprs() : void
        {
            var _loc_1:* = undefined;
            _loc_1 = this.canvas1;
            _loc_1 = this.testoErrore;
            _loc_1 = this.canvas1;
            _loc_1 = this.text2;
            _loc_1 = this.canvas1;
            _loc_1 = this.testoErrore;
            _loc_1 = this.canvas1;
            _loc_1 = this.text2;
            _loc_1 = this.button1;
            _loc_1 = this.canvas1;
            _loc_1 = this.text1;
            _loc_1 = this.canvas1;
            return;
        }// end function

        private function _Loading_Text2_i() : Text
        {
            var _loc_1:* = new Text();
            this.text3 = _loc_1;
            _loc_1.width = 200;
            _loc_1.selectable = false;
            _loc_1.setStyle("horizontalCenter", "0");
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 11);
            _loc_1.setStyle("color", 16777215);
            _loc_1.setStyle("textAlign", "center");
            _loc_1.setStyle("bottom", "119");
            _loc_1.id = "text3";
            BindingManager.executeBindings(this, "text3", this.text3);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function get canvas1() : Canvas
        {
            return this._550778329canvas1;
        }// end function

        private function get testoErrore() : String
        {
            return this._244391974testoErrore;
        }// end function

        public function __button2_click(event:MouseEvent) : void
        {
            this.clickClose();
            return;
        }// end function

        private function _Loading_State1_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "errore";
            _loc_1.overrides = [this._Loading_AddChild1_i(), this._Loading_AddChild2_i(), this._Loading_RemoveChild1_i()];
            return _loc_1;
        }// end function

        private function _Loading_Button3_i() : Button
        {
            var _loc_1:* = new Button();
            this.button0 = _loc_1;
            _loc_1.setStyle("horizontalCenter", "45");
            _loc_1.setStyle("verticalCenter", "35");
            _loc_1.setStyle("upSkin", this._embed_mxml_______img_v1_riprova_png_23985567);
            _loc_1.setStyle("downSkin", this._embed_mxml_______img_v1_riprova_png_23985567);
            _loc_1.setStyle("overSkin", this._embed_mxml_______img_v1_riprova_over_png_1077833397);
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.addEventListener("click", this.__button0_click);
            _loc_1.id = "button0";
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function setCanvasSkin() : void
        {
            switch(this.SKIN_TYPE)
            {
                case this.VODAFONE_SKIN:
                {
                    this.canvas1.height = 270;
                    break;
                }
                case this.ZEROLIMITS_SKIN:
                {
                    this.canvas1.height = 272;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
        {
            Loading._watcherSetupUtil = param1;
            return;
        }// end function

    }
}
