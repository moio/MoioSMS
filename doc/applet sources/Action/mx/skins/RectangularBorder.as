package mx.skins
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    import mx.core.*;
    import mx.resources.*;
    import mx.styles.*;

    public class RectangularBorder extends Border implements IRectangularBorder
    {
        private var backgroundImage:DisplayObject;
        private var backgroundImageHeight:Number;
        private var _backgroundImageBounds:Rectangle;
        private var backgroundImageStyle:Object;
        private var backgroundImageWidth:Number;
        private var resourceManager:IResourceManager;
        static const VERSION:String = "3.2.0.3958";

        public function RectangularBorder()
        {
            resourceManager = ResourceManager.getInstance();
            addEventListener(Event.REMOVED, removedHandler);
            return;
        }// end function

        public function layoutBackgroundImage() : void
        {
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_7:Number = NaN;
            var _loc_8:Number = NaN;
            var _loc_14:Number = NaN;
            var _loc_15:Graphics = null;
            var _loc_1:* = parent;
            var _loc_2:* = _loc_1 is IContainer ? (IContainer(_loc_1).viewMetrics) : (borderMetrics);
            var _loc_3:* = getStyle("backgroundAttachment") != "fixed";
            if (_backgroundImageBounds)
            {
                _loc_4 = _backgroundImageBounds.width;
                _loc_5 = _backgroundImageBounds.height;
            }
            else
            {
                _loc_4 = width - _loc_2.left - _loc_2.right;
                _loc_5 = height - _loc_2.top - _loc_2.bottom;
            }
            var _loc_6:* = getBackgroundSize();
            if (isNaN(_loc_6))
            {
                _loc_7 = 1;
                _loc_8 = 1;
            }
            else
            {
                _loc_14 = _loc_6 * 0.01;
                _loc_7 = _loc_14 * _loc_4 / backgroundImageWidth;
                _loc_8 = _loc_14 * _loc_5 / backgroundImageHeight;
            }
            backgroundImage.scaleX = _loc_7;
            backgroundImage.scaleY = _loc_8;
            var _loc_9:* = Math.round(0.5 * (_loc_4 - backgroundImageWidth * _loc_7));
            var _loc_10:* = Math.round(0.5 * (_loc_5 - backgroundImageHeight * _loc_8));
            backgroundImage.x = _loc_2.left;
            backgroundImage.y = _loc_2.top;
            var _loc_11:* = Shape(backgroundImage.mask);
            Shape(backgroundImage.mask).x = _loc_2.left;
            _loc_11.y = _loc_2.top;
            if (_loc_3 && _loc_1 is IContainer)
            {
                _loc_9 = _loc_9 - IContainer(_loc_1).horizontalScrollPosition;
                _loc_10 = _loc_10 - IContainer(_loc_1).verticalScrollPosition;
            }
            backgroundImage.alpha = getStyle("backgroundAlpha");
            backgroundImage.x = backgroundImage.x + _loc_9;
            backgroundImage.y = backgroundImage.y + _loc_10;
            var _loc_12:* = width - _loc_2.left - _loc_2.right;
            var _loc_13:* = height - _loc_2.top - _loc_2.bottom;
            if (_loc_11.width != _loc_12 || _loc_11.height != _loc_13)
            {
                _loc_15 = _loc_11.graphics;
                _loc_15.clear();
                _loc_15.beginFill(16777215);
                _loc_15.drawRect(0, 0, _loc_12, _loc_13);
                _loc_15.endFill();
            }
            return;
        }// end function

        public function set backgroundImageBounds(param1:Rectangle) : void
        {
            _backgroundImageBounds = param1;
            invalidateDisplayList();
            return;
        }// end function

        private function getBackgroundSize() : Number
        {
            var _loc_3:int = 0;
            var _loc_1:* = NaN;
            var _loc_2:* = getStyle("backgroundSize");
            if (_loc_2 && _loc_2 is String)
            {
                _loc_3 = _loc_2.indexOf("%");
                if (_loc_3 != -1)
                {
                    _loc_1 = Number(_loc_2.substr(0, _loc_3));
                }
            }
            return _loc_1;
        }// end function

        private function removedHandler(event:Event) : void
        {
            var _loc_2:IChildList = null;
            if (backgroundImage)
            {
                _loc_2 = parent is IRawChildrenContainer ? (IRawChildrenContainer(parent).rawChildren) : (IChildList(parent));
                _loc_2.removeChild(backgroundImage.mask);
                _loc_2.removeChild(backgroundImage);
                backgroundImage = null;
            }
            return;
        }// end function

        private function initBackgroundImage(param1:DisplayObject) : void
        {
            backgroundImage = param1;
            if (param1 is Loader)
            {
                backgroundImageWidth = Loader(param1).contentLoaderInfo.width;
                backgroundImageHeight = Loader(param1).contentLoaderInfo.height;
            }
            else
            {
                backgroundImageWidth = backgroundImage.width;
                backgroundImageHeight = backgroundImage.height;
                if (param1 is ISimpleStyleClient)
                {
                    ISimpleStyleClient(param1).styleName = styleName;
                }
            }
            var _loc_2:* = parent is IRawChildrenContainer ? (IRawChildrenContainer(parent).rawChildren) : (IChildList(parent));
            var _loc_3:* = new FlexShape();
            _loc_3.name = "backgroundMask";
            _loc_3.x = 0;
            _loc_3.y = 0;
            _loc_2.addChild(_loc_3);
            var _loc_4:* = _loc_2.getChildIndex(this);
            _loc_2.addChildAt(backgroundImage, _loc_4 + 1);
            backgroundImage.mask = _loc_3;
            return;
        }// end function

        public function get backgroundImageBounds() : Rectangle
        {
            return _backgroundImageBounds;
        }// end function

        public function get hasBackgroundImage() : Boolean
        {
            return backgroundImage != null;
        }// end function

        private function completeEventHandler(event:Event) : void
        {
            if (!parent)
            {
                return;
            }
            var _loc_2:* = DisplayObject(LoaderInfo(event.target).loader);
            initBackgroundImage(_loc_2);
            layoutBackgroundImage();
            dispatchEvent(event.clone());
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var cls:Class;
            var newStyleObj:DisplayObject;
            var loader:Loader;
            var loaderContext:LoaderContext;
            var message:String;
            var unscaledWidth:* = param1;
            var unscaledHeight:* = param2;
            if (!parent)
            {
                return;
            }
            var newStyle:* = getStyle("backgroundImage");
            if (newStyle != backgroundImageStyle)
            {
                removedHandler(null);
                backgroundImageStyle = newStyle;
                if (newStyle && newStyle as Class)
                {
                    cls = Class(newStyle);
                    initBackgroundImage(new cls);
                }
                else if (newStyle && newStyle is String)
                {
                    try
                    {
                        cls = Class(getDefinitionByName(String(newStyle)));
                    }
                    catch (e:Error)
                    {
                    }
                    if (cls)
                    {
                        newStyleObj = new cls;
                        initBackgroundImage(newStyleObj);
                    }
                    else
                    {
                        loader = new FlexLoader();
                        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeEventHandler);
                        loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorEventHandler);
                        loader.contentLoaderInfo.addEventListener(ErrorEvent.ERROR, errorEventHandler);
                        loaderContext = new LoaderContext();
                        loaderContext.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
                        loader.load(new URLRequest(String(newStyle)), loaderContext);
                    }
                }
                else if (newStyle)
                {
                    message = resourceManager.getString("skins", "notLoaded", [newStyle]);
                    throw new Error(message);
                }
            }
            if (backgroundImage)
            {
                layoutBackgroundImage();
            }
            return;
        }// end function

        private function errorEventHandler(event:Event) : void
        {
            return;
        }// end function

    }
}
