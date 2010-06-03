package mx.core
{

    public interface IFlexModuleFactory
    {

        public function IFlexModuleFactory();

        function create(... args) : Object;

        function info() : Object;

    }
}
