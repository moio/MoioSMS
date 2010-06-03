package org.papervision3d.materials
{
    import flash.display.*;
    import flash.geom.*;
    import org.papervision3d.core.log.*;
    import org.papervision3d.core.render.command.*;
    import org.papervision3d.core.render.data.*;

    public class MovieMaterial extends BitmapMaterial implements ITriangleDrawer, IUpdateBeforeMaterial, IUpdateAfterMaterial
    {
        public var movieTransparent:Boolean;
        private var quality:String;
        private var materialIsUsed:Boolean = false;
        private var stage:Stage;
        private var autoClipRect:Rectangle;
        public var allowAutoResize:Boolean = false;
        public var movie:DisplayObject;
        private var movieAnimated:Boolean;
        protected var recreateBitmapInSuper:Boolean;
        private var userClipRect:Rectangle;

        public function MovieMaterial(param1:DisplayObject = null, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false, param5:Rectangle = null)
        {
            this.movieTransparent = param2;
            this.animated = param3;
            this.precise = param4;
            this.userClipRect = param5;
            if (param1)
            {
                this.texture = param1;
            }
            return;
        }// end function

        protected function createBitmapFromSprite(param1:DisplayObject) : BitmapData
        {
            this.movie = param1;
            this.initBitmap(this.movie);
            this.drawBitmap();
            bitmap = super.createBitmap(bitmap);
            return bitmap;
        }// end function

        public function set rect(param1:Rectangle) : void
        {
            this.userClipRect = param1;
            this.createBitmapFromSprite(this.movie);
            return;
        }// end function

        public function updateAfterRender(param1:RenderSessionData) : void
        {
            if (this.movieAnimated == true && this.materialIsUsed == true)
            {
                this.drawBitmap();
                if (this.recreateBitmapInSuper)
                {
                    bitmap = super.createBitmap(bitmap);
                    this.recreateBitmapInSuper = false;
                }
            }
            return;
        }// end function

        public function set animated(param1:Boolean) : void
        {
            this.movieAnimated = param1;
            return;
        }// end function

        public function drawBitmap() : void
        {
            var _loc_3:String = null;
            bitmap.fillRect(bitmap.rect, fillColor);
            if (this.stage && this.quality)
            {
                _loc_3 = this.stage.quality;
                this.stage.quality = this.quality;
            }
            var _loc_1:* = this.rect;
            var _loc_2:* = new Matrix(1, 0, 0, 1, -_loc_1.x, -_loc_1.y);
            bitmap.draw(this.movie, _loc_2, this.movie.transform.colorTransform, null);
            if (!this.userClipRect)
            {
                this.autoClipRect = this.movie.getBounds(this.movie);
            }
            if (this.stage && this.quality)
            {
                this.stage.quality = _loc_3;
            }
            return;
        }// end function

        override public function get texture() : Object
        {
            return this._texture;
        }// end function

        public function updateBeforeRender(param1:RenderSessionData) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            this.materialIsUsed = false;
            if (this.movieAnimated)
            {
                if (this.userClipRect)
                {
                    _loc_2 = int(this.userClipRect.width + 0.5);
                    _loc_3 = int(this.userClipRect.height + 0.5);
                }
                else
                {
                    _loc_2 = int(this.movie.width + 0.5);
                    _loc_3 = int(this.movie.height + 0.5);
                }
                if (this.allowAutoResize && _loc_2 != bitmap.width || _loc_3 != bitmap.height)
                {
                    this.initBitmap(this.movie);
                    this.recreateBitmapInSuper = true;
                }
            }
            return;
        }// end function

        protected function initBitmap(param1:DisplayObject) : void
        {
            if (bitmap)
            {
                bitmap.dispose();
            }
            if (this.userClipRect)
            {
                bitmap = new BitmapData(int(this.userClipRect.width + 0.5), int(this.userClipRect.height + 0.5), this.movieTransparent, fillColor);
            }
            else if (param1.width == 0 || param1.height == 0)
            {
                bitmap = new BitmapData(256, 256, this.movieTransparent, fillColor);
            }
            else
            {
                bitmap = new BitmapData(int(param1.width + 0.5), int(param1.height + 0.5), this.movieTransparent, fillColor);
            }
            return;
        }// end function

        public function get animated() : Boolean
        {
            return this.movieAnimated;
        }// end function

        public function get rect() : Rectangle
        {
            if (!this.userClipRect)
            {
            }
            var _loc_1:* = this.autoClipRect;
            if (!_loc_1 && this.movie)
            {
                _loc_1 = this.movie.getBounds(this.movie);
            }
            return _loc_1;
        }// end function

        override public function set texture(param1:Object) : void
        {
            if (param1 is DisplayObject == false)
            {
                PaperLogger.error("MovieMaterial.texture requires a Sprite to be passed as the object");
                return;
            }
            bitmap = this.createBitmapFromSprite(DisplayObject(param1));
            _texture = param1;
            return;
        }// end function

        override public function drawTriangle(param1:RenderTriangle, param2:Graphics, param3:RenderSessionData, param4:BitmapData = null, param5:Matrix = null) : void
        {
            this.materialIsUsed = true;
            super.drawTriangle(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function setQuality(param1:String, param2:Stage, param3:Boolean = true) : void
        {
            this.quality = param1;
            this.stage = param2;
            if (param3)
            {
                this.createBitmapFromSprite(this.movie);
            }
            return;
        }// end function

    }
}
