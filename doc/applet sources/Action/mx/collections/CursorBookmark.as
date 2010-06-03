package mx.collections
{

    public class CursorBookmark extends Object
    {
        private var _value:Object;
        private static var _first:CursorBookmark;
        private static var _last:CursorBookmark;
        static const VERSION:String = "3.2.0.3958";
        private static var _current:CursorBookmark;

        public function CursorBookmark(param1:Object)
        {
            _value = param1;
            return;
        }// end function

        public function get value() : Object
        {
            return _value;
        }// end function

        public function getViewIndex() : int
        {
            return -1;
        }// end function

        public static function get LAST() : CursorBookmark
        {
            if (!_last)
            {
                _last = new CursorBookmark("${L}");
            }
            return _last;
        }// end function

        public static function get FIRST() : CursorBookmark
        {
            if (!_first)
            {
                _first = new CursorBookmark("${F}");
            }
            return _first;
        }// end function

        public static function get CURRENT() : CursorBookmark
        {
            if (!_current)
            {
                _current = new CursorBookmark("${C}");
            }
            return _current;
        }// end function

    }
}
