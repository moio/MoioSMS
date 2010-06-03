package mx.collections.errors
{
    import mx.rpc.*;

    public class ItemPendingError extends Error
    {
        private var _responders:Array;
        static const VERSION:String = "3.2.0.3958";

        public function ItemPendingError(param1:String)
        {
            super(param1);
            return;
        }// end function

        public function get responders() : Array
        {
            return _responders;
        }// end function

        public function addResponder(param1:IResponder) : void
        {
            if (!_responders)
            {
                _responders = [];
            }
            _responders.push(param1);
            return;
        }// end function

    }
}
