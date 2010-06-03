package it.vodafone
{
    import flash.events.*;
    import flash.utils.*;
    import mx.binding.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.states.*;

    public class Skin extends Canvas implements IBindingClient
    {
        private var _embed_mxml_img_v1_6_window_zero_png_1982370721:Class;
        var _bindings:Array;
        private var _embed_mxml_img_v1_logo_png_485293375:Class;
        var _watchers:Array;
        private var _embed_mxml_img_v1_6_back_zero_png_984403115:Class;
        private var _embed_mxml_img_v1_back_png_471696705:Class;
        var _bindingsByDestination:Object;
        var _bindingsBeginWithWord:Object;
        private var _embed_mxml_img_v1_linea_fondo_png_902459519:Class;
        public var _Skin_Button2:Button;
        public var _Skin_Button1:Button;
        public var _Skin_Button3:Button;
        private var _embed_mxml_img_v1_window_png_183462609:Class;
        private var _embed_mxml_img_v1_6_logo_zero_png_665869091:Class;
        private var _documentDescriptor_:UIComponentDescriptor;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public function Skin()
        {
            this._documentDescriptor_ = new UIComponentDescriptor({type:Canvas, propertiesFactory:function () : Object
            {
                return {width:268, height:378};
            }// end function
            });
            this._embed_mxml_img_v1_6_back_zero_png_984403115 = Skin__embed_mxml_img_v1_6_back_zero_png_984403115;
            this._embed_mxml_img_v1_6_logo_zero_png_665869091 = Skin__embed_mxml_img_v1_6_logo_zero_png_665869091;
            this._embed_mxml_img_v1_6_window_zero_png_1982370721 = Skin__embed_mxml_img_v1_6_window_zero_png_1982370721;
            this._embed_mxml_img_v1_back_png_471696705 = Skin__embed_mxml_img_v1_back_png_471696705;
            this._embed_mxml_img_v1_linea_fondo_png_902459519 = Skin__embed_mxml_img_v1_linea_fondo_png_902459519;
            this._embed_mxml_img_v1_logo_png_485293375 = Skin__embed_mxml_img_v1_logo_png_485293375;
            this._embed_mxml_img_v1_window_png_183462609 = Skin__embed_mxml_img_v1_window_png_183462609;
            this._bindings = [];
            this._watchers = [];
            this._bindingsByDestination = {};
            this._bindingsBeginWithWord = {};
            mx_internal::_document = this;
            this.width = 268;
            this.height = 378;
            this.states = [this._Skin_State1_c(), this._Skin_State2_c(), this._Skin_State3_c(), this._Skin_State4_c()];
            return;
        }// end function

        private function _Skin_Button4_c() : Button
        {
            var _loc_1:* = new Button();
            _loc_1.buttonMode = true;
            _loc_1.useHandCursor = true;
            _loc_1.styleName = "close";
            _loc_1.x = 247;
            _loc_1.y = 19;
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.addEventListener("click", this.___Skin_Button4_click);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function ___Skin_Button1_click(event:MouseEvent) : void
        {
            this.parentDocument.closeWidget();
            return;
        }// end function

        private function _Skin_Button2_i() : Button
        {
            var _loc_1:* = new Button();
            this._Skin_Button2 = _loc_1;
            _loc_1.buttonMode = true;
            _loc_1.useHandCursor = true;
            _loc_1.styleName = "closeZero";
            _loc_1.x = 247;
            _loc_1.y = 19;
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.addEventListener("click", this.___Skin_Button2_click);
            _loc_1.id = "_Skin_Button2";
            BindingManager.executeBindings(this, "_Skin_Button2", this._Skin_Button2);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _Skin_bindingsSetup() : Array
        {
            var binding:Binding;
            var result:Array;
            binding = new Binding(this, function () : int
            {
                return TabIndexManager.INDEX_CLOSE_BUTTON;
            }// end function
            , function (param1:int) : void
            {
                _Skin_Button1.tabIndex = param1;
                return;
            }// end function
            , "_Skin_Button1.tabIndex");
            result[0] = binding;
            binding = new Binding(this, function () : int
            {
                return TabIndexManager.INDEX_CLOSE_BUTTON;
            }// end function
            , function (param1:int) : void
            {
                _Skin_Button2.tabIndex = param1;
                return;
            }// end function
            , "_Skin_Button2.tabIndex");
            result[1] = binding;
            binding = new Binding(this, function () : int
            {
                return TabIndexManager.INDEX_CLOSE_BUTTON;
            }// end function
            , function (param1:int) : void
            {
                _Skin_Button3.tabIndex = param1;
                return;
            }// end function
            , "_Skin_Button3.tabIndex");
            result[2] = binding;
            return result;
        }// end function

        public function ___Skin_Button3_click(event:MouseEvent) : void
        {
            this.parentDocument.closeWidget();
            return;
        }// end function

        override public function initialize() : void
        {
            var target:Skin;
            var watcherSetupUtilClass:Object;
            .mx_internal::setDocumentDescriptor(this._documentDescriptor_);
            var bindings:* = this._Skin_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_it_vodafone_SkinWatcherSetupUtil");
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

        private function _Skin_AddChild1_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._Skin_Canvas2_c);
            return _loc_1;
        }// end function

        private function _Skin_AddChild3_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._Skin_Canvas4_c);
            return _loc_1;
        }// end function

        private function _Skin_Canvas2_c() : Canvas
        {
            var _loc_1:* = new Canvas();
            _loc_1.x = 0;
            _loc_1.y = 0;
            _loc_1.percentWidth = 100;
            _loc_1.percentHeight = 100;
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            _loc_1.addChild(this._Skin_Image1_c());
            _loc_1.addChild(this._Skin_Image2_c());
            _loc_1.addChild(this._Skin_Button1_i());
            return _loc_1;
        }// end function

        private function _Skin_Image1_c() : Image
        {
            var _loc_1:* = new Image();
            _loc_1.source = this._embed_mxml_img_v1_window_png_183462609;
            _loc_1.scaleContent = false;
            _loc_1.autoLoad = true;
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _Skin_Image3_c() : Image
        {
            var _loc_1:* = new Image();
            _loc_1.source = this._embed_mxml_img_v1_6_window_zero_png_1982370721;
            _loc_1.scaleContent = false;
            _loc_1.autoLoad = true;
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _Skin_Image5_c() : Image
        {
            var _loc_1:* = new Image();
            _loc_1.scaleContent = false;
            _loc_1.autoLoad = true;
            _loc_1.source = "img/v1_6/elementi_zero.png";
            _loc_1.useHandCursor = true;
            _loc_1.buttonMode = true;
            _loc_1.setStyle("left", "172");
            _loc_1.setStyle("top", "351");
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.addEventListener("click", this.___Skin_Image5_click);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _Skin_AddChild5_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._Skin_Canvas5_c);
            return _loc_1;
        }// end function

        private function _Skin_Image7_c() : Image
        {
            var _loc_1:* = new Image();
            _loc_1.scaleContent = false;
            _loc_1.autoLoad = true;
            _loc_1.source = this._embed_mxml_img_v1_linea_fondo_png_902459519;
            _loc_1.x = 4;
            _loc_1.y = 321;
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _Skin_Canvas4_c() : Canvas
        {
            var _loc_1:* = new Canvas();
            _loc_1.x = 0;
            _loc_1.y = 0;
            _loc_1.percentWidth = 100;
            _loc_1.percentHeight = 100;
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            _loc_1.addChild(this._Skin_Image6_c());
            _loc_1.addChild(this._Skin_Button3_i());
            return _loc_1;
        }// end function

        private function _Skin_Image9_c() : Image
        {
            var _loc_1:* = new Image();
            _loc_1.scaleContent = false;
            _loc_1.autoLoad = true;
            _loc_1.source = this._embed_mxml_img_v1_linea_fondo_png_902459519;
            _loc_1.x = 4;
            _loc_1.y = 321;
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function ___Skin_Image5_click(event:MouseEvent) : void
        {
            this.parentDocument.clickSuLogoFooter();
            return;
        }// end function

        private function _Skin_State1_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "vodafone_skin";
            _loc_1.overrides = [this._Skin_AddChild1_c()];
            return _loc_1;
        }// end function

        private function _Skin_State3_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "vodafone_options_skin";
            _loc_1.overrides = [this._Skin_AddChild3_c(), this._Skin_AddChild4_c()];
            return _loc_1;
        }// end function

        private function _Skin_Button1_i() : Button
        {
            var _loc_1:* = new Button();
            this._Skin_Button1 = _loc_1;
            _loc_1.buttonMode = true;
            _loc_1.useHandCursor = true;
            _loc_1.styleName = "close";
            _loc_1.x = 247;
            _loc_1.y = 19;
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.addEventListener("click", this.___Skin_Button1_click);
            _loc_1.id = "_Skin_Button1";
            BindingManager.executeBindings(this, "_Skin_Button1", this._Skin_Button1);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _Skin_Button3_i() : Button
        {
            var _loc_1:* = new Button();
            this._Skin_Button3 = _loc_1;
            _loc_1.buttonMode = true;
            _loc_1.useHandCursor = true;
            _loc_1.styleName = "close";
            _loc_1.x = 247;
            _loc_1.y = 19;
            _loc_1.setStyle("themeColor", 13369858);
            _loc_1.addEventListener("click", this.___Skin_Button3_click);
            _loc_1.id = "_Skin_Button3";
            BindingManager.executeBindings(this, "_Skin_Button3", this._Skin_Button3);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function ___Skin_Button2_click(event:MouseEvent) : void
        {
            this.parentDocument.closeWidget();
            return;
        }// end function

        public function ___Skin_Button4_click(event:MouseEvent) : void
        {
            this.parentDocument.closeWidget();
            return;
        }// end function

        private function _Skin_AddChild2_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._Skin_Canvas3_c);
            return _loc_1;
        }// end function

        private function _Skin_AddChild4_c() : AddChild
        {
            var _loc_1:* = new AddChild();
            _loc_1.position = "lastChild";
            _loc_1.targetFactory = new DeferredInstanceFromFunction(this._Skin_Image7_c);
            return _loc_1;
        }// end function

        private function _Skin_Canvas3_c() : Canvas
        {
            var _loc_1:* = new Canvas();
            _loc_1.x = 0;
            _loc_1.y = 0;
            _loc_1.percentWidth = 100;
            _loc_1.percentHeight = 100;
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            _loc_1.addChild(this._Skin_Image3_c());
            _loc_1.addChild(this._Skin_Image4_c());
            _loc_1.addChild(this._Skin_Button2_i());
            _loc_1.addChild(this._Skin_Image5_c());
            return _loc_1;
        }// end function

        private function _Skin_Canvas5_c() : Canvas
        {
            var _loc_1:* = new Canvas();
            _loc_1.x = 0;
            _loc_1.y = 0;
            _loc_1.percentWidth = 100;
            _loc_1.percentHeight = 100;
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            _loc_1.addChild(this._Skin_Image8_c());
            _loc_1.addChild(this._Skin_Button4_c());
            _loc_1.addChild(this._Skin_Image9_c());
            return _loc_1;
        }// end function

        private function _Skin_Image4_c() : Image
        {
            var _loc_1:* = new Image();
            _loc_1.scaleContent = false;
            _loc_1.autoLoad = true;
            _loc_1.source = this._embed_mxml_img_v1_6_logo_zero_png_665869091;
            _loc_1.useHandCursor = true;
            _loc_1.buttonMode = true;
            _loc_1.setStyle("left", "11");
            _loc_1.setStyle("top", "12");
            _loc_1.addEventListener("click", this.___Skin_Image4_click);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _Skin_Image6_c() : Image
        {
            var _loc_1:* = new Image();
            _loc_1.source = this._embed_mxml_img_v1_back_png_471696705;
            _loc_1.scaleContent = false;
            _loc_1.autoLoad = true;
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        public function ___Skin_Image2_click(event:MouseEvent) : void
        {
            this.parentDocument.clickSuLogo();
            return;
        }// end function

        private function _Skin_Image8_c() : Image
        {
            var _loc_1:* = new Image();
            _loc_1.source = this._embed_mxml_img_v1_6_back_zero_png_984403115;
            _loc_1.scaleContent = false;
            _loc_1.autoLoad = true;
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _Skin_Image2_c() : Image
        {
            var _loc_1:* = new Image();
            _loc_1.scaleContent = false;
            _loc_1.autoLoad = true;
            _loc_1.source = this._embed_mxml_img_v1_logo_png_485293375;
            _loc_1.useHandCursor = true;
            _loc_1.buttonMode = true;
            _loc_1.setStyle("left", "11");
            _loc_1.setStyle("top", "12");
            _loc_1.addEventListener("click", this.___Skin_Image2_click);
            if (!_loc_1.document)
            {
                _loc_1.document = this;
            }
            return _loc_1;
        }// end function

        private function _Skin_State2_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "zerolimits_skin";
            _loc_1.overrides = [this._Skin_AddChild2_c()];
            return _loc_1;
        }// end function

        private function _Skin_State4_c() : State
        {
            var _loc_1:* = new State();
            _loc_1.name = "zerolimits_options_skin";
            _loc_1.overrides = [this._Skin_AddChild5_c()];
            return _loc_1;
        }// end function

        public function ___Skin_Image4_click(event:MouseEvent) : void
        {
            this.parentDocument.clickSuLogo();
            return;
        }// end function

        private function _Skin_bindingExprs() : void
        {
            var _loc_1:* = undefined;
            _loc_1 = TabIndexManager.INDEX_CLOSE_BUTTON;
            _loc_1 = TabIndexManager.INDEX_CLOSE_BUTTON;
            _loc_1 = TabIndexManager.INDEX_CLOSE_BUTTON;
            return;
        }// end function

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
        {
            _watcherSetupUtil = param1;
            return;
        }// end function

    }
}
