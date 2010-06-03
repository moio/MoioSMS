package ws.tink.flex.pv3dEffects
{
    import mx.core.*;
    import mx.effects.*;
    import ws.tink.flex.pv3dEffects.effectClasses.*;

    public class Flip extends Effect
    {
        public var constrain:Boolean = false;
        public var type:String = "show";
        public var direction:String = "left";
        public static const LEFT:String = "left";
        public static const HIDE:String = "hide";
        public static const DOWN:String = "down";
        public static const UP:String = "up";
        public static const RIGHT:String = "right";
        public static const SHOW:String = "show";
        private static var AFFECTED_PROPERTIES:Array = ["rotationX (PV3D)", "rotationY (PV3D)", "rotationZ (PV3D)"];

        public function Flip(param1:UIComponent = null)
        {
            super(param1);
            instanceClass = FlipInstance;
            return;
        }// end function

        override protected function initInstance(param1:IEffectInstance) : void
        {
            super.initInstance(param1);
            var _loc_2:* = FlipInstance(param1);
            _loc_2.type = this.type;
            _loc_2.direction = this.direction;
            _loc_2.constrain = this.constrain;
            return;
        }// end function

        override public function getAffectedProperties() : Array
        {
            return AFFECTED_PROPERTIES;
        }// end function

    }
}
