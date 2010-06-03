package org.papervision3d.core.proto
{
    import flash.geom.*;
    import org.papervision3d.*;
    import org.papervision3d.core.culling.*;
    import org.papervision3d.core.log.*;
    import org.papervision3d.core.math.*;
    import org.papervision3d.core.render.data.*;
    import org.papervision3d.objects.*;

    public class CameraObject3D extends DisplayObject3D
    {
        protected var _orthoScale:Number = 1;
        public var culler:IObjectCuller;
        public var sort:Boolean;
        public var viewport:Rectangle;
        protected var _target:DisplayObject3D;
        protected var _orthoScaleMatrix:Matrix3D;
        public var eye:Matrix3D;
        protected var _ortho:Boolean;
        protected var _useCulling:Boolean;
        public var zoom:Number;
        public var yUP:Boolean;
        public var focus:Number;
        protected var _useProjectionMatrix:Boolean;
        protected var _far:Number;
        public static var DEFAULT_VIEWPORT:Rectangle = new Rectangle(0, 0, 550, 400);
        public static var DEFAULT_POS:Number3D = new Number3D(0, 0, -1000);
        public static var DEFAULT_UP:Number3D = new Number3D(0, 1, 0);
        private static var _flipY:Matrix3D = Matrix3D.scaleMatrix(1, -1, 1);

        public function CameraObject3D(param1:Number = 500, param2:Number = 3)
        {
            this.x = DEFAULT_POS.x;
            this.y = DEFAULT_POS.y;
            this.z = DEFAULT_POS.z;
            this.zoom = param2;
            this.focus = param1;
            this.eye = Matrix3D.IDENTITY;
            this.viewport = DEFAULT_VIEWPORT;
            this.sort = true;
            this._ortho = false;
            this._orthoScaleMatrix = Matrix3D.scaleMatrix(1, 1, 1);
            if (Papervision3D.useRIGHTHANDED)
            {
                DEFAULT_UP.y = -1;
                this.yUP = false;
                this.lookAt(DisplayObject3D.ZERO);
            }
            else
            {
                this.yUP = true;
            }
            return;
        }// end function

        public function get target() : DisplayObject3D
        {
            return this._target;
        }// end function

        public function get useProjectionMatrix() : Boolean
        {
            return this._useProjectionMatrix;
        }// end function

        public function set fov(param1:Number) : void
        {
            if (!this.viewport || this.viewport.isEmpty())
            {
                PaperLogger.warning("CameraObject3D#viewport not set, can\'t set fov!");
                return;
            }
            var _loc_2:Number = 0;
            var _loc_3:Number = 0;
            var _loc_4:Number = 0;
            if (this._target)
            {
                _loc_2 = this._target.world.n14;
                _loc_3 = this._target.world.n24;
                _loc_4 = this._target.world.n34;
            }
            var _loc_5:* = this.viewport.height / 2;
            var _loc_6:* = param1 / 2 * (Math.PI / 180);
            this.focus = _loc_5 / Math.tan(_loc_6) / this.zoom;
            return;
        }// end function

        public function pan(param1:Number) : void
        {
            return;
        }// end function

        public function get far() : Number
        {
            return this._far;
        }// end function

        public function set target(param1:DisplayObject3D) : void
        {
            this._target = param1;
            return;
        }// end function

        public function projectFaces(param1:Array, param2:DisplayObject3D, param3:RenderSessionData) : Number
        {
            return 0;
        }// end function

        public function get useCulling() : Boolean
        {
            return this._useCulling;
        }// end function

        public function set far(param1:Number) : void
        {
            if (param1 > this.focus)
            {
                this._far = param1;
            }
            return;
        }// end function

        public function get near() : Number
        {
            return this.focus;
        }// end function

        public function transformView(param1:Matrix3D = null) : void
        {
            if (this.yUP)
            {
                if (!param1)
                {
                }
                this.eye.calculateMultiply(this.transform, _flipY);
                this.eye.invert();
            }
            else
            {
                if (!param1)
                {
                }
                this.eye.calculateInverse(this.transform);
            }
            return;
        }// end function

        public function set useProjectionMatrix(param1:Boolean) : void
        {
            this._useProjectionMatrix = param1;
            return;
        }// end function

        public function tilt(param1:Number) : void
        {
            return;
        }// end function

        override public function lookAt(param1:DisplayObject3D, param2:Number3D = null) : void
        {
            if (this.yUP)
            {
                super.lookAt(param1, param2);
            }
            else
            {
                if (!param2)
                {
                }
                super.lookAt(param1, DEFAULT_UP);
            }
            return;
        }// end function

        public function get ortho() : Boolean
        {
            return this._ortho;
        }// end function

        public function orbit(param1:Number, param2:Number, param3:Boolean = true, param4:DisplayObject3D = null) : void
        {
            return;
        }// end function

        public function get fov() : Number
        {
            if (!this.viewport || this.viewport.isEmpty())
            {
                PaperLogger.warning("CameraObject3D#viewport not set, can\'t calculate fov!");
                return NaN;
            }
            var _loc_1:Number = 0;
            var _loc_2:Number = 0;
            var _loc_3:Number = 0;
            if (this._target)
            {
                _loc_1 = this._target.world.n14;
                _loc_2 = this._target.world.n24;
                _loc_3 = this._target.world.n34;
            }
            var _loc_4:* = this.x - _loc_1;
            var _loc_5:* = this.y - _loc_2;
            var _loc_6:* = this.z - _loc_3;
            var _loc_7:* = this.focus;
            var _loc_8:* = this.zoom;
            var _loc_9:* = Math.sqrt(_loc_4 * _loc_4 + _loc_5 * _loc_5 + _loc_6 * _loc_6) + _loc_7;
            var _loc_10:* = this.viewport.height / 2;
            var _loc_11:* = 180 / Math.PI;
            return Math.atan(_loc_9 / _loc_7 / _loc_8 * _loc_10 / _loc_9) * _loc_11 * 2;
        }// end function

        public function set near(param1:Number) : void
        {
            if (param1 > 0)
            {
                this.focus = param1;
            }
            return;
        }// end function

        public function set useCulling(param1:Boolean) : void
        {
            this._useCulling = param1;
            return;
        }// end function

        public function set orthoScale(param1:Number) : void
        {
            this._orthoScale = param1 > 0 ? (param1) : (0.0001);
            this._orthoScaleMatrix.n11 = this._orthoScale;
            this._orthoScaleMatrix.n22 = this._orthoScale;
            this._orthoScaleMatrix.n33 = this._orthoScale;
            return;
        }// end function

        public function unproject(param1:Number, param2:Number) : Number3D
        {
            var _loc_3:* = this.focus * this.zoom / this.focus;
            var _loc_4:* = new Number3D(param1 / _loc_3, (-param2) / _loc_3, this.focus);
            Matrix3D.multiplyVector3x3(transform, _loc_4);
            return _loc_4;
        }// end function

        public function set ortho(param1:Boolean) : void
        {
            this._ortho = param1;
            return;
        }// end function

        public function projectVertices(param1:Array, param2:DisplayObject3D, param3:RenderSessionData) : Number
        {
            return 0;
        }// end function

        public function get orthoScale() : Number
        {
            return this._orthoScale;
        }// end function

    }
}
