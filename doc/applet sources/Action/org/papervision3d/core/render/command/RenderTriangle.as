package org.papervision3d.core.render.command
{
    import flash.display.*;
    import flash.geom.*;
    import org.papervision3d.core.geom.renderables.*;
    import org.papervision3d.core.math.*;
    import org.papervision3d.core.proto.*;
    import org.papervision3d.core.render.data.*;
    import org.papervision3d.core.render.draw.*;
    import org.papervision3d.materials.*;

    public class RenderTriangle extends RenderableListItem implements IRenderListItem
    {
        public var triangle:Triangle3D;
        private var bzf:Number;
        private var axf:Number;
        private var det:Number;
        private var v12:Vertex3DInstance;
        private var faz:Number;
        private var position:Number3D;
        private var ayf:Number;
        private var au:Number;
        private var av:Number;
        private var ax:Number;
        private var ay:Number;
        private var az:Number;
        private var v20:Vertex3DInstance;
        private var fbz:Number;
        private var azf:Number;
        private var bu:Number;
        private var bv:Number;
        private var bx:Number;
        private var by:Number;
        private var bz:Number;
        private var fcz:Number;
        private var uv01:NumberUV;
        private var cu:Number;
        private var cv:Number;
        private var cx:Number;
        private var cy:Number;
        private var cz:Number;
        public var v0:Vertex3DInstance;
        public var v1:Vertex3DInstance;
        private var da:Number;
        private var db:Number;
        private var dc:Number;
        public var container:Sprite;
        private var uv12:NumberUV;
        public var v2:Vertex3DInstance;
        private var cxf:Number;
        private var uv20:NumberUV;
        protected var vx0:Vertex3DInstance;
        public var uv0:NumberUV;
        public var uv1:NumberUV;
        public var uv2:NumberUV;
        protected var vx1:Vertex3DInstance;
        protected var vx2:Vertex3DInstance;
        public var renderer:ITriangleDrawer;
        private var cyf:Number;
        private var czf:Number;
        private var bxf:Number;
        protected var vPointL:Vertex3DInstance;
        public var renderMat:MaterialObject3D;
        private var byf:Number;
        private var v01:Vertex3DInstance;
        public var create:Function;
        static var resPA:Vertex3DInstance = new Vertex3DInstance();
        static var resBA:Vertex3DInstance = new Vertex3DInstance();
        static var vPoint:Vertex3DInstance = new Vertex3DInstance();
        static var resRA:Vertex3DInstance = new Vertex3DInstance();

        public function RenderTriangle(param1:Triangle3D) : void
        {
            this.position = new Number3D();
            this.triangle = param1;
            this.instance = param1.instance;
            renderableInstance = param1;
            renderable = Triangle3D;
            this.v0 = param1.v0.vertex3DInstance;
            this.v1 = param1.v1.vertex3DInstance;
            this.v2 = param1.v2.vertex3DInstance;
            this.uv0 = param1.uv0;
            this.uv1 = param1.uv1;
            this.uv2 = param1.uv2;
            this.renderer = param1.material;
            this.update();
            return;
        }// end function

        private function deepHitTest(param1:Triangle3D, param2:Vertex3DInstance, param3:RenderHitData) : RenderHitData
        {
            var _loc_44:MovieMaterial = null;
            var _loc_45:Rectangle = null;
            var _loc_4:* = param1.v0.vertex3DInstance;
            var _loc_5:* = param1.v1.vertex3DInstance;
            var _loc_6:* = param1.v2.vertex3DInstance;
            var _loc_7:* = param1.v2.vertex3DInstance.x - _loc_4.x;
            var _loc_8:* = _loc_6.y - _loc_4.y;
            var _loc_9:* = _loc_5.x - _loc_4.x;
            var _loc_10:* = _loc_5.y - _loc_4.y;
            var _loc_11:* = param2.x - _loc_4.x;
            var _loc_12:* = param2.y - _loc_4.y;
            var _loc_13:* = _loc_7 * _loc_7 + _loc_8 * _loc_8;
            var _loc_14:* = _loc_7 * _loc_9 + _loc_8 * _loc_10;
            var _loc_15:* = _loc_7 * _loc_11 + _loc_8 * _loc_12;
            var _loc_16:* = _loc_9 * _loc_9 + _loc_10 * _loc_10;
            var _loc_17:* = _loc_9 * _loc_11 + _loc_10 * _loc_12;
            var _loc_18:* = 1 / (_loc_13 * _loc_16 - _loc_14 * _loc_14);
            var _loc_19:* = (_loc_16 * _loc_15 - _loc_14 * _loc_17) * _loc_18;
            var _loc_20:* = (_loc_13 * _loc_17 - _loc_14 * _loc_15) * _loc_18;
            var _loc_21:* = param1.v2.x - param1.v0.x;
            var _loc_22:* = param1.v2.y - param1.v0.y;
            var _loc_23:* = param1.v2.z - param1.v0.z;
            var _loc_24:* = param1.v1.x - param1.v0.x;
            var _loc_25:* = param1.v1.y - param1.v0.y;
            var _loc_26:* = param1.v1.z - param1.v0.z;
            var _loc_27:* = param1.v0.x + _loc_21 * _loc_19 + _loc_24 * _loc_20;
            var _loc_28:* = param1.v0.y + _loc_22 * _loc_19 + _loc_25 * _loc_20;
            var _loc_29:* = param1.v0.z + _loc_23 * _loc_19 + _loc_26 * _loc_20;
            var _loc_30:* = param1.uv;
            var _loc_31:* = param1.uv[0].u;
            var _loc_32:* = _loc_30[1].u;
            var _loc_33:* = _loc_30[2].u;
            var _loc_34:* = _loc_30[0].v;
            var _loc_35:* = _loc_30[1].v;
            var _loc_36:* = _loc_30[2].v;
            var _loc_37:* = (_loc_32 - _loc_31) * _loc_20 + (_loc_33 - _loc_31) * _loc_19 + _loc_31;
            var _loc_38:* = (_loc_35 - _loc_34) * _loc_20 + (_loc_36 - _loc_34) * _loc_19 + _loc_34;
            if (this.triangle.material)
            {
                this.renderMat = param1.material;
            }
            else
            {
                this.renderMat = param1.instance.material;
            }
            var _loc_39:* = this.renderMat.bitmap;
            var _loc_40:Number = 1;
            var _loc_41:Number = 1;
            var _loc_42:Number = 0;
            var _loc_43:Number = 0;
            if (this.renderMat is MovieMaterial)
            {
                _loc_44 = this.renderMat as MovieMaterial;
                _loc_45 = _loc_44.rect;
                if (_loc_45)
                {
                    _loc_42 = _loc_45.x;
                    _loc_43 = _loc_45.y;
                    _loc_40 = _loc_45.width;
                    _loc_41 = _loc_45.height;
                }
            }
            else if (_loc_39)
            {
                _loc_40 = BitmapMaterial.AUTO_MIP_MAPPING ? (this.renderMat.widthOffset) : (_loc_39.width);
                _loc_41 = BitmapMaterial.AUTO_MIP_MAPPING ? (this.renderMat.heightOffset) : (_loc_39.height);
            }
            param3.displayObject3D = param1.instance;
            param3.material = this.renderMat;
            param3.renderable = param1;
            param3.hasHit = true;
            this.position.x = _loc_27;
            this.position.y = _loc_28;
            this.position.z = _loc_29;
            Matrix3D.multiplyVector(param1.instance.world, this.position);
            param3.x = this.position.x;
            param3.y = this.position.y;
            param3.z = this.position.z;
            param3.u = _loc_37 * _loc_40 + _loc_42;
            param3.v = _loc_41 - _loc_38 * _loc_41 + _loc_43;
            return param3;
        }// end function

        override public function hitTestPoint2D(param1:Point, param2:RenderHitData) : RenderHitData
        {
            this.renderMat = this.triangle.material;
            if (!this.renderMat)
            {
                this.renderMat = this.triangle.instance.material;
            }
            if (this.renderMat && this.renderMat.interactive)
            {
                this.vPointL = RenderTriangle.vPoint;
                this.vPointL.x = param1.x;
                this.vPointL.y = param1.y;
                this.vx0 = this.triangle.v0.vertex3DInstance;
                this.vx1 = this.triangle.v1.vertex3DInstance;
                this.vx2 = this.triangle.v2.vertex3DInstance;
                if (this.sameSide(this.vPointL, this.vx0, this.vx1, this.vx2))
                {
                    if (this.sameSide(this.vPointL, this.vx1, this.vx0, this.vx2))
                    {
                        if (this.sameSide(this.vPointL, this.vx2, this.vx0, this.vx1))
                        {
                            return this.deepHitTest(this.triangle, this.vPointL, param2);
                        }
                    }
                }
            }
            return param2;
        }// end function

        public function fivepointcut(param1:Vertex3DInstance, param2:Vertex3DInstance, param3:Vertex3DInstance, param4:Vertex3DInstance, param5:Vertex3DInstance, param6:NumberUV, param7:NumberUV, param8:NumberUV, param9:NumberUV, param10:NumberUV) : Array
        {
            if (param1.distanceSqr(param4) < param2.distanceSqr(param5))
            {
                return [this.create(renderableInstance, instance.material, param1, param2, param4, param6, param7, param9), this.create(renderableInstance, instance.material, param2, param3, param4, param7, param8, param9), this.create(renderableInstance, instance.material, param1, param4, param5, param6, param9, param10)];
            }
            return [this.create(renderableInstance, instance.material, param1, param2, param5, param6, param7, param10), this.create(renderableInstance, instance.material, param2, param3, param4, param7, param8, param9), this.create(renderableInstance, instance.material, param2, param4, param5, param7, param9, param10)];
        }// end function

        override public function render(param1:RenderSessionData, param2:Graphics) : void
        {
            this.renderer.drawTriangle(this, param2, param1);
            return;
        }// end function

        final override public function quarter(param1:Number) : Array
        {
            if (area < 20)
            {
                return null;
            }
            this.v01 = Vertex3DInstance.median(this.v0, this.v1, param1);
            this.v12 = Vertex3DInstance.median(this.v1, this.v2, param1);
            this.v20 = Vertex3DInstance.median(this.v2, this.v0, param1);
            this.uv01 = NumberUV.median(this.uv0, this.uv1);
            this.uv12 = NumberUV.median(this.uv1, this.uv2);
            this.uv20 = NumberUV.median(this.uv2, this.uv0);
            return [this.create(renderableInstance, this.renderer, this.v0, this.v01, this.v20, this.uv0, this.uv01, this.uv20), this.create(renderableInstance, this.renderer, this.v1, this.v12, this.v01, this.uv1, this.uv12, this.uv01), this.create(renderableInstance, this.renderer, this.v2, this.v20, this.v12, this.uv2, this.uv20, this.uv12), this.create(renderableInstance, this.renderer, this.v01, this.v12, this.v20, this.uv01, this.uv12, this.uv20)];
        }// end function

        final override public function getZ(param1:Number, param2:Number, param3:Number) : Number
        {
            this.ax = this.v0.x;
            this.ay = this.v0.y;
            this.az = this.v0.z;
            this.bx = this.v1.x;
            this.by = this.v1.y;
            this.bz = this.v1.z;
            this.cx = this.v2.x;
            this.cy = this.v2.y;
            this.cz = this.v2.z;
            if (this.ax == param1 && this.ay == param2)
            {
                return this.az;
            }
            if (this.bx == param1 && this.by == param2)
            {
                return this.bz;
            }
            if (this.cx == param1 && this.cy == param2)
            {
                return this.cz;
            }
            this.azf = this.az / param3;
            this.bzf = this.bz / param3;
            this.czf = this.cz / param3;
            this.faz = 1 + this.azf;
            this.fbz = 1 + this.bzf;
            this.fcz = 1 + this.czf;
            this.axf = this.ax * this.faz - param1 * this.azf;
            this.bxf = this.bx * this.fbz - param1 * this.bzf;
            this.cxf = this.cx * this.fcz - param1 * this.czf;
            this.ayf = this.ay * this.faz - param2 * this.azf;
            this.byf = this.by * this.fbz - param2 * this.bzf;
            this.cyf = this.cy * this.fcz - param2 * this.czf;
            this.det = this.axf * (this.byf - this.cyf) + this.bxf * (this.cyf - this.ayf) + this.cxf * (this.ayf - this.byf);
            this.da = param1 * (this.byf - this.cyf) + this.bxf * (this.cyf - param2) + this.cxf * (param2 - this.byf);
            this.db = this.axf * (param2 - this.cyf) + param1 * (this.cyf - this.ayf) + this.cxf * (this.ayf - param2);
            this.dc = this.axf * (this.byf - param2) + this.bxf * (param2 - this.ayf) + param1 * (this.ayf - this.byf);
            return (this.da * this.az + this.db * this.bz + this.dc * this.cz) / this.det;
        }// end function

        override public function update() : void
        {
            if (this.v0.x > this.v1.x)
            {
                if (this.v0.x > this.v2.x)
                {
                    maxX = this.v0.x;
                }
                else
                {
                    maxX = this.v2.x;
                }
            }
            else if (this.v1.x > this.v2.x)
            {
                maxX = this.v1.x;
            }
            else
            {
                maxX = this.v2.x;
            }
            if (this.v0.x < this.v1.x)
            {
                if (this.v0.x < this.v2.x)
                {
                    minX = this.v0.x;
                }
                else
                {
                    minX = this.v2.x;
                }
            }
            else if (this.v1.x < this.v2.x)
            {
                minX = this.v1.x;
            }
            else
            {
                minX = this.v2.x;
            }
            if (this.v0.y > this.v1.y)
            {
                if (this.v0.y > this.v2.y)
                {
                    maxY = this.v0.y;
                }
                else
                {
                    maxY = this.v2.y;
                }
            }
            else if (this.v1.y > this.v2.y)
            {
                maxY = this.v1.y;
            }
            else
            {
                maxY = this.v2.y;
            }
            if (this.v0.y < this.v1.y)
            {
                if (this.v0.y < this.v2.y)
                {
                    minY = this.v0.y;
                }
                else
                {
                    minY = this.v2.y;
                }
            }
            else if (this.v1.y < this.v2.y)
            {
                minY = this.v1.y;
            }
            else
            {
                minY = this.v2.y;
            }
            if (this.v0.z > this.v1.z)
            {
                if (this.v0.z > this.v2.z)
                {
                    maxZ = this.v0.z;
                }
                else
                {
                    maxZ = this.v2.z;
                }
            }
            else if (this.v1.z > this.v2.z)
            {
                maxZ = this.v1.z;
            }
            else
            {
                maxZ = this.v2.z;
            }
            if (this.v0.z < this.v1.z)
            {
                if (this.v0.z < this.v2.z)
                {
                    minZ = this.v0.z;
                }
                else
                {
                    minZ = this.v2.z;
                }
            }
            else if (this.v1.z < this.v2.z)
            {
                minZ = this.v1.z;
            }
            else
            {
                minZ = this.v2.z;
            }
            screenZ = (this.v0.z + this.v1.z + this.v2.z) / 3;
            area = 0.5 * (this.v0.x * (this.v2.y - this.v1.y) + this.v1.x * (this.v0.y - this.v2.y) + this.v2.x * (this.v1.y - this.v0.y));
            return;
        }// end function

        public function sameSide(param1:Vertex3DInstance, param2:Vertex3DInstance, param3:Vertex3DInstance, param4:Vertex3DInstance) : Boolean
        {
            Vertex3DInstance.subTo(param4, param3, resBA);
            Vertex3DInstance.subTo(param1, param3, resPA);
            Vertex3DInstance.subTo(param2, param3, resRA);
            return Vertex3DInstance.cross(resBA, resPA) * Vertex3DInstance.cross(resBA, resRA) >= 0;
        }// end function

    }
}
