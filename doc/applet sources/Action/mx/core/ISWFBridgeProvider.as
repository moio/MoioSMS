package mx.core
{
    import flash.events.*;

    public interface ISWFBridgeProvider
    {

        public function ISWFBridgeProvider();

        function get childAllowsParent() : Boolean;

        function get swfBridge() : IEventDispatcher;

        function get parentAllowsChild() : Boolean;

    }
}
