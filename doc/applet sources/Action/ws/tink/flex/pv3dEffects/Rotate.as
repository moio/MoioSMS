package ws.tink.flex.pv3dEffects
{
    import mx.core.*;
    import mx.effects.*;
    import ws.tink.flex.pv3dEffects.effectClasses.*;

    public class Rotate extends Effect
    {
        public var rotationXFrom:Number;
        public var rotationYFrom:Number;
        public var rotationZFrom:Number;
        public var rotationXTo:Number;
        public var rotationYTo:Number;
        public var rotationZTo:Number;
        private static var AFFECTED_PROPERTIES:Array = ["rotationX (PV3D)", "rotationY (PV3D)", "rotationZ (PV3D)"];

        public function Rotate(param1:UIComponent = null)
        {
            super(param1);
            instanceClass = RotateInstance;
            return;
        }// end function

        override protected function initInstance(param1:IEffectInstance) : void
        {
            super.initInstance(param1);
            var _loc_2:* = RotateInstance(param1);
            _loc_2.rotationXFrom = this.rotationXFrom ? (this.rotationXFrom) : (0);
            _loc_2.rotationXTo = this.rotationXTo ? (this.rotationXTo) : (0);
            _loc_2.rotationYFrom = this.rotationYFrom ? (this.rotationYFrom) : (0);
            _loc_2.rotationYTo = this.rotationYTo ? (this.rotationYTo) : (0);
            _loc_2.rotationZFrom = this.rotationZFrom ? (this.rotationZFrom) : (0);
            _loc_2.rotationZTo = this.rotationZTo ? (this.rotationZTo) : (0);
            return;
        }// end function

        override public function getAffectedProperties() : Array
        {
            return AFFECTED_PROPERTIES;
        }// end function

    }
}
