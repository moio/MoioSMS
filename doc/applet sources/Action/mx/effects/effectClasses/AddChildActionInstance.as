package mx.effects.effectClasses
{
    import flash.display.*;
    import mx.core.*;

    public class AddChildActionInstance extends ActionEffectInstance
    {
        public var index:int = -1;
        public var relativeTo:DisplayObjectContainer;
        public var position:String;
        static const VERSION:String = "3.2.0.3958";

        public function AddChildActionInstance(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function play() : void
        {
            var _loc_1:* = DisplayObject(target);
            super.play();
            if (!relativeTo && propertyChanges)
            {
                if (propertyChanges.start.parent == null && propertyChanges.end.parent != null)
                {
                    relativeTo = propertyChanges.end.parent;
                    position = "index";
                    index = propertyChanges.end.index;
                }
            }
            if (!mx_internal::playReversed)
            {
                if (target && _loc_1.parent == null && relativeTo)
                {
                    switch(position)
                    {
                        case "index":
                        {
                            if (index == -1)
                            {
                                relativeTo.addChild(_loc_1);
                            }
                            else
                            {
                                relativeTo.addChildAt(_loc_1, Math.min(index, relativeTo.numChildren));
                            }
                            break;
                        }
                        case "before":
                        {
                            relativeTo.parent.addChildAt(_loc_1, relativeTo.parent.getChildIndex(relativeTo));
                            break;
                        }
                        case "after":
                        {
                            relativeTo.parent.addChildAt(_loc_1, relativeTo.parent.getChildIndex(relativeTo) + 1);
                            break;
                        }
                        case "firstChild":
                        {
                            relativeTo.addChildAt(_loc_1, 0);
                        }
                        case "lastChild":
                        {
                            relativeTo.addChild(_loc_1);
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
            }
            else if (target && relativeTo && _loc_1.parent == relativeTo)
            {
                relativeTo.removeChild(_loc_1);
            }
            finishRepeat();
            return;
        }// end function

    }
}
