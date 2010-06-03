package mx.effects
{
    import mx.effects.effectClasses.*;

    public class Glow extends TweenEffect
    {
        public var knockout:Boolean;
        public var color:uint = 4.29497e+009;
        public var alphaFrom:Number;
        public var blurXTo:Number;
        public var blurYTo:Number;
        public var strength:Number;
        public var alphaTo:Number;
        public var blurXFrom:Number;
        public var blurYFrom:Number;
        public var inner:Boolean;
        static const VERSION:String = "3.2.0.3958";
        private static var AFFECTED_PROPERTIES:Array = ["filters"];

        public function Glow(param1:Object = null)
        {
            super(param1);
            instanceClass = GlowInstance;
            return;
        }// end function

        override protected function initInstance(param1:IEffectInstance) : void
        {
            var _loc_2:GlowInstance = null;
            super.initInstance(param1);
            _loc_2 = GlowInstance(param1);
            _loc_2.alphaFrom = alphaFrom;
            _loc_2.alphaTo = alphaTo;
            _loc_2.blurXFrom = blurXFrom;
            _loc_2.blurXTo = blurXTo;
            _loc_2.blurYFrom = blurYFrom;
            _loc_2.blurYTo = blurYTo;
            _loc_2.color = color;
            _loc_2.inner = inner;
            _loc_2.knockout = knockout;
            _loc_2.strength = strength;
            return;
        }// end function

        override public function getAffectedProperties() : Array
        {
            return AFFECTED_PROPERTIES;
        }// end function

    }
}
