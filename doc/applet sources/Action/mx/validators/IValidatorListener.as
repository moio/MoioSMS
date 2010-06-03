package mx.validators
{
    import mx.events.*;

    public interface IValidatorListener
    {

        public function IValidatorListener();

        function set errorString(param1:String) : void;

        function get validationSubField() : String;

        function validationResultHandler(event:ValidationResultEvent) : void;

        function set validationSubField(param1:String) : void;

        function get errorString() : String;

    }
}
