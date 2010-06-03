package mx.effects
{
    import mx.effects.effectClasses.*;

    public class Move extends TweenEffect
    {
        public var xFrom:Number;
        public var yFrom:Number;
        public var xBy:Number;
        public var yBy:Number;
        public var yTo:Number;
        public var xTo:Number;
        static const VERSION:String = "3.2.0.3958";
        private static var AFFECTED_PROPERTIES:Array = ["x", "y"];

        public function Move(param1:Object = null)
        {
            super(param1);
            instanceClass = MoveInstance;
            return;
        }// end function

        override protected function initInstance(param1:IEffectInstance) : void
        {
            var _loc_2:MoveInstance = null;
            super.initInstance(param1);
            _loc_2 = MoveInstance(param1);
            _loc_2.xFrom = xFrom;
            _loc_2.xTo = xTo;
            _loc_2.xBy = xBy;
            _loc_2.yFrom = yFrom;
            _loc_2.yTo = yTo;
            _loc_2.yBy = yBy;
            return;
        }// end function

        override public function getAffectedProperties() : Array
        {
            return AFFECTED_PROPERTIES;
        }// end function

    }
}
