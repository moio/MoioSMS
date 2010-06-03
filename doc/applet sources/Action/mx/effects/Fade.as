package mx.effects
{
    import mx.effects.effectClasses.*;

    public class Fade extends TweenEffect
    {
        public var alphaFrom:Number;
        public var alphaTo:Number;
        static const VERSION:String = "3.2.0.3958";
        private static var AFFECTED_PROPERTIES:Array = ["alpha", "visible"];

        public function Fade(param1:Object = null)
        {
            super(param1);
            instanceClass = FadeInstance;
            return;
        }// end function

        override protected function initInstance(param1:IEffectInstance) : void
        {
            super.initInstance(param1);
            var _loc_2:* = FadeInstance(param1);
            _loc_2.alphaFrom = alphaFrom;
            _loc_2.alphaTo = alphaTo;
            return;
        }// end function

        override public function getAffectedProperties() : Array
        {
            return AFFECTED_PROPERTIES;
        }// end function

    }
}
