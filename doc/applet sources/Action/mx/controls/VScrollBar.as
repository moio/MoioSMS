package mx.controls
{
    import flash.ui.*;
    import mx.controls.scrollClasses.*;

    public class VScrollBar extends ScrollBar
    {
        static const VERSION:String = "3.2.0.3958";

        public function VScrollBar()
        {
            super.direction = ScrollBarDirection.VERTICAL;
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            measuredWidth = _minWidth;
            measuredHeight = _minHeight;
            return;
        }// end function

        override public function get minHeight() : Number
        {
            return _minHeight;
        }// end function

        override function isScrollBarKey(param1:uint) : Boolean
        {
            if (param1 == Keyboard.UP)
            {
                lineScroll(-1);
                return true;
            }
            if (param1 == Keyboard.DOWN)
            {
                lineScroll(1);
                return true;
            }
            if (param1 == Keyboard.PAGE_UP)
            {
                pageScroll(-1);
                return true;
            }
            if (param1 == Keyboard.PAGE_DOWN)
            {
                pageScroll(1);
                return true;
            }
            return super.isScrollBarKey(param1);
        }// end function

        override public function get minWidth() : Number
        {
            return _minWidth;
        }// end function

        override public function set direction(param1:String) : void
        {
            return;
        }// end function

    }
}
