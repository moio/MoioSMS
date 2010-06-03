package mx.events
{
    import flash.display.*;
    import flash.events.*;
    import mx.core.*;

    public class InterDragManagerEvent extends DragEvent
    {
        public var dropTarget:DisplayObject;
        public var dragEventType:String;
        static const VERSION:String = "3.2.0.3958";
        public static const DISPATCH_DRAG_EVENT:String = "dispatchDragEvent";

        public function InterDragManagerEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Number = 1.#QNAN, param5:Number = 1.#QNAN, param6:InteractiveObject = null, param7:Boolean = false, param8:Boolean = false, param9:Boolean = false, param10:Boolean = false, param11:int = 0, param12:DisplayObject = null, param13:String = null, param14:IUIComponent = null, param15:DragSource = null, param16:String = null, param17:Object = null)
        {
            super(param1, false, false, param14, param15, param16, param7, param8, param9);
            this.dropTarget = param12;
            this.dragEventType = param13;
            this.draggedItem = param17;
            this.localX = param4;
            this.localY = param5;
            this.buttonDown = param10;
            this.delta = param11;
            this.relatedObject = param6;
            return;
        }// end function

        override public function clone() : Event
        {
            var _loc_1:* = new InterDragManagerEvent(type, bubbles, cancelable, localX, localY, relatedObject, ctrlKey, altKey, shiftKey, buttonDown, delta, dropTarget, dragEventType, dragInitiator, dragSource, action, draggedItem);
            return _loc_1;
        }// end function

    }
}
