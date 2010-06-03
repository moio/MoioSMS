package mx.skins.halo
{
    import mx.skins.*;
    import mx.styles.*;
    import mx.utils.*;

    public class HaloFocusRect extends ProgrammaticSkin implements IStyleClient
    {
        private var _focusColor:Number;
        static const VERSION:String = "3.2.0.3958";

        public function HaloFocusRect()
        {
            return;
        }// end function

        public function get inheritingStyles() : Object
        {
            return styleName.inheritingStyles;
        }// end function

        public function set inheritingStyles(param1:Object) : void
        {
            return;
        }// end function

        public function notifyStyleChangeInChildren(param1:String, param2:Boolean) : void
        {
            return;
        }// end function

        public function registerEffects(param1:Array) : void
        {
            return;
        }// end function

        public function regenerateStyleCache(param1:Boolean) : void
        {
            return;
        }// end function

        public function get styleDeclaration() : CSSStyleDeclaration
        {
            return CSSStyleDeclaration(styleName);
        }// end function

        public function getClassStyleDeclarations() : Array
        {
            return [];
        }// end function

        public function get className() : String
        {
            return "HaloFocusRect";
        }// end function

        public function clearStyle(param1:String) : void
        {
            if (param1 == "focusColor")
            {
                _focusColor = NaN;
            }
            return;
        }// end function

        public function setStyle(param1:String, param2) : void
        {
            if (param1 == "focusColor")
            {
                _focusColor = param2;
            }
            return;
        }// end function

        public function set nonInheritingStyles(param1:Object) : void
        {
            return;
        }// end function

        public function get nonInheritingStyles() : Object
        {
            return styleName.nonInheritingStyles;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_12:Number = NaN;
            var _loc_13:Number = NaN;
            var _loc_14:Number = NaN;
            var _loc_15:Number = NaN;
            var _loc_16:Number = NaN;
            var _loc_17:Number = NaN;
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("focusBlendMode");
            var _loc_4:* = getStyle("focusAlpha");
            var _loc_5:* = getStyle("focusColor");
            var _loc_6:* = getStyle("cornerRadius");
            var _loc_7:* = getStyle("focusThickness");
            var _loc_8:* = getStyle("focusRoundedCorners");
            var _loc_9:* = getStyle("themeColor");
            var _loc_10:* = _loc_5;
            if (isNaN(_loc_10))
            {
                _loc_10 = _loc_9;
            }
            var _loc_11:* = graphics;
            graphics.clear();
            blendMode = _loc_3;
            if (_loc_8 != "tl tr bl br" && _loc_6 > 0)
            {
                _loc_12 = 0;
                _loc_13 = 0;
                _loc_14 = 0;
                _loc_15 = 0;
                _loc_16 = _loc_6 + _loc_7;
                if (_loc_8.indexOf("tl") >= 0)
                {
                    _loc_12 = _loc_16;
                }
                if (_loc_8.indexOf("tr") >= 0)
                {
                    _loc_14 = _loc_16;
                }
                if (_loc_8.indexOf("bl") >= 0)
                {
                    _loc_13 = _loc_16;
                }
                if (_loc_8.indexOf("br") >= 0)
                {
                    _loc_15 = _loc_16;
                }
                _loc_11.beginFill(_loc_10, _loc_4);
                GraphicsUtil.drawRoundRectComplex(_loc_11, 0, 0, param1, param2, _loc_12, _loc_14, _loc_13, _loc_15);
                _loc_12 = _loc_12 ? (_loc_6) : (0);
                _loc_14 = _loc_14 ? (_loc_6) : (0);
                _loc_13 = _loc_13 ? (_loc_6) : (0);
                _loc_15 = _loc_15 ? (_loc_6) : (0);
                GraphicsUtil.drawRoundRectComplex(_loc_11, _loc_7, _loc_7, param1 - 2 * _loc_7, param2 - 2 * _loc_7, _loc_12, _loc_14, _loc_13, _loc_15);
                _loc_11.endFill();
                _loc_16 = _loc_6 + _loc_7 / 2;
                _loc_12 = _loc_12 ? (_loc_16) : (0);
                _loc_14 = _loc_14 ? (_loc_16) : (0);
                _loc_13 = _loc_13 ? (_loc_16) : (0);
                _loc_15 = _loc_15 ? (_loc_16) : (0);
                _loc_11.beginFill(_loc_10, _loc_4);
                GraphicsUtil.drawRoundRectComplex(_loc_11, _loc_7 / 2, _loc_7 / 2, param1 - _loc_7, param2 - _loc_7, _loc_12, _loc_14, _loc_13, _loc_15);
                _loc_12 = _loc_12 ? (_loc_6) : (0);
                _loc_14 = _loc_14 ? (_loc_6) : (0);
                _loc_13 = _loc_13 ? (_loc_6) : (0);
                _loc_15 = _loc_15 ? (_loc_6) : (0);
                GraphicsUtil.drawRoundRectComplex(_loc_11, _loc_7, _loc_7, param1 - 2 * _loc_7, param2 - 2 * _loc_7, _loc_12, _loc_14, _loc_13, _loc_15);
                _loc_11.endFill();
            }
            else
            {
                _loc_11.beginFill(_loc_10, _loc_4);
                _loc_17 = (_loc_6 > 0 ? (_loc_6 + _loc_7) : (0)) * 2;
                _loc_11.drawRoundRect(0, 0, param1, param2, _loc_17, _loc_17);
                _loc_17 = _loc_6 * 2;
                _loc_11.drawRoundRect(_loc_7, _loc_7, param1 - 2 * _loc_7, param2 - 2 * _loc_7, _loc_17, _loc_17);
                _loc_11.endFill();
                _loc_11.beginFill(_loc_10, _loc_4);
                _loc_17 = (_loc_6 > 0 ? (_loc_6 + _loc_7 / 2) : (0)) * 2;
                _loc_11.drawRoundRect(_loc_7 / 2, _loc_7 / 2, param1 - _loc_7, param2 - _loc_7, _loc_17, _loc_17);
                _loc_17 = _loc_6 * 2;
                _loc_11.drawRoundRect(_loc_7, _loc_7, param1 - 2 * _loc_7, param2 - 2 * _loc_7, _loc_17, _loc_17);
                _loc_11.endFill();
            }
            return;
        }// end function

        override public function getStyle(param1:String)
        {
            return param1 == "focusColor" ? (_focusColor) : (super.getStyle(param1));
        }// end function

        public function set styleDeclaration(param1:CSSStyleDeclaration) : void
        {
            return;
        }// end function

    }
}
