package mx.core
{
    import flash.text.*;
    import mx.managers.*;

    public class UITextFormat extends TextFormat
    {
        private var systemManager:ISystemManager;
        public var sharpness:Number;
        public var gridFitType:String;
        public var antiAliasType:String;
        public var thickness:Number;
        private var cachedEmbeddedFont:EmbeddedFont = null;
        private var _moduleFactory:IFlexModuleFactory;
        private static var _embeddedFontRegistry:IEmbeddedFontRegistry;
        static const VERSION:String = "3.2.0.3958";
        private static var _textFieldFactory:ITextFieldFactory;

        public function UITextFormat(param1:ISystemManager, param2:String = null, param3:Object = null, param4:Object = null, param5:Object = null, param6:Object = null, param7:Object = null, param8:String = null, param9:String = null, param10:String = null, param11:Object = null, param12:Object = null, param13:Object = null, param14:Object = null)
        {
            this.systemManager = param1;
            super(param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14);
            return;
        }// end function

        public function set moduleFactory(param1:IFlexModuleFactory) : void
        {
            _moduleFactory = param1;
            return;
        }// end function

        function copyFrom(param1:TextFormat) : void
        {
            font = param1.font;
            size = param1.size;
            color = param1.color;
            bold = param1.bold;
            italic = param1.italic;
            underline = param1.underline;
            url = param1.url;
            target = param1.target;
            align = param1.align;
            leftMargin = param1.leftMargin;
            rightMargin = param1.rightMargin;
            indent = param1.indent;
            leading = param1.leading;
            letterSpacing = param1.letterSpacing;
            blockIndent = param1.blockIndent;
            bullet = param1.bullet;
            display = param1.display;
            indent = param1.indent;
            kerning = param1.kerning;
            tabStops = param1.tabStops;
            return;
        }// end function

        private function getEmbeddedFont(param1:String, param2:Boolean, param3:Boolean) : EmbeddedFont
        {
            if (cachedEmbeddedFont)
            {
                if (cachedEmbeddedFont.fontName == param1 && cachedEmbeddedFont.fontStyle == EmbeddedFontRegistry.getFontStyle(param2, param3))
                {
                    return cachedEmbeddedFont;
                }
            }
            cachedEmbeddedFont = new EmbeddedFont(param1, param2, param3);
            return cachedEmbeddedFont;
        }// end function

        public function measureText(param1:String, param2:Boolean = true) : TextLineMetrics
        {
            return measure(param1, false, param2);
        }// end function

        private function measure(param1:String, param2:Boolean, param3:Boolean) : TextLineMetrics
        {
            if (!param1)
            {
                param1 = "";
            }
            var _loc_4:Boolean = false;
            var _loc_5:* = embeddedFontRegistry.getAssociatedModuleFactory(getEmbeddedFont(font, bold, italic), moduleFactory);
            _loc_4 = embeddedFontRegistry.getAssociatedModuleFactory(getEmbeddedFont(font, bold, italic), moduleFactory) != null;
            if (_loc_5 == null)
            {
                _loc_5 = systemManager;
            }
            var _loc_6:TextField = null;
            _loc_6 = TextField(textFieldFactory.createTextField(_loc_5));
            if (param2)
            {
                _loc_6.htmlText = "";
            }
            else
            {
                _loc_6.text = "";
            }
            _loc_6.defaultTextFormat = this;
            if (font)
            {
                if (_loc_4 || systemManager != null)
                {
                }
                _loc_6.embedFonts = systemManager.isFontFaceEmbedded(this);
            }
            else
            {
                _loc_6.embedFonts = false;
            }
            _loc_6.antiAliasType = antiAliasType;
            _loc_6.gridFitType = gridFitType;
            _loc_6.sharpness = sharpness;
            _loc_6.thickness = thickness;
            if (param2)
            {
                _loc_6.htmlText = param1;
            }
            else
            {
                _loc_6.text = param1;
            }
            var _loc_7:* = _loc_6.getLineMetrics(0);
            if (indent != null)
            {
                _loc_7.width = _loc_7.width + indent;
            }
            if (param3)
            {
                _loc_7.width = Math.ceil(_loc_7.width);
                _loc_7.height = Math.ceil(_loc_7.height);
            }
            return _loc_7;
        }// end function

        public function measureHTMLText(param1:String, param2:Boolean = true) : TextLineMetrics
        {
            return measure(param1, true, param2);
        }// end function

        public function get moduleFactory() : IFlexModuleFactory
        {
            return _moduleFactory;
        }// end function

        private static function get embeddedFontRegistry() : IEmbeddedFontRegistry
        {
            if (!_embeddedFontRegistry)
            {
                _embeddedFontRegistry = IEmbeddedFontRegistry(Singleton.getInstance("mx.core::IEmbeddedFontRegistry"));
            }
            return _embeddedFontRegistry;
        }// end function

        private static function get textFieldFactory() : ITextFieldFactory
        {
            if (!_textFieldFactory)
            {
                _textFieldFactory = ITextFieldFactory(Singleton.getInstance("mx.core::ITextFieldFactory"));
            }
            return _textFieldFactory;
        }// end function

    }
}
