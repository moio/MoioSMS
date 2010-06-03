package mx.controls
{
    import flash.events.*;
    import flash.html.*;
    import flash.net.*;
    import flash.system.*;
    import mx.controls.listClasses.*;
    import mx.core.*;
    import mx.events.*;

    public class HTML extends ScrollControlBase implements IDataRenderer, IDropInListItemRenderer, IListItemRenderer, IFocusManagerComponent
    {
        private var _data:Object;
        private var _userAgent:String;
        private var _htmlLoaderFactory:IFactory;
        private var _location:String;
        private var _runtimeApplicationDomain:ApplicationDomain;
        private var htmlTextChanged:Boolean = false;
        public var htmlLoader:HTMLLoader;
        private var _paintsDefaultBackground:Boolean;
        private var locationChanged:Boolean = false;
        private var htmlHostChanged:Boolean = false;
        private var _listData:BaseListData;
        private var _htmlText:String;
        private var _htmlHost:HTMLHost;
        private var paintsDefaultBackgroundChanged:Boolean = false;
        private var userAgentChanged:Boolean = false;
        private var runtimeApplicationDomainChanged:Boolean = false;
        private var textSet:Boolean;
        private static const MAX_HTML_HEIGHT:Number = 2880;
        static const VERSION:String = "3.2.0.3958";
        private static const MAX_HTML_WIDTH:Number = 2880;

        public function HTML()
        {
            _htmlLoaderFactory = new ClassFactory(FlexHTMLLoader);
            mx_internal::_horizontalScrollPolicy = ScrollPolicy.AUTO;
            mx_internal::_verticalScrollPolicy = ScrollPolicy.AUTO;
            tabEnabled = false;
            tabChildren = true;
            return;
        }// end function

        public function get contentHeight() : Number
        {
            if (!htmlLoader)
            {
                return 0;
            }
            return htmlLoader.contentHeight;
        }// end function

        public function get userAgent() : String
        {
            return _userAgent;
        }// end function

        public function set userAgent(param1:String) : void
        {
            _userAgent = param1;
            userAgentChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function get loaded() : Boolean
        {
            if (!htmlLoader || locationChanged || htmlTextChanged)
            {
                return false;
            }
            return htmlLoader.loaded;
        }// end function

        public function cancelLoad() : void
        {
            if (htmlLoader)
            {
                htmlLoader.cancelLoad();
            }
            return;
        }// end function

        private function htmlLoader_htmlRenderHandler(event:Event) : void
        {
            dispatchEvent(event);
            adjustScrollBars();
            return;
        }// end function

        public function get htmlLoaderFactory() : IFactory
        {
            return _htmlLoaderFactory;
        }// end function

        public function historyForward() : void
        {
            if (htmlLoader)
            {
                htmlLoader.historyForward();
            }
            return;
        }// end function

        public function set htmlLoaderFactory(param1:IFactory) : void
        {
            _htmlLoaderFactory = param1;
            dispatchEvent(new Event("htmlLoaderFactoryChanged"));
            return;
        }// end function

        public function get historyLength() : int
        {
            if (!htmlLoader)
            {
                return 0;
            }
            return htmlLoader.historyLength;
        }// end function

        public function reload() : void
        {
            if (htmlLoader)
            {
                htmlLoader.reload();
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            if (!htmlLoader)
            {
                htmlLoader = htmlLoaderFactory.newInstance();
                htmlLoader.addEventListener(Event.HTML_DOM_INITIALIZE, htmlLoader_domInitialize);
                htmlLoader.addEventListener(Event.COMPLETE, htmlLoader_completeHandler);
                htmlLoader.addEventListener(Event.HTML_RENDER, htmlLoader_htmlRenderHandler);
                htmlLoader.addEventListener(Event.LOCATION_CHANGE, htmlLoader_locationChangeHandler);
                htmlLoader.addEventListener(Event.HTML_BOUNDS_CHANGE, htmlLoader_htmlBoundsChangeHandler);
                htmlLoader.addEventListener(Event.SCROLL, htmlLoader_scrollHandler);
                htmlLoader.addEventListener(HTMLUncaughtScriptExceptionEvent.UNCAUGHT_SCRIPT_EXCEPTION, htmlLoader_uncaughtScriptExceptionHandler);
                addChild(htmlLoader);
            }
            return;
        }// end function

        public function historyGo(param1:int) : void
        {
            if (htmlLoader)
            {
                htmlLoader.historyGo(param1);
            }
            return;
        }// end function

        private function htmlLoader_domInitialize(event:Event) : void
        {
            dispatchEvent(event);
            return;
        }// end function

        private function adjustScrollBars() : void
        {
            setScrollBarProperties(htmlLoader.contentWidth, htmlLoader.width, htmlLoader.contentHeight, htmlLoader.height);
            if (verticalScrollBar)
            {
                verticalScrollBar.lineScrollSize = 20;
            }
            if (horizontalScrollBar)
            {
                horizontalScrollBar.lineScrollSize = 20;
            }
            return;
        }// end function

        public function get data() : Object
        {
            return _data;
        }// end function

        public function get location() : String
        {
            return _location;
        }// end function

        private function htmlLoader_completeHandler(event:Event) : void
        {
            invalidateSize();
            dispatchEvent(event);
            return;
        }// end function

        public function set historyPosition(param1:int) : void
        {
            if (htmlLoader)
            {
                htmlLoader.historyPosition = param1;
            }
            return;
        }// end function

        public function getHistoryAt(param1:int) : HTMLHistoryItem
        {
            if (!htmlLoader)
            {
                return null;
            }
            return htmlLoader.getHistoryAt(param1);
        }// end function

        public function get runtimeApplicationDomain() : ApplicationDomain
        {
            return _runtimeApplicationDomain;
        }// end function

        override protected function scrollHandler(event:Event) : void
        {
            super.scrollHandler(event);
            htmlLoader.scrollH = horizontalScrollPosition;
            htmlLoader.scrollV = verticalScrollPosition;
            return;
        }// end function

        public function historyBack() : void
        {
            if (htmlLoader)
            {
                htmlLoader.historyBack();
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (htmlHostChanged)
            {
                htmlLoader.htmlHost = _htmlHost;
                htmlHostChanged = false;
            }
            if (paintsDefaultBackgroundChanged)
            {
                htmlLoader.paintsDefaultBackground = _paintsDefaultBackground;
                paintsDefaultBackgroundChanged = false;
            }
            if (runtimeApplicationDomainChanged)
            {
                htmlLoader.runtimeApplicationDomain = _runtimeApplicationDomain;
                runtimeApplicationDomainChanged = false;
            }
            if (userAgentChanged)
            {
                htmlLoader.userAgent = _userAgent;
                userAgentChanged = false;
            }
            if (locationChanged)
            {
                htmlLoader.load(new URLRequest(_location));
                locationChanged = false;
            }
            if (htmlTextChanged)
            {
                htmlLoader.loadString(_htmlText);
                htmlTextChanged = false;
            }
            return;
        }// end function

        public function get contentWidth() : Number
        {
            if (!htmlLoader)
            {
                return 0;
            }
            return htmlLoader.contentWidth;
        }// end function

        public function get domWindow() : Object
        {
            if (!htmlLoader)
            {
                return null;
            }
            return htmlLoader.window;
        }// end function

        override protected function mouseWheelHandler(event:MouseEvent) : void
        {
            if (event.target != this)
            {
                return;
            }
            event.delta = event.delta * 6;
            super.mouseWheelHandler(event);
            return;
        }// end function

        override public function set verticalScrollPosition(param1:Number) : void
        {
            param1 = Math.max(param1, 0);
            if (htmlLoader && htmlLoader.contentHeight > htmlLoader.height)
            {
                param1 = Math.min(param1, htmlLoader.contentHeight - htmlLoader.height);
            }
            super.verticalScrollPosition = param1;
            if (htmlLoader)
            {
                htmlLoader.scrollV = param1;
            }
            else
            {
                invalidateProperties();
            }
            return;
        }// end function

        public function set data(param1:Object) : void
        {
            var _loc_2:* = undefined;
            _data = param1;
            if (_listData)
            {
                _loc_2 = _listData.label;
            }
            else if (_data != null)
            {
                if (_data is String)
                {
                    _loc_2 = String(_data);
                }
                else
                {
                    _loc_2 = _data.toString();
                }
            }
            if (_loc_2 !== undefined && !textSet)
            {
                htmlText = _loc_2;
                textSet = false;
            }
            dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
            return;
        }// end function

        private function htmlLoader_scrollHandler(event:Event) : void
        {
            horizontalScrollPosition = htmlLoader.scrollH;
            verticalScrollPosition = htmlLoader.scrollV;
            return;
        }// end function

        public function get historyPosition() : int
        {
            if (!htmlLoader)
            {
                return 0;
            }
            return htmlLoader.historyPosition;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            var _loc_1:* = viewMetrics;
            _loc_1.left = _loc_1.left + getStyle("paddingLeft");
            _loc_1.top = _loc_1.top + getStyle("paddingTop");
            _loc_1.right = _loc_1.right + getStyle("paddingRight");
            _loc_1.bottom = _loc_1.bottom + getStyle("paddingBottom");
            measuredWidth = Math.min(htmlLoader.contentWidth + _loc_1.left + _loc_1.right, MAX_HTML_WIDTH);
            measuredHeight = Math.min(htmlLoader.contentHeight + _loc_1.top + _loc_1.bottom, MAX_HTML_HEIGHT);
            return;
        }// end function

        public function set listData(param1:BaseListData) : void
        {
            _listData = param1;
            return;
        }// end function

        private function htmlLoader_uncaughtScriptExceptionHandler(event:HTMLUncaughtScriptExceptionEvent) : void
        {
            var _loc_2:* = event.clone();
            dispatchEvent(_loc_2);
            if (_loc_2.isDefaultPrevented())
            {
                event.preventDefault();
            }
            return;
        }// end function

        private function htmlLoader_locationChangeHandler(event:Event) : void
        {
            var _loc_2:* = _location != htmlLoader.location;
            _location = htmlLoader.location;
            if (_loc_2)
            {
                dispatchEvent(event);
            }
            return;
        }// end function

        public function set htmlHost(param1:HTMLHost) : void
        {
            _htmlHost = param1;
            htmlHostChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function get listData() : BaseListData
        {
            return _listData;
        }// end function

        public function set htmlText(param1:String) : void
        {
            _htmlText = param1;
            htmlTextChanged = true;
            _location = null;
            locationChanged = false;
            invalidateProperties();
            invalidateSize();
            invalidateDisplayList();
            dispatchEvent(new Event("htmlTextChanged"));
            return;
        }// end function

        public function set location(param1:String) : void
        {
            _location = param1;
            locationChanged = true;
            _htmlText = null;
            htmlTextChanged = false;
            invalidateProperties();
            invalidateSize();
            invalidateDisplayList();
            dispatchEvent(new Event("locationChange"));
            return;
        }// end function

        public function get htmlHost() : HTMLHost
        {
            return _htmlHost;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = viewMetrics;
            _loc_3.left = _loc_3.left + getStyle("paddingLeft");
            _loc_3.top = _loc_3.top + getStyle("paddingTop");
            _loc_3.right = _loc_3.right + getStyle("paddingRight");
            _loc_3.bottom = _loc_3.bottom + getStyle("paddingBottom");
            htmlLoader.x = _loc_3.left;
            htmlLoader.y = _loc_3.top;
            var _loc_4:* = Math.max(param1 - _loc_3.left - _loc_3.right, 1);
            var _loc_5:* = Math.max(param2 - _loc_3.top - _loc_3.bottom, 1);
            htmlLoader.width = _loc_4;
            htmlLoader.height = _loc_5;
            return;
        }// end function

        public function get htmlText() : String
        {
            return _htmlText;
        }// end function

        private function htmlLoader_htmlBoundsChangeHandler(event:Event) : void
        {
            invalidateSize();
            adjustScrollBars();
            return;
        }// end function

        public function get paintsDefaultBackground() : Boolean
        {
            return _paintsDefaultBackground;
        }// end function

        public function set paintsDefaultBackground(param1:Boolean) : void
        {
            _paintsDefaultBackground = param1;
            paintsDefaultBackgroundChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function set runtimeApplicationDomain(param1:ApplicationDomain) : void
        {
            _runtimeApplicationDomain = param1;
            runtimeApplicationDomainChanged = true;
            invalidateProperties();
            return;
        }// end function

        public static function get pdfCapability() : int
        {
            return HTMLLoader.pdfCapability;
        }// end function

    }
}
