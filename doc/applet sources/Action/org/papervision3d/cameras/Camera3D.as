package org.papervision3d.cameras
{
    import flash.geom.*;
    import flash.utils.*;
    import org.papervision3d.core.culling.*;
    import org.papervision3d.core.math.*;
    import org.papervision3d.core.proto.*;
    import org.papervision3d.core.render.data.*;
    import org.papervision3d.objects.*;

    public class Camera3D extends CameraObject3D
    {
        protected var _focusFix:Matrix3D;
        protected var _prevUseProjection:Boolean;
        protected var _prevZoom:Number;
        protected var _prevOrtho:Boolean;
        protected var _prevWidth:Number;
        protected var _prevHeight:Number;
        protected var _prevFocus:Number;
        protected var _prevOrthoProjection:Boolean;
        protected var _projection:Matrix3D;

        public function Camera3D(param1:Number = 60, param2:Number = 10, param3:Number = 5000, param4:Boolean = false, param5:Boolean = false)
        {
            super(param2, 40);
            this.fov = param1;
            this._prevFocus = 0;
            this._prevZoom = 0;
            this._prevOrtho = false;
            this._prevUseProjection = false;
            _useCulling = param4;
            _useProjectionMatrix = param5;
            _far = param3;
            this._focusFix = Matrix3D.IDENTITY;
            return;
        }// end function

        public function update(param1:Rectangle) : void
        {
            if (!param1)
            {
                throw new Error("Camera3D#update: Invalid viewport rectangle! " + param1);
            }
            this.viewport = param1;
            this._prevFocus = this.focus;
            this._prevZoom = this.zoom;
            this._prevWidth = this.viewport.width;
            this._prevHeight = this.viewport.height;
            if (this._prevOrtho != this.ortho)
            {
                if (this.ortho)
                {
                    this._prevOrthoProjection = this.useProjectionMatrix;
                    this.useProjectionMatrix = true;
                }
                else
                {
                    this.useProjectionMatrix = this._prevOrthoProjection;
                }
            }
            else if (this._prevUseProjection != _useProjectionMatrix)
            {
                this.useProjectionMatrix = this._useProjectionMatrix;
            }
            this._prevOrtho = this.ortho;
            this._prevUseProjection = _useProjectionMatrix;
            this.useCulling = _useCulling;
            return;
        }// end function

        override public function set near(param1:Number) : void
        {
            if (param1 > 0)
            {
                this.focus = param1;
                this.update(this.viewport);
            }
            return;
        }// end function

        override public function orbit(param1:Number, param2:Number, param3:Boolean = true, param4:DisplayObject3D = null) : void
        {
            var _loc_8:Number = NaN;
            if (!param4)
            {
            }
            param4 = _target;
            if (!param4)
            {
            }
            param4 = DisplayObject3D.ZERO;
            if (param3)
            {
                param1 = param1 * (Math.PI / 180);
                param2 = param2 * (Math.PI / 180);
            }
            var _loc_5:* = param4.world.n14 - this.x;
            var _loc_6:* = param4.world.n24 - this.y;
            var _loc_7:* = param4.world.n34 - this.z;
            _loc_8 = Math.sqrt(_loc_5 * _loc_5 + _loc_6 * _loc_6 + _loc_7 * _loc_7);
            var _loc_9:* = Math.cos(param2) * Math.sin(param1);
            var _loc_10:* = Math.sin(param2) * Math.sin(param1);
            var _loc_11:* = Math.cos(param1);
            this.x = param4.world.n14 + _loc_9 * _loc_8;
            this.y = param4.world.n24 + _loc_11 * _loc_8;
            this.z = param4.world.n34 + _loc_10 * _loc_8;
            this.lookAt(param4);
            return;
        }// end function

        override public function set useCulling(param1:Boolean) : void
        {
            super.useCulling = param1;
            if (_useCulling)
            {
                if (!this.culler)
                {
                    this.culler = new FrustumCuller();
                }
                FrustumCuller(this.culler).initialize(this.fov, this.viewport.width / this.viewport.height, this.focus / this.zoom, _far);
            }
            else
            {
                this.culler = null;
            }
            return;
        }// end function

        override public function projectFaces(param1:Array, param2:DisplayObject3D, param3:RenderSessionData) : Number
        {
            var _loc_17:Number = NaN;
            var _loc_18:Number = NaN;
            var _loc_19:Number = NaN;
            var _loc_20:Number = NaN;
            var _loc_21:Number = NaN;
            var _loc_22:Number = NaN;
            var _loc_23:Number = NaN;
            var _loc_24:Vertex3D = null;
            var _loc_25:Vertex3DInstance = null;
            var _loc_26:Number = NaN;
            var _loc_34:Array = null;
            var _loc_36:Triangle3D = null;
            var _loc_4:* = param2.view;
            var _loc_5:* = param2.view.n11;
            var _loc_6:* = _loc_4.n12;
            var _loc_7:* = _loc_4.n13;
            var _loc_8:* = _loc_4.n21;
            var _loc_9:* = _loc_4.n22;
            var _loc_10:* = _loc_4.n23;
            var _loc_11:* = _loc_4.n31;
            var _loc_12:* = _loc_4.n32;
            var _loc_13:* = _loc_4.n33;
            var _loc_14:* = _loc_4.n41;
            var _loc_15:* = _loc_4.n42;
            var _loc_16:* = _loc_4.n43;
            var _loc_27:int = 0;
            var _loc_28:* = param3.camera.focus;
            var _loc_29:* = param3.camera.focus * param3.camera.zoom;
            var _loc_30:* = viewport.width / 2;
            var _loc_31:* = viewport.height / 2;
            var _loc_32:* = param3.camera.far;
            var _loc_33:* = param3.camera.far - _loc_28;
            var _loc_35:* = getTimer();
            for each (_loc_36 in param1)
            {
                
                _loc_34 = _loc_36.vertices;
                _loc_27 = _loc_34.length;
                do
                {
                    
                    if (_loc_24.timestamp == _loc_35)
                    {
                    }
                    else
                    {
                        _loc_24.timestamp = _loc_35;
                        _loc_17 = _loc_24.x;
                        _loc_18 = _loc_24.y;
                        _loc_19 = _loc_24.z;
                        _loc_22 = _loc_17 * _loc_11 + _loc_18 * _loc_12 + _loc_19 * _loc_13 + _loc_4.n34;
                        _loc_25 = _loc_24.vertex3DInstance;
                        if (_useProjectionMatrix)
                        {
                            _loc_23 = _loc_17 * _loc_14 + _loc_18 * _loc_15 + _loc_19 * _loc_16 + _loc_4.n44;
                            _loc_22 = _loc_22 / _loc_23;
                            if (_loc_22 > 0)
                            {
                            }
                            var _loc_39:* = _loc_22 < 1;
                            _loc_25.visible = _loc_22 < 1;
                            if (_loc_39)
                            {
                                _loc_20 = (_loc_17 * _loc_5 + _loc_18 * _loc_6 + _loc_19 * _loc_7 + _loc_4.n14) / _loc_23;
                                _loc_21 = (_loc_17 * _loc_8 + _loc_18 * _loc_9 + _loc_19 * _loc_10 + _loc_4.n24) / _loc_23;
                                _loc_25.x = _loc_20 * _loc_30;
                                _loc_25.y = _loc_21 * _loc_31;
                                _loc_25.z = _loc_22 * _loc_23;
                            }
                        }
                        else
                        {
                            var _loc_39:* = _loc_28 + _loc_22 > 0;
                            _loc_25.visible = _loc_28 + _loc_22 > 0;
                            if (_loc_39)
                            {
                                _loc_20 = _loc_17 * _loc_5 + _loc_18 * _loc_6 + _loc_19 * _loc_7 + _loc_4.n14;
                                _loc_21 = _loc_17 * _loc_8 + _loc_18 * _loc_9 + _loc_19 * _loc_10 + _loc_4.n24;
                                _loc_26 = _loc_29 / (_loc_28 + _loc_22);
                                _loc_25.x = _loc_20 * _loc_26;
                                _loc_25.y = _loc_21 * _loc_26;
                                _loc_25.z = _loc_22;
                            }
                        }
                    }
                    var _loc_39:* = _loc_34[--_loc_27];
                    _loc_24 = _loc_34[--_loc_27];
                }while (_loc_39)
            }
            return 0;
        }// end function

        override public function set orthoScale(param1:Number) : void
        {
            super.orthoScale = param1;
            this.useProjectionMatrix = this.useProjectionMatrix;
            this._prevOrtho = !this.ortho;
            this.update(this.viewport);
            return;
        }// end function

        override public function set useProjectionMatrix(param1:Boolean) : void
        {
            var _loc_2:Number = NaN;
            var _loc_3:Number = NaN;
            if (param1)
            {
                if (this.ortho)
                {
                    _loc_2 = viewport.width / 2;
                    _loc_3 = viewport.height / 2;
                    this._projection = createOrthoMatrix(-_loc_2, _loc_2, -_loc_3, _loc_3, -_far, _far);
                    this._projection = Matrix3D.multiply(_orthoScaleMatrix, this._projection);
                }
                else
                {
                    this._projection = createPerspectiveMatrix(fov, viewport.width / viewport.height, this.focus, this.far);
                }
            }
            else if (this.ortho)
            {
                param1 = true;
            }
            super.useProjectionMatrix = param1;
            return;
        }// end function

        override public function transformView(param1:Matrix3D = null) : void
        {
            if (ortho != this._prevOrtho || this._prevUseProjection != _useProjectionMatrix || focus != this._prevFocus || zoom != this._prevZoom || viewport.width != this._prevWidth || viewport.height != this._prevHeight)
            {
                this.update(viewport);
            }
            if (_target)
            {
                lookAt(_target);
            }
            else if (_transformDirty)
            {
                updateTransform();
            }
            if (_useProjectionMatrix)
            {
                super.transformView();
                this.eye.calculateMultiply4x4(this._projection, this.eye);
            }
            else
            {
                this._focusFix.copy(this.transform);
                this._focusFix.n14 = this._focusFix.n14 + focus * this.transform.n13;
                this._focusFix.n24 = this._focusFix.n24 + focus * this.transform.n23;
                this._focusFix.n34 = this._focusFix.n34 + focus * this.transform.n33;
                super.transformView(this._focusFix);
            }
            if (culler is FrustumCuller)
            {
                FrustumCuller(culler).transform.copy(this.transform);
            }
            return;
        }// end function

        override public function set far(param1:Number) : void
        {
            if (param1 > this.focus)
            {
                _far = param1;
                this.update(this.viewport);
            }
            return;
        }// end function

        override public function projectVertices(param1:Array, param2:DisplayObject3D, param3:RenderSessionData) : Number
        {
            var _loc_17:Number = NaN;
            var _loc_18:Number = NaN;
            var _loc_19:Number = NaN;
            var _loc_20:Number = NaN;
            var _loc_21:Number = NaN;
            var _loc_22:Number = NaN;
            var _loc_23:Number = NaN;
            var _loc_24:Vertex3D = null;
            var _loc_25:Vertex3DInstance = null;
            var _loc_26:Number = NaN;
            var _loc_4:* = param2.view;
            var _loc_5:* = param2.view.n11;
            var _loc_6:* = _loc_4.n12;
            var _loc_7:* = _loc_4.n13;
            var _loc_8:* = _loc_4.n21;
            var _loc_9:* = _loc_4.n22;
            var _loc_10:* = _loc_4.n23;
            var _loc_11:* = _loc_4.n31;
            var _loc_12:* = _loc_4.n32;
            var _loc_13:* = _loc_4.n33;
            var _loc_14:* = _loc_4.n41;
            var _loc_15:* = _loc_4.n42;
            var _loc_16:* = _loc_4.n43;
            var _loc_27:* = param1.length;
            var _loc_28:* = param3.camera.focus;
            var _loc_29:* = param3.camera.focus * param3.camera.zoom;
            var _loc_30:* = viewport.width / 2;
            var _loc_31:* = viewport.height / 2;
            var _loc_32:* = param3.camera.far;
            var _loc_33:* = param3.camera.far - _loc_28;
            do
            {
                
                _loc_17 = _loc_24.x;
                _loc_18 = _loc_24.y;
                _loc_19 = _loc_24.z;
                _loc_22 = _loc_17 * _loc_11 + _loc_18 * _loc_12 + _loc_19 * _loc_13 + _loc_4.n34;
                _loc_25 = _loc_24.vertex3DInstance;
                if (_useProjectionMatrix)
                {
                    _loc_23 = _loc_17 * _loc_14 + _loc_18 * _loc_15 + _loc_19 * _loc_16 + _loc_4.n44;
                    _loc_22 = _loc_22 / _loc_23;
                    if (_loc_22 > 0)
                    {
                    }
                    var _loc_34:* = _loc_22 < 1;
                    _loc_25.visible = _loc_22 < 1;
                    if (_loc_34)
                    {
                        _loc_20 = (_loc_17 * _loc_5 + _loc_18 * _loc_6 + _loc_19 * _loc_7 + _loc_4.n14) / _loc_23;
                        _loc_21 = (_loc_17 * _loc_8 + _loc_18 * _loc_9 + _loc_19 * _loc_10 + _loc_4.n24) / _loc_23;
                        _loc_25.x = _loc_20 * _loc_30;
                        _loc_25.y = _loc_21 * _loc_31;
                        _loc_25.z = _loc_22 * _loc_23;
                    }
                }
                else
                {
                    var _loc_34:* = _loc_28 + _loc_22 > 0;
                    _loc_25.visible = _loc_28 + _loc_22 > 0;
                    if (_loc_34)
                    {
                        _loc_20 = _loc_17 * _loc_5 + _loc_18 * _loc_6 + _loc_19 * _loc_7 + _loc_4.n14;
                        _loc_21 = _loc_17 * _loc_8 + _loc_18 * _loc_9 + _loc_19 * _loc_10 + _loc_4.n24;
                        _loc_26 = _loc_29 / (_loc_28 + _loc_22);
                        _loc_25.x = _loc_20 * _loc_26;
                        _loc_25.y = _loc_21 * _loc_26;
                        _loc_25.z = _loc_22;
                    }
                }
                var _loc_34:* = param1[--_loc_27];
                _loc_24 = param1[--_loc_27];
            }while (_loc_34)
            return 0;
        }// end function

        public static function createPerspectiveMatrix(param1:Number, param2:Number, param3:Number, param4:Number) : Matrix3D
        {
            var _loc_5:* = param1 / 2 * (Math.PI / 180);
            var _loc_6:* = Math.tan(_loc_5);
            var _loc_7:* = 1 / _loc_6;
            return new Matrix3D([_loc_7 / param2, 0, 0, 0, 0, _loc_7, 0, 0, 0, 0, -(param3 + param4) / (param3 - param4), 2 * param4 * param3 / (param3 - param4), 0, 0, 1, 0]);
        }// end function

        public static function createOrthoMatrix(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : Matrix3D
        {
            var _loc_7:* = (param2 + param1) / (param2 - param1);
            var _loc_8:* = (param4 + param3) / (param4 - param3);
            var _loc_9:* = (param6 + param5) / (param6 - param5);
            var _loc_10:* = new Matrix3D([2 / (param2 - param1), 0, 0, _loc_7, 0, 2 / (param4 - param3), 0, _loc_8, 0, 0, -2 / (param6 - param5), _loc_9, 0, 0, 0, 1]);
            new Matrix3D([2 / (param2 - param1), 0, 0, _loc_7, 0, 2 / (param4 - param3), 0, _loc_8, 0, 0, -2 / (param6 - param5), _loc_9, 0, 0, 0, 1]).calculateMultiply(Matrix3D.scaleMatrix(1, 1, -1), _loc_10);
            return _loc_10;
        }// end function

    }
}
