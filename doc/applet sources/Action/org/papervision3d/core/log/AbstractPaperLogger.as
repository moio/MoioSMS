package org.papervision3d.core.log
{
    import org.papervision3d.core.log.event.*;

    public class AbstractPaperLogger extends Object implements IPaperLogger
    {

        public function AbstractPaperLogger()
        {
            return;
        }// end function

        public function registerWithPaperLogger(param1:PaperLogger) : void
        {
            param1.addEventListener(PaperLoggerEvent.TYPE_LOGEVENT, this.onLogEvent);
            return;
        }// end function

        public function debug(param1:String, param2:Object = null, param3:Array = null) : void
        {
            return;
        }// end function

        public function warning(param1:String, param2:Object = null, param3:Array = null) : void
        {
            return;
        }// end function

        public function log(param1:String, param2:Object = null, param3:Array = null) : void
        {
            return;
        }// end function

        public function fatal(param1:String, param2:Object = null, param3:Array = null) : void
        {
            return;
        }// end function

        public function error(param1:String, param2:Object = null, param3:Array = null) : void
        {
            return;
        }// end function

        protected function onLogEvent(event:PaperLoggerEvent) : void
        {
            var _loc_2:* = event.paperLogVO;
            switch(_loc_2.level)
            {
                case LogLevel.LOG:
                {
                    this.log(_loc_2.msg, _loc_2.object, _loc_2.arg);
                    break;
                }
                case LogLevel.INFO:
                {
                    this.info(_loc_2.msg, _loc_2.object, _loc_2.arg);
                    break;
                }
                case LogLevel.ERROR:
                {
                    this.error(_loc_2.msg, _loc_2.object, _loc_2.arg);
                    break;
                }
                case LogLevel.DEBUG:
                {
                    this.debug(_loc_2.msg, _loc_2.object, _loc_2.arg);
                    break;
                }
                case LogLevel.WARNING:
                {
                    this.warning(_loc_2.msg, _loc_2.object, _loc_2.arg);
                    break;
                }
                case LogLevel.FATAL:
                {
                    this.fatal(_loc_2.msg, _loc_2.object, _loc_2.arg);
                    break;
                }
                default:
                {
                    this.log(_loc_2.msg, _loc_2.object, _loc_2.arg);
                    break;
                    break;
                }
            }
            return;
        }// end function

        public function unregisterFromPaperLogger(param1:PaperLogger) : void
        {
            param1.removeEventListener(PaperLoggerEvent.TYPE_LOGEVENT, this.onLogEvent);
            return;
        }// end function

        public function info(param1:String, param2:Object = null, param3:Array = null) : void
        {
            return;
        }// end function

    }
}
