package org.papervision3d.core.log
{

    public class PaperLogVO extends Object
    {
        public var msg:String;
        public var level:int;
        public var arg:Array;
        public var object:Object;

        public function PaperLogVO(param1:int, param2:String, param3:Object, param4:Array)
        {
            this.level = param1;
            this.msg = param2;
            this.object = param3;
            this.arg = param4;
            return;
        }// end function

    }
}
