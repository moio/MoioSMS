package mx.binding
{

    public class EvalBindingResponder extends Object implements IResponder
    {
        private var binding:Binding;
        private var object:Object;
        static const VERSION:String = "3.2.0.3958";

        public function EvalBindingResponder(param1:Binding, param2:Object)
        {
            this.binding = param1;
            this.object = param2;
            return;
        }// end function

        public function fault(param1:Object) : void
        {
            return;
        }// end function

        public function result(param1:Object) : void
        {
            binding.execute(object);
            return;
        }// end function

    }
}
