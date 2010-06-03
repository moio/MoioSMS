package mx.core
{

    public class EmbeddedFont extends Object
    {
        private var _fontName:String;
        private var _fontStyle:String;
        static const VERSION:String = "3.2.0.3958";

        public function EmbeddedFont(param1:String, param2:Boolean, param3:Boolean)
        {
            _fontName = param1;
            _fontStyle = EmbeddedFontRegistry.getFontStyle(param2, param3);
            return;
        }// end function

        public function get fontStyle() : String
        {
            return _fontStyle;
        }// end function

        public function get fontName() : String
        {
            return _fontName;
        }// end function

    }
}
