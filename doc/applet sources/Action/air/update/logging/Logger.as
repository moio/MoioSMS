package air.update.logging
{
    import flash.filesystem.*;
    import flash.utils.*;

    public class Logger extends Object
    {
        private var name:String = "";
        private static var loggers:Dictionary = new Dictionary();
        private static var _level:int = Level.OFF;

        public function Logger(param1:String) : void
        {
            this.name = param1;
            return;
        }// end function

        public function config(... args) : void
        {
            log(Level.CONFIG, args);
            return;
        }// end function

        public function log(param1:int, ... args) : void
        {
            var file:File;
            var fs:FileStream;
            var logLevel:* = param1;
            var arguments:* = args;
            if (!isLoggable(logLevel))
            {
                return;
            }
            var s:* = format(logLevel, arguments);
            trace(s);
            try
            {
                file = new File(File.documentsDirectory.nativePath + "/../.airappupdater.log");
                if (file.exists)
                {
                    fs = new FileStream();
                    fs.open(file, FileMode.APPEND);
                    fs.writeUTFBytes(s + "\n");
                    fs.close();
                }
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        public function isLoggable(param1:int) : Boolean
        {
            return param1 >= level;
        }// end function

        public function info(... args) : void
        {
            log(Level.INFO, args);
            return;
        }// end function

        public function severe(... args) : void
        {
            log(Level.SEVERE, args);
            return;
        }// end function

        private function format(param1:int, ... args) : String
        {
            var _loc_3:* = new Date();
            var _loc_4:* = _loc_3.fullYear + "/" + _loc_3.month + "/" + _loc_3.day + " " + _loc_3.hours + ":" + _loc_3.minutes + ":" + _loc_3.seconds + "." + _loc_3.milliseconds;
            var _loc_5:* = _loc_3 + " | " + name + " | [" + Level.getName(param1) + "] ";
            if (args == null)
            {
                return _loc_5;
            }
            var _loc_6:int = 0;
            while (_loc_6 < args.length)
            {
                
                _loc_5 = _loc_5 + ((_loc_6 > 0 ? (",") : ("")) + (args[_loc_6] != null ? (args[_loc_6].toString()) : ("null")));
                _loc_6++;
            }
            return _loc_5;
        }// end function

        public function finer(... args) : void
        {
            log(Level.FINER, args);
            return;
        }// end function

        public function fine(... args) : void
        {
            log(Level.FINE, args);
            return;
        }// end function

        public function finest(... args) : void
        {
            log(Level.FINEST, args);
            return;
        }// end function

        public function warning(... args) : void
        {
            log(Level.WARNING, args);
            return;
        }// end function

        public static function get level() : int
        {
            return _level;
        }// end function

        public static function getLogger(param1:String) : Logger
        {
            if (!loggers[param1])
            {
                return new Logger(param1);
            }
            return loggers[param1];
        }// end function

        public static function set level(param1:int) : void
        {
            _level = param1;
            return;
        }// end function

    }
}
