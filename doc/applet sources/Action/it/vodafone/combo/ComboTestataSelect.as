package it.vodafone.combo
{
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import mx.binding.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.styles.*;

    public class ComboTestataSelect extends Canvas implements IBindingClient
    {
        public var _ComboTestataSelect_Button1:Array;
        var _watchers:Array;
        private var _3756vb:VBox;
        private var motion:int;
        private var listaBottoni:Array;
        private var _1932245466_ComboTestataSelect_VBox1:VBox;
        private var _3646rp:Repeater;
        var _bindingsBeginWithWord:Object;
        private var _102982531lista:Array;
        var _bindingsByDestination:Object;
        public var selectedData:String;
        var _bindings:Array;
        private var _documentDescriptor_:UIComponentDescriptor;
        private var selectedIndex:int = -1;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public function ComboTestataSelect()
        {
            this._documentDescriptor_ = new UIComponentDescriptor({type:Canvas, propertiesFactory:function () : Object
            {
                return {width:119, height:200, childDescriptors:[new UIComponentDescriptor({type:VBox, id:"vb", stylesFactory:function () : void
                {
                    this.verticalGap = 0;
                    this.horizontalAlign = "left";
                    this.verticalAlign = "top";
                    return;
                }// end function
                , propertiesFactory:function () : Object
                {
                    return {childDescriptors:[new UIComponentDescriptor({type:Repeater, id:"rp", propertiesFactory:function () : Object
                    {
                        return {childDescriptors:[new UIComponentDescriptor({type:Button, id:"_ComboTestataSelect_Button1", events:{click:"___ComboTestataSelect_Button1_click"}, effects:["rollOverEffect", "focusInEffect"], stylesFactory:function () : void
                        {
                            this.fontFamily = "defFont";
                            this.fontSize = 14;
                            this.color = 16777215;
                            this.cornerRadius = 0;
                            this.textAlign = "left";
                            this.textRollOverColor = 16777215;
                            this.textSelectedColor = 16777215;
                            this.fillAlphas = [1, 1];
                            this.fillColors = [3355443, 3355443, 16711680, 16711680];
                            this.borderColor = 3355443;
                            this.rollOverEffect = "#ff0000";
                            this.focusInEffect = "#ff0000";
                            return;
                        }// end function
                        , propertiesFactory:function () : Object
                        {
                            return {tabEnabled:false, x:0, y:0, height:20, width:119, alpha:1};
                        }// end function
                        }), new UIComponentDescriptor({type:HRule, propertiesFactory:function () : Object
                        {
                            return {x:0, y:18, height:1, width:119};
                        }// end function
                        })]};
                    }// end function
                    })]};
                }// end function
                })]};
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
                this.backgroundColor = 3355443;
                return;
            }// end function
            ;
            this.width = 119;
            this.height = 200;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.addEventListener("mouseMove", this.___ComboTestataSelect_Canvas1_mouseMove);
            this.addEventListener("addedToStage", this.___ComboTestataSelect_Canvas1_addedToStage);
            this.addEventListener("removedFromStage", this.___ComboTestataSelect_Canvas1_removedFromStage);
            return;
        }// end function

        private function get lista() : Array
        {
            return this._102982531lista;
        }// end function

        private function set lista(param1:Array) : void
        {
            var _loc_2:* = this._102982531lista;
            if (_loc_2 !== param1)
            {
                this._102982531lista = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lista", _loc_2, param1));
            }
            return;
        }// end function

        public function updateList(param1:Array) : void
        {
            this.lista = param1;
            if (this.lista.length < 3)
            {
                this.height = 21 * 3;
            }
            else if (this.lista.length <= 6)
            {
                this.height = this.lista.length * 21;
            }
            else
            {
                this.height = 21 * 6;
            }
            this.addEventListener(Event.ENTER_FRAME, this.muovi);
            return;
        }// end function

        private function init() : void
        {
            stage.addEventListener(KeyboardEvent.KEY_DOWN, this.reportKeyDown);
            return;
        }// end function

        private function setupButtonsForToggle() : void
        {
            trace("setupButtonsForToggle");
            if (this.listaBottoni != null)
            {
                return;
            }
            this.listaBottoni = new Array();
            var _loc_1:int = 0;
            while (_loc_1 < this.vb.numChildren)
            {
                
                if (UIComponent(this.vb.getChildAt(_loc_1)).className == "Button")
                {
                    Button(this.vb.getChildAt(_loc_1)).toggle = true;
                    this.listaBottoni.push(this.vb.getChildAt(_loc_1));
                }
                _loc_1++;
            }
            return;
        }// end function

        public function ___ComboTestataSelect_Canvas1_mouseMove(event:MouseEvent) : void
        {
            this.mouseMoving(event);
            return;
        }// end function

        private function cleanup() : void
        {
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.reportKeyDown);
            return;
        }// end function

        public function ___ComboTestataSelect_Canvas1_addedToStage(event:Event) : void
        {
            this.init();
            return;
        }// end function

        private function unsetupButtonsForToggle() : void
        {
            trace("unsetupButtonsForToggle");
            if (this.listaBottoni == null)
            {
                return;
            }
            var _loc_1:int = 0;
            while (_loc_1 < this.vb.numChildren)
            {
                
                if (UIComponent(this.vb.getChildAt(_loc_1)).className == "Button")
                {
                    Button(this.vb.getChildAt(_loc_1)).toggle = false;
                }
                _loc_1++;
            }
            this.listaBottoni = null;
            this.selectedIndex = -1;
            return;
        }// end function

        override public function initialize() : void
        {
            var target:ComboTestataSelect;
            var watcherSetupUtilClass:Object;
            .mx_internal::setDocumentDescriptor(this._documentDescriptor_);
            var bindings:* = this._ComboTestataSelect_bindingsSetup();
            var watchers:Array;
            target;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_it_vodafone_combo_ComboTestataSelectWatcherSetupUtil");
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

        public function get _ComboTestataSelect_VBox1() : VBox
        {
            return this._1932245466_ComboTestataSelect_VBox1;
        }// end function

        private function stringFormatter(param1:String) : String
        {
            if (param1 == null)
            {
                return "";
            }
            return param1.substr(0, 3) + " " + param1.substr(3);
        }// end function

        public function get vb() : VBox
        {
            return this._3756vb;
        }// end function

        public function get rp() : Repeater
        {
            return this._3646rp;
        }// end function

        private function muovi(event:Event) : void
        {
            if (this.motion == 1)
            {
                this.verticalScrollPosition = this.verticalScrollPosition + 2;
            }
            else if (this.motion == -1)
            {
                this.verticalScrollPosition = this.verticalScrollPosition - 2;
            }
            return;
        }// end function

        private function updateSelection() : void
        {
            trace("updateSelection");
            if (this.listaBottoni == null)
            {
                return;
            }
            var _loc_1:int = 0;
            while (_loc_1 < this.listaBottoni.length)
            {
                
                if (_loc_1 == this.selectedIndex)
                {
                    Button(this.listaBottoni[_loc_1]).selected = true;
                }
                else
                {
                    Button(this.listaBottoni[_loc_1]).selected = false;
                }
                _loc_1++;
            }
            return;
        }// end function

        private function mouseStop() : void
        {
            this.motion = 0;
            return;
        }// end function

        private function reportKeyDown(event:KeyboardEvent) : void
        {
            trace("Key Pressed:  (character code: " + event.keyCode + ")");
            if (event.keyCode == 40 && this.selectedIndex < this.lista.length--)
            {
                this.setupButtonsForToggle();
                var _loc_2:String = this;
                _loc_2.selectedIndex = this.selectedIndex++;
                this.updateSelection();
                if (this.selectedIndex > 4)
                {
                    this.verticalScrollPosition = this.verticalScrollPosition + 21;
                }
            }
            else if (event.keyCode == 38 && this.selectedIndex > 0)
            {
                this.setupButtonsForToggle();
                var _loc_2:String = this;
                _loc_2.selectedIndex = this.selectedIndex--;
                this.updateSelection();
                if (this.selectedIndex > 4)
                {
                    this.verticalScrollPosition = this.verticalScrollPosition - 21;
                }
            }
            else if (event.keyCode == 32 && this.selectedIndex >= 0 && this.selectedIndex <= this.lista.length--)
            {
                this.processClick(this.lista[this.selectedIndex]);
            }
            return;
        }// end function

        private function mouseMoving(event:MouseEvent) : void
        {
            var _loc_2:* = new Point(event.stageX, event.stageY);
            _loc_2 = this.globalToLocal(_loc_2);
            if (_loc_2.y > 105)
            {
                this.motion = 1;
            }
            else if (_loc_2.y < 21)
            {
                this.motion = -1;
            }
            else
            {
                this.motion = 0;
            }
            this.unsetupButtonsForToggle();
            return;
        }// end function

        public function set vb(param1:VBox) : void
        {
            var _loc_2:* = this._3756vb;
            if (_loc_2 !== param1)
            {
                this._3756vb = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "vb", _loc_2, param1));
            }
            return;
        }// end function

        private function processClick(param1:String) : void
        {
            this.selectedData = param1;
            dispatchEvent(new Event("user_selection"));
            return;
        }// end function

        public function set _ComboTestataSelect_VBox1(param1:VBox) : void
        {
            var _loc_2:* = this._1932245466_ComboTestataSelect_VBox1;
            if (_loc_2 !== param1)
            {
                this._1932245466_ComboTestataSelect_VBox1 = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_ComboTestataSelect_VBox1", _loc_2, param1));
            }
            return;
        }// end function

        private function _ComboTestataSelect_bindingExprs() : void
        {
            var _loc_1:* = undefined;
            _loc_1 = this.lista;
            _loc_1 = this.stringFormatter(String(this.rp.currentItem));
            return;
        }// end function

        public function ___ComboTestataSelect_Canvas1_removedFromStage(event:Event) : void
        {
            this.cleanup();
            return;
        }// end function

        public function ___ComboTestataSelect_Button1_click(event:MouseEvent) : void
        {
            this.processClick(String(event.currentTarget.getRepeaterItem()));
            return;
        }// end function

        private function _ComboTestataSelect_bindingsSetup() : Array
        {
            var binding:Binding;
            var result:Array;
            binding = new Binding(this, function () : Object
            {
                return lista;
            }// end function
            , function (param1:Object) : void
            {
                rp.dataProvider = param1;
                return;
            }// end function
            , "rp.dataProvider");
            result[0] = binding;
            binding = new RepeatableBinding(this, function (param1:Array, param2:Array) : String
            {
                var _loc_5:* = rp;
                var _loc_3:* = stringFormatter(String(_loc_5.mx_internal::getItemAt(param2[0])));
                var _loc_4:* = _loc_3 == undefined ? (null) : (String(_loc_3));
                return _loc_3 == undefined ? (null) : (String(_loc_3));
            }// end function
            , function (param1:String, param2:Array) : void
            {
                _ComboTestataSelect_Button1[param2[0]].label = param1;
                return;
            }// end function
            , "_ComboTestataSelect_Button1.label");
            result[1] = binding;
            return result;
        }// end function

        public function set rp(param1:Repeater) : void
        {
            var _loc_2:* = this._3646rp;
            if (_loc_2 !== param1)
            {
                this._3646rp = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rp", _loc_2, param1));
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
