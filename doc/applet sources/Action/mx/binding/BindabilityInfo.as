package mx.binding
{
    import mx.events.*;

    public class BindabilityInfo extends Object
    {
        private var classChangeEvents:Object;
        private var typeDescription:XML;
        private var childChangeEvents:Object;
        public static const METHOD:String = "method";
        public static const ACCESSOR:String = "accessor";
        public static const CHANGE_EVENT:String = "ChangeEvent";
        public static const NON_COMMITTING_CHANGE_EVENT:String = "NonCommittingChangeEvent";
        public static const BINDABLE:String = "Bindable";
        static const VERSION:String = "3.2.0.3958";
        public static const MANAGED:String = "Managed";

        public function BindabilityInfo(param1:XML)
        {
            childChangeEvents = {};
            this.typeDescription = param1;
            return;
        }// end function

        private function addChangeEvents(param1:XMLList, param2:Object, param3:Boolean) : void
        {
            var _loc_4:XML = null;
            var _loc_5:XMLList = null;
            var _loc_6:String = null;
            for each (_loc_4 in param1)
            {
                
                _loc_5 = _loc_4.arg;
                if (_loc_5.length() > 0)
                {
                    _loc_6 = _loc_5[0].@value;
                    param2[_loc_6] = param3;
                    continue;
                }
                trace("warning: unconverted Bindable metadata in class \'" + typeDescription.@name + "\'");
            }
            return;
        }// end function

        private function getClassChangeEvents() : Object
        {
            if (!classChangeEvents)
            {
                classChangeEvents = {};
                addBindabilityEvents(typeDescription.metadata, classChangeEvents);
                var _loc_3:int = 0;
                var _loc_4:* = typeDescription.metadata;
                var _loc_2:* = new XMLList("");
                for each (_loc_5 in _loc_4)
                {
                    
                    var _loc_6:* = _loc_4[_loc_3];
                    with (_loc_4[_loc_3])
                    {
                        if (@name == MANAGED)
                        {
                            _loc_2[_loc_3] = _loc_5;
                        }
                    }
                }
                if (_loc_2.length() > 0)
                {
                    classChangeEvents[PropertyChangeEvent.PROPERTY_CHANGE] = true;
                }
            }
            return classChangeEvents;
        }// end function

        private function addBindabilityEvents(param1:XMLList, param2:Object) : void
        {
            var metadata:* = param1;
            var eventListObj:* = param2;
            var _loc_5:int = 0;
            var _loc_6:* = metadata;
            var _loc_4:* = new XMLList("");
            for each (_loc_7 in _loc_6)
            {
                
                var _loc_8:* = _loc_6[_loc_5];
                with (_loc_6[_loc_5])
                {
                    if (@name == BINDABLE)
                    {
                        _loc_4[_loc_5] = _loc_7;
                    }
                }
            }
            addChangeEvents(_loc_4, eventListObj, true);
            var _loc_5:int = 0;
            var _loc_6:* = metadata;
            var _loc_4:* = new XMLList("");
            for each (_loc_7 in _loc_6)
            {
                
                var _loc_8:* = _loc_6[_loc_5];
                with (_loc_6[_loc_5])
                {
                    if (@name == CHANGE_EVENT)
                    {
                        _loc_4[_loc_5] = _loc_7;
                    }
                }
            }
            addChangeEvents(_loc_4, eventListObj, true);
            var _loc_5:int = 0;
            var _loc_6:* = metadata;
            var _loc_4:* = new XMLList("");
            for each (_loc_7 in _loc_6)
            {
                
                var _loc_8:* = _loc_6[_loc_5];
                with (_loc_6[_loc_5])
                {
                    if (@name == NON_COMMITTING_CHANGE_EVENT)
                    {
                        _loc_4[_loc_5] = _loc_7;
                    }
                }
            }
            addChangeEvents(_loc_4, eventListObj, false);
            return;
        }// end function

        private function copyProps(param1:Object, param2:Object) : Object
        {
            var _loc_3:String = null;
            for (_loc_3 in param1)
            {
                
                param2[_loc_3] = param1[_loc_3];
            }
            return param2;
        }// end function

        public function getChangeEvents(param1:String) : Object
        {
            var childDesc:XMLList;
            var numChildren:int;
            var childName:* = param1;
            var changeEvents:* = childChangeEvents[childName];
            if (!changeEvents)
            {
                changeEvents = copyProps(getClassChangeEvents(), {});
                var _loc_4:int = 0;
                var _loc_5:* = typeDescription.accessor;
                var _loc_3:* = new XMLList("");
                for each (_loc_6 in _loc_5)
                {
                    
                    var _loc_7:* = _loc_5[_loc_4];
                    with (_loc_5[_loc_4])
                    {
                        if (@name == childName)
                        {
                            _loc_3[_loc_4] = _loc_6;
                        }
                    }
                }
                var _loc_4:int = 0;
                var _loc_5:* = typeDescription.method;
                var _loc_3:* = new XMLList("");
                for each (_loc_6 in _loc_5)
                {
                    
                    var _loc_7:* = _loc_5[_loc_4];
                    with (_loc_5[_loc_4])
                    {
                        if (@name == childName)
                        {
                            _loc_3[_loc_4] = _loc_6;
                        }
                    }
                }
                childDesc = _loc_3 + _loc_3;
                numChildren = childDesc.length();
                if (numChildren == 0)
                {
                    if (!typeDescription.@dynamic)
                    {
                        trace("warning: no describeType entry for \'" + childName + "\' on non-dynamic type \'" + typeDescription.@name + "\'");
                    }
                }
                else
                {
                    if (numChildren > 1)
                    {
                        trace("warning: multiple describeType entries for \'" + childName + "\' on type \'" + typeDescription.@name + "\':\n" + childDesc);
                    }
                    addBindabilityEvents(childDesc.metadata, changeEvents);
                }
                childChangeEvents[childName] = changeEvents;
            }
            return changeEvents;
        }// end function

    }
}
