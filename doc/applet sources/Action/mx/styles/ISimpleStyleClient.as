package mx.styles
{

    public interface ISimpleStyleClient
    {

        public function ISimpleStyleClient();

        function set styleName(param1:Object) : void;

        function styleChanged(param1:String) : void;

        function get styleName() : Object;

    }
}
