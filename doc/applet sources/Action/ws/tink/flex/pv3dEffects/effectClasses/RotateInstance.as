package ws.tink.flex.pv3dEffects.effectClasses
{
    import flash.events.*;
    import mx.core.*;
    import mx.events.*;
    import org.papervision3d.materials.*;
    import org.papervision3d.objects.primitives.*;

    public class RotateInstance extends EffectInstance
    {
        public var rotationXFrom:Number;
        public var rotationYFrom:Number;
        public var rotationZFrom:Number;
        public var rotationXTo:Number;
        public var rotationYTo:Number;
        public var rotationZTo:Number;
        protected var _plane:Plane;

        public function RotateInstance(param1:UIComponent)
        {
            super(param1);
            return;
        }// end function

        override public function initEffect(event:Event) : void
        {
            switch(event.type)
            {
                case Event.ADDED:
                case Event.REMOVED:
                case "childrenCreationComplete":
                case FlexEvent.CREATION_COMPLETE:
                case FlexEvent.SHOW:
                case FlexEvent.HIDE:
                {
                    super.initEffect(event);
                    break;
                }
                case "resizeStart":
                case "resizeEnd":
                {
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override protected function createPropertiesToTween() : void
        {
            _to = new Array(this.rotationXTo, this.rotationYTo, this.rotationZTo);
            _from = new Array(this.rotationXFrom, this.rotationYFrom, this.rotationZFrom);
            return;
        }// end function

        override public function onTweenUpdate(param1:Object) : void
        {
            this._plane.rotationX = isNaN(param1[0]) ? (0) : (param1[0]);
            this._plane.rotationY = isNaN(param1[1]) ? (0) : (param1[1]);
            this._plane.rotationZ = isNaN(param1[2]) ? (0) : (param1[2]);
            super.onTweenUpdate(param1);
            return;
        }// end function

        override protected function createDisplayObject3Ds() : void
        {
            if (this._plane)
            {
                _root3D.removeChild(this._plane);
            }
            var _loc_1:* = BitmapMaterial(_materials[0]);
            _loc_1.oneSide = false;
            this._plane = new Plane(_loc_1, target.width, target.height, 8, 8);
            this._plane.rotationX = this.rotationXFrom;
            this._plane.rotationY = this.rotationYFrom;
            this._plane.rotationZ = this.rotationZFrom;
            _root3D.addChild(this._plane, "plane");
            return;
        }// end function

    }
}
