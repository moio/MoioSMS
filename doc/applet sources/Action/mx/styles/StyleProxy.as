package mx.styles
{
    import mx.core.*;

    public class StyleProxy extends Object implements IStyleClient
    {
        private var _source:IStyleClient;
        private var _filterMap:Object;
        static const VERSION:String = "3.2.0.3958";

        public function StyleProxy(param1:IStyleClient, param2:Object)
        {
            this.filterMap = param2;
            this.source = param1;
            return;
        }// end function

        public function styleChanged(param1:String) : void
        {
            return _source.styleChanged(param1);
        }// end function

        public function get filterMap() : Object
        {
            return FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0 ? (null) : (_filterMap);
        }// end function

        public function set filterMap(param1:Object) : void
        {
            _filterMap = param1;
            return;
        }// end function

        public function get styleDeclaration() : CSSStyleDeclaration
        {
            return _source.styleDeclaration;
        }// end function

        public function notifyStyleChangeInChildren(param1:String, param2:Boolean) : void
        {
            return _source.notifyStyleChangeInChildren(param1, param2);
        }// end function

        public function set inheritingStyles(param1:Object) : void
        {
            return;
        }// end function

        public function get source() : IStyleClient
        {
            return _source;
        }// end function

        public function get styleName() : Object
        {
            if (_source.styleName is IStyleClient)
            {
                return new StyleProxy(IStyleClient(_source.styleName), filterMap);
            }
            return _source.styleName;
        }// end function

        public function registerEffects(param1:Array) : void
        {
            return _source.registerEffects(param1);
        }// end function

        public function regenerateStyleCache(param1:Boolean) : void
        {
            _source.regenerateStyleCache(param1);
            return;
        }// end function

        public function get inheritingStyles() : Object
        {
            return _source.inheritingStyles;
        }// end function

        public function get className() : String
        {
            return _source.className;
        }// end function

        public function clearStyle(param1:String) : void
        {
            _source.clearStyle(param1);
            return;
        }// end function

        public function getClassStyleDeclarations() : Array
        {
            return _source.getClassStyleDeclarations();
        }// end function

        public function set nonInheritingStyles(param1:Object) : void
        {
            return;
        }// end function

        public function setStyle(param1:String, param2) : void
        {
            _source.setStyle(param1, param2);
            return;
        }// end function

        public function get nonInheritingStyles() : Object
        {
            return FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0 ? (_source.nonInheritingStyles) : (null);
        }// end function

        public function set styleName(param1:Object) : void
        {
            _source.styleName = param1;
            return;
        }// end function

        public function getStyle(param1:String)
        {
            return _source.getStyle(param1);
        }// end function

        public function set source(param1:IStyleClient) : void
        {
            _source = param1;
            return;
        }// end function

        public function set styleDeclaration(param1:CSSStyleDeclaration) : void
        {
            _source.styleDeclaration = styleDeclaration;
            return;
        }// end function

    }
}
