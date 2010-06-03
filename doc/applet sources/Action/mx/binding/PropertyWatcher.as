package mx.binding
{
    import flash.events.*;
    import flash.utils.*;
    import mx.core.*;
    import mx.events.*;
    import mx.utils.*;

    public class PropertyWatcher extends Watcher
    {
        protected var propertyGetter:Function;
        private var parentObj:Object;
        protected var events:Object;
        private var useRTTI:Boolean;
        private var _propertyName:String;
        static const VERSION:String = "3.2.0.3958";

        public function PropertyWatcher(param1:String, param2:Object, param3:Array, param4:Function = null)
        {
            super(param3);
            _propertyName = param1;
            this.events = param2;
            this.propertyGetter = param4;
            useRTTI = !param2;
            return;
        }// end function

        private function eventNamesToString() : String
        {
            var _loc_2:String = null;
            var _loc_1:String = " ";
            for (_loc_2 in events)
            {
                
                _loc_1 = _loc_1 + (_loc_2 + " ");
            }
            return _loc_1;
        }// end function

        override public function updateParent(param1:Object) : void
        {
            var _loc_2:String = null;
            var _loc_3:BindabilityInfo = null;
            if (parentObj && parentObj is IEventDispatcher)
            {
                for (_loc_2 in events)
                {
                    
                    parentObj.removeEventListener(_loc_2, eventHandler);
                }
            }
            if (param1 is Watcher)
            {
                parentObj = param1.value;
            }
            else
            {
                parentObj = param1;
            }
            if (parentObj)
            {
                if (useRTTI)
                {
                    events = {};
                    if (parentObj is IEventDispatcher)
                    {
                        _loc_3 = DescribeTypeCache.describeType(parentObj).bindabilityInfo;
                        events = _loc_3.getChangeEvents(_propertyName);
                        if (objectIsEmpty(events))
                        {
                            trace("warning: unable to bind to property \'" + _propertyName + "\' on class \'" + getQualifiedClassName(parentObj) + "\'");
                        }
                        else
                        {
                            addParentEventListeners();
                        }
                    }
                    else
                    {
                        trace("warning: unable to bind to property \'" + _propertyName + "\' on class \'" + getQualifiedClassName(parentObj) + "\' (class is not an IEventDispatcher)");
                    }
                }
                else if (parentObj is IEventDispatcher)
                {
                    addParentEventListeners();
                }
            }
            wrapUpdate(updateProperty);
            return;
        }// end function

        private function objectIsEmpty(param1:Object) : Boolean
        {
            var _loc_2:String = null;
            for (_loc_2 in param1)
            {
                
                return false;
            }
            return true;
        }// end function

        override protected function shallowClone() : Watcher
        {
            var _loc_1:* = new PropertyWatcher(_propertyName, events, listeners, propertyGetter);
            return _loc_1;
        }// end function

        private function traceInfo() : String
        {
            return "Watcher(" + getQualifiedClassName(parentObj) + "." + _propertyName + "): events = [" + eventNamesToString() + (useRTTI ? ("] (RTTI)") : ("]"));
        }// end function

        public function get propertyName() : String
        {
            return _propertyName;
        }// end function

        private function addParentEventListeners() : void
        {
            var _loc_1:String = null;
            for (_loc_1 in events)
            {
                
                if (_loc_1 != "__NoChangeEvent__")
                {
                    parentObj.addEventListener(_loc_1, eventHandler, false, EventPriority.BINDING, true);
                }
            }
            return;
        }// end function

        private function updateProperty() : void
        {
            if (parentObj)
            {
                if (_propertyName == "this")
                {
                    value = parentObj;
                }
                else if (propertyGetter != null)
                {
                    value = propertyGetter.apply(parentObj, [_propertyName]);
                }
                else
                {
                    value = parentObj[_propertyName];
                }
            }
            else
            {
                value = null;
            }
            updateChildren();
            return;
        }// end function

        public function eventHandler(event:Event) : void
        {
            var _loc_2:Object = null;
            if (event is PropertyChangeEvent)
            {
                _loc_2 = PropertyChangeEvent(event).property;
                if (_loc_2 != _propertyName)
                {
                    return;
                }
            }
            wrapUpdate(updateProperty);
            notifyListeners(events[event.type]);
            return;
        }// end function

    }
}
