package mx.managers
{

    public interface IToolTipManagerClient extends IFlexDisplayObject
    {

        public function IToolTipManagerClient();

        function get toolTip() : String;

        function set toolTip(param1:String) : void;

    }
}
