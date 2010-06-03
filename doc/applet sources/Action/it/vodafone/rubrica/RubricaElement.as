package it.vodafone.rubrica
{
    import flash.events.*;
    import flash.text.*;
    import mx.events.*;

    public class RubricaElement extends EventDispatcher
    {
        private var _591693646_phoneNumberSpace:String;
        private var _91108202_name:String;
        private var _90977266_item:NomeNumero;
        private var _1815013224_phoneNumber:String;
        private var _1784915920_phoneNumberHtmlText:String;
        private var _1381859070_nameHtmlText:String;
        public static const INSERT_NAME:String = "Inserisci il Nome";
        public static const INSERT_NUMBER:String = "Numero";

        public function RubricaElement(param1:String, param2:String, param3:NomeNumero = null)
        {
            this._name = param1;
            this._phoneNumber = param2;
            this._nameHtmlText = truncateText(param1);
            this._phoneNumberHtmlText = param2;
            this._item = param3;
            return;
        }// end function

        private function get _nameHtmlText() : String
        {
            return this._1381859070_nameHtmlText;
        }// end function

        private function set _nameHtmlText(param1:String) : void
        {
            var _loc_2:* = this._1381859070_nameHtmlText;
            if (_loc_2 !== param1)
            {
                this._1381859070_nameHtmlText = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_nameHtmlText", _loc_2, param1));
            }
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function set nameHtmlText(param1:String) : void
        {
            this._nameHtmlText = param1;
            return;
        }// end function

        private function get _phoneNumberSpace() : String
        {
            return this._591693646_phoneNumberSpace;
        }// end function

        private function get _phoneNumberHtmlText() : String
        {
            return this._1784915920_phoneNumberHtmlText;
        }// end function

        public function get item() : NomeNumero
        {
            return this._item;
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

        public function set name(param1:String) : void
        {
            this._name = param1;
            return;
        }// end function

        public function get phoneNumber() : String
        {
            return this._phoneNumber;
        }// end function

        private function set _phoneNumberSpace(param1:String) : void
        {
            var _loc_2:* = this._591693646_phoneNumberSpace;
            if (_loc_2 !== param1)
            {
                this._591693646_phoneNumberSpace = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_phoneNumberSpace", _loc_2, param1));
            }
            return;
        }// end function

        public function set phoneNumberHtmlText(param1:String) : void
        {
            this._phoneNumberHtmlText = param1;
            return;
        }// end function

        private function set _phoneNumberHtmlText(param1:String) : void
        {
            var _loc_2:* = this._1784915920_phoneNumberHtmlText;
            if (_loc_2 !== param1)
            {
                this._1784915920_phoneNumberHtmlText = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_phoneNumberHtmlText", _loc_2, param1));
            }
            return;
        }// end function

        public function set item(param1:NomeNumero) : void
        {
            this._item = param1;
            return;
        }// end function

        private function get _phoneNumber() : String
        {
            return this._1815013224_phoneNumber;
        }// end function

        public function get nameHtmlText() : String
        {
            return this._nameHtmlText;
        }// end function

        public function set phoneNumber(param1:String) : void
        {
            this._phoneNumber = param1;
            return;
        }// end function

        public function get phoneNumberHtmlText() : String
        {
            return this._phoneNumberHtmlText;
        }// end function

        private function get _name() : String
        {
            return this._91108202_name;
        }// end function

        private function get _item() : NomeNumero
        {
            return this._90977266_item;
        }// end function

        private function set _item(param1:NomeNumero) : void
        {
            var _loc_2:* = this._90977266_item;
            if (_loc_2 !== param1)
            {
                this._90977266_item = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_item", _loc_2, param1));
            }
            return;
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

        public static function formatPhoneNumber(param1:String) : String
        {
            var _loc_2:* = /\+\d{2,}?/g;
            param1 = param1.replace(_loc_2, "");
            var _loc_3:* = /\D*/g;
            param1 = param1.replace(_loc_3, "");
            param1 = insertSpace(param1);
            return param1;
        }// end function

        public static function truncateText(param1:String) : String
        {
            var _loc_2:* = new TextField();
            var _loc_3:* = new TextFormat("defFont", 10);
            _loc_2.setTextFormat(_loc_3);
            _loc_2.width = 114;
            _loc_2.text = param1;
            var _loc_4:Boolean = false;
            if (_loc_2.text.length >= 40)
            {
                _loc_4 = true;
                _loc_2.text = _loc_2.text.substring(0, 40);
            }
            var _loc_5:int = 0;
            while (_loc_2.textWidth >= _loc_2.width - 20)
            {
                
                _loc_4 = true;
                _loc_2.text = _loc_2.text.substring(0, _loc_2.text.length - 3);
                _loc_5++;
                if (_loc_5 == 100)
                {
                    return _loc_2.text;
                }
            }
            if (_loc_4)
            {
                _loc_2.text = _loc_2.text + "...";
            }
            _loc_2.text = setSpecialHtmlChar(_loc_2.text);
            return _loc_2.text;
        }// end function

        public static function formatPhoneNumberNoSpace(param1:String) : String
        {
            var _loc_2:* = /\+\d{2,}?/g;
            param1 = param1.replace(_loc_2, "");
            var _loc_3:* = /\D*/g;
            param1 = param1.replace(_loc_3, "");
            return param1;
        }// end function

        public static function setSpecialHtmlChar(param1:String) : String
        {
            param1 = RubricaUser.replaceString("&", "&amp;", param1);
            param1 = RubricaUser.replaceString("<", "&lt;", param1);
            param1 = RubricaUser.replaceString(">", "&gt;", param1);
            return param1;
        }// end function

        public static function checkNumber(param1:String) : Boolean
        {
            if (param1 != "" && param1 != INSERT_NUMBER)
            {
                return true;
            }
            return false;
        }// end function

        public static function checkName(param1:String) : Boolean
        {
            trace("checkName: " + param1);
            if (param1 != "" && param1 != INSERT_NAME)
            {
                return true;
            }
            return false;
        }// end function

        public static function insertSpace(param1:String) : String
        {
            return param1.substring(0, 3) + " " + param1.substring(3, param1.length);
        }// end function

    }
}
