package mx.core
{
    import flash.display.*;
    import flash.events.*;
    import flash.external.*;
    import flash.net.*;
    import flash.system.*;
    import flash.ui.*;
    import flash.utils.*;
    import mx.containers.utilityClasses.*;
    import mx.effects.*;
    import mx.events.*;
    import mx.managers.*;
    import mx.styles.*;

    public class Application extends LayoutContainer
    {
        public var preloader:Object;
        public var pageTitle:String;
        private var resizeWidth:Boolean = true;
        private var _applicationViewMetrics:EdgeMetrics;
        var _parameters:Object;
        private var processingCreationQueue:Boolean = false;
        public var scriptRecursionLimit:int;
        private var resizeHandlerAdded:Boolean = false;
        private var preloadObj:Object;
        public var usePreloader:Boolean;
        var _url:String;
        private var _viewSourceURL:String;
        public var resetHistory:Boolean = true;
        public var historyManagementEnabled:Boolean = true;
        public var scriptTimeLimit:Number;
        public var frameRate:Number;
        private var creationQueue:Array;
        private var resizeHeight:Boolean = true;
        public var controlBar:IUIComponent;
        private var viewSourceCMI:ContextMenuItem;
        static const VERSION:String = "3.2.0.3958";
        static var useProgressiveLayout:Boolean = false;

        public function Application()
        {
            creationQueue = [];
            name = "application";
            UIComponentGlobals.layoutManager = ILayoutManager(Singleton.getInstance("mx.managers::ILayoutManager"));
            UIComponentGlobals.layoutManager.usePhasedInstantiation = true;
            if (!ApplicationGlobals.application)
            {
                ApplicationGlobals.application = this;
            }
            layoutObject = new ApplicationLayout();
            layoutObject.target = this;
            boxLayoutClass = ApplicationLayout;
            showInAutomationHierarchy = true;
            return;
        }// end function

        public function set viewSourceURL(param1:String) : void
        {
            _viewSourceURL = param1;
            return;
        }// end function

        override public function set percentWidth(param1:Number) : void
        {
            super.percentWidth = param1;
            invalidateDisplayList();
            return;
        }// end function

        override public function prepareToPrint(param1:IFlexDisplayObject) : Object
        {
            var _loc_2:Object = {};
            if (param1 == this)
            {
                _loc_2.width = width;
                _loc_2.height = height;
                _loc_2.verticalScrollPosition = verticalScrollPosition;
                _loc_2.horizontalScrollPosition = horizontalScrollPosition;
                _loc_2.horizontalScrollBarVisible = horizontalScrollBar != null;
                _loc_2.verticalScrollBarVisible = verticalScrollBar != null;
                _loc_2.whiteBoxVisible = whiteBox != null;
                setActualSize(measuredWidth, measuredHeight);
                horizontalScrollPosition = 0;
                verticalScrollPosition = 0;
                if (horizontalScrollBar)
                {
                    horizontalScrollBar.visible = false;
                }
                if (verticalScrollBar)
                {
                    verticalScrollBar.visible = false;
                }
                if (whiteBox)
                {
                    whiteBox.visible = false;
                }
                updateDisplayList(unscaledWidth, unscaledHeight);
            }
            _loc_2.scrollRect = super.prepareToPrint(param1);
            return _loc_2;
        }// end function

        override protected function measure() : void
        {
            var _loc_2:Number = NaN;
            super.measure();
            var _loc_1:* = borderMetrics;
            if (controlBar && controlBar.includeInLayout)
            {
                _loc_2 = controlBar.getExplicitOrMeasuredWidth() + _loc_1.left + _loc_1.right;
                measuredWidth = Math.max(measuredWidth, _loc_2);
                measuredMinWidth = Math.max(measuredMinWidth, _loc_2);
            }
            return;
        }// end function

        override public function getChildIndex(param1:DisplayObject) : int
        {
            if (controlBar && param1 == controlBar)
            {
                return -1;
            }
            return super.getChildIndex(param1);
        }// end function

        private function resizeHandler(event:Event) : void
        {
            var _loc_2:Number = NaN;
            var _loc_3:Number = NaN;
            if (resizeWidth)
            {
                if (isNaN(percentWidth))
                {
                    _loc_2 = DisplayObject(systemManager).width;
                }
                else
                {
                    super.percentWidth = Math.max(percentWidth, 0);
                    super.percentWidth = Math.min(percentWidth, 100);
                    _loc_2 = percentWidth * screen.width / 100;
                }
                if (!isNaN(explicitMaxWidth))
                {
                    _loc_2 = Math.min(_loc_2, explicitMaxWidth);
                }
                if (!isNaN(explicitMinWidth))
                {
                    _loc_2 = Math.max(_loc_2, explicitMinWidth);
                }
            }
            else
            {
                _loc_2 = width;
            }
            if (resizeHeight)
            {
                if (isNaN(percentHeight))
                {
                    _loc_3 = DisplayObject(systemManager).height;
                }
                else
                {
                    super.percentHeight = Math.max(percentHeight, 0);
                    super.percentHeight = Math.min(percentHeight, 100);
                    _loc_3 = percentHeight * screen.height / 100;
                }
                if (!isNaN(explicitMaxHeight))
                {
                    _loc_3 = Math.min(_loc_3, explicitMaxHeight);
                }
                if (!isNaN(explicitMinHeight))
                {
                    _loc_3 = Math.max(_loc_3, explicitMinHeight);
                }
            }
            else
            {
                _loc_3 = height;
            }
            if (_loc_2 != width || _loc_3 != height)
            {
                invalidateProperties();
                invalidateSize();
            }
            setActualSize(_loc_2, _loc_3);
            invalidateDisplayList();
            return;
        }// end function

        private function initManagers(param1:ISystemManager) : void
        {
            if (param1.isTopLevel())
            {
                focusManager = new FocusManager(this);
                param1.activate(this);
            }
            return;
        }// end function

        override public function initialize() : void
        {
            var _loc_2:Object = null;
            var _loc_1:* = systemManager;
            _url = _loc_1.loaderInfo.url;
            _parameters = _loc_1.loaderInfo.parameters;
            initManagers(_loc_1);
            _descriptor = null;
            if (documentDescriptor)
            {
                creationPolicy = documentDescriptor.properties.creationPolicy;
                if (creationPolicy == null || creationPolicy.length == 0)
                {
                    creationPolicy = ContainerCreationPolicy.AUTO;
                }
                _loc_2 = documentDescriptor.properties;
                if (_loc_2.width != null)
                {
                    width = _loc_2.width;
                    delete _loc_2.width;
                }
                if (_loc_2.height != null)
                {
                    height = _loc_2.height;
                    delete _loc_2.height;
                }
                documentDescriptor.events = null;
            }
            initContextMenu();
            super.initialize();
            addEventListener(Event.ADDED, addedHandler);
            if (_loc_1.isTopLevelRoot() && Capabilities.isDebugger == true)
            {
                setInterval(debugTickler, 1500);
            }
            return;
        }// end function

        override public function set percentHeight(param1:Number) : void
        {
            super.percentHeight = param1;
            invalidateDisplayList();
            return;
        }// end function

        override public function get id() : String
        {
            if (!super.id && Application.application == this && ExternalInterface.available)
            {
                return ExternalInterface.objectID;
            }
            return super.id;
        }// end function

        override function setUnscaledWidth(param1:Number) : void
        {
            invalidateProperties();
            super.setUnscaledWidth(param1);
            return;
        }// end function

        private function debugTickler() : void
        {
            var _loc_1:int = 0;
            return;
        }// end function

        private function doNextQueueItem(event:FlexEvent = null) : void
        {
            processingCreationQueue = true;
            Application.useProgressiveLayout = true;
            callLater(processNextQueueItem);
            return;
        }// end function

        private function initContextMenu() : void
        {
            var _loc_2:String = null;
            if (flexContextMenu != null)
            {
                if (systemManager is InteractiveObject)
                {
                    InteractiveObject(systemManager).contextMenu = contextMenu;
                }
                return;
            }
            var _loc_1:* = new ContextMenu();
            _loc_1.hideBuiltInItems();
            _loc_1.builtInItems.print = true;
            if (_viewSourceURL)
            {
                _loc_2 = resourceManager.getString("core", "viewSource");
                viewSourceCMI = new ContextMenuItem(_loc_2, true);
                viewSourceCMI.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
                _loc_1.customItems.push(viewSourceCMI);
            }
            contextMenu = _loc_1;
            if (systemManager is InteractiveObject)
            {
                InteractiveObject(systemManager).contextMenu = _loc_1;
            }
            return;
        }// end function

        private function addedHandler(event:Event) : void
        {
            if (event.target == this && creationQueue.length > 0)
            {
                doNextQueueItem();
            }
            return;
        }// end function

        public function get viewSourceURL() : String
        {
            return _viewSourceURL;
        }// end function

        override function get usePadding() : Boolean
        {
            return layout != ContainerLayout.ABSOLUTE;
        }// end function

        override function setUnscaledHeight(param1:Number) : void
        {
            invalidateProperties();
            super.setUnscaledHeight(param1);
            return;
        }// end function

        function dockControlBar(param1:IUIComponent, param2:Boolean) : void
        {
            var controlBar:* = param1;
            var dock:* = param2;
            if (dock)
            {
                try
                {
                    removeChild(DisplayObject(controlBar));
                }
                catch (e:Error)
                {
                    return;
                }
                rawChildren.addChildAt(DisplayObject(controlBar), firstChildIndex);
                setControlBar(controlBar);
            }
            else
            {
                try
                {
                    rawChildren.removeChild(DisplayObject(controlBar));
                }
                catch (e:Error)
                {
                    return;
                }
                setControlBar(null);
                addChildAt(DisplayObject(controlBar), 0);
            }
            return;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            super.styleChanged(param1);
            if (param1 == "backgroundColor" && getStyle("backgroundImage") == getStyle("defaultBackgroundImage"))
            {
                clearStyle("backgroundImage");
            }
            return;
        }// end function

        override protected function layoutChrome(param1:Number, param2:Number) : void
        {
            super.layoutChrome(param1, param2);
            if (!doingLayout)
            {
                createBorder();
            }
            var _loc_3:* = borderMetrics;
            var _loc_4:* = getStyle("borderThickness");
            var _loc_5:* = new EdgeMetrics();
            new EdgeMetrics().left = _loc_3.left - _loc_4;
            _loc_5.top = _loc_3.top - _loc_4;
            _loc_5.right = _loc_3.right - _loc_4;
            _loc_5.bottom = _loc_3.bottom - _loc_4;
            if (controlBar && controlBar.includeInLayout)
            {
                if (controlBar is IInvalidating)
                {
                    IInvalidating(controlBar).invalidateDisplayList();
                }
                controlBar.setActualSize(width - (_loc_5.left + _loc_5.right), controlBar.getExplicitOrMeasuredHeight());
                controlBar.move(_loc_5.left, _loc_5.top);
            }
            return;
        }// end function

        protected function menuItemSelectHandler(event:Event) : void
        {
            navigateToURL(new URLRequest(_viewSourceURL), "_blank");
            return;
        }// end function

        private function printCreationQueue() : void
        {
            var _loc_4:Object = null;
            var _loc_1:String = "";
            var _loc_2:* = creationQueue.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = creationQueue[_loc_3];
                _loc_1 = _loc_1 + (" [" + _loc_3 + "] " + _loc_4.id + " " + _loc_4.index);
                _loc_3++;
            }
            return;
        }// end function

        override protected function resourcesChanged() : void
        {
            super.resourcesChanged();
            if (viewSourceCMI)
            {
                viewSourceCMI.caption = resourceManager.getString("core", "viewSource");
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            resizeWidth = isNaN(explicitWidth);
            resizeHeight = isNaN(explicitHeight);
            if (resizeWidth || resizeHeight)
            {
                resizeHandler(new Event(Event.RESIZE));
                if (!resizeHandlerAdded)
                {
                    systemManager.addEventListener(Event.RESIZE, resizeHandler, false, 0, true);
                    resizeHandlerAdded = true;
                }
            }
            else if (resizeHandlerAdded)
            {
                systemManager.removeEventListener(Event.RESIZE, resizeHandler);
                resizeHandlerAdded = false;
            }
            return;
        }// end function

        override public function set toolTip(param1:String) : void
        {
            return;
        }// end function

        public function addToCreationQueue(param1:Object, param2:int = -1, param3:Function = null, param4:IFlexDisplayObject = null) : void
        {
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            var _loc_10:int = 0;
            var _loc_12:int = 0;
            var _loc_5:* = creationQueue.length;
            var _loc_6:Object = {};
            var _loc_7:Boolean = false;
            _loc_6.id = param1;
            _loc_6.parent = param4;
            _loc_6.callbackFunc = param3;
            _loc_6.index = param2;
            var _loc_11:int = 0;
            while (_loc_11 < _loc_5)
            {
                
                _loc_9 = creationQueue[_loc_11].index;
                _loc_10 = creationQueue[_loc_11].parent ? (creationQueue[_loc_11].parent.nestLevel) : (0);
                if (_loc_6.index != -1)
                {
                    if (_loc_9 == -1 || _loc_6.index < _loc_9)
                    {
                        _loc_8 = _loc_11;
                        _loc_7 = true;
                        break;
                    }
                }
                else
                {
                    _loc_12 = _loc_6.parent ? (_loc_6.parent.nestLevel) : (0);
                    if (_loc_9 == -1 && _loc_10 < _loc_12)
                    {
                        _loc_8 = _loc_11;
                        _loc_7 = true;
                        break;
                    }
                }
                _loc_11++;
            }
            if (true)
            {
                creationQueue.push(_loc_6);
                _loc_7 = true;
            }
            else
            {
                creationQueue.splice(_loc_8, 0, _loc_6);
            }
            if (initialized && !processingCreationQueue)
            {
                doNextQueueItem();
            }
            return;
        }// end function

        override function initThemeColor() : Boolean
        {
            var _loc_2:Object = null;
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            var _loc_5:CSSStyleDeclaration = null;
            var _loc_1:* = super.initThemeColor();
            if (!_loc_1)
            {
                _loc_5 = StyleManager.getStyleDeclaration("global");
                if (_loc_5)
                {
                    _loc_2 = _loc_5.getStyle("themeColor");
                    _loc_3 = _loc_5.getStyle("rollOverColor");
                    _loc_4 = _loc_5.getStyle("selectionColor");
                }
                if (_loc_2 && isNaN(_loc_3) && isNaN(_loc_4))
                {
                    setThemeColor(_loc_2);
                }
                _loc_1 = true;
            }
            return _loc_1;
        }// end function

        override public function finishPrint(param1:Object, param2:IFlexDisplayObject) : void
        {
            if (param2 == this)
            {
                setActualSize(param1.width, param1.height);
                if (horizontalScrollBar)
                {
                    horizontalScrollBar.visible = param1.horizontalScrollBarVisible;
                }
                if (verticalScrollBar)
                {
                    verticalScrollBar.visible = param1.verticalScrollBarVisible;
                }
                if (whiteBox)
                {
                    whiteBox.visible = param1.whiteBoxVisible;
                }
                horizontalScrollPosition = param1.horizontalScrollPosition;
                verticalScrollPosition = param1.verticalScrollPosition;
                updateDisplayList(unscaledWidth, unscaledHeight);
            }
            super.finishPrint(param1.scrollRect, param2);
            return;
        }// end function

        private function processNextQueueItem() : void
        {
            var queueItem:Object;
            var nextChild:IUIComponent;
            if (EffectManager.effectsPlaying.length > 0)
            {
                callLater(processNextQueueItem);
            }
            else if (creationQueue.length > 0)
            {
                queueItem = creationQueue.shift();
                try
                {
                    nextChild = queueItem.id is String ? (document[queueItem.id]) : (queueItem.id);
                    if (nextChild is Container)
                    {
                        Container(nextChild).createComponentsFromDescriptors(true);
                    }
                    if (nextChild is Container && Container(nextChild).creationPolicy == ContainerCreationPolicy.QUEUED)
                    {
                        doNextQueueItem();
                    }
                    else
                    {
                        nextChild.addEventListener("childrenCreationComplete", doNextQueueItem);
                    }
                }
                catch (e:Error)
                {
                    processNextQueueItem();
                }
            }
            else
            {
                processingCreationQueue = false;
                Application.useProgressiveLayout = false;
            }
            return;
        }// end function

        override public function set label(param1:String) : void
        {
            return;
        }// end function

        public function get parameters() : Object
        {
            return _parameters;
        }// end function

        override public function get viewMetrics() : EdgeMetrics
        {
            if (!_applicationViewMetrics)
            {
                _applicationViewMetrics = new EdgeMetrics();
            }
            var _loc_1:* = _applicationViewMetrics;
            var _loc_2:* = super.viewMetrics;
            var _loc_3:* = getStyle("borderThickness");
            _loc_1.left = _loc_2.left;
            _loc_1.top = _loc_2.top;
            _loc_1.right = _loc_2.right;
            _loc_1.bottom = _loc_2.bottom;
            if (controlBar && controlBar.includeInLayout)
            {
                _loc_1.top = _loc_1.top - _loc_3;
                _loc_1.top = _loc_1.top + Math.max(controlBar.getExplicitOrMeasuredHeight(), _loc_3);
            }
            return _loc_1;
        }// end function

        public function get url() : String
        {
            return _url;
        }// end function

        override public function set icon(param1:Class) : void
        {
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            createBorder();
            return;
        }// end function

        private function setControlBar(param1:IUIComponent) : void
        {
            if (param1 == controlBar)
            {
                return;
            }
            if (controlBar && controlBar is IStyleClient)
            {
                IStyleClient(controlBar).clearStyle("cornerRadius");
                IStyleClient(controlBar).clearStyle("docked");
            }
            controlBar = param1;
            if (controlBar && controlBar is IStyleClient)
            {
                IStyleClient(controlBar).setStyle("cornerRadius", 0);
                IStyleClient(controlBar).setStyle("docked", true);
            }
            invalidateSize();
            invalidateDisplayList();
            invalidateViewMetricsAndPadding();
            return;
        }// end function

        override public function set tabIndex(param1:int) : void
        {
            return;
        }// end function

        public static function get application() : Object
        {
            return ApplicationGlobals.application;
        }// end function

    }
}
