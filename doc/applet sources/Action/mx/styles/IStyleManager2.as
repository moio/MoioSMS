package mx.styles
{
    import flash.events.*;
    import flash.system.*;

    public interface IStyleManager2 extends IStyleManager
    {

        public function IStyleManager2();

        function get selectors() : Array;

        function loadStyleDeclarations2(param1:String, param2:Boolean = true, param3:ApplicationDomain = null, param4:SecurityDomain = null) : IEventDispatcher;

    }
}
