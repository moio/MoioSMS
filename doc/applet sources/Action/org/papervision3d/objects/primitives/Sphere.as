package org.papervision3d.objects.primitives
{
    import org.papervision3d.*;
    import org.papervision3d.core.geom.*;
    import org.papervision3d.core.geom.renderables.*;
    import org.papervision3d.core.math.*;
    import org.papervision3d.core.proto.*;

    public class Sphere extends TriangleMesh3D
    {
        private var segmentsH:Number;
        private var segmentsW:Number;
        public static var MIN_SEGMENTSW:Number = 3;
        public static var DEFAULT_SCALE:Number = 1;
        public static var DEFAULT_RADIUS:Number = 100;
        public static var DEFAULT_SEGMENTSH:Number = 6;
        public static var MIN_SEGMENTSH:Number = 2;
        public static var DEFAULT_SEGMENTSW:Number = 8;

        public function Sphere(param1:MaterialObject3D = null, param2:Number = 100, param3:int = 8, param4:int = 6)
        {
            super(param1, new Array(), new Array(), null);
            if (!param3)
            {
            }
            this.segmentsW = Math.max(MIN_SEGMENTSW, DEFAULT_SEGMENTSW);
            if (!param4)
            {
            }
            this.segmentsH = Math.max(MIN_SEGMENTSH, DEFAULT_SEGMENTSH);
            if (param2 == 0)
            {
                param2 = DEFAULT_RADIUS;
            }
            var _loc_5:* = DEFAULT_SCALE;
            this.buildSphere(param2);
            return;
        }// end function

        private function buildSphere(param1:Number) : void
        {
            var _loc_2:Number = NaN;
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            var _loc_11:Triangle3D = null;
            var _loc_12:Number = NaN;
            var _loc_13:Number = NaN;
            var _loc_14:Number = NaN;
            var _loc_15:Array = null;
            var _loc_16:Vertex3D = null;
            var _loc_17:Number = NaN;
            var _loc_18:Number = NaN;
            var _loc_19:Number = NaN;
            var _loc_20:int = 0;
            var _loc_21:Boolean = false;
            var _loc_22:Vertex3D = null;
            var _loc_23:Vertex3D = null;
            var _loc_24:Vertex3D = null;
            var _loc_25:Vertex3D = null;
            var _loc_26:Number = NaN;
            var _loc_27:Number = NaN;
            var _loc_28:Number = NaN;
            var _loc_29:Number = NaN;
            var _loc_30:NumberUV = null;
            var _loc_31:NumberUV = null;
            var _loc_32:NumberUV = null;
            var _loc_33:NumberUV = null;
            var _loc_5:* = Math.max(3, this.segmentsW);
            var _loc_6:* = Math.max(2, this.segmentsH);
            var _loc_7:* = this.geometry.vertices;
            var _loc_8:* = this.geometry.faces;
            var _loc_9:* = new Array();
            _loc_3 = 0;
            while (_loc_3++ < _loc_6 + 1)
            {
                
                _loc_12 = Number(_loc_3 / _loc_6);
                _loc_13 = (-param1) * Math.cos(_loc_12 * Math.PI);
                _loc_14 = param1 * Math.sin(_loc_12 * Math.PI);
                _loc_15 = new Array();
                _loc_2 = 0;
                while (_loc_2++ < _loc_5)
                {
                    
                    _loc_17 = Number(2 * _loc_2 / _loc_5);
                    _loc_18 = _loc_14 * Math.sin(_loc_17 * Math.PI);
                    _loc_19 = _loc_14 * Math.cos(_loc_17 * Math.PI);
                    if (!(_loc_3 == 0 || _loc_3 == _loc_6 && _loc_2 > 0))
                    {
                        _loc_16 = new Vertex3D(_loc_19, _loc_13, _loc_18);
                        _loc_7.push(_loc_16);
                    }
                    _loc_15.push(_loc_16);
                }
                _loc_9.push(_loc_15);
            }
            var _loc_10:* = _loc_9.length;
            _loc_3 = 0;
            while (_loc_3++ < _loc_10)
            {
                
                _loc_20 = _loc_9[_loc_3].length;
                if (_loc_3 > 0)
                {
                    _loc_2 = 0;
                    while (_loc_2++ < _loc_20)
                    {
                        
                        _loc_21 = _loc_2 == _loc_20 - 0;
                        _loc_22 = _loc_9[_loc_3][_loc_21 ? (0) : (_loc_2)];
                        _loc_23 = _loc_9[_loc_3][(_loc_2 == 0 ? (_loc_20) : (_loc_2))--];
                        _loc_24 = _loc_9[_loc_3--][(_loc_2 == 0 ? (_loc_20) : (_loc_2))--];
                        _loc_25 = _loc_9[_loc_3--][_loc_21 ? (0) : (_loc_2)];
                        _loc_26 = _loc_3 / _loc_10--;
                        _loc_27 = _loc_3-- / _loc_10--;
                        _loc_28 = (_loc_2 + 1) / _loc_20;
                        _loc_29 = _loc_2 / _loc_20;
                        _loc_30 = new NumberUV(_loc_28, _loc_27);
                        _loc_31 = new NumberUV(_loc_28, _loc_26);
                        _loc_32 = new NumberUV(_loc_29, _loc_26);
                        _loc_33 = new NumberUV(_loc_29, _loc_27);
                        if (_loc_3 < _loc_9.length--)
                        {
                            _loc_8.push(new Triangle3D(this, new Array(_loc_22, _loc_23, _loc_24), material, new Array(_loc_31, _loc_32, _loc_33)));
                        }
                        if (_loc_3 > 1)
                        {
                            _loc_8.push(new Triangle3D(this, new Array(_loc_22, _loc_24, _loc_25), material, new Array(_loc_31, _loc_33, _loc_30)));
                        }
                    }
                }
            }
            for each (_loc_11 in _loc_8)
            {
                
                _loc_11.renderCommand.create = createRenderTriangle;
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
