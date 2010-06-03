package ws.tink.flex.pv3dEffects.effectClasses
{
    import flash.display.*;
    import mx.core.*;

    public class CacheInstance extends EffectInstance
    {
        protected var _cache:Boolean;

        public function CacheInstance(param1:UIComponent)
        {
            super(param1);
            return;
        }// end function

        override protected function initialize() : void
        {
            super.initialize();
            this._cache = true;
            return;
        }// end function

        public function get cache() : Boolean
        {
            return this._cache;
        }// end function

        override public function play() : void
        {
            super.play();
            if (toString() == "[object CacheInstance]")
            {
                _display.callLater(this.onTweenEnd, [0]);
            }
            return;
        }// end function

        public function get materials() : Array
        {
            return _materials;
        }// end function

        override protected function createDisplayObject3Ds() : void
        {
            var _loc_1:* = new Bitmap(BitmapData(_bitmapDatas[0]));
            _display.addChild(_loc_1);
            return;
        }// end function

        override public function onTweenEnd(param1:Object) : void
        {
            super.onTweenEnd(param1);
            return;
        }// end function

    }
}
