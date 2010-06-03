package ws.tink.flex.pv3dEffects
{
    import mx.core.*;
    import mx.effects.*;
    import ws.tink.flex.pv3dEffects.effectClasses.*;

    public class Effect extends TweenEffect
    {
        private const DEFAULT_HIDE_METHOD:String = "blendMode";
        public var transparent:Boolean;
        public var hideMethod:String;
        private const DEFAULT_TRANSPARENT:Boolean = false;
        public static const HIDE_METHOD_BLEND_MODE:String = "blendMode";
        public static const HIDE_METHOD_NONE:String = "none";
        public static const HIDE_METHOD_ALPHA:String = "alpha";

        public function Effect(param1:UIComponent)
        {
            this.hideMethod = this.DEFAULT_HIDE_METHOD;
            this.transparent = this.DEFAULT_TRANSPARENT;
            super(param1);
            instanceClass = EffectInstance;
            return;
        }// end function

        override protected function initInstance(param1:IEffectInstance) : void
        {
            super.initInstance(param1);
            var _loc_2:* = EffectInstance(param1);
            _loc_2.hideMethod = this.hideMethod;
            _loc_2.transparent = this.transparent;
            return;
        }// end function

    }
}
