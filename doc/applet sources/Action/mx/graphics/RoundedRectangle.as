package mx.graphics
{
    import flash.geom.*;

    public class RoundedRectangle extends Rectangle
    {
        public var cornerRadius:Number = 0;
        static const VERSION:String = "3.2.0.3958";

        public function RoundedRectangle(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Number = 0)
        {
            super(param1, param2, param3, param4);
            this.cornerRadius = param5;
            return;
        }// end function

    }
}
