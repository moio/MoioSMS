package ws.tink.flex.pv3dEffects
{
    import mx.core.*;
    import mx.effects.*;
    import ws.tink.flex.pv3dEffects.effectClasses.*;

    public class Zoom extends Rotate
    {
        public var scaleFrom:Number;
        public var scaleTo:Number;
        public var alphaFrom:Number;
        public var alphaTo:Number;

        public function Zoom(param1:UIComponent = null)
        {
            super(param1);
            instanceClass = ZoomInstance;
            return;
        }// end function

        override protected function initInstance(param1:IEffectInstance) : void
        {
            super.initInstance(param1);
            var _loc_2:* = ZoomInstance(param1);
            _loc_2.alphaFrom = !isNaN(this.alphaFrom) ? (this.alphaFrom) : (1);
            _loc_2.alphaTo = !isNaN(this.alphaTo) ? (this.alphaTo) : (1);
            _loc_2.scaleFrom = !isNaN(this.scaleFrom) ? (this.scaleFrom) : (1);
            _loc_2.scaleTo = !isNaN(this.scaleTo) ? (this.scaleTo) : (1);
            return;
        }// end function

        override public function getAffectedProperties() : Array
        {
            return super.getAffectedProperties().concat(["alpha", "scaleX", "scaleY"]);
        }// end function

    }
}
