package mx.core
{

    public class UIComponentDescriptor extends ComponentDescriptor
    {
        var instanceIndices:Array;
        public var stylesFactory:Function;
        public var effects:Array;
        var repeaters:Array;
        var repeaterIndices:Array;
        static const VERSION:String = "3.2.0.3958";

        public function UIComponentDescriptor(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function toString() : String
        {
            return "UIComponentDescriptor_" + id;
        }// end function

    }
}
