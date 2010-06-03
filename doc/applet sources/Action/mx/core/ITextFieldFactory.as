package mx.core
{
    import flash.text.*;

    public interface ITextFieldFactory
    {

        public function ITextFieldFactory();

        function createTextField(param1:IFlexModuleFactory) : TextField;

    }
}
