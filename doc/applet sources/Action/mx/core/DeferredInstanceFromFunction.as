package mx.core
{

    public class DeferredInstanceFromFunction extends Object implements IDeferredInstance
    {
        private var generator:Function;
        private var instance:Object = null;
        static const VERSION:String = "3.2.0.3958";

        public function DeferredInstanceFromFunction(param1:Function)
        {
            this.generator = param1;
            return;
        }// end function

        public function getInstance() : Object
        {
            if (!instance)
            {
                instance = generator();
            }
            return instance;
        }// end function

    }
}
