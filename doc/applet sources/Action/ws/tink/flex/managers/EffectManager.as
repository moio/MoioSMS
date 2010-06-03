package ws.tink.flex.managers
{
    import mx.core.*;
    import mx.events.*;
    import ws.tink.flex.pv3dEffects.effectClasses.*;

    public class EffectManager extends UIComponent
    {
        private var _cache:Array;
        private static var instance:EffectManager;
        private static var allowCreation:Boolean;

        public function EffectManager()
        {
            if (!allowCreation)
            {
                throw new Error("EffectManager is a singleton and can only be accessed through EffectManager.effectManager");
            }
            return;
        }// end function

        private function onEffectCreationComplete(event:FlexEvent) : void
        {
            this.removePrevCachedEffect(EffectInstance(event.currentTarget));
            return;
        }// end function

        private function removePrevCachedEffect(param1:EffectInstance) : void
        {
            var _loc_3:int = 0;
            if (this._cache.length > 1)
            {
                _loc_3 = 0;
                if (_loc_3 != -1)
                {
                    this.removeEffect(CacheInstance(this._cache.splice(_loc_3, 1)[0]));
                }
            }
            var _loc_2:Number = 0;
            while (_loc_2++ < this._cache.length)
            {
                
                if (CacheInstance(this._cache[_loc_2]).display != null)
                {
                    removeChild(CacheInstance(this._cache[_loc_2]).display);
                }
            }
            return;
        }// end function

        private function onEffectEnd(event:EffectEvent) : void
        {
            var _loc_2:* = EffectInstance(event.target);
            if (_loc_2 is CacheInstance)
            {
                if (CacheInstance(_loc_2).cache)
                {
                    this._cache.push(_loc_2);
                    return;
                }
            }
            this.removeEffect(_loc_2);
            return;
        }// end function

        override public function initialize() : void
        {
            super.initialize();
            mouseEnabled = false;
            mouseChildren = false;
            this._cache = new Array();
            return;
        }// end function

        public function addEffect(param1:EffectInstance) : void
        {
            param1.addEventListener(FlexEvent.CREATION_COMPLETE, this.onEffectCreationComplete, false, 0, true);
            param1.addEventListener(EffectEvent.EFFECT_START, this.onEffectStart, false, 0, true);
            param1.addEventListener(EffectEvent.EFFECT_END, this.onEffectEnd, false, 0, true);
            return;
        }// end function

        public function removeEffect(param1:EffectInstance) : void
        {
            param1.removeEventListener(FlexEvent.CREATION_COMPLETE, this.onEffectCreationComplete, false);
            param1.removeEventListener(EffectEvent.EFFECT_START, this.onEffectStart, false);
            param1.removeEventListener(EffectEvent.EFFECT_END, this.onEffectEnd, false);
            if (param1.display != null)
            {
                if (param1.display.parent == this)
                {
                    removeChild(param1.display);
                }
            }
            param1.destroy();
            return;
        }// end function

        private function getPrevEffectIndex(param1:EffectInstance) : int
        {
            var _loc_2:EffectInstance = null;
            var _loc_3:* = this._cache.length;
            while (_loc_4-- >= 0)
            {
                
                _loc_2 = CacheInstance(this._cache[_loc_3--]);
                if (_loc_2.target.parent == param1.target.parent)
                {
                    return _loc_4;
                }
            }
            return -1;
        }// end function

        private function onEffectStart(event:EffectEvent) : void
        {
            var _loc_2:* = EffectInstance(event.target);
            addChild(_loc_2.display);
            return;
        }// end function

        public function getPrevEffect(param1:EffectInstance) : CacheInstance
        {
            var _loc_2:* = this.getPrevEffectIndex(param1);
            if (_loc_2 != -1)
            {
                return CacheInstance(this._cache[_loc_2]);
            }
            return null;
        }// end function

        public static function get effectManager() : EffectManager
        {
            if (!instance)
            {
                allowCreation = true;
                instance = new EffectManager;
                allowCreation = false;
                Application.application.systemManager.addChild(instance);
            }
            return instance;
        }// end function

    }
}
