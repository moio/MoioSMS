package it.vodafone.ultimiNumeri
{
    import flash.events.*;
    import flash.ui.*;
    import flash.utils.*;
    import it.vodafone.*;
    import it.vodafone.rubrica.*;
    import mx.binding.*;
    import mx.containers.*;
    import mx.core.*;
    import mx.events.*;
    import mx.styles.*;

    public class UltimiNumeriList extends VBox implements IBindingClient
    {
        private var _indexSelectedItem:Number = 0;
        var _bindingsByDestination:Object;
        var _bindingsBeginWithWord:Object;
        private const ITEM_HEIGHT:Number = 16.75;
        var _watchers:Array;
        var _bindings:Array;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var _1763739238_dataProvider:Array;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public function UltimiNumeriList()
        {
            this._documentDescriptor_ = new UIComponentDescriptor({type:VBox, propertiesFactory:function () : Object
            {
                return {width:243, height:82};
            }// end function
            });
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
                this.verticalGap = 0.5;
                this.paddingLeft = 0;
                this.paddingTop = 0;
                this.paddingBottom = 0;
                this.borderStyle = "none";
                return;
            }// end function
            ;
            this.tabEnabled = false;
            this.width = 243;
            this.height = 82;
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            this.addEventListener("initialize", this.___UltimiNumeriList_VBox1_initialize);
            return;
        }// end function

        public function set dataProvider(param1:Array) : void
        {
            this._indexSelectedItem = 0;
            this._dataProvider = param1;
            this.drawList();
            return;
        }// end function

        private function onKeyDown(event:KeyboardEvent) : void
        {
            switch(event.keyCode)
            {
                case Keyboard.DOWN:
                {
                    if (this._indexSelectedItem < this._dataProvider.length--)
                    {
                        this._dataProvider[this._indexSelectedItem].item.textOut();
                        var _loc_2:String = this;
                        _loc_2._indexSelectedItem = this._indexSelectedItem++;
                        this._dataProvider[this._indexSelectedItem].item.textOver();
                    }
                    break;
                }
                case Keyboard.UP:
                {
                    if (this._indexSelectedItem > 0)
                    {
                        this._dataProvider[this._indexSelectedItem].item.textOut();
                        var _loc_2:String = this;
                        _loc_2._indexSelectedItem = this._indexSelectedItem--;
                        this._dataProvider[this._indexSelectedItem].item.textOver();
                    }
                    else
                    {
                        this._dataProvider[this._indexSelectedItem].item.textOut();
                        this.dispatchEvent(new Event(Sms.SET_FOCUS_TO_TEXT_NUMBER, true));
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

        override public function initialize() : void
        {
            var target:UltimiNumeriList;
            var watcherSetupUtilClass:Object;
            .mx_internal::setDocumentDescriptor(this._documentDescriptor_);
            var bindings:* = this._UltimiNumeriList_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_it_vodafone_ultimiNumeri_UltimiNumeriListWatcherSetupUtil");
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

        public function drawList(param1:String = "") : void
        {
            var _loc_7:String = null;
            var _loc_8:String = null;
            var _loc_9:int = 0;
            var _loc_10:UltimoNumeroElement = null;
            var _loc_11:UltimoNumero = null;
            var _loc_12:Number = NaN;
            var _loc_13:UltimoNumero = null;
            trace("UltimiNumeriList, drawList, list: " + this._dataProvider);
            this.removeAllChildren();
            var _loc_2:Number = 0;
            var _loc_3:Number = 0;
            this.visible = true;
            trace("UltimiNumeriList, drowList: loading rubrica");
            var _loc_4:* = RubricaUser.getIstance(ServerBridge.getServerBridgeInstance().username.toUpperCase());
            var _loc_5:Number = 0;
            while (_loc_5++ < this._dataProvider.length)
            {
                
                _loc_7 = "";
                _loc_8 = this._dataProvider[_loc_5].phoneNumber;
                trace("UltimiNumeriList, drowList: check if element exists");
                _loc_9 = _loc_4.isInList(_loc_8);
                if (_loc_9 != -1)
                {
                    trace("UltimiNumeriList, drowList: found");
                    _loc_7 = _loc_4.list[_loc_9].name;
                    trace("UltimiNumeriList, drowList: name assigned");
                }
                _loc_10 = new UltimoNumeroElement(_loc_7, _loc_8);
                _loc_11 = new UltimoNumero();
                _loc_11.itemData = _loc_10;
                this._dataProvider[_loc_5].item = _loc_11;
                _loc_11.init();
                if (_loc_9 != -1)
                {
                    _loc_11.setModality(true);
                }
                this.addChild(_loc_11);
                trace("UltimiNumeriList, drawList, addChild di |" + _loc_11.nome_txt + "|, |" + _loc_11.numero_txt + "|");
                _loc_2 = _loc_2 + this.ITEM_HEIGHT;
            }
            var _loc_6:* = 5 - this._dataProvider.length;
            if (5 - this._dataProvider.length > 0)
            {
                _loc_12 = 0;
                while (_loc_12++ < _loc_6)
                {
                    
                    _loc_13 = new UltimoNumero();
                    _loc_13.currentState = "empty";
                    this.addChild(_loc_13);
                    trace("UltimiNumeriList, drawList, addChild di empty");
                    _loc_2 = _loc_2 + this.ITEM_HEIGHT;
                }
            }
            this.verticalScrollPosition = _loc_3;
            return;
        }// end function

        private function init() : void
        {
            return;
        }// end function

        private function get _dataProvider() : Array
        {
            return this._1763739238_dataProvider;
        }// end function

        public function setFocusFirstElement() : void
        {
            try
            {
                this._dataProvider[0].item.setFocus();
                this._dataProvider[0].item.textOver();
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        private function _UltimiNumeriList_bindingsSetup() : Array
        {
            var binding:Binding;
            var result:Array;
            binding = new Binding(this, function () : Number
            {
                return ITEM_HEIGHT;
            }// end function
            , function (param1:Number) : void
            {
                this.verticalLineScrollSize = param1;
                return;
            }// end function
            , "this.verticalLineScrollSize");
            result[0] = binding;
            return result;
        }// end function

        private function set _dataProvider(param1:Array) : void
        {
            var _loc_2:* = this._1763739238_dataProvider;
            if (_loc_2 !== param1)
            {
                this._1763739238_dataProvider = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_dataProvider", _loc_2, param1));
            }
            return;
        }// end function

        public function ___UltimiNumeriList_VBox1_initialize(event:FlexEvent) : void
        {
            this.init();
            return;
        }// end function

        private function _UltimiNumeriList_bindingExprs() : void
        {
            var _loc_1:* = undefined;
            _loc_1 = this.ITEM_HEIGHT;
            return;
        }// end function

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
        {
            UltimiNumeriList._watcherSetupUtil = param1;
            return;
        }// end function

    }
}
