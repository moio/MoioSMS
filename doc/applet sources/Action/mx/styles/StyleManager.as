package mx.styles
{
    import flash.events.*;
    import flash.system.*;
    import mx.core.*;

    public class StyleManager extends Object
    {
        private static var _impl:IStyleManager2;
        private static var implClassDependency:StyleManagerImpl;
        static const VERSION:String = "3.2.0.3958";
        public static const NOT_A_COLOR:uint = 4.29497e+009;

        public function StyleManager()
        {
            return;
        }// end function

        public static function isParentSizeInvalidatingStyle(param1:String) : Boolean
        {
            return impl.isParentSizeInvalidatingStyle(param1);
        }// end function

        public static function registerInheritingStyle(param1:String) : void
        {
            impl.registerInheritingStyle(param1);
            return;
        }// end function

        static function set stylesRoot(param1:Object) : void
        {
            impl.stylesRoot = param1;
            return;
        }// end function

        static function get inheritingStyles() : Object
        {
            return impl.inheritingStyles;
        }// end function

        static function styleDeclarationsChanged() : void
        {
            impl.styleDeclarationsChanged();
            return;
        }// end function

        public static function setStyleDeclaration(param1:String, param2:CSSStyleDeclaration, param3:Boolean) : void
        {
            impl.setStyleDeclaration(param1, param2, param3);
            return;
        }// end function

        public static function registerParentDisplayListInvalidatingStyle(param1:String) : void
        {
            impl.registerParentDisplayListInvalidatingStyle(param1);
            return;
        }// end function

        static function get typeSelectorCache() : Object
        {
            return impl.typeSelectorCache;
        }// end function

        static function set inheritingStyles(param1:Object) : void
        {
            impl.inheritingStyles = param1;
            return;
        }// end function

        public static function isColorName(param1:String) : Boolean
        {
            return impl.isColorName(param1);
        }// end function

        public static function isParentDisplayListInvalidatingStyle(param1:String) : Boolean
        {
            return impl.isParentDisplayListInvalidatingStyle(param1);
        }// end function

        public static function isSizeInvalidatingStyle(param1:String) : Boolean
        {
            return impl.isSizeInvalidatingStyle(param1);
        }// end function

        public static function getColorName(param1:Object) : uint
        {
            return impl.getColorName(param1);
        }// end function

        static function set typeSelectorCache(param1:Object) : void
        {
            impl.typeSelectorCache = param1;
            return;
        }// end function

        public static function unloadStyleDeclarations(param1:String, param2:Boolean = true) : void
        {
            impl.unloadStyleDeclarations(param1, param2);
            return;
        }// end function

        public static function getColorNames(param1:Array) : void
        {
            impl.getColorNames(param1);
            return;
        }// end function

        public static function loadStyleDeclarations(param1:String, param2:Boolean = true, param3:Boolean = false, param4:ApplicationDomain = null, param5:SecurityDomain = null) : IEventDispatcher
        {
            return impl.loadStyleDeclarations2(param1, param2, param4, param5);
        }// end function

        private static function get impl() : IStyleManager2
        {
            if (!_impl)
            {
                _impl = IStyleManager2(Singleton.getInstance("mx.styles::IStyleManager2"));
            }
            return _impl;
        }// end function

        public static function isValidStyleValue(param1) : Boolean
        {
            return impl.isValidStyleValue(param1);
        }// end function

        static function get stylesRoot() : Object
        {
            return impl.stylesRoot;
        }// end function

        public static function isInheritingStyle(param1:String) : Boolean
        {
            return impl.isInheritingStyle(param1);
        }// end function

        static function initProtoChainRoots() : void
        {
            impl.initProtoChainRoots();
            return;
        }// end function

        public static function registerParentSizeInvalidatingStyle(param1:String) : void
        {
            impl.registerParentSizeInvalidatingStyle(param1);
            return;
        }// end function

        public static function get selectors() : Array
        {
            return impl.selectors;
        }// end function

        public static function registerSizeInvalidatingStyle(param1:String) : void
        {
            impl.registerSizeInvalidatingStyle(param1);
            return;
        }// end function

        public static function clearStyleDeclaration(param1:String, param2:Boolean) : void
        {
            impl.clearStyleDeclaration(param1, param2);
            return;
        }// end function

        public static function registerColorName(param1:String, param2:uint) : void
        {
            impl.registerColorName(param1, param2);
            return;
        }// end function

        public static function isInheritingTextFormatStyle(param1:String) : Boolean
        {
            return impl.isInheritingTextFormatStyle(param1);
        }// end function

        public static function getStyleDeclaration(param1:String) : CSSStyleDeclaration
        {
            return impl.getStyleDeclaration(param1);
        }// end function

    }
}
