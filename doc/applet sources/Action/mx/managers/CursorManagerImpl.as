package mx.managers
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.ui.*;
    import mx.core.*;
    import mx.events.*;
    import mx.styles.*;

    public class CursorManagerImpl extends Object implements ICursorManager
    {
        private var showSystemCursor:Boolean = false;
        private var nextCursorID:int = 1;
        private var systemManager:ISystemManager = null;
        private var cursorList:Array;
        private var _currentCursorYOffset:Number = 0;
        private var cursorHolder:Sprite;
        private var currentCursor:DisplayObject;
        private var sandboxRoot:IEventDispatcher = null;
        private var showCustomCursor:Boolean = false;
        private var listenForContextMenu:Boolean = false;
        private var _currentCursorID:int = 0;
        private var initialized:Boolean = false;
        private var overTextField:Boolean = false;
        private var _currentCursorXOffset:Number = 0;
        private var busyCursorList:Array;
        private var overLink:Boolean = false;
        private var sourceArray:Array;
        static const VERSION:String = "3.2.0.3958";
        private static var instance:ICursorManager;

        public function CursorManagerImpl(param1:ISystemManager = null)
        {
            cursorList = [];
            busyCursorList = [];
            sourceArray = [];
            if (instance && !param1)
            {
                throw new Error("Instance already exists.");
            }
            if (param1)
            {
                this.systemManager = param1 as ISystemManager;
            }
            else
            {
                this.systemManager = SystemManagerGlobals.topLevelSystemManagers[0] as ISystemManager;
            }
            sandboxRoot = this.systemManager.getSandboxRoot();
            sandboxRoot.addEventListener(InterManagerRequest.CURSOR_MANAGER_REQUEST, marshalCursorManagerHandler, false, 0, true);
            var _loc_2:* = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
            _loc_2.name = "update";
            sandboxRoot.dispatchEvent(_loc_2);
            return;
        }// end function

        public function set currentCursorYOffset(param1:Number) : void
        {
            var _loc_2:InterManagerRequest = null;
            _currentCursorYOffset = param1;
            if (!cursorHolder)
            {
                _loc_2 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                _loc_2.name = "currentCursorYOffset";
                _loc_2.value = currentCursorYOffset;
                sandboxRoot.dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function get currentCursorXOffset() : Number
        {
            return _currentCursorXOffset;
        }// end function

        public function removeCursor(param1:int) : void
        {
            var _loc_2:Object = null;
            var _loc_3:InterManagerRequest = null;
            var _loc_4:CursorQueueItem = null;
            if (initialized && !cursorHolder)
            {
                _loc_3 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                _loc_3.name = "removeCursor";
                _loc_3.value = param1;
                sandboxRoot.dispatchEvent(_loc_3);
                return;
            }
            for (_loc_2 in cursorList)
            {
                
                _loc_4 = cursorList[_loc_2];
                if (_loc_4.cursorID == param1)
                {
                    cursorList.splice(_loc_2, 1);
                    showCurrentCursor();
                    break;
                }
            }
            return;
        }// end function

        public function get currentCursorID() : int
        {
            return _currentCursorID;
        }// end function

        private function marshalMouseMoveHandler(event:Event) : void
        {
            var _loc_2:SWFBridgeRequest = null;
            var _loc_3:IEventDispatcher = null;
            if (cursorHolder.visible)
            {
                cursorHolder.visible = false;
                _loc_2 = new SWFBridgeRequest(SWFBridgeRequest.SHOW_MOUSE_CURSOR_REQUEST);
                if (systemManager.useSWFBridge())
                {
                    _loc_3 = systemManager.swfBridgeGroup.parentBridge;
                }
                else
                {
                    _loc_3 = systemManager;
                }
                _loc_2.requestor = _loc_3;
                _loc_3.dispatchEvent(_loc_2);
                if (_loc_2.data)
                {
                    Mouse.show();
                }
            }
            return;
        }// end function

        public function set currentCursorID(param1:int) : void
        {
            var _loc_2:InterManagerRequest = null;
            _currentCursorID = param1;
            if (!cursorHolder)
            {
                _loc_2 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                _loc_2.name = "currentCursorID";
                _loc_2.value = currentCursorID;
                sandboxRoot.dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function removeAllCursors() : void
        {
            var _loc_1:InterManagerRequest = null;
            if (initialized && !cursorHolder)
            {
                _loc_1 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                _loc_1.name = "removeAllCursors";
                sandboxRoot.dispatchEvent(_loc_1);
                return;
            }
            cursorList.splice(0);
            showCurrentCursor();
            return;
        }// end function

        private function priorityCompare(param1:CursorQueueItem, param2:CursorQueueItem) : int
        {
            if (param1.priority < param2.priority)
            {
                return -1;
            }
            if (param1.priority == param2.priority)
            {
                return 0;
            }
            return 1;
        }// end function

        public function setBusyCursor() : void
        {
            var _loc_3:InterManagerRequest = null;
            if (initialized && !cursorHolder)
            {
                _loc_3 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                _loc_3.name = "setBusyCursor";
                sandboxRoot.dispatchEvent(_loc_3);
                return;
            }
            var _loc_1:* = StyleManager.getStyleDeclaration("CursorManager");
            var _loc_2:* = _loc_1.getStyle("busyCursor");
            busyCursorList.push(setCursor(_loc_2, CursorManagerPriority.LOW));
            return;
        }// end function

        public function showCursor() : void
        {
            var _loc_1:InterManagerRequest = null;
            if (cursorHolder)
            {
                cursorHolder.visible = true;
            }
            else
            {
                _loc_1 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                _loc_1.name = "showCursor";
                sandboxRoot.dispatchEvent(_loc_1);
            }
            return;
        }// end function

        private function findSource(param1:Object) : int
        {
            var _loc_2:* = sourceArray.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (sourceArray[_loc_3] === param1)
                {
                    return _loc_3;
                }
                _loc_3++;
            }
            return -1;
        }// end function

        private function showCurrentCursor() : void
        {
            var _loc_1:InteractiveObject = null;
            var _loc_2:InteractiveObject = null;
            var _loc_3:CursorQueueItem = null;
            var _loc_4:InterManagerRequest = null;
            var _loc_5:Point = null;
            if (cursorList.length > 0)
            {
                if (!initialized)
                {
                    cursorHolder = new FlexSprite();
                    cursorHolder.name = "cursorHolder";
                    cursorHolder.mouseEnabled = false;
                    cursorHolder.mouseChildren = false;
                    systemManager.addChildToSandboxRoot("cursorChildren", cursorHolder);
                    initialized = true;
                    _loc_4 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                    _loc_4.name = "initialized";
                    sandboxRoot.dispatchEvent(_loc_4);
                }
                _loc_3 = cursorList[0];
                if (currentCursorID == CursorManager.NO_CURSOR)
                {
                    Mouse.hide();
                }
                if (_loc_3.cursorID != currentCursorID)
                {
                    if (cursorHolder.numChildren > 0)
                    {
                        cursorHolder.removeChildAt(0);
                    }
                    currentCursor = new _loc_3.cursorClass();
                    if (currentCursor)
                    {
                        if (currentCursor is InteractiveObject)
                        {
                            InteractiveObject(currentCursor).mouseEnabled = false;
                        }
                        if (currentCursor is DisplayObjectContainer)
                        {
                            DisplayObjectContainer(currentCursor).mouseChildren = false;
                        }
                        cursorHolder.addChild(currentCursor);
                        if (!listenForContextMenu)
                        {
                            _loc_1 = systemManager.document as InteractiveObject;
                            if (_loc_1 && _loc_1.contextMenu)
                            {
                                _loc_1.contextMenu.addEventListener(ContextMenuEvent.MENU_SELECT, contextMenu_menuSelectHandler);
                                listenForContextMenu = true;
                            }
                            _loc_2 = systemManager as InteractiveObject;
                            if (_loc_2 && _loc_2.contextMenu)
                            {
                                _loc_2.contextMenu.addEventListener(ContextMenuEvent.MENU_SELECT, contextMenu_menuSelectHandler);
                                listenForContextMenu = true;
                            }
                        }
                        if (systemManager is SystemManager)
                        {
                            _loc_5 = new Point(SystemManager(systemManager).mouseX + _loc_3.x, SystemManager(systemManager).mouseY + _loc_3.y);
                            _loc_5 = SystemManager(systemManager).localToGlobal(_loc_5);
                            _loc_5 = cursorHolder.parent.globalToLocal(_loc_5);
                            cursorHolder.x = _loc_5.x;
                            cursorHolder.y = _loc_5.y;
                        }
                        else if (systemManager is DisplayObject)
                        {
                            _loc_5 = new Point(DisplayObject(systemManager).mouseX + _loc_3.x, DisplayObject(systemManager).mouseY + _loc_3.y);
                            _loc_5 = DisplayObject(systemManager).localToGlobal(_loc_5);
                            _loc_5 = cursorHolder.parent.globalToLocal(_loc_5);
                            cursorHolder.x = DisplayObject(systemManager).mouseX + _loc_3.x;
                            cursorHolder.y = DisplayObject(systemManager).mouseY + _loc_3.y;
                        }
                        else
                        {
                            cursorHolder.x = _loc_3.x;
                            cursorHolder.y = _loc_3.y;
                        }
                        if (systemManager.useSWFBridge())
                        {
                            sandboxRoot.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, true, EventPriority.CURSOR_MANAGEMENT);
                        }
                        else
                        {
                            systemManager.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, true, EventPriority.CURSOR_MANAGEMENT);
                        }
                        sandboxRoot.addEventListener(SandboxMouseEvent.MOUSE_MOVE_SOMEWHERE, marshalMouseMoveHandler, false, EventPriority.CURSOR_MANAGEMENT);
                    }
                    currentCursorID = _loc_3.cursorID;
                    currentCursorXOffset = _loc_3.x;
                    currentCursorYOffset = _loc_3.y;
                }
            }
            else
            {
                if (currentCursorID != CursorManager.NO_CURSOR)
                {
                    currentCursorID = CursorManager.NO_CURSOR;
                    currentCursorXOffset = 0;
                    currentCursorYOffset = 0;
                    if (systemManager.useSWFBridge())
                    {
                        sandboxRoot.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, true);
                    }
                    else
                    {
                        systemManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, true);
                    }
                    sandboxRoot.removeEventListener(SandboxMouseEvent.MOUSE_MOVE_SOMEWHERE, marshalMouseMoveHandler, false);
                    cursorHolder.removeChild(currentCursor);
                    if (listenForContextMenu)
                    {
                        _loc_1 = systemManager.document as InteractiveObject;
                        if (_loc_1 && _loc_1.contextMenu)
                        {
                            _loc_1.contextMenu.removeEventListener(ContextMenuEvent.MENU_SELECT, contextMenu_menuSelectHandler);
                        }
                        _loc_2 = systemManager as InteractiveObject;
                        if (_loc_2 && _loc_2.contextMenu)
                        {
                            _loc_2.contextMenu.removeEventListener(ContextMenuEvent.MENU_SELECT, contextMenu_menuSelectHandler);
                        }
                        listenForContextMenu = false;
                    }
                }
                Mouse.show();
            }
            return;
        }// end function

        public function get currentCursorYOffset() : Number
        {
            return _currentCursorYOffset;
        }// end function

        private function contextMenu_menuSelectHandler(event:ContextMenuEvent) : void
        {
            showCustomCursor = true;
            sandboxRoot.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
            return;
        }// end function

        public function hideCursor() : void
        {
            var _loc_1:InterManagerRequest = null;
            if (cursorHolder)
            {
                cursorHolder.visible = false;
            }
            else
            {
                _loc_1 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                _loc_1.name = "hideCursor";
                sandboxRoot.dispatchEvent(_loc_1);
            }
            return;
        }// end function

        private function marshalCursorManagerHandler(event:Event) : void
        {
            var _loc_3:InterManagerRequest = null;
            if (event is InterManagerRequest)
            {
                return;
            }
            var _loc_2:* = event;
            switch(_loc_2.name)
            {
                case "initialized":
                {
                    initialized = _loc_2.value;
                    break;
                }
                case "currentCursorID":
                {
                    _currentCursorID = _loc_2.value;
                    break;
                }
                case "currentCursorXOffset":
                {
                    _currentCursorXOffset = _loc_2.value;
                    break;
                }
                case "currentCursorYOffset":
                {
                    _currentCursorYOffset = _loc_2.value;
                    break;
                }
                case "showCursor":
                {
                    if (cursorHolder)
                    {
                        cursorHolder.visible = true;
                    }
                    break;
                }
                case "hideCursor":
                {
                    if (cursorHolder)
                    {
                        cursorHolder.visible = false;
                    }
                    break;
                }
                case "setCursor":
                {
                    if (cursorHolder)
                    {
                        _loc_2.value = setCursor.apply(this, _loc_2.value);
                    }
                    break;
                }
                case "removeCursor":
                {
                    if (cursorHolder)
                    {
                        removeCursor.apply(this, [_loc_2.value]);
                    }
                    break;
                }
                case "removeAllCursors":
                {
                    if (cursorHolder)
                    {
                        removeAllCursors();
                    }
                    break;
                }
                case "setBusyCursor":
                {
                    if (cursorHolder)
                    {
                        setBusyCursor();
                    }
                    break;
                }
                case "removeBusyCursor":
                {
                    if (cursorHolder)
                    {
                        removeBusyCursor();
                    }
                    break;
                }
                case "registerToUseBusyCursor":
                {
                    if (cursorHolder)
                    {
                        registerToUseBusyCursor.apply(this, _loc_2.value);
                    }
                    break;
                }
                case "unRegisterToUseBusyCursor":
                {
                    if (cursorHolder)
                    {
                        unRegisterToUseBusyCursor.apply(this, _loc_2.value);
                    }
                    break;
                }
                case "update":
                {
                    if (cursorHolder)
                    {
                        _loc_3 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                        _loc_3.name = "initialized";
                        _loc_3.value = true;
                        sandboxRoot.dispatchEvent(_loc_3);
                        _loc_3 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                        _loc_3.name = "currentCursorID";
                        _loc_3.value = currentCursorID;
                        sandboxRoot.dispatchEvent(_loc_3);
                        _loc_3 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                        _loc_3.name = "currentCursorXOffset";
                        _loc_3.value = currentCursorXOffset;
                        sandboxRoot.dispatchEvent(_loc_3);
                        _loc_3 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                        _loc_3.name = "currentCursorYOffset";
                        _loc_3.value = currentCursorYOffset;
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

        public function registerToUseBusyCursor(param1:Object) : void
        {
            var _loc_2:InterManagerRequest = null;
            if (initialized && !cursorHolder)
            {
                _loc_2 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                _loc_2.name = "registerToUseBusyCursor";
                _loc_2.value = param1;
                sandboxRoot.dispatchEvent(_loc_2);
                return;
            }
            if (param1 && param1 is EventDispatcher)
            {
                param1.addEventListener(ProgressEvent.PROGRESS, progressHandler);
                param1.addEventListener(Event.COMPLETE, completeHandler);
                param1.addEventListener(IOErrorEvent.IO_ERROR, completeHandler);
            }
            return;
        }// end function

        private function completeHandler(event:Event) : void
        {
            var _loc_2:* = findSource(event.target);
            if (_loc_2 != -1)
            {
                sourceArray.splice(_loc_2, 1);
                removeBusyCursor();
            }
            return;
        }// end function

        public function removeBusyCursor() : void
        {
            var _loc_1:InterManagerRequest = null;
            if (initialized && !cursorHolder)
            {
                _loc_1 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                _loc_1.name = "removeBusyCursor";
                sandboxRoot.dispatchEvent(_loc_1);
                return;
            }
            if (busyCursorList.length > 0)
            {
                removeCursor(int(busyCursorList.pop()));
            }
            return;
        }// end function

        public function setCursor(param1:Class, param2:int = 2, param3:Number = 0, param4:Number = 0) : int
        {
            var _loc_7:InterManagerRequest = null;
            if (initialized && !cursorHolder)
            {
                _loc_7 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                _loc_7.name = "setCursor";
                _loc_7.value = [param1, param2, param3, param4];
                sandboxRoot.dispatchEvent(_loc_7);
                return _loc_7.value as int;
            }
            var _loc_6:* = new CursorQueueItem();
            new CursorQueueItem().cursorID = nextCursorID++;
            _loc_6.cursorClass = param1;
            _loc_6.priority = param2;
            _loc_6.x = param3;
            _loc_6.y = param4;
            if (systemManager)
            {
                _loc_6.systemManager = systemManager;
            }
            else
            {
                _loc_6.systemManager = ApplicationGlobals.application.systemManager;
            }
            cursorList.push(_loc_6);
            cursorList.sort(priorityCompare);
            showCurrentCursor();
            return _loc_5;
        }// end function

        private function progressHandler(event:ProgressEvent) : void
        {
            var _loc_2:* = findSource(event.target);
            if (_loc_2 == -1)
            {
                sourceArray.push(event.target);
                setBusyCursor();
            }
            return;
        }// end function

        private function mouseMoveHandler(event:MouseEvent) : void
        {
            var _loc_4:SWFBridgeRequest = null;
            var _loc_5:IEventDispatcher = null;
            var _loc_2:* = new Point(event.stageX, event.stageY);
            _loc_2 = cursorHolder.parent.globalToLocal(_loc_2);
            _loc_2.x = _loc_2.x + currentCursorXOffset;
            _loc_2.y = _loc_2.y + currentCursorYOffset;
            cursorHolder.x = _loc_2.x;
            cursorHolder.y = _loc_2.y;
            var _loc_3:* = event.target;
            if (!overTextField && _loc_3 is TextField && _loc_3.type == TextFieldType.INPUT)
            {
                overTextField = true;
                showSystemCursor = true;
            }
            else if (overTextField && _loc_3 is TextField && _loc_3.type != TextFieldType.INPUT)
            {
                overTextField = false;
                showCustomCursor = true;
            }
            else
            {
                showCustomCursor = true;
            }
            if (showSystemCursor)
            {
                showSystemCursor = false;
                cursorHolder.visible = false;
                Mouse.show();
            }
            if (showCustomCursor)
            {
                showCustomCursor = false;
                cursorHolder.visible = true;
                Mouse.hide();
                _loc_4 = new SWFBridgeRequest(SWFBridgeRequest.HIDE_MOUSE_CURSOR_REQUEST);
                if (systemManager.useSWFBridge())
                {
                    _loc_5 = systemManager.swfBridgeGroup.parentBridge;
                }
                else
                {
                    _loc_5 = systemManager;
                }
                _loc_4.requestor = _loc_5;
                _loc_5.dispatchEvent(_loc_4);
            }
            return;
        }// end function

        public function unRegisterToUseBusyCursor(param1:Object) : void
        {
            var _loc_2:InterManagerRequest = null;
            if (initialized && !cursorHolder)
            {
                _loc_2 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                _loc_2.name = "unRegisterToUseBusyCursor";
                _loc_2.value = param1;
                sandboxRoot.dispatchEvent(_loc_2);
                return;
            }
            if (param1 && param1 is EventDispatcher)
            {
                param1.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
                param1.removeEventListener(Event.COMPLETE, completeHandler);
                param1.removeEventListener(IOErrorEvent.IO_ERROR, completeHandler);
            }
            return;
        }// end function

        private function mouseOverHandler(event:MouseEvent) : void
        {
            sandboxRoot.removeEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
            mouseMoveHandler(event);
            return;
        }// end function

        public function set currentCursorXOffset(param1:Number) : void
        {
            var _loc_2:InterManagerRequest = null;
            _currentCursorXOffset = param1;
            if (!cursorHolder)
            {
                _loc_2 = new InterManagerRequest(InterManagerRequest.CURSOR_MANAGER_REQUEST);
                _loc_2.name = "currentCursorXOffset";
                _loc_2.value = currentCursorXOffset;
                sandboxRoot.dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public static function getInstance() : ICursorManager
        {
            if (!instance)
            {
                instance = new CursorManagerImpl;
            }
            return instance;
        }// end function

    }
}
