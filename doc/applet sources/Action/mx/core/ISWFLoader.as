package mx.core
{
    import flash.geom.*;

    public interface ISWFLoader extends ISWFBridgeProvider
    {

        public function ISWFLoader();

        function getVisibleApplicationRect(param1:Boolean = false) : Rectangle;

        function set loadForCompatibility(param1:Boolean) : void;

        function get loadForCompatibility() : Boolean;

    }
}
