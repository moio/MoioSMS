package org.papervision3d.core.culling
{
    import org.papervision3d.core.math.*;
    import org.papervision3d.objects.*;

    public class FrustumCuller extends Object implements IObjectCuller
    {
        private var _tang:Number;
        private var _near:Number;
        private var _ratio:Number;
        private var _fov:Number;
        private var _far:Number;
        private var _nh:Number;
        private var _fh:Number;
        private var _nw:Number;
        public var transform:Matrix3D;
        private var _sphereY:Number;
        private var _sphereX:Number;
        private var _fw:Number;
        public static const OUTSIDE:int = -1;
        public static const INSIDE:int = 1;
        public static const INTERSECT:int = 0;

        public function FrustumCuller()
        {
            this.transform = Matrix3D.IDENTITY;
            this.initialize();
            return;
        }// end function

        public function get ratio() : Number
        {
            return this._ratio;
        }// end function

        public function pointInFrustum(param1:Number, param2:Number, param3:Number) : int
        {
            var _loc_4:* = this.transform;
            var _loc_5:* = param1 - _loc_4.n14;
            var _loc_6:* = param2 - _loc_4.n24;
            var _loc_7:* = param3 - _loc_4.n34;
            var _loc_8:* = _loc_5 * _loc_4.n13 + _loc_6 * _loc_4.n23 + _loc_7 * _loc_4.n33;
            if (_loc_5 * _loc_4.n13 + _loc_6 * _loc_4.n23 + _loc_7 * _loc_4.n33 > this._far || _loc_8 < this._near)
            {
                return OUTSIDE;
            }
            var _loc_9:* = _loc_5 * _loc_4.n12 + _loc_6 * _loc_4.n22 + _loc_7 * _loc_4.n32;
            var _loc_10:* = _loc_8 * this._tang;
            if (_loc_9 > _loc_10 || _loc_9 < -_loc_10)
            {
                return OUTSIDE;
            }
            var _loc_11:* = _loc_5 * _loc_4.n11 + _loc_6 * _loc_4.n21 + _loc_7 * _loc_4.n31;
            _loc_10 = _loc_10 * this._ratio;
            if (_loc_11 > _loc_10 || _loc_11 < -_loc_10)
            {
                return OUTSIDE;
            }
            return INSIDE;
        }// end function

        public function get fov() : Number
        {
            return this._fov;
        }// end function

        public function set ratio(param1:Number) : void
        {
            this.initialize(this._fov, param1, this._near, this._far);
            return;
        }// end function

        public function set near(param1:Number) : void
        {
            this.initialize(this._fov, this._ratio, param1, this._far);
            return;
        }// end function

        public function set fov(param1:Number) : void
        {
            this.initialize(param1, this._ratio, this._near, this._far);
            return;
        }// end function

        public function get far() : Number
        {
            return this._far;
        }// end function

        public function initialize(param1:Number = 60, param2:Number = 1.333, param3:Number = 1, param4:Number = 5000) : void
        {
            this._fov = param1;
            this._ratio = param2;
            this._near = param3;
            this._far = param4;
            var _loc_5:* = Math.PI / 180 * this._fov * 0.5;
            this._tang = Math.tan(_loc_5);
            this._nh = this._near * this._tang;
            this._nw = this._nh * this._ratio;
            this._fh = this._far * this._tang;
            this._fw = this._fh * this._ratio;
            var _loc_6:* = Math.atan(this._tang * this._ratio);
            this._sphereX = 1 / Math.cos(_loc_6);
            this._sphereY = 1 / Math.cos(_loc_5);
            return;
        }// end function

        public function set far(param1:Number) : void
        {
            this.initialize(this._fov, this._ratio, this._near, param1);
            return;
        }// end function

        public function get near() : Number
        {
            return this._near;
        }// end function

        public function sphereInFrustum(param1:DisplayObject3D, param2:BoundingSphere) : int
        {
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_6:Number = NaN;
            var _loc_7:Number = NaN;
            var _loc_3:* = param2.radius * Math.max(param1.scaleX, Math.max(param1.scaleY, param1.scaleZ));
            var _loc_8:* = INSIDE;
            var _loc_9:* = this.transform;
            var _loc_10:* = param1.world.n14 - _loc_9.n14;
            var _loc_11:* = param1.world.n24 - _loc_9.n24;
            var _loc_12:* = param1.world.n34 - _loc_9.n34;
            _loc_7 = _loc_10 * _loc_9.n13 + _loc_11 * _loc_9.n23 + _loc_12 * _loc_9.n33;
            if (_loc_7 > this._far + _loc_3 || _loc_7 < this._near - _loc_3)
            {
                return OUTSIDE;
            }
            if (_loc_7 > this._far - _loc_3 || _loc_7 < this._near + _loc_3)
            {
                _loc_8 = INTERSECT;
            }
            _loc_6 = _loc_10 * _loc_9.n12 + _loc_11 * _loc_9.n22 + _loc_12 * _loc_9.n32;
            _loc_4 = this._sphereY * _loc_3;
            _loc_7 = _loc_7 * this._tang;
            if (_loc_6 > _loc_7 + _loc_4 || _loc_6 < -_loc_7 - _loc_4)
            {
                return OUTSIDE;
            }
            if (_loc_6 > _loc_7 - _loc_4 || _loc_6 < -_loc_7 + _loc_4)
            {
                _loc_8 = INTERSECT;
            }
            _loc_5 = _loc_10 * _loc_9.n11 + _loc_11 * _loc_9.n21 + _loc_12 * _loc_9.n31;
            _loc_7 = _loc_7 * this._ratio;
            _loc_4 = this._sphereX * _loc_3;
            if (_loc_5 > _loc_7 + _loc_4 || _loc_5 < -_loc_7 - _loc_4)
            {
                return OUTSIDE;
            }
            if (_loc_5 > _loc_7 - _loc_4 || _loc_5 < -_loc_7 + _loc_4)
            {
                _loc_8 = INTERSECT;
            }
            return _loc_8;
        }// end function

        public function testObject(param1:DisplayObject3D) : int
        {
            var _loc_2:* = INSIDE;
            if (!param1.geometry || !param1.geometry.vertices || !param1.geometry.vertices.length)
            {
                return _loc_2;
            }
            switch(param1.frustumTestMethod)
            {
                case FrustumTestMethod.BOUNDING_SPHERE:
                {
                    _loc_2 = this.sphereInFrustum(param1, param1.geometry.boundingSphere);
                    break;
                }
                case FrustumTestMethod.BOUNDING_BOX:
                {
                    _loc_2 = this.aabbInFrustum(param1, param1.geometry.aabb);
                    break;
                }
                case FrustumTestMethod.NO_TESTING:
                {
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function aabbInFrustum(param1:DisplayObject3D, param2:AxisAlignedBoundingBox, param3:Boolean = true) : int
        {
            var _loc_4:Vertex3D = null;
            var _loc_5:Number3D = null;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:* = param2.getBoxVertices();
            for each (_loc_4 in _loc_8)
            {
                
                _loc_5 = _loc_4.toNumber3D();
                Matrix3D.multiplyVector(param1.world, _loc_5);
                if (this.pointInFrustum(_loc_5.x, _loc_5.y, _loc_5.z) == INSIDE)
                {
                    _loc_6++;
                    if (param3)
                    {
                        return INSIDE;
                    }
                }
                else
                {
                    _loc_7++;
                }
                if (_loc_6 && _loc_7)
                {
                    return INTERSECT;
                }
            }
            if (_loc_6)
            {
                return _loc_6 < 8 ? (INTERSECT) : (INSIDE);
            }
            else
            {
                return OUTSIDE;
            }
        }// end function

    }
}
