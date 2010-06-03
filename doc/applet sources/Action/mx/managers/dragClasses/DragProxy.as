package mx.managers.dragClasses
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import mx.core.*;
    import mx.effects.*;
    import mx.events.*;
    import mx.managers.*;
    import mx.styles.*;

    public class DragProxy extends UIComponent
    {
        public var allowMove:Boolean = true;
        private var cursorClass:Class = null;
        public var action:String;
        private var sandboxRoot:IEventDispatcher;
        public var target:DisplayObject = null;
        public var dragInitiator:IUIComponent;
        public var xOffset:Number;
        public var yOffset:Number;
        public var dragSource:DragSource;
        private var cursorID:int = 0;
        private var lastMouseEvent:MouseEvent;
        public var startX:Number;
        public var startY:Number;
        private var lastKeyEvent:KeyboardEvent;
        static const VERSION:String = "3.2.0.3958";
        private static var $visible:QName = new QName(mx_internal, "$visible");

        public function DragProxy(param1:IUIComponent, param2:DragSource)
        {
            this.dragInitiator = param1;
            this.dragSource = param2;
            var _loc_3:* = param1.systemManager.topLevelSystemManager as ISystemManager;
            var _loc_5:* = _loc_3.getSandboxRoot();
            sandboxRoot = _loc_3.getSandboxRoot();
            var _loc_4:* = _loc_5;
            _loc_5.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, true);
            _loc_4.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, true);
            _loc_4.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
            _loc_4.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
            return;
        }// end function

        public function mouseUpHandler(event:MouseEvent) : void
        {
            var _loc_2:DragEvent = null;
            var _loc_6:Point = null;
            var _loc_7:Move = null;
            var _loc_8:Zoom = null;
            var _loc_9:Move = null;
            var _loc_3:* = dragInitiator.systemManager.topLevelSystemManager as ISystemManager;
            var _loc_4:* = sandboxRoot;
            sandboxRoot.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, true);
            _loc_4.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, true);
            _loc_4.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
            _loc_4.removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, mouseLeaveHandler);
            _loc_4.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
            var _loc_5:* = automationDelegate;
            if (target && action != DragManager.NONE)
            {
                _loc_2 = new DragEvent(DragEvent.DRAG_DROP);
                _loc_2.dragInitiator = dragInitiator;
                _loc_2.dragSource = dragSource;
                _loc_2.action = action;
                _loc_2.ctrlKey = event.ctrlKey;
                _loc_2.altKey = event.altKey;
                _loc_2.shiftKey = event.shiftKey;
                _loc_6 = new Point();
                _loc_6.x = lastMouseEvent.localX;
                _loc_6.y = lastMouseEvent.localY;
                _loc_6 = DisplayObject(lastMouseEvent.target).localToGlobal(_loc_6);
                _loc_6 = DisplayObject(target).globalToLocal(_loc_6);
                _loc_2.localX = _loc_6.x;
                _loc_2.localY = _loc_6.y;
                if (_loc_5)
                {
                    _loc_5.recordAutomatableDragDrop(target, _loc_2);
                }
                _dispatchDragEvent(target, _loc_2);
            }
            else
            {
                action = DragManager.NONE;
            }
            if (action == DragManager.NONE)
            {
                _loc_7 = new Move(this);
                _loc_7.addEventListener(EffectEvent.EFFECT_END, effectEndHandler);
                _loc_7.xFrom = x;
                _loc_7.yFrom = y;
                _loc_7.xTo = startX;
                _loc_7.yTo = startY;
                _loc_7.duration = 200;
                _loc_7.play();
            }
            else
            {
                _loc_8 = new Zoom(this);
                var _loc_10:int = 1;
                _loc_8.zoomHeightFrom = 1;
                new Zoom(this).zoomWidthFrom = _loc_10;
                var _loc_10:int = 0;
                _loc_8.zoomHeightTo = 0;
                _loc_8.zoomWidthTo = _loc_10;
                _loc_8.duration = 200;
                _loc_8.play();
                _loc_9 = new Move(this);
                _loc_9.addEventListener(EffectEvent.EFFECT_END, effectEndHandler);
                _loc_9.xFrom = x;
                _loc_9.yFrom = this.y;
                _loc_9.xTo = parent.mouseX;
                _loc_9.yTo = parent.mouseY;
                _loc_9.duration = 200;
                _loc_9.play();
            }
            _loc_2 = new DragEvent(DragEvent.DRAG_COMPLETE);
            _loc_2.dragInitiator = dragInitiator;
            _loc_2.dragSource = dragSource;
            _loc_2.relatedObject = InteractiveObject(target);
            _loc_2.action = action;
            _loc_2.ctrlKey = event.ctrlKey;
            _loc_2.altKey = event.altKey;
            _loc_2.shiftKey = event.shiftKey;
            dragInitiator.dispatchEvent(_loc_2);
            if (_loc_5 && action == DragManager.NONE)
            {
                _loc_5.recordAutomatableDragCancel(dragInitiator, _loc_2);
            }
            cursorManager.removeCursor(cursorID);
            cursorID = CursorManager.NO_CURSOR;
            this.lastMouseEvent = null;
            return;
        }// end function

        private function isSameOrChildApplicationDomain(param1:Object) : Boolean
        {
            var _loc_2:* = SystemManager.getSWFRoot(param1);
            if (_loc_2)
            {
                return true;
            }
            var _loc_3:* = new InterManagerRequest(InterManagerRequest.SYSTEM_MANAGER_REQUEST);
            _loc_3.name = "hasSWFBridges";
            sandboxRoot.dispatchEvent(_loc_3);
            if (!_loc_3.value)
            {
                return true;
            }
            return false;
        }// end function

        public function showFeedback() : void
        {
            var _loc_1:* = cursorClass;
            var _loc_2:* = StyleManager.getStyleDeclaration("DragManager");
            if (action == DragManager.COPY)
            {
                _loc_1 = _loc_2.getStyle("copyCursor");
            }
            else if (action == DragManager.LINK)
            {
                _loc_1 = _loc_2.getStyle("linkCursor");
            }
            else if (action == DragManager.NONE)
            {
                _loc_1 = _loc_2.getStyle("rejectCursor");
            }
            else
            {
                _loc_1 = _loc_2.getStyle("moveCursor");
            }
            if (_loc_1 != cursorClass)
            {
                cursorClass = _loc_1;
                if (cursorID != CursorManager.NO_CURSOR)
                {
                    cursorManager.removeCursor(cursorID);
                }
                cursorID = cursorManager.setCursor(cursorClass, 2, 0, 0);
            }
            return;
        }// end function

        override public function initialize() : void
        {
            super.initialize();
            dragInitiator.systemManager.getSandboxRoot().addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, mouseLeaveHandler);
            if (!getFocus())
            {
                setFocus();
            }
            return;
        }// end function

        public function mouseMoveHandler(event:MouseEvent) : void
        {
            var _loc_2:DragEvent = null;
            var _loc_3:DisplayObject = null;
            var _loc_4:int = 0;
            var _loc_10:Array = null;
            var _loc_14:Boolean = false;
            var _loc_15:DisplayObject = null;
            lastMouseEvent = event;
            var _loc_5:* = new Point();
            var _loc_6:* = new Point(event.localX, event.localY);
            var _loc_7:* = DisplayObject(event.target).localToGlobal(_loc_6);
            _loc_6 = DisplayObject(sandboxRoot).globalToLocal(_loc_7);
            var _loc_8:* = _loc_6.x;
            var _loc_9:* = _loc_6.y;
            x = _loc_8 - xOffset;
            y = _loc_9 - yOffset;
            if (!event)
            {
                return;
            }
            var _loc_11:* = systemManager.getTopLevelRoot();
            _loc_10 = [];
            DragProxy.getObjectsUnderPoint(DisplayObject(sandboxRoot), _loc_7, _loc_10);
            var _loc_12:DisplayObject = null;
            while (_loc_13-- >= 0)
            {
                
                _loc_12 = _loc_10[_loc_10.length--];
                if (_loc_12 != this && !contains(_loc_12))
                {
                    break;
                }
            }
            if (target)
            {
                _loc_14 = false;
                _loc_15 = target;
                _loc_3 = _loc_12;
                while (_loc_3)
                {
                    
                    if (_loc_3 == target)
                    {
                        dispatchDragEvent(DragEvent.DRAG_OVER, event, _loc_3);
                        _loc_14 = true;
                        break;
                    }
                    else
                    {
                        dispatchDragEvent(DragEvent.DRAG_ENTER, event, _loc_3);
                        if (target == _loc_3)
                        {
                            _loc_14 = false;
                            break;
                        }
                    }
                    _loc_3 = _loc_3.parent;
                }
                if (true)
                {
                    dispatchDragEvent(DragEvent.DRAG_EXIT, event, _loc_15);
                    if (target == _loc_15)
                    {
                        target = null;
                    }
                }
            }
            if (!target)
            {
                action = DragManager.MOVE;
                _loc_3 = _loc_12;
                while (_loc_3)
                {
                    
                    if (_loc_3 != this)
                    {
                        dispatchDragEvent(DragEvent.DRAG_ENTER, event, _loc_3);
                        if (target)
                        {
                            break;
                        }
                    }
                    _loc_3 = _loc_3.parent;
                }
                if (!target)
                {
                    action = DragManager.NONE;
                }
            }
            showFeedback();
            return;
        }// end function

        private function dispatchDragEvent(param1:String, param2:MouseEvent, param3:Object) : void
        {
            var _loc_4:* = new DragEvent(param1);
            var _loc_5:* = new Point();
            _loc_4.dragInitiator = dragInitiator;
            _loc_4.dragSource = dragSource;
            _loc_4.action = action;
            _loc_4.ctrlKey = param2.ctrlKey;
            _loc_4.altKey = param2.altKey;
            _loc_4.shiftKey = param2.shiftKey;
            _loc_5.x = lastMouseEvent.localX;
            _loc_5.y = lastMouseEvent.localY;
            _loc_5 = DisplayObject(lastMouseEvent.target).localToGlobal(_loc_5);
            _loc_5 = DisplayObject(param3).globalToLocal(_loc_5);
            _loc_4.localX = _loc_5.x;
            _loc_4.localY = _loc_5.y;
            _dispatchDragEvent(DisplayObject(param3), _loc_4);
            return;
        }// end function

        override protected function keyUpHandler(event:KeyboardEvent) : void
        {
            checkKeyEvent(event);
            return;
        }// end function

        private function effectEndHandler(event:EffectEvent) : void
        {
            var _loc_2:* = DragManager;
            _loc_2.mx_internal::endDrag();
            return;
        }// end function

        public function checkKeyEvent(event:KeyboardEvent) : void
        {
            var _loc_2:DragEvent = null;
            var _loc_3:Point = null;
            if (target)
            {
                if (lastKeyEvent && event.type == lastKeyEvent.type && event.keyCode == lastKeyEvent.keyCode)
                {
                    return;
                }
                lastKeyEvent = event;
                _loc_2 = new DragEvent(DragEvent.DRAG_OVER);
                _loc_2.dragInitiator = dragInitiator;
                _loc_2.dragSource = dragSource;
                _loc_2.action = action;
                _loc_2.ctrlKey = event.ctrlKey;
                _loc_2.altKey = event.altKey;
                _loc_2.shiftKey = event.shiftKey;
                _loc_3 = new Point();
                _loc_3.x = lastMouseEvent.localX;
                _loc_3.y = lastMouseEvent.localY;
                _loc_3 = DisplayObject(lastMouseEvent.target).localToGlobal(_loc_3);
                _loc_3 = DisplayObject(target).globalToLocal(_loc_3);
                _loc_2.localX = _loc_3.x;
                _loc_2.localY = _loc_3.y;
                _dispatchDragEvent(target, _loc_2);
                showFeedback();
            }
            return;
        }// end function

        public function mouseLeaveHandler(event:Event) : void
        {
            mouseUpHandler(lastMouseEvent);
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
                _loc_3.name = "mx.managers::IDragManager";
                sandboxRoot.dispatchEvent(_loc_3);
                _loc_4 = new InterDragManagerEvent(InterDragManagerEvent.DISPATCH_DRAG_EVENT, false, false, param2.localX, param2.localY, param2.relatedObject, param2.ctrlKey, param2.altKey, param2.shiftKey, param2.buttonDown, param2.delta, param1, param2.type, param2.dragInitiator, param2.dragSource, param2.action, param2.draggedItem);
                sandboxRoot.dispatchEvent(_loc_4);
            }
            return;
        }// end function

        override protected function keyDownHandler(event:KeyboardEvent) : void
        {
            checkKeyEvent(event);
            return;
        }// end function

        public function stage_mouseMoveHandler(event:MouseEvent) : void
        {
            if (event.target != stage)
            {
                return;
            }
            mouseMoveHandler(event);
            return;
        }// end function

        private static function getObjectsUnderPoint(param1:DisplayObject, param2:Point, param3:Array) : void
        {
            var doc:DisplayObjectContainer;
            var rc:Object;
            var n:int;
            var i:int;
            var child:DisplayObject;
            var obj:* = param1;
            var pt:* = param2;
            var arr:* = param3;
            if (!obj.visible)
            {
                return;
            }
            try
            {
                if (!obj[$visible])
                {
                    return;
                }
            }
            catch (e:Error)
            {
            }
            if (obj.hitTestPoint(pt.x, pt.y, true))
            {
                if (obj is InteractiveObject && InteractiveObject(obj).mouseEnabled)
                {
                    arr.push(obj);
                }
                if (obj is DisplayObjectContainer)
                {
                    doc = obj as DisplayObjectContainer;
                    if (doc.mouseChildren)
                    {
                        if ("rawChildren" in doc)
                        {
                            rc = doc["rawChildren"];
                            n = rc.numChildren;
                            i;
                            while (i < n)
                            {
                                
                                try
                                {
                                    getObjectsUnderPoint(rc.getChildAt(i), pt, arr);
                                }
                                catch (e:Error)
                                {
                                }
                                i = i++;
                            }
                        }
                        else if (doc.numChildren)
                        {
                            n = doc.numChildren;
                            i;
                            while (i < n)
                            {
                                
                                try
                                {
                                    child = doc.getChildAt(i);
                                    getObjectsUnderPoint(child, pt, arr);
                                }
                                catch (e:Error)
                                {
                                }
                                i = i++;
                            }
                        }
                    }
                }
            }
            return;
        }// end function

    }
}
