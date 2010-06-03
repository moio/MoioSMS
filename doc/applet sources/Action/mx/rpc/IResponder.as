package mx.rpc
{

    public interface IResponder
    {

        public function IResponder();

        function fault(param1:Object) : void;

        function result(param1:Object) : void;

    }
}
