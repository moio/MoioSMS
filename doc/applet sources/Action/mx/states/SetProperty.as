package mx.states
{
    import mx.core.*;

    public class SetProperty extends Object implements IOverride
    {
        private var oldRelatedValues:Array;
        private var oldValue:Object;
        public var name:String;
        public var target:Object;
        public var value:Object;
        private static const RELATED_PROPERTIES:Object = {explicitWidth:["percentWidth"], explicitHeight:["percentHeight"]};
        static const VERSION:String = "3.2.0.3958";
        private static const PSEUDONYMS:Object = {width:"explicitWidth", height:"explicitHeight"};

        public function SetProperty(param1:Object = null, param2:String = null, param3 = )
        {
            this.target = param1;
            this.name = param2;
            this.value = param3;
            return;
        }// end function

        public function remove(param1:UIComponent) : void
        {
            var _loc_5:int = 0;
            var _loc_2:* = target ? (target) : (param1);
            var _loc_3:* = PSEUDONYMS[name] ? (PSEUDONYMS[name]) : (name);
            var _loc_4:* = RELATED_PROPERTIES[_loc_3] ? (RELATED_PROPERTIES[_loc_3]) : (null);
            if (name == "width" || name == "height" && !isNaN(Number(oldValue)))
            {
                _loc_3 = name;
            }
            setPropertyValue(_loc_2, _loc_3, oldValue, oldValue);
            if (_loc_4)
            {
                _loc_5 = 0;
                while (_loc_5 < _loc_4.length)
                {
                    
                    setPropertyValue(_loc_2, _loc_4[_loc_5], oldRelatedValues[_loc_5], oldRelatedValues[_loc_5]);
                    _loc_5++;
                }
            }
            return;
        }// end function

        private function toBoolean(param1:Object) : Boolean
        {
            if (param1 is String)
            {
                return param1.toLowerCase() == "true";
            }
            return param1 != false;
        }// end function

        public function apply(param1:UIComponent) : void
        {
            var _loc_6:int = 0;
            var _loc_2:* = target ? (target) : (param1);
            var _loc_3:* = PSEUDONYMS[name] ? (PSEUDONYMS[name]) : (name);
            var _loc_4:* = RELATED_PROPERTIES[_loc_3] ? (RELATED_PROPERTIES[_loc_3]) : (null);
            var _loc_5:* = value;
            oldValue = _loc_2[_loc_3];
            if (_loc_4)
            {
                oldRelatedValues = [];
                _loc_6 = 0;
                while (_loc_6 < _loc_4.length)
                {
                    
                    oldRelatedValues[_loc_6] = _loc_2[_loc_4[_loc_6]];
                    _loc_6++;
                }
            }
            if (name == "width" || name == "height")
            {
                if (_loc_5 is String && _loc_5.indexOf("%") >= 0)
                {
                    _loc_3 = name == "width" ? ("percentWidth") : ("percentHeight");
                    _loc_5 = _loc_5.slice(0, _loc_5.indexOf("%"));
                }
                else
                {
                    _loc_3 = name;
                }
            }
            setPropertyValue(_loc_2, _loc_3, _loc_5, oldValue);
            return;
        }// end function

        public function initialize() : void
        {
            return;
        }// end function

        private function setPropertyValue(param1:Object, param2:String, param3, param4:Object) : void
        {
            if (param4 is Number)
            {
                param1[param2] = Number(param3);
            }
            else if (param4 is Boolean)
            {
                param1[param2] = toBoolean(param3);
            }
            else
            {
                param1[param2] = param3;
            }
            return;
        }// end function

    }
}
