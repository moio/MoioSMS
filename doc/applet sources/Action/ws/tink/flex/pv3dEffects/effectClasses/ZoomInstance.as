package ws.tink.flex.pv3dEffects.effectClasses
{
    import flash.events.*;
    import mx.core.*;
    import mx.events.*;
    import org.papervision3d.materials.*;
    import org.papervision3d.objects.primitives.*;

    public class ZoomInstance extends RotateInstance
    {
        public var scaleTo:Number;
        public var alphaFrom:Number;
        public var scaleFrom:Number;
        public var alphaTo:Number;

        public function ZoomInstance(param1:UIComponent)
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
            super.createPropertiesToTween();
            _to = _to.concat(new Array(this.alphaTo, this.scaleTo));
            _from = _from.concat(new Array(this.alphaFrom, this.scaleFrom));
            return;
        }// end function

        override public function onTweenUpdate(param1:Object) : void
        {
            super.onTweenUpdate(param1);
            _display.alpha = isNaN(param1[3]) ? (1) : (param1[3]);
            var _loc_2:* = isNaN(param1[4]) ? (1) : (param1[4]);
            _plane.scaleY = isNaN(param1[4]) ? (1) : (param1[4]);
            _plane.scaleX = _loc_2;
            super.onTweenUpdate(param1);
            return;
        }// end function

        override protected function createDisplayObject3Ds() : void
        {
            if (_plane)
            {
                _root3D.removeChild(_plane);
            }
            var _loc_1:* = BitmapMaterial(_materials[0]);
            _loc_1.oneSide = false;
            _plane = new Plane(_loc_1, target.width, target.height, 8, 8);
            _plane.rotationX = rotationXFrom;
            _plane.rotationY = rotationYFrom;
            _plane.rotationZ = rotationZFrom;
            _root3D.addChild(_plane, "plane");
            return;
        }// end function

    }
}
