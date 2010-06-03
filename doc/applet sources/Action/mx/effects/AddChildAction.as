package mx.effects
{
    import flash.display.*;
    import mx.core.*;
    import mx.effects.effectClasses.*;

    public class AddChildAction extends Effect
    {
        private var localPropertyChanges:Array;
        public var relativeTo:DisplayObjectContainer;
        public var position:String = "index";
        public var index:int = -1;
        static const VERSION:String = "3.2.0.3958";
        private static var AFFECTED_PROPERTIES:Array = ["parent", "index"];

        public function AddChildAction(param1:Object = null)
        {
            super(param1);
            instanceClass = AddChildActionInstance;
            return;
        }// end function

        override public function createInstances(param1:Array = null) : Array
        {
            if (!param1)
            {
                param1 = this.targets;
            }
            if (param1 && mx_internal::propertyChangesArray)
            {
                localPropertyChanges = mx_internal::propertyChangesArray;
                param1.sort(targetSortHandler);
            }
            return super.createInstances(param1);
        }// end function

        override protected function initInstance(param1:IEffectInstance) : void
        {
            super.initInstance(param1);
            var _loc_2:* = AddChildActionInstance(param1);
            _loc_2.relativeTo = relativeTo;
            _loc_2.index = index;
            _loc_2.position = position;
            return;
        }// end function

        override public function getAffectedProperties() : Array
        {
            return AFFECTED_PROPERTIES;
        }// end function

        override protected function applyValueToTarget(param1:Object, param2:String, param3, param4:Object) : void
        {
            if (param2 == "parent" && param1.parent && param3 == undefined)
            {
                param1.parent.removeChild(param1);
            }
            return;
        }// end function

        override protected function getValueFromTarget(param1:Object, param2:String)
        {
            if (param2 == "index")
            {
                return param1.parent ? (param1.parent.getChildIndex(param1)) : (0);
            }
            return super.getValueFromTarget(param1, param2);
        }// end function

        private function getPropertyChanges(param1:Object) : PropertyChanges
        {
            var _loc_2:int = 0;
            while (_loc_2 < localPropertyChanges.length)
            {
                
                if (localPropertyChanges[_loc_2].target == param1)
                {
                    return localPropertyChanges[_loc_2];
                }
                _loc_2++;
            }
            return null;
        }// end function

        private function targetSortHandler(param1:Object, param2:Object) : Number
        {
            var _loc_3:* = getPropertyChanges(param1);
            var _loc_4:* = getPropertyChanges(param2);
            if (_loc_3 && _loc_4)
            {
                if (_loc_3.start.index > _loc_4.start.index)
                {
                    return 1;
                }
                if (_loc_3.start.index < _loc_4.start.index)
                {
                    return -1;
                }
            }
            return 0;
        }// end function

    }
}
