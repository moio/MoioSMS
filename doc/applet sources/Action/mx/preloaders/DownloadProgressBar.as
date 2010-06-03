package mx.preloaders
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import flash.utils.*;
    import mx.events.*;
    import mx.graphics.*;

    public class DownloadProgressBar extends Sprite implements IPreloaderDisplay
    {
        protected var MINIMUM_DISPLAY_TIME:uint = 0;
        private var _barFrameRect:RoundedRectangle;
        private var _stageHeight:Number = 375;
        private var _stageWidth:Number = 500;
        private var _percentRect:Rectangle;
        private var _percentObj:TextField;
        private var _downloadingLabel:String = "Loading";
        private var _showProgressBar:Boolean = true;
        private var _yOffset:Number = 20;
        private var _initProgressCount:uint = 0;
        private var _barSprite:Sprite;
        private var _visible:Boolean = false;
        private var _barRect:RoundedRectangle;
        private var _showingDisplay:Boolean = false;
        private var _backgroundSize:String = "";
        private var _initProgressTotal:uint = 12;
        private var _startedInit:Boolean = false;
        private var _showLabel:Boolean = true;
        private var _value:Number = 0;
        private var _labelRect:Rectangle;
        private var _backgroundImage:Object;
        private var _backgroundAlpha:Number = 1;
        private var _backgroundColor:uint;
        private var _startedLoading:Boolean = false;
        private var _showPercentage:Boolean = false;
        private var _barFrameSprite:Sprite;
        protected var DOWNLOAD_PERCENTAGE:uint = 60;
        private var _displayStartCount:uint = 0;
        private var _labelObj:TextField;
        private var _borderRect:RoundedRectangle;
        private var _maximum:Number = 0;
        private var _displayTime:int;
        private var _label:String = "";
        private var _preloader:Sprite;
        private var _xOffset:Number = 20;
        private var _startTime:int;
        static const VERSION:String = "3.2.0.3958";
        private static var _initializingLabel:String = "Initializing";

        public function DownloadProgressBar()
        {
            _labelRect = labelRect;
            _percentRect = percentRect;
            _borderRect = borderRect;
            _barFrameRect = barFrameRect;
            _barRect = barRect;
            return;
        }// end function

        protected function getPercentLoaded(param1:Number, param2:Number) : Number
        {
            var _loc_3:Number = NaN;
            if (param1 == 0 || param2 == 0 || isNaN(param2) || isNaN(param1))
            {
                return 0;
            }
            _loc_3 = 100 * param1 / param2;
            if (isNaN(_loc_3) || _loc_3 <= 0)
            {
                return 0;
            }
            if (_loc_3 > 99)
            {
                return 99;
            }
            return Math.round(_loc_3);
        }// end function

        protected function get labelFormat() : TextFormat
        {
            var _loc_1:* = new TextFormat();
            _loc_1.color = 3355443;
            _loc_1.font = "Verdana";
            _loc_1.size = 10;
            return _loc_1;
        }// end function

        private function calcScale() : void
        {
            var _loc_1:Number = NaN;
            if (stageWidth < 160 || stageHeight < 120)
            {
                scaleX = 1;
                scaleY = 1;
            }
            else if (stageWidth < 240 || stageHeight < 150)
            {
                createChildren();
                _loc_1 = Math.min(stageWidth / 240, stageHeight / 150);
                scaleX = _loc_1;
                scaleY = _loc_1;
            }
            else
            {
                createChildren();
            }
            return;
        }// end function

        protected function get percentRect() : Rectangle
        {
            return new Rectangle(108, 4, 34, 16);
        }// end function

        protected function set showLabel(param1:Boolean) : void
        {
            _showLabel = param1;
            draw();
            return;
        }// end function

        private function calcBackgroundSize() : Number
        {
            var _loc_2:int = 0;
            var _loc_1:* = NaN;
            if (backgroundSize)
            {
                _loc_2 = backgroundSize.indexOf("%");
                if (_loc_2 != -1)
                {
                    _loc_1 = Number(backgroundSize.substr(0, _loc_2));
                }
            }
            return _loc_1;
        }// end function

        private function show() : void
        {
            _showingDisplay = true;
            calcScale();
            draw();
            _displayTime = getTimer();
            return;
        }// end function

        private function loadBackgroundImage(param1:Object) : void
        {
            var cls:Class;
            var newStyleObj:DisplayObject;
            var loader:Loader;
            var loaderContext:LoaderContext;
            var classOrString:* = param1;
            if (classOrString && classOrString as Class)
            {
                cls = Class(classOrString);
                initBackgroundImage(new cls);
            }
            else if (classOrString && classOrString is String)
            {
                try
                {
                    cls = Class(getDefinitionByName(String(classOrString)));
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
                    loader = new Loader();
                    loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_completeHandler);
                    loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loader_ioErrorHandler);
                    loaderContext = new LoaderContext();
                    loaderContext.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
                    loader.load(new URLRequest(String(classOrString)), loaderContext);
                }
            }
            return;
        }// end function

        protected function set showPercentage(param1:Boolean) : void
        {
            _showPercentage = param1;
            draw();
            return;
        }// end function

        protected function get barFrameRect() : RoundedRectangle
        {
            return new RoundedRectangle(14, 40, 154, 4);
        }// end function

        private function loader_ioErrorHandler(event:IOErrorEvent) : void
        {
            return;
        }// end function

        protected function rslErrorHandler(event:RSLEvent) : void
        {
            _preloader.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
            _preloader.removeEventListener(Event.COMPLETE, completeHandler);
            _preloader.removeEventListener(RSLEvent.RSL_PROGRESS, rslProgressHandler);
            _preloader.removeEventListener(RSLEvent.RSL_COMPLETE, rslCompleteHandler);
            _preloader.removeEventListener(RSLEvent.RSL_ERROR, rslErrorHandler);
            _preloader.removeEventListener(FlexEvent.INIT_PROGRESS, initProgressHandler);
            _preloader.removeEventListener(FlexEvent.INIT_COMPLETE, initCompleteHandler);
            if (!_showingDisplay)
            {
                show();
                _showingDisplay = true;
            }
            label = "RSL Error " + (event.rslIndex + 1) + " of " + event.rslTotal;
            var _loc_2:* = new ErrorField(this);
            _loc_2.show(event.errorText);
            return;
        }// end function

        protected function rslCompleteHandler(event:RSLEvent) : void
        {
            label = "Loaded library " + event.rslIndex + " of " + event.rslTotal;
            return;
        }// end function

        protected function get borderRect() : RoundedRectangle
        {
            return new RoundedRectangle(0, 0, 182, 60, 4);
        }// end function

        protected function showDisplayForDownloading(param1:int, param2:ProgressEvent) : Boolean
        {
            if (param1 > 700)
            {
            }
            return param2.bytesLoaded < param2.bytesTotal / 2;
        }// end function

        protected function createChildren() : void
        {
            var _loc_2:TextField = null;
            var _loc_3:TextField = null;
            var _loc_1:* = graphics;
            if (backgroundColor != 4294967295)
            {
                _loc_1.beginFill(backgroundColor, backgroundAlpha);
                _loc_1.drawRect(0, 0, stageWidth, stageHeight);
            }
            if (backgroundImage != null)
            {
                loadBackgroundImage(backgroundImage);
            }
            _barFrameSprite = new Sprite();
            _barSprite = new Sprite();
            addChild(_barFrameSprite);
            addChild(_barSprite);
            _loc_1.beginFill(13421772, 0.4);
            _loc_1.drawRoundRect(calcX(_borderRect.x), calcY(_borderRect.y), _borderRect.width, _borderRect.height, _borderRect.cornerRadius * 2, _borderRect.cornerRadius * 2);
            _loc_1.drawRoundRect(calcX(_borderRect.x + 1), calcY(_borderRect.y + 1), _borderRect.width - 2, _borderRect.height - 2, _borderRect.cornerRadius - 1 * 2, _borderRect.cornerRadius - 1 * 2);
            _loc_1.endFill();
            _loc_1.beginFill(13421772, 0.4);
            _loc_1.drawRoundRect(calcX(_borderRect.x + 1), calcY(_borderRect.y + 1), _borderRect.width - 2, _borderRect.height - 2, _borderRect.cornerRadius - 1 * 2, _borderRect.cornerRadius - 1 * 2);
            _loc_1.endFill();
            var _loc_4:* = _barFrameSprite.graphics;
            var _loc_5:* = new Matrix();
            new Matrix().createGradientBox(_barFrameRect.width, _barFrameRect.height, Math.PI / 2, calcX(_barFrameRect.x), calcY(_barFrameRect.y));
            _loc_4.beginGradientFill(GradientType.LINEAR, [6054502, 11909306], [1, 1], [0, 255], _loc_5);
            _loc_4.drawRoundRect(calcX(_barFrameRect.x), calcY(_barFrameRect.y), _barFrameRect.width, _barFrameRect.height, _barFrameRect.cornerRadius * 2, _barFrameRect.cornerRadius * 2);
            _loc_4.drawRoundRect(calcX(_barFrameRect.x + 1), calcY(_barFrameRect.y + 1), _barFrameRect.width - 2, _barFrameRect.height - 2, _barFrameRect.cornerRadius * 2, _barFrameRect.cornerRadius * 2);
            _loc_4.endFill();
            _labelObj = new TextField();
            _labelObj.x = calcX(_labelRect.x);
            _labelObj.y = calcY(_labelRect.y);
            _labelObj.width = _labelRect.width;
            _labelObj.height = _labelRect.height;
            _labelObj.selectable = false;
            _labelObj.defaultTextFormat = labelFormat;
            addChild(_labelObj);
            _percentObj = new TextField();
            _percentObj.x = calcX(_percentRect.x);
            _percentObj.y = calcY(_percentRect.y);
            _percentObj.width = _percentRect.width;
            _percentObj.height = _percentRect.height;
            _percentObj.selectable = false;
            _percentObj.defaultTextFormat = percentFormat;
            addChild(_percentObj);
            var _loc_6:* = new RectangularDropShadow();
            new RectangularDropShadow().color = 0;
            _loc_6.angle = 90;
            _loc_6.alpha = 0.6;
            _loc_6.distance = 2;
            var _loc_7:* = _borderRect.cornerRadius;
            _loc_6.brRadius = _borderRect.cornerRadius;
            var _loc_7:* = _loc_7;
            _loc_6.blRadius = _loc_7;
            var _loc_7:* = _loc_7;
            _loc_6.trRadius = _loc_7;
            _loc_6.tlRadius = _loc_7;
            _loc_6.drawShadow(_loc_1, calcX(_borderRect.x), calcY(_borderRect.y), _borderRect.width, _borderRect.height);
            _loc_1.lineStyle(1, 16777215, 0.3);
            _loc_1.moveTo(calcX(_borderRect.x) + _borderRect.cornerRadius, calcY(_borderRect.y));
            _loc_1.lineTo(calcX(_borderRect.x) - _borderRect.cornerRadius + _borderRect.width, calcY(_borderRect.y));
            return;
        }// end function

        private function draw() : void
        {
            var _loc_1:Number = NaN;
            if (_startedLoading)
            {
                if (!_startedInit)
                {
                    _loc_1 = Math.round(getPercentLoaded(_value, _maximum) * DOWNLOAD_PERCENTAGE / 100);
                }
                else
                {
                    _loc_1 = Math.round(getPercentLoaded(_value, _maximum) * (100 - DOWNLOAD_PERCENTAGE) / 100 + DOWNLOAD_PERCENTAGE);
                }
            }
            else
            {
                _loc_1 = getPercentLoaded(_value, _maximum);
            }
            if (_labelObj)
            {
                _labelObj.text = _label;
            }
            if (_percentObj)
            {
                if (!_showPercentage)
                {
                    _percentObj.visible = false;
                    _percentObj.text = "";
                }
                else
                {
                    _percentObj.text = String(_loc_1) + "%";
                }
            }
            if (_barSprite && _barFrameSprite)
            {
                if (!_showProgressBar)
                {
                    _barSprite.visible = false;
                    _barFrameSprite.visible = false;
                }
                else
                {
                    drawProgressBar(_loc_1);
                }
            }
            return;
        }// end function

        private function timerHandler(event:Event = null) : void
        {
            dispatchEvent(new Event(Event.COMPLETE));
            return;
        }// end function

        private function hide() : void
        {
            return;
        }// end function

        public function get backgroundSize() : String
        {
            return _backgroundSize;
        }// end function

        protected function center(param1:Number, param2:Number) : void
        {
            _xOffset = Math.floor((param1 - _borderRect.width) / 2);
            _yOffset = Math.floor((param2 - _borderRect.height) / 2);
            return;
        }// end function

        protected function progressHandler(event:ProgressEvent) : void
        {
            var _loc_2:* = event.bytesLoaded;
            var _loc_3:* = event.bytesTotal;
            var _loc_4:* = getTimer() - _startTime;
            if (_showingDisplay || showDisplayForDownloading(_loc_4, event))
            {
                if (!_startedLoading)
                {
                    show();
                    label = downloadingLabel;
                    _startedLoading = true;
                }
                setProgress(event.bytesLoaded, event.bytesTotal);
            }
            return;
        }// end function

        protected function initProgressHandler(event:Event) : void
        {
            var _loc_3:Number = NaN;
            var _loc_2:* = getTimer() - _startTime;
            _initProgressCount++;
            if (!_showingDisplay && showDisplayForInit(_loc_2, _initProgressCount))
            {
                _displayStartCount = _initProgressCount;
                show();
            }
            else if (_showingDisplay)
            {
                if (!_startedInit)
                {
                    _startedInit = true;
                    label = initializingLabel;
                }
                _loc_3 = 100 * _initProgressCount / (_initProgressTotal - _displayStartCount);
                setProgress(_loc_3, 100);
            }
            return;
        }// end function

        protected function set downloadingLabel(param1:String) : void
        {
            _downloadingLabel = param1;
            return;
        }// end function

        public function get stageWidth() : Number
        {
            return _stageWidth;
        }// end function

        protected function get showPercentage() : Boolean
        {
            return _showPercentage;
        }// end function

        override public function get visible() : Boolean
        {
            return _visible;
        }// end function

        public function set stageHeight(param1:Number) : void
        {
            _stageHeight = param1;
            return;
        }// end function

        public function initialize() : void
        {
            _startTime = getTimer();
            center(stageWidth, stageHeight);
            return;
        }// end function

        protected function rslProgressHandler(event:RSLEvent) : void
        {
            return;
        }// end function

        protected function get barRect() : RoundedRectangle
        {
            return new RoundedRectangle(14, 39, 154, 6, 0);
        }// end function

        protected function get percentFormat() : TextFormat
        {
            var _loc_1:* = new TextFormat();
            _loc_1.align = "right";
            _loc_1.color = 0;
            _loc_1.font = "Verdana";
            _loc_1.size = 10;
            return _loc_1;
        }// end function

        public function set backgroundImage(param1:Object) : void
        {
            _backgroundImage = param1;
            return;
        }// end function

        private function calcX(param1:Number) : Number
        {
            return param1 + _xOffset;
        }// end function

        private function calcY(param1:Number) : Number
        {
            return param1 + _yOffset;
        }// end function

        public function set backgroundAlpha(param1:Number) : void
        {
            _backgroundAlpha = param1;
            return;
        }// end function

        private function initCompleteHandler(event:Event) : void
        {
            var _loc_3:Timer = null;
            var _loc_2:* = getTimer() - _displayTime;
            if (_showingDisplay && _loc_2 < MINIMUM_DISPLAY_TIME)
            {
                _loc_3 = new Timer(MINIMUM_DISPLAY_TIME - _loc_2, 1);
                _loc_3.addEventListener(TimerEvent.TIMER, timerHandler);
                _loc_3.start();
            }
            else
            {
                timerHandler();
            }
            return;
        }// end function

        public function set backgroundColor(param1:uint) : void
        {
            _backgroundColor = param1;
            return;
        }// end function

        private function initBackgroundImage(param1:DisplayObject) : void
        {
            var _loc_7:Number = NaN;
            var _loc_8:Number = NaN;
            var _loc_9:Number = NaN;
            addChildAt(param1, 0);
            var _loc_2:* = param1.width;
            var _loc_3:* = param1.height;
            var _loc_4:* = calcBackgroundSize();
            if (isNaN(_loc_4))
            {
                _loc_7 = 1;
                _loc_8 = 1;
            }
            else
            {
                _loc_9 = _loc_4 * 0.01;
                _loc_7 = _loc_9 * stageWidth / _loc_2;
                _loc_8 = _loc_9 * stageHeight / _loc_3;
            }
            param1.scaleX = _loc_7;
            param1.scaleY = _loc_8;
            var _loc_5:* = Math.round(0.5 * (stageWidth - _loc_2 * _loc_7));
            var _loc_6:* = Math.round(0.5 * (stageHeight - _loc_3 * _loc_8));
            param1.x = _loc_5;
            param1.y = _loc_6;
            if (!isNaN(backgroundAlpha))
            {
                param1.alpha = backgroundAlpha;
            }
            return;
        }// end function

        public function set backgroundSize(param1:String) : void
        {
            _backgroundSize = param1;
            return;
        }// end function

        protected function showDisplayForInit(param1:int, param2:int) : Boolean
        {
            if (param1 > 300)
            {
            }
            return param2 == 2;
        }// end function

        protected function get downloadingLabel() : String
        {
            return _downloadingLabel;
        }// end function

        private function loader_completeHandler(event:Event) : void
        {
            var _loc_2:* = DisplayObject(LoaderInfo(event.target).loader);
            initBackgroundImage(_loc_2);
            return;
        }// end function

        protected function setProgress(param1:Number, param2:Number) : void
        {
            if (!isNaN(param1) && !isNaN(param2) && param1 >= 0 && param2 > 0)
            {
                _value = Number(param1);
                _maximum = Number(param2);
                draw();
            }
            return;
        }// end function

        public function get stageHeight() : Number
        {
            return _stageHeight;
        }// end function

        public function get backgroundImage() : Object
        {
            return _backgroundImage;
        }// end function

        public function get backgroundAlpha() : Number
        {
            if (!isNaN(_backgroundAlpha))
            {
                return _backgroundAlpha;
            }
            return 1;
        }// end function

        private function drawProgressBar(param1:Number) : void
        {
            var _loc_11:Number = NaN;
            var _loc_2:* = _barSprite.graphics;
            _loc_2.clear();
            var _loc_3:Array = [16777215, 16777215];
            var _loc_4:Array = [0, 255];
            var _loc_5:* = new Matrix();
            var _loc_6:* = _barRect.width * param1 / 100;
            var _loc_7:* = _barRect.width * param1 / 100 / 2;
            var _loc_8:* = _barRect.height - 4;
            var _loc_9:* = calcX(_barRect.x);
            var _loc_10:* = calcY(_barRect.y) + 2;
            _loc_5.createGradientBox(_loc_7, _loc_8, 0, _loc_9, _loc_10);
            _loc_2.beginGradientFill(GradientType.LINEAR, _loc_3, [0.39, 0.85], _loc_4, _loc_5);
            _loc_2.drawRect(_loc_9, _loc_10, _loc_7, _loc_8);
            _loc_5.createGradientBox(_loc_7, _loc_8, 0, _loc_9 + _loc_7, _loc_10);
            _loc_2.beginGradientFill(GradientType.LINEAR, _loc_3, [0.85, 1], _loc_4, _loc_5);
            _loc_2.drawRect(_loc_9 + _loc_7, _loc_10, _loc_7, _loc_8);
            _loc_7 = _loc_6 / 3;
            _loc_8 = _barRect.height;
            _loc_10 = calcY(_barRect.y);
            _loc_5.createGradientBox(_loc_7, _loc_8, 0, _loc_9, _loc_10);
            _loc_2.beginGradientFill(GradientType.LINEAR, _loc_3, [0.05, 0.15], _loc_4, _loc_5);
            _loc_2.drawRect(_loc_9, _loc_10, _loc_7, 1);
            _loc_2.drawRect(_loc_9, (_loc_10 + _loc_8)--, _loc_7, 1);
            _loc_5.createGradientBox(_loc_7, _loc_8, 0, _loc_9 + _loc_7, _loc_10);
            _loc_2.beginGradientFill(GradientType.LINEAR, _loc_3, [0.15, 0.25], _loc_4, _loc_5);
            _loc_2.drawRect(_loc_9 + _loc_7, _loc_10, _loc_7, 1);
            _loc_2.drawRect(_loc_9 + _loc_7, _loc_11, _loc_7, 1);
            _loc_5.createGradientBox(_loc_7, _loc_8, 0, _loc_9 + _loc_7 * 2, _loc_10);
            _loc_2.beginGradientFill(GradientType.LINEAR, _loc_3, [0.25, 0.1], _loc_4, _loc_5);
            _loc_2.drawRect(_loc_9 + _loc_7 * 2, _loc_10, _loc_7, 1);
            _loc_2.drawRect(_loc_9 + _loc_7 * 2, _loc_11, _loc_7, 1);
            _loc_7 = _loc_6 / 3;
            _loc_8 = _barRect.height;
            _loc_10 = calcY(_barRect.y) + 1;
            _loc_11 = calcY(_barRect.y) + _loc_8 - 2;
            _loc_5.createGradientBox(_loc_7, _loc_8, 0, _loc_9, _loc_10);
            _loc_2.beginGradientFill(GradientType.LINEAR, _loc_3, [0.15, 0.3], _loc_4, _loc_5);
            _loc_2.drawRect(_loc_9, _loc_10, _loc_7, 1);
            _loc_2.drawRect(_loc_9, _loc_11, _loc_7, 1);
            _loc_5.createGradientBox(_loc_7, _loc_8, 0, _loc_9 + _loc_7, _loc_10);
            _loc_2.beginGradientFill(GradientType.LINEAR, _loc_3, [0.3, 0.4], _loc_4, _loc_5);
            _loc_2.drawRect(_loc_9 + _loc_7, _loc_10, _loc_7, 1);
            _loc_2.drawRect(_loc_9 + _loc_7, _loc_11, _loc_7, 1);
            _loc_5.createGradientBox(_loc_7, _loc_8, 0, _loc_9 + _loc_7 * 2, _loc_10);
            _loc_2.beginGradientFill(GradientType.LINEAR, _loc_3, [0.4, 0.25], _loc_4, _loc_5);
            _loc_2.drawRect(_loc_9 + _loc_7 * 2, _loc_10, _loc_7, 1);
            _loc_2.drawRect(_loc_9 + _loc_7 * 2, _loc_11, _loc_7, 1);
            return;
        }// end function

        public function get backgroundColor() : uint
        {
            return _backgroundColor;
        }// end function

        public function set stageWidth(param1:Number) : void
        {
            _stageWidth = param1;
            return;
        }// end function

        protected function completeHandler(event:Event) : void
        {
            return;
        }// end function

        protected function set label(param1:String) : void
        {
            if (!(param1 is Function))
            {
                _label = param1;
            }
            draw();
            return;
        }// end function

        public function set preloader(param1:Sprite) : void
        {
            _preloader = param1;
            param1.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            param1.addEventListener(Event.COMPLETE, completeHandler);
            param1.addEventListener(RSLEvent.RSL_PROGRESS, rslProgressHandler);
            param1.addEventListener(RSLEvent.RSL_COMPLETE, rslCompleteHandler);
            param1.addEventListener(RSLEvent.RSL_ERROR, rslErrorHandler);
            param1.addEventListener(FlexEvent.INIT_PROGRESS, initProgressHandler);
            param1.addEventListener(FlexEvent.INIT_COMPLETE, initCompleteHandler);
            return;
        }// end function

        protected function get label() : String
        {
            return _label;
        }// end function

        protected function get labelRect() : Rectangle
        {
            return new Rectangle(14, 17, 100, 16);
        }// end function

        override public function set visible(param1:Boolean) : void
        {
            if (!_visible && param1)
            {
                show();
            }
            else if (_visible && !param1)
            {
                hide();
            }
            _visible = param1;
            return;
        }// end function

        protected function get showLabel() : Boolean
        {
            return _showLabel;
        }// end function

        public static function get initializingLabel() : String
        {
            return _initializingLabel;
        }// end function

        public static function set initializingLabel(param1:String) : void
        {
            _initializingLabel = param1;
            return;
        }// end function

    }
}
