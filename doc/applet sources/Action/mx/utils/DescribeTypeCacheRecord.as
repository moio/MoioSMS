package mx.utils
{
    import flash.utils.*;

    dynamic public class DescribeTypeCacheRecord extends Proxy
    {
        public var typeDescription:XML;
        public var typeName:String;
        private var cache:Object;

        public function DescribeTypeCacheRecord()
        {
            cache = {};
            return;
        }// end function

        override function getProperty(param1)
        {
            var _loc_2:* = cache[param1];
            if (_loc_2 === undefined)
            {
                _loc_2 = DescribeTypeCache.extractValue(param1, this);
                cache[param1] = _loc_2;
            }
            return _loc_2;
        }// end function

        override function hasProperty(param1) : Boolean
        {
            if (param1 in cache)
            {
                return true;
            }
            var _loc_2:* = DescribeTypeCache.extractValue(param1, this);
            if (_loc_2 === undefined)
            {
                return false;
            }
            cache[param1] = _loc_2;
            return true;
        }// end function

    }
}
