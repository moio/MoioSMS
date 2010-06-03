package mx.core
{
    import flash.display.*;
    import flash.geom.*;

    public class ContainerRawChildrenList extends Object implements IChildList
    {
        private var owner:Container;
        static const VERSION:String = "3.2.0.3958";

        public function ContainerRawChildrenList(param1:Container)
        {
            this.owner = param1;
            return;
        }// end function

        public function addChild(param1:DisplayObject) : DisplayObject
        {
            var _loc_2:* = owner;
            return _loc_2.mx_internal::rawChildren_addChild(param1);
        }// end function

        public function getChildIndex(param1:DisplayObject) : int
        {
            var _loc_2:* = owner;
            return _loc_2.mx_internal::rawChildren_getChildIndex(param1);
        }// end function

        public function setChildIndex(param1:DisplayObject, param2:int) : void
        {
            var _loc_3:* = owner;
            _loc_3.mx_internal::rawChildren_setChildIndex(param1, param2);
            return;
        }// end function

        public function getChildByName(param1:String) : DisplayObject
        {
            var _loc_2:* = owner;
            return _loc_2.mx_internal::rawChildren_getChildByName(param1);
        }// end function

        public function removeChildAt(param1:int) : DisplayObject
        {
            var _loc_2:* = owner;
            return _loc_2.mx_internal::rawChildren_removeChildAt(param1);
        }// end function

        public function get numChildren() : int
        {
            return mx_internal::$numChildren;
        }// end function

        public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
        {
            var _loc_3:* = owner;
            return _loc_3.mx_internal::rawChildren_addChildAt(param1, param2);
        }// end function

        public function getObjectsUnderPoint(param1:Point) : Array
        {
            var _loc_2:* = owner;
            return _loc_2.mx_internal::rawChildren_getObjectsUnderPoint(param1);
        }// end function

        public function contains(param1:DisplayObject) : Boolean
        {
            var _loc_2:* = owner;
            return _loc_2.mx_internal::rawChildren_contains(param1);
        }// end function

        public function removeChild(param1:DisplayObject) : DisplayObject
        {
            var _loc_2:* = owner;
            return _loc_2.mx_internal::rawChildren_removeChild(param1);
        }// end function

        public function getChildAt(param1:int) : DisplayObject
        {
            var _loc_2:* = owner;
            return _loc_2.mx_internal::rawChildren_getChildAt(param1);
        }// end function

    }
}
