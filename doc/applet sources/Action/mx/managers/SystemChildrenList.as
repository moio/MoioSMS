package mx.managers
{
    import flash.display.*;
    import flash.geom.*;
    import mx.core.*;

    public class SystemChildrenList extends Object implements IChildList
    {
        private var lowerBoundReference:QName;
        private var upperBoundReference:QName;
        private var owner:SystemManager;
        static const VERSION:String = "3.2.0.3958";

        public function SystemChildrenList(param1:SystemManager, param2:QName, param3:QName)
        {
            this.owner = param1;
            this.lowerBoundReference = param2;
            this.upperBoundReference = param3;
            return;
        }// end function

        public function getChildAt(param1:int) : DisplayObject
        {
            var _loc_3:* = owner;
            var _loc_2:* = _loc_3.mx_internal::rawChildren_getChildAt(owner[lowerBoundReference] + param1);
            return _loc_2;
        }// end function

        public function getChildByName(param1:String) : DisplayObject
        {
            var _loc_2:* = owner;
            return _loc_2.mx_internal::rawChildren_getChildByName(param1);
        }// end function

        public function removeChildAt(param1:int) : DisplayObject
        {
            var _loc_3:* = owner;
            var _loc_2:* = _loc_3.mx_internal::rawChildren_removeChildAt(param1 + owner[lowerBoundReference]);
            var _loc_3:* = owner;
            var _loc_4:* = upperBoundReference;
            _loc_3[_loc_4] = owner[upperBoundReference]--;
            return _loc_2;
        }// end function

        public function getChildIndex(param1:DisplayObject) : int
        {
            var _loc_3:* = owner;
            var _loc_2:* = _loc_3.mx_internal::rawChildren_getChildIndex(param1);
            _loc_2 = _loc_2 - owner[lowerBoundReference];
            return _loc_2;
        }// end function

        public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
        {
            var _loc_3:* = owner;
            _loc_3.mx_internal::rawChildren_addChildAt(param1, owner[lowerBoundReference] + param2);
            var _loc_3:* = owner;
            var _loc_4:* = upperBoundReference;
            _loc_3[_loc_4] = owner[upperBoundReference]++;
            return param1;
        }// end function

        public function getObjectsUnderPoint(param1:Point) : Array
        {
            var _loc_2:* = owner;
            return _loc_2.mx_internal::rawChildren_getObjectsUnderPoint(param1);
        }// end function

        public function setChildIndex(param1:DisplayObject, param2:int) : void
        {
            var _loc_3:* = owner;
            _loc_3.mx_internal::rawChildren_setChildIndex(param1, owner[lowerBoundReference] + param2);
            return;
        }// end function

        public function get numChildren() : int
        {
            return owner[upperBoundReference] - owner[lowerBoundReference];
        }// end function

        public function contains(param1:DisplayObject) : Boolean
        {
            var _loc_2:int = 0;
            if (param1 != owner)
            {
                var _loc_3:* = owner;
            }
            if (_loc_3.mx_internal::rawChildren_contains(param1))
            {
                while (param1.parent != owner)
                {
                    
                    param1 = param1.parent;
                }
                var _loc_3:* = owner;
                _loc_2 = _loc_3.mx_internal::rawChildren_getChildIndex(param1);
                if (_loc_2 >= owner[lowerBoundReference] && _loc_2 < owner[upperBoundReference])
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function removeChild(param1:DisplayObject) : DisplayObject
        {
            var _loc_3:* = owner;
            var _loc_2:* = _loc_3.mx_internal::rawChildren_getChildIndex(param1);
            if (owner[lowerBoundReference] <= _loc_2 && _loc_2 < owner[upperBoundReference])
            {
                var _loc_3:* = owner;
                _loc_3.mx_internal::rawChildren_removeChild(param1);
                var _loc_3:* = owner;
                var _loc_4:* = upperBoundReference;
                _loc_3[_loc_4] = owner[upperBoundReference]--;
            }
            return param1;
        }// end function

        public function addChild(param1:DisplayObject) : DisplayObject
        {
            var _loc_2:* = owner;
            _loc_2.mx_internal::rawChildren_addChildAt(param1, owner[upperBoundReference]);
            var _loc_2:* = owner;
            var _loc_3:* = upperBoundReference;
            _loc_2[_loc_3] = owner[upperBoundReference]++;
            return param1;
        }// end function

    }
}
