package mx.core
{

    public interface IFlexModule
    {

        public function IFlexModule();

        function set moduleFactory(param1:IFlexModuleFactory) : void;

        function get moduleFactory() : IFlexModuleFactory;

    }
}
