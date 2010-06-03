package mx.effects.effectClasses
{
    import mx.effects.*;

    public class RotateInstance extends TweenEffectInstance
    {
        public var originX:Number;
        public var originY:Number;
        private var centerX:Number;
        private var centerY:Number;
        public var angleTo:Number = 360;
        private var originalOffsetX:Number;
        private var originalOffsetY:Number;
        private var newX:Number;
        private var newY:Number;
        public var angleFrom:Number = 0;
        static const VERSION:String = "3.2.0.3958";

        public function RotateInstance(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function onTweenUpdate(param1:Object) : void
        {
            if (Math.abs(newX - target.x) > 0.1)
            {
                centerX = target.x + originalOffsetX;
            }
            if (Math.abs(newY - target.y) > 0.1)
            {
                centerY = target.y + originalOffsetY;
            }
            var _loc_2:* = Number(param1);
            var _loc_3:* = Math.PI * _loc_2 / 180;
            EffectManager.suspendEventHandling();
            target.rotation = _loc_2;
            newX = centerX - originX * Math.cos(_loc_3) + originY * Math.sin(_loc_3);
            newY = centerY - originX * Math.sin(_loc_3) - originY * Math.cos(_loc_3);
            newX = Number(newX.toFixed(1));
            newY = Number(newY.toFixed(1));
            target.move(newX, newY);
            EffectManager.resumeEventHandling();
            return;
        }// end function

        override public function play() : void
        {
            super.play();
            var _loc_1:* = Math.PI * target.rotation / 180;
            if (isNaN(originX))
            {
                originX = target.width / 2;
            }
            if (isNaN(originY))
            {
                originY = target.height / 2;
            }
            centerX = target.x + originX * Math.cos(_loc_1) - originY * Math.sin(_loc_1);
            centerY = target.y + originX * Math.sin(_loc_1) + originY * Math.cos(_loc_1);
            if (isNaN(angleFrom))
            {
                angleFrom = target.rotation;
            }
            if (isNaN(angleTo))
            {
                angleTo = target.rotation == 0 ? (angleFrom > 180 ? (360) : (0)) : (target.rotation);
            }
            tween = createTween(this, angleFrom, angleTo, duration);
            target.rotation = angleFrom;
            _loc_1 = Math.PI * angleFrom / 180;
            EffectManager.suspendEventHandling();
            originalOffsetX = originX * Math.cos(_loc_1) - originY * Math.sin(_loc_1);
            originalOffsetY = originX * Math.sin(_loc_1) + originY * Math.cos(_loc_1);
            newX = Number((centerX - originalOffsetX).toFixed(1));
            newY = Number((centerY - originalOffsetY).toFixed(1));
            target.move(newX, newY);
            EffectManager.resumeEventHandling();
            return;
        }// end function

    }
}
