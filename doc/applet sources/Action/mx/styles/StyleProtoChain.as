package mx.styles
{
    import flash.display.*;
    import mx.core.*;

    public class StyleProtoChain extends Object
    {
        static const VERSION:String = "3.2.0.3958";

        public function StyleProtoChain()
        {
            return;
        }// end function

        public static function initProtoChainForUIComponentStyleName(param1:IStyleClient) : void
        {
            var _loc_9:CSSStyleDeclaration = null;
            var _loc_2:* = IStyleClient(param1.styleName);
            var _loc_3:* = param1 as DisplayObject;
            var _loc_4:* = _loc_2.nonInheritingStyles;
            if (!_loc_2.nonInheritingStyles || _loc_4 == UIComponent.STYLE_UNINITIALIZED)
            {
                _loc_4 = StyleManager.stylesRoot;
                if (_loc_4.effects)
                {
                    param1.registerEffects(_loc_4.effects);
                }
            }
            var _loc_5:* = _loc_2.inheritingStyles;
            if (!_loc_2.inheritingStyles || _loc_5 == UIComponent.STYLE_UNINITIALIZED)
            {
                _loc_5 = StyleManager.stylesRoot;
            }
            var _loc_6:* = param1.getClassStyleDeclarations();
            var _loc_7:* = param1.getClassStyleDeclarations().length;
            if (_loc_2 is StyleProxy)
            {
                if (_loc_7 == 0)
                {
                    _loc_4 = addProperties(_loc_4, _loc_2, false);
                }
                _loc_3 = StyleProxy(_loc_2).source as DisplayObject;
            }
            var _loc_8:int = 0;
            while (_loc_8 < _loc_7)
            {
                
                _loc_9 = _loc_6[_loc_8];
                _loc_5 = _loc_9.addStyleToProtoChain(_loc_5, _loc_3);
                _loc_5 = addProperties(_loc_5, _loc_2, true);
                _loc_4 = _loc_9.addStyleToProtoChain(_loc_4, _loc_3);
                _loc_4 = addProperties(_loc_4, _loc_2, false);
                if (_loc_9.effects)
                {
                    param1.registerEffects(_loc_9.effects);
                }
                _loc_8++;
            }
            param1.inheritingStyles = param1.styleDeclaration ? (param1.styleDeclaration.addStyleToProtoChain(_loc_5, _loc_3)) : (_loc_5);
            param1.nonInheritingStyles = param1.styleDeclaration ? (param1.styleDeclaration.addStyleToProtoChain(_loc_4, _loc_3)) : (_loc_4);
            return;
        }// end function

        private static function addProperties(param1:Object, param2:IStyleClient, param3:Boolean) : Object
        {
            var _loc_11:CSSStyleDeclaration = null;
            var _loc_12:CSSStyleDeclaration = null;
            if (param2 is StyleProxy)
            {
            }
            var _loc_4:* = !param3 ? (StyleProxy(param2).filterMap) : (null);
            var _loc_5:* = param2;
            while (_loc_5 is StyleProxy)
            {
                
                _loc_5 = StyleProxy(_loc_5).source;
            }
            var _loc_6:* = _loc_5 as DisplayObject;
            var _loc_7:* = param2.getClassStyleDeclarations();
            var _loc_8:* = param2.getClassStyleDeclarations().length;
            var _loc_9:int = 0;
            while (_loc_9 < _loc_8)
            {
                
                _loc_11 = _loc_7[_loc_9];
                param1 = _loc_11.addStyleToProtoChain(param1, _loc_6, _loc_4);
                if (_loc_11.effects)
                {
                    param2.registerEffects(_loc_11.effects);
                }
                _loc_9++;
            }
            var _loc_10:* = param2.styleName;
            if (param2.styleName)
            {
                if (typeof(_loc_10) == "object")
                {
                    if (_loc_10 is CSSStyleDeclaration)
                    {
                        _loc_12 = CSSStyleDeclaration(_loc_10);
                    }
                    else
                    {
                        param1 = addProperties(param1, IStyleClient(_loc_10), param3);
                    }
                }
                else
                {
                    _loc_12 = StyleManager.getStyleDeclaration("." + _loc_10);
                }
                if (_loc_12)
                {
                    param1 = _loc_12.addStyleToProtoChain(param1, _loc_6, _loc_4);
                    if (_loc_12.effects)
                    {
                        param2.registerEffects(_loc_12.effects);
                    }
                }
            }
            if (param2.styleDeclaration)
            {
                param1 = param2.styleDeclaration.addStyleToProtoChain(param1, _loc_6, _loc_4);
            }
            return param1;
        }// end function

        public static function initTextField(param1:IUITextField) : void
        {
            var _loc_3:CSSStyleDeclaration = null;
            var _loc_2:* = param1.styleName;
            if (_loc_2)
            {
                if (typeof(_loc_2) == "object")
                {
                    if (_loc_2 is CSSStyleDeclaration)
                    {
                        _loc_3 = CSSStyleDeclaration(_loc_2);
                    }
                    else
                    {
                        if (_loc_2 is StyleProxy)
                        {
                            param1.mx.core:IUITextField::inheritingStyles = IStyleClient(_loc_2).inheritingStyles;
                            param1.mx.core:IUITextField::nonInheritingStyles = addProperties(StyleManager.stylesRoot, IStyleClient(_loc_2), false);
                            return;
                        }
                        param1.mx.core:IUITextField::inheritingStyles = IStyleClient(_loc_2).inheritingStyles;
                        param1.mx.core:IUITextField::nonInheritingStyles = IStyleClient(_loc_2).nonInheritingStyles;
                        return;
                    }
                }
                else
                {
                    _loc_3 = StyleManager.getStyleDeclaration("." + _loc_2);
                }
            }
            var _loc_4:* = IStyleClient(param1.parent).inheritingStyles;
            var _loc_5:* = StyleManager.stylesRoot;
            if (!_loc_4)
            {
                _loc_4 = StyleManager.stylesRoot;
            }
            if (_loc_3)
            {
                _loc_4 = _loc_3.addStyleToProtoChain(_loc_4, DisplayObject(param1));
                _loc_5 = _loc_3.addStyleToProtoChain(_loc_5, DisplayObject(param1));
            }
            param1.mx.core:IUITextField::inheritingStyles = _loc_4;
            param1.mx.core:IUITextField::nonInheritingStyles = _loc_5;
            return;
        }// end function

    }
}
