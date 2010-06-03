package it.vodafone.ultimiNumeri
{
    import flash.events.*;
    import it.vodafone.*;

    public class UltimiNumeriUser extends EventDispatcher
    {
        private var _isEmpty:Boolean;
        private const ULTIMI_NUMERI:String = "ULTIMI_NUMERI_";
        private var _username:String;
        private var _list:Array;
        private static var _ultimiNumeriIstance:UltimiNumeriUser;

        public function UltimiNumeriUser(param1:String)
        {
            this._username = param1.toUpperCase();
            this.loadUltimiNumeri();
            return;
        }// end function

        public function addElement(param1:UltimoNumeroElement) : void
        {
            trace("UltimiNumeriUser - addElement - phoneNumber: " + param1.phoneNumber);
            var _loc_2:* = this.isInList(param1.phoneNumber);
            if (_loc_2 != -1)
            {
                this._list.splice(_loc_2, 1);
            }
            this._list.unshift(param1);
            if (this._list.length > 5)
            {
                this._list = this._list.slice(0, 5);
            }
            trace("UltimiNumeriUser - addElement, _list: " + this._list);
            this.saveUltimiNumeri();
            return;
        }// end function

        public function get isEmpty() : Boolean
        {
            return this.list.length > 0 ? (false) : (true);
        }// end function

        public function loadUltimiNumeri() : Boolean
        {
            this._list = new Array();
            this._list = LocalPreferences.getInstance().storageObjectGet(this.ULTIMI_NUMERI + this._username) as Array;
            trace("UltimiNumeriUser - loadRubrica user=" + this._username + " , list= " + this._list);
            if (this._list == null || this._list.length == 0)
            {
                this._list = new Array();
                this._isEmpty = true;
                return false;
            }
            return true;
        }// end function

        private function reset() : void
        {
            this._list = new Array();
            return;
        }// end function

        public function deleteElement(param1:UltimoNumeroElement) : Boolean
        {
            var _loc_2:Boolean = false;
            trace("UltimiNumeriUser - deleteElement, name: " + param1.name);
            var _loc_3:* = this.isInList(param1.phoneNumber);
            if (_loc_3 != -1)
            {
                _loc_2 = true;
                this._list.splice(_loc_3, 1);
            }
            trace("UltimiNumeriUser - deleteElement, _list: " + this._list);
            this.saveUltimiNumeri();
            return _loc_2;
        }// end function

        public function isInList(param1:String) : Number
        {
            if (this.isEmpty)
            {
                return -1;
            }
            var _loc_2:int = 0;
            while (_loc_2 < this._list.length)
            {
                
                if (param1 == this._list[_loc_2].phoneNumber)
                {
                    return _loc_2;
                }
                _loc_2++;
            }
            return -1;
        }// end function

        public function saveUltimiNumeri() : void
        {
            trace("UltimiNumeriUser - saveUltimiNumeri, list is null? " + (this._list == null));
            if (this._list == null)
            {
                this._list = new Array();
                trace("UltimiNumeriUser - saveUltimiNumeri, reinizializzato array _list");
            }
            trace("UltimiNumeriUser - saveUltimiNumeri, list: " + this._list);
            if (this._list != null)
            {
                trace("UltimiNumeriUser - saveUltimiNumeri, list length " + this._list.length);
            }
            LocalPreferences.getInstance().storageObjectSet(this.ULTIMI_NUMERI + this._username, this._list, true);
            trace("UltimiNumeriUser - saveUltimiNumeri, after save: list length" + this._list.length);
            return;
        }// end function

        public function get list() : Array
        {
            return this._list;
        }// end function

        public static function getIstance(param1:String, param2:Boolean = false) : UltimiNumeriUser
        {
            if (_ultimiNumeriIstance == null || param2)
            {
                _ultimiNumeriIstance = new UltimiNumeriUser(param1);
            }
            return _ultimiNumeriIstance;
        }// end function

    }
}
