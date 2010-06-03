package it.vodafone.tooltip
{
    import flash.filters.*;
    import flash.utils.*;
    import mx.binding.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;

    public class CustomToolTip extends Canvas implements IBindingClient, IToolTip
    {
        public var _CustomToolTip_Label1:Label;
        var _bindingsByDestination:Object;
        private var _text:String;
        var _bindingsBeginWithWord:Object;
        var _watchers:Array;
        private var shadow:DropShadowFilter;
        private var _documentDescriptor_:UIComponentDescriptor;
        var _bindings:Array;
        public static const OPEN_RUBRICA_TT:String = "Apri Rubrica";
        public static const CLOSE_RUBRICA_TT:String = "Chiudi Rubrica";
        public static const CLOSE_ULTIMI_NUMERI_TT:String = "Chiudi Ultimi numeri";
        public static const OPEN_ULTIMI_NUMERI_TT:String = "Apri Ultimi numeri";
        public static const CANCELLA_TT:String = "Cancella";
        public static const DELETE_ULTIMI_NUMERI:String = "Cancella da Ultimi numeri";
        public static const EDIT_SALVA_RUBRICA_TT:String = "Salva";
        public static const SELEZIONA_TT:String = "Seleziona";
        public static const NOME_CONTATTO_TT:String = "Nome del contatto";
        public static const ADD_ANNULLA_RUBRICA_TT:String = "Annulla";
        public static const NUMERO_CONTATTO_TT:String = "Numero del contatto";
        public static const MODIFICA_TT:String = "Modifica";
        public static const NEW_TT:String = "Scopri le novità ";
        public static const ADD_RUBRICA_TT:String = "Aggiungi a Rubrica";
        public static const ADD_ULTIMI_NUMERI_TT:String = "Aggiungi a Rubrica";
        private static var _watcherSetupUtil:IWatcherSetupUtil;
        public static const EDIT_ULTIMI_NUMERI_TT:String = "Modifica";
        public static const EDIT_ANNULLA_RUBRICA_TT:String = "Annulla";
        public static const ADD_SALVA_RUBRICA_TT:String = "Salva";

        public function CustomToolTip()
        {
            this._documentDescriptor_ = new UIComponentDescriptor({type:Canvas, propertiesFactory:function () : Object
            {
                return {childDescriptors:[new UIComponentDescriptor({type:VBox, stylesFactory:function () : void
                {
                    this.borderThickness = 1;
                    this.fontFamily = "defFont";
                    this.fontSize = 11;
                    this.backgroundColor = 15921906;
                    this.borderColor = 0;
                    this.borderStyle = "solid";
                    this.cornerRadius = 1;
                    this.horizontalAlign = "center";
                    this.paddingTop = 0;
                    this.verticalGap = 0;
                    this.verticalAlign = "middle";
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {alpha:1, height:16, childDescriptors:[new UIComponentDescriptor({type:Label, id:"_CustomToolTip_Label1", stylesFactory:function () : void
                    {
                        this.paddingTop = -1;
                        return;
                    }// end function
                    })]};
                }// end function
                })]};
            }// end function
            });
            this.shadow = new DropShadowFilter();
            this._bindings = [];
            this._watchers = [];
            this._bindingsByDestination = {};
            this._bindingsBeginWithWord = {};
            mx_internal::_document = this;
            this.addEventListener("initialize", this.___CustomToolTip_Canvas1_initialize);
            return;
        }// end function

        public function drawShadow() : void
        {
            this.shadow.distance = 0;
            this.shadow.angle = 25;
            this.shadow.quality = 1;
            this.shadow.alpha = 0.7;
            this.filters = [this.shadow];
            return;
        }// end function

        private function _CustomToolTip_bindingExprs() : void
        {
            var _loc_1:* = undefined;
            _loc_1 = this._text;
            return;
        }// end function

        override public function initialize() : void
        {
            var target:CustomToolTip;
            var watcherSetupUtilClass:Object;
            .mx_internal::setDocumentDescriptor(this._documentDescriptor_);
            var bindings:* = this._CustomToolTip_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_it_vodafone_tooltip_CustomToolTipWatcherSetupUtil");
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

        public function ___CustomToolTip_Canvas1_initialize(event:FlexEvent) : void
        {
            this.drawShadow();
            return;
        }// end function

        private function _CustomToolTip_bindingsSetup() : Array
        {
            var binding:Binding;
            var result:Array;
            binding = new Binding(this, function () : String
            {
                var _loc_1:* = _text;
                var _loc_2:* = _loc_1 == undefined ? (null) : (String(_loc_1));
                return _loc_2;
            }// end function
            , function (param1:String) : void
            {
                _CustomToolTip_Label1.text = param1;
                return;
            }// end function
            , "_CustomToolTip_Label1.text");
            result[0] = binding;
            return result;
        }// end function

        public function set text(param1:String) : void
        {
            this._text = param1;
            return;
        }// end function

        public function get text() : String
        {
            return this._text;
        }// end function

        public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
        {
            _watcherSetupUtil = param1;
            return;
        }// end function

    }
}
