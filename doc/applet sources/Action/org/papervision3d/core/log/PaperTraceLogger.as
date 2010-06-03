package org.papervision3d.core.log
{

    public class PaperTraceLogger extends AbstractPaperLogger implements IPaperLogger
    {

        public function PaperTraceLogger()
        {
            return;
        }// end function

        override public function warning(param1:String, param2:Object = null, param3:Array = null) : void
        {
            trace("WARNING:", param1, param3);
            return;
        }// end function

        override public function log(param1:String, param2:Object = null, param3:Array = null) : void
        {
            trace("LOG:", param1, param3);
            return;
        }// end function

        override public function error(param1:String, param2:Object = null, param3:Array = null) : void
        {
            trace("ERROR:", param1, param3);
            return;
        }// end function

        override public function fatal(param1:String, param2:Object = null, param3:Array = null) : void
        {
            trace("FATAL:", param1, param3);
            return;
        }// end function

        override public function info(param1:String, param2:Object = null, param3:Array = null) : void
        {
            trace("INFO:", param1, param3);
            return;
        }// end function

        override public function debug(param1:String, param2:Object = null, param3:Array = null) : void
        {
            trace("DEBUG:", param1, param3);
            return;
        }// end function

    }
}
