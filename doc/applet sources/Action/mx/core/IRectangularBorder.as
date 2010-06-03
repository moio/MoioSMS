package mx.core
{
    import flash.geom.*;

    public interface IRectangularBorder extends IBorder
    {

        public function IRectangularBorder();

        function get backgroundImageBounds() : Rectangle;

        function get hasBackgroundImage() : Boolean;

        function set backgroundImageBounds(param1:Rectangle) : void;

        function layoutBackgroundImage() : void;

    }
}
