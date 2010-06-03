package it.vodafone
{

    public class NumberDataCache extends Object
    {
        private var EXPIRE_TIME:int = 1.08e+007;
        private var _credito:String;
        private var _tipo:int;
        private var _numero:String;
        private var _timestamp:Date;

        public function NumberDataCache(param1:String, param2:int, param3:String)
        {
            this.EXPIRE_TIME = 1000 * 60 * 60 * Number(RemotePreferences.getInstance().getValue("infoconto_validity"));
            this._numero = param1;
            this._tipo = param2;
            this._credito = param3;
            this._timestamp = new Date();
            return;
        }// end function

        public function get oraAggiornamento() : String
        {
            var _loc_1:* = this._timestamp.hours.toString();
            var _loc_2:* = this._timestamp.minutes.toString();
            var _loc_3:* = this._timestamp.seconds.toString();
            if (this._timestamp.hours < 10)
            {
                _loc_1 = "0" + _loc_1;
            }
            if (this._timestamp.minutes < 10)
            {
                _loc_2 = "0" + _loc_2;
            }
            if (this._timestamp.seconds < 10)
            {
                _loc_3 = "0" + _loc_3;
            }
            return _loc_1 + ":" + _loc_2 + ":" + _loc_3;
        }// end function

        public function get expired() : Boolean
        {
            var _loc_1:* = new Date();
            if (this._timestamp.time + this.EXPIRE_TIME < _loc_1.time)
            {
                return true;
            }
            return false;
        }// end function

        public function get tipo() : int
        {
            return this._tipo;
        }// end function

        public function get numero() : String
        {
            return this._numero;
        }// end function

        public function get credito() : String
        {
            return this._credito;
        }// end function

    }
}
