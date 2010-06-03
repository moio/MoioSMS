package mx.states
{
    import mx.core.*;

    public interface IOverride
    {

        public function IOverride();

        function initialize() : void;

        function remove(param1:UIComponent) : void;

        function apply(param1:UIComponent) : void;

    }
}
