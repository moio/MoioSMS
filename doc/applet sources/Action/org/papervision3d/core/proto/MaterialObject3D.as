package org.papervision3d.core.proto
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import org.papervision3d.core.render.command.*;
    import org.papervision3d.core.render.data.*;
    import org.papervision3d.core.render.material.*;
    import org.papervision3d.materials.*;
    import org.papervision3d.objects.*;

    public class MaterialObject3D extends EventDispatcher implements ITriangleDrawer
    {
        public var widthOffset:Number = 0;
        public var name:String;
        public var heightOffset:Number = 0;
        public var fillAlpha:Number = 0;
        public var fillColor:Number;
        public var id:Number;
        protected var objects:Dictionary;
        public var baked:Boolean = false;
        public var invisible:Boolean = false;
        public var smooth:Boolean = false;
        public var bitmap:BitmapData;
        public var lineAlpha:Number = 0;
        public var lineColor:Number;
        public var lineThickness:Number = 1;
        public var interactive:Boolean = false;
        public var oneSide:Boolean = true;
        public var opposite:Boolean = false;
        public var maxU:Number;
        public var tiled:Boolean = false;
        public var maxV:Number;
        public static var DEFAULT_COLOR:int = 0;
        public static var DEBUG_COLOR:int = 16711935;
        private static var _totalMaterialObjects:Number = 0;

        public function MaterialObject3D()
        {
            this.lineColor = DEFAULT_COLOR;
            this.fillColor = DEFAULT_COLOR;
            this.id = _totalMaterialObjects++;
            MaterialManager.registerMaterial(this);
            this.objects = new Dictionary(true);
            return;
        }// end function

        public function getObjectList() : Dictionary
        {
            return this.objects;
        }// end function

        override public function toString() : String
        {
            return "[MaterialObject3D] bitmap:" + this.bitmap + " lineColor:" + this.lineColor + " fillColor:" + this.fillColor;
        }// end function

        public function drawRT(param1:RenderTriangle, param2:Graphics, param3:RenderSessionData) : void
        {
            return;
        }// end function

        public function get doubleSided() : Boolean
        {
            return !this.oneSide;
        }// end function

        public function unregisterObject(param1:DisplayObject3D) : void
        {
            if (this.objects && this.objects[param1])
            {
                this.objects[param1] = null;
            }
            return;
        }// end function

        public function set doubleSided(param1:Boolean) : void
        {
            this.oneSide = !param1;
            return;
        }// end function

        public function registerObject(param1:DisplayObject3D) : void
        {
            this.objects[param1] = true;
            return;
        }// end function

        public function updateBitmap() : void
        {
            return;
        }// end function

        public function clone() : MaterialObject3D
        {
            var _loc_1:* = new MaterialObject3D();
            _loc_1.copy(this);
            return _loc_1;
        }// end function

        public function isUpdateable() : Boolean
        {
            return !this.baked;
        }// end function

        public function copy(param1:MaterialObject3D) : void
        {
            this.bitmap = param1.bitmap;
            this.smooth = param1.smooth;
            this.lineColor = param1.lineColor;
            this.lineAlpha = param1.lineAlpha;
            this.fillColor = param1.fillColor;
            this.fillAlpha = param1.fillAlpha;
            this.oneSide = param1.oneSide;
            this.opposite = param1.opposite;
            this.invisible = param1.invisible;
            this.name = param1.name;
            this.maxU = param1.maxU;
            this.maxV = param1.maxV;
            return;
        }// end function

        public function destroy() : void
        {
            this.objects = null;
            this.bitmap = null;
            MaterialManager.unRegisterMaterial(this);
            return;
        }// end function

        public function drawTriangle(param1:RenderTriangle, param2:Graphics, param3:RenderSessionData, param4:BitmapData = null, param5:Matrix = null) : void
        {
            return;
        }// end function

        public static function get DEFAULT() : MaterialObject3D
        {
            var _loc_1:* = new WireframeMaterial();
            _loc_1.lineColor = 16777215 * Math.random();
            _loc_1.lineAlpha = 1;
            _loc_1.fillColor = DEFAULT_COLOR;
            _loc_1.fillAlpha = 1;
            _loc_1.doubleSided = false;
            return _loc_1;
        }// end function

        public static function get DEBUG() : MaterialObject3D
        {
            var _loc_1:* = new MaterialObject3D;
            _loc_1.lineColor = 16777215 * Math.random();
            _loc_1.lineAlpha = 1;
            _loc_1.fillColor = DEBUG_COLOR;
            _loc_1.fillAlpha = 0.37;
            _loc_1.doubleSided = true;
            return _loc_1;
        }// end function

    }
}
