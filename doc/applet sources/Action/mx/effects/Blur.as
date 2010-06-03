package mx.effects
{
    import mx.effects.effectClasses.*;

    public class Blur extends TweenEffect
    {
        public var blurXTo:Number;
        public var blurXFrom:Number;
        public var blurYFrom:Number;
        public var blurYTo:Number;
        static const VERSION:String = "3.2.0.3958";
        private static var AFFECTED_PROPERTIES:Array = ["filters"];

        public function Blur(param1:Object = null)
        {
            super(param1);
            instanceClass = BlurInstance;
            return;
        }// end function

        override public function getAffectedProperties() : Array
        {
            return AFFECTED_PROPERTIES;
        }// end function

        override protected function initInstance(param1:IEffectInstance) : void
        {
            var _loc_2:BlurInstance = null;
            super.initInstance(param1);
            _loc_2 = BlurInstance(param1);
            _loc_2.blurXFrom = blurXFrom;
            _loc_2.blurXTo = blurXTo;
            _loc_2.blurYFrom = blurYFrom;
            _loc_2.blurYTo = blurYTo;
            return;
        }// end function

    }
}
