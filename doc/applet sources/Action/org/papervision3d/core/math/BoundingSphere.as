package org.papervision3d.core.math
{

    public class BoundingSphere extends Object
    {
        public var maxDistance:Number;
        public var radius:Number;

        public function BoundingSphere(param1:Number)
        {
            this.maxDistance = param1;
            this.radius = Math.sqrt(param1);
            return;
        }// end function

        public static function getFromVertices(param1:Array) : BoundingSphere
        {
            var _loc_3:Number = NaN;
            var _loc_4:Vertex3D = null;
            var _loc_2:Number = 0;
            for each (_loc_4 in param1)
            {
                
                _loc_3 = _loc_4.x * _loc_4.x + _loc_4.y * _loc_4.y + _loc_4.z * _loc_4.z;
                _loc_2 = _loc_3 > _loc_2 ? (_loc_3) : (_loc_2);
            }
            return new BoundingSphere(_loc_2);
        }// end function

    }
}
