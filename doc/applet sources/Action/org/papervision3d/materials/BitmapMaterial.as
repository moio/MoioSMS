package org.papervision3d.materials
{
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;
    import org.papervision3d.*;
    import org.papervision3d.core.geom.renderables.*;
    import org.papervision3d.core.log.*;
    import org.papervision3d.core.material.*;
    import org.papervision3d.core.proto.*;
    import org.papervision3d.core.render.command.*;
    import org.papervision3d.core.render.data.*;
    import org.papervision3d.materials.utils.*;

    public class BitmapMaterial extends TriangleMaterial implements ITriangleDrawer
    {
        protected var renderRecStorage:Array;
        protected var dsbc:Number;
        private var d2bc:Number;
        private var b2:Number;
        public var uvMatrices:Dictionary;
        protected var _precise:Boolean;
        protected var faz:Number;
        protected var dsca:Number;
        protected var ax:Number;
        protected var ay:Number;
        protected var az:Number;
        private var d2ca:Number;
        protected var tempPreGrp:Graphics;
        public var precisionMode:int;
        protected var fbz:Number;
        private var c2:Number;
        protected var mcax:Number;
        protected var mcay:Number;
        protected var mcaz:Number;
        private var d2:Number;
        protected var bx:Number;
        protected var by:Number;
        protected var bz:Number;
        protected var fcz:Number;
        public var minimumRenderSize:Number = 4;
        protected var dbcx:Number;
        protected var dbcy:Number;
        protected var cx:Number;
        protected var cullRect:Rectangle;
        protected var cz:Number;
        protected var cy:Number;
        protected var dmax:Number;
        protected var dabx:Number;
        private var dy:Number;
        protected var _perPixelPrecision:int = 8;
        protected var daby:Number;
        protected var tempPreRSD:RenderSessionData;
        private var dx:Number;
        private var x0:Number;
        private var x1:Number;
        private var x2:Number;
        protected var mbcy:Number;
        protected var mbcz:Number;
        protected var mbcx:Number;
        private var y0:Number;
        protected var focus:Number = 200;
        private var y2:Number;
        protected var _texture:Object;
        protected var tempPreBmp:BitmapData;
        private var y1:Number;
        protected var tempTriangleMatrix:Matrix;
        protected var maby:Number;
        protected var mabz:Number;
        private var d2ab:Number;
        protected var dsab:Number;
        protected var mabx:Number;
        protected var dcax:Number;
        protected var dcay:Number;
        private var a2:Number;
        protected var _precision:int = 8;
        static const DEFAULT_FOCUS:Number = 200;
        static var _triMatrix:Matrix = new Matrix();
        static var _triMap:Matrix;
        public static var AUTO_MIP_MAPPING:Boolean = false;
        public static var MIP_MAP_DEPTH:Number = 8;
        static var hitRect:Rectangle = new Rectangle();
        static var _localMatrix:Matrix = new Matrix();

        public function BitmapMaterial(param1:BitmapData = null, param2:Boolean = false)
        {
            this.precisionMode = PrecisionMode.ORIGINAL;
            this.uvMatrices = new Dictionary();
            this.tempTriangleMatrix = new Matrix();
            if (param1)
            {
                this.texture = param1;
            }
            this.precise = param2;
            this.createRenderRecStorage();
            return;
        }// end function

        public function transformUV(param1:Triangle3D) : Matrix
        {
            var _loc_2:Array = null;
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
            var _loc_15:Matrix = null;
            var _loc_16:Matrix = null;
            if (!param1.uv)
            {
                PaperLogger.error("MaterialObject3D: transformUV() uv not found!");
            }
            else if (bitmap)
            {
                _loc_2 = param1.uv;
                _loc_3 = bitmap.width * maxU;
                _loc_4 = bitmap.height * maxV;
                _loc_5 = _loc_3 * param1.uv0.u;
                _loc_6 = _loc_4 * (1 - param1.uv0.v);
                _loc_7 = _loc_3 * param1.uv1.u;
                _loc_8 = _loc_4 * (1 - param1.uv1.v);
                _loc_9 = _loc_3 * param1.uv2.u;
                _loc_10 = _loc_4 * (1 - param1.uv2.v);
                if (_loc_5 == _loc_7 && _loc_6 == _loc_8 || _loc_5 == _loc_9 && _loc_6 == _loc_10)
                {
                    _loc_5 = _loc_5 - (_loc_5 > 0.05 ? (0.05) : (-0.05));
                    _loc_6 = _loc_6 - (_loc_6 > 0.07 ? (0.07) : (-0.07));
                }
                if (_loc_9 == _loc_7 && _loc_10 == _loc_8)
                {
                    _loc_9 = _loc_9 - (_loc_9 > 0.05 ? (0.04) : (-0.04));
                    _loc_10 = _loc_10 - (_loc_10 > 0.06 ? (0.06) : (-0.06));
                }
                _loc_11 = _loc_7 - _loc_5;
                _loc_12 = _loc_8 - _loc_6;
                _loc_13 = _loc_9 - _loc_5;
                _loc_14 = _loc_10 - _loc_6;
                _loc_15 = new Matrix(_loc_11, _loc_12, _loc_13, _loc_14, _loc_5, _loc_6);
                if (Papervision3D.useRIGHTHANDED)
                {
                    _loc_15.scale(-1, 1);
                    _loc_15.translate(_loc_3, 0);
                }
                _loc_15.invert();
                var _loc_17:* = _loc_15.clone();
                this.uvMatrices[param1] = _loc_15.clone();
                _loc_16 = _loc_17;
                _loc_16.a = _loc_15.a;
                _loc_16.b = _loc_15.b;
                _loc_16.c = _loc_15.c;
                _loc_16.d = _loc_15.d;
                _loc_16.tx = _loc_15.tx;
                _loc_16.ty = _loc_15.ty;
            }
            else
            {
                PaperLogger.error("MaterialObject3D: transformUV() material.bitmap not found!");
            }
            return _loc_16;
        }// end function

        public function transformUVRT(param1:RenderTriangle) : Matrix
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
            var _loc_14:Matrix = null;
            var _loc_15:Matrix = null;
            if (bitmap)
            {
                _loc_2 = bitmap.width * maxU;
                _loc_3 = bitmap.height * maxV;
                _loc_4 = _loc_2 * param1.uv0.u;
                _loc_5 = _loc_3 * (1 - param1.uv0.v);
                _loc_6 = _loc_2 * param1.uv1.u;
                _loc_7 = _loc_3 * (1 - param1.uv1.v);
                _loc_8 = _loc_2 * param1.uv2.u;
                _loc_9 = _loc_3 * (1 - param1.uv2.v);
                if (_loc_4 == _loc_6 && _loc_5 == _loc_7 || _loc_4 == _loc_8 && _loc_5 == _loc_9)
                {
                    _loc_4 = _loc_4 - (_loc_4 > 0.05 ? (0.05) : (-0.05));
                    _loc_5 = _loc_5 - (_loc_5 > 0.07 ? (0.07) : (-0.07));
                }
                if (_loc_8 == _loc_6 && _loc_9 == _loc_7)
                {
                    _loc_8 = _loc_8 - (_loc_8 > 0.05 ? (0.04) : (-0.04));
                    _loc_9 = _loc_9 - (_loc_9 > 0.06 ? (0.06) : (-0.06));
                }
                _loc_10 = _loc_6 - _loc_4;
                _loc_11 = _loc_7 - _loc_5;
                _loc_12 = _loc_8 - _loc_4;
                _loc_13 = _loc_9 - _loc_5;
                _loc_14 = new Matrix(_loc_10, _loc_11, _loc_12, _loc_13, _loc_4, _loc_5);
                if (Papervision3D.useRIGHTHANDED)
                {
                    _loc_14.scale(-1, 1);
                    _loc_14.translate(_loc_2, 0);
                }
                _loc_14.invert();
                var _loc_16:* = _loc_14.clone();
                this.uvMatrices[param1] = _loc_14.clone();
                _loc_15 = _loc_16;
                _loc_15.a = _loc_14.a;
                _loc_15.b = _loc_14.b;
                _loc_15.c = _loc_14.c;
                _loc_15.d = _loc_14.d;
                _loc_15.tx = _loc_14.tx;
                _loc_15.ty = _loc_14.ty;
            }
            else
            {
                PaperLogger.error("MaterialObject3D: transformUV() material.bitmap not found!");
            }
            return _loc_15;
        }// end function

        protected function renderRec(param1:Matrix, param2:Vertex3DInstance, param3:Vertex3DInstance, param4:Vertex3DInstance, param5:Number) : void
        {
            this.az = param2.z;
            this.bz = param3.z;
            this.cz = param4.z;
            if (this.az <= 0 && this.bz <= 0 && this.cz <= 0)
            {
                return;
            }
            this.cx = param4.x;
            this.cy = param4.y;
            this.bx = param3.x;
            this.by = param3.y;
            this.ax = param2.x;
            this.ay = param2.y;
            if (this.cullRect)
            {
                hitRect.x = this.bx < this.ax ? (this.bx < this.cx ? (this.bx) : (this.cx)) : (this.ax < this.cx ? (this.ax) : (this.cx));
                hitRect.width = (this.bx > this.ax ? (this.bx > this.cx ? (this.bx) : (this.cx)) : (this.ax > this.cx ? (this.ax) : (this.cx))) + (hitRect.x < 0 ? (-hitRect.x) : (hitRect.x));
                hitRect.y = this.by < this.ay ? (this.by < this.cy ? (this.by) : (this.cy)) : (this.ay < this.cy ? (this.ay) : (this.cy));
                hitRect.height = (this.by > this.ay ? (this.by > this.cy ? (this.by) : (this.cy)) : (this.ay > this.cy ? (this.ay) : (this.cy))) + (hitRect.y < 0 ? (-hitRect.y) : (hitRect.y));
                if (!(hitRect.right < this.cullRect.left || hitRect.left > this.cullRect.right))
                {
                    if (!(hitRect.bottom < this.cullRect.top || hitRect.top > this.cullRect.bottom))
                    {
                    }
                    else
                    {
                        return;
                    }
                }
                else
                {
                    return;
                }
            }
            if (param5 >= 100 || hitRect.width < this.minimumRenderSize || hitRect.height < this.minimumRenderSize || this.focus == Infinity)
            {
                this.a2 = param3.x - param2.x;
                this.b2 = param3.y - param2.y;
                this.c2 = param4.x - param2.x;
                this.d2 = param4.y - param2.y;
                this.tempTriangleMatrix.a = param1.a * this.a2 + param1.b * this.c2;
                this.tempTriangleMatrix.b = param1.a * this.b2 + param1.b * this.d2;
                this.tempTriangleMatrix.c = param1.c * this.a2 + param1.d * this.c2;
                this.tempTriangleMatrix.d = param1.c * this.b2 + param1.d * this.d2;
                this.tempTriangleMatrix.tx = param1.tx * this.a2 + param1.ty * this.c2 + param2.x;
                this.tempTriangleMatrix.ty = param1.tx * this.b2 + param1.ty * this.d2 + param2.y;
                if (lineAlpha)
                {
                    this.tempPreGrp.lineStyle(lineThickness, lineColor, lineAlpha);
                }
                this.tempPreGrp.beginBitmapFill(this.tempPreBmp, this.tempTriangleMatrix, tiled, smooth);
                this.tempPreGrp.moveTo(param2.x, param2.y);
                this.tempPreGrp.lineTo(param3.x, param3.y);
                this.tempPreGrp.lineTo(param4.x, param4.y);
                this.tempPreGrp.endFill();
                if (lineAlpha)
                {
                    this.tempPreGrp.lineStyle();
                }
                var _loc_9:* = this.tempPreRSD.renderStatistics;
                _loc_9.triangles = this.tempPreRSD.renderStatistics.triangles++;
                return;
            }
            this.faz = this.focus + this.az;
            this.fbz = this.focus + this.bz;
            this.fcz = this.focus + this.cz;
            this.mabz = 2 / (this.faz + this.fbz);
            this.mbcz = 2 / (this.fbz + this.fcz);
            this.mcaz = 2 / (this.fcz + this.faz);
            this.mabx = (this.ax * this.faz + this.bx * this.fbz) * this.mabz;
            this.maby = (this.ay * this.faz + this.by * this.fbz) * this.mabz;
            this.mbcx = (this.bx * this.fbz + this.cx * this.fcz) * this.mbcz;
            this.mbcy = (this.by * this.fbz + this.cy * this.fcz) * this.mbcz;
            this.mcax = (this.cx * this.fcz + this.ax * this.faz) * this.mcaz;
            this.mcay = (this.cy * this.fcz + this.ay * this.faz) * this.mcaz;
            this.dabx = this.ax + this.bx - this.mabx;
            this.daby = this.ay + this.by - this.maby;
            this.dbcx = this.bx + this.cx - this.mbcx;
            this.dbcy = this.by + this.cy - this.mbcy;
            this.dcax = this.cx + this.ax - this.mcax;
            this.dcay = this.cy + this.ay - this.mcay;
            this.dsab = this.dabx * this.dabx + this.daby * this.daby;
            this.dsbc = this.dbcx * this.dbcx + this.dbcy * this.dbcy;
            this.dsca = this.dcax * this.dcax + this.dcay * this.dcay;
            var _loc_6:* = param5 + 1;
            var _loc_7:* = RenderRecStorage(this.renderRecStorage[int(param5)]);
            var _loc_8:* = RenderRecStorage(this.renderRecStorage[int(param5)]).mat;
            if (this.dsab <= this._precision && this.dsca <= this._precision && this.dsbc <= this._precision)
            {
                this.a2 = param3.x - param2.x;
                this.b2 = param3.y - param2.y;
                this.c2 = param4.x - param2.x;
                this.d2 = param4.y - param2.y;
                this.tempTriangleMatrix.a = param1.a * this.a2 + param1.b * this.c2;
                this.tempTriangleMatrix.b = param1.a * this.b2 + param1.b * this.d2;
                this.tempTriangleMatrix.c = param1.c * this.a2 + param1.d * this.c2;
                this.tempTriangleMatrix.d = param1.c * this.b2 + param1.d * this.d2;
                this.tempTriangleMatrix.tx = param1.tx * this.a2 + param1.ty * this.c2 + param2.x;
                this.tempTriangleMatrix.ty = param1.tx * this.b2 + param1.ty * this.d2 + param2.y;
                if (lineAlpha)
                {
                    this.tempPreGrp.lineStyle(lineThickness, lineColor, lineAlpha);
                }
                this.tempPreGrp.beginBitmapFill(this.tempPreBmp, this.tempTriangleMatrix, tiled, smooth);
                this.tempPreGrp.moveTo(param2.x, param2.y);
                this.tempPreGrp.lineTo(param3.x, param3.y);
                this.tempPreGrp.lineTo(param4.x, param4.y);
                this.tempPreGrp.endFill();
                if (lineAlpha)
                {
                    this.tempPreGrp.lineStyle();
                }
                var _loc_9:* = this.tempPreRSD.renderStatistics;
                _loc_9.triangles = this.tempPreRSD.renderStatistics.triangles++;
                return;
            }
            if (this.dsab > this._precision && this.dsca > this._precision && this.dsbc > this._precision)
            {
                _loc_8.a = param1.a * 2;
                _loc_8.b = param1.b * 2;
                _loc_8.c = param1.c * 2;
                _loc_8.d = param1.d * 2;
                _loc_8.tx = param1.tx * 2;
                _loc_8.ty = param1.ty * 2;
                _loc_7.v0.x = this.mabx * 0.5;
                _loc_7.v0.y = this.maby * 0.5;
                _loc_7.v0.z = (this.az + this.bz) * 0.5;
                _loc_7.v1.x = this.mbcx * 0.5;
                _loc_7.v1.y = this.mbcy * 0.5;
                _loc_7.v1.z = (this.bz + this.cz) * 0.5;
                _loc_7.v2.x = this.mcax * 0.5;
                _loc_7.v2.y = this.mcay * 0.5;
                _loc_7.v2.z = (this.cz + this.az) * 0.5;
                this.renderRec(_loc_8, param2, _loc_7.v0, _loc_7.v2, _loc_6);
                _loc_8.tx--;
                this.renderRec(_loc_8, _loc_7.v0, param3, _loc_7.v1, _loc_6);
                _loc_8.ty--;
                _loc_8.tx = param1.tx * 2;
                this.renderRec(_loc_8, _loc_7.v2, _loc_7.v1, param4, _loc_6);
                _loc_8.a = (-param1.a) * 2;
                _loc_8.b = (-param1.b) * 2;
                _loc_8.c = (-param1.c) * 2;
                _loc_8.d = (-param1.d) * 2;
                _loc_8.tx = (-param1.tx) * 2 + 1;
                _loc_8.ty = (-param1.ty) * 2 + 1;
                this.renderRec(_loc_8, _loc_7.v1, _loc_7.v2, _loc_7.v0, _loc_6);
                return;
            }
            if (this.precisionMode == PrecisionMode.ORIGINAL)
            {
                this.d2ab = this.dsab;
                this.d2bc = this.dsbc;
                this.d2ca = this.dsca;
                this.dmax = this.dsca > this.dsbc ? (this.dsca > this.dsab ? (this.dsca) : (this.dsab)) : (this.dsbc > this.dsab ? (this.dsbc) : (this.dsab));
            }
            else
            {
                this.dx = param2.x - param3.x;
                this.dy = param2.y - param3.y;
                this.d2ab = this.dx * this.dx + this.dy * this.dy;
                this.dx = param3.x - param4.x;
                this.dy = param3.y - param4.y;
                this.d2bc = this.dx * this.dx + this.dy * this.dy;
                this.dx = param4.x - param2.x;
                this.dy = param4.y - param2.y;
                this.d2ca = this.dx * this.dx + this.dy * this.dy;
                this.dmax = this.d2ca > this.d2bc ? (this.d2ca > this.d2ab ? (this.d2ca) : (this.d2ab)) : (this.d2bc > this.d2ab ? (this.d2bc) : (this.d2ab));
            }
            if (this.d2ab == this.dmax)
            {
                _loc_8.a = param1.a * 2;
                _loc_8.b = param1.b;
                _loc_8.c = param1.c * 2;
                _loc_8.d = param1.d;
                _loc_8.tx = param1.tx * 2;
                _loc_8.ty = param1.ty;
                _loc_7.v0.x = this.mabx * 0.5;
                _loc_7.v0.y = this.maby * 0.5;
                _loc_7.v0.z = (this.az + this.bz) * 0.5;
                this.renderRec(_loc_8, param2, _loc_7.v0, param4, _loc_6);
                _loc_8.a = param1.a * 2 + param1.b;
                _loc_8.c = 2 * param1.c + param1.d;
                _loc_8.tx = (param1.tx * 2 + param1.ty)--;
                this.renderRec(_loc_8, _loc_7.v0, param3, param4, _loc_6);
                return;
            }
            if (this.d2ca == this.dmax)
            {
                _loc_8.a = param1.a;
                _loc_8.b = param1.b * 2;
                _loc_8.c = param1.c;
                _loc_8.d = param1.d * 2;
                _loc_8.tx = param1.tx;
                _loc_8.ty = param1.ty * 2;
                _loc_7.v2.x = this.mcax * 0.5;
                _loc_7.v2.y = this.mcay * 0.5;
                _loc_7.v2.z = (this.cz + this.az) * 0.5;
                this.renderRec(_loc_8, param2, param3, _loc_7.v2, _loc_6);
                _loc_8.b = _loc_8.b + param1.a;
                _loc_8.d = _loc_8.d + param1.c;
                _loc_8.ty = _loc_8.ty + param1.tx--;
                this.renderRec(_loc_8, _loc_7.v2, param3, param4, _loc_6);
                return;
            }
            _loc_8.a = param1.a - param1.b;
            _loc_8.b = param1.b * 2;
            _loc_8.c = param1.c - param1.d;
            _loc_8.d = param1.d * 2;
            _loc_8.tx = param1.tx - param1.ty;
            _loc_8.ty = param1.ty * 2;
            _loc_7.v1.x = this.mbcx * 0.5;
            _loc_7.v1.y = this.mbcy * 0.5;
            _loc_7.v1.z = (this.bz + this.cz) * 0.5;
            this.renderRec(_loc_8, param2, param3, _loc_7.v1, _loc_6);
            _loc_8.a = param1.a * 2;
            _loc_8.b = param1.b - param1.a;
            _loc_8.c = param1.c * 2;
            _loc_8.d = param1.d - param1.c;
            _loc_8.tx = param1.tx * 2;
            _loc_8.ty = param1.ty - param1.tx;
            this.renderRec(_loc_8, param2, _loc_7.v1, param4, _loc_6);
            return;
        }// end function

        protected function createRenderRecStorage() : void
        {
            this.renderRecStorage = new Array();
            var _loc_1:int = 0;
            while (_loc_1 <= 100)
            {
                
                this.renderRecStorage[_loc_1] = new RenderRecStorage();
                _loc_1++;
            }
            return;
        }// end function

        public function get texture() : Object
        {
            return this._texture;
        }// end function

        public function resetUVS() : void
        {
            this.uvMatrices = new Dictionary(false);
            return;
        }// end function

        public function set pixelPrecision(param1:int) : void
        {
            this._precision = param1 * param1 * 1.4;
            this._perPixelPrecision = param1;
            return;
        }// end function

        protected function correctBitmap(param1:BitmapData) : BitmapData
        {
            var _loc_2:BitmapData = null;
            var _loc_3:* = 1 << MIP_MAP_DEPTH;
            var _loc_4:* = param1.width / _loc_3;
            _loc_4 = param1.width / _loc_3 == uint(_loc_4) ? (_loc_4) : (uint(_loc_4) + 1);
            var _loc_5:* = param1.height / _loc_3;
            _loc_5 = param1.height / _loc_3 == uint(_loc_5) ? (_loc_5) : (uint(_loc_5) + 1);
            var _loc_6:* = _loc_3 * _loc_4;
            var _loc_7:* = _loc_3 * _loc_5;
            var _loc_8:Boolean = true;
            if (_loc_6 > 2880)
            {
                _loc_6 = param1.width;
                _loc_8 = false;
            }
            if (_loc_7 > 2880)
            {
                _loc_7 = param1.height;
                _loc_8 = false;
            }
            if (true)
            {
                PaperLogger.warning("Material " + this.name + ": Texture too big for mip mapping. Resizing recommended for better performance and quality.");
            }
            if (param1 && param1.width % _loc_3 != 0 || param1.height % _loc_3 != 0)
            {
                _loc_2 = new BitmapData(_loc_6, _loc_7, param1.transparent, 0);
                widthOffset = param1.width;
                heightOffset = param1.height;
                this.maxU = param1.width / _loc_6;
                this.maxV = param1.height / _loc_7;
                _loc_2.draw(param1);
                this.extendBitmapEdges(_loc_2, param1.width, param1.height);
            }
            else
            {
                var _loc_9:int = 1;
                this.maxV = 1;
                this.maxU = _loc_9;
                _loc_2 = param1;
            }
            return _loc_2;
        }// end function

        protected function createBitmap(param1:BitmapData) : BitmapData
        {
            var _loc_2:BitmapData = null;
            this.resetMapping();
            if (AUTO_MIP_MAPPING)
            {
                _loc_2 = this.correctBitmap(param1);
            }
            else
            {
                var _loc_3:int = 1;
                this.maxV = 1;
                this.maxU = _loc_3;
                _loc_2 = param1;
            }
            return _loc_2;
        }// end function

        public function get precise() : Boolean
        {
            return this._precise;
        }// end function

        public function set texture(param1:Object) : void
        {
            if (param1 is BitmapData == false)
            {
                PaperLogger.error("BitmapMaterial.texture requires a BitmapData object for the texture");
                return;
            }
            bitmap = this.createBitmap(BitmapData(param1));
            this._texture = param1;
            return;
        }// end function

        override public function clone() : MaterialObject3D
        {
            var _loc_1:* = super.clone();
            _loc_1.maxU = this.maxU;
            _loc_1.maxV = this.maxV;
            return _loc_1;
        }// end function

        override public function drawTriangle(param1:RenderTriangle, param2:Graphics, param3:RenderSessionData, param4:BitmapData = null, param5:Matrix = null) : void
        {
            if (!this.uvMatrices[param1])
            {
            }
            _triMap = param5 ? (param5) : (if (this.uvMatrices[param1]) goto 4, this.transformUVRT(param1));
            if (!this._precise || !_triMap)
            {
                if (lineAlpha)
                {
                    param2.lineStyle(lineThickness, lineColor, lineAlpha);
                }
                if (bitmap)
                {
                    this.x0 = param1.v0.x;
                    this.y0 = param1.v0.y;
                    this.x1 = param1.v1.x;
                    this.y1 = param1.v1.y;
                    this.x2 = param1.v2.x;
                    this.y2 = param1.v2.y;
                    _triMatrix.a = this.x1 - this.x0;
                    _triMatrix.b = this.y1 - this.y0;
                    _triMatrix.c = this.x2 - this.x0;
                    _triMatrix.d = this.y2 - this.y0;
                    _triMatrix.tx = this.x0;
                    _triMatrix.ty = this.y0;
                    _localMatrix.a = _triMap.a;
                    _localMatrix.b = _triMap.b;
                    _localMatrix.c = _triMap.c;
                    _localMatrix.d = _triMap.d;
                    _localMatrix.tx = _triMap.tx;
                    _localMatrix.ty = _triMap.ty;
                    _localMatrix.concat(_triMatrix);
                    param2.beginBitmapFill(param4 ? (param4) : (bitmap), _localMatrix, tiled, smooth);
                }
                param2.moveTo(this.x0, this.y0);
                param2.lineTo(this.x1, this.y1);
                param2.lineTo(this.x2, this.y2);
                param2.lineTo(this.x0, this.y0);
                if (bitmap)
                {
                    param2.endFill();
                }
                if (lineAlpha)
                {
                    param2.lineStyle();
                }
                var _loc_6:* = param3.renderStatistics;
                _loc_6.triangles = param3.renderStatistics.triangles++;
            }
            else if (bitmap)
            {
                this.focus = param3.camera.focus;
                this.tempPreBmp = param4 ? (param4) : (bitmap);
                this.tempPreRSD = param3;
                this.tempPreGrp = param2;
                this.cullRect = param3.viewPort.cullingRectangle;
                this.renderRec(_triMap, param1.v0, param1.v1, param1.v2, 0);
            }
            return;
        }// end function

        public function get precision() : int
        {
            return this._precision;
        }// end function

        public function resetMapping() : void
        {
            this.uvMatrices = new Dictionary();
            return;
        }// end function

        override public function copy(param1:MaterialObject3D) : void
        {
            super.copy(param1);
            this.maxU = param1.maxU;
            this.maxV = param1.maxV;
            return;
        }// end function

        override public function toString() : String
        {
            return "Texture:" + this.texture + " lineColor:" + this.lineColor + " lineAlpha:" + this.lineAlpha;
        }// end function

        public function get pixelPrecision() : int
        {
            return this._perPixelPrecision;
        }// end function

        public function set precise(param1:Boolean) : void
        {
            this._precise = param1;
            return;
        }// end function

        protected function extendBitmapEdges(param1:BitmapData, param2:Number, param3:Number) : void
        {
            var _loc_6:int = 0;
            var _loc_4:* = new Rectangle();
            var _loc_5:* = new Point();
            if (param1.width > param2)
            {
                _loc_4.x = param2--;
                _loc_4.y = 0;
                _loc_4.width = 1;
                _loc_4.height = param3;
                _loc_5.y = 0;
                _loc_6 = param2;
                while (_loc_6 < param1.width)
                {
                    
                    _loc_5.x = _loc_6;
                    param1.copyPixels(param1, _loc_4, _loc_5);
                    _loc_6++;
                }
            }
            if (param1.height > param3)
            {
                _loc_4.x = 0;
                _loc_4.y = param3--;
                _loc_4.width = param1.width;
                _loc_4.height = 1;
                _loc_5.x = 0;
                _loc_6 = param3;
                while (_loc_6 < param1.height)
                {
                    
                    _loc_5.y = _loc_6;
                    param1.copyPixels(param1, _loc_4, _loc_5);
                    _loc_6++;
                }
            }
            return;
        }// end function

        override public function destroy() : void
        {
            super.destroy();
            if (this.uvMatrices)
            {
                this.uvMatrices = null;
            }
            if (bitmap)
            {
                bitmap.dispose();
            }
            this.renderRecStorage = null;
            return;
        }// end function

        public function set precision(param1:int) : void
        {
            this._precision = param1;
            return;
        }// end function

    }
}
