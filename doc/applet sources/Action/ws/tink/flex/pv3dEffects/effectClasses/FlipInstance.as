package ws.tink.flex.pv3dEffects.effectClasses
{
    import flash.events.*;
    import mx.core.*;
    import mx.events.*;
    import org.papervision3d.materials.*;
    import org.papervision3d.objects.primitives.*;
    import ws.tink.flex.pv3dEffects.*;

    public class FlipInstance extends EffectInstance
    {
        public var _zFrom:Number;
        public var type:String;
        public var _zTo:Number;
        private var _plane:Plane;
        public var _rotationXFrom:Number;
        public var _rotationYFrom:Number;
        public var _rotationXTo:Number;
        public var _rotationYTo:Number;
        public var constrain:Boolean;
        public var direction:String;

        public function FlipInstance(param1:UIComponent)
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

        override public function destroy() : void
        {
            _root3D.removeChild(this._plane);
            var _loc_1:String = null;
            this._plane = null;
            super.destroy();
            return;
        }// end function

        override protected function createPropertiesToTween() : void
        {
            var _loc_1:* = new Array(this._rotationXFrom, this._rotationYFrom, this._zFrom);
            _from = new Array(this._rotationXFrom, this._rotationYFrom, this._zFrom);
            var _loc_1:* = new Array(this._rotationXTo, this._rotationYTo, this._zTo);
            _to = new Array(this._rotationXTo, this._rotationYTo, this._zTo);
            return;
        }// end function

        override public function onTweenUpdate(param1:Object) : void
        {
            this._plane.rotationX = isNaN(param1[0]) ? (0) : (param1[0]);
            this._plane.rotationY = isNaN(param1[1]) ? (0) : (param1[1]);
            this._plane.z = isNaN(param1[2]) ? (0) : (param1[2]);
            super.onTweenUpdate(param1);
            return;
        }// end function

        override protected function createDisplayObject3Ds() : void
        {
            switch(this.direction)
            {
                case Flip.LEFT:
                {
                    this._rotationXFrom = 0;
                    this._rotationXTo = 0;
                    this._rotationYFrom = this.type == Flip.SHOW ? (-90) : (0);
                    this._rotationYTo = this._rotationYFrom + 90;
                    break;
                }
                case Flip.RIGHT:
                {
                    this._rotationXFrom = 0;
                    this._rotationXTo = 0;
                    this._rotationYFrom = this.type == Flip.SHOW ? (90) : (0);
                    this._rotationYTo = this._rotationYFrom - 90;
                    break;
                }
                case Flip.DOWN:
                {
                    this._rotationXFrom = this.type == Flip.SHOW ? (-90) : (0);
                    this._rotationXTo = this._rotationXFrom + 90;
                    this._rotationYFrom = 0;
                    this._rotationYTo = 0;
                    break;
                }
                case Flip.UP:
                {
                    this._rotationXFrom = this.type == Flip.SHOW ? (90) : (0);
                    this._rotationXTo = this._rotationXFrom - 90;
                    this._rotationYFrom = 0;
                    this._rotationYTo = 0;
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_1:* = new Plane(BitmapMaterial(_materials[0]), target.width, target.height, 8, 8);
            this._plane = new Plane(BitmapMaterial(_materials[0]), target.width, target.height, 8, 8);
            var _loc_1:* = this._rotationXFrom;
            this._plane.rotationX = this._rotationXFrom;
            var _loc_1:* = this._rotationYFrom;
            this._plane.rotationY = this._rotationYFrom;
            if (this.constrain)
            {
                if (this.type == Flip.SHOW)
                {
                    var _loc_1:* = target.width / 2;
                    this._zFrom = target.width / 2;
                    var _loc_1:int = 0;
                    this._zTo = 0;
                }
                else
                {
                    var _loc_1:int = 0;
                    this._zFrom = 0;
                    var _loc_1:* = target.width / 2;
                    this._zTo = target.width / 2;
                }
            }
            else
            {
                var _loc_1:int = 0;
                this._zFrom = 0;
                var _loc_1:int = 0;
                this._zTo = 0;
            }
            _root3D.addChild(this._plane, "plane");
            return;
        }// end function

    }
}
