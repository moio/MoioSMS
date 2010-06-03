package mx.controls
{
    import flash.ui.*;
    import mx.controls.scrollClasses.*;

    public class HScrollBar extends ScrollBar
    {
        static const VERSION:String = "3.2.0.3958";

        public function HScrollBar()
        {
            super.direction = ScrollBarDirection.HORIZONTAL;
            scaleX = -1;
            rotation = -90;
            return;
        }// end function

        override function get virtualHeight() : Number
        {
            return unscaledWidth;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            measuredWidth = _minHeight;
            measuredHeight = _minWidth;
            return;
        }// end function

        override public function get minHeight() : Number
        {
            return _minWidth;
        }// end function

        override function get virtualWidth() : Number
        {
            return unscaledHeight;
        }// end function

        override public function get minWidth() : Number
        {
            return _minHeight;
        }// end function

        override function isScrollBarKey(param1:uint) : Boolean
        {
            if (param1 == Keyboard.LEFT)
            {
                lineScroll(-1);
                return true;
            }
            if (param1 == Keyboard.RIGHT)
            {
                lineScroll(1);
                return true;
            }
            return super.isScrollBarKey(param1);
        }// end function

        override public function set direction(param1:String) : void
        {
            return;
        }// end function

    }
}
