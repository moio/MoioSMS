package mx.managers
{

    public interface IFocusManagerGroup
    {

        public function IFocusManagerGroup();

        function get groupName() : String;

        function get selected() : Boolean;

        function set groupName(param1:String) : void;

        function set selected(param1:Boolean) : void;

    }
}
