package mx.states
{
    import mx.core.*;
    import mx.styles.*;

    public class SetStyle extends Object implements IOverride
    {
        private var oldRelatedValues:Array;
        private var oldValue:Object;
        public var name:String;
        public var target:IStyleClient;
        public var value:Object;
        static const VERSION:String = "3.2.0.3958";
        private static const RELATED_PROPERTIES:Object = {left:["x"], top:["y"], right:["x"], bottom:["y"]};

        public function SetStyle(param1:IStyleClient = null, param2:String = null, param3:Object = null)
        {
            this.target = param1;
            this.name = param2;
            this.value = param3;
            return;
        }// end function

        public function remove(param1:UIComponent) : void
        {
            var _loc_4:int = 0;
            var _loc_2:* = target ? (target) : (param1);
            if (oldValue is Number)
            {
                _loc_2.setStyle(name, Number(oldValue));
            }
            else if (oldValue is Boolean)
            {
                _loc_2.setStyle(name, toBoolean(oldValue));
            }
            else if (oldValue === null)
            {
                _loc_2.clearStyle(name);
            }
            else
            {
                _loc_2.setStyle(name, oldValue);
            }
            var _loc_3:* = RELATED_PROPERTIES[name] ? (RELATED_PROPERTIES[name]) : (null);
            if (_loc_3)
            {
                _loc_4 = 0;
                while (_loc_4 < _loc_3.length)
                {
                    
                    _loc_2[_loc_3[_loc_4]] = oldRelatedValues[_loc_4];
                    _loc_4++;
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
            var _loc_4:int = 0;
            var _loc_2:* = target ? (target) : (param1);
            var _loc_3:* = RELATED_PROPERTIES[name] ? (RELATED_PROPERTIES[name]) : (null);
            oldValue = _loc_2.getStyle(name);
            if (_loc_3)
            {
                oldRelatedValues = [];
                _loc_4 = 0;
                while (_loc_4 < _loc_3.length)
                {
                    
                    oldRelatedValues[_loc_4] = _loc_2[_loc_3[_loc_4]];
                    _loc_4++;
                }
            }
            if (value === null)
            {
                _loc_2.clearStyle(name);
            }
            else if (oldValue is Number)
            {
                if (name.toLowerCase().indexOf("color") != -1)
                {
                    _loc_2.setStyle(name, StyleManager.getColorName(value));
                }
                else
                {
                    _loc_2.setStyle(name, Number(value));
                }
            }
            else if (oldValue is Boolean)
            {
                _loc_2.setStyle(name, toBoolean(value));
            }
            else
            {
                _loc_2.setStyle(name, value);
            }
            return;
        }// end function

        public function initialize() : void
        {
            return;
        }// end function

    }
}
