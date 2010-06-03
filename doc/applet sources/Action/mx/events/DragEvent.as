package mx.events
{
    import flash.events.*;
    import mx.core.*;

    public class DragEvent extends MouseEvent
    {
        public var draggedItem:Object;
        public var action:String;
        public var dragInitiator:IUIComponent;
        public var dragSource:DragSource;
        public static const DRAG_DROP:String = "dragDrop";
        public static const DRAG_COMPLETE:String = "dragComplete";
        public static const DRAG_EXIT:String = "dragExit";
        public static const DRAG_ENTER:String = "dragEnter";
        public static const DRAG_START:String = "dragStart";
        static const VERSION:String = "3.2.0.3958";
        public static const DRAG_OVER:String = "dragOver";

        public function DragEvent(param1:String, param2:Boolean = false, param3:Boolean = true, param4:IUIComponent = null, param5:DragSource = null, param6:String = null, param7:Boolean = false, param8:Boolean = false, param9:Boolean = false)
        {
            super(param1, param2, param3);
            this.dragInitiator = param4;
            this.dragSource = param5;
            this.action = param6;
            this.ctrlKey = param7;
            this.altKey = param8;
            this.shiftKey = param9;
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new DragEvent(type, bubbles, cancelable, dragInitiator, dragSource, action, ctrlKey, altKey, shiftKey);
            _loc_1.relatedObject = this.relatedObject;
            _loc_1.localX = this.localX;
            _loc_1.localY = this.localY;
            return _loc_1;
        }// end function

    }
}
