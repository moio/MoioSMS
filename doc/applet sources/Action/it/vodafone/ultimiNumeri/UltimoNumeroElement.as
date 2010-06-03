package it.vodafone.ultimiNumeri
{
    import flash.events.*;
    import flash.text.*;
    import mx.events.*;

    public class UltimoNumeroElement extends Object implements IEventDispatcher
    {
        private var _91108202_name:String;
        private var _90977266_item:UltimoNumero;
        private var _1815013224_phoneNumber:String;
        private var _bindingEventDispatcher:EventDispatcher;

        public function UltimoNumeroElement(param1:String, param2:String)
        {
            this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            this._name = param1;
            this._phoneNumber = param2;
            return;
        }// end function

        public function dispatchEvent(event:Event) : Boolean
        {
            return this._bindingEventDispatcher.dispatchEvent(event);
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            this._bindingEventDispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            this._bindingEventDispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function get item() : UltimoNumero
        {
            return this._item;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return this._bindingEventDispatcher.willTrigger(param1);
        }// end function

        public function set name(param1:String) : void
        {
            this._name = param1;
            return;
        }// end function

        public function get phoneNumber() : String
        {
            return this._phoneNumber;
        }// end function

        private function set _name(param1:String) : void
        {
            var _loc_2:* = this._91108202_name;
            if (_loc_2 !== param1)
            {
                this._91108202_name = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_name", _loc_2, param1));
            }
            return;
        }// end function

        private function get _phoneNumber() : String
        {
            return this._1815013224_phoneNumber;
        }// end function

        public function set item(param1:UltimoNumero) : void
        {
            this._item = param1;
            return;
        }// end function

        private function get _name() : String
        {
            return this._91108202_name;
        }// end function

        private function set _item(param1:UltimoNumero) : void
        {
            var _loc_2:* = this._90977266_item;
            if (_loc_2 !== param1)
            {
                this._90977266_item = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_item", _loc_2, param1));
            }
            return;
        }// end function

        public function set phoneNumber(param1:String) : void
        {
            this._phoneNumber = param1;
            return;
        }// end function

        private function get _item() : UltimoNumero
        {
            return this._90977266_item;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return this._bindingEventDispatcher.hasEventListener(param1);
        }// end function

        private function set _phoneNumber(param1:String) : void
        {
            var _loc_2:* = this._1815013224_phoneNumber;
            if (_loc_2 !== param1)
            {
                this._1815013224_phoneNumber = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_phoneNumber", _loc_2, param1));
            }
            return;
        }// end function

        public static function truncateText(param1:String) : String
        {
            var _loc_2:* = new TextField();
            var _loc_3:* = new TextFormat("defFont", 10);
            _loc_2.setTextFormat(_loc_3);
            _loc_2.width = 114;
            _loc_2.text = param1;
            while (_loc_2.textWidth >= _loc_2.width - 14)
            {
                
                _loc_2.text = _loc_2.text.substring(0, _loc_2.text.length - 3);
            }
            return _loc_2.text + "...";
        }// end function

    }
}
