package mx.utils
{
    import flash.utils.*;
    import mx.binding.*;

    public class DescribeTypeCache extends Object
    {
        static const VERSION:String = "3.2.0.3958";
        private static var cacheHandlers:Object = {};
        private static var typeCache:Object = {};

        public function DescribeTypeCache()
        {
            return;
        }// end function

        public static function describeType(param1) : DescribeTypeCacheRecord
        {
            var _loc_2:String = null;
            var _loc_3:XML = null;
            var _loc_4:DescribeTypeCacheRecord = null;
            if (param1 is String)
            {
                _loc_2 = param1;
            }
            else
            {
                _loc_2 = getQualifiedClassName(param1);
            }
            if (_loc_2 in typeCache)
            {
                return typeCache[_loc_2];
            }
            if (param1 is String)
            {
                param1 = getDefinitionByName(param1);
            }
            _loc_3 = describeType(param1);
            _loc_4 = new DescribeTypeCacheRecord();
            _loc_4.typeDescription = _loc_3;
            _loc_4.typeName = _loc_2;
            typeCache[_loc_2] = _loc_4;
            return _loc_4;
        }// end function

        public static function registerCacheHandler(param1:String, param2:Function) : void
        {
            cacheHandlers[param1] = param2;
            return;
        }// end function

        static function extractValue(param1:String, param2:DescribeTypeCacheRecord)
        {
            if (param1 in cacheHandlers)
            {
                var _loc_3:* = cacheHandlers;
                return _loc_3.cacheHandlers[param1](param2);
            }
            return undefined;
        }// end function

        private static function bindabilityInfoHandler(param1:DescribeTypeCacheRecord)
        {
            return new BindabilityInfo(param1.typeDescription);
        }// end function

        registerCacheHandler("bindabilityInfo", bindabilityInfoHandler);
    }
}
