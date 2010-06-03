package mx.managers
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.system.*;
    import flash.text.*;
    import flash.utils.*;
    import mx.core.*;
    import mx.events.*;
    import mx.managers.systemClasses.*;
    import mx.messaging.config.*;
    import mx.preloaders.*;
    import mx.resources.*;
    import mx.styles.*;
    import mx.utils.*;

    public class SystemManager extends MovieClip implements IChildList, IFlexDisplayObject, IFlexModuleFactory, ISystemManager, ISWFBridgeProvider
    {
        private var _stage:Stage;
        var nestLevel:int = 0;
        private var currentSandboxEvent:Event;
        private var forms:Array;
        private var mouseCatcher:Sprite;
        private var _height:Number;
        private var dispatchingToSystemManagers:Boolean = false;
        private var preloader:Preloader;
        private var lastFrame:int;
        private var _document:Object;
        private var strongReferenceProxies:Dictionary;
        private var _rawChildren:SystemRawChildrenList;
        private var _topLevelSystemManager:ISystemManager;
        private var _toolTipIndex:int = 0;
        private var _explicitHeight:Number;
        private var idToPlaceholder:Object;
        private var _swfBridgeGroup:ISWFBridgeGroup;
        private var _toolTipChildren:SystemChildrenList;
        private var form:Object;
        private var _width:Number;
        private var initialized:Boolean = false;
        private var _focusPane:Sprite;
        private var _fontList:Object = null;
        private var isStageRoot:Boolean = true;
        private var _popUpChildren:SystemChildrenList;
        private var rslSizes:Array = null;
        private var _topMostIndex:int = 0;
        private var nextFrameTimer:Timer = null;
        var topLevel:Boolean = true;
        private var weakReferenceProxies:Dictionary;
        private var _cursorIndex:int = 0;
        private var isBootstrapRoot:Boolean = false;
        var _mouseY:Object;
        private var _numModalWindows:int = 0;
        var _mouseX:Object;
        private var _screen:Rectangle;
        var idleCounter:int = 0;
        private var _cursorChildren:SystemChildrenList;
        private var initCallbackFunctions:Array;
        private var bridgeToFocusManager:Dictionary;
        private var _noTopMostIndex:int = 0;
        private var _applicationIndex:int = 1;
        private var isDispatchingResizeEvent:Boolean;
        private var idleTimer:Timer;
        private var doneExecutingInitCallbacks:Boolean = false;
        private var _explicitWidth:Number;
        private var eventProxy:EventProxy;
        var topLevelWindow:IUIComponent;
        private static const IDLE_THRESHOLD:Number = 1000;
        static var lastSystemManager:SystemManager;
        private static const IDLE_INTERVAL:Number = 100;
        static var allSystemManagers:Dictionary = new Dictionary(true);
        static const VERSION:String = "3.2.0.3958";

        public function SystemManager()
        {
            initCallbackFunctions = [];
            forms = [];
            weakReferenceProxies = new Dictionary(true);
            strongReferenceProxies = new Dictionary(false);
            if (stage)
            {
                stage.scaleMode = StageScaleMode.NO_SCALE;
                stage.align = StageAlign.TOP_LEFT;
            }
            if (SystemManagerGlobals.topLevelSystemManagers.length > 0 && !stage)
            {
                topLevel = false;
            }
            if (!stage)
            {
                isStageRoot = false;
            }
            if (topLevel)
            {
                SystemManagerGlobals.topLevelSystemManagers.push(this);
            }
            lastSystemManager = this;
            var _loc_1:* = info()["compiledLocales"];
            if (_loc_1 != null)
            {
            }
            ResourceBundle.locale = _loc_1.length > 0 ? (_loc_1[0]) : ("en_US");
            executeCallbacks();
            stop();
            if (topLevel && currentFrame != 1)
            {
                throw new Error("The SystemManager constructor was called when the currentFrame was at " + currentFrame + " Please add this SWF to bug 129782.");
            }
            if (root && root.loaderInfo)
            {
                root.loaderInfo.addEventListener(Event.INIT, initHandler);
            }
            return;
        }// end function

        private function removeEventListenerFromSandboxes(param1:String, param2:Function, param3:Boolean = false, param4:IEventDispatcher = null) : void
        {
            var _loc_8:int = 0;
            if (!swfBridgeGroup)
            {
                return;
            }
            var _loc_5:* = new EventListenerRequest(EventListenerRequest.REMOVE_EVENT_LISTENER_REQUEST, false, false, param1, param3);
            var _loc_6:* = swfBridgeGroup.parentBridge;
            if (swfBridgeGroup.parentBridge && _loc_6 != param4)
            {
                _loc_6.removeEventListener(param1, param2, param3);
            }
            var _loc_7:* = swfBridgeGroup.getChildBridges();
            while (_loc_8 < _loc_7.length)
            {
                
                if (_loc_7[_loc_8] != param4)
                {
                    IEventDispatcher(_loc_7[_loc_8]).removeEventListener(param1, param2, param3);
                }
                _loc_8++;
            }
            dispatchEventFromSWFBridges(_loc_5, param4);
            return;
        }// end function

        function addingChild(param1:DisplayObject) : void
        {
            var _loc_4:DisplayObjectContainer = null;
            var _loc_2:int = 1;
            if (!topLevel && parent)
            {
                _loc_4 = parent.parent;
                while (_loc_4)
                {
                    
                    if (_loc_4 is ILayoutManagerClient)
                    {
                        _loc_2 = ILayoutManagerClient(_loc_4).nestLevel + 1;
                        break;
                    }
                    _loc_4 = _loc_4.parent;
                }
            }
            nestLevel = _loc_2;
            if (param1 is IUIComponent)
            {
                IUIComponent(param1).systemManager = this;
            }
            var _loc_3:* = Class(getDefinitionByName("mx.core.UIComponent"));
            if (param1 is IUIComponent && !IUIComponent(param1).document)
            {
                IUIComponent(param1).document = document;
            }
            if (param1 is ILayoutManagerClient)
            {
                ILayoutManagerClient(param1).nestLevel = nestLevel + 1;
            }
            if (param1 is InteractiveObject)
            {
                if (doubleClickEnabled)
                {
                    InteractiveObject(param1).doubleClickEnabled = true;
                }
            }
            if (param1 is IUIComponent)
            {
                IUIComponent(param1).parentChanged(this);
            }
            if (param1 is IStyleClient)
            {
                IStyleClient(param1).regenerateStyleCache(true);
            }
            if (param1 is ISimpleStyleClient)
            {
                ISimpleStyleClient(param1).styleChanged(null);
            }
            if (param1 is IStyleClient)
            {
                IStyleClient(param1).notifyStyleChangeInChildren(null, true);
            }
            if (_loc_3 && param1 is _loc_3)
            {
                this._loc_3(param1).initThemeColor();
            }
            if (_loc_3 && param1 is _loc_3)
            {
                this._loc_3(param1).stylesInitialized();
            }
            return;
        }// end function

        private function dispatchEventToOtherSystemManagers(event:Event) : void
        {
            dispatchingToSystemManagers = true;
            var _loc_2:* = SystemManagerGlobals.topLevelSystemManagers;
            var _loc_3:* = _loc_2.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (_loc_2[_loc_4] != this)
                {
                    _loc_2[_loc_4].dispatchEvent(event);
                }
                _loc_4++;
            }
            dispatchingToSystemManagers = false;
            return;
        }// end function

        private function idleTimer_timerHandler(event:TimerEvent) : void
        {
            idleCounter++;
            if (idleCounter * IDLE_INTERVAL > IDLE_THRESHOLD)
            {
                dispatchEvent(new FlexEvent(FlexEvent.IDLE));
            }
            return;
        }// end function

        private function initManagerHandler(event:Event) : void
        {
            var event:* = event;
            if (!dispatchingToSystemManagers)
            {
                dispatchEventToOtherSystemManagers(event);
            }
            if (event is InterManagerRequest)
            {
                return;
            }
            var name:* = event["name"];
            try
            {
                Singleton.getInstance(name);
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        private function getSizeRequestHandler(event:Event) : void
        {
            var _loc_2:* = Object(event);
            _loc_2.data = {width:measuredWidth, height:measuredHeight};
            return;
        }// end function

        private function beforeUnloadHandler(event:Event) : void
        {
            var _loc_2:DisplayObject = null;
            if (topLevel && stage)
            {
                _loc_2 = getSandboxRoot();
                if (_loc_2 != this)
                {
                    _loc_2.removeEventListener(Event.RESIZE, Stage_resizeHandler);
                }
            }
            removeParentBridgeListeners();
            dispatchEvent(event);
            return;
        }// end function

        public function getExplicitOrMeasuredHeight() : Number
        {
            return !isNaN(explicitHeight) ? (explicitHeight) : (measuredHeight);
        }// end function

        private function getVisibleRectRequestHandler(event:Event) : void
        {
            var _loc_5:Rectangle = null;
            var _loc_7:Point = null;
            var _loc_8:IEventDispatcher = null;
            if (event is SWFBridgeRequest)
            {
                return;
            }
            var _loc_2:* = SWFBridgeRequest.marshal(event);
            var _loc_3:* = Rectangle(_loc_2.data);
            var _loc_4:* = DisplayObject(swfBridgeGroup.getChildBridgeProvider(_loc_2.requestor));
            var _loc_6:Boolean = true;
            if (!DisplayObjectContainer(document).contains(_loc_4))
            {
                _loc_6 = false;
            }
            if (_loc_4 is ISWFLoader)
            {
                _loc_5 = ISWFLoader(_loc_4).getVisibleApplicationRect();
            }
            else
            {
                _loc_5 = _loc_4.getBounds(this);
                _loc_7 = localToGlobal(_loc_5.topLeft);
                _loc_5.x = _loc_7.x;
                _loc_5.y = _loc_7.y;
            }
            _loc_3 = _loc_3.intersection(_loc_5);
            _loc_2.data = _loc_3;
            if (_loc_6 && useSWFBridge())
            {
                _loc_8 = swfBridgeGroup.parentBridge;
                _loc_2.requestor = _loc_8;
                _loc_8.dispatchEvent(_loc_2);
            }
            Object(event).data = _loc_2.data;
            return;
        }// end function

        function notifyStyleChangeInChildren(param1:String, param2:Boolean) : void
        {
            var _loc_6:IStyleClient = null;
            var _loc_3:Boolean = false;
            var _loc_4:* = rawChildren.numChildren;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_6 = rawChildren.getChildAt(_loc_5) as IStyleClient;
                if (_loc_6)
                {
                    _loc_6.styleChanged(param1);
                    _loc_6.notifyStyleChangeInChildren(param1, param2);
                }
                if (isTopLevelWindow(DisplayObject(_loc_6)))
                {
                    _loc_3 = true;
                }
                _loc_4 = rawChildren.numChildren;
                _loc_5++;
            }
            if (!_loc_3 && topLevelWindow is IStyleClient)
            {
                IStyleClient(topLevelWindow).styleChanged(param1);
                IStyleClient(topLevelWindow).notifyStyleChangeInChildren(param1, param2);
            }
            return;
        }// end function

        function rawChildren_getObjectsUnderPoint(param1:Point) : Array
        {
            return super.getObjectsUnderPoint(param1);
        }// end function

        private function initHandler(event:Event) : void
        {
            var bridgeEvent:SWFBridgeEvent;
            var event:* = event;
            if (!isStageRoot)
            {
                if (root.loaderInfo.parentAllowsChild)
                {
                    try
                    {
                        if (!parent.dispatchEvent(new Event("mx.managers.SystemManager.isBootstrapRoot", false, true)))
                        {
                            isBootstrapRoot = true;
                        }
                    }
                    catch (e:Error)
                    {
                    }
                }
            }
            allSystemManagers[this] = this.loaderInfo.url;
            root.loaderInfo.removeEventListener(Event.INIT, initHandler);
            if (useSWFBridge())
            {
                swfBridgeGroup = new SWFBridgeGroup(this);
                swfBridgeGroup.parentBridge = loaderInfo.sharedEvents;
                addParentBridgeListeners();
                bridgeEvent = new SWFBridgeEvent(SWFBridgeEvent.BRIDGE_NEW_APPLICATION);
                bridgeEvent.data = swfBridgeGroup.parentBridge;
                swfBridgeGroup.parentBridge.dispatchEvent(bridgeEvent);
                addEventListener(SWFBridgeRequest.ADD_POP_UP_PLACE_HOLDER_REQUEST, addPlaceholderPopupRequestHandler);
                root.loaderInfo.addEventListener(Event.UNLOAD, unloadHandler, false, 0, true);
            }
            getSandboxRoot().addEventListener(InterManagerRequest.INIT_MANAGER_REQUEST, initManagerHandler, false, 0, true);
            if (getSandboxRoot() == this)
            {
                addEventListener(InterManagerRequest.SYSTEM_MANAGER_REQUEST, systemManagerHandler);
                addEventListener(InterManagerRequest.DRAG_MANAGER_REQUEST, multiWindowRedispatcher);
                addEventListener("dispatchDragEvent", multiWindowRedispatcher);
                addEventListener(SWFBridgeRequest.ADD_POP_UP_REQUEST, addPopupRequestHandler);
                addEventListener(SWFBridgeRequest.REMOVE_POP_UP_REQUEST, removePopupRequestHandler);
                addEventListener(SWFBridgeRequest.ADD_POP_UP_PLACE_HOLDER_REQUEST, addPlaceholderPopupRequestHandler);
                addEventListener(SWFBridgeRequest.REMOVE_POP_UP_PLACE_HOLDER_REQUEST, removePlaceholderPopupRequestHandler);
                addEventListener(SWFBridgeEvent.BRIDGE_WINDOW_ACTIVATE, activateFormSandboxEventHandler);
                addEventListener(SWFBridgeEvent.BRIDGE_WINDOW_DEACTIVATE, deactivateFormSandboxEventHandler);
                addEventListener(SWFBridgeRequest.HIDE_MOUSE_CURSOR_REQUEST, hideMouseCursorRequestHandler);
                addEventListener(SWFBridgeRequest.SHOW_MOUSE_CURSOR_REQUEST, showMouseCursorRequestHandler);
                addEventListener(SWFBridgeRequest.RESET_MOUSE_CURSOR_REQUEST, resetMouseCursorRequestHandler);
            }
            var docFrame:* = totalFrames == 1 ? (0) : (1);
            addEventListener(Event.ENTER_FRAME, docFrameListener);
            initialize();
            return;
        }// end function

        function findFocusManagerContainer(param1:SystemManagerProxy) : IFocusManagerContainer
        {
            var _loc_5:DisplayObject = null;
            var _loc_2:* = param1.rawChildren;
            var _loc_3:* = _loc_2.numChildren;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _loc_2.getChildAt(_loc_4);
                if (_loc_5 is IFocusManagerContainer)
                {
                    return IFocusManagerContainer(_loc_5);
                }
                _loc_4++;
            }
            return null;
        }// end function

        private function addPlaceholderPopupRequestHandler(event:Event) : void
        {
            var _loc_3:RemotePopUp = null;
            var _loc_2:* = SWFBridgeRequest.marshal(event);
            if (event.target != this && event is SWFBridgeRequest)
            {
                return;
            }
            if (!forwardPlaceholderRequest(_loc_2, true))
            {
                _loc_3 = new RemotePopUp(_loc_2.data.placeHolderId, _loc_2.requestor);
                forms.push(_loc_3);
            }
            return;
        }// end function

        override public function contains(param1:DisplayObject) : Boolean
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:DisplayObject = null;
            if (super.contains(param1))
            {
                if (param1.parent == this)
                {
                    _loc_2 = super.getChildIndex(param1);
                    if (_loc_2 < noTopMostIndex)
                    {
                        return true;
                    }
                }
                else
                {
                    _loc_3 = 0;
                    while (_loc_3 < noTopMostIndex)
                    {
                        
                        _loc_4 = super.getChildAt(_loc_3);
                        if (_loc_4 is IRawChildrenContainer)
                        {
                            if (IRawChildrenContainer(_loc_4).rawChildren.contains(param1))
                            {
                                return true;
                            }
                        }
                        if (_loc_4 is DisplayObjectContainer)
                        {
                            if (DisplayObjectContainer(_loc_4).contains(param1))
                            {
                                return true;
                            }
                        }
                        _loc_3++;
                    }
                }
            }
            return false;
        }// end function

        private function modalWindowRequestHandler(event:Event) : void
        {
            if (event is SWFBridgeRequest)
            {
                return;
            }
            var _loc_2:* = SWFBridgeRequest.marshal(event);
            if (!preProcessModalWindowRequest(_loc_2, getSandboxRoot()))
            {
                return;
            }
            Singleton.getInstance("mx.managers::IPopUpManager");
            dispatchEvent(_loc_2);
            return;
        }// end function

        private function activateApplicationSandboxEventHandler(event:Event) : void
        {
            if (!isTopLevelRoot())
            {
                swfBridgeGroup.parentBridge.dispatchEvent(event);
                return;
            }
            activateForm(document);
            return;
        }// end function

        public function getDefinitionByName(param1:String) : Object
        {
            var _loc_3:Object = null;
            if (!topLevel)
            {
            }
            var _loc_2:* = parent is Loader ? (Loader(parent).contentLoaderInfo.applicationDomain) : (info()["currentDomain"] as ApplicationDomain);
            if (_loc_2.hasDefinition(param1))
            {
                _loc_3 = _loc_2.getDefinition(param1);
            }
            return _loc_3;
        }// end function

        public function removeChildFromSandboxRoot(param1:String, param2:DisplayObject) : void
        {
            var _loc_3:InterManagerRequest = null;
            if (getSandboxRoot() == this)
            {
                this[param1].removeChild(param2);
            }
            else
            {
                removingChild(param2);
                _loc_3 = new InterManagerRequest(InterManagerRequest.SYSTEM_MANAGER_REQUEST);
                _loc_3.name = param1 + ".removeChild";
                _loc_3.value = param2;
                getSandboxRoot().dispatchEvent(_loc_3);
                childRemoved(param2);
            }
            return;
        }// end function

        private function removeEventListenerFromOtherSystemManagers(param1:String, param2:Function, param3:Boolean = false) : void
        {
            var _loc_4:* = SystemManagerGlobals.topLevelSystemManagers;
            if (SystemManagerGlobals.topLevelSystemManagers.length < 2)
            {
                return;
            }
            SystemManagerGlobals.changingListenersInOtherSystemManagers = true;
            var _loc_5:* = _loc_4.length;
            var _loc_6:int = 0;
            while (_loc_6 < _loc_5)
            {
                
                if (_loc_4[_loc_6] != this)
                {
                    _loc_4[_loc_6].removeEventListener(param1, param2, param3);
                }
                _loc_6++;
            }
            SystemManagerGlobals.changingListenersInOtherSystemManagers = false;
            return;
        }// end function

        private function addEventListenerToOtherSystemManagers(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            var _loc_6:* = SystemManagerGlobals.topLevelSystemManagers;
            if (SystemManagerGlobals.topLevelSystemManagers.length < 2)
            {
                return;
            }
            SystemManagerGlobals.changingListenersInOtherSystemManagers = true;
            var _loc_7:* = _loc_6.length;
            var _loc_8:int = 0;
            while (_loc_8 < _loc_7)
            {
                
                if (_loc_6[_loc_8] != this)
                {
                    _loc_6[_loc_8].addEventListener(param1, param2, param3, param4, param5);
                }
                _loc_8++;
            }
            SystemManagerGlobals.changingListenersInOtherSystemManagers = false;
            return;
        }// end function

        public function get embeddedFontList() : Object
        {
            var _loc_1:Object = null;
            var _loc_2:String = null;
            var _loc_3:Object = null;
            if (_fontList == null)
            {
                _fontList = {};
                _loc_1 = info()["fonts"];
                for (_loc_2 in _loc_1)
                {
                    
                    _fontList[_loc_2] = _loc_1[_loc_2];
                }
                if (!topLevel && _topLevelSystemManager)
                {
                    _loc_3 = _topLevelSystemManager.embeddedFontList;
                    for (_loc_2 in _loc_3)
                    {
                        
                        _fontList[_loc_2] = _loc_3[_loc_2];
                    }
                }
            }
            return _fontList;
        }// end function

        function set cursorIndex(param1:int) : void
        {
            var _loc_2:* = param1 - _cursorIndex;
            _cursorIndex = param1;
            return;
        }// end function

        function addChildBridgeListeners(param1:IEventDispatcher) : void
        {
            if (!topLevel && topLevelSystemManager)
            {
                SystemManager(topLevelSystemManager).addChildBridgeListeners(param1);
                return;
            }
            param1.addEventListener(SWFBridgeRequest.ADD_POP_UP_REQUEST, addPopupRequestHandler);
            param1.addEventListener(SWFBridgeRequest.REMOVE_POP_UP_REQUEST, removePopupRequestHandler);
            param1.addEventListener(SWFBridgeRequest.ADD_POP_UP_PLACE_HOLDER_REQUEST, addPlaceholderPopupRequestHandler);
            param1.addEventListener(SWFBridgeRequest.REMOVE_POP_UP_PLACE_HOLDER_REQUEST, removePlaceholderPopupRequestHandler);
            param1.addEventListener(SWFBridgeEvent.BRIDGE_WINDOW_ACTIVATE, activateFormSandboxEventHandler);
            param1.addEventListener(SWFBridgeEvent.BRIDGE_WINDOW_DEACTIVATE, deactivateFormSandboxEventHandler);
            param1.addEventListener(SWFBridgeEvent.BRIDGE_APPLICATION_ACTIVATE, activateApplicationSandboxEventHandler);
            param1.addEventListener(EventListenerRequest.ADD_EVENT_LISTENER_REQUEST, eventListenerRequestHandler, false, 0, true);
            param1.addEventListener(EventListenerRequest.REMOVE_EVENT_LISTENER_REQUEST, eventListenerRequestHandler, false, 0, true);
            param1.addEventListener(SWFBridgeRequest.CREATE_MODAL_WINDOW_REQUEST, modalWindowRequestHandler);
            param1.addEventListener(SWFBridgeRequest.SHOW_MODAL_WINDOW_REQUEST, modalWindowRequestHandler);
            param1.addEventListener(SWFBridgeRequest.HIDE_MODAL_WINDOW_REQUEST, modalWindowRequestHandler);
            param1.addEventListener(SWFBridgeRequest.GET_VISIBLE_RECT_REQUEST, getVisibleRectRequestHandler);
            param1.addEventListener(SWFBridgeRequest.HIDE_MOUSE_CURSOR_REQUEST, hideMouseCursorRequestHandler);
            param1.addEventListener(SWFBridgeRequest.SHOW_MOUSE_CURSOR_REQUEST, showMouseCursorRequestHandler);
            param1.addEventListener(SWFBridgeRequest.RESET_MOUSE_CURSOR_REQUEST, resetMouseCursorRequestHandler);
            return;
        }// end function

        public function set document(param1:Object) : void
        {
            _document = param1;
            return;
        }// end function

        override public function getChildAt(param1:int) : DisplayObject
        {
            return super.getChildAt(applicationIndex + param1);
        }// end function

        public function get rawChildren() : IChildList
        {
            if (!_rawChildren)
            {
                _rawChildren = new SystemRawChildrenList(this);
            }
            return _rawChildren;
        }// end function

        private function findLastActiveForm(param1:Object) : Object
        {
            var _loc_2:* = forms.length;
            while (_loc_3-- >= 0)
            {
                
                if (forms[forms.length--] != param1 && canActivatePopUp(forms[_loc_3]))
                {
                    return forms[_loc_3];
                }
            }
            return null;
        }// end function

        private function multiWindowRedispatcher(event:Event) : void
        {
            if (!dispatchingToSystemManagers)
            {
                dispatchEventToOtherSystemManagers(event);
            }
            return;
        }// end function

        public function deployMouseShields(param1:Boolean) : void
        {
            var _loc_2:* = new InterManagerRequest(InterManagerRequest.DRAG_MANAGER_REQUEST, false, false, "mouseShield", param1);
            getSandboxRoot().dispatchEvent(_loc_2);
            return;
        }// end function

        override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            var newListener:StageEventProxy;
            var actualType:String;
            var type:* = param1;
            var listener:* = param2;
            var useCapture:* = param3;
            var priority:* = param4;
            var useWeakReference:* = param5;
            if (type == FlexEvent.RENDER || type == FlexEvent.ENTER_FRAME)
            {
                if (type == FlexEvent.RENDER)
                {
                    type = Event.RENDER;
                }
                else
                {
                    type = Event.ENTER_FRAME;
                }
                try
                {
                    if (stage)
                    {
                        stage.addEventListener(type, listener, useCapture, priority, useWeakReference);
                    }
                    else
                    {
                        super.addEventListener(type, listener, useCapture, priority, useWeakReference);
                    }
                }
                catch (error:SecurityError)
                {
                    super.addEventListener(type, listener, useCapture, priority, useWeakReference);
                }
                if (stage && type == Event.RENDER)
                {
                    stage.invalidate();
                }
                return;
            }
            if (type == MouseEvent.MOUSE_MOVE || type == MouseEvent.MOUSE_UP || type == MouseEvent.MOUSE_DOWN || type == Event.ACTIVATE || type == Event.DEACTIVATE)
            {
                try
                {
                    if (stage)
                    {
                        newListener = new StageEventProxy(listener);
                        stage.addEventListener(type, newListener.stageListener, false, priority, useWeakReference);
                        if (useWeakReference)
                        {
                            weakReferenceProxies[listener] = newListener;
                        }
                        else
                        {
                            strongReferenceProxies[listener] = newListener;
                        }
                    }
                }
                catch (error:SecurityError)
                {
                }
            }
            if (hasSWFBridges() || SystemManagerGlobals.topLevelSystemManagers.length > 1)
            {
                if (!eventProxy)
                {
                    eventProxy = new EventProxy(this);
                }
                actualType = EventUtil.sandboxMouseEventMap[type];
                if (actualType)
                {
                    if (isTopLevelRoot())
                    {
                        stage.addEventListener(MouseEvent.MOUSE_MOVE, resetMouseCursorTracking, true, EventPriority.CURSOR_MANAGEMENT + 1, true);
                        addEventListenerToSandboxes(SandboxMouseEvent.MOUSE_MOVE_SOMEWHERE, resetMouseCursorTracking, true, EventPriority.CURSOR_MANAGEMENT + 1, true);
                    }
                    else
                    {
                        super.addEventListener(MouseEvent.MOUSE_MOVE, resetMouseCursorTracking, true, EventPriority.CURSOR_MANAGEMENT + 1, true);
                    }
                    addEventListenerToSandboxes(type, sandboxMouseListener, useCapture, priority, useWeakReference);
                    if (!SystemManagerGlobals.changingListenersInOtherSystemManagers)
                    {
                        addEventListenerToOtherSystemManagers(type, otherSystemManagerMouseListener, useCapture, priority, useWeakReference);
                    }
                    if (getSandboxRoot() == this)
                    {
                        super.addEventListener(actualType, eventProxy.marshalListener, useCapture, priority, useWeakReference);
                    }
                    super.addEventListener(type, listener, false, priority, useWeakReference);
                    return;
                }
            }
            if (type == FlexEvent.IDLE && !idleTimer)
            {
                idleTimer = new Timer(IDLE_INTERVAL);
                idleTimer.addEventListener(TimerEvent.TIMER, idleTimer_timerHandler);
                idleTimer.start();
                addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, true);
                addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, true);
            }
            super.addEventListener(type, listener, useCapture, priority, useWeakReference);
            return;
        }// end function

        private function activateForm(param1:Object) : void
        {
            var _loc_2:IFocusManagerContainer = null;
            if (form)
            {
                if (form != param1 && forms.length > 1)
                {
                    if (isRemotePopUp(form))
                    {
                        if (!areRemotePopUpsEqual(form, param1))
                        {
                            deactivateRemotePopUp(form);
                        }
                    }
                    else
                    {
                        _loc_2 = IFocusManagerContainer(form);
                        _loc_2.focusManager.deactivate();
                    }
                }
            }
            form = param1;
            if (isRemotePopUp(param1))
            {
                activateRemotePopUp(param1);
            }
            else if (param1.focusManager)
            {
                param1.focusManager.activate();
            }
            updateLastActiveForm();
            return;
        }// end function

        public function removeFocusManager(param1:IFocusManagerContainer) : void
        {
            var _loc_2:* = forms.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (forms[_loc_3] == param1)
                {
                    if (form == param1)
                    {
                        deactivate(param1);
                    }
                    dispatchDeactivatedWindowEvent(DisplayObject(param1));
                    forms.splice(_loc_3, 1);
                    return;
                }
                _loc_3++;
            }
            return;
        }// end function

        private function mouseMoveHandler(event:MouseEvent) : void
        {
            idleCounter = 0;
            return;
        }// end function

        private function getSandboxScreen() : Rectangle
        {
            var _loc_2:Rectangle = null;
            var _loc_3:DisplayObject = null;
            var _loc_4:InterManagerRequest = null;
            var _loc_1:* = getSandboxRoot();
            if (_loc_1 == this)
            {
                _loc_2 = new Rectangle(0, 0, width, height);
            }
            else if (_loc_1 == topLevelSystemManager)
            {
                _loc_3 = DisplayObject(topLevelSystemManager);
                _loc_2 = new Rectangle(0, 0, _loc_3.width, _loc_3.height);
            }
            else
            {
                _loc_4 = new InterManagerRequest(InterManagerRequest.SYSTEM_MANAGER_REQUEST, false, false, "screen");
                _loc_1.dispatchEvent(_loc_4);
                _loc_2 = Rectangle(_loc_4.value);
            }
            return _loc_2;
        }// end function

        public function get focusPane() : Sprite
        {
            return _focusPane;
        }// end function

        override public function get mouseX() : Number
        {
            if (_mouseX === undefined)
            {
                return super.mouseX;
            }
            return _mouseX;
        }// end function

        private function mouseDownHandler(event:MouseEvent) : void
        {
            var _loc_3:int = 0;
            var _loc_4:DisplayObject = null;
            var _loc_5:Boolean = false;
            var _loc_6:int = 0;
            var _loc_7:Object = null;
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            var _loc_10:int = 0;
            var _loc_11:IChildList = null;
            var _loc_12:DisplayObject = null;
            var _loc_13:Boolean = false;
            var _loc_14:int = 0;
            idleCounter = 0;
            var _loc_2:* = getSWFBridgeOfDisplayObject(event.target as DisplayObject);
            if (_loc_2 && bridgeToFocusManager[_loc_2] == document.focusManager)
            {
                if (isTopLevelRoot())
                {
                    activateForm(document);
                }
                else
                {
                    dispatchActivatedApplicationEvent();
                }
                return;
            }
            if (numModalWindows == 0)
            {
                if (!isTopLevelRoot() || forms.length > 1)
                {
                    _loc_3 = forms.length;
                    _loc_4 = DisplayObject(event.target);
                    _loc_5 = document.rawChildren.contains(_loc_4);
                    while (_loc_4)
                    {
                        
                        _loc_6 = 0;
                        while (_loc_6 < _loc_3)
                        {
                            
                            _loc_7 = isRemotePopUp(forms[_loc_6]) ? (forms[_loc_6].window) : (forms[_loc_6]);
                            if (_loc_7 == _loc_4)
                            {
                                _loc_8 = 0;
                                if (_loc_4 != form && _loc_4 is IFocusManagerContainer || !isTopLevelRoot() && _loc_4 == form)
                                {
                                    if (isTopLevelRoot())
                                    {
                                        activate(IFocusManagerContainer(_loc_4));
                                    }
                                    if (_loc_4 == document)
                                    {
                                        dispatchActivatedApplicationEvent();
                                    }
                                    else if (_loc_4 is DisplayObject)
                                    {
                                        dispatchActivatedWindowEvent(DisplayObject(_loc_4));
                                    }
                                }
                                if (popUpChildren.contains(_loc_4))
                                {
                                    _loc_11 = popUpChildren;
                                }
                                else
                                {
                                    _loc_11 = this;
                                }
                                _loc_9 = _loc_11.getChildIndex(_loc_4);
                                _loc_10 = _loc_9;
                                _loc_3 = forms.length;
                                _loc_8 = 0;
                                while (_loc_8 < _loc_3)
                                {
                                    
                                    _loc_13 = isRemotePopUp(forms[_loc_8]);
                                    if (_loc_13)
                                    {
                                        if (forms[_loc_8].window is String)
                                        {
                                        }
                                        _loc_12 = forms[_loc_8].window;
                                    }
                                    else
                                    {
                                        _loc_12 = forms[_loc_8];
                                    }
                                    if (_loc_13)
                                    {
                                        _loc_14 = getChildListIndex(_loc_11, _loc_12);
                                        if (_loc_14 > _loc_9)
                                        {
                                            _loc_10 = Math.max(_loc_14, _loc_10);
                                        }
                                    }
                                    else if (_loc_11.contains(_loc_12))
                                    {
                                        if (_loc_11.getChildIndex(_loc_12) > _loc_9)
                                        {
                                            _loc_10 = Math.max(_loc_11.getChildIndex(_loc_12), _loc_10);
                                        }
                                    }
                                    _loc_8++;
                                }
                                if (_loc_10 > _loc_9 && !_loc_5)
                                {
                                    _loc_11.setChildIndex(_loc_4, _loc_10);
                                }
                                return;
                            }
                            _loc_6++;
                        }
                        _loc_4 = _loc_4.parent;
                    }
                }
                else
                {
                    dispatchActivatedApplicationEvent();
                }
            }
            return;
        }// end function

        private function removePopupRequestHandler(event:Event) : void
        {
            var _loc_3:SWFBridgeRequest = null;
            var _loc_2:* = SWFBridgeRequest.marshal(event);
            if (swfBridgeGroup.parentBridge && SecurityUtil.hasMutualTrustBetweenParentAndChild(this))
            {
                _loc_2.requestor = swfBridgeGroup.parentBridge;
                getSandboxRoot().dispatchEvent(_loc_2);
                return;
            }
            if (popUpChildren.contains(_loc_2.data.window))
            {
                popUpChildren.removeChild(_loc_2.data.window);
            }
            else
            {
                removeChild(DisplayObject(_loc_2.data.window));
            }
            if (_loc_2.data.modal)
            {
                numModalWindows--;
            }
            removeRemotePopUp(new RemotePopUp(_loc_2.data.window, _loc_2.requestor));
            if (!isTopLevelRoot() && swfBridgeGroup)
            {
                _loc_3 = new SWFBridgeRequest(SWFBridgeRequest.REMOVE_POP_UP_PLACE_HOLDER_REQUEST, false, false, _loc_2.requestor, {placeHolderId:NameUtil.displayObjectToString(_loc_2.data.window)});
                dispatchEvent(_loc_3);
            }
            return;
        }// end function

        public function addChildBridge(param1:IEventDispatcher, param2:DisplayObject) : void
        {
            var _loc_3:IFocusManager = null;
            var _loc_4:* = param2;
            while (_loc_4)
            {
                
                if (_loc_4 is IFocusManagerContainer)
                {
                    _loc_3 = IFocusManagerContainer(_loc_4).focusManager;
                    break;
                }
                _loc_4 = _loc_4.parent;
            }
            if (!_loc_3)
            {
                return;
            }
            if (!swfBridgeGroup)
            {
                swfBridgeGroup = new SWFBridgeGroup(this);
            }
            swfBridgeGroup.addChildBridge(param1, ISWFBridgeProvider(param2));
            _loc_3.addSWFBridge(param1, param2);
            if (!bridgeToFocusManager)
            {
                bridgeToFocusManager = new Dictionary();
            }
            bridgeToFocusManager[param1] = _loc_3;
            addChildBridgeListeners(param1);
            return;
        }// end function

        public function get screen() : Rectangle
        {
            if (!_screen)
            {
                Stage_resizeHandler();
            }
            if (!isStageRoot)
            {
                Stage_resizeHandler();
            }
            return _screen;
        }// end function

        private function resetMouseCursorRequestHandler(event:Event) : void
        {
            var _loc_3:IEventDispatcher = null;
            if (!isTopLevelRoot() && event is SWFBridgeRequest)
            {
                return;
            }
            var _loc_2:* = SWFBridgeRequest.marshal(event);
            if (!isTopLevelRoot())
            {
                _loc_3 = swfBridgeGroup.parentBridge;
                _loc_2.requestor = _loc_3;
                _loc_3.dispatchEvent(_loc_2);
            }
            else if (eventProxy)
            {
                SystemManagerGlobals.showMouseCursor = true;
            }
            return;
        }// end function

        function set topMostIndex(param1:int) : void
        {
            var _loc_2:* = param1 - _topMostIndex;
            _topMostIndex = param1;
            toolTipIndex = toolTipIndex + _loc_2;
            return;
        }// end function

        function docFrameHandler(event:Event = null) : void
        {
            var _loc_2:TextFieldFactory = null;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:Class = null;
            Singleton.registerClass("mx.managers::IBrowserManager", Class(getDefinitionByName("mx.managers::BrowserManagerImpl")));
            Singleton.registerClass("mx.managers::ICursorManager", Class(getDefinitionByName("mx.managers::CursorManagerImpl")));
            Singleton.registerClass("mx.managers::IHistoryManager", Class(getDefinitionByName("mx.managers::HistoryManagerImpl")));
            Singleton.registerClass("mx.managers::ILayoutManager", Class(getDefinitionByName("mx.managers::LayoutManager")));
            Singleton.registerClass("mx.managers::IPopUpManager", Class(getDefinitionByName("mx.managers::PopUpManagerImpl")));
            Singleton.registerClass("mx.managers::IToolTipManager2", Class(getDefinitionByName("mx.managers::ToolTipManagerImpl")));
            if (Capabilities.playerType == "Desktop")
            {
                Singleton.registerClass("mx.managers::IDragManager", Class(getDefinitionByName("mx.managers::NativeDragManagerImpl")));
                if (Singleton.getClass("mx.managers::IDragManager") == null)
                {
                    Singleton.registerClass("mx.managers::IDragManager", Class(getDefinitionByName("mx.managers::DragManagerImpl")));
                }
            }
            else
            {
                Singleton.registerClass("mx.managers::IDragManager", Class(getDefinitionByName("mx.managers::DragManagerImpl")));
            }
            Singleton.registerClass("mx.core::ITextFieldFactory", Class(getDefinitionByName("mx.core::TextFieldFactory")));
            executeCallbacks();
            doneExecutingInitCallbacks = true;
            var _loc_3:* = info()["mixins"];
            if (_loc_3 && _loc_3.length > 0)
            {
                _loc_4 = _loc_3.length;
                _loc_5 = 0;
                while (_loc_5 < _loc_4)
                {
                    
                    _loc_6 = Class(getDefinitionByName(_loc_3[_loc_5]));
                    var _loc_7:* = _loc_6;
                    _loc_7._loc_6["init"](this);
                    _loc_5++;
                }
            }
            installCompiledResourceBundles();
            initializeTopLevelWindow(null);
            deferredNextFrame();
            return;
        }// end function

        public function get explicitHeight() : Number
        {
            return _explicitHeight;
        }// end function

        public function get preloaderBackgroundSize() : String
        {
            return info()["backgroundSize"];
        }// end function

        public function isTopLevel() : Boolean
        {
            return topLevel;
        }// end function

        override public function get mouseY() : Number
        {
            if (_mouseY === undefined)
            {
                return super.mouseY;
            }
            return _mouseY;
        }// end function

        public function getExplicitOrMeasuredWidth() : Number
        {
            return !isNaN(explicitWidth) ? (explicitWidth) : (measuredWidth);
        }// end function

        public function deactivate(param1:IFocusManagerContainer) : void
        {
            deactivateForm(Object(param1));
            return;
        }// end function

        private function preProcessModalWindowRequest(param1:SWFBridgeRequest, param2:DisplayObject) : Boolean
        {
            var _loc_3:IEventDispatcher = null;
            var _loc_4:ISWFLoader = null;
            var _loc_5:Rectangle = null;
            if (param1.data.skip)
            {
                param1.data.skip = false;
                if (useSWFBridge())
                {
                    _loc_3 = swfBridgeGroup.parentBridge;
                    param1.requestor = _loc_3;
                    _loc_3.dispatchEvent(param1);
                }
                return false;
            }
            if (param2 != this)
            {
                if (param1.type == SWFBridgeRequest.CREATE_MODAL_WINDOW_REQUEST || param1.type == SWFBridgeRequest.SHOW_MODAL_WINDOW_REQUEST)
                {
                    _loc_4 = swfBridgeGroup.getChildBridgeProvider(param1.requestor) as ISWFLoader;
                    if (_loc_4)
                    {
                        _loc_5 = ISWFLoader(_loc_4).getVisibleApplicationRect();
                        param1.data.excludeRect = _loc_5;
                        if (!DisplayObjectContainer(document).contains(DisplayObject(_loc_4)))
                        {
                            param1.data.useExclude = false;
                        }
                    }
                }
                _loc_3 = swfBridgeGroup.parentBridge;
                param1.requestor = _loc_3;
                if (param1.type == SWFBridgeRequest.HIDE_MODAL_WINDOW_REQUEST)
                {
                    param2.dispatchEvent(param1);
                }
                else
                {
                    _loc_3.dispatchEvent(param1);
                }
                return false;
            }
            param1.data.skip = false;
            return true;
        }// end function

        private function resetMouseCursorTracking(event:Event) : void
        {
            var _loc_2:SWFBridgeRequest = null;
            var _loc_3:IEventDispatcher = null;
            if (isTopLevelRoot())
            {
                SystemManagerGlobals.showMouseCursor = true;
            }
            else if (swfBridgeGroup.parentBridge)
            {
                _loc_2 = new SWFBridgeRequest(SWFBridgeRequest.RESET_MOUSE_CURSOR_REQUEST);
                _loc_3 = swfBridgeGroup.parentBridge;
                _loc_2.requestor = _loc_3;
                _loc_3.dispatchEvent(_loc_2);
            }
            return;
        }// end function

        function addParentBridgeListeners() : void
        {
            if (!topLevel && topLevelSystemManager)
            {
                SystemManager(topLevelSystemManager).addParentBridgeListeners();
                return;
            }
            var _loc_1:* = swfBridgeGroup.parentBridge;
            _loc_1.addEventListener(SWFBridgeRequest.SET_ACTUAL_SIZE_REQUEST, setActualSizeRequestHandler);
            _loc_1.addEventListener(SWFBridgeRequest.GET_SIZE_REQUEST, getSizeRequestHandler);
            _loc_1.addEventListener(SWFBridgeRequest.ACTIVATE_POP_UP_REQUEST, activateRequestHandler);
            _loc_1.addEventListener(SWFBridgeRequest.DEACTIVATE_POP_UP_REQUEST, deactivateRequestHandler);
            _loc_1.addEventListener(SWFBridgeRequest.IS_BRIDGE_CHILD_REQUEST, isBridgeChildHandler);
            _loc_1.addEventListener(EventListenerRequest.ADD_EVENT_LISTENER_REQUEST, eventListenerRequestHandler);
            _loc_1.addEventListener(EventListenerRequest.REMOVE_EVENT_LISTENER_REQUEST, eventListenerRequestHandler);
            _loc_1.addEventListener(SWFBridgeRequest.CAN_ACTIVATE_POP_UP_REQUEST, canActivateHandler);
            _loc_1.addEventListener(SWFBridgeEvent.BRIDGE_APPLICATION_UNLOADING, beforeUnloadHandler);
            return;
        }// end function

        public function get swfBridgeGroup() : ISWFBridgeGroup
        {
            if (topLevel)
            {
                return _swfBridgeGroup;
            }
            if (topLevelSystemManager)
            {
                return topLevelSystemManager.swfBridgeGroup;
            }
            return null;
        }// end function

        override public function getChildByName(param1:String) : DisplayObject
        {
            return super.getChildByName(param1);
        }// end function

        public function get measuredWidth() : Number
        {
            return topLevelWindow ? (topLevelWindow.getExplicitOrMeasuredWidth()) : (loaderInfo.width);
        }// end function

        public function removeChildBridge(param1:IEventDispatcher) : void
        {
            var _loc_2:* = IFocusManager(bridgeToFocusManager[param1]);
            _loc_2.removeSWFBridge(param1);
            swfBridgeGroup.removeChildBridge(param1);
            delete bridgeToFocusManager[param1];
            removeChildBridgeListeners(param1);
            return;
        }// end function

        function removeChildBridgeListeners(param1:IEventDispatcher) : void
        {
            if (!topLevel && topLevelSystemManager)
            {
                SystemManager(topLevelSystemManager).removeChildBridgeListeners(param1);
                return;
            }
            param1.removeEventListener(SWFBridgeRequest.ADD_POP_UP_REQUEST, addPopupRequestHandler);
            param1.removeEventListener(SWFBridgeRequest.REMOVE_POP_UP_REQUEST, removePopupRequestHandler);
            param1.removeEventListener(SWFBridgeRequest.ADD_POP_UP_PLACE_HOLDER_REQUEST, addPlaceholderPopupRequestHandler);
            param1.removeEventListener(SWFBridgeRequest.REMOVE_POP_UP_PLACE_HOLDER_REQUEST, removePlaceholderPopupRequestHandler);
            param1.removeEventListener(SWFBridgeEvent.BRIDGE_WINDOW_ACTIVATE, activateFormSandboxEventHandler);
            param1.removeEventListener(SWFBridgeEvent.BRIDGE_WINDOW_DEACTIVATE, deactivateFormSandboxEventHandler);
            param1.removeEventListener(SWFBridgeEvent.BRIDGE_APPLICATION_ACTIVATE, activateApplicationSandboxEventHandler);
            param1.removeEventListener(EventListenerRequest.ADD_EVENT_LISTENER_REQUEST, eventListenerRequestHandler);
            param1.removeEventListener(EventListenerRequest.REMOVE_EVENT_LISTENER_REQUEST, eventListenerRequestHandler);
            param1.removeEventListener(SWFBridgeRequest.CREATE_MODAL_WINDOW_REQUEST, modalWindowRequestHandler);
            param1.removeEventListener(SWFBridgeRequest.SHOW_MODAL_WINDOW_REQUEST, modalWindowRequestHandler);
            param1.removeEventListener(SWFBridgeRequest.HIDE_MODAL_WINDOW_REQUEST, modalWindowRequestHandler);
            param1.removeEventListener(SWFBridgeRequest.GET_VISIBLE_RECT_REQUEST, getVisibleRectRequestHandler);
            param1.removeEventListener(SWFBridgeRequest.HIDE_MOUSE_CURSOR_REQUEST, hideMouseCursorRequestHandler);
            param1.removeEventListener(SWFBridgeRequest.SHOW_MOUSE_CURSOR_REQUEST, showMouseCursorRequestHandler);
            param1.removeEventListener(SWFBridgeRequest.RESET_MOUSE_CURSOR_REQUEST, resetMouseCursorRequestHandler);
            return;
        }// end function

        override public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
        {
            noTopMostIndex++;
            return rawChildren_addChildAt(param1, applicationIndex + param2);
        }// end function

        private function Stage_resizeHandler(event:Event = null) : void
        {
            var m:Number;
            var n:Number;
            var sandboxScreen:Rectangle;
            var event:* = event;
            if (isDispatchingResizeEvent)
            {
                return;
            }
            var w:Number;
            var h:Number;
            try
            {
                m = loaderInfo.width;
                n = loaderInfo.height;
            }
            catch (error:Error)
            {
                return;
            }
            var align:* = StageAlign.TOP_LEFT;
            try
            {
                if (stage)
                {
                    w = stage.stageWidth;
                    h = stage.stageHeight;
                    align = stage.align;
                }
            }
            catch (error:SecurityError)
            {
                sandboxScreen = getSandboxScreen();
                w = sandboxScreen.width;
                h = sandboxScreen.height;
            }
            var x:* = (m - w) / 2;
            var y:* = (n - h) / 2;
            if (align == StageAlign.TOP)
            {
                y;
            }
            else if (align == StageAlign.BOTTOM)
            {
                y = n - h;
            }
            else if (align == StageAlign.LEFT)
            {
                x;
            }
            else if (align == StageAlign.RIGHT)
            {
                x = m - w;
            }
            else if (align == StageAlign.TOP_LEFT || align == "LT")
            {
                y;
                x;
            }
            else if (align == StageAlign.TOP_RIGHT)
            {
                y;
                x = m - w;
            }
            else if (align == StageAlign.BOTTOM_LEFT)
            {
                y = n - h;
                x;
            }
            else if (align == StageAlign.BOTTOM_RIGHT)
            {
                y = n - h;
                x = m - w;
            }
            if (!_screen)
            {
                _screen = new Rectangle();
            }
            _screen.x = x;
            _screen.y = y;
            _screen.width = w;
            _screen.height = h;
            if (isStageRoot)
            {
                _width = stage.stageWidth;
                _height = stage.stageHeight;
            }
            if (event)
            {
                resizeMouseCatcher();
                isDispatchingResizeEvent = true;
                dispatchEvent(event);
                isDispatchingResizeEvent = false;
            }
            return;
        }// end function

        public function get swfBridge() : IEventDispatcher
        {
            if (swfBridgeGroup)
            {
                return swfBridgeGroup.parentBridge;
            }
            return null;
        }// end function

        private function findRemotePopUp(param1:Object, param2:IEventDispatcher) : RemotePopUp
        {
            var _loc_5:RemotePopUp = null;
            var _loc_3:* = forms.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (isRemotePopUp(forms[_loc_4]))
                {
                    _loc_5 = RemotePopUp(forms[_loc_4]);
                    if (_loc_5.window == param1 && _loc_5.bridge == param2)
                    {
                        return _loc_5;
                    }
                }
                _loc_4++;
            }
            return null;
        }// end function

        public function info() : Object
        {
            return {};
        }// end function

        function get toolTipIndex() : int
        {
            return _toolTipIndex;
        }// end function

        public function setActualSize(param1:Number, param2:Number) : void
        {
            if (isStageRoot)
            {
                return;
            }
            _width = param1;
            _height = param2;
            if (mouseCatcher)
            {
                mouseCatcher.width = param1;
                mouseCatcher.height = param2;
            }
            dispatchEvent(new Event(Event.RESIZE));
            return;
        }// end function

        private function removePlaceholderPopupRequestHandler(event:Event) : void
        {
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_2:* = SWFBridgeRequest.marshal(event);
            if (!forwardPlaceholderRequest(_loc_2, false))
            {
                _loc_3 = forms.length;
                _loc_4 = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    if (isRemotePopUp(forms[_loc_4]))
                    {
                        if (forms[_loc_4].window == _loc_2.data.placeHolderId && forms[_loc_4].bridge == _loc_2.requestor)
                        {
                            forms.splice(_loc_4, 1);
                            break;
                        }
                    }
                    _loc_4++;
                }
            }
            return;
        }// end function

        public function set focusPane(param1:Sprite) : void
        {
            if (param1)
            {
                addChild(param1);
                param1.x = 0;
                param1.y = 0;
                param1.scrollRect = null;
                _focusPane = param1;
            }
            else
            {
                removeChild(_focusPane);
                _focusPane = null;
            }
            return;
        }// end function

        function removeParentBridgeListeners() : void
        {
            if (!topLevel && topLevelSystemManager)
            {
                SystemManager(topLevelSystemManager).removeParentBridgeListeners();
                return;
            }
            var _loc_1:* = swfBridgeGroup.parentBridge;
            _loc_1.removeEventListener(SWFBridgeRequest.SET_ACTUAL_SIZE_REQUEST, setActualSizeRequestHandler);
            _loc_1.removeEventListener(SWFBridgeRequest.GET_SIZE_REQUEST, getSizeRequestHandler);
            _loc_1.removeEventListener(SWFBridgeRequest.ACTIVATE_POP_UP_REQUEST, activateRequestHandler);
            _loc_1.removeEventListener(SWFBridgeRequest.DEACTIVATE_POP_UP_REQUEST, deactivateRequestHandler);
            _loc_1.removeEventListener(SWFBridgeRequest.IS_BRIDGE_CHILD_REQUEST, isBridgeChildHandler);
            _loc_1.removeEventListener(EventListenerRequest.ADD_EVENT_LISTENER_REQUEST, eventListenerRequestHandler);
            _loc_1.removeEventListener(EventListenerRequest.REMOVE_EVENT_LISTENER_REQUEST, eventListenerRequestHandler);
            _loc_1.removeEventListener(SWFBridgeRequest.CAN_ACTIVATE_POP_UP_REQUEST, canActivateHandler);
            _loc_1.removeEventListener(SWFBridgeEvent.BRIDGE_APPLICATION_UNLOADING, beforeUnloadHandler);
            return;
        }// end function

        override public function get parent() : DisplayObjectContainer
        {
            try
            {
                return super.parent;
            }
            catch (e:SecurityError)
            {
            }
            return null;
        }// end function

        private function eventListenerRequestHandler(event:Event) : void
        {
            var _loc_2:String = null;
            if (event is EventListenerRequest)
            {
                return;
            }
            var _loc_3:* = EventListenerRequest.marshal(event);
            if (event.type == EventListenerRequest.ADD_EVENT_LISTENER_REQUEST)
            {
                if (!eventProxy)
                {
                    eventProxy = new EventProxy(this);
                }
                _loc_2 = EventUtil.sandboxMouseEventMap[_loc_3.eventType];
                if (_loc_2)
                {
                    if (isTopLevelRoot())
                    {
                        stage.addEventListener(MouseEvent.MOUSE_MOVE, resetMouseCursorTracking, true, EventPriority.CURSOR_MANAGEMENT + 1, true);
                    }
                    else
                    {
                        super.addEventListener(MouseEvent.MOUSE_MOVE, resetMouseCursorTracking, true, EventPriority.CURSOR_MANAGEMENT + 1, true);
                    }
                    addEventListenerToSandboxes(_loc_3.eventType, sandboxMouseListener, true, _loc_3.priority, _loc_3.useWeakReference, event.target as IEventDispatcher);
                    addEventListenerToOtherSystemManagers(_loc_3.eventType, otherSystemManagerMouseListener, true, _loc_3.priority, _loc_3.useWeakReference);
                    if (getSandboxRoot() == this)
                    {
                        if (isTopLevelRoot() && _loc_2 == MouseEvent.MOUSE_UP || _loc_2 == MouseEvent.MOUSE_MOVE)
                        {
                            stage.addEventListener(_loc_2, eventProxy.marshalListener, false, _loc_3.priority, _loc_3.useWeakReference);
                        }
                        super.addEventListener(_loc_2, eventProxy.marshalListener, true, _loc_3.priority, _loc_3.useWeakReference);
                    }
                }
            }
            else if (event.type == EventListenerRequest.REMOVE_EVENT_LISTENER_REQUEST)
            {
                _loc_2 = EventUtil.sandboxMouseEventMap[_loc_3.eventType];
                if (_loc_2)
                {
                    removeEventListenerFromOtherSystemManagers(_loc_3.eventType, otherSystemManagerMouseListener, true);
                    removeEventListenerFromSandboxes(_loc_3.eventType, sandboxMouseListener, true, event.target as IEventDispatcher);
                    if (getSandboxRoot() == this)
                    {
                        if (isTopLevelRoot() && _loc_2 == MouseEvent.MOUSE_UP || _loc_2 == MouseEvent.MOUSE_MOVE)
                        {
                            stage.removeEventListener(_loc_2, eventProxy.marshalListener);
                        }
                        super.removeEventListener(_loc_2, eventProxy.marshalListener, true);
                    }
                }
            }
            return;
        }// end function

        function set applicationIndex(param1:int) : void
        {
            _applicationIndex = param1;
            return;
        }// end function

        private function showMouseCursorRequestHandler(event:Event) : void
        {
            var _loc_3:IEventDispatcher = null;
            if (!isTopLevelRoot() && event is SWFBridgeRequest)
            {
                return;
            }
            var _loc_2:* = SWFBridgeRequest.marshal(event);
            if (!isTopLevelRoot())
            {
                _loc_3 = swfBridgeGroup.parentBridge;
                _loc_2.requestor = _loc_3;
                _loc_3.dispatchEvent(_loc_2);
                Object(event).data = _loc_2.data;
            }
            else if (eventProxy)
            {
                Object(event).data = SystemManagerGlobals.showMouseCursor;
            }
            return;
        }// end function

        public function get childAllowsParent() : Boolean
        {
            try
            {
                return loaderInfo.childAllowsParent;
            }
            catch (error:Error)
            {
            }
            return false;
        }// end function

        public function dispatchEventFromSWFBridges(event:Event, param2:IEventDispatcher = null, param3:Boolean = false, param4:Boolean = false) : void
        {
            var _loc_5:Event = null;
            if (param4)
            {
                dispatchEventToOtherSystemManagers(event);
            }
            if (!swfBridgeGroup)
            {
                return;
            }
            _loc_5 = event.clone();
            if (param3)
            {
                currentSandboxEvent = _loc_5;
            }
            var _loc_6:* = swfBridgeGroup.parentBridge;
            if (swfBridgeGroup.parentBridge && _loc_6 != param2)
            {
                if (_loc_5 is SWFBridgeRequest)
                {
                    SWFBridgeRequest(_loc_5).requestor = _loc_6;
                }
                _loc_6.dispatchEvent(_loc_5);
            }
            var _loc_7:* = swfBridgeGroup.getChildBridges();
            var _loc_8:int = 0;
            while (_loc_8 < _loc_7.length)
            {
                
                if (_loc_7[_loc_8] != param2)
                {
                    _loc_5 = event.clone();
                    if (param3)
                    {
                        currentSandboxEvent = _loc_5;
                    }
                    if (_loc_5 is SWFBridgeRequest)
                    {
                        SWFBridgeRequest(_loc_5).requestor = IEventDispatcher(_loc_7[_loc_8]);
                    }
                    IEventDispatcher(_loc_7[_loc_8]).dispatchEvent(_loc_5);
                }
                _loc_8++;
            }
            currentSandboxEvent = null;
            return;
        }// end function

        private function setActualSizeRequestHandler(event:Event) : void
        {
            var _loc_2:* = Object(event);
            setActualSize(_loc_2.data.width, _loc_2.data.height);
            return;
        }// end function

        private function executeCallbacks() : void
        {
            var _loc_1:Function = null;
            if (!parent && parentAllowsChild)
            {
                return;
            }
            while (initCallbackFunctions.length > 0)
            {
                
                _loc_1 = initCallbackFunctions.shift();
                this._loc_1(this);
            }
            return;
        }// end function

        private function addPlaceholderId(param1:String, param2:String, param3:IEventDispatcher, param4:Object) : void
        {
            if (!param3)
            {
                throw new Error();
            }
            if (!idToPlaceholder)
            {
                idToPlaceholder = [];
            }
            idToPlaceholder[param1] = new PlaceholderData(param2, param3, param4);
            return;
        }// end function

        private function canActivateHandler(event:Event) : void
        {
            var _loc_3:SWFBridgeRequest = null;
            var _loc_6:PlaceholderData = null;
            var _loc_7:RemotePopUp = null;
            var _loc_8:SystemManagerProxy = null;
            var _loc_9:IFocusManagerContainer = null;
            var _loc_10:IEventDispatcher = null;
            var _loc_2:* = Object(event);
            var _loc_4:* = _loc_2.data;
            var _loc_5:String = null;
            if (_loc_2.data is String)
            {
                _loc_6 = idToPlaceholder[_loc_2.data];
                _loc_4 = _loc_6.data;
                _loc_5 = _loc_6.id;
                if (_loc_5 == null)
                {
                    _loc_7 = findRemotePopUp(_loc_4, _loc_6.bridge);
                    if (_loc_7)
                    {
                        _loc_3 = new SWFBridgeRequest(SWFBridgeRequest.CAN_ACTIVATE_POP_UP_REQUEST, false, false, IEventDispatcher(_loc_7.bridge), _loc_7.window);
                        if (_loc_7.bridge)
                        {
                            _loc_7.bridge.dispatchEvent(_loc_3);
                            _loc_2.data = _loc_3.data;
                        }
                        return;
                    }
                }
            }
            if (_loc_4 is SystemManagerProxy)
            {
                _loc_8 = SystemManagerProxy(_loc_4);
                _loc_9 = findFocusManagerContainer(_loc_8);
                if (_loc_8 && _loc_9)
                {
                }
                _loc_2.data = canActivateLocalComponent(_loc_9);
            }
            else if (_loc_4 is IFocusManagerContainer)
            {
                _loc_2.data = canActivateLocalComponent(_loc_4);
            }
            else if (_loc_4 is IEventDispatcher)
            {
                _loc_10 = IEventDispatcher(_loc_4);
                _loc_3 = new SWFBridgeRequest(SWFBridgeRequest.CAN_ACTIVATE_POP_UP_REQUEST, false, false, _loc_10, _loc_5);
                if (_loc_10)
                {
                    _loc_10.dispatchEvent(_loc_3);
                    _loc_2.data = _loc_3.data;
                }
            }
            else
            {
                throw new Error();
            }
            return;
        }// end function

        private function docFrameListener(event:Event) : void
        {
            if (currentFrame == 2)
            {
                removeEventListener(Event.ENTER_FRAME, docFrameListener);
                if (totalFrames > 2)
                {
                    addEventListener(Event.ENTER_FRAME, extraFrameListener);
                }
                docFrameHandler();
            }
            return;
        }// end function

        public function get popUpChildren() : IChildList
        {
            if (!topLevel)
            {
                return _topLevelSystemManager.popUpChildren;
            }
            if (!_popUpChildren)
            {
                _popUpChildren = new SystemChildrenList(this, new QName(mx_internal, "noTopMostIndex"), new QName(mx_internal, "topMostIndex"));
            }
            return _popUpChildren;
        }// end function

        private function addEventListenerToSandboxes(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false, param6:IEventDispatcher = null) : void
        {
            var _loc_10:int = 0;
            var _loc_11:IEventDispatcher = null;
            if (!swfBridgeGroup)
            {
                return;
            }
            var _loc_7:* = new EventListenerRequest(EventListenerRequest.ADD_EVENT_LISTENER_REQUEST, false, false, param1, param3, param4, param5);
            var _loc_8:* = swfBridgeGroup.parentBridge;
            if (swfBridgeGroup.parentBridge && _loc_8 != param6)
            {
                _loc_8.addEventListener(param1, param2, false, param4, param5);
            }
            var _loc_9:* = swfBridgeGroup.getChildBridges();
            while (_loc_10 < _loc_9.length)
            {
                
                _loc_11 = IEventDispatcher(_loc_9[_loc_10]);
                if (_loc_11 != param6)
                {
                    _loc_11.addEventListener(param1, param2, false, param4, param5);
                }
                _loc_10++;
            }
            dispatchEventFromSWFBridges(_loc_7, param6);
            return;
        }// end function

        private function forwardFormEvent(event:SWFBridgeEvent) : Boolean
        {
            var _loc_3:DisplayObject = null;
            if (isTopLevelRoot())
            {
                return false;
            }
            var _loc_2:* = swfBridgeGroup.parentBridge;
            if (_loc_2)
            {
                _loc_3 = getSandboxRoot();
                event.data.notifier = _loc_2;
                if (_loc_3 == this)
                {
                    if (!(event.data.window is String))
                    {
                        event.data.window = NameUtil.displayObjectToString(DisplayObject(event.data.window));
                    }
                    else
                    {
                        event.data.window = NameUtil.displayObjectToString(DisplayObject(this)) + "." + event.data.window;
                    }
                    _loc_2.dispatchEvent(event);
                }
                else
                {
                    if (event.data.window is String)
                    {
                        event.data.window = NameUtil.displayObjectToString(DisplayObject(this)) + "." + event.data.window;
                    }
                    _loc_3.dispatchEvent(event);
                }
            }
            return true;
        }// end function

        public function set explicitHeight(param1:Number) : void
        {
            _explicitHeight = param1;
            return;
        }// end function

        override public function removeChild(param1:DisplayObject) : DisplayObject
        {
            noTopMostIndex--;
            return rawChildren_removeChild(param1);
        }// end function

        function rawChildren_removeChild(param1:DisplayObject) : DisplayObject
        {
            removingChild(param1);
            super.removeChild(param1);
            childRemoved(param1);
            return param1;
        }// end function

        final function get $numChildren() : int
        {
            return super.numChildren;
        }// end function

        public function get toolTipChildren() : IChildList
        {
            if (!topLevel)
            {
                return _topLevelSystemManager.toolTipChildren;
            }
            if (!_toolTipChildren)
            {
                _toolTipChildren = new SystemChildrenList(this, new QName(mx_internal, "topMostIndex"), new QName(mx_internal, "toolTipIndex"));
            }
            return _toolTipChildren;
        }// end function

        public function create(... args) : Object
        {
            var _loc_4:String = null;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_2:* = info()["mainClassName"];
            if (_loc_2 == null)
            {
                _loc_4 = loaderInfo.loaderURL;
                _loc_5 = _loc_4.lastIndexOf(".");
                _loc_6 = _loc_4.lastIndexOf("/");
                _loc_2 = _loc_4.substring(_loc_6 + 1, _loc_5);
            }
            var _loc_3:* = Class(getDefinitionByName(_loc_2));
            return _loc_3 ? (new _loc_3) : (null);
        }// end function

        override public function get stage() : Stage
        {
            var _loc_2:DisplayObject = null;
            if (_stage)
            {
                return _stage;
            }
            var _loc_1:* = super.stage;
            if (_loc_1)
            {
                _stage = _loc_1;
                return _loc_1;
            }
            if (!topLevel && _topLevelSystemManager)
            {
                _stage = _topLevelSystemManager.stage;
                return _stage;
            }
            if (!isStageRoot && topLevel)
            {
                _loc_2 = getTopLevelRoot();
                if (_loc_2)
                {
                    _stage = _loc_2.stage;
                    return _stage;
                }
            }
            return null;
        }// end function

        override public function addChild(param1:DisplayObject) : DisplayObject
        {
            noTopMostIndex++;
            return rawChildren_addChildAt(param1, noTopMostIndex--);
        }// end function

        private function removeRemotePopUp(param1:RemotePopUp) : void
        {
            var _loc_2:* = forms.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (isRemotePopUp(forms[_loc_3]))
                {
                    if (forms[_loc_3].window == param1.window && forms[_loc_3].bridge == param1.bridge)
                    {
                        if (forms[_loc_3] == param1)
                        {
                            deactivateForm(param1);
                        }
                        forms.splice(_loc_3, 1);
                        break;
                    }
                }
                _loc_3++;
            }
            return;
        }// end function

        private function deactivateRemotePopUp(param1:Object) : void
        {
            var _loc_2:* = new SWFBridgeRequest(SWFBridgeRequest.DEACTIVATE_POP_UP_REQUEST, false, false, param1.bridge, param1.window);
            var _loc_3:* = param1.bridge;
            if (_loc_3)
            {
                _loc_3.dispatchEvent(_loc_2);
            }
            return;
        }// end function

        override public function getChildIndex(param1:DisplayObject) : int
        {
            return super.getChildIndex(param1) - applicationIndex;
        }// end function

        function rawChildren_getChildIndex(param1:DisplayObject) : int
        {
            return super.getChildIndex(param1);
        }// end function

        public function activate(param1:IFocusManagerContainer) : void
        {
            activateForm(param1);
            return;
        }// end function

        public function getSandboxRoot() : DisplayObject
        {
            var parent:DisplayObject;
            var lastParent:DisplayObject;
            var loader:Loader;
            var loaderInfo:LoaderInfo;
            var sm:ISystemManager;
            try
            {
                if (sm.topLevelSystemManager)
                {
                    sm = sm.topLevelSystemManager;
                }
                parent = DisplayObject(sm).parent;
                if (parent is Stage)
                {
                    return DisplayObject(sm);
                }
                if (parent && !parent.dispatchEvent(new Event("mx.managers.SystemManager.isBootstrapRoot", false, true)))
                {
                    return this;
                }
                lastParent = parent;
                while (parent)
                {
                    
                    if (parent is Stage)
                    {
                        return lastParent;
                    }
                    if (!parent.dispatchEvent(new Event("mx.managers.SystemManager.isBootstrapRoot", false, true)))
                    {
                        return lastParent;
                    }
                    if (parent is Loader)
                    {
                        loader = Loader(parent);
                        loaderInfo = loader.contentLoaderInfo;
                        if (!loaderInfo.childAllowsParent)
                        {
                            return loaderInfo.content;
                        }
                    }
                    lastParent = parent;
                    parent = parent.parent;
                }
            }
            catch (error:SecurityError)
            {
            }
            return lastParent != null ? (lastParent) : (DisplayObject(sm));
        }// end function

        private function deferredNextFrame() : void
        {
            if (currentFrame + 1 > totalFrames)
            {
                return;
            }
            if (currentFrame + 1 <= framesLoaded)
            {
                nextFrame();
            }
            else
            {
                nextFrameTimer = new Timer(100);
                nextFrameTimer.addEventListener(TimerEvent.TIMER, nextFrameTimerHandler);
                nextFrameTimer.start();
            }
            return;
        }// end function

        function get cursorIndex() : int
        {
            return _cursorIndex;
        }// end function

        function rawChildren_contains(param1:DisplayObject) : Boolean
        {
            return super.contains(param1);
        }// end function

        override public function setChildIndex(param1:DisplayObject, param2:int) : void
        {
            super.setChildIndex(param1, applicationIndex + param2);
            return;
        }// end function

        public function get document() : Object
        {
            return _document;
        }// end function

        private function resizeMouseCatcher() : void
        {
            var g:Graphics;
            var s:Rectangle;
            if (mouseCatcher)
            {
                try
                {
                    g = mouseCatcher.graphics;
                    s = screen;
                    g.clear();
                    g.beginFill(0, 0);
                    g.drawRect(0, 0, s.width, s.height);
                    g.endFill();
                }
                catch (e:SecurityError)
                {
                }
            }
            return;
        }// end function

        private function extraFrameListener(event:Event) : void
        {
            if (lastFrame == currentFrame)
            {
                return;
            }
            lastFrame = currentFrame;
            if (currentFrame + 1 > totalFrames)
            {
                removeEventListener(Event.ENTER_FRAME, extraFrameListener);
            }
            extraFrameHandler();
            return;
        }// end function

        private function addPopupRequestHandler(event:Event) : void
        {
            var _loc_3:Boolean = false;
            var _loc_4:IChildList = null;
            var _loc_6:ISWFBridgeProvider = null;
            var _loc_7:SWFBridgeRequest = null;
            if (event.target != this && event is SWFBridgeRequest)
            {
                return;
            }
            var _loc_2:* = SWFBridgeRequest.marshal(event);
            if (event.target != this)
            {
                _loc_6 = swfBridgeGroup.getChildBridgeProvider(IEventDispatcher(event.target));
                if (!SecurityUtil.hasMutualTrustBetweenParentAndChild(_loc_6))
                {
                    return;
                }
            }
            if (swfBridgeGroup.parentBridge && SecurityUtil.hasMutualTrustBetweenParentAndChild(this))
            {
                _loc_2.requestor = swfBridgeGroup.parentBridge;
                getSandboxRoot().dispatchEvent(_loc_2);
                return;
            }
            if (!_loc_2.data.childList || _loc_2.data.childList == PopUpManagerChildList.PARENT)
            {
                if (_loc_2.data.parent)
                {
                }
                _loc_3 = popUpChildren.contains(_loc_2.data.parent);
            }
            else
            {
                _loc_3 = _loc_2.data.childList == PopUpManagerChildList.POPUP;
            }
            _loc_4 = _loc_3 ? (popUpChildren) : (this);
            _loc_4.addChild(DisplayObject(_loc_2.data.window));
            if (_loc_2.data.modal)
            {
                numModalWindows++;
            }
            var _loc_5:* = new RemotePopUp(_loc_2.data.window, _loc_2.requestor);
            forms.push(_loc_5);
            if (!isTopLevelRoot() && swfBridgeGroup)
            {
                _loc_7 = new SWFBridgeRequest(SWFBridgeRequest.ADD_POP_UP_PLACE_HOLDER_REQUEST, false, false, _loc_2.requestor, {window:_loc_2.data.window});
                _loc_7.data.placeHolderId = NameUtil.displayObjectToString(DisplayObject(_loc_2.data.window));
                dispatchEvent(_loc_7);
            }
            return;
        }// end function

        override public function get height() : Number
        {
            return _height;
        }// end function

        function rawChildren_getChildAt(param1:int) : DisplayObject
        {
            return super.getChildAt(param1);
        }// end function

        private function systemManagerHandler(event:Event) : void
        {
            if (event["name"] == "sameSandbox")
            {
                event["value"] = currentSandboxEvent == event["value"];
                return;
            }
            if (event["name"] == "hasSWFBridges")
            {
                event["value"] = hasSWFBridges();
                return;
            }
            if (event is InterManagerRequest)
            {
                return;
            }
            var _loc_2:* = event["name"];
            switch(_loc_2)
            {
                case "popUpChildren.addChild":
                {
                    popUpChildren.addChild(event["value"]);
                    break;
                }
                case "popUpChildren.removeChild":
                {
                    popUpChildren.removeChild(event["value"]);
                    break;
                }
                case "cursorChildren.addChild":
                {
                    cursorChildren.addChild(event["value"]);
                    break;
                }
                case "cursorChildren.removeChild":
                {
                    cursorChildren.removeChild(event["value"]);
                    break;
                }
                case "toolTipChildren.addChild":
                {
                    toolTipChildren.addChild(event["value"]);
                    break;
                }
                case "toolTipChildren.removeChild":
                {
                    toolTipChildren.removeChild(event["value"]);
                    break;
                }
                case "screen":
                {
                    event["value"] = screen;
                    break;
                }
                case "application":
                {
                    event["value"] = application;
                    break;
                }
                case "isTopLevelRoot":
                {
                    event["value"] = isTopLevelRoot();
                    break;
                }
                case "getVisibleApplicationRect":
                {
                    event["value"] = getVisibleApplicationRect();
                    break;
                }
                case "bringToFront":
                {
                    if (event["value"].topMost)
                    {
                        popUpChildren.setChildIndex(DisplayObject(event["value"].popUp), popUpChildren.numChildren--);
                    }
                    else
                    {
                        setChildIndex(DisplayObject(event["value"].popUp), numChildren--);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function activateRemotePopUp(param1:Object) : void
        {
            var _loc_2:* = new SWFBridgeRequest(SWFBridgeRequest.ACTIVATE_POP_UP_REQUEST, false, false, param1.bridge, param1.window);
            var _loc_3:* = param1.bridge;
            if (_loc_3)
            {
                _loc_3.dispatchEvent(_loc_2);
            }
            return;
        }// end function

        function set noTopMostIndex(param1:int) : void
        {
            var _loc_2:* = param1 - _noTopMostIndex;
            _noTopMostIndex = param1;
            topMostIndex = topMostIndex + _loc_2;
            return;
        }// end function

        override public function getObjectsUnderPoint(param1:Point) : Array
        {
            var _loc_5:DisplayObject = null;
            var _loc_6:Array = null;
            var _loc_2:Array = [];
            var _loc_3:* = topMostIndex;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = super.getChildAt(_loc_4);
                if (_loc_5 is DisplayObjectContainer)
                {
                    _loc_6 = DisplayObjectContainer(_loc_5).getObjectsUnderPoint(param1);
                    if (_loc_6)
                    {
                        _loc_2 = _loc_2.concat(_loc_6);
                    }
                }
                _loc_4++;
            }
            return _loc_2;
        }// end function

        function get topMostIndex() : int
        {
            return _topMostIndex;
        }// end function

        function regenerateStyleCache(param1:Boolean) : void
        {
            var _loc_5:IStyleClient = null;
            var _loc_2:Boolean = false;
            var _loc_3:* = rawChildren.numChildren;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = rawChildren.getChildAt(_loc_4) as IStyleClient;
                if (_loc_5)
                {
                    _loc_5.regenerateStyleCache(param1);
                }
                if (isTopLevelWindow(DisplayObject(_loc_5)))
                {
                    _loc_2 = true;
                }
                _loc_3 = rawChildren.numChildren;
                _loc_4++;
            }
            if (!_loc_2 && topLevelWindow is IStyleClient)
            {
                IStyleClient(topLevelWindow).regenerateStyleCache(param1);
            }
            return;
        }// end function

        public function addFocusManager(param1:IFocusManagerContainer) : void
        {
            forms.push(param1);
            return;
        }// end function

        private function deactivateFormSandboxEventHandler(event:Event) : void
        {
            if (event is SWFBridgeRequest)
            {
                return;
            }
            var _loc_2:* = SWFBridgeEvent.marshal(event);
            if (!forwardFormEvent(_loc_2))
            {
                if (isRemotePopUp(form) && RemotePopUp(form).window == _loc_2.data.window && RemotePopUp(form).bridge == _loc_2.data.notifier)
                {
                    deactivateForm(form);
                }
            }
            return;
        }// end function

        public function set swfBridgeGroup(param1:ISWFBridgeGroup) : void
        {
            if (topLevel)
            {
                _swfBridgeGroup = param1;
            }
            else if (topLevelSystemManager)
            {
                SystemManager(topLevelSystemManager).swfBridgeGroup = param1;
            }
            return;
        }// end function

        function rawChildren_setChildIndex(param1:DisplayObject, param2:int) : void
        {
            super.setChildIndex(param1, param2);
            return;
        }// end function

        private function mouseUpHandler(event:MouseEvent) : void
        {
            idleCounter = 0;
            return;
        }// end function

        function childAdded(param1:DisplayObject) : void
        {
            param1.dispatchEvent(new FlexEvent(FlexEvent.ADD));
            if (param1 is IUIComponent)
            {
                IUIComponent(param1).initialize();
            }
            return;
        }// end function

        public function isFontFaceEmbedded(param1:TextFormat) : Boolean
        {
            var _loc_6:Font = null;
            var _loc_7:String = null;
            var _loc_2:* = param1.font;
            var _loc_3:* = Font.enumerateFonts();
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                _loc_6 = Font(_loc_3[_loc_4]);
                if (_loc_6.fontName == _loc_2)
                {
                    _loc_7 = "regular";
                    if (param1.bold && param1.italic)
                    {
                        _loc_7 = "boldItalic";
                    }
                    else if (param1.bold)
                    {
                        _loc_7 = "bold";
                    }
                    else if (param1.italic)
                    {
                        _loc_7 = "italic";
                    }
                    if (_loc_6.fontStyle == _loc_7)
                    {
                        return true;
                    }
                }
                _loc_4++;
            }
            if (!_loc_2 || !embeddedFontList || !embeddedFontList[_loc_2])
            {
                return false;
            }
            var _loc_5:* = embeddedFontList[_loc_2];
            if (param1.bold && !_loc_5.bold || param1.italic && !_loc_5.italic || !param1.bold && !param1.italic)
            {
            }
            return _loc_5.regular;
        }// end function

        private function forwardPlaceholderRequest(param1:SWFBridgeRequest, param2:Boolean) : Boolean
        {
            if (isTopLevelRoot())
            {
                return false;
            }
            var _loc_3:Object = null;
            var _loc_4:String = null;
            if (param1.data.window)
            {
                _loc_3 = param1.data.window;
                param1.data.window = null;
            }
            else
            {
                _loc_3 = param1.requestor;
                _loc_4 = param1.data.placeHolderId;
                param1.data.placeHolderId = NameUtil.displayObjectToString(this) + "." + param1.data.placeHolderId;
            }
            if (param2)
            {
                addPlaceholderId(param1.data.placeHolderId, _loc_4, param1.requestor, _loc_3);
            }
            else
            {
                removePlaceholderId(param1.data.placeHolderId);
            }
            var _loc_5:* = getSandboxRoot();
            var _loc_6:* = swfBridgeGroup.parentBridge;
            param1.requestor = _loc_6;
            if (_loc_5 == this)
            {
                _loc_6.dispatchEvent(param1);
            }
            else
            {
                _loc_5.dispatchEvent(param1);
            }
            return true;
        }// end function

        public function getTopLevelRoot() : DisplayObject
        {
            var sm:ISystemManager;
            var parent:DisplayObject;
            var lastParent:DisplayObject;
            try
            {
                sm;
                if (sm.topLevelSystemManager)
                {
                    sm = sm.topLevelSystemManager;
                }
                parent = DisplayObject(sm).parent;
                lastParent = parent;
                while (parent)
                {
                    
                    if (parent is Stage)
                    {
                        return lastParent;
                    }
                    lastParent = parent;
                    parent = parent.parent;
                }
            }
            catch (error:SecurityError)
            {
            }
            return null;
        }// end function

        override public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            var newListener:StageEventProxy;
            var actualType:String;
            var type:* = param1;
            var listener:* = param2;
            var useCapture:* = param3;
            if (type == FlexEvent.RENDER || type == FlexEvent.ENTER_FRAME)
            {
                if (type == FlexEvent.RENDER)
                {
                    type = Event.RENDER;
                }
                else
                {
                    type = Event.ENTER_FRAME;
                }
                try
                {
                    if (stage)
                    {
                        stage.removeEventListener(type, listener, useCapture);
                    }
                    super.removeEventListener(type, listener, useCapture);
                }
                catch (error:SecurityError)
                {
                    super.removeEventListener(type, listener, useCapture);
                }
                return;
            }
            if (type == MouseEvent.MOUSE_MOVE || type == MouseEvent.MOUSE_UP || type == MouseEvent.MOUSE_DOWN || type == Event.ACTIVATE || type == Event.DEACTIVATE)
            {
                try
                {
                    if (stage)
                    {
                        newListener = weakReferenceProxies[listener];
                        if (!newListener)
                        {
                            newListener = strongReferenceProxies[listener];
                            if (newListener)
                            {
                                delete strongReferenceProxies[listener];
                            }
                        }
                        if (newListener)
                        {
                            stage.removeEventListener(type, newListener.stageListener, false);
                        }
                    }
                }
                catch (error:SecurityError)
                {
                }
            }
            if (hasSWFBridges() || SystemManagerGlobals.topLevelSystemManagers.length > 1)
            {
                actualType = EventUtil.sandboxMouseEventMap[type];
                if (actualType)
                {
                    if (getSandboxRoot() == this && eventProxy)
                    {
                        super.removeEventListener(actualType, eventProxy.marshalListener, useCapture);
                    }
                    if (!SystemManagerGlobals.changingListenersInOtherSystemManagers)
                    {
                        removeEventListenerFromOtherSystemManagers(type, otherSystemManagerMouseListener, useCapture);
                    }
                    removeEventListenerFromSandboxes(type, sandboxMouseListener, useCapture);
                    super.removeEventListener(type, listener, false);
                    return;
                }
            }
            if (type == FlexEvent.IDLE)
            {
                super.removeEventListener(type, listener, useCapture);
                if (!hasEventListener(FlexEvent.IDLE) && idleTimer)
                {
                    idleTimer.stop();
                    idleTimer = null;
                    removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
                    removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
                }
            }
            else
            {
                super.removeEventListener(type, listener, useCapture);
            }
            return;
        }// end function

        private function extraFrameHandler(event:Event = null) : void
        {
            var _loc_3:Class = null;
            var _loc_2:* = info()["frames"];
            if (_loc_2 && _loc_2[currentLabel])
            {
                _loc_3 = Class(getDefinitionByName(_loc_2[currentLabel]));
                var _loc_4:* = _loc_3;
                _loc_4._loc_3["frame"](this);
            }
            deferredNextFrame();
            return;
        }// end function

        public function isTopLevelRoot() : Boolean
        {
            if (true)
            {
            }
            return isBootstrapRoot;
        }// end function

        public function get application() : IUIComponent
        {
            return IUIComponent(_document);
        }// end function

        override public function removeChildAt(param1:int) : DisplayObject
        {
            noTopMostIndex--;
            return rawChildren_removeChildAt(applicationIndex + param1);
        }// end function

        function rawChildren_removeChildAt(param1:int) : DisplayObject
        {
            var _loc_2:* = super.getChildAt(param1);
            removingChild(_loc_2);
            super.removeChildAt(param1);
            childRemoved(_loc_2);
            return _loc_2;
        }// end function

        private function getSWFBridgeOfDisplayObject(param1:DisplayObject) : IEventDispatcher
        {
            var _loc_2:SWFBridgeRequest = null;
            var _loc_3:Array = null;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:IEventDispatcher = null;
            var _loc_7:ISWFBridgeProvider = null;
            if (swfBridgeGroup)
            {
                _loc_2 = new SWFBridgeRequest(SWFBridgeRequest.IS_BRIDGE_CHILD_REQUEST, false, false, null, param1);
                _loc_3 = swfBridgeGroup.getChildBridges();
                _loc_4 = _loc_3.length;
                _loc_5 = 0;
                while (_loc_5 < _loc_4)
                {
                    
                    _loc_6 = IEventDispatcher(_loc_3[_loc_5]);
                    _loc_7 = swfBridgeGroup.getChildBridgeProvider(_loc_6);
                    if (SecurityUtil.hasMutualTrustBetweenParentAndChild(_loc_7))
                    {
                        _loc_6.dispatchEvent(_loc_2);
                        if (_loc_2.data == true)
                        {
                            return _loc_6;
                        }
                        _loc_2.data = param1;
                    }
                    _loc_5++;
                }
            }
            return null;
        }// end function

        private function deactivateRequestHandler(event:Event) : void
        {
            var _loc_5:PlaceholderData = null;
            var _loc_6:RemotePopUp = null;
            var _loc_7:SystemManagerProxy = null;
            var _loc_8:IFocusManagerContainer = null;
            var _loc_2:* = SWFBridgeRequest.marshal(event);
            var _loc_3:* = _loc_2.data;
            var _loc_4:String = null;
            if (_loc_2.data is String)
            {
                _loc_5 = idToPlaceholder[_loc_2.data];
                _loc_3 = _loc_5.data;
                _loc_4 = _loc_5.id;
                if (_loc_4 == null)
                {
                    _loc_6 = findRemotePopUp(_loc_3, _loc_5.bridge);
                    if (_loc_6)
                    {
                        deactivateRemotePopUp(_loc_6);
                        return;
                    }
                }
            }
            if (_loc_3 is SystemManagerProxy)
            {
                _loc_7 = SystemManagerProxy(_loc_3);
                _loc_8 = findFocusManagerContainer(_loc_7);
                if (_loc_7 && _loc_8)
                {
                    _loc_7.deactivateByProxy(_loc_8);
                }
            }
            else if (_loc_3 is IFocusManagerContainer)
            {
                IFocusManagerContainer(_loc_3).focusManager.deactivate();
            }
            else
            {
                if (_loc_3 is IEventDispatcher)
                {
                    _loc_2.data = _loc_4;
                    _loc_2.requestor = IEventDispatcher(_loc_3);
                    IEventDispatcher(_loc_3).dispatchEvent(_loc_2);
                    return;
                }
                throw new Error();
            }
            return;
        }// end function

        private function installCompiledResourceBundles() : void
        {
            var _loc_1:* = this.info();
            if (!topLevel)
            {
            }
            var _loc_2:* = parent is Loader ? (Loader(parent).contentLoaderInfo.applicationDomain) : (_loc_1["currentDomain"]);
            var _loc_3:* = _loc_1["compiledLocales"];
            var _loc_4:* = _loc_1["compiledResourceBundleNames"];
            var _loc_5:* = ResourceManager.getInstance();
            ResourceManager.getInstance().installCompiledResourceBundles(_loc_2, _loc_3, _loc_4);
            if (!_loc_5.localeChain)
            {
                _loc_5.initializeLocaleChain(_loc_3);
            }
            return;
        }// end function

        private function deactivateForm(param1:Object) : void
        {
            if (form)
            {
                if (form == param1 && forms.length > 1)
                {
                    if (isRemotePopUp(form))
                    {
                        deactivateRemotePopUp(form);
                    }
                    else
                    {
                        form.focusManager.deactivate();
                    }
                    form = findLastActiveForm(param1);
                    if (form)
                    {
                        if (isRemotePopUp(form))
                        {
                            activateRemotePopUp(form);
                        }
                        else
                        {
                            form.focusManager.activate();
                        }
                    }
                }
            }
            return;
        }// end function

        private function unloadHandler(event:Event) : void
        {
            dispatchEvent(event);
            return;
        }// end function

        function removingChild(param1:DisplayObject) : void
        {
            param1.dispatchEvent(new FlexEvent(FlexEvent.REMOVE));
            return;
        }// end function

        function get applicationIndex() : int
        {
            return _applicationIndex;
        }// end function

        function set toolTipIndex(param1:int) : void
        {
            var _loc_2:* = param1 - _toolTipIndex;
            _toolTipIndex = param1;
            cursorIndex = cursorIndex + _loc_2;
            return;
        }// end function

        private function hasSWFBridges() : Boolean
        {
            if (swfBridgeGroup)
            {
                return true;
            }
            return false;
        }// end function

        private function updateLastActiveForm() : void
        {
            var _loc_1:* = forms.length;
            if (_loc_1 < 2)
            {
                return;
            }
            var _loc_2:int = -1;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_1)
            {
                
                if (areFormsEqual(form, forms[_loc_3]))
                {
                    _loc_2 = _loc_3;
                    break;
                }
                _loc_3++;
            }
            if (_loc_2 >= 0)
            {
                forms.splice(_loc_2, 1);
                forms.push(form);
            }
            else
            {
                throw new Error();
            }
            return;
        }// end function

        public function get cursorChildren() : IChildList
        {
            if (!topLevel)
            {
                return _topLevelSystemManager.cursorChildren;
            }
            if (!_cursorChildren)
            {
                _cursorChildren = new SystemChildrenList(this, new QName(mx_internal, "toolTipIndex"), new QName(mx_internal, "cursorIndex"));
            }
            return _cursorChildren;
        }// end function

        private function sandboxMouseListener(event:Event) : void
        {
            if (event is SandboxMouseEvent)
            {
                return;
            }
            var _loc_2:* = SandboxMouseEvent.marshal(event);
            dispatchEventFromSWFBridges(_loc_2, event.target as IEventDispatcher);
            var _loc_3:* = new InterManagerRequest(InterManagerRequest.SYSTEM_MANAGER_REQUEST);
            _loc_3.name = "sameSandbox";
            _loc_3.value = event;
            getSandboxRoot().dispatchEvent(_loc_3);
            if (!_loc_3.value)
            {
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function get preloaderBackgroundImage() : Object
        {
            return info()["backgroundImage"];
        }// end function

        public function set numModalWindows(param1:int) : void
        {
            _numModalWindows = param1;
            return;
        }// end function

        public function get preloaderBackgroundAlpha() : Number
        {
            return info()["backgroundAlpha"];
        }// end function

        function rawChildren_getChildByName(param1:String) : DisplayObject
        {
            return super.getChildByName(param1);
        }// end function

        private function dispatchInvalidateRequest() : void
        {
            var _loc_1:* = swfBridgeGroup.parentBridge;
            var _loc_2:* = new SWFBridgeRequest(SWFBridgeRequest.INVALIDATE_REQUEST, false, false, _loc_1, InvalidateRequestData.SIZE | InvalidateRequestData.DISPLAY_LIST);
            _loc_1.dispatchEvent(_loc_2);
            return;
        }// end function

        public function get preloaderBackgroundColor() : uint
        {
            var _loc_1:* = info()["backgroundColor"];
            if (_loc_1 == undefined)
            {
                return StyleManager.NOT_A_COLOR;
            }
            return StyleManager.getColorName(_loc_1);
        }// end function

        public function getVisibleApplicationRect(param1:Rectangle = null) : Rectangle
        {
            var _loc_2:Rectangle = null;
            var _loc_3:Point = null;
            var _loc_4:IEventDispatcher = null;
            var _loc_5:SWFBridgeRequest = null;
            if (!param1)
            {
                param1 = getBounds(DisplayObject(this));
                _loc_2 = screen;
                _loc_3 = new Point(Math.max(0, param1.x), Math.max(0, param1.y));
                _loc_3 = localToGlobal(_loc_3);
                param1.x = _loc_3.x;
                param1.y = _loc_3.y;
                param1.width = _loc_2.width;
                param1.height = _loc_2.height;
            }
            if (useSWFBridge())
            {
                _loc_4 = swfBridgeGroup.parentBridge;
                _loc_5 = new SWFBridgeRequest(SWFBridgeRequest.GET_VISIBLE_RECT_REQUEST, false, false, _loc_4, param1);
                _loc_4.dispatchEvent(_loc_5);
                param1 = Rectangle(_loc_5.data);
            }
            return param1;
        }// end function

        public function get topLevelSystemManager() : ISystemManager
        {
            if (topLevel)
            {
                return this;
            }
            return _topLevelSystemManager;
        }// end function

        private function appCreationCompleteHandler(event:FlexEvent) : void
        {
            var _loc_2:DisplayObjectContainer = null;
            if (!topLevel && parent)
            {
                _loc_2 = parent.parent;
                while (_loc_2)
                {
                    
                    if (_loc_2 is IInvalidating)
                    {
                        IInvalidating(_loc_2).invalidateSize();
                        IInvalidating(_loc_2).invalidateDisplayList();
                        return;
                    }
                    _loc_2 = _loc_2.parent;
                }
            }
            if (topLevel && useSWFBridge())
            {
                dispatchInvalidateRequest();
            }
            return;
        }// end function

        public function addChildToSandboxRoot(param1:String, param2:DisplayObject) : void
        {
            var _loc_3:InterManagerRequest = null;
            if (getSandboxRoot() == this)
            {
                this[param1].addChild(param2);
            }
            else
            {
                addingChild(param2);
                _loc_3 = new InterManagerRequest(InterManagerRequest.SYSTEM_MANAGER_REQUEST);
                _loc_3.name = param1 + ".addChild";
                _loc_3.value = param2;
                getSandboxRoot().dispatchEvent(_loc_3);
                childAdded(param2);
            }
            return;
        }// end function

        private function dispatchDeactivatedWindowEvent(param1:DisplayObject) : void
        {
            var _loc_3:DisplayObject = null;
            var _loc_4:Boolean = false;
            var _loc_5:SWFBridgeEvent = null;
            var _loc_2:* = swfBridgeGroup ? (swfBridgeGroup.parentBridge) : (null);
            if (_loc_2)
            {
                _loc_3 = getSandboxRoot();
                _loc_4 = _loc_3 != this;
                _loc_5 = new SWFBridgeEvent(SWFBridgeEvent.BRIDGE_WINDOW_DEACTIVATE, false, false, {notifier:_loc_2, window:_loc_4 ? (param1) : (NameUtil.displayObjectToString(param1))});
                if (_loc_4)
                {
                    _loc_3.dispatchEvent(_loc_5);
                }
                else
                {
                    _loc_2.dispatchEvent(_loc_5);
                }
            }
            return;
        }// end function

        private function isBridgeChildHandler(event:Event) : void
        {
            if (event is SWFBridgeRequest)
            {
                return;
            }
            var _loc_2:* = Object(event);
            if (_loc_2.data)
            {
            }
            _loc_2.data = rawChildren.contains(_loc_2.data as DisplayObject);
            return;
        }// end function

        public function get measuredHeight() : Number
        {
            return topLevelWindow ? (topLevelWindow.getExplicitOrMeasuredHeight()) : (loaderInfo.height);
        }// end function

        private function activateRequestHandler(event:Event) : void
        {
            var _loc_5:PlaceholderData = null;
            var _loc_6:RemotePopUp = null;
            var _loc_7:SystemManagerProxy = null;
            var _loc_8:IFocusManagerContainer = null;
            var _loc_2:* = SWFBridgeRequest.marshal(event);
            var _loc_3:* = _loc_2.data;
            var _loc_4:String = null;
            if (_loc_2.data is String)
            {
                _loc_5 = idToPlaceholder[_loc_2.data];
                _loc_3 = _loc_5.data;
                _loc_4 = _loc_5.id;
                if (_loc_4 == null)
                {
                    _loc_6 = findRemotePopUp(_loc_3, _loc_5.bridge);
                    if (_loc_6)
                    {
                        activateRemotePopUp(_loc_6);
                        return;
                    }
                }
            }
            if (_loc_3 is SystemManagerProxy)
            {
                _loc_7 = SystemManagerProxy(_loc_3);
                _loc_8 = findFocusManagerContainer(_loc_7);
                if (_loc_7 && _loc_8)
                {
                    _loc_7.activateByProxy(_loc_8);
                }
            }
            else if (_loc_3 is IFocusManagerContainer)
            {
                IFocusManagerContainer(_loc_3).focusManager.activate();
            }
            else if (_loc_3 is IEventDispatcher)
            {
                _loc_2.data = _loc_4;
                _loc_2.requestor = IEventDispatcher(_loc_3);
                IEventDispatcher(_loc_3).dispatchEvent(_loc_2);
            }
            else
            {
                throw new Error();
            }
            return;
        }// end function

        function rawChildren_addChildAt(param1:DisplayObject, param2:int) : DisplayObject
        {
            addingChild(param1);
            super.addChildAt(param1, param2);
            childAdded(param1);
            return param1;
        }// end function

        function initialize() : void
        {
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_9:EmbeddedFontRegistry = null;
            var _loc_13:Class = null;
            var _loc_14:Object = null;
            var _loc_15:RSLItem = null;
            if (isStageRoot)
            {
                _width = stage.stageWidth;
                _height = stage.stageHeight;
            }
            else
            {
                _width = loaderInfo.width;
                _height = loaderInfo.height;
            }
            preloader = new Preloader();
            preloader.addEventListener(FlexEvent.INIT_PROGRESS, preloader_initProgressHandler);
            preloader.addEventListener(FlexEvent.PRELOADER_DONE, preloader_preloaderDoneHandler);
            if (!_popUpChildren)
            {
                _popUpChildren = new SystemChildrenList(this, new QName(mx_internal, "noTopMostIndex"), new QName(mx_internal, "topMostIndex"));
            }
            _popUpChildren.addChild(preloader);
            var _loc_1:* = info()["rsls"];
            var _loc_2:* = info()["cdRsls"];
            var _loc_3:Boolean = true;
            if (info()["usePreloader"] != undefined)
            {
                _loc_3 = info()["usePreloader"];
            }
            var _loc_4:* = info()["preloader"] as Class;
            if (_loc_3 && !_loc_4)
            {
                _loc_4 = DownloadProgressBar;
            }
            var _loc_5:Array = [];
            if (_loc_2 && _loc_2.length > 0)
            {
                _loc_13 = Class(getDefinitionByName("mx.core::CrossDomainRSLItem"));
                _loc_6 = _loc_2.length;
                _loc_7 = 0;
                while (_loc_7 < _loc_6)
                {
                    
                    _loc_14 = new _loc_13(_loc_2[_loc_7]["rsls"], _loc_2[_loc_7]["policyFiles"], _loc_2[_loc_7]["digests"], _loc_2[_loc_7]["types"], _loc_2[_loc_7]["isSigned"], this.loaderInfo.url);
                    _loc_5.push(_loc_14);
                    _loc_7++;
                }
            }
            if (_loc_1 != null && _loc_1.length > 0)
            {
                _loc_6 = _loc_1.length;
                _loc_7 = 0;
                while (_loc_7 < _loc_6)
                {
                    
                    _loc_15 = new RSLItem(_loc_1[_loc_7].url, this.loaderInfo.url);
                    _loc_5.push(_loc_15);
                    _loc_7++;
                }
            }
            Singleton.registerClass("mx.resources::IResourceManager", Class(getDefinitionByName("mx.resources::ResourceManagerImpl")));
            var _loc_8:* = ResourceManager.getInstance();
            Singleton.registerClass("mx.core::IEmbeddedFontRegistry", Class(getDefinitionByName("mx.core::EmbeddedFontRegistry")));
            Singleton.registerClass("mx.styles::IStyleManager", Class(getDefinitionByName("mx.styles::StyleManagerImpl")));
            Singleton.registerClass("mx.styles::IStyleManager2", Class(getDefinitionByName("mx.styles::StyleManagerImpl")));
            var _loc_10:* = loaderInfo.parameters["localeChain"];
            if (loaderInfo.parameters["localeChain"] != null && _loc_10 != "")
            {
                _loc_8.localeChain = _loc_10.split(",");
            }
            var _loc_11:* = loaderInfo.parameters["resourceModuleURLs"];
            var _loc_12:* = loaderInfo.parameters["resourceModuleURLs"] ? (_loc_11.split(",")) : (null);
            preloader.initialize(_loc_3, _loc_4, preloaderBackgroundColor, preloaderBackgroundAlpha, preloaderBackgroundImage, preloaderBackgroundSize, isStageRoot ? (stage.stageWidth) : (loaderInfo.width), isStageRoot ? (stage.stageHeight) : (loaderInfo.height), null, null, _loc_5, _loc_12);
            return;
        }// end function

        public function useSWFBridge() : Boolean
        {
            if (isStageRoot)
            {
                return false;
            }
            if (!topLevel && topLevelSystemManager)
            {
                return topLevelSystemManager.useSWFBridge();
            }
            if (topLevel && getSandboxRoot() != this)
            {
                return true;
            }
            if (getSandboxRoot() == this)
            {
                try
                {
                    if (parentAllowsChild && childAllowsParent)
                    {
                        try
                        {
                            if (!parent.dispatchEvent(new Event("mx.managers.SystemManager.isStageRoot", false, true)))
                            {
                                return true;
                            }
                        }
                        catch (e:Error)
                        {
                        }
                    }
                    else
                    {
                        return true;
                    }
                }
                catch (e1:Error)
                {
                    return false;
                }
            }
            return false;
        }// end function

        function childRemoved(param1:DisplayObject) : void
        {
            if (param1 is IUIComponent)
            {
                IUIComponent(param1).parentChanged(null);
            }
            return;
        }// end function

        final function $removeChildAt(param1:int) : DisplayObject
        {
            return super.removeChildAt(param1);
        }// end function

        private function canActivatePopUp(param1:Object) : Boolean
        {
            var _loc_2:RemotePopUp = null;
            var _loc_3:SWFBridgeRequest = null;
            if (isRemotePopUp(param1))
            {
                _loc_2 = RemotePopUp(param1);
                _loc_3 = new SWFBridgeRequest(SWFBridgeRequest.CAN_ACTIVATE_POP_UP_REQUEST, false, false, null, _loc_2.window);
                IEventDispatcher(_loc_2.bridge).dispatchEvent(_loc_3);
                return _loc_3.data;
            }
            if (canActivateLocalComponent(param1))
            {
                return true;
            }
            return false;
        }// end function

        function get noTopMostIndex() : int
        {
            return _noTopMostIndex;
        }// end function

        override public function get numChildren() : int
        {
            return noTopMostIndex - applicationIndex;
        }// end function

        private function canActivateLocalComponent(param1:Object) : Boolean
        {
            if (param1 is Sprite && param1 is IUIComponent && Sprite(param1).visible && IUIComponent(param1).enabled)
            {
                return true;
            }
            return false;
        }// end function

        private function preloader_preloaderDoneHandler(event:Event) : void
        {
            var _loc_2:* = topLevelWindow;
            preloader.removeEventListener(FlexEvent.PRELOADER_DONE, preloader_preloaderDoneHandler);
            _popUpChildren.removeChild(preloader);
            preloader = null;
            mouseCatcher = new FlexSprite();
            mouseCatcher.name = "mouseCatcher";
            noTopMostIndex++;
            super.addChildAt(mouseCatcher, 0);
            resizeMouseCatcher();
            if (!topLevel)
            {
                mouseCatcher.visible = false;
                mask = mouseCatcher;
            }
            noTopMostIndex++;
            super.addChildAt(DisplayObject(_loc_2), 1);
            _loc_2.dispatchEvent(new FlexEvent(FlexEvent.APPLICATION_COMPLETE));
            dispatchEvent(new FlexEvent(FlexEvent.APPLICATION_COMPLETE));
            return;
        }// end function

        private function initializeTopLevelWindow(event:Event) : void
        {
            var _loc_2:IUIComponent = null;
            var _loc_3:DisplayObjectContainer = null;
            var _loc_4:ISystemManager = null;
            var _loc_5:DisplayObject = null;
            initialized = true;
            if (!parent && parentAllowsChild)
            {
                return;
            }
            if (!topLevel)
            {
                _loc_3 = parent.parent;
                if (!_loc_3)
                {
                    return;
                }
                while (_loc_3)
                {
                    
                    if (_loc_3 is IUIComponent)
                    {
                        _loc_4 = IUIComponent(_loc_3).systemManager;
                        if (_loc_4 && !_loc_4.isTopLevel())
                        {
                            _loc_4 = _loc_4.topLevelSystemManager;
                        }
                        _topLevelSystemManager = _loc_4;
                        break;
                    }
                    _loc_3 = _loc_3.parent;
                }
            }
            if (isTopLevelRoot() || getSandboxRoot() == this)
            {
                addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, true);
            }
            if (isTopLevelRoot() && stage)
            {
                stage.addEventListener(Event.RESIZE, Stage_resizeHandler, false, 0, true);
            }
            else if (topLevel && stage)
            {
                _loc_5 = getSandboxRoot();
                if (_loc_5 != this)
                {
                    _loc_5.addEventListener(Event.RESIZE, Stage_resizeHandler, false, 0, true);
                }
            }
            var _loc_6:* = IUIComponent(create());
            topLevelWindow = IUIComponent(create());
            var _loc_6:* = _loc_6;
            _loc_2 = _loc_6;
            document = _loc_6;
            if (document)
            {
                IEventDispatcher(_loc_2).addEventListener(FlexEvent.CREATION_COMPLETE, appCreationCompleteHandler);
                if (!LoaderConfig._url)
                {
                    LoaderConfig._url = loaderInfo.url;
                    LoaderConfig._parameters = loaderInfo.parameters;
                }
                if (isStageRoot && stage)
                {
                    _width = stage.stageWidth;
                    _height = stage.stageHeight;
                    IFlexDisplayObject(_loc_2).setActualSize(_width, _height);
                }
                else
                {
                    IFlexDisplayObject(_loc_2).setActualSize(loaderInfo.width, loaderInfo.height);
                }
                if (preloader)
                {
                    preloader.registerApplication(_loc_2);
                }
                addingChild(DisplayObject(_loc_2));
                childAdded(DisplayObject(_loc_2));
            }
            else
            {
                document = this;
            }
            return;
        }// end function

        final function $addChildAt(param1:DisplayObject, param2:int) : DisplayObject
        {
            return super.addChildAt(param1, param2);
        }// end function

        function dispatchActivatedWindowEvent(param1:DisplayObject) : void
        {
            var _loc_3:DisplayObject = null;
            var _loc_4:Boolean = false;
            var _loc_5:SWFBridgeEvent = null;
            var _loc_2:* = swfBridgeGroup ? (swfBridgeGroup.parentBridge) : (null);
            if (_loc_2)
            {
                _loc_3 = getSandboxRoot();
                _loc_4 = _loc_3 != this;
                _loc_5 = new SWFBridgeEvent(SWFBridgeEvent.BRIDGE_WINDOW_ACTIVATE, false, false, {notifier:_loc_2, window:_loc_4 ? (param1) : (NameUtil.displayObjectToString(param1))});
                if (_loc_4)
                {
                    _loc_3.dispatchEvent(_loc_5);
                }
                else
                {
                    _loc_2.dispatchEvent(_loc_5);
                }
            }
            return;
        }// end function

        private function nextFrameTimerHandler(event:TimerEvent) : void
        {
            if (currentFrame + 1 <= framesLoaded)
            {
                nextFrame();
                nextFrameTimer.removeEventListener(TimerEvent.TIMER, nextFrameTimerHandler);
                nextFrameTimer.reset();
            }
            return;
        }// end function

        public function get numModalWindows() : int
        {
            return _numModalWindows;
        }// end function

        private function areFormsEqual(param1:Object, param2:Object) : Boolean
        {
            if (param1 == param2)
            {
                return true;
            }
            if (param1 is RemotePopUp && param2 is RemotePopUp)
            {
                return areRemotePopUpsEqual(param1, param2);
            }
            return false;
        }// end function

        public function isTopLevelWindow(param1:DisplayObject) : Boolean
        {
            if (param1 is IUIComponent)
            {
            }
            return IUIComponent(param1) == topLevelWindow;
        }// end function

        private function removePlaceholderId(param1:String) : void
        {
            delete idToPlaceholder[param1];
            return;
        }// end function

        override public function get width() : Number
        {
            return _width;
        }// end function

        private function dispatchActivatedApplicationEvent() : void
        {
            var _loc_2:SWFBridgeEvent = null;
            var _loc_1:* = swfBridgeGroup ? (swfBridgeGroup.parentBridge) : (null);
            if (_loc_1)
            {
                _loc_2 = new SWFBridgeEvent(SWFBridgeEvent.BRIDGE_APPLICATION_ACTIVATE, false, false);
                _loc_1.dispatchEvent(_loc_2);
            }
            return;
        }// end function

        private function otherSystemManagerMouseListener(event:SandboxMouseEvent) : void
        {
            if (dispatchingToSystemManagers)
            {
                return;
            }
            dispatchEventFromSWFBridges(event);
            var _loc_2:* = new InterManagerRequest(InterManagerRequest.SYSTEM_MANAGER_REQUEST);
            _loc_2.name = "sameSandbox";
            _loc_2.value = event;
            getSandboxRoot().dispatchEvent(_loc_2);
            if (!_loc_2.value)
            {
                dispatchEvent(event);
            }
            return;
        }// end function

        private function hideMouseCursorRequestHandler(event:Event) : void
        {
            var _loc_3:IEventDispatcher = null;
            if (!isTopLevelRoot() && event is SWFBridgeRequest)
            {
                return;
            }
            var _loc_2:* = SWFBridgeRequest.marshal(event);
            if (!isTopLevelRoot())
            {
                _loc_3 = swfBridgeGroup.parentBridge;
                _loc_2.requestor = _loc_3;
                _loc_3.dispatchEvent(_loc_2);
            }
            else if (eventProxy)
            {
                SystemManagerGlobals.showMouseCursor = false;
            }
            return;
        }// end function

        private function getTopLevelSystemManager(param1:DisplayObject) : ISystemManager
        {
            var _loc_3:ISystemManager = null;
            var _loc_2:* = DisplayObjectContainer(param1.root);
            if (!_loc_2 || _loc_2 is Stage && param1 is IUIComponent)
            {
                _loc_2 = DisplayObjectContainer(IUIComponent(param1).systemManager);
            }
            if (_loc_2 is ISystemManager)
            {
                _loc_3 = ISystemManager(_loc_2);
                if (!_loc_3.isTopLevel())
                {
                    _loc_3 = _loc_3.topLevelSystemManager;
                }
            }
            return _loc_3;
        }// end function

        public function isDisplayObjectInABridgedApplication(param1:DisplayObject) : Boolean
        {
            return getSWFBridgeOfDisplayObject(param1) != null;
        }// end function

        public function move(param1:Number, param2:Number) : void
        {
            return;
        }// end function

        public function set explicitWidth(param1:Number) : void
        {
            _explicitWidth = param1;
            return;
        }// end function

        public function get parentAllowsChild() : Boolean
        {
            try
            {
                return loaderInfo.parentAllowsChild;
            }
            catch (error:Error)
            {
            }
            return false;
        }// end function

        private function preloader_initProgressHandler(event:Event) : void
        {
            preloader.removeEventListener(FlexEvent.INIT_PROGRESS, preloader_initProgressHandler);
            deferredNextFrame();
            return;
        }// end function

        public function get explicitWidth() : Number
        {
            return _explicitWidth;
        }// end function

        private function activateFormSandboxEventHandler(event:Event) : void
        {
            var _loc_2:* = SWFBridgeEvent.marshal(event);
            if (!forwardFormEvent(_loc_2))
            {
                activateForm(new RemotePopUp(_loc_2.data.window, _loc_2.data.notifier));
            }
            return;
        }// end function

        function rawChildren_addChild(param1:DisplayObject) : DisplayObject
        {
            addingChild(param1);
            super.addChild(param1);
            childAdded(param1);
            return param1;
        }// end function

        public static function getSWFRoot(param1:Object) : DisplayObject
        {
            var p:*;
            var sm:ISystemManager;
            var domain:ApplicationDomain;
            var cls:Class;
            var object:* = param1;
            var className:* = getQualifiedClassName(object);
            var _loc_3:int = 0;
            var _loc_4:* = allSystemManagers;
            do
            {
                
                p = _loc_4[_loc_3];
                sm = p as ISystemManager;
                domain = sm.loaderInfo.applicationDomain;
                try
                {
                    cls = Class(domain.getDefinition(className));
                    if (object is cls)
                    {
                        return sm as DisplayObject;
                    }
                }
                catch (e:Error)
                {
                }
            }while (_loc_4 in _loc_3)
            return null;
        }// end function

        private static function areRemotePopUpsEqual(param1:Object, param2:Object) : Boolean
        {
            if (!(param1 is RemotePopUp))
            {
                return false;
            }
            if (!(param2 is RemotePopUp))
            {
                return false;
            }
            var _loc_3:* = RemotePopUp(param1);
            var _loc_4:* = RemotePopUp(param2);
            if (_loc_3.window == _loc_4.window && _loc_3.bridge && _loc_4.bridge)
            {
                return true;
            }
            return false;
        }// end function

        private static function getChildListIndex(param1:IChildList, param2:Object) : int
        {
            var childList:* = param1;
            var f:* = param2;
            var index:int;
            try
            {
                index = childList.getChildIndex(DisplayObject(f));
            }
            catch (e:ArgumentError)
            {
            }
            return index;
        }// end function

        static function registerInitCallback(param1:Function) : void
        {
            if (!allSystemManagers || !lastSystemManager)
            {
                return;
            }
            var _loc_2:* = lastSystemManager;
            if (_loc_2.doneExecutingInitCallbacks)
            {
                this.param1(_loc_2);
            }
            else
            {
                _loc_2.initCallbackFunctions.push(param1);
            }
            return;
        }// end function

        private static function isRemotePopUp(param1:Object) : Boolean
        {
            return !(param1 is IFocusManagerContainer);
        }// end function

    }
}
