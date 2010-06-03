package mx.managers
{
    import flash.desktop.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.system.*;
    import mx.core.*;
    import mx.events.*;
    import mx.managers.dragClasses.*;
    import mx.styles.*;

    public class NativeDragManagerImpl extends Object implements IDragManager
    {
        private var _dragImage:IFlexDisplayObject;
        private var sandboxRoot:IEventDispatcher;
        private var _relatedObject:InteractiveObject;
        private var _allowedActions:NativeDragOptions;
        private var _action:String;
        private var _clipboard:Clipboard;
        public var dragProxy:DragProxy;
        private var _dragInitiator:IUIComponent;
        private var mouseIsDown:Boolean = false;
        private var _offset:Point;
        private var _allowMove:Boolean;
        private static var sm:ISystemManager;
        private static var instance:IDragManager;

        public function NativeDragManagerImpl()
        {
            if (instance)
            {
                throw new Error("Instance already exists.");
            }
            registerSystemManager(sm);
            sandboxRoot = sm.getSandboxRoot();
            sandboxRoot.addEventListener(InterDragManagerEvent.DISPATCH_DRAG_EVENT, marshalDispatchEventHandler, false, 0, true);
            sandboxRoot.addEventListener(InterManagerRequest.DRAG_MANAGER_REQUEST, marshalDragManagerHandler, false, 0, true);
            var _loc_1:* = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST);
            _loc_1.name = "update";
            sandboxRoot.dispatchEvent(_loc_1);
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
            if (!isDragging)
            {
                _loc_1 = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST);
                _loc_1.name = "getFeedback";
                sandboxRoot.dispatchEvent(_loc_1);
                return _loc_1.value as String;
            }
            return NativeDragManager.dropAction;
        }// end function

        private function marshalDragManagerHandler(event:Event) : void
        {
            var _loc_3:InteractiveObject = null;
            var _loc_4:InterManagerRequest = null;
            if (event is InterManagerRequest)
            {
                return;
            }
            var _loc_2:* = event;
            switch(_loc_2.name)
            {
                case "isDragging":
                {
                    break;
                }
                case "acceptDragDrop":
                {
                    if (isDragging)
                    {
                        _loc_3 = _loc_2.value as InteractiveObject;
                        if (_loc_3)
                        {
                            NativeDragManager.acceptDragDrop(_loc_3);
                        }
                    }
                    break;
                }
                case "showFeedback":
                {
                    if (isDragging)
                    {
                        showFeedback(_loc_2.value);
                    }
                    break;
                }
                case "getFeedback":
                {
                    if (isDragging)
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
                    if (isDragging)
                    {
                        _loc_4 = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST);
                        _loc_4.name = "isDragging";
                        _loc_4.value = true;
                        sandboxRoot.dispatchEvent(_loc_4);
                    }
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        function unregisterSystemManager(param1:ISystemManager) : void
        {
            if (param1.isTopLevel())
            {
                param1.removeEventListener(MouseEvent.MOUSE_DOWN, sm_mouseDownHandler);
                param1.removeEventListener(MouseEvent.MOUSE_UP, sm_mouseUpHandler);
            }
            param1.stage.removeEventListener(NativeDragEvent.NATIVE_DRAG_ENTER, nativeDragEventHandler, true);
            param1.stage.removeEventListener(NativeDragEvent.NATIVE_DRAG_COMPLETE, nativeDragEventHandler, true);
            param1.stage.removeEventListener(NativeDragEvent.NATIVE_DRAG_DROP, nativeDragEventHandler, true);
            param1.stage.removeEventListener(NativeDragEvent.NATIVE_DRAG_EXIT, nativeDragEventHandler, true);
            param1.stage.removeEventListener(NativeDragEvent.NATIVE_DRAG_OVER, nativeDragEventHandler, true);
            param1.stage.removeEventListener(NativeDragEvent.NATIVE_DRAG_START, nativeDragEventHandler, true);
            return;
        }// end function

        public function get isDragging() : Boolean
        {
            return NativeDragManager.isDragging;
        }// end function

        function registerSystemManager(param1:ISystemManager) : void
        {
            if (param1.isTopLevel())
            {
                param1.addEventListener(MouseEvent.MOUSE_DOWN, sm_mouseDownHandler);
                param1.addEventListener(MouseEvent.MOUSE_UP, sm_mouseUpHandler);
            }
            param1.stage.addEventListener(NativeDragEvent.NATIVE_DRAG_ENTER, nativeDragEventHandler, true);
            param1.stage.addEventListener(NativeDragEvent.NATIVE_DRAG_COMPLETE, nativeDragEventHandler, true);
            param1.stage.addEventListener(NativeDragEvent.NATIVE_DRAG_DROP, nativeDragEventHandler, true);
            param1.stage.addEventListener(NativeDragEvent.NATIVE_DRAG_EXIT, nativeDragEventHandler, true);
            param1.stage.addEventListener(NativeDragEvent.NATIVE_DRAG_OVER, nativeDragEventHandler, true);
            param1.stage.addEventListener(NativeDragEvent.NATIVE_DRAG_START, nativeDragEventHandler, true);
            return;
        }// end function

        private function sm_mouseUpHandler(event:MouseEvent) : void
        {
            mouseIsDown = false;
            return;
        }// end function

        public function doDrag(param1:IUIComponent, param2:DragSource, param3:MouseEvent, param4:IFlexDisplayObject = null, param5:Number = 0, param6:Number = 0, param7:Number = 0.5, param8:Boolean = true) : void
        {
            var _loc_9:Number = NaN;
            var _loc_10:Number = NaN;
            var _loc_13:String = null;
            var _loc_14:Object = null;
            var _loc_15:CSSStyleDeclaration = null;
            var _loc_16:Class = null;
            if (isDragging)
            {
                return;
            }
            if (!(param3.type == MouseEvent.MOUSE_DOWN || param3.type == MouseEvent.CLICK || mouseIsDown || param3.buttonDown))
            {
                return;
            }
            var _loc_11:* = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST);
            new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST).name = "isDragging";
            _loc_11.value = true;
            sandboxRoot.dispatchEvent(_loc_11);
            _loc_11 = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST);
            _loc_11.name = "mouseShield";
            _loc_11.value = true;
            sandboxRoot.dispatchEvent(_loc_11);
            _clipboard = new Clipboard();
            _dragInitiator = param1;
            _offset = new Point(param5, param6);
            _allowMove = param8;
            _offset.y = _offset.y - InteractiveObject(param1).mouseY;
            _offset.x = _offset.x - InteractiveObject(param1).mouseX;
            _allowedActions = new NativeDragOptions();
            _allowedActions.allowCopy = true;
            _allowedActions.allowLink = true;
            _allowedActions.allowMove = param8;
            var _loc_12:int = 0;
            while (_loc_12 < param2.formats.length)
            {
                
                _loc_13 = param2.formats[_loc_12] as String;
                _loc_14 = param2.dataForFormat(_loc_13);
                _clipboard.setData(_loc_13, _loc_14);
                _loc_12++;
            }
            if (!param4)
            {
                _loc_15 = StyleManager.getStyleDeclaration("DragManager");
                _loc_16 = _loc_15.getStyle("defaultDragImageSkin");
                param4 = new _loc_16;
                _loc_9 = param1 ? (param1.width) : (0);
                _loc_10 = param1 ? (param1.height) : (0);
                if (param4 is IFlexDisplayObject)
                {
                    IFlexDisplayObject(param4).setActualSize(_loc_9, _loc_10);
                }
            }
            else
            {
                _loc_9 = param4.width;
                _loc_10 = param4.height;
            }
            _dragImage = param4;
            if (param4 is IUIComponent && param4 is ILayoutManagerClient && !ILayoutManagerClient(param4).initialized && param1)
            {
                param4.addEventListener(FlexEvent.UPDATE_COMPLETE, initiateDrag);
                param1.systemManager.popUpChildren.addChild(DisplayObject(param4));
                if (param4 is ILayoutManagerClient)
                {
                    UIComponentGlobals.layoutManager.validateClient(ILayoutManagerClient(param4), true);
                }
                if (param4 is IUIComponent)
                {
                    param4.setActualSize(_loc_9, _loc_10);
                    _loc_9 = (param4 as IUIComponent).getExplicitOrMeasuredWidth();
                    _loc_10 = (param4 as IUIComponent).getExplicitOrMeasuredHeight();
                }
                else
                {
                    _loc_9 = param4.measuredWidth;
                    _loc_10 = param4.measuredHeight;
                }
                if (param4 is ILayoutManagerClient)
                {
                    UIComponentGlobals.layoutManager.validateClient(ILayoutManagerClient(param4));
                }
            }
            else
            {
                initiateDrag(null, false);
                return;
            }
            return;
        }// end function

        private function isSameOrChildApplicationDomain(param1:Object) : Boolean
        {
            var _loc_2:* = SystemManager.getSWFRoot(param1);
            return _loc_2 != null;
        }// end function

        public function showFeedback(param1:String) : void
        {
            var _loc_2:InterManagerRequest = null;
            if (isDragging)
            {
                if (param1 == DragManager.MOVE && !_allowedActions.allowMove)
                {
                    return;
                }
                if (param1 == DragManager.COPY && !_allowedActions.allowCopy)
                {
                    return;
                }
                if (param1 == DragManager.LINK && !_allowedActions.allowLink)
                {
                    return;
                }
                NativeDragManager.dropAction = param1;
            }
            else
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
            var _loc_2:InteractiveObject = null;
            var _loc_3:InterManagerRequest = null;
            if (isDragging)
            {
                _loc_2 = param1 as InteractiveObject;
                if (_loc_2)
                {
                    NativeDragManager.acceptDragDrop(_loc_2);
                }
            }
            else
            {
                _loc_3 = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST);
                _loc_3.name = "acceptDragDrop";
                _loc_3.value = param1;
                sandboxRoot.dispatchEvent(_loc_3);
            }
            return;
        }// end function

        private function initiateDrag(event:FlexEvent, param2:Boolean = true) : void
        {
            var _loc_3:BitmapData = null;
            if (param2)
            {
                _dragImage.removeEventListener(FlexEvent.UPDATE_COMPLETE, initiateDrag);
            }
            if (_dragImage.width && _dragImage.height)
            {
                _loc_3 = new BitmapData(_dragImage.width, _dragImage.height, true, 0);
            }
            else
            {
                _loc_3 = new BitmapData(1, 1, true, 0);
            }
            _loc_3.draw(_dragImage);
            if (param2 && _dragImage is IUIComponent && _dragInitiator)
            {
                _dragInitiator.systemManager.popUpChildren.removeChild(DisplayObject(_dragImage));
            }
            NativeDragManager.doDrag(InteractiveObject(_dragInitiator), _clipboard, _loc_3, _offset, _allowedActions);
            return;
        }// end function

        public function endDrag() : void
        {
            var _loc_1:InterManagerRequest = null;
            _loc_1 = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST);
            _loc_1.name = "mouseShield";
            _loc_1.value = false;
            sandboxRoot.dispatchEvent(_loc_1);
            _loc_1 = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST);
            _loc_1.name = "isDragging";
            _loc_1.value = false;
            sandboxRoot.dispatchEvent(_loc_1);
            return;
        }// end function

        private function sm_mouseDownHandler(event:MouseEvent) : void
        {
            mouseIsDown = true;
            return;
        }// end function

        private function _dispatchDragEvent(param1:DisplayObject, param2:DragEvent) : void
        {
            var _loc_3:InterManagerRequest = null;
            var _loc_4:InterDragManagerEvent = null;
            if (isSameOrChildApplicationDomain(param1))
            {
                param1.dispatchEvent(param2);
            }
            else
            {
                _loc_3 = new InterManagerRequest(InterManagerRequest.INIT_MANAGER_REQUEST);
                _loc_3.name = "mx.managers.IDragManagerImpl";
                sandboxRoot.dispatchEvent(_loc_3);
                _loc_4 = new InterDragManagerEvent(InterDragManagerEvent.DISPATCH_DRAG_EVENT, false, false, param2.localX, param2.localY, param2.relatedObject, param2.ctrlKey, param2.altKey, param2.shiftKey, param2.buttonDown, param2.delta, param1, param2.type, param2.dragInitiator, param2.dragSource, param2.action, param2.draggedItem);
                sandboxRoot.dispatchEvent(_loc_4);
            }
            return;
        }// end function

        private function nativeDragEventHandler(event:NativeDragEvent) : void
        {
            var _loc_8:String = null;
            var _loc_9:Object = null;
            var _loc_10:InterManagerRequest = null;
            var _loc_13:int = 0;
            var _loc_2:* = event.type.charAt(6).toLowerCase() + event.type.substr(7);
            var _loc_3:* = new DragSource();
            var _loc_4:* = event.target as DisplayObject;
            var _loc_5:* = event.clipboard;
            var _loc_6:* = event.clipboard.formats;
            var _loc_7:* = event.clipboard.formats.length;
            _allowedActions = event.allowedActions;
            var _loc_11:Boolean = false;
            if (Capabilities.os.substring(0, 3) == "Mac")
            {
                _loc_11 = event.commandKey;
            }
            else
            {
                _loc_11 = event.controlKey;
            }
            if (NativeDragManager.dragInitiator != null)
            {
                if (true)
                {
                }
                NativeDragManager.dropAction = !_allowMove ? (DragManager.COPY) : (DragManager.MOVE);
            }
            if (event.type != NativeDragEvent.NATIVE_DRAG_EXIT)
            {
                _loc_13 = 0;
                while (_loc_13 < _loc_7)
                {
                    
                    _loc_8 = _loc_6[_loc_13];
                    if (_loc_5.hasFormat(_loc_8))
                    {
                        _loc_9 = _loc_5.getData(_loc_8);
                        _loc_3.addData(_loc_9, _loc_8);
                    }
                    _loc_13++;
                }
            }
            if (event.type == NativeDragEvent.NATIVE_DRAG_DROP)
            {
                _relatedObject = event.target as InteractiveObject;
            }
            var _loc_12:* = new DragEvent(_loc_2, false, event.cancelable, NativeDragManager.dragInitiator as IUIComponent, _loc_3, event.dropAction, _loc_11, event.altKey, event.shiftKey);
            new DragEvent(_loc_2, false, event.cancelable, NativeDragManager.dragInitiator as IUIComponent, _loc_3, event.dropAction, _loc_11, event.altKey, event.shiftKey).buttonDown = event.buttonDown;
            _loc_12.delta = event.delta;
            _loc_12.localX = event.localX;
            _loc_12.localY = event.localY;
            if (_loc_2 == DragEvent.DRAG_COMPLETE)
            {
                _loc_12.relatedObject = _relatedObject;
            }
            else
            {
                _loc_12.relatedObject = event.relatedObject;
            }
            _dispatchDragEvent(_loc_4, _loc_12);
            if (_loc_2 == DragEvent.DRAG_COMPLETE)
            {
                if (sm == sandboxRoot)
                {
                    endDrag();
                }
                else
                {
                    _loc_10 = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST);
                    _loc_10.name = "endDrag";
                    sandboxRoot.dispatchEvent(_loc_10);
                }
            }
            return;
        }// end function

        public static function getInstance() : IDragManager
        {
            if (!instance)
            {
                sm = SystemManagerGlobals.topLevelSystemManagers[0];
                instance = new NativeDragManagerImpl;
            }
            return instance;
        }// end function

    }
}
