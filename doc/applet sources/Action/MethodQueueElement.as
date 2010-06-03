package 
{

    private class MethodQueueElement extends Object
    {
        public var method:Function;
        public var args:Array;

        private function MethodQueueElement(param1:Function, param2:Array = null)
        {
            this.method = param1;
            this.args = param2;
            return;
        }// end function

    }
}
