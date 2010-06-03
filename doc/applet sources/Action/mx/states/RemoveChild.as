package mx.states
{
    import flash.display.*;
    import mx.core.*;

    public class RemoveChild extends Object implements IOverride
    {
        private var removed:Boolean;
        private var oldIndex:int;
        private var oldParent:DisplayObjectContainer;
        public var target:DisplayObject;
        static const VERSION:String = "3.2.0.3958";

        public function RemoveChild(param1:DisplayObject = null)
        {
            this.target = param1;
            return;
        }// end function

        public function remove(param1:UIComponent) : void
        {
            if (removed)
            {
                oldParent.addChildAt(target, oldIndex);
                if (target is UIComponent)
                {
                    var _loc_2:* = UIComponent(target);
                    _loc_2.mx_internal::updateCallbacks();
                }
                removed = false;
            }
            return;
        }// end function

        public function apply(param1:UIComponent) : void
        {
            removed = false;
            if (target.parent)
            {
                oldParent = target.parent;
                oldIndex = oldParent.getChildIndex(target);
                oldParent.removeChild(target);
                removed = true;
            }
            return;
        }// end function

        public function initialize() : void
        {
            return;
        }// end function

    }
}
