package air.update.states
{
    import flash.events.*;

    public class HSMEvent extends Event
    {
        public static const ENTER:String = "enter";
        public static const EXIT:String = "exit";

        public function HSMEvent(param1:String)
        {
            super(param1);
            return;
        }// end function

    }
}
