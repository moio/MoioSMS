package it.vodafone
{
    import flash.data.*;
    import flash.events.*;
    import flash.utils.*;

    public class LocalPreferences extends EventDispatcher
    {
        public const SKIN_TYPE:String = "vodafone_skin";
        public const VODAFONE_SKIN:String = "vodafone_skin";
        public const ZEROLIMITS_SKIN:String = "zerolimits_skin";
        private static var selfInstance:LocalPreferences;

        public function LocalPreferences(param1:IEventDispatcher = null)
        {
            super(param1);
            return;
        }// end function

        public function storageGet(param1:String) : String
        {
            var storedValue:ByteArray;
            var key:* = param1;
            if (this.SKIN_TYPE == this.ZEROLIMITS_SKIN)
            {
                if (key == "rss_feeds")
                {
                    key;
                }
                if (key == "disabledFeeds")
                {
                    key;
                }
            }
            try
            {
                storedValue = EncryptedLocalStore.getItem(key);
                if (storedValue == null)
                {
                    return null;
                }
                return storedValue.readUTFBytes(storedValue.length);
            }
            catch (e:Error)
            {
            }
            return null;
        }// end function

        public function storageSet(param1:String, param2:String, param3:Boolean = true) : void
        {
            if (this.SKIN_TYPE == this.ZEROLIMITS_SKIN)
            {
                if (param1 == "rss_feeds")
                {
                    param1 = "zero_rss_feeds";
                }
                if (param1 == "disabledFeeds")
                {
                    param1 = "zero_disabledFeeds";
                }
            }
            var _loc_4:* = new ByteArray();
            new ByteArray().writeUTFBytes(param2);
            EncryptedLocalStore.setItem(param1, _loc_4, param3);
            return;
        }// end function

        public function storageObjectSet(param1:String, param2:Object, param3:Boolean = true) : void
        {
            var _loc_4:* = new ByteArray();
            new ByteArray().writeObject(param2);
            EncryptedLocalStore.setItem(param1, _loc_4, param3);
            return;
        }// end function

        public function storageObjectGet(param1:String) : Object
        {
            var storedValue:ByteArray;
            var key:* = param1;
            try
            {
                storedValue = EncryptedLocalStore.getItem(key);
                if (storedValue == null)
                {
                    return null;
                }
                return storedValue.readObject();
            }
            catch (e:Error)
            {
            }
            return null;
        }// end function

        public function set autologin(param1:Boolean) : void
        {
            if (param1)
            {
                this.storageSet("autologin", "true");
            }
            else
            {
                this.storageSet("autologin", "false");
                this.storageSet("username", "");
                this.storageSet("password", "");
            }
            return;
        }// end function

        public function setLoginInfo(param1:String, param2:String) : void
        {
            this.storageSet("username", param1);
            this.storageSet("password", param2);
            return;
        }// end function

        public function get username() : String
        {
            return this.storageGet("username");
        }// end function

        public function get autologin() : Boolean
        {
            return this.storageGet("autologin") == "true";
        }// end function

        public function get password() : String
        {
            return this.storageGet("password");
        }// end function

        public static function getInstance() : LocalPreferences
        {
            if (selfInstance == null)
            {
                selfInstance = new LocalPreferences;
            }
            return selfInstance;
        }// end function

    }
}
