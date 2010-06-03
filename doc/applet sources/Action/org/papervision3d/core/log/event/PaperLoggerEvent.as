package org.papervision3d.core.log.event
{
    import flash.events.*;
    import org.papervision3d.core.log.*;

    public class PaperLoggerEvent extends Event
    {
        public var paperLogVO:PaperLogVO;
        public static const TYPE_LOGEVENT:String = "logEvent";

        public function PaperLoggerEvent(param1:PaperLogVO)
        {
            super(TYPE_LOGEVENT);
            this.paperLogVO = param1;
            return;
        }// end function

    }
}
