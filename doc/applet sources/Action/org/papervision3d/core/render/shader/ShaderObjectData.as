package org.papervision3d.core.render.shader
{
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;
    import org.papervision3d.core.geom.renderables.*;
    import org.papervision3d.materials.*;
    import org.papervision3d.materials.shaders.*;
    import org.papervision3d.objects.*;

    public class ShaderObjectData extends Object
    {
        public var shaderRenderer:ShaderRenderer;
        public var triangleUVS:Dictionary;
        public var renderTriangleUVS:Dictionary;
        public var lightMatrices:Dictionary;
        public var shadedMaterial:ShadedMaterial;
        public var uvMatrices:Dictionary;
        private var origin:Point;
        public var material:BitmapMaterial;
        public var triangleRects:Dictionary;
        protected var triangleBitmaps:Dictionary;
        public var object:DisplayObject3D;

        public function ShaderObjectData(param1:DisplayObject3D, param2:BitmapMaterial, param3:ShadedMaterial) : void
        {
            this.origin = new Point(0, 0);
            this.shaderRenderer = new ShaderRenderer();
            this.lightMatrices = new Dictionary();
            this.uvMatrices = new Dictionary();
            this.object = param1;
            this.material = param2;
            this.shadedMaterial = param3;
            this.triangleUVS = new Dictionary();
            this.renderTriangleUVS = new Dictionary();
            this.triangleBitmaps = new Dictionary();
            this.triangleRects = new Dictionary();
            return;
        }// end function

        public function getPerTriUVForDraw(param1:Triangle3D) : Matrix
        {
            var _loc_2:Matrix = null;
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_6:Number = NaN;
            var _loc_7:Number = NaN;
            var _loc_8:Number = NaN;
            var _loc_9:Number = NaN;
            var _loc_10:Number = NaN;
            var _loc_11:Rectangle = null;
            if (!this.triangleUVS[param1])
            {
                var _loc_12:* = new Matrix();
                this.triangleUVS[param1] = new Matrix();
                _loc_2 = _loc_12;
                _loc_3 = this.material.bitmap.width;
                _loc_4 = this.material.bitmap.height;
                _loc_5 = param1.uv[0].u * _loc_3;
                _loc_6 = (1 - param1.uv[0].v) * _loc_4;
                _loc_7 = param1.uv[1].u * _loc_3;
                _loc_8 = (1 - param1.uv[1].v) * _loc_4;
                _loc_9 = param1.uv[2].u * _loc_3;
                _loc_10 = (1 - param1.uv[2].v) * _loc_4;
                _loc_11 = this.getRectFor(param1);
                _loc_2.tx = _loc_5 - _loc_11.x;
                _loc_2.ty = _loc_6 - _loc_11.y;
                _loc_2.a = _loc_7 - _loc_5;
                _loc_2.b = _loc_8 - _loc_6;
                _loc_2.c = _loc_9 - _loc_5;
                _loc_2.d = _loc_10 - _loc_6;
                _loc_2.invert();
            }
            return this.triangleUVS[param1];
        }// end function

        public function getRectFor(param1:Triangle3D) : Rectangle
        {
            var _loc_2:Number = NaN;
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_6:Number = NaN;
            var _loc_7:Number = NaN;
            var _loc_8:Number = NaN;
            var _loc_9:Number = NaN;
            var _loc_10:Number = NaN;
            var _loc_11:Number = NaN;
            var _loc_12:Number = NaN;
            var _loc_13:Number = NaN;
            var _loc_14:Number = NaN;
            var _loc_15:Number = NaN;
            if (!this.triangleRects[param1])
            {
                _loc_2 = this.material.bitmap.width;
                _loc_3 = this.material.bitmap.height;
                _loc_4 = param1.uv[0].u * _loc_2;
                _loc_5 = (1 - param1.uv[0].v) * _loc_3;
                _loc_6 = param1.uv[1].u * _loc_2;
                _loc_7 = (1 - param1.uv[1].v) * _loc_3;
                _loc_8 = param1.uv[2].u * _loc_2;
                _loc_9 = (1 - param1.uv[2].v) * _loc_3;
                _loc_10 = Math.min(Math.min(_loc_4, _loc_6), _loc_8);
                _loc_11 = Math.min(Math.min(_loc_5, _loc_7), _loc_9);
                _loc_12 = Math.max(Math.max(_loc_4, _loc_6), _loc_8);
                _loc_13 = Math.max(Math.max(_loc_5, _loc_7), _loc_9);
                _loc_14 = _loc_12 - _loc_10;
                _loc_15 = _loc_13 - _loc_11;
                if (_loc_14 <= 0)
                {
                    _loc_14 = 1;
                }
                if (_loc_15 <= 0)
                {
                    _loc_15 = 1;
                }
                var _loc_16:* = new Rectangle(_loc_10, _loc_11, _loc_14, _loc_15);
                this.triangleRects[param1] = new Rectangle(_loc_10, _loc_11, _loc_14, _loc_15);
                return _loc_16;
            }
            return this.triangleRects[param1];
        }// end function

        private function perturbUVMatrix(param1:Matrix, param2:Triangle3D, param3:Number = 2) : void
        {
            var _loc_4:* = this.material.bitmap.width;
            var _loc_5:* = this.material.bitmap.height;
            var _loc_6:* = param2.uv[0].u;
            var _loc_7:* = 1 - param2.uv[0].v;
            var _loc_8:* = param2.uv[1].u;
            var _loc_9:* = 1 - param2.uv[1].v;
            var _loc_10:* = param2.uv[2].u;
            var _loc_11:* = 1 - param2.uv[2].v;
            var _loc_12:* = _loc_6 * _loc_4;
            var _loc_13:* = _loc_7 * _loc_5;
            var _loc_14:* = _loc_8 * _loc_4;
            var _loc_15:* = _loc_9 * _loc_5;
            var _loc_16:* = _loc_10 * _loc_4;
            var _loc_17:* = _loc_11 * _loc_5;
            var _loc_18:* = (_loc_10 + _loc_8 + _loc_6) / 3;
            var _loc_19:* = (_loc_11 + _loc_9 + _loc_7) / 3;
            var _loc_20:* = _loc_6 - _loc_18;
            var _loc_21:* = _loc_7 - _loc_19;
            var _loc_22:* = _loc_8 - _loc_18;
            var _loc_23:* = _loc_9 - _loc_19;
            var _loc_24:* = _loc_10 - _loc_18;
            var _loc_25:* = _loc_11 - _loc_19;
            var _loc_26:* = _loc_20 < 0 ? (-_loc_20) : (_loc_20);
            var _loc_27:* = _loc_21 < 0 ? (-_loc_21) : (_loc_21);
            var _loc_28:* = _loc_22 < 0 ? (-_loc_22) : (_loc_22);
            var _loc_29:* = _loc_23 < 0 ? (-_loc_23) : (_loc_23);
            var _loc_30:* = _loc_24 < 0 ? (-_loc_24) : (_loc_24);
            var _loc_31:* = _loc_25 < 0 ? (-_loc_25) : (_loc_25);
            var _loc_32:* = _loc_26 > _loc_27 ? (1 / _loc_26) : (1 / _loc_27);
            var _loc_33:* = _loc_28 > _loc_29 ? (1 / _loc_28) : (1 / _loc_29);
            var _loc_34:* = _loc_30 > _loc_31 ? (1 / _loc_30) : (1 / _loc_31);
            _loc_12 = _loc_12 - (-_loc_20) * _loc_32 * param3;
            _loc_13 = _loc_13 - (-_loc_21) * _loc_32 * param3;
            _loc_14 = _loc_14 - (-_loc_22) * _loc_33 * param3;
            _loc_15 = _loc_15 - (-_loc_23) * _loc_33 * param3;
            _loc_16 = _loc_16 - (-_loc_24) * _loc_34 * param3;
            _loc_17 = _loc_17 - (-_loc_25) * _loc_34 * param3;
            param1.tx = _loc_12;
            param1.ty = _loc_13;
            param1.a = _loc_14 - _loc_12;
            param1.b = _loc_15 - _loc_13;
            param1.c = _loc_16 - _loc_12;
            param1.d = _loc_17 - _loc_13;
            return;
        }// end function

        public function getOutputBitmapFor(param1:Triangle3D) : BitmapData
        {
            var _loc_2:Rectangle = null;
            var _loc_3:BitmapData = null;
            var _loc_4:Rectangle = null;
            if (!this.triangleBitmaps[param1])
            {
                _loc_2 = this.getRectFor(param1);
                var _loc_5:* = new BitmapData(Math.ceil(_loc_2.width), Math.ceil(_loc_2.height), false, 0);
                this.triangleBitmaps[param1] = new BitmapData(Math.ceil(_loc_2.width), Math.ceil(_loc_2.height), false, 0);
                _loc_3 = _loc_5;
                _loc_4 = new Rectangle(0, 0, _loc_3.width, _loc_3.height);
                _loc_3.copyPixels(this.material.bitmap, _loc_4, this.origin);
            }
            else
            {
                _loc_2 = this.getRectFor(param1);
            }
            if (this.material.bitmap && _loc_2)
            {
                this.triangleBitmaps[param1].copyPixels(this.material.bitmap, _loc_2, this.origin);
            }
            return this.triangleBitmaps[param1];
        }// end function

        public function updateBeforeRender() : void
        {
            return;
        }// end function

        public function getPerTriUVForShader(param1:Triangle3D) : Matrix
        {
            var _loc_2:Matrix = null;
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_6:Number = NaN;
            var _loc_7:Number = NaN;
            var _loc_8:Number = NaN;
            var _loc_9:Number = NaN;
            var _loc_10:Number = NaN;
            var _loc_11:Rectangle = null;
            if (!this.renderTriangleUVS[param1])
            {
                var _loc_12:* = new Matrix();
                this.renderTriangleUVS[param1] = new Matrix();
                _loc_2 = _loc_12;
                _loc_3 = this.material.bitmap.width;
                _loc_4 = this.material.bitmap.height;
                _loc_5 = param1.uv[0].u * _loc_3;
                _loc_6 = (1 - param1.uv[0].v) * _loc_4;
                _loc_7 = param1.uv[1].u * _loc_3;
                _loc_8 = (1 - param1.uv[1].v) * _loc_4;
                _loc_9 = param1.uv[2].u * _loc_3;
                _loc_10 = (1 - param1.uv[2].v) * _loc_4;
                _loc_11 = this.getRectFor(param1);
                _loc_2.tx = _loc_5 - _loc_11.x;
                _loc_2.ty = _loc_6 - _loc_11.y;
                _loc_2.a = _loc_7 - _loc_5;
                _loc_2.b = _loc_8 - _loc_6;
                _loc_2.c = _loc_9 - _loc_5;
                _loc_2.d = _loc_10 - _loc_6;
            }
            return this.renderTriangleUVS[param1];
        }// end function

        public function getUVMatrixForTriangle(param1:Triangle3D, param2:Boolean = false) : Matrix
        {
            var _loc_3:Matrix = null;
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_6:Number = NaN;
            var _loc_7:Number = NaN;
            var _loc_8:Number = NaN;
            var _loc_9:Number = NaN;
            var _loc_10:Number = NaN;
            var _loc_11:Number = NaN;
            var _loc_12:* = this.uvMatrices[param1];
            _loc_3 = this.uvMatrices[param1];
            if (!_loc_12)
            {
                _loc_3 = new Matrix();
                if (param2)
                {
                    this.perturbUVMatrix(_loc_3, param1, 2);
                }
                else if (this.material.bitmap)
                {
                    _loc_4 = this.material.bitmap.width;
                    _loc_5 = this.material.bitmap.height;
                    _loc_6 = param1.uv[0].u * _loc_4;
                    _loc_7 = (1 - param1.uv[0].v) * _loc_5;
                    _loc_8 = param1.uv[1].u * _loc_4;
                    _loc_9 = (1 - param1.uv[1].v) * _loc_5;
                    _loc_10 = param1.uv[2].u * _loc_4;
                    _loc_11 = (1 - param1.uv[2].v) * _loc_5;
                    _loc_3.tx = _loc_6;
                    _loc_3.ty = _loc_7;
                    _loc_3.a = _loc_8 - _loc_6;
                    _loc_3.b = _loc_9 - _loc_7;
                    _loc_3.c = _loc_10 - _loc_6;
                    _loc_3.d = _loc_11 - _loc_7;
                }
                if (this.material.bitmap)
                {
                    this.uvMatrices[param1] = _loc_3;
                }
            }
            return _loc_3;
        }// end function

        public function destroy() : void
        {
            var _loc_1:Object = null;
            for each (_loc_1 in this.uvMatrices)
            {
                
                this.uvMatrices[_loc_1] = null;
            }
            this.uvMatrices = null;
            this.shaderRenderer.destroy();
            this.shaderRenderer = null;
            this.lightMatrices = null;
            return;
        }// end function

    }
}
