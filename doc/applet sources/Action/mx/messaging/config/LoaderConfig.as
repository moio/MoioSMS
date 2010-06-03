package mx.messaging.config
{

    public class LoaderConfig extends Object
    {
        static var _url:String = null;
        static const VERSION:String = "3.2.0.3958";
        static var _parameters:Object;

        public function LoaderConfig()
        {
            return;
        }// end function

        public static function get url() : String
        {
            return _url;
        }// end function

        public static function get parameters() : Object
        {
            return _parameters;
        }// end function

    }
}
