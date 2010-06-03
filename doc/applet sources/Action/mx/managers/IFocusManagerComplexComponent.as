package mx.managers
{

    public interface IFocusManagerComplexComponent extends IFocusManagerComponent
    {

        public function IFocusManagerComplexComponent();

        function assignFocus(param1:String) : void;

        function get hasFocusableContent() : Boolean;

    }
}
