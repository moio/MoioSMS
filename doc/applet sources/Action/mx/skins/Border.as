package mx.skins
{
    import mx.core.*;

    public class Border extends ProgrammaticSkin implements IBorder
    {
        static const VERSION:String = "3.2.0.3958";

        public function Border()
        {
            return;
        }// end function

        public function get borderMetrics() : EdgeMetrics
        {
            return EdgeMetrics.EMPTY;
        }// end function

    }
}
