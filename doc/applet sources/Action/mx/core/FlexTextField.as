package mx.core
{
    import flash.text.*;
    import mx.utils.*;

    public class FlexTextField extends TextField
    {
        static const VERSION:String = "3.2.0.3958";

        public function FlexTextField()
        {
            try
            {
                name = NameUtil.createUniqueName(this);
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        override public function toString() : String
        {
            return NameUtil.displayObjectToString(this);
        }// end function

    }
}
