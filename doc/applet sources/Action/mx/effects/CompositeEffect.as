package mx.effects
{
    import mx.effects.effectClasses.*;

    public class CompositeEffect extends Effect
    {
        private var _affectedProperties:Array;
        private var childTargets:Array;
        public var children:Array;
        static const VERSION:String = "3.2.0.3958";

        public function CompositeEffect(param1:Object = null)
        {
            children = [];
            super(param1);
            instanceClass = CompositeEffectInstance;
            return;
        }// end function

        override public function createInstances(param1:Array = null) : Array
        {
            if (!param1)
            {
                param1 = this.targets;
            }
            childTargets = param1;
            var _loc_2:* = createInstance();
            childTargets = null;
            return _loc_2 ? ([_loc_2]) : ([]);
        }// end function

        override protected function initInstance(param1:IEffectInstance) : void
        {
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:Effect = null;
            super.initInstance(param1);
            var _loc_2:* = CompositeEffectInstance(param1);
            var _loc_3:* = childTargets;
            if (!(_loc_3 is Array))
            {
                _loc_3 = [_loc_3];
            }
            if (children)
            {
                _loc_4 = children.length;
                _loc_5 = 0;
                while (_loc_5 < _loc_4)
                {
                    
                    _loc_6 = children[_loc_5];
                    if (propertyChangesArray != null)
                    {
                        _loc_6.propertyChangesArray = propertyChangesArray;
                    }
                    if (_loc_6.filterObject == null && filterObject)
                    {
                        _loc_6.filterObject = filterObject;
                    }
                    if (effectTargetHost)
                    {
                        _loc_6.effectTargetHost = effectTargetHost;
                    }
                    if (_loc_6.targets.length == 0)
                    {
                        _loc_2.addChildSet(children[_loc_5].createInstances(_loc_3));
                    }
                    else
                    {
                        _loc_2.addChildSet(children[_loc_5].createInstances(_loc_6.targets));
                    }
                    _loc_5++;
                }
            }
            return;
        }// end function

        override function captureValues(param1:Array, param2:Boolean) : Array
        {
            var _loc_5:Effect = null;
            var _loc_3:* = children.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = children[_loc_4];
                param1 = _loc_5.captureValues(param1, param2);
                _loc_4++;
            }
            return param1;
        }// end function

        public function addChild(param1:IEffect) : void
        {
            children.push(param1);
            _affectedProperties = null;
            return;
        }// end function

        override function applyStartValues(param1:Array, param2:Array) : void
        {
            var _loc_5:Effect = null;
            var _loc_6:Array = null;
            var _loc_3:* = children.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = children[_loc_4];
                _loc_6 = _loc_5.targets.length > 0 ? (_loc_5.targets) : (param2);
                if (_loc_5.filterObject == null && filterObject)
                {
                    _loc_5.filterObject = filterObject;
                }
                _loc_5.applyStartValues(param1, _loc_6);
                _loc_4++;
            }
            return;
        }// end function

        override public function createInstance(param1:Object = null) : IEffectInstance
        {
            if (!childTargets)
            {
                childTargets = [param1];
            }
            var _loc_2:* = super.createInstance(param1);
            childTargets = null;
            return _loc_2;
        }// end function

        override protected function filterInstance(param1:Array, param2:Object) : Boolean
        {
            var _loc_3:Array = null;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            if (filterObject)
            {
                _loc_3 = targets;
                if (_loc_3.length == 0)
                {
                    _loc_3 = childTargets;
                }
                _loc_4 = _loc_3.length;
                _loc_5 = 0;
                while (_loc_5 < _loc_4)
                {
                    
                    if (filterObject.filterInstance(param1, effectTargetHost, _loc_3[_loc_5]))
                    {
                        return true;
                    }
                    _loc_5++;
                }
                return false;
            }
            return true;
        }// end function

        override public function captureStartValues() : void
        {
            var _loc_1:* = getChildrenTargets();
            propertyChangesArray = [];
            var _loc_2:* = _loc_1.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                propertyChangesArray.push(new PropertyChanges(_loc_1[_loc_3]));
                _loc_3++;
            }
            propertyChangesArray = captureValues(propertyChangesArray, true);
            endValuesCaptured = false;
            return;
        }// end function

        private function getChildrenTargets() : Array
        {
            var _loc_3:Array = null;
            var _loc_4:Effect = null;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_9:String = null;
            var _loc_1:Array = [];
            var _loc_2:Object = {};
            _loc_5 = children.length;
            _loc_6 = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_4 = children[_loc_6];
                if (_loc_4 is CompositeEffect)
                {
                    _loc_3 = CompositeEffect(_loc_4).getChildrenTargets();
                    _loc_7 = _loc_3.length;
                    _loc_8 = 0;
                    while (_loc_8 < _loc_7)
                    {
                        
                        if (_loc_3[_loc_8] != null)
                        {
                            _loc_2[_loc_3[_loc_8].toString()] = _loc_3[_loc_8];
                        }
                        _loc_8++;
                    }
                }
                else if (_loc_4.targets != null)
                {
                    _loc_7 = _loc_4.targets.length;
                    _loc_8 = 0;
                    while (_loc_8 < _loc_7)
                    {
                        
                        if (_loc_4.targets[_loc_8] != null)
                        {
                            _loc_2[_loc_4.targets[_loc_8].toString()] = _loc_4.targets[_loc_8];
                        }
                        _loc_8++;
                    }
                }
                _loc_6++;
            }
            _loc_5 = targets.length;
            _loc_6 = 0;
            while (_loc_6 < _loc_5)
            {
                
                if (targets[_loc_6] != null)
                {
                    _loc_2[targets[_loc_6].toString()] = targets[_loc_6];
                }
                _loc_6++;
            }
            for (_loc_9 in _loc_2)
            {
                
                _loc_1.push(_loc_2[_loc_9]);
            }
            return _loc_1;
        }// end function

        override public function getAffectedProperties() : Array
        {
            var _loc_1:Array = null;
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            if (!_affectedProperties)
            {
                _loc_1 = [];
                _loc_2 = children.length;
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    _loc_1 = _loc_1.concat(children[_loc_3].getAffectedProperties());
                    _loc_3++;
                }
                _affectedProperties = _loc_1;
            }
            return _affectedProperties;
        }// end function

    }
}
