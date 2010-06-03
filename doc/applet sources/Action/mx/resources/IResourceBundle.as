package mx.resources
{

    public interface IResourceBundle
    {

        public function IResourceBundle();

        function get content() : Object;

        function get locale() : String;

        function get bundleName() : String;

    }
}
