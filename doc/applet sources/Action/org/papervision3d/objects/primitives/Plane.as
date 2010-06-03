package org.papervision3d.objects.primitives
{
    import org.papervision3d.*;
    import org.papervision3d.core.geom.*;
    import org.papervision3d.core.geom.renderables.*;
    import org.papervision3d.core.math.*;
    import org.papervision3d.core.proto.*;

    public class Plane extends TriangleMesh3D
    {
        public var segmentsH:Number;
        public var segmentsW:Number;
        public static var DEFAULT_SCALE:Number = 1;
        public static var DEFAULT_SEGMENTS:Number = 1;
        public static var DEFAULT_SIZE:Number = 500;

        public function Plane(param1:MaterialObject3D = null, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Number = 0)
        {
            super(param1, new Array(), new Array(), null);
            if (!param4)
            {
            }
            this.segmentsW = DEFAULT_SEGMENTS;
            if (!param5)
            {
            }
            this.segmentsH = this.segmentsW;
            var _loc_6:* = DEFAULT_SCALE;
            if (!param3)
            {
                if (param2)
                {
                    _loc_6 = param2;
                }
                if (param1 && param1.bitmap)
                {
                    param2 = param1.bitmap.width * _loc_6;
                    param3 = param1.bitmap.height * _loc_6;
                }
                else
                {
                    param2 = DEFAULT_SIZE * _loc_6;
                    param3 = DEFAULT_SIZE * _loc_6;
                }
            }
            this.buildPlane(param2, param3);
            return;
        }// end function

        private function buildPlane(param1:Number, param2:Number) : void
        {
            var _loc_14:NumberUV = null;
            var _loc_15:NumberUV = null;
            var _loc_16:NumberUV = null;
            var _loc_17:int = 0;
            var _loc_18:Number = NaN;
            var _loc_19:Number = NaN;
            var _loc_20:Vertex3D = null;
            var _loc_21:Vertex3D = null;
            var _loc_22:Vertex3D = null;
            var _loc_3:* = this.segmentsW;
            var _loc_4:* = this.segmentsH;
            var _loc_5:* = _loc_3 + 1;
            var _loc_6:* = _loc_4 + 1;
            var _loc_7:* = this.geometry.vertices;
            var _loc_8:* = this.geometry.faces;
            var _loc_9:* = param1 / 2;
            var _loc_10:* = param2 / 2;
            var _loc_11:* = param1 / _loc_3;
            var _loc_12:* = param2 / _loc_4;
            var _loc_13:int = 0;
            while (_loc_13 < _loc_3 + 1)
            {
                
                _loc_17 = 0;
                while (_loc_17 < _loc_6)
                {
                    
                    _loc_18 = _loc_13 * _loc_11 - _loc_9;
                    _loc_19 = _loc_17 * _loc_12 - _loc_10;
                    _loc_7.push(new Vertex3D(_loc_18, _loc_19, 0));
                    _loc_17++;
                }
                _loc_13++;
            }
            _loc_13 = 0;
            while (_loc_13 < _loc_3)
            {
                
                _loc_17 = 0;
                while (_loc_17 < _loc_4)
                {
                    
                    _loc_20 = _loc_7[_loc_13 * _loc_6 + _loc_17];
                    _loc_21 = _loc_7[_loc_13 * _loc_6 + (_loc_17 + 1)];
                    _loc_22 = _loc_7[(_loc_13 + 1) * _loc_6 + _loc_17];
                    _loc_14 = new NumberUV(_loc_13 / _loc_3, _loc_17 / _loc_4);
                    _loc_15 = new NumberUV(_loc_13 / _loc_3, (_loc_17 + 1) / _loc_4);
                    _loc_16 = new NumberUV((_loc_13 + 1) / _loc_3, _loc_17 / _loc_4);
                    _loc_8.push(new Triangle3D(this, [_loc_20, _loc_22, _loc_21], material, [_loc_14, _loc_16, _loc_15]));
                    _loc_20 = _loc_7[(_loc_13 + 1) * _loc_6 + (_loc_17 + 1)];
                    _loc_21 = _loc_7[(_loc_13 + 1) * _loc_6 + _loc_17];
                    _loc_22 = _loc_7[_loc_13 * _loc_6 + (_loc_17 + 1)];
                    _loc_14 = new NumberUV((_loc_13 + 1) / _loc_3, (_loc_17 + 1) / _loc_4);
                    _loc_15 = new NumberUV((_loc_13 + 1) / _loc_3, _loc_17 / _loc_4);
                    _loc_16 = new NumberUV(_loc_13 / _loc_3, (_loc_17 + 1) / _loc_4);
                    _loc_8.push(new Triangle3D(this, [_loc_20, _loc_22, _loc_21], material, [_loc_14, _loc_16, _loc_15]));
                    _loc_17++;
                }
                _loc_13++;
            }
            this.geometry.ready = true;
            if (Papervision3D.useRIGHTHANDED)
            {
                this.geometry.flipFaces();
            }
            return;
        }// end function

    }
}
