package mx.effects.effectClasses
{
    import mx.core.*;

    public class SetPropertyActionInstance extends ActionEffectInstance
    {
        private var _value:Object;
        public var name:String;
        static const VERSION:String = "3.2.0.3958";

        public function SetPropertyActionInstance(param1:Object)
        {
            super(param1);
            return;
        }// end function

        public function get value()
        {
            var _loc_1:* = undefined;
            if (mx_internal::playReversed)
            {
                _loc_1 = getStartValue();
                if (_loc_1 != undefined)
                {
                    return _loc_1;
                }
            }
            return _value;
        }// end function

        public function set value(param1) : void
        {
            _value = param1;
            return;
        }// end function

        override public function play() : void
        {
            var _loc_1:String = null;
            var _loc_2:Object = null;
            super.play();
            if (value === undefined && propertyChanges)
            {
                if (name in propertyChanges.end && propertyChanges.start[name] != propertyChanges.end[name])
                {
                    value = propertyChanges.end[name];
                }
            }
            if (target && name && value !== undefined)
            {
                if (target[name] is Number)
                {
                    _loc_1 = name;
                    _loc_2 = value;
                    if (name == "width" || name == "height")
                    {
                        if (_loc_2 is String && _loc_2.indexOf("%") >= 0)
                        {
                            _loc_1 = name == "width" ? ("percentWidth") : ("percentHeight");
                            _loc_2 = _loc_2.slice(0, _loc_2.indexOf("%"));
                        }
                    }
                    target[_loc_1] = Number(_loc_2);
                }
                else if (target[name] is Boolean)
                {
                    if (value is String)
                    {
                        target[name] = value.toLowerCase() == "true";
                    }
                    else
                    {
                        target[name] = value;
                    }
                }
                else
                {
                    target[name] = value;
                }
            }
            finishRepeat();
            return;
        }// end function

        override protected function saveStartValue()
        {
            if (name != null)
            {
                try
                {
                    return target[name];
                }
                catch (e:Error)
                {
                }
            }
            return undefined;
        }// end function

    }
}
