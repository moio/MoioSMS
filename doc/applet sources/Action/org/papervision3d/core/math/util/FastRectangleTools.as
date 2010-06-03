package org.papervision3d.core.math.util
{
    import flash.geom.*;

    public class FastRectangleTools extends Object
    {

        public function FastRectangleTools()
        {
            return;
        }// end function

        public static function intersection(param1:Rectangle, param2:Rectangle, param3:Rectangle = null) : Rectangle
        {
            if (!param3)
            {
                param3 = new Rectangle();
            }
            if (!intersects(param1, param2))
            {
                var _loc_4:int = 0;
                param3.height = 0;
                var _loc_4:* = _loc_4;
                param3.width = _loc_4;
                var _loc_4:* = _loc_4;
                param3.y = _loc_4;
                param3.x = _loc_4;
                return param3;
            }
            param3.left = param1.left > param2.left ? (param1.left) : (param2.left);
            param3.right = param1.right < param2.right ? (param1.right) : (param2.right);
            param3.top = param1.top > param2.top ? (param1.top) : (param2.top);
            param3.bottom = param1.bottom < param2.bottom ? (param1.bottom) : (param2.bottom);
            return param3;
        }// end function

        public static function intersects(param1:Rectangle, param2:Rectangle) : Boolean
        {
            if (!(param1.right < param2.left || param1.left > param2.right))
            {
                if (!(param1.bottom < param2.top || param1.top > param2.bottom))
                {
                    return true;
                }
            }
            return false;
        }// end function

    }
}
