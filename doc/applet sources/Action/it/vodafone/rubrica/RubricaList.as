package it.vodafone.rubrica
{
    import flash.display.*;
    import flash.events.*;
    import flash.ui.*;
    import flash.utils.*;
    import it.vodafone.*;
    import mx.binding.*;
    import mx.containers.*;
    import mx.core.*;
    import mx.events.*;
    import mx.styles.*;

    public class RubricaList extends VBox implements IBindingClient
    {
        private var _indexSelectedItem:Number = 0;
        var _bindingsByDestination:Object;
        var _bindingsBeginWithWord:Object;
        private const ITEM_HEIGHT:Number = 16.75;
        var _watchers:Array;
        var _bindings:Array;
        private var _elementInEditMode:NomeNumero;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var _1763739238_dataProvider:Array;
        private static var _isKeyDownEnabled:Boolean = true;
        private static var _hasBeenShown:Boolean = false;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public function RubricaList()
        {
            this._documentDescriptor_ = new UIComponentDescriptor({type:VBox, propertiesFactory:function () : Object
            {
                return {width:243, height:67};
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
                this.verticalGap = 1;
                this.paddingLeft = 0;
                this.paddingTop = 0;
                this.paddingBottom = 0;
                this.borderStyle = "none";
                return;
            }// end function
            ;
            this.tabEnabled = false;
            this.width = 243;
            this.height = 67;
            this.verticalScrollPolicy = "on";
            this.horizontalScrollPolicy = "off";
            this.addEventListener("keyDown", this.___RubricaList_VBox1_keyDown);
            this.addEventListener("initialize", this.___RubricaList_VBox1_initialize);
            this.addEventListener("mouseOver", this.___RubricaList_VBox1_mouseOver);
            this.addEventListener("mouseOut", this.___RubricaList_VBox1_mouseOut);
            return;
        }// end function

        private function _RubricaList_bindingsSetup() : Array
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

        public function selectFirstElement() : void
        {
            if (this._dataProvider.length > 0)
            {
                this._dataProvider[0].item.selectElement(true);
            }
            else
            {
                dispatchEvent(new RubricaElementEvent(RubricaElementEvent.SELECT_ELEMENT, "", null, null, true));
            }
            return;
        }// end function

        private function onKeyDown(event:KeyboardEvent) : void
        {
            if (_isKeyDownEnabled)
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
                            this._dataProvider[this._indexSelectedItem].item.textOver(true);
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
                            this._dataProvider[this._indexSelectedItem].item.textOver(true);
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
            }
            return;
        }// end function

        override public function initialize() : void
        {
            var target:RubricaList;
            var watcherSetupUtilClass:Object;
            .mx_internal::setDocumentDescriptor(this._documentDescriptor_);
            var bindings:* = this._RubricaList_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_it_vodafone_rubrica_RubricaListWatcherSetupUtil");
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
            this.drawListExtended(param1, false);
            return;
        }// end function

        public function disableKeyDown(event:MouseEvent) : void
        {
            if (this.contains(event.target as DisplayObject))
            {
                _isKeyDownEnabled = false;
            }
            return;
        }// end function

        public function drawListExtended(param1:String, param2:Boolean) : void
        {
            var _loc_3:Number = NaN;
            var _loc_7:RubricaElement = null;
            var _loc_8:NomeNumero = null;
            var _loc_9:Number = NaN;
            var _loc_10:NomeNumero = null;
            trace("RubricaLista, drawListExtended - BEGIN");
            this.removeAllChildren();
            _loc_3 = 0;
            var _loc_4:Number = 0;
            this.visible = true;
            var _loc_5:Number = 0;
            while (_loc_5++ < this._dataProvider.length)
            {
                
                _loc_7 = new RubricaElement(this._dataProvider[_loc_5].name, this._dataProvider[_loc_5].phoneNumber);
                if (param2)
                {
                    var _loc_11:* = RubricaElement.truncateText(_loc_7.name);
                    this._dataProvider[_loc_5].nameHtmlText = RubricaElement.truncateText(_loc_7.name);
                    _loc_7.nameHtmlText = _loc_11;
                    var _loc_11:* = _loc_7.phoneNumber;
                    this._dataProvider[_loc_5].phoneNumberHtmlText = _loc_7.phoneNumber;
                    _loc_7.phoneNumberHtmlText = _loc_11;
                }
                else
                {
                    _loc_7.nameHtmlText = this._dataProvider[_loc_5].nameHtmlText;
                    _loc_7.phoneNumberHtmlText = this._dataProvider[_loc_5].phoneNumberHtmlText;
                }
                _loc_7.phoneNumberHtmlText = this._dataProvider[_loc_5].phoneNumberHtmlText;
                if (param1 != "" && _loc_7.phoneNumber == param1)
                {
                    _loc_4 = _loc_3;
                }
                _loc_8 = new NomeNumero();
                _loc_8.itemData = _loc_7;
                this._dataProvider[_loc_5].item = _loc_8;
                _loc_8.init();
                this.addChild(_loc_8);
                _loc_3 = _loc_3 + this.ITEM_HEIGHT;
            }
            var _loc_6:* = 4 - this._dataProvider.length;
            if (4 - this._dataProvider.length > 0)
            {
                _loc_9 = 0;
                while (_loc_9++ < _loc_6)
                {
                    
                    _loc_10 = new NomeNumero();
                    _loc_10.currentState = "empty";
                    this.addChild(_loc_10);
                    _loc_3 = _loc_3 + this.ITEM_HEIGHT;
                }
            }
            this.verticalScrollPosition = _loc_4;
            trace("RubricaLista, drawListExtended - END");
            return;
        }// end function

        public function enableKeyDown(event:MouseEvent) : void
        {
            if (this.contains(event.target as DisplayObject))
            {
                _isKeyDownEnabled = true;
            }
            return;
        }// end function

        private function init() : void
        {
            this.addEventListener(NomeNumero.EDIT_MODE_ENTER, this.editModeEntered);
            this.addEventListener(NomeNumero.NO_EDIT_MODE_ENTER, this.noEditModeEntered);
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

        private function noEditModeEntered(event:Event) : void
        {
            this._elementInEditMode = null;
            var _loc_2:Number = 0;
            while (_loc_2++ < this._dataProvider.length)
            {
                
                this._dataProvider[_loc_2].item.enabled = true;
            }
            return;
        }// end function

        private function editModeEntered(event:Event) : void
        {
            var _loc_3:NomeNumero = null;
            var _loc_2:Number = 0;
            while (_loc_2++ < this._dataProvider.length)
            {
                
                _loc_3 = this._dataProvider[_loc_2].item;
                if (_loc_3 == event.target)
                {
                    _loc_3.enabled = true;
                    this._elementInEditMode = _loc_3;
                    continue;
                }
                if (_loc_3.currentState == "edit")
                {
                    _loc_3.deleteEdit(false);
                }
                _loc_3.enabled = false;
            }
            return;
        }// end function

        public function get elementInEditMode() : NomeNumero
        {
            return this._elementInEditMode;
        }// end function

        public function editModeEnteredByPosition(param1:Number) : void
        {
            var _loc_2:NomeNumero = null;
            trace("RubricaList, editModeEnteredByPosition - BEGIN");
            if (param1 < this._dataProvider.length)
            {
                _loc_2 = this._dataProvider[param1].item;
                _loc_2.editMode();
                this.verticalScrollPosition = param1 * this.ITEM_HEIGHT;
            }
            trace("RubricaList, editModeEnteredByPosition - END");
            return;
        }// end function

        public function ___RubricaList_VBox1_keyDown(event:KeyboardEvent) : void
        {
            this.onKeyDown(event);
            return;
        }// end function

        private function _RubricaList_bindingExprs() : void
        {
            var _loc_1:* = undefined;
            _loc_1 = this.ITEM_HEIGHT;
            return;
        }// end function

        public function ___RubricaList_VBox1_initialize(event:FlexEvent) : void
        {
            this.init();
            return;
        }// end function

        public function ___RubricaList_VBox1_mouseOut(event:MouseEvent) : void
        {
            this.enableKeyDown(event);
            return;
        }// end function

        public function ___RubricaList_VBox1_mouseOver(event:MouseEvent) : void
        {
            this.disableKeyDown(event);
            return;
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

        public function set dataProvider(param1:Array) : void
        {
            this._indexSelectedItem = 0;
            this._dataProvider = param1;
            this.drawList();
            return;
        }// end function

        public static function set hasBeenShown(param1:Boolean) : void
        {
            _hasBeenShown = param1;
            trace("RubricaList, set hasBeenShown: " + _hasBeenShown);
            return;
        }// end function

        public static function get hasBeenShown() : Boolean
        {
            trace("RubricaList, get hasBeenShown: " + _hasBeenShown);
            return _hasBeenShown;
        }// end function

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
        {
            RubricaList._watcherSetupUtil = param1;
            return;
        }// end function

    }
}
