package org.papervision3d.core.log
{
    import flash.events.*;
    import org.papervision3d.core.log.event.*;

    public class PaperLogger extends EventDispatcher
    {
        public var traceLogger:PaperTraceLogger;
        private static var instance:PaperLogger;

        public function PaperLogger()
        {
            if (instance)
            {
                throw new Error("Don\'t call the PaperLogger constructor directly");
            }
            this.traceLogger = new PaperTraceLogger();
            this.registerLogger(this.traceLogger);
            return;
        }// end function

        public function registerLogger(param1:AbstractPaperLogger) : void
        {
            param1.registerWithPaperLogger(this);
            return;
        }// end function

        public function _debug(param1:String, param2:Object = null, ... args) : void
        {
            var _loc_4:* = new PaperLogVO(LogLevel.DEBUG, param1, param2, args);
            var _loc_5:* = new PaperLoggerEvent(_loc_4);
            dispatchEvent(_loc_5);
            return;
        }// end function

        public function _log(param1:String, param2:Object = null, ... args) : void
        {
            var _loc_4:* = new PaperLogVO(LogLevel.LOG, param1, param2, args);
            var _loc_5:* = new PaperLoggerEvent(_loc_4);
            dispatchEvent(_loc_5);
            return;
        }// end function

        public function _error(param1:String, param2:Object = null, ... args) : void
        {
            var _loc_4:* = new PaperLogVO(LogLevel.ERROR, param1, param2, args);
            var _loc_5:* = new PaperLoggerEvent(_loc_4);
            dispatchEvent(_loc_5);
            return;
        }// end function

        public function unregisterLogger(param1:AbstractPaperLogger) : void
        {
            param1.unregisterFromPaperLogger(this);
            return;
        }// end function

        public function _info(param1:String, param2:Object = null, ... args) : void
        {
            var _loc_4:* = new PaperLogVO(LogLevel.INFO, param1, param2, args);
            var _loc_5:* = new PaperLoggerEvent(_loc_4);
            dispatchEvent(_loc_5);
            return;
        }// end function

        public function _warning(param1:String, param2:Object = null, ... args) : void
        {
            var _loc_4:* = new PaperLogVO(LogLevel.WARNING, param1, param2, args);
            var _loc_5:* = new PaperLoggerEvent(_loc_4);
            dispatchEvent(_loc_5);
            return;
        }// end function

        public static function debug(param1:String, param2:Object = null, ... args) : void
        {
            getInstance()._debug(param1);
            return;
        }// end function

        public static function log(param1:String, param2:Object = null, ... args) : void
        {
            getInstance()._log(param1);
            return;
        }// end function

        public static function error(param1:String, param2:Object = null, ... args) : void
        {
            getInstance()._error(param1);
            return;
        }// end function

        public static function getInstance() : PaperLogger
        {
            if (!instance)
            {
                instance = new PaperLogger;
            }
            return instance;
        }// end function

        public static function warning(param1:String, param2:Object = null, ... args) : void
        {
            getInstance()._warning(param1);
            return;
        }// end function

        public static function info(param1:String, param2:Object = null, ... args) : void
        {
            getInstance()._info(param1);
            return;
        }// end function

    }
}
