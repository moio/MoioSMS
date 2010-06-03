package mx.utils
{
    import flash.utils.*;

    public class XMLNotifier extends Object
    {
        private static var instance:XMLNotifier;
        static const VERSION:String = "3.2.0.3958";

        public function XMLNotifier(param1:XMLNotifierSingleton)
        {
            return;
        }// end function

        public function watchXML(param1:Object, param2:IXMLNotifiable, param3:String = null) : void
        {
            var _loc_6:Dictionary = null;
            var _loc_4:* = XML(param1);
            var _loc_5:* = XML(param1).notification();
            if (!(XML(param1).notification() is Function))
            {
                _loc_5 = initializeXMLForNotification();
                _loc_4.setNotification(_loc_5 as Function);
                if (param3 && _loc_5["uid"] == null)
                {
                    _loc_5["uid"] = param3;
                }
            }
            if (_loc_5["watched"] == undefined)
            {
                var _loc_7:* = new Dictionary(true);
                _loc_6 = new Dictionary(true);
                _loc_5["watched"] = _loc_7;
            }
            else
            {
                _loc_6 = _loc_5["watched"];
            }
            _loc_6[param2] = true;
            return;
        }// end function

        public function unwatchXML(param1:Object, param2:IXMLNotifiable) : void
        {
            var _loc_5:Dictionary = null;
            var _loc_3:* = XML(param1);
            var _loc_4:* = _loc_3.notification();
            if (!(_loc_3.notification() is Function))
            {
                return;
            }
            if (_loc_4["watched"] != undefined)
            {
                _loc_5 = _loc_4["watched"];
                delete _loc_5[param2];
            }
            return;
        }// end function

        public static function getInstance() : XMLNotifier
        {
            if (!instance)
            {
                instance = new XMLNotifier(new XMLNotifierSingleton());
            }
            return instance;
        }// end function

        static function initializeXMLForNotification() : Function
        {
            var notificationFunction:* = function (param1:Object, param2:String, param3:Object, param4:Object, param5:Object) : void
            {
                var _loc_8:Object = null;
                var _loc_7:* = _loc_6.callee.watched;
                if (_loc_6.callee.watched != null)
                {
                    for (_loc_8 in _loc_7)
                    {
                        
                        IXMLNotifiable(_loc_8).xmlNotification(param1, param2, param3, param4, param5);
                    }
                }
                return;
            }// end function
            ;
            return notificationFunction;
        }// end function

    }
}
