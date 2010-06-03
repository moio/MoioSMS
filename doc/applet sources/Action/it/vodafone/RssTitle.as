package it.vodafone
{
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import mx.binding.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;

    public class RssTitle extends Canvas implements IBindingClient
    {
        private var _1004197030textArea:Label;
        private var _110251549testo:String;
        var _bindingsByDestination:Object;
        var _bindingsBeginWithWord:Object;
        private var _3321850link:String;
        var _watchers:Array;
        var _bindings:Array;
        private var _documentDescriptor_:UIComponentDescriptor;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public function RssTitle()
        {
            this._documentDescriptor_ = new UIComponentDescriptor({type:Canvas, propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:Label, id:"textArea", events:{initialize:"__textArea_initialize", click:"__textArea_click"}, stylesFactory:function () : void
                {
                    this.fontFamily = "defFont";
                    this.fontSize = 11;
                    this.color = 3355443;
                    this.fontWeight = "normal";
                    this.fontAntiAliasType = "advanced";
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {x:0, y:2, mouseChildren:false};
                }// end function
                })]};
            }// end function
            });
            this._bindings = [];
            this._watchers = [];
            this._bindingsByDestination = {};
            this._bindingsBeginWithWord = {};
            mx_internal::_document = this;
            return;
        }// end function

        public function __textArea_click(event:MouseEvent) : void
        {
            this.processClick();
            return;
        }// end function

        public function set textArea(param1:Label) : void
        {
            var _loc_2:* = this._1004197030textArea;
            if (_loc_2 !== param1)
            {
                this._1004197030textArea = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "textArea", _loc_2, param1));
            }
            return;
        }// end function

        public function set testo(param1:String) : void
        {
            var _loc_2:* = this._110251549testo;
            if (_loc_2 !== param1)
            {
                this._110251549testo = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "testo", _loc_2, param1));
            }
            return;
        }// end function

        override public function initialize() : void
        {
            var target:RssTitle;
            var watcherSetupUtilClass:Object;
            .mx_internal::setDocumentDescriptor(this._documentDescriptor_);
            var bindings:* = this._RssTitle_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_it_vodafone_RssTitleWatcherSetupUtil");
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

        public function get link() : String
        {
            return this._3321850link;
        }// end function

        private function init() : void
        {
            if (this.link != null)
            {
                this.textArea.buttonMode = true;
                this.textArea.useHandCursor = true;
            }
            else
            {
                this.textArea.buttonMode = false;
                this.textArea.useHandCursor = false;
            }
            return;
        }// end function

        private function processClick() : void
        {
            if (this.link != null)
            {
                navigateToURL(new URLRequest(this.link));
            }
            return;
        }// end function

        public function get testo() : String
        {
            return this._110251549testo;
        }// end function

        public function get textArea() : Label
        {
            return this._1004197030textArea;
        }// end function

        public function set link(param1:String) : void
        {
            var _loc_2:* = this._3321850link;
            if (_loc_2 !== param1)
            {
                this._3321850link = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "link", _loc_2, param1));
            }
            return;
        }// end function

        private function _RssTitle_bindingExprs() : void
        {
            var _loc_1:* = undefined;
            _loc_1 = this.testo;
            return;
        }// end function

        public function __textArea_initialize(event:FlexEvent) : void
        {
            this.init();
            return;
        }// end function

        private function _RssTitle_bindingsSetup() : Array
        {
            var binding:Binding;
            var result:Array;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = testo;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                textArea.text = param1;
                return;
            }// end function
            , "textArea.text");
            result[0] = binding;
            return result;
        }// end function

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
        {
            _watcherSetupUtil = param1;
            return;
        }// end function

    }
}
