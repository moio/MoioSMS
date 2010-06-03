package mx.utils
{

    public class ArrayUtil extends Object
    {
        static const VERSION:String = "3.2.0.3958";

        public function ArrayUtil()
        {
            return;
        }// end function

        public static function getItemIndex(param1:Object, param2:Array) : int
        {
            var _loc_3:* = param2.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (param2[_loc_4] === param1)
                {
                    return _loc_4;
                }
                _loc_4++;
            }
            return -1;
        }// end function

        public static function toArray(param1:Object) : Array
        {
            if (!param1)
            {
                return [];
            }
            if (param1 is Array)
            {
                return param1 as Array;
            }
            return [param1];
        }// end function

    }
}
