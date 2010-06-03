package mx.modules
{
    import flash.system.*;
    import flash.utils.*;
    import mx.core.*;

    public interface IModuleInfo extends IEventDispatcher
    {

        public function IModuleInfo();

        function get ready() : Boolean;

        function get loaded() : Boolean;

        function load(param1:ApplicationDomain = null, param2:SecurityDomain = null, param3:ByteArray = null) : void;

        function release() : void;

        function get error() : Boolean;

        function get data() : Object;

        function publish(param1:IFlexModuleFactory) : void;

        function get factory() : IFlexModuleFactory;

        function set data(param1:Object) : void;

        function get url() : String;

        function get setup() : Boolean;

        function unload() : void;

    }
}
