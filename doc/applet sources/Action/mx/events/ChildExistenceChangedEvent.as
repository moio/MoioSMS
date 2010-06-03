package mx.events
{
    import flash.display.*;
    import flash.events.*;

    public class ChildExistenceChangedEvent extends Event
    {
        public var relatedObject:DisplayObject;
        public static const CHILD_REMOVE:String = "childRemove";
        static const VERSION:String = "3.2.0.3958";
        public static const OVERLAY_CREATED:String = "overlayCreated";
        public static const CHILD_ADD:String = "childAdd";

        public function ChildExistenceChangedEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:DisplayObject = null)
        {
            super(param1, param2, param3);
            this.relatedObject = param4;
            return;
        }// end function

        override public function clone() : Event
        {
            return new ChildExistenceChangedEvent(type, bubbles, cancelable, relatedObject);
        }// end function

    }
}
