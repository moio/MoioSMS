package mx.effects
{

    public class EffectTargetFilter extends Object
    {
        public var filterFunction:Function;
        public var filterStyles:Array;
        public var filterProperties:Array;
        public var requiredSemantics:Object = null;
        static const VERSION:String = "3.2.0.3958";

        public function EffectTargetFilter()
        {
            filterFunction = defaultFilterFunctionEx;
            filterProperties = [];
            filterStyles = [];
            return;
        }// end function

        protected function defaultFilterFunctionEx(param1:Array, param2:IEffectTargetHost, param3:Object) : Boolean
        {
            var _loc_4:String = null;
            if (requiredSemantics)
            {
                for (_loc_4 in requiredSemantics)
                {
                    
                    if (!param2)
                    {
                        return false;
                    }
                    if (param2.getRendererSemanticValue(param3, _loc_4) != requiredSemantics[_loc_4])
                    {
                        return false;
                    }
                }
                return true;
            }
            return defaultFilterFunction(param1, param3);
        }// end function

        protected function defaultFilterFunction(param1:Array, param2:Object) : Boolean
        {
            var _loc_5:PropertyChanges = null;
            var _loc_6:Array = null;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_3:* = param1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = param1[_loc_4];
                if (_loc_5.target == param2)
                {
                    _loc_6 = filterProperties.concat(filterStyles);
                    _loc_7 = _loc_6.length;
                    _loc_8 = 0;
                    while (_loc_8 < _loc_7)
                    {
                        
                        if (_loc_5.start[_loc_6[_loc_8]] !== undefined && _loc_5.end[_loc_6[_loc_8]] != _loc_5.start[_loc_6[_loc_8]])
                        {
                            return true;
                        }
                        _loc_8++;
                    }
                }
                _loc_4++;
            }
            return false;
        }// end function

        public function filterInstance(param1:Array, param2:IEffectTargetHost, param3:Object) : Boolean
        {
            if (filterFunction.length == 2)
            {
                return filterFunction(param1, param3);
            }
            return filterFunction(param1, param2, param3);
        }// end function

    }
}
