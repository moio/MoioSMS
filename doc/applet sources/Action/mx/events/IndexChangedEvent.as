package mx.events
{
    import flash.display.*;
    import flash.events.*;

    public class IndexChangedEvent extends Event
    {
        public var newIndex:Number;
        public var triggerEvent:Event;
        public var relatedObject:DisplayObject;
        public var oldIndex:Number;
        public static const HEADER_SHIFT:String = "headerShift";
        public static const CHANGE:String = "change";
        static const VERSION:String = "3.2.0.3958";
        public static const CHILD_INDEX_CHANGE:String = "childIndexChange";

        public function IndexChangedEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:DisplayObject = null, param5:Number = -1, param6:Number = -1, param7:Event = null)
        {
            super(param1, param2, param3);
            this.relatedObject = param4;
            this.oldIndex = param5;
            this.newIndex = param6;
            this.triggerEvent = param7;
            return;
        }// end function

        override public function clone() : Event
        {
            return new IndexChangedEvent(type, bubbles, cancelable, relatedObject, oldIndex, newIndex, triggerEvent);
        }// end function

    }
}
