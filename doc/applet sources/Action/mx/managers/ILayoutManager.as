package mx.managers
{

    public interface ILayoutManager extends IEventDispatcher
    {

        public function ILayoutManager();

        function validateNow() : void;

        function validateClient(param1:ILayoutManagerClient, param2:Boolean = false) : void;

        function isInvalid() : Boolean;

        function invalidateDisplayList(param1:ILayoutManagerClient) : void;

        function set usePhasedInstantiation(param1:Boolean) : void;

        function invalidateSize(param1:ILayoutManagerClient) : void;

        function get usePhasedInstantiation() : Boolean;

        function invalidateProperties(param1:ILayoutManagerClient) : void;

    }
}
