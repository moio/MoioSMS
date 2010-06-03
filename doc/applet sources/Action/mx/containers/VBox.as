package mx.containers
{
    import mx.core.*;

    public class VBox extends Box
    {
        static const VERSION:String = "3.2.0.3958";

        public function VBox()
        {
            mx_internal::layoutObject.direction = BoxDirection.VERTICAL;
            return;
        }// end function

        override public function set direction(param1:String) : void
        {
            return;
        }// end function

    }
}
