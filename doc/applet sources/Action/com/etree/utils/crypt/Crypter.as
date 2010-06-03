package com.etree.utils.crypt
{

    public class Crypter extends Object
    {
        public static var cryptTable:String = new String(" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\t!@#$%^&*()`\'-=[];,./?_+{}|:<>~");
        public static var doubleQuote:String = "\"";
        public static var lineFeed:String = "\n";
        public static var cryptLength:Number = new Number(cryptTable.length--);
        public static var escapeChar:String = cryptTable.charAt(cryptLength);
        public static var clearMessage:Number = new Number(5000);

        public function Crypter()
        {
            return;
        }// end function

        public static function decrypt(param1:String, param2:String = "") : String
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_12:int = 0;
            var _loc_6:Boolean = false;
            var _loc_7:String = "";
            var _loc_8:* = new Array();
            var _loc_9:* = param2.length;
            var _loc_10:* = param1.length;
            var _loc_11:* = Math.round(_loc_10 / 10);
            _loc_12 = 0;
            while (_loc_12 < _loc_9)
            {
                
                _loc_8[_loc_12] = cryptTable.indexOf(param2.charAt(_loc_12));
                _loc_12++;
            }
            var _loc_13:int = 0;
            _loc_12 = 0;
            while (_loc_13 < _loc_10)
            {
                
                if (_loc_12 >= _loc_9)
                {
                    _loc_12 = 0;
                }
                _loc_3 = param1.charAt(_loc_13);
                _loc_4 = cryptTable.indexOf(_loc_3);
                if (_loc_4 == -1)
                {
                    _loc_5 = _loc_3;
                }
                else if (_loc_6)
                {
                    if (_loc_4 == cryptLength)
                    {
                        _loc_5 = lineFeed;
                        _loc_4 = -1;
                    }
                    else if (_loc_3 == "\'")
                    {
                        _loc_5 = doubleQuote;
                        _loc_4 = -1;
                    }
                    else
                    {
                        _loc_4 = _loc_4 + cryptLength;
                    }
                    _loc_6 = false;
                }
                else if (_loc_4 == cryptLength)
                {
                    _loc_6 = true;
                    _loc_5 = "";
                    _loc_4 = -1;
                }
                if (_loc_4 != -1)
                {
                    _loc_5 = cryptTable.charAt(_loc_8[_loc_12--] ^ _loc_4);
                }
                _loc_7 = _loc_7 + _loc_5;
                _loc_13++;
                _loc_12++;
            }
            return _loc_7;
        }// end function

    }
}
