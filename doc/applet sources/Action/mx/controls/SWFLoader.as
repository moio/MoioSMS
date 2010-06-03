package mx.controls
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    import mx.core.*;
    import mx.events.*;
    import mx.managers.*;
    import mx.styles.*;
    import mx.utils.*;

    public class SWFLoader extends UIComponent implements ISWFLoader
    {
        private var _loadForCompatibility:Boolean = false;
        private var _loaderContext:LoaderContext;
        private var requestedURL:URLRequest;
        private var _swfBridge:IEventDispatcher;
        private var _bytesTotal:Number = 1.#QNAN;
        private var useUnloadAndStop:Boolean;
        private var flexContent:Boolean = false;
        private var explicitLoaderContext:Boolean = false;
        private var resizableContent:Boolean = false;
        private var brokenImageBorder:IFlexDisplayObject;
        private var _maintainAspectRatio:Boolean = true;
        private var _source:Object;
        private var mouseShield:Sprite;
        private var contentRequestID:String = null;
        var contentHolder:DisplayObject;
        private var brokenImage:Boolean = false;
        private var _bytesLoaded:Number = 1.#QNAN;
        private var _autoLoad:Boolean = true;
        private var _showBusyCursor:Boolean = false;
        private var _scaleContent:Boolean = true;
        private var isContentLoaded:Boolean = false;
        private var unloadAndStopGC:Boolean;
        private var _trustContent:Boolean = false;
        private var attemptingChildAppDomain:Boolean = false;
        private var scaleContentChanged:Boolean = false;
        private var contentChanged:Boolean = false;
        static const VERSION:String = "3.2.0.3958";

        public function SWFLoader()
        {
            tabChildren = true;
            tabEnabled = false;
            addEventListener(FlexEvent.INITIALIZE, initializeHandler);
            addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
            showInAutomationHierarchy = false;
            return;
        }// end function

        public function get contentHeight() : Number
        {
            return contentHolder ? (contentHolder.height) : (NaN);
        }// end function

        public function get trustContent() : Boolean
        {
            return _trustContent;
        }// end function

        public function set trustContent(param1:Boolean) : void
        {
            if (_trustContent != param1)
            {
                _trustContent = param1;
                invalidateProperties();
                invalidateSize();
                invalidateDisplayList();
                dispatchEvent(new Event("trustContentChanged"));
            }
            return;
        }// end function

        public function get maintainAspectRatio() : Boolean
        {
            return _maintainAspectRatio;
        }// end function

        private function unScaleContent() : void
        {
            contentHolder.scaleX = 1;
            contentHolder.scaleY = 1;
            contentHolder.x = 0;
            contentHolder.y = 0;
            return;
        }// end function

        public function set maintainAspectRatio(param1:Boolean) : void
        {
            _maintainAspectRatio = param1;
            dispatchEvent(new Event("maintainAspectRatioChanged"));
            return;
        }// end function

        override public function regenerateStyleCache(param1:Boolean) : void
        {
            var sm:ISystemManager;
            var recursive:* = param1;
            super.regenerateStyleCache(recursive);
            try
            {
                sm = content as ISystemManager;
                if (sm != null)
                {
                    Object(sm).regenerateStyleCache(recursive);
                }
            }
            catch (error:Error)
            {
            }
            return;
        }// end function

        private function get contentHolderHeight() : Number
        {
            var loaderInfo:LoaderInfo;
            var content:IFlexDisplayObject;
            var bridge:IEventDispatcher;
            var request:SWFBridgeRequest;
            var testContent:DisplayObject;
            if (contentHolder is Loader)
            {
                loaderInfo = Loader(contentHolder).contentLoaderInfo;
            }
            if (loaderInfo)
            {
                if (loaderInfo.contentType == "application/x-shockwave-flash")
                {
                    try
                    {
                        if (systemManager.swfBridgeGroup)
                        {
                            bridge = swfBridge;
                            if (bridge)
                            {
                                request = new SWFBridgeRequest(SWFBridgeRequest.GET_SIZE_REQUEST);
                                bridge.dispatchEvent(request);
                                return request.data.height;
                            }
                        }
                        content = Loader(contentHolder).content as IFlexDisplayObject;
                        if (content)
                        {
                            return content.measuredHeight;
                        }
                    }
                    catch (error:Error)
                    {
                        return contentHolder.height;
                    }
                }
                else
                {
                    try
                    {
                        testContent = Loader(contentHolder).content;
                    }
                    catch (error:Error)
                    {
                        return contentHolder.height;
                    }
                }
                return loaderInfo.height;
            }
            if (contentHolder is IUIComponent)
            {
                return IUIComponent(contentHolder).getExplicitOrMeasuredHeight();
            }
            if (contentHolder is IFlexDisplayObject)
            {
                return IFlexDisplayObject(contentHolder).measuredHeight;
            }
            return contentHolder.height;
        }// end function

        public function get loaderContext() : LoaderContext
        {
            return _loaderContext;
        }// end function

        public function set showBusyCursor(param1:Boolean) : void
        {
            if (_showBusyCursor != param1)
            {
                _showBusyCursor = param1;
                if (_showBusyCursor)
                {
                    CursorManager.registerToUseBusyCursor(this);
                }
                else
                {
                    CursorManager.unRegisterToUseBusyCursor(this);
                }
            }
            return;
        }// end function

        override public function notifyStyleChangeInChildren(param1:String, param2:Boolean) : void
        {
            var sm:ISystemManager;
            var styleProp:* = param1;
            var recursive:* = param2;
            super.notifyStyleChangeInChildren(styleProp, recursive);
            try
            {
                sm = content as ISystemManager;
                if (sm != null)
                {
                    Object(sm).notifyStyleChangeInChildren(styleProp, recursive);
                }
            }
            catch (error:Error)
            {
            }
            return;
        }// end function

        private function getHorizontalAlignValue() : Number
        {
            var _loc_1:* = getStyle("horizontalAlign");
            if (_loc_1 == "left")
            {
                return 0;
            }
            if (_loc_1 == "right")
            {
                return 1;
            }
            return 0.5;
        }// end function

        public function get source() : Object
        {
            return _source;
        }// end function

        public function get loadForCompatibility() : Boolean
        {
            return _loadForCompatibility;
        }// end function

        private function contentLoaderInfo_httpStatusEventHandler(event:HTTPStatusEvent) : void
        {
            dispatchEvent(event);
            return;
        }// end function

        public function get autoLoad() : Boolean
        {
            return _autoLoad;
        }// end function

        public function set source(param1:Object) : void
        {
            if (_source != param1)
            {
                _source = param1;
                contentChanged = true;
                invalidateProperties();
                invalidateSize();
                invalidateDisplayList();
                dispatchEvent(new Event("sourceChanged"));
            }
            return;
        }// end function

        public function set loaderContext(param1:LoaderContext) : void
        {
            _loaderContext = param1;
            explicitLoaderContext = true;
            dispatchEvent(new Event("loaderContextChanged"));
            return;
        }// end function

        private function get contentHolderWidth() : Number
        {
            var loaderInfo:LoaderInfo;
            var content:IFlexDisplayObject;
            var request:SWFBridgeRequest;
            var testContent:DisplayObject;
            if (contentHolder is Loader)
            {
                loaderInfo = Loader(contentHolder).contentLoaderInfo;
            }
            if (loaderInfo)
            {
                if (loaderInfo.contentType == "application/x-shockwave-flash")
                {
                    try
                    {
                        if (swfBridge)
                        {
                            request = new SWFBridgeRequest(SWFBridgeRequest.GET_SIZE_REQUEST);
                            swfBridge.dispatchEvent(request);
                            return request.data.width;
                        }
                        content = Loader(contentHolder).content as IFlexDisplayObject;
                        if (content)
                        {
                            return content.measuredWidth;
                        }
                    }
                    catch (error:Error)
                    {
                        return contentHolder.width;
                    }
                }
                else
                {
                    try
                    {
                        testContent = Loader(contentHolder).content;
                    }
                    catch (error:Error)
                    {
                        return contentHolder.width;
                    }
                }
                return loaderInfo.width;
            }
            if (contentHolder is IUIComponent)
            {
                return IUIComponent(contentHolder).getExplicitOrMeasuredWidth();
            }
            if (contentHolder is IFlexDisplayObject)
            {
                return IFlexDisplayObject(contentHolder).measuredWidth;
            }
            return contentHolder.width;
        }// end function

        public function get bytesLoaded() : Number
        {
            return _bytesLoaded;
        }// end function

        private function removeInitSystemManagerCompleteListener(param1:LoaderInfo) : void
        {
            var _loc_2:EventDispatcher = null;
            if (param1.contentType == "application/x-shockwave-flash")
            {
                _loc_2 = param1.sharedEvents;
                _loc_2.removeEventListener(SWFBridgeEvent.BRIDGE_NEW_APPLICATION, initSystemManagerCompleteEventHandler);
            }
            return;
        }// end function

        public function set loadForCompatibility(param1:Boolean) : void
        {
            if (_loadForCompatibility != param1)
            {
                _loadForCompatibility = param1;
                contentChanged = true;
                invalidateProperties();
                invalidateSize();
                invalidateDisplayList();
                dispatchEvent(new Event("loadForCompatibilityChanged"));
            }
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_1:Number = NaN;
            var _loc_2:Number = NaN;
            super.measure();
            if (isContentLoaded)
            {
                _loc_1 = contentHolder.scaleX;
                _loc_2 = contentHolder.scaleY;
                contentHolder.scaleX = 1;
                contentHolder.scaleY = 1;
                measuredWidth = contentHolderWidth;
                measuredHeight = contentHolderHeight;
                contentHolder.scaleX = _loc_1;
                contentHolder.scaleY = _loc_2;
            }
            else if (!_source || _source == "")
            {
                measuredWidth = 0;
                measuredHeight = 0;
            }
            return;
        }// end function

        private function contentLoaderInfo_initEventHandler(event:Event) : void
        {
            dispatchEvent(event);
            addInitSystemManagerCompleteListener(LoaderInfo(event.target).loader.contentLoaderInfo);
            return;
        }// end function

        public function set autoLoad(param1:Boolean) : void
        {
            if (_autoLoad != param1)
            {
                _autoLoad = param1;
                contentChanged = true;
                invalidateProperties();
                invalidateSize();
                invalidateDisplayList();
                dispatchEvent(new Event("autoLoadChanged"));
            }
            return;
        }// end function

        private function doScaleLoader() : void
        {
            if (!isContentLoaded)
            {
                return;
            }
            unScaleContent();
            var _loc_1:* = unscaledWidth;
            var _loc_2:* = unscaledHeight;
            if (contentHolderWidth > _loc_1 || contentHolderHeight > _loc_2 || !parentAllowsChild)
            {
                contentHolder.scrollRect = new Rectangle(0, 0, _loc_1, _loc_2);
            }
            else
            {
                contentHolder.scrollRect = null;
            }
            contentHolder.x = (_loc_1 - contentHolderWidth) * getHorizontalAlignValue();
            contentHolder.y = (_loc_2 - contentHolderHeight) * getVerticalAlignValue();
            return;
        }// end function

        private function getVerticalAlignValue() : Number
        {
            var _loc_1:* = getStyle("verticalAlign");
            if (_loc_1 == "top")
            {
                return 0;
            }
            if (_loc_1 == "bottom")
            {
                return 1;
            }
            return 0.5;
        }// end function

        public function get content() : DisplayObject
        {
            if (contentHolder is Loader)
            {
                return Loader(contentHolder).content;
            }
            return contentHolder;
        }// end function

        private function dispatchInvalidateRequest(param1:Boolean, param2:Boolean, param3:Boolean) : void
        {
            var _loc_4:* = systemManager;
            if (!systemManager.useSWFBridge())
            {
                return;
            }
            var _loc_5:* = _loc_4.swfBridgeGroup.parentBridge;
            var _loc_6:uint = 0;
            if (param1)
            {
                _loc_6 = _loc_6 | InvalidateRequestData.PROPERTIES;
            }
            if (param2)
            {
                _loc_6 = _loc_6 | InvalidateRequestData.SIZE;
            }
            if (param3)
            {
                _loc_6 = _loc_6 | InvalidateRequestData.DISPLAY_LIST;
            }
            var _loc_7:* = new SWFBridgeRequest(SWFBridgeRequest.INVALIDATE_REQUEST, false, false, _loc_5, _loc_6);
            _loc_5.dispatchEvent(_loc_7);
            return;
        }// end function

        public function getVisibleApplicationRect(param1:Boolean = false) : Rectangle
        {
            var _loc_2:* = getVisibleRect();
            if (param1)
            {
                _loc_2 = systemManager.getVisibleApplicationRect(_loc_2);
            }
            return _loc_2;
        }// end function

        public function unloadAndStop(param1:Boolean = true) : void
        {
            useUnloadAndStop = true;
            unloadAndStopGC = param1;
            source = null;
            return;
        }// end function

        private function contentLoaderInfo_progressEventHandler(event:ProgressEvent) : void
        {
            _bytesTotal = event.bytesTotal;
            _bytesLoaded = event.bytesLoaded;
            dispatchEvent(event);
            return;
        }// end function

        public function get showBusyCursor() : Boolean
        {
            return _showBusyCursor;
        }// end function

        override public function get baselinePosition() : Number
        {
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                return 0;
            }
            return super.baselinePosition;
        }// end function

        private function initSystemManagerCompleteEventHandler(event:Event) : void
        {
            var _loc_3:ISystemManager = null;
            var _loc_2:* = Object(event);
            if (contentHolder is Loader && _loc_2.data == Loader(contentHolder).contentLoaderInfo.sharedEvents)
            {
                _swfBridge = Loader(contentHolder).contentLoaderInfo.sharedEvents;
                _loc_3 = systemManager;
                _loc_3.addChildBridge(_swfBridge, this);
                removeInitSystemManagerCompleteListener(Loader(contentHolder).contentLoaderInfo);
                _swfBridge.addEventListener(SWFBridgeRequest.INVALIDATE_REQUEST, invalidateRequestHandler);
            }
            return;
        }// end function

        public function get bytesTotal() : Number
        {
            return _bytesTotal;
        }// end function

        private function initializeHandler(event:FlexEvent) : void
        {
            if (contentChanged)
            {
                contentChanged = false;
                if (_autoLoad)
                {
                    load(_source);
                }
            }
            return;
        }// end function

        private function contentLoaderInfo_unloadEventHandler(event:Event) : void
        {
            var _loc_2:ISystemManager = null;
            dispatchEvent(event);
            if (_swfBridge)
            {
                _swfBridge.removeEventListener(SWFBridgeRequest.INVALIDATE_REQUEST, invalidateRequestHandler);
                _loc_2 = systemManager;
                _loc_2.removeChildBridge(_swfBridge);
                _swfBridge = null;
            }
            if (contentHolder is Loader)
            {
                removeInitSystemManagerCompleteListener(Loader(contentHolder).contentLoaderInfo);
            }
            return;
        }// end function

        function contentLoaderInfo_completeEventHandler(event:Event) : void
        {
            if (LoaderInfo(event.target).loader != contentHolder)
            {
                return;
            }
            dispatchEvent(event);
            contentLoaded();
            if (contentHolder is Loader)
            {
                removeInitSystemManagerCompleteListener(Loader(contentHolder).contentLoaderInfo);
            }
            return;
        }// end function

        public function set scaleContent(param1:Boolean) : void
        {
            if (_scaleContent != param1)
            {
                _scaleContent = param1;
                scaleContentChanged = true;
                invalidateDisplayList();
            }
            dispatchEvent(new Event("scaleContentChanged"));
            return;
        }// end function

        private function contentLoaderInfo_openEventHandler(event:Event) : void
        {
            dispatchEvent(event);
            return;
        }// end function

        private function addedToStageHandler(event:Event) : void
        {
            systemManager.getSandboxRoot().addEventListener(InterManagerRequest.DRAG_MANAGER_REQUEST, mouseShieldHandler, false, 0, true);
            return;
        }// end function

        public function get percentLoaded() : Number
        {
            if (true)
            {
                isNaN(_bytesTotal);
            }
            var _loc_1:* = _bytesTotal == 0 ? (0) : (100 * (_bytesLoaded / _bytesTotal));
            if (isNaN(_loc_1))
            {
                _loc_1 = 0;
            }
            return _loc_1;
        }// end function

        public function get swfBridge() : IEventDispatcher
        {
            return _swfBridge;
        }// end function

        private function loadContent(param1:Object) : DisplayObject
        {
            var child:DisplayObject;
            var cls:Class;
            var url:String;
            var byteArray:ByteArray;
            var loader:Loader;
            var lc:LoaderContext;
            var rootURL:String;
            var lastIndex:int;
            var currentDomain:ApplicationDomain;
            var topmostDomain:ApplicationDomain;
            var message:String;
            var classOrString:* = param1;
            if (classOrString is Class)
            {
                cls = Class(classOrString);
            }
            else if (classOrString is String)
            {
                try
                {
                    cls = Class(systemManager.getDefinitionByName(String(classOrString)));
                }
                catch (e:Error)
                {
                }
                url = String(classOrString);
            }
            else if (classOrString is ByteArray)
            {
                byteArray = ByteArray(classOrString);
            }
            else
            {
                url = classOrString.toString();
            }
            if (cls)
            {
                var _loc_3:* = new cls;
                child = new cls;
                contentHolder = _loc_3;
                addChild(child);
                contentLoaded();
            }
            else if (classOrString is DisplayObject)
            {
                var _loc_3:* = DisplayObject(classOrString);
                child = DisplayObject(classOrString);
                contentHolder = _loc_3;
                addChild(child);
                contentLoaded();
            }
            else if (byteArray)
            {
                loader = new FlexLoader();
                child = loader;
                addChild(child);
                loader.contentLoaderInfo.addEventListener(Event.COMPLETE, contentLoaderInfo_completeEventHandler);
                loader.contentLoaderInfo.addEventListener(Event.INIT, contentLoaderInfo_initEventHandler);
                loader.contentLoaderInfo.addEventListener(Event.UNLOAD, contentLoaderInfo_unloadEventHandler);
                loader.loadBytes(byteArray, loaderContext);
            }
            else if (url)
            {
                loader = new FlexLoader();
                child = loader;
                addChild(loader);
                loader.contentLoaderInfo.addEventListener(Event.COMPLETE, contentLoaderInfo_completeEventHandler);
                loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, contentLoaderInfo_httpStatusEventHandler);
                loader.contentLoaderInfo.addEventListener(Event.INIT, contentLoaderInfo_initEventHandler);
                loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, contentLoaderInfo_ioErrorEventHandler);
                loader.contentLoaderInfo.addEventListener(Event.OPEN, contentLoaderInfo_openEventHandler);
                loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, contentLoaderInfo_progressEventHandler);
                loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, contentLoaderInfo_securityErrorEventHandler);
                loader.contentLoaderInfo.addEventListener(Event.UNLOAD, contentLoaderInfo_unloadEventHandler);
                if (Capabilities.isDebugger == true && url.indexOf(".jpg") == -1 && LoaderUtil.normalizeURL(Application.application.systemManager.loaderInfo).indexOf("debug=true") > -1)
                {
                    url = url + (url.indexOf("?") > -1 ? ("&debug=true") : ("?debug=true"));
                }
                if (!(url.indexOf(":") > -1 || url.indexOf("/") == 0 || url.indexOf("\\") == 0))
                {
                    if (SystemManagerGlobals.bootstrapLoaderInfoURL != null && SystemManagerGlobals.bootstrapLoaderInfoURL != "")
                    {
                        rootURL = SystemManagerGlobals.bootstrapLoaderInfoURL;
                    }
                    else if (root)
                    {
                        rootURL = LoaderUtil.normalizeURL(root.loaderInfo);
                    }
                    else if (systemManager)
                    {
                        rootURL = LoaderUtil.normalizeURL(DisplayObject(systemManager).loaderInfo);
                    }
                    if (rootURL)
                    {
                        lastIndex = Math.max(rootURL.lastIndexOf("\\"), rootURL.lastIndexOf("/"));
                        if (lastIndex != -1)
                        {
                            url = rootURL.substr(0, lastIndex + 1) + url;
                        }
                    }
                }
                requestedURL = new URLRequest(url);
                lc = loaderContext;
                if (!lc)
                {
                    lc = new LoaderContext();
                    _loaderContext = lc;
                    if (loadForCompatibility)
                    {
                        currentDomain = ApplicationDomain.currentDomain.parentDomain;
                        topmostDomain;
                        while (currentDomain)
                        {
                            
                            topmostDomain = currentDomain;
                            currentDomain = currentDomain.parentDomain;
                        }
                        lc.applicationDomain = new ApplicationDomain(topmostDomain);
                    }
                    if (trustContent)
                    {
                        lc.securityDomain = SecurityDomain.currentDomain;
                    }
                    else if (!loadForCompatibility)
                    {
                        attemptingChildAppDomain = true;
                        lc.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
                    }
                }
                loader.load(requestedURL, lc);
            }
            else
            {
                message = resourceManager.getString("controls", "notLoadable", [source]);
                throw new Error(message);
            }
            invalidateDisplayList();
            return child;
        }// end function

        public function get contentWidth() : Number
        {
            return contentHolder ? (contentHolder.width) : (NaN);
        }// end function

        public function get scaleContent() : Boolean
        {
            return _scaleContent;
        }// end function

        public function get childAllowsParent() : Boolean
        {
            if (!isContentLoaded)
            {
                return false;
            }
            if (contentHolder is Loader)
            {
                return Loader(contentHolder).contentLoaderInfo.childAllowsParent;
            }
            return true;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (contentChanged)
            {
                contentChanged = false;
                if (_autoLoad)
                {
                    load(_source);
                }
            }
            return;
        }// end function

        private function contentLoaderInfo_securityErrorEventHandler(event:SecurityErrorEvent) : void
        {
            var _loc_2:LoaderContext = null;
            if (attemptingChildAppDomain)
            {
                attemptingChildAppDomain = false;
                _loc_2 = new LoaderContext();
                _loaderContext = _loc_2;
                callLater(load);
                return;
            }
            dispatchEvent(event);
            if (contentHolder is Loader)
            {
                removeInitSystemManagerCompleteListener(Loader(contentHolder).contentLoaderInfo);
            }
            return;
        }// end function

        private function sizeShield() : void
        {
            if (mouseShield && mouseShield.parent)
            {
                mouseShield.width = unscaledWidth;
                mouseShield.height = unscaledHeight;
            }
            return;
        }// end function

        private function addInitSystemManagerCompleteListener(param1:LoaderInfo) : void
        {
            var _loc_2:EventDispatcher = null;
            if (param1.contentType == "application/x-shockwave-flash")
            {
                _loc_2 = param1.sharedEvents;
                _loc_2.addEventListener(SWFBridgeEvent.BRIDGE_NEW_APPLICATION, initSystemManagerCompleteEventHandler);
            }
            return;
        }// end function

        private function invalidateRequestHandler(event:Event) : void
        {
            if (event is SWFBridgeRequest)
            {
                return;
            }
            var _loc_2:* = SWFBridgeRequest.marshal(event);
            var _loc_3:* = uint(_loc_2.data);
            if (_loc_3 & InvalidateRequestData.PROPERTIES)
            {
                invalidateProperties();
            }
            if (_loc_3 & InvalidateRequestData.SIZE)
            {
                invalidateSize();
            }
            if (_loc_3 & InvalidateRequestData.DISPLAY_LIST)
            {
                invalidateDisplayList();
            }
            dispatchInvalidateRequest((_loc_3 & InvalidateRequestData.PROPERTIES) != 0, (_loc_3 & InvalidateRequestData.SIZE) != 0, (_loc_3 & InvalidateRequestData.DISPLAY_LIST) != 0);
            return;
        }// end function

        private function contentLoaded() : void
        {
            var loaderInfo:LoaderInfo;
            isContentLoaded = true;
            if (contentHolder is Loader)
            {
                loaderInfo = Loader(contentHolder).contentLoaderInfo;
            }
            resizableContent = false;
            if (loaderInfo)
            {
                if (loaderInfo.contentType == "application/x-shockwave-flash")
                {
                    resizableContent = true;
                }
                if (resizableContent)
                {
                    try
                    {
                        if (Loader(contentHolder).content is IFlexDisplayObject)
                        {
                            flexContent = true;
                        }
                        else
                        {
                            flexContent = swfBridge != null;
                        }
                    }
                    catch (e:Error)
                    {
                        flexContent = swfBridge != null;
                    }
                }
                try
                {
                }
                if (tabChildren && contentHolder is Loader && loaderInfo.contentType == "application/x-shockwave-flash" || Loader(contentHolder).content is DisplayObjectContainer)
                {
                    Loader(contentHolder).tabChildren = true;
                    DisplayObjectContainer(Loader(contentHolder).content).tabChildren = true;
                }
            }
            catch (e:Error)
            {
            }
            invalidateSize();
            invalidateDisplayList();
            return;
        }// end function

        private function getContentSize() : Point
        {
            var _loc_3:IEventDispatcher = null;
            var _loc_4:SWFBridgeRequest = null;
            var _loc_1:* = new Point();
            if (!contentHolder is Loader)
            {
                return _loc_1;
            }
            var _loc_2:* = Loader(contentHolder);
            if (_loc_2.contentLoaderInfo.childAllowsParent)
            {
                _loc_1.x = _loc_2.content.width;
                _loc_1.y = _loc_2.content.height;
            }
            else
            {
                _loc_3 = swfBridge;
                if (_loc_3)
                {
                    _loc_4 = new SWFBridgeRequest(SWFBridgeRequest.GET_SIZE_REQUEST);
                    _loc_3.dispatchEvent(_loc_4);
                    _loc_1.x = _loc_4.data.width;
                    _loc_1.y = _loc_4.data.height;
                }
            }
            if (_loc_1.x == 0)
            {
                _loc_1.x = _loc_2.contentLoaderInfo.width;
            }
            if (_loc_1.y == 0)
            {
                _loc_1.y = _loc_2.contentLoaderInfo.height;
            }
            return _loc_1;
        }// end function

        public function load(param1:Object = null) : void
        {
            var imageData:Bitmap;
            var request:SWFBridgeEvent;
            var url:* = param1;
            if (url)
            {
                _source = url;
            }
            if (contentHolder)
            {
                if (isContentLoaded)
                {
                    if (contentHolder is Loader)
                    {
                        try
                        {
                            if (Loader(contentHolder).content is Bitmap)
                            {
                                imageData = Bitmap(Loader(contentHolder).content);
                                if (imageData.bitmapData)
                                {
                                    imageData.bitmapData = null;
                                }
                            }
                        }
                        catch (error:Error)
                        {
                        }
                        if (_swfBridge)
                        {
                            request = new SWFBridgeEvent(SWFBridgeEvent.BRIDGE_APPLICATION_UNLOADING, false, false, _swfBridge);
                            _swfBridge.dispatchEvent(request);
                        }
                        if (useUnloadAndStop && "unloadAndStop" in contentHolder)
                        {
                            var _loc_3:* = contentHolder;
                            _loc_3.contentHolder["unloadAndStop"](unloadAndStopGC);
                        }
                        else
                        {
                            Loader(contentHolder).unload();
                        }
                        if (!explicitLoaderContext)
                        {
                            _loaderContext = null;
                        }
                    }
                    else if (contentHolder is Bitmap)
                    {
                        imageData = Bitmap(contentHolder);
                        if (imageData.bitmapData)
                        {
                            imageData.bitmapData = null;
                        }
                    }
                }
                else if (contentHolder is Loader)
                {
                    try
                    {
                        Loader(contentHolder).close();
                    }
                    catch (error:Error)
                    {
                    }
                    try
                    {
                    }
                    if (contentHolder.parent == this)
                    {
                        removeChild(contentHolder);
                    }
                }
                catch (error:Error)
                {
                    try
                    {
                        removeChild(contentHolder);
                    }
                    catch (error1:Error)
                    {
                    }
                    contentHolder = null;
                }
                isContentLoaded = false;
                brokenImage = false;
                useUnloadAndStop = false;
                if (!_source || _source == "")
                {
                    return;
                }
                contentHolder = loadContent(_source);
                return;
        }// end function

        public function get parentAllowsChild() : Boolean
        {
            if (!isContentLoaded)
            {
                return false;
            }
            if (contentHolder is Loader)
            {
                return Loader(contentHolder).contentLoaderInfo.parentAllowsChild;
            }
            return true;
        }// end function

        private function contentLoaderInfo_ioErrorEventHandler(event:IOErrorEvent) : void
        {
            source = getStyle("brokenImageSkin");
            load();
            contentChanged = false;
            brokenImage = true;
            if (hasEventListener(event.type))
            {
                dispatchEvent(event);
            }
            if (contentHolder is Loader)
            {
                removeInitSystemManagerCompleteListener(Loader(contentHolder).contentLoaderInfo);
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_3:Class = null;
            super.updateDisplayList(param1, param2);
            if (contentChanged)
            {
                contentChanged = false;
                if (_autoLoad)
                {
                    load(_source);
                }
            }
            if (isContentLoaded)
            {
                if (_scaleContent && !brokenImage)
                {
                    doScaleContent();
                }
                else
                {
                    doScaleLoader();
                }
                scaleContentChanged = false;
            }
            if (brokenImage && !brokenImageBorder)
            {
                _loc_3 = getStyle("brokenImageBorderSkin");
                if (_loc_3)
                {
                    brokenImageBorder = IFlexDisplayObject(new _loc_3);
                    if (brokenImageBorder is ISimpleStyleClient)
                    {
                        ISimpleStyleClient(brokenImageBorder).styleName = this;
                    }
                    addChild(DisplayObject(brokenImageBorder));
                }
            }
            else if (!brokenImage && brokenImageBorder)
            {
                removeChild(DisplayObject(brokenImageBorder));
                brokenImageBorder = null;
            }
            if (brokenImageBorder)
            {
                brokenImageBorder.setActualSize(param1, param2);
            }
            sizeShield();
            return;
        }// end function

        private function doScaleContent() : void
        {
            var interiorWidth:Number;
            var interiorHeight:Number;
            var contentWidth:Number;
            var contentHeight:Number;
            var x:Number;
            var y:Number;
            var newXScale:Number;
            var newYScale:Number;
            var scale:Number;
            var w:Number;
            var h:Number;
            var holder:Loader;
            var sizeSet:Boolean;
            var lInfo:LoaderInfo;
            if (!isContentLoaded)
            {
                return;
            }
            if (!resizableContent || maintainAspectRatio && !flexContent)
            {
                unScaleContent();
                interiorWidth = unscaledWidth;
                interiorHeight = unscaledHeight;
                contentWidth = contentHolderWidth;
                contentHeight = contentHolderHeight;
                x;
                y;
                newXScale = contentWidth == 0 ? (1) : (interiorWidth / contentWidth);
                newYScale = contentHeight == 0 ? (1) : (interiorHeight / contentHeight);
                if (_maintainAspectRatio)
                {
                    if (newXScale > newYScale)
                    {
                        x = Math.floor((interiorWidth - contentWidth * newYScale) * getHorizontalAlignValue());
                        scale = newYScale;
                    }
                    else
                    {
                        y = Math.floor((interiorHeight - contentHeight * newXScale) * getVerticalAlignValue());
                        scale = newXScale;
                    }
                    contentHolder.scaleX = scale;
                    contentHolder.scaleY = scale;
                }
                else
                {
                    contentHolder.scaleX = newXScale;
                    contentHolder.scaleY = newYScale;
                }
                contentHolder.x = x;
                contentHolder.y = y;
            }
            else
            {
                contentHolder.x = 0;
                contentHolder.y = 0;
                w = unscaledWidth;
                h = unscaledHeight;
                if (contentHolder is Loader)
                {
                    holder = Loader(contentHolder);
                    try
                    {
                        if (getContentSize().x > 0)
                        {
                            sizeSet;
                            if (holder.contentLoaderInfo.contentType == "application/x-shockwave-flash")
                            {
                                if (childAllowsParent)
                                {
                                    if (holder.content is IFlexDisplayObject)
                                    {
                                        IFlexDisplayObject(holder.content).setActualSize(w, h);
                                        sizeSet;
                                    }
                                }
                                if (!sizeSet)
                                {
                                    if (swfBridge)
                                    {
                                        swfBridge.dispatchEvent(new SWFBridgeRequest(SWFBridgeRequest.SET_ACTUAL_SIZE_REQUEST, false, false, null, {width:w, height:h}));
                                        sizeSet;
                                    }
                                }
                            }
                            else
                            {
                                lInfo = holder.contentLoaderInfo;
                                if (lInfo)
                                {
                                    contentHolder.scaleX = w / lInfo.width;
                                    contentHolder.scaleY = h / lInfo.height;
                                    sizeSet;
                                }
                            }
                            if (!sizeSet)
                            {
                                contentHolder.width = w;
                                contentHolder.height = h;
                            }
                        }
                        else if (childAllowsParent && !(holder.content is IFlexDisplayObject))
                        {
                            contentHolder.width = w;
                            contentHolder.height = h;
                        }
                    }
                    catch (error:Error)
                    {
                        contentHolder.width = w;
                        contentHolder.height = h;
                    }
                    if (!parentAllowsChild)
                    {
                        contentHolder.scrollRect = new Rectangle(0, 0, w / contentHolder.scaleX, h / contentHolder.scaleY);
                    }
                }
                else
                {
                    contentHolder.width = w;
                    contentHolder.height = h;
                }
            }
            return;
        }// end function

        private function mouseShieldHandler(event:Event) : void
        {
            if (event["name"] != "mouseShield")
            {
                return;
            }
            if (parentAllowsChild)
            {
                return;
            }
            if (event["value"])
            {
                if (!mouseShield)
                {
                    mouseShield = new Sprite();
                    mouseShield.graphics.beginFill(0, 0);
                    mouseShield.graphics.drawRect(0, 0, 100, 100);
                    mouseShield.graphics.endFill();
                }
                if (!mouseShield.parent)
                {
                    addChild(mouseShield);
                }
                sizeShield();
            }
            else if (mouseShield && mouseShield.parent)
            {
                removeChild(mouseShield);
            }
            return;
        }// end function

    }
}
