package mx.core
{
    import flash.desktop.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.geom.*;
    import flash.system.*;
    import mx.controls.*;
    import mx.core.windowClasses.*;
    import mx.events.*;
    import mx.managers.*;
    import mx.styles.*;

    public class WindowedApplication extends Application implements IWindow
    {
        private var showGripperChanged:Boolean = true;
        private var shouldShowTitleBar:Boolean;
        private var invokesPending:Boolean = true;
        private var _maxWidth:Number = 0;
        var titleBarBackground:IFlexDisplayObject;
        private var _maxHeight:Number = 0;
        private var windowBoundsChanged:Boolean = true;
        private var _menu:FlexNativeMenu;
        private var boundsChanged:Boolean = false;
        private var _showStatusBar:Boolean = true;
        private var minHeightChanged:Boolean = false;
        private var menuChanged:Boolean = false;
        private var statusChanged:Boolean = false;
        private var titleIconChanged:Boolean = false;
        private var prevX:Number;
        private var prevY:Number;
        private var maxHeightChanged:Boolean = false;
        private var gripper:Button;
        private var _showTitleBar:Boolean = true;
        private var _minHeight:Number = 0;
        private var lastDisplayState:String = "normal";
        private var _dockIconMenu:FlexNativeMenu;
        private var _nativeWindow:NativeWindow;
        private var _nativeWindowVisible:Boolean = true;
        var statusBarBackground:IFlexDisplayObject;
        private var showTitleBarChanged:Boolean = true;
        private var toMax:Boolean = false;
        private var _alwaysInFront:Boolean = false;
        private var gripperHit:Sprite;
        private var _showGripper:Boolean = true;
        private var oldX:Number;
        private var oldY:Number;
        private var initialInvokes:Array;
        private var _status:String = "";
        private var ucCount:Number = 0;
        private var _gripperPadding:Number = 3;
        private var _systemTrayIconMenu:FlexNativeMenu;
        private var _statusBar:UIComponent;
        private var titleChanged:Boolean = false;
        private var _title:String = "";
        private var _statusBarFactory:IFactory;
        private var statusBarFactoryChanged:Boolean = false;
        private var _titleIcon:Class;
        private var appViewMetrics:EdgeMetrics;
        private var minWidthChanged:Boolean = false;
        private var maxWidthChanged:Boolean = false;
        private var activateOnOpen:Boolean = true;
        private var _titleBarFactory:IFactory;
        private var titleBarFactoryChanged:Boolean = false;
        private var showStatusBarChanged:Boolean = true;
        private var _bounds:Rectangle;
        private var _minWidth:Number = 0;
        private var _titleBar:UIComponent;
        private static var _titleBarStyleFilters:Object = {buttonAlignment:"buttonAlignment", buttonPadding:"buttonPadding", closeButtonSkin:"closeButtonSkin", cornerRadius:"cornerRadius", headerHeight:"headerHeight", maximizeButtonSkin:"maximizeButtonSkin", minimizeButtonSkin:"minimizeButtonSkin", restoreButtonSkin:"restoreButtonSkin", titleAlignment:"titleAlignment", titleBarBackgroundSkin:"titleBarBackgroundSkin", titleBarButtonPadding:"titleBarButtonPadding", titleBarColors:"titleBarColors", titleTextStyleName:"titleTextStyleName"};
        private static const HEADER_PADDING:Number = 4;
        private static var _statusBarStyleFilters:Object = {statusBarBackgroundColor:"statusBarBackgroundColor", statusBarBackgroundSkin:"statusBarBackgroundSkin", statusTextStyleName:"statusTextStyleName"};
        private static const MOUSE_SLACK:Number = 5;
        private static var _forceLinkNDMI:NativeDragManagerImpl;
        static const VERSION:String = "3.2.0.3958";

        public function WindowedApplication()
        {
            _bounds = new Rectangle(0, 0, 0, 0);
            _statusBarFactory = new ClassFactory(StatusBar);
            _titleBarFactory = new ClassFactory(TitleBar);
            addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
            addEventListener(FlexEvent.PREINITIALIZE, preinitializeHandler);
            addEventListener(FlexEvent.UPDATE_COMPLETE, updateComplete_handler);
            addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
            var _loc_1:* = NativeApplication.nativeApplication;
            _loc_1.addEventListener(Event.ACTIVATE, nativeApplication_activateHandler);
            _loc_1.addEventListener(Event.DEACTIVATE, nativeApplication_deactivateHandler);
            _loc_1.addEventListener(Event.NETWORK_CHANGE, nativeApplication_networkChangeHandler);
            _loc_1.addEventListener(InvokeEvent.INVOKE, nativeApplication_invokeHandler);
            initialInvokes = new Array();
            return;
        }// end function

        public function orderInBackOf(param1:IWindow) : Boolean
        {
            if (nativeWindow && !nativeWindow.closed)
            {
                return nativeWindow.orderInBackOf(param1.nativeWindow);
            }
            return false;
        }// end function

        public function set statusBarFactory(param1:IFactory) : void
        {
            _statusBarFactory = param1;
            statusBarFactoryChanged = true;
            invalidateProperties();
            dispatchEvent(new Event("statusBarFactoryChanged"));
            return;
        }// end function

        private function enterFrameHandler(event:Event) : void
        {
            removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
            if (stage.nativeWindow.closed)
            {
                return;
            }
            stage.nativeWindow.visible = _nativeWindowVisible;
            dispatchEvent(new AIREvent(AIREvent.WINDOW_COMPLETE));
            dispatchPendingInvokes();
            if (_nativeWindowVisible && activateOnOpen)
            {
                stage.nativeWindow.activate();
            }
            stage.nativeWindow.alwaysInFront = _alwaysInFront;
            return;
        }// end function

        override public function get minHeight() : Number
        {
            if (nativeWindow && !minHeightChanged)
            {
                return nativeWindow.minSize.y - chromeHeight();
            }
            return _minHeight;
        }// end function

        private function window_closeHandler(event:Event) : void
        {
            dispatchEvent(new Event("close"));
            return;
        }// end function

        private function nativeApplication_deactivateHandler(event:Event) : void
        {
            dispatchEvent(new AIREvent(AIREvent.APPLICATION_DEACTIVATE));
            return;
        }// end function

        override public function set minHeight(param1:Number) : void
        {
            _minHeight = param1;
            minHeightChanged = true;
            invalidateProperties();
            return;
        }// end function

        private function chromeHeight() : Number
        {
            return nativeWindow.height - systemManager.stage.stageHeight;
        }// end function

        public function get showStatusBar() : Boolean
        {
            return _showStatusBar;
        }// end function

        override public function set height(param1:Number) : void
        {
            if (param1 < minHeight)
            {
                param1 = minHeight;
            }
            else if (param1 > maxHeight)
            {
                param1 = maxHeight;
            }
            _bounds.height = param1;
            boundsChanged = true;
            invalidateProperties();
            invalidateSize();
            invalidateViewMetricsAndPadding();
            return;
        }// end function

        private function mouseMoveHandler(event:MouseEvent) : void
        {
            stage.nativeWindow.x = stage.nativeWindow.x + (event.stageX - prevX);
            stage.nativeWindow.y = stage.nativeWindow.y + (event.stageY - prevY);
            return;
        }// end function

        public function get title() : String
        {
            return _title;
        }// end function

        protected function mouseDownHandler(event:MouseEvent) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            if (systemManager.stage.nativeWindow.systemChrome != "none")
            {
                return;
            }
            if (event.target == gripperHit)
            {
                startResize(NativeWindowResize.BOTTOM_RIGHT);
                event.stopPropagation();
            }
            else
            {
                _loc_2 = Number(getStyle("borderThickness")) + 6;
                _loc_3 = 12;
                if (event.stageY < Number(getStyle("borderThickness")))
                {
                    if (event.stageX < _loc_3)
                    {
                        startResize(NativeWindowResize.TOP_LEFT);
                    }
                    else if (event.stageX > width - _loc_3)
                    {
                        startResize(NativeWindowResize.TOP_RIGHT);
                    }
                    else
                    {
                        startResize(NativeWindowResize.TOP);
                    }
                }
                else if (event.stageY > height - _loc_2)
                {
                    if (event.stageX < _loc_3)
                    {
                        startResize(NativeWindowResize.BOTTOM_LEFT);
                    }
                    else if (event.stageX > width - _loc_3)
                    {
                        startResize(NativeWindowResize.BOTTOM_RIGHT);
                    }
                    else
                    {
                        startResize(NativeWindowResize.BOTTOM);
                    }
                }
                else if (event.stageX < _loc_2)
                {
                    if (event.stageY < _loc_3)
                    {
                        startResize(NativeWindowResize.TOP_LEFT);
                    }
                    else if (event.stageY > height - _loc_3)
                    {
                        startResize(NativeWindowResize.BOTTOM_LEFT);
                    }
                    else
                    {
                        startResize(NativeWindowResize.LEFT);
                    }
                    event.stopPropagation();
                }
                else if (event.stageX > width - _loc_2)
                {
                    if (event.stageY < _loc_3)
                    {
                        startResize(NativeWindowResize.TOP_RIGHT);
                    }
                    else if (event.stageY > height - _loc_3)
                    {
                        startResize(NativeWindowResize.BOTTOM_RIGHT);
                    }
                    else
                    {
                        startResize(NativeWindowResize.RIGHT);
                    }
                }
            }
            return;
        }// end function

        override public function get viewMetrics() : EdgeMetrics
        {
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            var _loc_1:* = super.viewMetrics;
            var _loc_2:* = new EdgeMetrics(_loc_1.left, _loc_1.top, _loc_1.right, _loc_1.bottom);
            if (showTitleBar)
            {
                _loc_3 = getHeaderHeight();
                if (!isNaN(_loc_3))
                {
                    _loc_2.top = _loc_2.top + _loc_3;
                }
            }
            if (_showStatusBar)
            {
                _loc_4 = getStatusBarHeight();
                if (!isNaN(_loc_4))
                {
                    _loc_2.bottom = _loc_2.bottom + _loc_4;
                }
            }
            return _loc_2;
        }// end function

        private function window_moveHandler(event:NativeWindowBoundsEvent) : void
        {
            dispatchEvent(new FlexNativeWindowBoundsEvent(FlexNativeWindowBoundsEvent.WINDOW_MOVE, event.bubbles, event.cancelable, event.beforeBounds, event.afterBounds));
            return;
        }// end function

        public function get applicationID() : String
        {
            return nativeApplication.applicationID;
        }// end function

        protected function get statusBarStyleFilters() : Object
        {
            return _statusBarStyleFilters;
        }// end function

        override public function get visible() : Boolean
        {
            if (nativeWindow && nativeWindow.closed)
            {
                return false;
            }
            if (nativeWindow)
            {
                return nativeWindow.visible;
            }
            return _nativeWindowVisible;
        }// end function

        public function get minimizable() : Boolean
        {
            if (!nativeWindow.closed)
            {
                return nativeWindow.minimizable;
            }
            return false;
        }// end function

        private function dispatchPendingInvokes() : void
        {
            var _loc_1:InvokeEvent = null;
            invokesPending = false;
            for each (_loc_1 in initialInvokes)
            {
                
                dispatchEvent(_loc_1);
            }
            initialInvokes = null;
            return;
        }// end function

        public function restore() : void
        {
            var _loc_1:NativeWindowDisplayStateEvent = null;
            if (!nativeWindow.closed)
            {
                if (stage.nativeWindow.displayState == NativeWindowDisplayState.MAXIMIZED)
                {
                    _loc_1 = new NativeWindowDisplayStateEvent(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGING, false, true, NativeWindowDisplayState.MAXIMIZED, NativeWindowDisplayState.NORMAL);
                    stage.nativeWindow.dispatchEvent(_loc_1);
                    if (!_loc_1.isDefaultPrevented())
                    {
                        nativeWindow.restore();
                    }
                }
                else if (stage.nativeWindow.displayState == NativeWindowDisplayState.MINIMIZED)
                {
                    _loc_1 = new NativeWindowDisplayStateEvent(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGING, false, true, NativeWindowDisplayState.MINIMIZED, NativeWindowDisplayState.NORMAL);
                    stage.nativeWindow.dispatchEvent(_loc_1);
                    if (!_loc_1.isDefaultPrevented())
                    {
                        nativeWindow.restore();
                    }
                }
            }
            return;
        }// end function

        public function set showStatusBar(param1:Boolean) : void
        {
            if (_showStatusBar == param1)
            {
                return;
            }
            _showStatusBar = param1;
            showStatusBarChanged = true;
            invalidateProperties();
            invalidateDisplayList();
            return;
        }// end function

        private function getHeaderHeight() : Number
        {
            if (!nativeWindow.closed)
            {
                if (getStyle("headerHeight") != null)
                {
                    return getStyle("headerHeight");
                }
                if (systemManager.stage.nativeWindow.systemChrome != "none")
                {
                    return 0;
                }
                if (titleBar)
                {
                    return titleBar.getExplicitOrMeasuredHeight();
                }
            }
            return 0;
        }// end function

        override public function get minWidth() : Number
        {
            if (nativeWindow && !minWidthChanged)
            {
                return nativeWindow.minSize.x - chromeWidth();
            }
            return _minWidth;
        }// end function

        public function get systemTrayIconMenu() : FlexNativeMenu
        {
            return _systemTrayIconMenu;
        }// end function

        public function minimize() : void
        {
            var _loc_1:NativeWindowDisplayStateEvent = null;
            if (!nativeWindow.closed)
            {
                _loc_1 = new NativeWindowDisplayStateEvent(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGING, false, true, nativeWindow.displayState, NativeWindowDisplayState.MINIMIZED);
                stage.nativeWindow.dispatchEvent(_loc_1);
                if (!_loc_1.isDefaultPrevented())
                {
                    stage.nativeWindow.minimize();
                }
            }
            return;
        }// end function

        public function get titleBar() : UIComponent
        {
            return _titleBar;
        }// end function

        public function get resizable() : Boolean
        {
            if (nativeWindow.closed)
            {
                return false;
            }
            return nativeWindow.resizable;
        }// end function

        private function nativeApplication_invokeHandler(event:InvokeEvent) : void
        {
            if (invokesPending)
            {
                initialInvokes.push(event);
            }
            else
            {
                dispatchEvent(event);
            }
            return;
        }// end function

        public function set title(param1:String) : void
        {
            _title = param1;
            titleChanged = true;
            invalidateProperties();
            invalidateSize();
            invalidateViewMetricsAndPadding();
            invalidateDisplayList();
            dispatchEvent(new Event("titleChanged"));
            return;
        }// end function

        protected function get bounds() : Rectangle
        {
            return nativeWindow.bounds;
        }// end function

        public function get showTitleBar() : Boolean
        {
            return _showTitleBar;
        }// end function

        public function get nativeApplication() : NativeApplication
        {
            return NativeApplication.nativeApplication;
        }// end function

        override protected function menuItemSelectHandler(event:Event) : void
        {
            var _loc_3:Rectangle = null;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:Number = NaN;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            var _loc_10:int = 0;
            var _loc_11:HTML = null;
            var _loc_12:Window = null;
            var _loc_2:* = File.applicationDirectory.resolvePath(viewSourceURL);
            if (_loc_2.exists)
            {
                _loc_3 = Screen.mainScreen.visibleBounds;
                _loc_4 = _loc_3.width;
                _loc_5 = _loc_3.height;
                _loc_6 = Math.min(_loc_4, _loc_5);
                _loc_7 = _loc_6 * 0.9;
                _loc_8 = _loc_7 * 0.618;
                _loc_9 = (_loc_4 - _loc_7) / 2;
                _loc_10 = (_loc_5 - _loc_8) / 2;
                _loc_11 = new HTML();
                _loc_11.width = _loc_7;
                _loc_11.height = _loc_8;
                _loc_11.location = _loc_2.url;
                _loc_12 = new Window();
                _loc_12.type = NativeWindowType.UTILITY;
                _loc_12.systemChrome = NativeWindowSystemChrome.STANDARD;
                _loc_12.title = resourceManager.getString("core", "viewSource");
                _loc_12.width = _loc_7;
                _loc_12.height = _loc_8;
                _loc_12.addChild(_loc_11);
                _loc_12.addEventListener(FlexNativeWindowBoundsEvent.WINDOW_RESIZE, viewSourceResizeHandler(_loc_11), false, 0, true);
                _loc_11.htmlLoader.navigateInSystemBrowser = true;
                addEventListener(Event.CLOSING, viewSourceCloseHandler(_loc_12), false, 0, true);
                _loc_12.open();
                _loc_12.move(_loc_9, _loc_10);
            }
            else
            {
                Alert.show(resourceManager.getString("core", "badFile"));
            }
            return;
        }// end function

        private function viewSourceResizeHandler(param1:HTML) : Function
        {
            var html:* = param1;
            return function (event:FlexNativeWindowBoundsEvent) : void
            {
                var _loc_2:* = event.target;
                html.width = _loc_2.width;
                html.height = _loc_2.height;
                return;
            }// end function
            ;
        }// end function

        public function set menu(param1:FlexNativeMenu) : void
        {
            _menu = param1;
            menuChanged = true;
            return;
        }// end function

        public function get statusBar() : UIComponent
        {
            return _statusBar;
        }// end function

        override public function get maxWidth() : Number
        {
            if (nativeWindow && !maxWidthChanged)
            {
                return nativeWindow.maxSize.x - chromeWidth();
            }
            return _maxWidth;
        }// end function

        private function windowMinimizeHandler(event:Event) : void
        {
            if (!nativeWindow.closed)
            {
                stage.nativeWindow.minimize();
            }
            removeEventListener("effectEnd", windowMinimizeHandler);
            return;
        }// end function

        public function get dockIconMenu() : FlexNativeMenu
        {
            return _dockIconMenu;
        }// end function

        private function window_boundsHandler(event:NativeWindowBoundsEvent) : void
        {
            var _loc_3:Rectangle = null;
            var _loc_4:Boolean = false;
            var _loc_2:* = event.afterBounds;
            if (event.type == NativeWindowBoundsEvent.MOVING)
            {
                dispatchEvent(event);
                if (event.isDefaultPrevented())
                {
                    return;
                }
            }
            else
            {
                dispatchEvent(event);
                if (event.isDefaultPrevented())
                {
                    return;
                }
                _loc_4 = false;
                if (_loc_2.width < nativeWindow.minSize.x)
                {
                    _loc_4 = true;
                    if (_loc_2.x != event.beforeBounds.x && !isNaN(oldX))
                    {
                        _loc_2.x = oldX;
                    }
                    _loc_2.width = nativeWindow.minSize.x;
                }
                else if (_loc_2.width > nativeWindow.maxSize.x)
                {
                    _loc_4 = true;
                    if (_loc_2.x != event.beforeBounds.x && !isNaN(oldX))
                    {
                        _loc_2.x = oldX;
                    }
                    _loc_2.width = nativeWindow.maxSize.x;
                }
                if (_loc_2.height < nativeWindow.minSize.y)
                {
                    _loc_4 = true;
                    if (event.afterBounds.y != event.beforeBounds.y && !isNaN(oldY))
                    {
                        _loc_2.y = oldY;
                    }
                    _loc_2.height = nativeWindow.minSize.y;
                }
                else if (_loc_2.height > nativeWindow.maxSize.y)
                {
                    _loc_4 = true;
                    if (event.afterBounds.y != event.beforeBounds.y && !isNaN(oldY))
                    {
                        _loc_2.y = oldY;
                    }
                    _loc_2.height = nativeWindow.maxSize.y;
                }
                if (_loc_4)
                {
                    event.preventDefault();
                    stage.nativeWindow.bounds = _loc_2;
                    windowBoundsChanged = true;
                    invalidateProperties();
                }
            }
            oldX = _loc_2.x;
            oldY = _loc_2.y;
            return;
        }// end function

        public function get showGripper() : Boolean
        {
            return _showGripper;
        }// end function

        public function maximize() : void
        {
            var _loc_1:NativeWindowDisplayStateEvent = null;
            if (!nativeWindow || !nativeWindow.maximizable || nativeWindow.closed)
            {
                return;
            }
            if (systemManager.stage.nativeWindow.displayState != NativeWindowDisplayState.MAXIMIZED)
            {
                _loc_1 = new NativeWindowDisplayStateEvent(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGING, false, true, systemManager.stage.nativeWindow.displayState, NativeWindowDisplayState.MAXIMIZED);
                systemManager.stage.nativeWindow.dispatchEvent(_loc_1);
                if (!_loc_1.isDefaultPrevented())
                {
                    invalidateProperties();
                    invalidateSize();
                    invalidateDisplayList();
                    toMax = true;
                }
            }
            return;
        }// end function

        private function windowMaximizeHandler(event:Event) : void
        {
            removeEventListener("effectEnd", windowMaximizeHandler);
            if (!nativeWindow.closed)
            {
                stage.nativeWindow.maximize();
            }
            return;
        }// end function

        public function set autoExit(param1:Boolean) : void
        {
            nativeApplication.autoExit = param1;
            return;
        }// end function

        private function nativeWindow_deactivateHandler(event:Event) : void
        {
            dispatchEvent(new AIREvent(AIREvent.WINDOW_DEACTIVATE));
            return;
        }// end function

        public function get nativeWindow() : NativeWindow
        {
            if (systemManager != null && systemManager.stage != null)
            {
                return systemManager.stage.nativeWindow;
            }
            return null;
        }// end function

        override public function set visible(param1:Boolean) : void
        {
            var _loc_2:FlexEvent = null;
            if (!nativeWindow)
            {
                _nativeWindowVisible = param1;
                invalidateProperties();
            }
            else if (!nativeWindow.closed)
            {
                if (param1)
                {
                    _loc_2 = new FlexEvent(FlexEvent.SHOW);
                    _nativeWindow.visible = param1;
                    dispatchEvent(_loc_2);
                }
                else
                {
                    _loc_2 = new FlexEvent(FlexEvent.HIDE);
                    if (getStyle("hideEffect"))
                    {
                        addEventListener("effectEnd", hideEffectEndHandler);
                    }
                    else
                    {
                        _nativeWindow.visible = param1;
                        dispatchEvent(_loc_2);
                    }
                }
            }
            return;
        }// end function

        public function orderToBack() : Boolean
        {
            if (nativeWindow && !nativeWindow.closed)
            {
                return nativeWindow.orderToBack();
            }
            return false;
        }// end function

        public function get titleIcon() : Class
        {
            return _titleIcon;
        }// end function

        private function creationCompleteHandler(event:Event) : void
        {
            addEventListener(Event.ENTER_FRAME, enterFrameHandler);
            _nativeWindow = systemManager.stage.nativeWindow;
            return;
        }// end function

        public function activate() : void
        {
            if (!systemManager.stage.nativeWindow.closed)
            {
                systemManager.stage.nativeWindow.activate();
            }
            return;
        }// end function

        public function get alwaysInFront() : Boolean
        {
            if (_nativeWindow && !_nativeWindow.closed)
            {
                return nativeWindow.alwaysInFront;
            }
            return _alwaysInFront;
        }// end function

        private function windowUnminimizeHandler(event:Event) : void
        {
            removeEventListener("effectEnd", windowUnminimizeHandler);
            return;
        }// end function

        private function window_closingHandler(event:Event) : void
        {
            var _loc_2:* = new Event("closing", true, true);
            dispatchEvent(_loc_2);
            if (_loc_2.isDefaultPrevented())
            {
                event.preventDefault();
            }
            else
            {
                if (getStyle("closeEffect") && stage.nativeWindow.transparent == true)
                {
                    addEventListener("effectEnd", window_closeEffectEndHandler);
                    dispatchEvent(new Event("windowClose"));
                    event.preventDefault();
                }
            }
            return;
        }// end function

        public function get statusBarFactory() : IFactory
        {
            return _statusBarFactory;
        }// end function

        private function windowUnmaximizeHandler(event:Event) : void
        {
            removeEventListener("effectEnd", windowUnmaximizeHandler);
            if (!nativeWindow.closed)
            {
                stage.nativeWindow.restore();
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:String = null;
            var _loc_2:CSSStyleDeclaration = null;
            super.createChildren();
            if (getStyle("showFlexChrome") == false || getStyle("showFlexChrome") == "false")
            {
                setStyle("borderStyle", "none");
                setStyle("backgroundAlpha", 0);
                return;
            }
            if (!_statusBar)
            {
                _statusBar = statusBarFactory.newInstance();
                _statusBar.styleName = new StyleProxy(this, statusBarStyleFilters);
                rawChildren.addChild(DisplayObject(_statusBar));
                showStatusBarChanged = true;
            }
            if (systemManager.stage.nativeWindow.systemChrome != "none")
            {
                setStyle("borderStyle", "none");
                return;
            }
            if (!_titleBar)
            {
                _titleBar = titleBarFactory.newInstance();
                _titleBar.styleName = new StyleProxy(this, titleBarStyleFilters);
                rawChildren.addChild(DisplayObject(titleBar));
                showTitleBarChanged = true;
                titleBarFactoryChanged = false;
            }
            if (!gripper)
            {
                gripper = new Button();
                _loc_1 = getStyle("gripperStyleName");
                if (_loc_1)
                {
                    _loc_2 = StyleManager.getStyleDeclaration("." + _loc_1);
                    gripper.styleName = _loc_1;
                }
                rawChildren.addChild(gripper);
                gripperHit = new Sprite();
                gripperHit.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
                rawChildren.addChild(gripperHit);
            }
            return;
        }// end function

        public function exit() : void
        {
            nativeApplication.exit();
            return;
        }// end function

        private function mouseUpHandler(event:MouseEvent) : void
        {
            removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
            removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
            return;
        }// end function

        override public function get height() : Number
        {
            return _bounds.height;
        }// end function

        override public function set minWidth(param1:Number) : void
        {
            _minWidth = param1;
            minWidthChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function getStatusBarHeight() : Number
        {
            if (_statusBar)
            {
                return _statusBar.getExplicitOrMeasuredHeight();
            }
            return 0;
        }// end function

        private function updateComplete_handler(event:FlexEvent) : void
        {
            if (ucCount == 1)
            {
                dispatchEvent(new Event("initialLayoutComplete"));
                removeEventListener(FlexEvent.UPDATE_COMPLETE, updateComplete_handler);
            }
            else
            {
                ucCount++;
            }
            return;
        }// end function

        public function set systemTrayIconMenu(param1:FlexNativeMenu) : void
        {
            _systemTrayIconMenu = param1;
            if (NativeApplication.supportsSystemTrayIcon)
            {
                if (nativeApplication.icon is SystemTrayIcon)
                {
                    SystemTrayIcon(nativeApplication.icon).menu = param1.nativeMenu;
                }
            }
            return;
        }// end function

        public function orderToFront() : Boolean
        {
            if (nativeWindow && !nativeWindow.closed)
            {
                return nativeWindow.orderToFront();
            }
            return false;
        }// end function

        public function get type() : String
        {
            if (nativeWindow.closed)
            {
                return "standard";
            }
            return nativeWindow.type;
        }// end function

        protected function get titleBarStyleFilters() : Object
        {
            return _titleBarStyleFilters;
        }// end function

        private function window_displayStateChangeHandler(event:NativeWindowDisplayStateEvent) : void
        {
            dispatchEvent(event);
            height = systemManager.stage.stageHeight;
            width = systemManager.stage.stageWidth;
            return;
        }// end function

        public function orderInFrontOf(param1:IWindow) : Boolean
        {
            if (nativeWindow && !nativeWindow.closed)
            {
                return nativeWindow.orderInFrontOf(param1.nativeWindow);
            }
            return false;
        }// end function

        private function nativeApplication_activateHandler(event:Event) : void
        {
            dispatchEvent(new AIREvent(AIREvent.APPLICATION_ACTIVATE));
            return;
        }// end function

        public function get transparent() : Boolean
        {
            if (nativeWindow.closed)
            {
                return false;
            }
            return nativeWindow.transparent;
        }// end function

        private function startMove(event:MouseEvent) : void
        {
            addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
            addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
            prevX = event.stageX;
            prevY = event.stageY;
            return;
        }// end function

        override public function set maxHeight(param1:Number) : void
        {
            _maxHeight = param1;
            maxHeightChanged = true;
            invalidateProperties();
            return;
        }// end function

        private function preinitializeHandler(event:Event = null) : void
        {
            systemManager.stage.nativeWindow.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGING, window_displayStateChangingHandler);
            systemManager.stage.nativeWindow.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE, window_displayStateChangeHandler);
            systemManager.stage.nativeWindow.addEventListener("closing", window_closingHandler);
            systemManager.stage.nativeWindow.addEventListener("close", window_closeHandler, false, 0, true);
            if (systemManager.stage.nativeWindow.active)
            {
                dispatchEvent(new AIREvent(AIREvent.WINDOW_ACTIVATE));
            }
            systemManager.stage.nativeWindow.addEventListener("activate", nativeWindow_activateHandler, false, 0, true);
            systemManager.stage.nativeWindow.addEventListener("deactivate", nativeWindow_deactivateHandler, false, 0, true);
            systemManager.stage.nativeWindow.addEventListener(NativeWindowBoundsEvent.MOVING, window_boundsHandler);
            systemManager.stage.nativeWindow.addEventListener(NativeWindowBoundsEvent.MOVE, window_moveHandler);
            systemManager.stage.nativeWindow.addEventListener(NativeWindowBoundsEvent.RESIZING, window_boundsHandler);
            systemManager.stage.nativeWindow.addEventListener(NativeWindowBoundsEvent.RESIZE, window_resizeHandler);
            systemManager.stage.addEventListener(FullScreenEvent.FULL_SCREEN, stage_fullScreenHandler);
            return;
        }// end function

        public function get menu() : FlexNativeMenu
        {
            return _menu;
        }// end function

        private function window_displayStateChangingHandler(event:NativeWindowDisplayStateEvent) : void
        {
            dispatchEvent(event);
            if (event.isDefaultPrevented())
            {
                return;
            }
            if (event.afterDisplayState == NativeWindowDisplayState.MINIMIZED)
            {
                if (getStyle("minimizeEffect"))
                {
                    event.preventDefault();
                    addEventListener("effectEnd", windowMinimizeHandler);
                    dispatchEvent(new Event("windowMinimize"));
                }
            }
            else if (event.beforeDisplayState == NativeWindowDisplayState.MINIMIZED)
            {
                addEventListener("effectEnd", windowUnminimizeHandler);
                dispatchEvent(new Event("windowUnminimize"));
            }
            return;
        }// end function

        private function window_closeEffectEndHandler(event:Event) : void
        {
            removeEventListener("effectEnd", window_closeEffectEndHandler);
            if (!nativeWindow.closed)
            {
                stage.nativeWindow.close();
            }
            return;
        }// end function

        protected function set bounds(param1:Rectangle) : void
        {
            nativeWindow.bounds = param1;
            boundsChanged = true;
            invalidateProperties();
            invalidateSize();
            invalidateViewMetricsAndPadding();
            return;
        }// end function

        public function get closed() : Boolean
        {
            return nativeWindow.closed;
        }// end function

        public function get autoExit() : Boolean
        {
            return nativeApplication.autoExit;
        }// end function

        public function set showTitleBar(param1:Boolean) : void
        {
            if (_showTitleBar == param1)
            {
                return;
            }
            _showTitleBar = param1;
            showTitleBarChanged = true;
            invalidateProperties();
            invalidateDisplayList();
            return;
        }// end function

        private function chromeWidth() : Number
        {
            return nativeWindow.width - systemManager.stage.stageWidth;
        }// end function

        private function closeButton_clickHandler(event:Event) : void
        {
            stage.nativeWindow.close();
            return;
        }// end function

        private function viewSourceCloseHandler(param1:Window) : Function
        {
            var win:* = param1;
            return function () : void
            {
                win.close();
                return;
            }// end function
            ;
        }// end function

        private function nativeWindow_activateHandler(event:Event) : void
        {
            dispatchEvent(new AIREvent(AIREvent.WINDOW_ACTIVATE));
            return;
        }// end function

        override public function set maxWidth(param1:Number) : void
        {
            _maxWidth = param1;
            maxWidthChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function get systemChrome() : String
        {
            if (nativeWindow.closed)
            {
                return "";
            }
            return nativeWindow.systemChrome;
        }// end function

        override public function validateDisplayList() : void
        {
            var _loc_1:Graphics = null;
            super.validateDisplayList();
            if (!nativeWindow.closed)
            {
                if (Capabilities.os.substring(0, 3) == "Mac" && systemChrome == "standard")
                {
                    if (horizontalScrollBar || verticalScrollBar && horizontalScrollBar && !verticalScrollBar && !showStatusBar)
                    {
                        if (!whiteBox)
                        {
                            whiteBox = new FlexShape();
                            whiteBox.name = "whiteBox";
                            _loc_1 = whiteBox.graphics;
                            _loc_1.beginFill(16777215);
                            _loc_1.drawRect(0, 0, verticalScrollBar ? (verticalScrollBar.minWidth) : (15), horizontalScrollBar ? (horizontalScrollBar.minHeight) : (15));
                            _loc_1.endFill();
                            rawChildren.addChild(whiteBox);
                        }
                        whiteBox.visible = true;
                        if (horizontalScrollBar)
                        {
                            horizontalScrollBar.setActualSize(horizontalScrollBar.width - whiteBox.width, horizontalScrollBar.height);
                        }
                        if (verticalScrollBar)
                        {
                            verticalScrollBar.setActualSize(verticalScrollBar.width, verticalScrollBar.height - whiteBox.height);
                        }
                        whiteBox.x = systemManager.stage.stageWidth - whiteBox.width;
                        whiteBox.y = systemManager.stage.stageHeight - whiteBox.height;
                    }
                    else if (!(horizontalScrollBar && verticalScrollBar))
                    {
                        if (whiteBox)
                        {
                            rawChildren.removeChild(whiteBox);
                            whiteBox = null;
                        }
                    }
                }
                else if (gripper && showGripper && !showStatusBar)
                {
                    if (whiteBox)
                    {
                        whiteBox.visible = false;
                        if (gripperHit.height > whiteBox.height)
                        {
                            verticalScrollBar.setActualSize(verticalScrollBar.width, verticalScrollBar.height - (gripperHit.height - whiteBox.height));
                        }
                        if (gripperHit.width > whiteBox.width)
                        {
                            horizontalScrollBar.setActualSize(horizontalScrollBar.width - (gripperHit.width - whiteBox.height), horizontalScrollBar.height);
                        }
                    }
                    else if (horizontalScrollBar)
                    {
                        horizontalScrollBar.setActualSize(horizontalScrollBar.width - gripperHit.width, horizontalScrollBar.height);
                    }
                    else if (verticalScrollBar)
                    {
                        verticalScrollBar.setActualSize(verticalScrollBar.width, verticalScrollBar.height - gripperHit.height);
                    }
                }
                else if (whiteBox)
                {
                    whiteBox.visible = true;
                }
            }
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            if (param1 < minWidth)
            {
                param1 = minWidth;
            }
            else if (param1 > maxWidth)
            {
                param1 = maxWidth;
            }
            _bounds.width = param1;
            boundsChanged = true;
            invalidateProperties();
            invalidateSize();
            invalidateViewMetricsAndPadding();
            return;
        }// end function

        public function set dockIconMenu(param1:FlexNativeMenu) : void
        {
            _dockIconMenu = param1;
            if (NativeApplication.supportsDockIcon)
            {
                if (nativeApplication.icon is DockIcon)
                {
                    DockIcon(nativeApplication.icon).menu = param1.nativeMenu;
                }
            }
            return;
        }// end function

        public function get maximizable() : Boolean
        {
            if (!nativeWindow.closed)
            {
                return nativeWindow.maximizable;
            }
            return false;
        }// end function

        public function set showGripper(param1:Boolean) : void
        {
            if (_showGripper == param1)
            {
                return;
            }
            _showGripper = param1;
            showGripperChanged = true;
            invalidateProperties();
            invalidateDisplayList();
            return;
        }// end function

        override public function get maxHeight() : Number
        {
            if (nativeWindow && !maxHeightChanged)
            {
                return nativeWindow.maxSize.y - chromeHeight();
            }
            return _maxHeight;
        }// end function

        protected function startResize(param1:String) : void
        {
            if (!nativeWindow.closed)
            {
                if (nativeWindow.resizable)
                {
                    stage.nativeWindow.startResize(param1);
                }
            }
            return;
        }// end function

        private function nativeApplication_networkChangeHandler(event:Event) : void
        {
            dispatchEvent(event);
            return;
        }// end function

        private function hideEffectEndHandler(event:Event) : void
        {
            _nativeWindow.visible = false;
            dispatchEvent(new FlexEvent(FlexEvent.HIDE));
            return;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            super.styleChanged(param1);
            if (!nativeWindow.closed)
            {
                if (!(getStyle("showFlexChrome") == "false" || getStyle("showFlexChrome") == false))
                {
                    if (param1 == null || param1 == "headerHeight" || param1 == "gripperPadding")
                    {
                        invalidateViewMetricsAndPadding();
                        invalidateDisplayList();
                        invalidateSize();
                    }
                }
            }
            return;
        }// end function

        override public function get width() : Number
        {
            return _bounds.width;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:Number = NaN;
            var _loc_2:Number = NaN;
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            super.commitProperties();
            if (minWidthChanged || minHeightChanged)
            {
                _loc_1 = minWidthChanged ? (_minWidth + chromeWidth()) : (nativeWindow.minSize.x);
                _loc_2 = minHeightChanged ? (_minHeight + chromeHeight()) : (nativeWindow.minSize.y);
                nativeWindow.minSize = new Point(_loc_1, _loc_2);
                if (minWidthChanged)
                {
                    minWidthChanged = false;
                    if (width < minWidth)
                    {
                        width = minWidth;
                    }
                    dispatchEvent(new Event("minWidthChanged"));
                }
                if (minHeightChanged)
                {
                    minHeightChanged = false;
                    if (height < minHeight)
                    {
                        height = minHeight;
                    }
                    dispatchEvent(new Event("minHeightChanged"));
                }
            }
            if (maxWidthChanged || maxHeightChanged)
            {
                _loc_3 = maxWidthChanged ? (_maxWidth + chromeWidth()) : (nativeWindow.maxSize.x);
                _loc_4 = maxHeightChanged ? (_maxHeight + chromeHeight()) : (nativeWindow.maxSize.y);
                nativeWindow.maxSize = new Point(_loc_3, _loc_4);
                if (maxWidthChanged)
                {
                    maxWidthChanged = false;
                    if (width > maxWidth)
                    {
                        width = maxWidth;
                    }
                    dispatchEvent(new Event("maxWidthChanged"));
                }
                if (maxHeightChanged)
                {
                    maxHeightChanged = false;
                    if (height > maxHeight)
                    {
                        height = maxHeight;
                    }
                    dispatchEvent(new Event("maxHeightChanged"));
                }
            }
            if (boundsChanged)
            {
                var _loc_5:* = _bounds.width;
                _width = _bounds.width;
                systemManager.stage.stageWidth = _loc_5;
                var _loc_5:* = _bounds.height;
                _height = _bounds.height;
                systemManager.stage.stageHeight = _loc_5;
                boundsChanged = false;
                dispatchEvent(new Event("widthChanged"));
                dispatchEvent(new Event("heightChanged"));
            }
            if (windowBoundsChanged)
            {
                var _loc_5:* = systemManager.stage.stageWidth;
                _width = systemManager.stage.stageWidth;
                _bounds.width = _loc_5;
                var _loc_5:* = systemManager.stage.stageHeight;
                _height = systemManager.stage.stageHeight;
                _bounds.height = _loc_5;
                windowBoundsChanged = false;
                dispatchEvent(new Event("widthChanged"));
                dispatchEvent(new Event("heightChanged"));
            }
            if (menuChanged && !nativeWindow.closed)
            {
                menuChanged = false;
                if (menu == null)
                {
                    if (NativeApplication.supportsMenu)
                    {
                        nativeApplication.menu = null;
                    }
                    else if (NativeWindow.supportsMenu)
                    {
                        nativeWindow.menu = null;
                    }
                }
                else if (menu.nativeMenu)
                {
                    if (NativeApplication.supportsMenu)
                    {
                        nativeApplication.menu = menu.nativeMenu;
                    }
                    else if (NativeWindow.supportsMenu)
                    {
                        nativeWindow.menu = menu.nativeMenu;
                    }
                }
            }
            if (titleBarFactoryChanged)
            {
                if (_titleBar)
                {
                    rawChildren.removeChild(DisplayObject(titleBar));
                    _titleBar = null;
                }
                _titleBar = titleBarFactory.newInstance();
                _titleBar.styleName = new StyleProxy(this, titleBarStyleFilters);
                rawChildren.addChild(DisplayObject(titleBar));
                titleBarFactoryChanged = false;
                invalidateDisplayList();
            }
            if (showTitleBarChanged)
            {
                if (titleBar)
                {
                    titleBar.visible = _showTitleBar;
                }
                showTitleBarChanged = false;
            }
            if (titleIconChanged)
            {
                if (_titleBar && "titleIcon" in _titleBar)
                {
                    _titleBar["titleIcon"] = _titleIcon;
                }
                titleIconChanged = false;
            }
            if (titleChanged)
            {
                if (!nativeWindow.closed)
                {
                    systemManager.stage.nativeWindow.title = _title;
                }
                if (_titleBar && "title" in _titleBar)
                {
                    _titleBar["title"] = _title;
                }
                titleChanged = false;
            }
            if (statusBarFactoryChanged)
            {
                if (_statusBar)
                {
                    rawChildren.removeChild(DisplayObject(_statusBar));
                    _statusBar = null;
                }
                _statusBar = statusBarFactory.newInstance();
                _statusBar.styleName = new StyleProxy(this, statusBarStyleFilters);
                if (gripper)
                {
                    rawChildren.addChildAt(DisplayObject(_statusBar), rawChildren.getChildIndex(gripper));
                }
                else
                {
                    rawChildren.addChild(DisplayObject(_statusBar));
                }
                statusBarFactoryChanged = false;
                showStatusBarChanged = true;
                invalidateDisplayList();
            }
            if (showStatusBarChanged)
            {
                if (_statusBar)
                {
                    _statusBar.visible = _showStatusBar;
                }
                showStatusBarChanged = false;
            }
            if (statusChanged)
            {
                if (_statusBar && "status" in _statusBar)
                {
                    _statusBar["status"] = _status;
                }
                statusChanged = false;
            }
            if (showGripperChanged)
            {
                if (gripper)
                {
                    gripper.visible = _showGripper;
                    gripperHit.visible = _showGripper;
                }
                showGripperChanged = false;
            }
            if (toMax)
            {
                toMax = false;
                if (!nativeWindow.closed)
                {
                    nativeWindow.maximize();
                }
            }
            return;
        }// end function

        override public function move(param1:Number, param2:Number) : void
        {
            var _loc_3:Rectangle = null;
            if (nativeWindow && !nativeWindow.closed)
            {
                _loc_3 = nativeWindow.bounds;
                _loc_3.x = param1;
                _loc_3.y = param2;
                nativeWindow.bounds = _loc_3;
            }
            return;
        }// end function

        public function set titleBarFactory(param1:IFactory) : void
        {
            _titleBarFactory = param1;
            titleBarFactoryChanged = true;
            invalidateProperties();
            dispatchEvent(new Event("titleBarFactoryChanged"));
            return;
        }// end function

        private function window_resizeHandler(event:NativeWindowBoundsEvent) : void
        {
            if (!windowBoundsChanged)
            {
                windowBoundsChanged = true;
                invalidateProperties();
                invalidateViewMetricsAndPadding();
                invalidateDisplayList();
                validateNow();
            }
            var _loc_2:* = new FlexNativeWindowBoundsEvent(FlexNativeWindowBoundsEvent.WINDOW_RESIZE, event.bubbles, event.cancelable, event.beforeBounds, event.afterBounds);
            dispatchEvent(_loc_2);
            return;
        }// end function

        public function set titleIcon(param1:Class) : void
        {
            _titleIcon = param1;
            titleIconChanged = true;
            invalidateProperties();
            invalidateSize();
            invalidateViewMetricsAndPadding();
            invalidateDisplayList();
            dispatchEvent(new Event("titleIconChanged"));
            return;
        }// end function

        public function set alwaysInFront(param1:Boolean) : void
        {
            _alwaysInFront = param1;
            if (_nativeWindow && !_nativeWindow.closed)
            {
                nativeWindow.alwaysInFront = param1;
            }
            return;
        }// end function

        public function set status(param1:String) : void
        {
            _status = param1;
            statusChanged = true;
            invalidateProperties();
            invalidateSize();
            invalidateViewMetricsAndPadding();
            dispatchEvent(new Event("statusChanged"));
            return;
        }// end function

        private function stage_fullScreenHandler(event:FullScreenEvent) : void
        {
            if (stage.displayState != lastDisplayState)
            {
                lastDisplayState = stage.displayState;
                if (stage.displayState == StageDisplayState.FULL_SCREEN || stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE)
                {
                    shouldShowTitleBar = showTitleBar;
                    showTitleBar = false;
                }
                else
                {
                    showTitleBar = shouldShowTitleBar;
                }
            }
            return;
        }// end function

        public function get titleBarFactory() : IFactory
        {
            return _titleBarFactory;
        }// end function

        public function get status() : String
        {
            return _status;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_3:EdgeMetrics = null;
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_6:String = null;
            if (!nativeWindow.closed)
            {
                super.updateDisplayList(param1, param2);
                _loc_3 = borderMetrics;
                _loc_4 = 10;
                _loc_5 = 10;
                if (_statusBar)
                {
                    _statusBar.move(_loc_3.left, param2 - _loc_3.bottom - getStatusBarHeight());
                    _statusBar.setActualSize(param1 - _loc_3.left - _loc_3.right, getStatusBarHeight());
                }
                if (systemManager.stage.nativeWindow.systemChrome != "none" || systemManager.stage.nativeWindow.closed)
                {
                    return;
                }
                _loc_6 = String(getStyle("buttonAlignment"));
                if (titleBar)
                {
                    titleBar.move(_loc_3.left, _loc_3.top);
                    titleBar.setActualSize(param1 - _loc_3.left - _loc_3.right, getHeaderHeight());
                }
                if (titleBar && controlBar)
                {
                    controlBar.move(0, titleBar.height);
                }
                if (gripper && showGripper)
                {
                    _gripperPadding = getStyle("gripperPadding");
                    gripper.setActualSize(gripper.measuredWidth, gripper.measuredHeight);
                    gripperHit.graphics.beginFill(16777215, 0.0001);
                    gripperHit.graphics.drawRect(0, 0, gripper.width + 2 * _gripperPadding, gripper.height + 2 * _gripperPadding);
                    gripper.move(param1 - gripper.measuredWidth - _gripperPadding, param2 - gripper.measuredHeight - _gripperPadding);
                    gripperHit.x = gripper.x - _gripperPadding;
                    gripperHit.y = gripper.y - _gripperPadding;
                }
            }
            return;
        }// end function

        public function close() : void
        {
            var _loc_1:Event = null;
            if (!nativeWindow.closed)
            {
                _loc_1 = new Event("closing", true, true);
                stage.nativeWindow.dispatchEvent(_loc_1);
                if (!_loc_1.isDefaultPrevented())
                {
                    stage.nativeWindow.close();
                }
            }
            return;
        }// end function

    }
}
