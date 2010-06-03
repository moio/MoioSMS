package it.vodafone
{
    import flash.events.*;
    import flash.utils.*;
    import it.vodafone.combo.*;
    import mx.binding.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;

    public class Testata extends Canvas implements IBindingClient
    {
        private var _107002ldr:Loading;
        private var _1714148973displayName:String = "";
        private var _1123684748_selectedMsisdn:String = null;
        public const ZEROLIMITS_SKIN:String = "zerolimits_skin";
        var _watchers:Array;
        private var _293585097_msisdnList:Array;
        public const SKIN_TYPE:String = "vodafone_skin";
        var _bindingsByDestination:Object;
        private var _607923297labelName:Label;
        private var _1481743114displayNameColor:Number = 3355443;
        var _bindingsBeginWithWord:Object;
        private var _491303079c_lista:ComboTestata;
        public const VODAFONE_SKIN:String = "vodafone_skin";
        var _bindings:Array;
        private var _documentDescriptor_:UIComponentDescriptor;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public function Testata()
        {
            this._documentDescriptor_ = new UIComponentDescriptor({type:Canvas, propertiesFactory:function () : Object
            {
                return {width:266, height:60, childDescriptors:[new UIComponentDescriptor({type:Label, id:"labelName", events:{initialize:"__labelName_initialize"}, stylesFactory:function () : void
                {
                    this.fontFamily = "defFont";
                    this.fontWeight = "bold";
                    this.fontSize = 11;
                    this.textAlign = "right";
                    this.right = "8";
                    this.top = "3";
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {width:248};
                }// end function
                }), new UIComponentDescriptor({type:Label, stylesFactory:function () : void
                {
                    this.fontFamily = "defFont";
                    this.fontSize = 11;
                    this.color = 3355443;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {x:10, y:35, text:"Stai usando il numero:"};
                }// end function
                }), new UIComponentDescriptor({type:ComboTestata, id:"c_lista", events:{change:"__c_lista_change"}, stylesFactory:function () : void
                {
                    this.themeColor = 13369858;
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {x:137, y:33};
                }// end function
                })]};
            }// end function
            });
            this._293585097_msisdnList = new Array();
            this._bindings = [];
            this._watchers = [];
            this._bindingsByDestination = {};
            this._bindingsBeginWithWord = {};
            mx_internal::_document = this;
            this.width = 266;
            this.height = 60;
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            return;
        }// end function

        private function convertCase(param1:String) : String
        {
            var _loc_2:String = "";
            var _loc_3:Boolean = true;
            var _loc_4:int = 0;
            while (_loc_4 < param1.length)
            {
                
                if (_loc_3)
                {
                    _loc_2 = _loc_2 + param1.charAt(_loc_4).toUpperCase();
                }
                else
                {
                    _loc_2 = _loc_2 + param1.charAt(_loc_4).toLowerCase();
                }
                if (param1.charAt(_loc_4) == " " || param1.charAt(_loc_4) == ".")
                {
                    _loc_3 = true;
                }
                else
                {
                    _loc_3 = false;
                }
                _loc_4++;
            }
            if (_loc_2.toUpperCase() == "NULL")
            {
                _loc_2 = "";
            }
            return _loc_2;
        }// end function

        public function set ldr(param1:Loading) : void
        {
            var _loc_2:* = this._107002ldr;
            if (_loc_2 !== param1)
            {
                this._107002ldr = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ldr", _loc_2, param1));
            }
            return;
        }// end function

        override public function initialize() : void
        {
            var target:Testata;
            var watcherSetupUtilClass:Object;
            .mx_internal::setDocumentDescriptor(this._documentDescriptor_);
            var bindings:* = this._Testata_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_it_vodafone_TestataWatcherSetupUtil");
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

        private function logout() : void
        {
            dispatchEvent(new Event("logout"));
            return;
        }// end function

        public function __labelName_initialize(event:FlexEvent) : void
        {
            this.setColor();
            return;
        }// end function

        private function setColor() : void
        {
            switch(this.SKIN_TYPE)
            {
                case this.VODAFONE_SKIN:
                {
                    this.displayNameColor = 3355443;
                    break;
                }
                case this.ZEROLIMITS_SKIN:
                {
                    this.displayNameColor = 16777215;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function get labelName() : Label
        {
            return this._607923297labelName;
        }// end function

        public function get c_lista() : ComboTestata
        {
            return this._491303079c_lista;
        }// end function

        public function __c_lista_change(event:Event) : void
        {
            this.userUpdatedMsisdn();
            return;
        }// end function

        public function set selectedMsisdn(param1:String) : void
        {
            if (this._selectedMsisdn != param1)
            {
                this._selectedMsisdn = param1;
                this.updateSelectedMsisdn();
            }
            return;
        }// end function

        private function _Testata_bindingsSetup() : Array
        {
            var binding:Binding;
            var result:Array;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = "Ciao " + convertCase(displayName) + "!";
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                labelName.text = param1;
                return;
            }// end function
            , "labelName.text");
            result[0] = binding;
            binding = new Binding(this, function () : uint
            {
                return displayNameColor;
            }// end function
            , function (param1:uint) : void
            {
                labelName.setStyle("color", param1);
                return;
            }// end function
            , "labelName.color");
            result[1] = binding;
            binding = new Binding(this, function () : Array
            {
                return _msisdnList;
            }// end function
            , function (param1:Array) : void
            {
                c_lista.dataProvider = param1;
                return;
            }// end function
            , "c_lista.dataProvider");
            result[2] = binding;
            binding = new Binding(this, function () : Loading
            {
                return ldr;
            }// end function
            , function (param1:Loading) : void
            {
                c_lista.ldr = param1;
                return;
            }// end function
            , "c_lista.ldr");
            result[3] = binding;
            binding = new Binding(this, function () : int
            {
                return TabIndexManager.INDEX_COMBO_NUMBER;
            }// end function
            , function (param1:int) : void
            {
                c_lista.tabIndex = param1;
                return;
            }// end function
            , "c_lista.tabIndex");
            result[4] = binding;
            return result;
        }// end function

        public function set msisdnList(param1:Array) : void
        {
            this._msisdnList = param1;
            this.updateSelectedMsisdn();
            return;
        }// end function

        private function get _msisdnList() : Array
        {
            return this._293585097_msisdnList;
        }// end function

        private function _Testata_bindingExprs() : void
        {
            var _loc_1:* = undefined;
            _loc_1 = "Ciao " + this.convertCase(this.displayName) + "!";
            _loc_1 = this.displayNameColor;
            _loc_1 = this._msisdnList;
            _loc_1 = this.ldr;
            _loc_1 = TabIndexManager.INDEX_COMBO_NUMBER;
            return;
        }// end function

        public function set labelName(param1:Label) : void
        {
            var _loc_2:* = this._607923297labelName;
            if (_loc_2 !== param1)
            {
                this._607923297labelName = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "labelName", _loc_2, param1));
            }
            return;
        }// end function

        public function set c_lista(param1:ComboTestata) : void
        {
            var _loc_2:* = this._491303079c_lista;
            if (_loc_2 !== param1)
            {
                this._491303079c_lista = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "c_lista", _loc_2, param1));
            }
            return;
        }// end function

        public function get selectedMsisdn() : String
        {
            return this._selectedMsisdn;
        }// end function

        public function set displayName(param1:String) : void
        {
            var _loc_2:* = this._1714148973displayName;
            if (_loc_2 !== param1)
            {
                this._1714148973displayName = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "displayName", _loc_2, param1));
            }
            return;
        }// end function

        private function set _selectedMsisdn(param1:String) : void
        {
            var _loc_2:* = this._1123684748_selectedMsisdn;
            if (_loc_2 !== param1)
            {
                this._1123684748_selectedMsisdn = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_selectedMsisdn", _loc_2, param1));
            }
            return;
        }// end function

        private function userUpdatedMsisdn() : void
        {
            if (this.c_lista.selectedItem.toString() != this._selectedMsisdn)
            {
                this._selectedMsisdn = this.c_lista.selectedItem.toString();
                dispatchEvent(new Event("msisdnUpdated"));
            }
            return;
        }// end function

        public function get displayName() : String
        {
            return this._1714148973displayName;
        }// end function

        private function set _msisdnList(param1:Array) : void
        {
            var _loc_2:* = this._293585097_msisdnList;
            if (_loc_2 !== param1)
            {
                this._293585097_msisdnList = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_msisdnList", _loc_2, param1));
            }
            return;
        }// end function

        public function set displayNameColor(param1:Number) : void
        {
            var _loc_2:* = this._1481743114displayNameColor;
            if (_loc_2 !== param1)
            {
                this._1481743114displayNameColor = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "displayNameColor", _loc_2, param1));
            }
            return;
        }// end function

        public function get ldr() : Loading
        {
            return this._107002ldr;
        }// end function

        private function get _selectedMsisdn() : String
        {
            return this._1123684748_selectedMsisdn;
        }// end function

        public function get displayNameColor() : Number
        {
            return this._1481743114displayNameColor;
        }// end function

        private function updateSelectedMsisdn() : void
        {
            var _loc_1:* = this._msisdnList.indexOf(this._selectedMsisdn);
            if (_loc_1 >= 0 && _loc_1 != this.c_lista.selectedIndex)
            {
                this.c_lista.selectedIndex = _loc_1;
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
