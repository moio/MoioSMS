package mx.core
{

    public class EdgeMetrics extends Object
    {
        public var top:Number;
        public var left:Number;
        public var bottom:Number;
        public var right:Number;
        static const VERSION:String = "3.2.0.3958";
        public static const EMPTY:EdgeMetrics = new EdgeMetrics(0, 0, 0, 0);

        public function EdgeMetrics(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0)
        {
            this.left = param1;
            this.top = param2;
            this.right = param3;
            this.bottom = param4;
            return;
        }// end function

        public function clone() : EdgeMetrics
        {
            return new EdgeMetrics(left, top, right, bottom);
        }// end function

    }
}
