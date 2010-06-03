package mx.styles
{
    import flash.events.*;
    import flash.system.*;
    import flash.utils.*;
    import mx.core.*;
    import mx.events.*;
    import mx.managers.*;
    import mx.modules.*;
    import mx.resources.*;

    public class StyleManagerImpl extends Object implements IStyleManager2
    {
        private var _stylesRoot:Object;
        private var _selectors:Object;
        private var styleModules:Object;
        private var _inheritingStyles:Object;
        private var resourceManager:IResourceManager;
        private var _typeSelectorCache:Object;
        private static var parentSizeInvalidatingStyles:Object = {bottom:true, horizontalCenter:true, left:true, right:true, top:true, verticalCenter:true, baseline:true};
        private static var colorNames:Object = {transparent:"transparent", black:0, blue:255, green:32768, gray:8421504, silver:12632256, lime:65280, olive:8421376, white:16777215, yellow:16776960, maroon:8388608, navy:128, red:16711680, purple:8388736, teal:32896, fuchsia:16711935, aqua:65535, magenta:16711935, cyan:65535, halogreen:8453965, haloblue:40447, haloorange:16758272, halosilver:11455193};
        private static var inheritingTextFormatStyles:Object = {align:true, bold:true, color:true, font:true, indent:true, italic:true, size:true};
        private static var instance:IStyleManager2;
        private static var parentDisplayListInvalidatingStyles:Object = {bottom:true, horizontalCenter:true, left:true, right:true, top:true, verticalCenter:true, baseline:true};
        static const VERSION:String = "3.2.0.3958";
        private static var sizeInvalidatingStyles:Object = {borderStyle:true, borderThickness:true, fontAntiAliasType:true, fontFamily:true, fontGridFitType:true, fontSharpness:true, fontSize:true, fontStyle:true, fontThickness:true, fontWeight:true, headerHeight:true, horizontalAlign:true, horizontalGap:true, kerning:true, leading:true, letterSpacing:true, paddingBottom:true, paddingLeft:true, paddingRight:true, paddingTop:true, strokeWidth:true, tabHeight:true, tabWidth:true, verticalAlign:true, verticalGap:true};

        public function StyleManagerImpl()
        {
            _selectors = {};
            styleModules = {};
            resourceManager = ResourceManager.getInstance();
            _inheritingStyles = {};
            _typeSelectorCache = {};
            return;
        }// end function

        public function setStyleDeclaration(param1:String, param2:CSSStyleDeclaration, param3:Boolean) : void
        {
            var _loc_4:* = param2;
            _loc_4.selectorRefCount = param2.selectorRefCount++;
            _selectors[param1] = param2;
            typeSelectorCache = {};
            if (param3)
            {
                styleDeclarationsChanged();
            }
            return;
        }// end function

        public function registerParentDisplayListInvalidatingStyle(param1:String) : void
        {
            parentDisplayListInvalidatingStyles[param1] = true;
            return;
        }// end function

        public function getStyleDeclaration(param1:String) : CSSStyleDeclaration
        {
            var _loc_2:int = 0;
            if (param1.charAt(0) != ".")
            {
                _loc_2 = param1.lastIndexOf(".");
                if (_loc_2 != -1)
                {
                    param1 = param1.substr(_loc_2 + 1);
                }
            }
            return _selectors[param1];
        }// end function

        public function set typeSelectorCache(param1:Object) : void
        {
            _typeSelectorCache = param1;
            return;
        }// end function

        public function isColorName(param1:String) : Boolean
        {
            return colorNames[param1.toLowerCase()] !== undefined;
        }// end function

        public function set inheritingStyles(param1:Object) : void
        {
            _inheritingStyles = param1;
            return;
        }// end function

        public function getColorNames(param1:Array) : void
        {
            var _loc_4:uint = 0;
            if (!param1)
            {
                return;
            }
            var _loc_2:* = param1.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (param1[_loc_3] != null && isNaN(param1[_loc_3]))
                {
                    _loc_4 = getColorName(param1[_loc_3]);
                    if (_loc_4 != StyleManager.NOT_A_COLOR)
                    {
                        param1[_loc_3] = _loc_4;
                    }
                }
                _loc_3++;
            }
            return;
        }// end function

        public function isInheritingTextFormatStyle(param1:String) : Boolean
        {
            return inheritingTextFormatStyles[param1] == true;
        }// end function

        public function registerParentSizeInvalidatingStyle(param1:String) : void
        {
            parentSizeInvalidatingStyles[param1] = true;
            return;
        }// end function

        public function registerColorName(param1:String, param2:uint) : void
        {
            colorNames[param1.toLowerCase()] = param2;
            return;
        }// end function

        public function isParentSizeInvalidatingStyle(param1:String) : Boolean
        {
            return parentSizeInvalidatingStyles[param1] == true;
        }// end function

        public function registerInheritingStyle(param1:String) : void
        {
            inheritingStyles[param1] = true;
            return;
        }// end function

        public function set stylesRoot(param1:Object) : void
        {
            _stylesRoot = param1;
            return;
        }// end function

        public function get typeSelectorCache() : Object
        {
            return _typeSelectorCache;
        }// end function

        public function isParentDisplayListInvalidatingStyle(param1:String) : Boolean
        {
            return parentDisplayListInvalidatingStyles[param1] == true;
        }// end function

        public function isSizeInvalidatingStyle(param1:String) : Boolean
        {
            return sizeInvalidatingStyles[param1] == true;
        }// end function

        public function styleDeclarationsChanged() : void
        {
            var _loc_4:Object = null;
            var _loc_1:* = SystemManagerGlobals.topLevelSystemManagers;
            var _loc_2:* = _loc_1.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = _loc_1[_loc_3];
                _loc_4.regenerateStyleCache(true);
                _loc_4.notifyStyleChangeInChildren(null, true);
                _loc_3++;
            }
            return;
        }// end function

        public function isValidStyleValue(param1) : Boolean
        {
            return param1 !== undefined;
        }// end function

        public function loadStyleDeclarations(param1:String, param2:Boolean = true, param3:Boolean = false) : IEventDispatcher
        {
            return loadStyleDeclarations2(param1, param2);
        }// end function

        public function get inheritingStyles() : Object
        {
            return _inheritingStyles;
        }// end function

        public function unloadStyleDeclarations(param1:String, param2:Boolean = true) : void
        {
            var _loc_4:IModuleInfo = null;
            var _loc_3:* = styleModules[param1];
            if (_loc_3)
            {
                _loc_3.styleModule.unload();
                _loc_4 = _loc_3.module;
                _loc_4.mx.modules:IModuleInfo::unload();
                _loc_4.removeEventListener(ModuleEvent.READY, _loc_3.readyHandler);
                _loc_4.removeEventListener(ModuleEvent.ERROR, _loc_3.errorHandler);
                styleModules[param1] = null;
            }
            if (param2)
            {
                styleDeclarationsChanged();
            }
            return;
        }// end function

        public function getColorName(param1:Object) : uint
        {
            var _loc_2:Number = NaN;
            var _loc_3:* = undefined;
            if (param1 is String)
            {
                if (param1.charAt(0) == "#")
                {
                    _loc_2 = Number("0x" + param1.slice(1));
                    return isNaN(_loc_2) ? (StyleManager.NOT_A_COLOR) : (uint(_loc_2));
                }
                if (param1.charAt(1) == "x" && param1.charAt(0) == "0")
                {
                    _loc_2 = Number(param1);
                    return isNaN(_loc_2) ? (StyleManager.NOT_A_COLOR) : (uint(_loc_2));
                }
                _loc_3 = colorNames[param1.toLowerCase()];
                if (_loc_3 === undefined)
                {
                    return StyleManager.NOT_A_COLOR;
                }
                return uint(_loc_3);
            }
            return uint(param1);
        }// end function

        public function isInheritingStyle(param1:String) : Boolean
        {
            return inheritingStyles[param1] == true;
        }// end function

        public function get stylesRoot() : Object
        {
            return _stylesRoot;
        }// end function

        public function initProtoChainRoots() : void
        {
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                delete _inheritingStyles["textDecoration"];
                delete _inheritingStyles["leading"];
            }
            if (!stylesRoot)
            {
                stylesRoot = _selectors["global"].addStyleToProtoChain({}, null);
            }
            return;
        }// end function

        public function loadStyleDeclarations2(param1:String, param2:Boolean = true, param3:ApplicationDomain = null, param4:SecurityDomain = null) : IEventDispatcher
        {
            var module:IModuleInfo;
            var styleEventDispatcher:StyleEventDispatcher;
            var timer:Timer;
            var timerHandler:Function;
            var url:* = param1;
            var update:* = param2;
            var applicationDomain:* = param3;
            var securityDomain:* = param4;
            module = ModuleManager.getModule(url);
            var readyHandler:* = function (event:ModuleEvent) : void
            {
                var _loc_2:* = IStyleModule(event.module.factory.create());
                styleModules[event.module.url].styleModule = _loc_2;
                if (update)
                {
                    styleDeclarationsChanged();
                }
                return;
            }// end function
            ;
            module.addEventListener(ModuleEvent.READY, readyHandler, false, 0, true);
            styleEventDispatcher = new StyleEventDispatcher(module);
            var errorHandler:* = function (event:ModuleEvent) : void
            {
                var _loc_3:StyleEvent = null;
                var _loc_2:* = resourceManager.getString("styles", "unableToLoad", [event.errorText, url]);
                if (styleEventDispatcher.willTrigger(StyleEvent.ERROR))
                {
                    _loc_3 = new StyleEvent(StyleEvent.ERROR, event.bubbles, event.cancelable);
                    _loc_3.bytesLoaded = 0;
                    _loc_3.bytesTotal = 0;
                    _loc_3.errorText = _loc_2;
                    styleEventDispatcher.dispatchEvent(_loc_3);
                }
                else
                {
                    throw new Error(_loc_2);
                }
                return;
            }// end function
            ;
            module.addEventListener(ModuleEvent.ERROR, errorHandler, false, 0, true);
            styleModules[url] = new StyleModuleInfo(module, readyHandler, errorHandler);
            timer = new Timer(0);
            timerHandler = function (event:TimerEvent) : void
            {
                timer.removeEventListener(TimerEvent.TIMER, timerHandler);
                timer.stop();
                module.load(applicationDomain, securityDomain);
                return;
            }// end function
            ;
            timer.addEventListener(TimerEvent.TIMER, timerHandler, false, 0, true);
            timer.start();
            return styleEventDispatcher;
        }// end function

        public function registerSizeInvalidatingStyle(param1:String) : void
        {
            sizeInvalidatingStyles[param1] = true;
            return;
        }// end function

        public function clearStyleDeclaration(param1:String, param2:Boolean) : void
        {
            var _loc_3:* = getStyleDeclaration(param1);
            if (_loc_3 && _loc_3.selectorRefCount > 0)
            {
                var _loc_4:* = _loc_3;
                _loc_4.selectorRefCount = _loc_3.selectorRefCount--;
            }
            delete _selectors[param1];
            if (param2)
            {
                styleDeclarationsChanged();
            }
            return;
        }// end function

        public function get selectors() : Array
        {
            var _loc_2:String = null;
            var _loc_1:Array = [];
            for (_loc_2 in _selectors)
            {
                
                _loc_1.push(_loc_2);
            }
            return _loc_1;
        }// end function

        public static function getInstance() : IStyleManager2
        {
            if (!instance)
            {
                instance = new StyleManagerImpl;
            }
            return instance;
        }// end function

    }
}
