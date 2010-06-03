package it.vodafone.rubrica
{
    import flash.events.*;
    import it.vodafone.*;

    public class RubricaUser extends EventDispatcher
    {
        private var _isEmpty:Boolean;
        private const RUBRICA:String = "RUBRICA_";
        private var _username:String;
        private var _list:Array;
        private static var _rubricaIstance:RubricaUser;

        public function RubricaUser(param1:String)
        {
            this._username = param1.toUpperCase();
            this.loadRubrica();
            return;
        }// end function

        public function search(param1:String, param2:Boolean = false) : Array
        {
            var _loc_6:Number = NaN;
            var _loc_7:RegExp = null;
            var _loc_8:String = null;
            var _loc_9:RegExp = null;
            var _loc_10:Boolean = false;
            var _loc_11:RegExp = null;
            var _loc_12:Boolean = false;
            var _loc_13:Boolean = false;
            trace("RubricaUser - search: s=" + param1);
            var _loc_3:String = "#0b333c";
            var _loc_4:String = "#777777";
            var _loc_5:* = new Array();
            if (param1 == "")
            {
                _loc_6 = 0;
                while (_loc_6++ < this._list.length)
                {
                    
                    this._list[_loc_6].phoneNumberHtmlText = this._list[_loc_6].phoneNumber;
                    this._list[_loc_6].nameHtmlText = RubricaElement.truncateText(this._list[_loc_6].name);
                    _loc_5.push(this._list[_loc_6]);
                }
            }
            else
            {
                param1 = this.replaceSpecialChar(param1);
                param1 = param1.toLowerCase();
                _loc_7 = new RegExp("^" + param1 + "| +" + param1, "i");
                _loc_8 = RubricaElement.setSpecialHtmlChar(param1);
                _loc_9 = new RegExp("^" + _loc_8 + "| +" + _loc_8, "i");
                _loc_10 = false;
                if (isPhoneNumber(param1))
                {
                    _loc_10 = true;
                    param1 = RubricaElement.formatPhoneNumberNoSpace(param1);
                    if (param1.length > 3 && param1.charAt(3) != " ")
                    {
                        param1 = RubricaElement.insertSpace(param1);
                    }
                }
                _loc_11 = new RegExp("^" + param1, "i");
                _loc_6 = 0;
                while (_loc_6++ < this._list.length)
                {
                    
                    _loc_12 = _loc_7.test(this._list[_loc_6].name.toLowerCase());
                    if (_loc_11.test(this._list[_loc_6].phoneNumber))
                    {
                        _loc_11.test(this._list[_loc_6].phoneNumber);
                    }
                    _loc_13 = param1.length > 0;
                    if (_loc_10)
                    {
                        if (_loc_12 && _loc_13)
                        {
                            if (param2)
                            {
                                this._list[_loc_6].nameHtmlText = "<font color=\'" + _loc_4 + "\'>" + RubricaElement.truncateText(this._list[_loc_6].name).replace(_loc_9, "</font><font color=\'" + _loc_3 + "\'><b>$&</b></font><font color=\'" + _loc_4 + "\'>") + "</font>";
                                this._list[_loc_6].phoneNumberHtmlText = "<font color=\'" + _loc_4 + "\'>" + this._list[_loc_6].phoneNumber.replace(_loc_11, "</font><font color=\'" + _loc_3 + "\'><b>$&</b></font><font color=\'" + _loc_4 + "\'>") + "</font>";
                                _loc_5.push(this._list[_loc_6]);
                            }
                        }
                        else if (_loc_13)
                        {
                            if (param2)
                            {
                                this._list[_loc_6].nameHtmlText = "<font color=\'" + _loc_4 + "\'>" + RubricaElement.truncateText(this._list[_loc_6].name) + "</font>";
                                this._list[_loc_6].phoneNumberHtmlText = "<font color=\'" + _loc_4 + "\'>" + this._list[_loc_6].phoneNumber.replace(_loc_11, "</font><font color=\'" + _loc_3 + "\'><b>$&</b></font><font color=\'" + _loc_4 + "\'>") + "</font>";
                                _loc_5.push(this._list[_loc_6]);
                            }
                        }
                        else if (_loc_12)
                        {
                            if (param2)
                            {
                                this._list[_loc_6].nameHtmlText = "<font color=\'" + _loc_4 + "\'>" + RubricaElement.truncateText(this._list[_loc_6].name).replace(_loc_9, "</font><font color=\'" + _loc_3 + "\'><b>$&</b></font><font color=\'" + _loc_4 + "\'>") + "</font>";
                                this._list[_loc_6].phoneNumberHtmlText = "<font color=\'" + _loc_4 + "\'>" + this._list[_loc_6].phoneNumber + "</font>";
                                _loc_5.push(this._list[_loc_6]);
                            }
                        }
                        continue;
                    }
                    if (_loc_12)
                    {
                        if (param2)
                        {
                            this._list[_loc_6].nameHtmlText = "<font color=\'" + _loc_4 + "\'>" + RubricaElement.truncateText(this._list[_loc_6].name).replace(_loc_9, "</font><font color=\'" + _loc_3 + "\'><b>$&</b></font><font color=\'" + _loc_4 + "\'>") + "</font>";
                            this._list[_loc_6].phoneNumberHtmlText = "<font color=\'" + _loc_4 + "\'>" + this._list[_loc_6].phoneNumber + "</font>";
                        }
                        _loc_5.push(this._list[_loc_6]);
                    }
                }
            }
            return this.sort(_loc_5);
        }// end function

        private function replaceSpecialChar(param1:String) : String
        {
            param1 = replaceString("\\", "\\\\", param1);
            param1 = replaceString(".", "\\.", param1);
            param1 = replaceString("(", "\\(", param1);
            param1 = replaceString(")", "\\)", param1);
            param1 = replaceString("[", "\\[", param1);
            param1 = replaceString("]", "\\]", param1);
            param1 = replaceString("}", "\\}", param1);
            param1 = replaceString("{", "\\{", param1);
            param1 = replaceString("|", "\\|", param1);
            param1 = replaceString("$", "\\$", param1);
            param1 = replaceString("*", "\\*", param1);
            param1 = replaceString("?", "\\?", param1);
            param1 = replaceString("^", "\\^", param1);
            return param1;
        }// end function

        public function get isEmpty() : Boolean
        {
            return this.list.length > 0 ? (false) : (true);
        }// end function

        public function sort(param1:Array) : Array
        {
            return param1.sortOn(["name", "phoneNumber"], Array.CASEINSENSITIVE);
        }// end function

        public function reset() : void
        {
            this._list = new Array();
            return;
        }// end function

        public function isInList(param1:String, param2:String = "") : Number
        {
            if (this.isEmpty)
            {
                return -1;
            }
            var _loc_3:int = 0;
            while (_loc_3 < this._list.length)
            {
                
                if (param1 == this._list[_loc_3].phoneNumber && param2 != this._list[_loc_3].phoneNumber)
                {
                    return _loc_3;
                }
                _loc_3++;
            }
            return -1;
        }// end function

        public function loadRubrica() : Boolean
        {
            trace("RubricaUser - loadRubrica user=" + this._username);
            this._list = LocalPreferences.getInstance().storageObjectGet(this.RUBRICA + this._username) as Array;
            if (this._list == null || this._list.length == 0)
            {
                this._list = new Array();
                this._isEmpty = true;
                return false;
            }
            this._list = this.search("");
            this._list = this.sort(this._list);
            return true;
        }// end function

        public function deleteElement(param1:RubricaElement) : Boolean
        {
            var _loc_2:Boolean = false;
            trace("RubricaUser - deleteElement, name: " + param1.name);
            var _loc_3:* = this.isInList(param1.phoneNumber);
            if (_loc_3 != -1)
            {
                _loc_2 = true;
                this._list.splice(_loc_3, 1);
            }
            this._list = this.sort(this._list);
            this.saveRubrica();
            return _loc_2;
        }// end function

        public function editElement(param1:RubricaElement, param2:RubricaElement) : Boolean
        {
            trace("RubricaUser - editElement");
            var _loc_3:* = this.deleteElement(param1);
            if (_loc_3)
            {
                this.addElement(param2);
            }
            this._list = this.sort(this._list);
            return _loc_3;
        }// end function

        public function isNumberPartiallyInList(param1:String) : Number
        {
            var _loc_3:String = null;
            if (this.isEmpty)
            {
                return -1;
            }
            var _loc_2:int = 0;
            while (_loc_2 < this._list.length)
            {
                
                _loc_3 = this._list[_loc_2].phoneNumber;
                if (_loc_3.indexOf(param1) == 0)
                {
                    return _loc_2;
                }
                _loc_2++;
            }
            return -1;
        }// end function

        public function saveRubrica() : void
        {
            trace("RubricaUser - saveRubrica");
            LocalPreferences.getInstance().storageObjectSet(this.RUBRICA + this._username, this._list, false);
            return;
        }// end function

        public function addElement(param1:RubricaElement) : void
        {
            trace("RubricaUser - addElement - name: " + param1.name);
            this._list.push(param1);
            this._list = this.sort(this._list);
            this.saveRubrica();
            return;
        }// end function

        public function get list() : Array
        {
            return this._list;
        }// end function

        public static function getIstance(param1:String, param2:Boolean = false) : RubricaUser
        {
            if (_rubricaIstance == null || param2)
            {
                _rubricaIstance = new RubricaUser(param1);
            }
            return _rubricaIstance;
        }// end function

        public static function isPhoneNumber(param1:String) : Boolean
        {
            var _loc_2:* = /[^0-9,-_:; .()\/\\]+/g;
            return param1.match(_loc_2).length == 0 ? (true) : (false);
        }// end function

        public static function replaceString(param1:String, param2:String, param3:String) : String
        {
            var _loc_5:String = null;
            var _loc_6:String = null;
            trace("RubricaElement, replaceString - before replacement: " + param3);
            var _loc_4:* = param3.indexOf(param1);
            while (_loc_4 > -1)
            {
                
                _loc_5 = param3.substring(0, _loc_4);
                _loc_6 = param3.substr(_loc_4 + param1.length);
                param3 = _loc_5 + param2 + _loc_6;
                _loc_4 = param3.indexOf(param1, _loc_5.length + param2.length);
                if (_loc_4 > 100)
                {
                    _loc_4 = -1;
                }
            }
            return param3;
        }// end function

    }
}
