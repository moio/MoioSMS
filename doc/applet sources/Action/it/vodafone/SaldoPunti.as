package it.vodafone
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import mx.binding.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.effects.*;
    import mx.events.*;
    import mx.states.*;
    import mx.styles.*;

    public class SaldoPunti extends Canvas implements IBindingClient
    {
        private var _embed_mxml_______img_v1_reload_over_png_1513002865:Class;
        private var _550778329canvas1:Canvas;
        public var _SaldoPunti_SetEventHandler1:SetEventHandler;
        private var _241352512button2:Button;
        private var _1110417474label2:Label;
        public var _SaldoPunti_RemoveChild1:RemoveChild;
        public var _SaldoPunti_RemoveChild2:RemoveChild;
        public var _SaldoPunti_RemoveChild3:RemoveChild;
        public var _SaldoPunti_RemoveChild4:RemoveChild;
        public var _SaldoPunti_RemoveChild5:RemoveChild;
        public var _SaldoPunti_RemoveChild6:RemoveChild;
        private var _241352511button1:Button;
        private var _1835020882_titolo:String = "Vodafone One";
        private var _865462023_testoEsteso:String = "";
        private var _2940447_ora:String = "";
        private var _737693187effetto_appare:Sequence;
        private var _embed_mxml_______img_v1_bg_infoconto_png_1295411645:Class;
        private var _embed_mxml_______img_v1_expanded_png_1764667771:Class;
        private var _1405856126effetto_scompare:Sequence;
        private var _1110417475label1:Label;
        var _bindingsByDestination:Object;
        private var _embed_mxml_______img_v1_reload_png_264908037:Class;
        private var _1059518887_testoEsteso2:String = "";
        public var _SaldoPunti_AddChild1:AddChild;
        public var _SaldoPunti_AddChild2:AddChild;
        private var _576569889labelestesa:Text;
        private var _embed_mxml_______img_v1_expanded_over_png_360079281:Class;
        var _watchers:Array;
        public var _SaldoPunti_SetStyle1:SetStyle;
        public var _SaldoPunti_SetStyle2:SetStyle;
        public var _SaldoPunti_SetStyle3:SetStyle;
        public var _SaldoPunti_SetStyle4:SetStyle;
        public var _SaldoPunti_SetStyle5:SetStyle;
        private var _1464946402_testo:String = "";
        private var _693797425labelestesa2:Text;
        var _bindingsBeginWithWord:Object;
        private var _1035784137textarea1:TextArea;
        private var _358164447buttonGlow:Glow;
        var _bindings:Array;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var _embed_mxml_______img_v1_expanded_r_jpg_1796344049:Class;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public function SaldoPunti()
        {
            this._documentDescriptor_ = new UIComponentDescriptor({type:Canvas, propertiesFactory:function () : Object
            {
                return {width:118, height:51, childDescriptors:[new UIComponentDescriptor({type:Canvas, id:"canvas1", propertiesFactory:function () : Object
                {
                    return {x:0, y:0, percentWidth:100, percentHeight:100, verticalScrollPolicy:"off", horizontalScrollPolicy:"off", childDescriptors:[new UIComponentDescriptor({type:TextArea, id:"textarea1", effects:["addedEffect", "removedEffect"], stylesFactory:function () : void
                    {
                        this.fontFamily = "defFont";
                        this.fontSize = 18;
                        this.color = 0;
                        this.backgroundAlpha = 0;
                        this.borderStyle = "none";
                        this.leading = -1;
                        this.fontWeight = "bold";
                        this.addedEffect = "effetto_appare";
                        this.removedEffect = "effetto_scompare";
                        return;
                    }// end function
                    , propertiesFactory:function () : Object
                    {
                        return {x:2, y:18, selectable:false, width:96, editable:false, height:20, tabEnabled:false, mouseChildren:false};
                    }// end function
                    }), new UIComponentDescriptor({type:Button, id:"button2", events:{click:"__button2_click"}, stylesFactory:function () : void
                    {
                        this.downSkin = _embed_mxml_______img_v1_reload_png_264908037;
                        this.upSkin = _embed_mxml_______img_v1_reload_png_264908037;
                        this.overSkin = _embed_mxml_______img_v1_reload_over_png_1513002865;
                        this.themeColor = 13369858;
                        return;
                    }// end function
                    , propertiesFactory:function () : Object
                    {
                        return {x:103, y:26, tabEnabled:false};
                    }// end function
                    }), new UIComponentDescriptor({type:Button, id:"button1", events:{click:"__button1_click"}, stylesFactory:function () : void
                    {
                        this.upSkin = _embed_mxml_______img_v1_expanded_png_1764667771;
                        this.overSkin = _embed_mxml_______img_v1_expanded_over_png_360079281;
                        this.downSkin = _embed_mxml_______img_v1_expanded_png_1764667771;
                        this.themeColor = 13369858;
                        return;
                    }// end function
                    , propertiesFactory:function () : Object
                    {
                        return {x:103, y:0, tabEnabled:false};
                    }// end function
                    }), new UIComponentDescriptor({type:Label, id:"label1", effects:["addedEffect", "removedEffect"], stylesFactory:function () : void
                    {
                        this.fontFamily = "defFont";
                        this.fontSize = 11;
                        this.color = 16711680;
                        this.fontWeight = "bold";
                        this.addedEffect = "effetto_appare";
                        this.removedEffect = "effetto_scompare";
                        return;
                    }// end function
                    , propertiesFactory:function () : Object
                    {
                        return {x:2, y:3, mouseChildren:false};
                    }// end function
                    }), new UIComponentDescriptor({type:Label, id:"label2", effects:["addedEffect", "removedEffect"], stylesFactory:function () : void
                    {
                        this.fontFamily = "defFont";
                        this.fontSize = 10;
                        this.color = 6710886;
                        this.addedEffect = "effetto_appare";
                        this.removedEffect = "effetto_scompare";
                        return;
                    }// end function
                    , propertiesFactory:function () : Object
                    {
                        return {x:2, y:37, mouseChildren:false};
                    }// end function
                    })]};
                }// end function
                })]};
            }// end function
            });
            this._embed_mxml_______img_v1_bg_infoconto_png_1295411645 = SaldoPunti__embed_mxml_______img_v1_bg_infoconto_png_1295411645;
            this._embed_mxml_______img_v1_expanded_over_png_360079281 = SaldoPunti__embed_mxml_______img_v1_expanded_over_png_360079281;
            this._embed_mxml_______img_v1_expanded_png_1764667771 = SaldoPunti__embed_mxml_______img_v1_expanded_png_1764667771;
            this._embed_mxml_______img_v1_expanded_r_jpg_1796344049 = SaldoPunti__embed_mxml_______img_v1_expanded_r_jpg_1796344049;
            this._embed_mxml_______img_v1_reload_over_png_1513002865 = SaldoPunti__embed_mxml_______img_v1_reload_over_png_1513002865;
            this._embed_mxml_______img_v1_reload_png_264908037 = SaldoPunti__embed_mxml_______img_v1_reload_png_264908037;
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
                this.backgroundImage = _embed_mxml_______img_v1_bg_infoconto_png_1295411645;
                return;
            }// end function
            ;
            this.width = 118;
            this.height = 51;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.buttonMode = true;
            this.useHandCursor = true;
            this.states = [this._SaldoPunti_State1_c(), this._SaldoPunti_State2_c()];
            this._SaldoPunti_Glow1_i();
            this._SaldoPunti_Sequence1_i();
            this._SaldoPunti_Sequence2_i();
            this.addEventListener("click", this.___SaldoPunti_Canvas1_click);
            this.addEventListener("addedToStage", this.___SaldoPunti_Canvas1_addedToStage);
            return;
        }// end function

        private function _SaldoPunti_SetStyle4_i() : SetStyle
        {
            var _loc_1:* = new SetStyle();
            this._SaldoPunti_SetStyle4 = _loc_1;
            _loc_1.name = "overSkin";
            _loc_1.value = this._embed_mxml_______img_v1_expanded_png_1764667771;
            BindingManager.executeBindings(this, "_SaldoPunti_SetStyle4", this._SaldoPunti_SetStyle4);
            return _loc_1;
        }// end function

        public function set effetto_scompare(param1:Sequence) : void
        {
            var _loc_2:* = this._1405856126effetto_scompare;
            if (_loc_2 !== param1)
            {
                this._1405856126effetto_scompare = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "effetto_scompare", _loc_2, param1));
            }
            return;
        }// end function

        public function set effetto_appare(param1:Sequence) : void
        {
            var _loc_2:* = this._737693187effetto_appare;
            if (_loc_2 !== param1)
            {
                this._737693187effetto_appare = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "effetto_appare", _loc_2, param1));
            }
            return;
        }// end function

        private function _SaldoPunti_Fade1_c() : Fade
        {
            var _loc_1:* = new Fade();
            _loc_1.duration = 200;
            return _loc_1;
        }// end function

        private function _SaldoPunti_State1_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "info";
            _loc_1.overrides = [this._SaldoPunti_RemoveChild1_i(), this._SaldoPunti_RemoveChild2_i(), this._SaldoPunti_RemoveChild3_i(), this._SaldoPunti_AddChild1_i(), this._SaldoPunti_SetStyle1_i(), this._SaldoPunti_SetStyle2_i(), this._SaldoPunti_SetStyle3_i()];
            return _loc_1;
        }// end function

        private function init() : void
        {
            this.update();
            ServerBridge.getServerBridgeInstance().addEventListener(ServerBridge.USER_DATA_LOADED, this.updateDisplay);
            ServerBridge.getServerBridgeInstance().addEventListener(ServerBridge.OMNIONE_LOADED, this.updateDisplay);
            ServerBridge.getServerBridgeInstance().addEventListener(ServerBridge.LOADING_OMNIONE, this.displayLoading);
            return;
        }// end function

        private function _SaldoPunti_RemoveChild5_i() : RemoveChild
        {
            var _loc_1:* = new RemoveChild();
            this._SaldoPunti_RemoveChild5 = _loc_1;
            BindingManager.executeBindings(this, "_SaldoPunti_RemoveChild5", this._SaldoPunti_RemoveChild5);
            return _loc_1;
        }// end function

        private function _SaldoPunti_RemoveChild1_i() : RemoveChild
        {
            var _loc_1:* = new RemoveChild();
            this._SaldoPunti_RemoveChild1 = _loc_1;
            BindingManager.executeBindings(this, "_SaldoPunti_RemoveChild1", this._SaldoPunti_RemoveChild1);
            return _loc_1;
        }// end function

        private function displayLoading(event:Event = null) : void
        {
            this._testo = "Loading...";
            this._ora = "";
            this._testoEsteso = "";
            this._testoEsteso2 = "";
            return;
        }// end function

        private function get _testo() : String
        {
            return this._1464946402_testo;
        }// end function

        private function get _ora() : String
        {
            return this._2940447_ora;
        }// end function

        public function get labelestesa() : Text
        {
            return this._576569889labelestesa;
        }// end function

        private function _SaldoPunti_bindingsSetup() : Array
        {
            var binding:Binding;
            var result:Array;
            binding = new Binding(this, function () : DisplayObject
            {
                return label1;
            }// end function
            , function (param1:DisplayObject) : void
            {
                _SaldoPunti_RemoveChild1.target = param1;
                return;
            }// end function
            , "_SaldoPunti_RemoveChild1.target");
            result[0] = binding;
            binding = new Binding(this, function () : DisplayObject
            {
                return label2;
            }// end function
            , function (param1:DisplayObject) : void
            {
                _SaldoPunti_RemoveChild2.target = param1;
                return;
            }// end function
            , "_SaldoPunti_RemoveChild2.target");
            result[1] = binding;
            binding = new Binding(this, function () : DisplayObject
            {
                return textarea1;
            }// end function
            , function (param1:DisplayObject) : void
            {
                _SaldoPunti_RemoveChild3.target = param1;
                return;
            }// end function
            , "_SaldoPunti_RemoveChild3.target");
            result[2] = binding;
            binding = new Binding(this, function () : UIComponent
            {
                return canvas1;
            }// end function
            , function (param1:UIComponent) : void
            {
                _SaldoPunti_AddChild1.relativeTo = param1;
                return;
            }// end function
            , "_SaldoPunti_AddChild1.relativeTo");
            result[3] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = _testoEsteso;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                labelestesa.text = param1;
                return;
            }// end function
            , "labelestesa.text");
            result[4] = binding;
            binding = new Binding(this, function () : IStyleClient
            {
                return button1;
            }// end function
            , function (param1:IStyleClient) : void
            {
                _SaldoPunti_SetStyle1.target = param1;
                return;
            }// end function
            , "_SaldoPunti_SetStyle1.target");
            result[5] = binding;
            binding = new Binding(this, function () : IStyleClient
            {
                return button1;
            }// end function
            , function (param1:IStyleClient) : void
            {
                _SaldoPunti_SetStyle2.target = param1;
                return;
            }// end function
            , "_SaldoPunti_SetStyle2.target");
            result[6] = binding;
            binding = new Binding(this, function () : IStyleClient
            {
                return button1;
            }// end function
            , function (param1:IStyleClient) : void
            {
                _SaldoPunti_SetStyle3.target = param1;
                return;
            }// end function
            , "_SaldoPunti_SetStyle3.target");
            result[7] = binding;
            binding = new Binding(this, function () : DisplayObject
            {
                return label1;
            }// end function
            , function (param1:DisplayObject) : void
            {
                _SaldoPunti_RemoveChild4.target = param1;
                return;
            }// end function
            , "_SaldoPunti_RemoveChild4.target");
            result[8] = binding;
            binding = new Binding(this, function () : DisplayObject
            {
                return label2;
            }// end function
            , function (param1:DisplayObject) : void
            {
                _SaldoPunti_RemoveChild5.target = param1;
                return;
            }// end function
            , "_SaldoPunti_RemoveChild5.target");
            result[9] = binding;
            binding = new Binding(this, function () : DisplayObject
            {
                return textarea1;
            }// end function
            , function (param1:DisplayObject) : void
            {
                _SaldoPunti_RemoveChild6.target = param1;
                return;
            }// end function
            , "_SaldoPunti_RemoveChild6.target");
            result[10] = binding;
            binding = new Binding(this, function () : UIComponent
            {
                return canvas1;
            }// end function
            , function (param1:UIComponent) : void
            {
                _SaldoPunti_AddChild2.relativeTo = param1;
                return;
            }// end function
            , "_SaldoPunti_AddChild2.relativeTo");
            result[11] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = _testoEsteso2;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                labelestesa2.text = param1;
                return;
            }// end function
            , "labelestesa2.text");
            result[12] = binding;
            binding = new Binding(this, function () : IStyleClient
            {
                return button1;
            }// end function
            , function (param1:IStyleClient) : void
            {
                _SaldoPunti_SetStyle4.target = param1;
                return;
            }// end function
            , "_SaldoPunti_SetStyle4.target");
            result[13] = binding;
            binding = new Binding(this, function () : IStyleClient
            {
                return button1;
            }// end function
            , function (param1:IStyleClient) : void
            {
                _SaldoPunti_SetStyle5.target = param1;
                return;
            }// end function
            , "_SaldoPunti_SetStyle5.target");
            result[14] = binding;
            binding = new Binding(this, function () : EventDispatcher
            {
                return button1;
            }// end function
            , function (param1:EventDispatcher) : void
            {
                _SaldoPunti_SetEventHandler1.target = param1;
                return;
            }// end function
            , "_SaldoPunti_SetEventHandler1.target");
            result[15] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = _testo;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                textarea1.htmlText = param1;
                return;
            }// end function
            , "textarea1.htmlText");
            result[16] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = _titolo;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                label1.text = param1;
                return;
            }// end function
            , "label1.text");
            result[17] = binding;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = _ora;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                label2.text = param1;
                return;
            }// end function
            , "label2.text");
            result[18] = binding;
            return result;
        }// end function

        private function _SaldoPunti_Sequence1_i() : Sequence
        {
            var _loc_1:* = new Sequence();
            this.effetto_appare = _loc_1;
            _loc_1.children = [this._SaldoPunti_SetPropertyAction1_c(), this._SaldoPunti_Pause1_c(), this._SaldoPunti_Fade1_c()];
            return _loc_1;
        }// end function

        public function get labelestesa2() : Text
        {
            return this._693797425labelestesa2;
        }// end function

        public function ___SaldoPunti_Canvas1_click(event:MouseEvent) : void
        {
            this.clickMore(event);
            return;
        }// end function

        private function _SaldoPunti_SetPropertyAction1_c() : SetPropertyAction
        {
            var _loc_1:* = new SetPropertyAction();
            _loc_1.name = "alpha";
            _loc_1.value = 0;
            return _loc_1;
        }// end function

        public function get effetto_appare() : Sequence
        {
            return this._737693187effetto_appare;
        }// end function

        private function _SaldoPunti_SetStyle3_i() : SetStyle
        {
            var _loc_1:* = new SetStyle();
            this._SaldoPunti_SetStyle3 = _loc_1;
            _loc_1.name = "upSkin";
            _loc_1.value = this._embed_mxml_______img_v1_expanded_r_jpg_1796344049;
            BindingManager.executeBindings(this, "_SaldoPunti_SetStyle3", this._SaldoPunti_SetStyle3);
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

        public function set labelestesa(param1:Text) : void
        {
            var _loc_2:* = this._576569889labelestesa;
            if (_loc_2 !== param1)
            {
                this._576569889labelestesa = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "labelestesa", _loc_2, param1));
            }
            return;
        }// end function

        private function showInfo() : void
        {
            if (currentState == "info")
            {
                currentState = "";
            }
            else
            {
                currentState = "info";
            }
            return;
        }// end function

        private function set _ora(param1:String) : void
        {
            var _loc_2:* = this._2940447_ora;
            if (_loc_2 !== param1)
            {
                this._2940447_ora = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_ora", _loc_2, param1));
            }
            return;
        }// end function

        public function get textarea1() : TextArea
        {
            return this._1035784137textarea1;
        }// end function

        private function _SaldoPunti_RemoveChild4_i() : RemoveChild
        {
            var _loc_1:* = new RemoveChild();
            this._SaldoPunti_RemoveChild4 = _loc_1;
            BindingManager.executeBindings(this, "_SaldoPunti_RemoveChild4", this._SaldoPunti_RemoveChild4);
            return _loc_1;
        }// end function

        private function set _testo(param1:String) : void
        {
            var _loc_2:* = this._1464946402_testo;
            if (_loc_2 !== param1)
            {
                this._1464946402_testo = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_testo", _loc_2, param1));
            }
            return;
        }// end function

        private function get _testoEsteso2() : String
        {
            return this._1059518887_testoEsteso2;
        }// end function

        private function get _titolo() : String
        {
            return this._1835020882_titolo;
        }// end function

        public function set labelestesa2(param1:Text) : void
        {
            var _loc_2:* = this._693797425labelestesa2;
            if (_loc_2 !== param1)
            {
                this._693797425labelestesa2 = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "labelestesa2", _loc_2, param1));
            }
            return;
        }// end function

        private function _SaldoPunti_Glow1_i() : Glow
        {
            var _loc_1:* = new Glow();
            this.buttonGlow = _loc_1;
            _loc_1.color = 16777215;
            _loc_1.alphaFrom = 1;
            _loc_1.alphaTo = 0;
            _loc_1.duration = 1500;
            return _loc_1;
        }// end function

        private function _SaldoPunti_bindingExprs() : void
        {
            var _loc_1:* = undefined;
            _loc_1 = this.label1;
            _loc_1 = this.label2;
            _loc_1 = this.textarea1;
            _loc_1 = this.canvas1;
            _loc_1 = this._testoEsteso;
            _loc_1 = this.button1;
            _loc_1 = this.button1;
            _loc_1 = this.button1;
            _loc_1 = this.label1;
            _loc_1 = this.label2;
            _loc_1 = this.textarea1;
            _loc_1 = this.canvas1;
            _loc_1 = this._testoEsteso2;
            _loc_1 = this.button1;
            _loc_1 = this.button1;
            _loc_1 = this.button1;
            _loc_1 = this._testo;
            _loc_1 = this._titolo;
            _loc_1 = this._ora;
            return;
        }// end function

        public function set textarea1(param1:TextArea) : void
        {
            var _loc_2:* = this._1035784137textarea1;
            if (_loc_2 !== param1)
            {
                this._1035784137textarea1 = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "textarea1", _loc_2, param1));
            }
            return;
        }// end function

        private function _SaldoPunti_SetEventHandler1_i() : SetEventHandler
        {
            var _loc_1:* = new SetEventHandler();
            this._SaldoPunti_SetEventHandler1 = _loc_1;
            _loc_1.name = "click";
            BindingManager.executeBindings(this, "_SaldoPunti_SetEventHandler1", this._SaldoPunti_SetEventHandler1);
            return _loc_1;
        }// end function

        private function _SaldoPunti_AddChild2_i() : AddChild
        {
            var _loc_1:* = new AddChild();
            this._SaldoPunti_AddChild2 = _loc_1;
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._SaldoPunti_Text2_i);
            BindingManager.executeBindings(this, "_SaldoPunti_AddChild2", this._SaldoPunti_AddChild2);
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

        private function _SaldoPunti_SetStyle2_i() : SetStyle
        {
            var _loc_1:* = new SetStyle();
            this._SaldoPunti_SetStyle2 = _loc_1;
            _loc_1.name = "downSkin";
            _loc_1.value = this._embed_mxml_______img_v1_expanded_r_jpg_1796344049;
            BindingManager.executeBindings(this, "_SaldoPunti_SetStyle2", this._SaldoPunti_SetStyle2);
            return _loc_1;
        }// end function

        public function set label2(param1:Label) : void
        {
            var _loc_2:* = this._1110417474label2;
            if (_loc_2 !== param1)
            {
                this._1110417474label2 = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "label2", _loc_2, param1));
            }
            return;
        }// end function

        private function _SaldoPunti_Text2_i() : Text
        {
            var _loc_1:* = new Text();
            this.labelestesa2 = _loc_1;
            _loc_1.x = 3;
            _loc_1.y = 4;
            _loc_1.width = 98;
            _loc_1.height = 47;
            _loc_1.selectable = false;
            _loc_1.mouseChildren = false;
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 9);
            _loc_1.setStyle("color", 3355443);
            _loc_1.setStyle("leading", -0.2);
            _loc_1.setStyle("removedEffect", "effetto_scompare");
            _loc_1.setStyle("addedEffect", "effetto_appare");
            _loc_1.registerEffects(["removedEffect", "addedEffect"]);
            _loc_1.id = "labelestesa2";
            BindingManager.executeBindings(this, "labelestesa2", this.labelestesa2);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
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

        public function get effetto_scompare() : Sequence
        {
            return this._1405856126effetto_scompare;
        }// end function

        override public function initialize() : void
        {
            var target:SaldoPunti;
            var watcherSetupUtilClass:Object;
            .mx_internal::setDocumentDescriptor(this._documentDescriptor_);
            var bindings:* = this._SaldoPunti_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_it_vodafone_SaldoPuntiWatcherSetupUtil");
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

        private function _SaldoPunti_Pause1_c() : Pause
        {
            var _loc_1:* = new Pause();
            _loc_1.duration = 800;
            return _loc_1;
        }// end function

        public function ___SaldoPunti_Canvas1_addedToStage(event:Event) : void
        {
            this.init();
            return;
        }// end function

        private function set _titolo(param1:String) : void
        {
            var _loc_2:* = this._1835020882_titolo;
            if (_loc_2 !== param1)
            {
                this._1835020882_titolo = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_titolo", _loc_2, param1));
            }
            return;
        }// end function

        public function __button1_click(event:MouseEvent) : void
        {
            this.showInfo();
            return;
        }// end function

        public function sessionRetry(event:Event) : void
        {
            this.update();
            return;
        }// end function

        private function _SaldoPunti_AddChild1_i() : AddChild
        {
            var _loc_1:* = new AddChild();
            this._SaldoPunti_AddChild1 = _loc_1;
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._SaldoPunti_Text1_i);
            BindingManager.executeBindings(this, "_SaldoPunti_AddChild1", this._SaldoPunti_AddChild1);
            return _loc_1;
        }// end function

        private function _SaldoPunti_RemoveChild3_i() : RemoveChild
        {
            var _loc_1:* = new RemoveChild();
            this._SaldoPunti_RemoveChild3 = _loc_1;
            BindingManager.executeBindings(this, "_SaldoPunti_RemoveChild3", this._SaldoPunti_RemoveChild3);
            return _loc_1;
        }// end function

        private function updateDisplay(event:Event = null) : void
        {
            if (ServerBridge.getServerBridgeInstance().punti == "")
            {
                this.update();
            }
            else
            {
                this.setTesto(ServerBridge.getServerBridgeInstance().punti, ServerBridge.getServerBridgeInstance().oraPunti);
            }
            return;
        }// end function

        private function _SaldoPunti_SetStyle1_i() : SetStyle
        {
            var _loc_1:* = new SetStyle();
            this._SaldoPunti_SetStyle1 = _loc_1;
            _loc_1.name = "overSkin";
            _loc_1.value = this._embed_mxml_______img_v1_expanded_r_jpg_1796344049;
            BindingManager.executeBindings(this, "_SaldoPunti_SetStyle1", this._SaldoPunti_SetStyle1);
            return _loc_1;
        }// end function

        private function _SaldoPunti_Text1_i() : Text
        {
            var _loc_1:* = new Text();
            this.labelestesa = _loc_1;
            _loc_1.x = 3;
            _loc_1.y = 4;
            _loc_1.width = 98;
            _loc_1.height = 47;
            _loc_1.mouseChildren = false;
            _loc_1.setStyle("fontFamily", "defFont");
            _loc_1.setStyle("fontSize", 9);
            _loc_1.setStyle("color", 3355443);
            _loc_1.setStyle("leading", -0.2);
            _loc_1.setStyle("removedEffect", "effetto_scompare");
            _loc_1.setStyle("addedEffect", "effetto_appare");
            _loc_1.registerEffects(["removedEffect", "addedEffect"]);
            _loc_1.id = "labelestesa";
            BindingManager.executeBindings(this, "labelestesa", this.labelestesa);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _SaldoPunti_SetStyle5_i() : SetStyle
        {
            var _loc_1:* = new SetStyle();
            this._SaldoPunti_SetStyle5 = _loc_1;
            _loc_1.name = "upSkin";
            _loc_1.value = this._embed_mxml_______img_v1_expanded_png_1764667771;
            BindingManager.executeBindings(this, "_SaldoPunti_SetStyle5", this._SaldoPunti_SetStyle5);
            return _loc_1;
        }// end function

        private function update() : void
        {
            ServerBridge.getServerBridgeInstance().addEventListener(ServerBridge.SESSION_RESTORED, this.sessionRetry);
            ServerBridge.getServerBridgeInstance().updateOmnione(true);
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

        public function set buttonGlow(param1:Glow) : void
        {
            var _loc_2:* = this._358164447buttonGlow;
            if (_loc_2 !== param1)
            {
                this._358164447buttonGlow = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buttonGlow", _loc_2, param1));
            }
            return;
        }// end function

        private function _SaldoPunti_Fade2_c() : Fade
        {
            var _loc_1:* = new Fade();
            _loc_1.duration = 400;
            return _loc_1;
        }// end function

        private function _SaldoPunti_State2_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "subscribe";
            _loc_1.overrides = [this._SaldoPunti_RemoveChild4_i(), this._SaldoPunti_RemoveChild5_i(), this._SaldoPunti_RemoveChild6_i(), this._SaldoPunti_AddChild2_i(), this._SaldoPunti_SetStyle4_i(), this._SaldoPunti_SetStyle5_i(), this._SaldoPunti_SetEventHandler1_i()];
            return _loc_1;
        }// end function

        private function _SaldoPunti_RemoveChild6_i() : RemoveChild
        {
            var _loc_1:* = new RemoveChild();
            this._SaldoPunti_RemoveChild6 = _loc_1;
            BindingManager.executeBindings(this, "_SaldoPunti_RemoveChild6", this._SaldoPunti_RemoveChild6);
            return _loc_1;
        }// end function

        private function set _testoEsteso2(param1:String) : void
        {
            var _loc_2:* = this._1059518887_testoEsteso2;
            if (_loc_2 !== param1)
            {
                this._1059518887_testoEsteso2 = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_testoEsteso2", _loc_2, param1));
            }
            return;
        }// end function

        private function _SaldoPunti_RemoveChild2_i() : RemoveChild
        {
            var _loc_1:* = new RemoveChild();
            this._SaldoPunti_RemoveChild2 = _loc_1;
            BindingManager.executeBindings(this, "_SaldoPunti_RemoveChild2", this._SaldoPunti_RemoveChild2);
            return _loc_1;
        }// end function

        public function get canvas1() : Canvas
        {
            return this._550778329canvas1;
        }// end function

        public function setTesto(param1:String, param2:String) : void
        {
            ServerBridge.getServerBridgeInstance().removeEventListener(ServerBridge.SESSION_RESTORED, this.sessionRetry);
            if (param1 == null)
            {
                currentState = "";
            }
            else if (param1 == "non_iscritto")
            {
                currentState = "subscribe";
                this._testoEsteso2 = "Iscriviti al programma Vodafone One! Ti aspettano premi e vantaggi esclusivi.";
            }
            else
            {
                if (currentState == "subscribe")
                {
                    currentState = "";
                }
                this._testoEsteso = "Il tuo saldo punti Vodafone One aggiornato alle " + param2 + " è " + param1 + ".";
                this._testo = param1 + " punti";
                this._ora = "alle " + param2;
            }
            return;
        }// end function

        public function get buttonGlow() : Glow
        {
            return this._358164447buttonGlow;
        }// end function

        public function get label2() : Label
        {
            return this._1110417474label2;
        }// end function

        public function __button2_click(event:MouseEvent) : void
        {
            this.update();
            return;
        }// end function

        public function get label1() : Label
        {
            return this._1110417475label1;
        }// end function

        private function _SaldoPunti_Sequence2_i() : Sequence
        {
            var _loc_1:* = new Sequence();
            this.effetto_scompare = _loc_1;
            _loc_1.children = [this._SaldoPunti_Fade2_c()];
            return _loc_1;
        }// end function

        private function set _testoEsteso(param1:String) : void
        {
            var _loc_2:* = this._865462023_testoEsteso;
            if (_loc_2 !== param1)
            {
                this._865462023_testoEsteso = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_testoEsteso", _loc_2, param1));
            }
            return;
        }// end function

        private function get _testoEsteso() : String
        {
            return this._865462023_testoEsteso;
        }// end function

        private function clickMore(event:MouseEvent) : void
        {
            if (event.target.hasOwnProperty("className") && event.target.className == "Button")
            {
                return;
            }
            if (currentState == "subscribe")
            {
                trace("vodafone_one_url: " + RemotePreferences.getInstance().getValue("vodafone_one_url"));
                dispatchEvent(new BannerClick(RemotePreferences.getInstance().getValue("vodafone_one_url")));
            }
            else
            {
                trace("v1_more_url: " + RemotePreferences.getInstance().getValue("v1_more_url"));
                dispatchEvent(new BannerClick(RemotePreferences.getInstance().getValue("v1_more_url")));
            }
            return;
        }// end function

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
        {
            _watcherSetupUtil = param1;
            return;
        }// end function

    }
}
