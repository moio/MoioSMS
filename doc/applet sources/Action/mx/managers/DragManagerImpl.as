package mx.managers
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import mx.core.*;
    import mx.events.*;
    import mx.managers.dragClasses.*;
    import mx.styles.*;

    public class DragManagerImpl extends Object implements IDragManager
    {
        private var bDoingDrag:Boolean = false;
        private var sandboxRoot:IEventDispatcher;
        public var dragProxy:DragProxy;
        private var dragInitiator:IUIComponent;
        private var mouseIsDown:Boolean = false;
        private static var instance:IDragManager;
        static const VERSION:String = "3.2.0.3958";
        private static var sm:ISystemManager;

        public function DragManagerImpl()
        {
            var _loc_1:IEventDispatcher = null;
            if (instance)
            {
                throw new Error("Instance already exists.");
            }
            if (!sm.isTopLevelRoot())
            {
                sandboxRoot = sm.getSandboxRoot();
                sandboxRoot.addEventListener(InterDragManagerEvent.DISPATCH_DRAG_EVENT, marshalDispatchEventHandler, false, 0, true);
            }
            else
            {
                _loc_1 = sm;
                _loc_1.addEventListener(MouseEvent.MOUSE_DOWN, sm_mouseDownHandler, false, 0, true);
                _loc_1.addEventListener(MouseEvent.MOUSE_UP, sm_mouseUpHandler, false, 0, true);
                sandboxRoot = sm;
                sandboxRoot.addEventListener(InterDragManagerEvent.DISPATCH_DRAG_EVENT, marshalDispatchEventHandler, false, 0, true);
            }
            sandboxRoot.addEventListener(InterManagerRequest.DRAG_MANAGER_REQUEST, marshalDragManagerHandler, false, 0, true);
            var _loc_2:* = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST);
            _loc_2.name = "update";
            sandboxRoot.dispatchEvent(_loc_2);
            return;
        }// end function

        private function marshalDragManagerHandler(event:Event) : void
        {
            var _loc_3:InterManagerRequest = null;
            if (event is InterManagerRequest)
            {
                return;
            }
            var _loc_2:* = event;
            switch(_loc_2.name)
            {
                case "isDragging":
                {
                    bDoingDrag = _loc_2.value;
                    break;
                }
                case "acceptDragDrop":
                {
                    if (dragProxy)
                    {
                        dragProxy.target = _loc_2.value;
                    }
                    break;
                }
                case "showFeedback":
                {
                    if (dragProxy)
                    {
                        showFeedback(_loc_2.value);
                    }
                    break;
                }
                case "getFeedback":
                {
                    if (dragProxy)
                    {
                        _loc_2.value = getFeedback();
                    }
                    break;
                }
                case "endDrag":
                {
                    endDrag();
                    break;
                }
                case "update":
                {
                    if (dragProxy && isDragging)
                    {
                        _loc_3 = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST);
                        _loc_3.name = "isDragging";
                        _loc_3.value = true;
                        sandboxRoot.dispatchEvent(_loc_3);
                    }
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function sm_mouseUpHandler(event:MouseEvent) : void
        {
            mouseIsDown = false;
            return;
        }// end function

        public function get isDragging() : Boolean
        {
            return bDoingDrag;
        }// end function

        public function doDrag(param1:IUIComponent, param2:DragSource, param3:MouseEvent, param4:IFlexDisplayObject = null, param5:Number = 0, param6:Number = 0, param7:Number = 0.5, param8:Boolean = true) : void
        {
            var _loc_9:Number = NaN;
            var _loc_10:Number = NaN;
            var _loc_18:CSSStyleDeclaration = null;
            var _loc_19:Class = null;
            if (bDoingDrag)
            {
                return;
            }
            if (!(param3.type == MouseEvent.MOUSE_DOWN || param3.type == MouseEvent.CLICK || mouseIsDown || param3.buttonDown))
            {
                return;
            }
            bDoingDrag = true;
            var _loc_11:* = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST);
            new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST).name = "isDragging";
            _loc_11.value = true;
            sandboxRoot.dispatchEvent(_loc_11);
            _loc_11 = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST);
            _loc_11.name = "mouseShield";
            _loc_11.value = true;
            sandboxRoot.dispatchEvent(_loc_11);
            this.dragInitiator = param1;
            dragProxy = new DragProxy(param1, param2);
            sm.addChildToSandboxRoot("popUpChildren", dragProxy);
            if (!param4)
            {
                _loc_18 = StyleManager.getStyleDeclaration("DragManager");
                _loc_19 = _loc_18.getStyle("defaultDragImageSkin");
                param4 = new _loc_19;
                dragProxy.addChild(DisplayObject(param4));
                _loc_9 = param1.width;
                _loc_10 = param1.height;
            }
            else
            {
                dragProxy.addChild(DisplayObject(param4));
                if (param4 is ILayoutManagerClient)
                {
                    UIComponentGlobals.layoutManager.validateClient(ILayoutManagerClient(param4), true);
                }
                if (param4 is IUIComponent)
                {
                    _loc_9 = (param4 as IUIComponent).getExplicitOrMeasuredWidth();
                    _loc_10 = (param4 as IUIComponent).getExplicitOrMeasuredHeight();
                }
                else
                {
                    _loc_9 = param4.measuredWidth;
                    _loc_10 = param4.measuredHeight;
                }
            }
            param4.setActualSize(_loc_9, _loc_10);
            dragProxy.setActualSize(_loc_9, _loc_10);
            dragProxy.alpha = param7;
            dragProxy.allowMove = param8;
            var _loc_12:* = param3.target;
            if (param3.target == null)
            {
                _loc_12 = param1;
            }
            var _loc_13:* = new Point(param3.localX, param3.localY);
            _loc_13 = DisplayObject(_loc_12).localToGlobal(_loc_13);
            _loc_13 = DisplayObject(sandboxRoot).globalToLocal(_loc_13);
            var _loc_14:* = _loc_13.x;
            var _loc_15:* = _loc_13.y;
            var _loc_16:* = DisplayObject(_loc_12).localToGlobal(new Point(param3.localX, param3.localY));
            _loc_16 = DisplayObject(param1).globalToLocal(_loc_16);
            dragProxy.xOffset = _loc_16.x + param5;
            dragProxy.yOffset = _loc_16.y + param6;
            dragProxy.x = _loc_14 - dragProxy.xOffset;
            dragProxy.y = _loc_15 - dragProxy.yOffset;
            dragProxy.startX = dragProxy.x;
            dragProxy.startY = dragProxy.y;
            if (param4 is DisplayObject)
            {
                DisplayObject(param4).cacheAsBitmap = true;
            }
            var _loc_17:* = dragProxy.automationDelegate;
            if (dragProxy.automationDelegate)
            {
                _loc_17.recordAutomatableDragStart(param1, param3);
            }
            return;
        }// end function

        private function sm_mouseDownHandler(event:MouseEvent) : void
        {
            mouseIsDown = true;
            return;
        }// end function

        public function showFeedback(param1:String) : void
        {
            var _loc_2:InterManagerRequest = null;
            if (dragProxy)
            {
                if (param1 == DragManager.MOVE && !dragProxy.allowMove)
                {
                    param1 = DragManager.COPY;
                }
                dragProxy.action = param1;
            }
            else if (isDragging)
            {
                _loc_2 = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST);
                _loc_2.name = "showFeedback";
                _loc_2.value = param1;
                sandboxRoot.dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function acceptDragDrop(param1:IUIComponent) : void
        {
            var _loc_2:InterManagerRequest = null;
            if (dragProxy)
            {
                dragProxy.target = param1 as DisplayObject;
            }
            else if (isDragging)
            {
                _loc_2 = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST);
                _loc_2.name = "acceptDragDrop";
                _loc_2.value = param1;
                sandboxRoot.dispatchEvent(_loc_2);
            }
            return;
        }// end function

        private function marshalDispatchEventHandler(event:Event) : void
        {
            if (event is InterDragManagerEvent)
            {
                return;
            }
            var _loc_2:* = event;
            var _loc_3:* = SystemManager.getSWFRoot(_loc_2.dropTarget);
            if (!_loc_3)
            {
                return;
            }
            var _loc_4:* = new DragEvent(_loc_2.dragEventType, _loc_2.bubbles, _loc_2.cancelable);
            new DragEvent(_loc_2.dragEventType, _loc_2.bubbles, _loc_2.cancelable).localX = _loc_2.localX;
            _loc_4.localY = _loc_2.localY;
            _loc_4.action = _loc_2.action;
            _loc_4.ctrlKey = _loc_2.ctrlKey;
            _loc_4.altKey = _loc_2.altKey;
            _loc_4.shiftKey = _loc_2.shiftKey;
            _loc_4.draggedItem = _loc_2.draggedItem;
            _loc_4.dragSource = new DragSource();
            var _loc_5:* = _loc_2.dragSource.formats;
            var _loc_6:* = _loc_2.dragSource.formats.length;
            var _loc_7:int = 0;
            while (_loc_7 < _loc_6)
            {
                
                _loc_4.dragSource.addData(_loc_2.dragSource.dataForFormat(_loc_5[_loc_7]), _loc_5[_loc_7]);
                _loc_7++;
            }
            if (!_loc_2.dropTarget.dispatchEvent(_loc_4))
            {
                event.preventDefault();
            }
            return;
        }// end function

        public function getFeedback() : String
        {
            var _loc_1:InterManagerRequest = null;
            if (!dragProxy && isDragging)
            {
                _loc_1 = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST);
                _loc_1.name = "getFeedback";
                sandboxRoot.dispatchEvent(_loc_1);
                return _loc_1.value as String;
            }
            return dragProxy ? (dragProxy.action) : (DragManager.NONE);
        }// end function

        public function endDrag() : void
        {
            var _loc_1:InterManagerRequest = null;
            if (dragProxy)
            {
                sm.removeChildFromSandboxRoot("popUpChildren", dragProxy);
                dragProxy.removeChildAt(0);
                dragProxy = null;
            }
            else if (isDragging)
            {
                _loc_1 = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST);
                _loc_1.name = "endDrag";
                sandboxRoot.dispatchEvent(_loc_1);
            }
            _loc_1 = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST);
            _loc_1.name = "mouseShield";
            _loc_1.value = false;
            sandboxRoot.dispatchEvent(_loc_1);
            dragInitiator = null;
            bDoingDrag = false;
            _loc_1 = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST);
            _loc_1.name = "isDragging";
            _loc_1.value = false;
            sandboxRoot.dispatchEvent(_loc_1);
            return;
        }// end function

        public static function getInstance() : IDragManager
        {
            if (!instance)
            {
                sm = SystemManagerGlobals.topLevelSystemManagers[0];
                instance = new DragManagerImpl;
            }
            return instance;
        }// end function

    }
}
