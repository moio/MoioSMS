package mx.containers
{
    import mx.core.*;

    public class HBox extends Box
    {
        static const VERSION:String = "3.2.0.3958";

        public function HBox()
        {
            mx_internal::layoutObject.direction = BoxDirection.HORIZONTAL;
            return;
        }// end function

        override public function set direction(param1:String) : void
        {
            return;
        }// end function

    }
}
