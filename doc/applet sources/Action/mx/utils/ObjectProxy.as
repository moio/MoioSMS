package mx.utils
{
    import flash.events.*;
    import flash.utils.*;
    import mx.core.*;
    import mx.events.*;

    dynamic public class ObjectProxy extends Proxy implements IExternalizable, IPropertyChangeNotifier
    {
        private var _id:String;
        protected var notifiers:Object;
        protected var propertyList:Array;
        private var _proxyLevel:int;
        private var _type:QName;
        protected var dispatcher:EventDispatcher;
        protected var proxyClass:Class;
        private var _item:Object;

        public function ObjectProxy(param1:Object = null, param2:String = null, param3:int = -1)
        {
            proxyClass = ObjectProxy;
            if (!param1)
            {
                param1 = {};
            }
            _item = param1;
            _proxyLevel = param3;
            notifiers = {};
            dispatcher = new EventDispatcher(this);
            if (param2)
            {
                _id = param2;
            }
            return;
        }// end function

        public function dispatchEvent(event:Event) : Boolean
        {
            return dispatcher.dispatchEvent(event);
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return dispatcher.hasEventListener(param1);
        }// end function

        override function setProperty(param1, param2) : void
        {
            var _loc_4:IPropertyChangeNotifier = null;
            var _loc_5:PropertyChangeEvent = null;
            var _loc_3:* = _item[param1];
            if (_loc_3 !== param2)
            {
                _item[param1] = param2;
                _loc_4 = IPropertyChangeNotifier(notifiers[param1]);
                if (_loc_4)
                {
                    _loc_4.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler);
                    delete notifiers[param1];
                }
                if (dispatcher.hasEventListener(PropertyChangeEvent.PROPERTY_CHANGE))
                {
                    if (param1 is QName)
                    {
                        param1 = QName(param1).localName;
                    }
                    _loc_5 = PropertyChangeEvent.createUpdateEvent(this, param1.toString(), _loc_3, param2);
                    dispatcher.dispatchEvent(_loc_5);
                }
            }
            return;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return dispatcher.willTrigger(param1);
        }// end function

        public function readExternal(param1:IDataInput) : void
        {
            var _loc_2:* = param1.readObject();
            _item = _loc_2;
            return;
        }// end function

        public function writeExternal(param1:IDataOutput) : void
        {
            param1.writeObject(_item);
            return;
        }// end function

        override function getProperty(param1)
        {
            var _loc_2:* = undefined;
            if (notifiers[param1.toString()])
            {
                return notifiers[param1];
            }
            _loc_2 = _item[param1];
            if (_loc_2)
            {
                if (_proxyLevel == 0 || ObjectUtil.isSimple(_loc_2))
                {
                    return _loc_2;
                }
                _loc_2 = getComplexProperty(param1, _loc_2);
            }
            return _loc_2;
        }// end function

        override function hasProperty(param1) : Boolean
        {
            return param1 in _item;
        }// end function

        public function get uid() : String
        {
            if (_id === null)
            {
                _id = UIDUtil.createUID();
            }
            return _id;
        }// end function

        override function nextNameIndex(param1:int) : int
        {
            if (param1 == 0)
            {
                setupPropertyList();
            }
            if (param1 < propertyList.length)
            {
                return param1 + 1;
            }
            return 0;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            dispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        override function nextName(param1:int) : String
        {
            return propertyList[param1--];
        }// end function

        public function set uid(param1:String) : void
        {
            _id = param1;
            return;
        }// end function

        override function callProperty(param1, ... args)
        {
            return _item[param1].apply(_item, args);
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            dispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        protected function setupPropertyList() : void
        {
            var _loc_1:String = null;
            if (getQualifiedClassName(_item) == "Object")
            {
                propertyList = [];
                for (_loc_1 in _item)
                {
                    
                    propertyList.push(_loc_1);
                }
            }
            else
            {
                propertyList = ObjectUtil.getClassInfo(_item, null, {includeReadOnly:true, uris:["*"]}).properties;
            }
            return;
        }// end function

        function getComplexProperty(param1, param2)
        {
            if (param2 is IPropertyChangeNotifier)
            {
                param2.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler);
                notifiers[param1] = param2;
                return param2;
            }
            if (getQualifiedClassName(param2) == "Object")
            {
                param2 = new proxyClass(_item[param1], null, _proxyLevel > 0 ? (_proxyLevel--) : (_proxyLevel));
                param2.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler);
                notifiers[param1] = param2;
                return param2;
            }
            return param2;
        }// end function

        override function deleteProperty(param1) : Boolean
        {
            var _loc_5:PropertyChangeEvent = null;
            var _loc_2:* = IPropertyChangeNotifier(notifiers[param1]);
            if (_loc_2)
            {
                _loc_2.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler);
                delete notifiers[param1];
            }
            var _loc_3:* = _item[param1];
            var _loc_4:* = delete _item[param1];
            if (dispatcher.hasEventListener(PropertyChangeEvent.PROPERTY_CHANGE))
            {
                _loc_5 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_5.kind = PropertyChangeEventKind.DELETE;
                _loc_5.property = param1;
                _loc_5.oldValue = _loc_3;
                _loc_5.source = this;
                dispatcher.dispatchEvent(_loc_5);
            }
            return _loc_4;
        }// end function

        function get type() : QName
        {
            return _type;
        }// end function

        function set type(param1:QName) : void
        {
            _type = param1;
            return;
        }// end function

        public function propertyChangeHandler(event:PropertyChangeEvent) : void
        {
            dispatcher.dispatchEvent(event);
            return;
        }// end function

        override function nextValue(param1:int)
        {
            return _item[propertyList[param1--]];
        }// end function

        function get object() : Object
        {
            return _item;
        }// end function

    }
}
