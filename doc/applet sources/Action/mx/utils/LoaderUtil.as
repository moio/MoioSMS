package mx.utils
{
    import flash.display.*;

    public class LoaderUtil extends Object
    {

        public function LoaderUtil()
        {
            return;
        }// end function

        public static function normalizeURL(param1:LoaderInfo) : String
        {
            var _loc_2:* = param1.url;
            var _loc_3:* = _loc_2.split("/[[DYNAMIC]]/");
            return _loc_3[0];
        }// end function

        public static function createAbsoluteURL(param1:String, param2:String) : String
        {
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_3:* = param2;
            if (!(param2.indexOf(":") > -1 || param2.indexOf("/") == 0 || param2.indexOf("\\") == 0))
            {
                if (param1)
                {
                    _loc_4 = Math.max(param1.lastIndexOf("\\"), param1.lastIndexOf("/"));
                    if (_loc_4 <= 8)
                    {
                        param1 = param1 + "/";
                    }
                    if (param2.indexOf("./") == 0)
                    {
                        param2 = param2.substring(2);
                    }
                    else
                    {
                        while (param2.indexOf("../") == 0)
                        {
                            
                            param2 = param2.substring(3);
                            _loc_5 = Math.max(param1.lastIndexOf("\\", param1.length----), param1.lastIndexOf("/", _loc_4--));
                            if (_loc_5 <= 8)
                            {
                                _loc_5 = _loc_4;
                            }
                            _loc_4 = _loc_5;
                        }
                    }
                    if (_loc_4 != -1)
                    {
                        _loc_3 = param1.substr(0, _loc_4 + 1) + param2;
                    }
                }
            }
            return _loc_3;
        }// end function

    }
}
