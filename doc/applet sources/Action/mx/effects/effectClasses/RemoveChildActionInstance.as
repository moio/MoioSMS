package mx.effects.effectClasses
{
    import flash.display.*;
    import flash.events.*;
    import mx.core.*;

    public class RemoveChildActionInstance extends ActionEffectInstance
    {
        private var _startParent:DisplayObjectContainer;
        private var _startIndex:Number;
        static const VERSION:String = "3.2.0.3958";

        public function RemoveChildActionInstance(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function initEffect(event:Event) : void
        {
            super.initEffect(event);
            return;
        }// end function

        override public function play() : void
        {
            var _loc_1:* = DisplayObject(target);
            var _loc_2:Boolean = true;
            super.play();
            if (propertyChanges)
            {
                if (propertyChanges.start.parent != null)
                {
                }
                _loc_2 = propertyChanges.end.parent == null;
            }
            if (!mx_internal::playReversed)
            {
                if (_loc_2 && target && _loc_1.parent != null)
                {
                    _loc_1.parent.removeChild(_loc_1);
                }
            }
            else if (_startParent && !isNaN(_startIndex))
            {
                _startParent.addChildAt(_loc_1, _startIndex);
            }
            finishRepeat();
            return;
        }// end function

        override protected function saveStartValue()
        {
            var _loc_1:* = DisplayObject(target);
            if (target && _loc_1.parent != null)
            {
                _startIndex = _loc_1.parent.getChildIndex(_loc_1);
                _startParent = _loc_1.parent;
            }
            return;
        }// end function

    }
}
