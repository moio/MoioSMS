package mx.effects.effectClasses
{
    import flash.events.*;
    import flash.filters.*;

    public class BlurInstance extends TweenEffectInstance
    {
        public var blurXTo:Number;
        public var blurYTo:Number;
        public var blurXFrom:Number;
        public var blurYFrom:Number;
        static const VERSION:String = "3.2.0.3958";

        public function BlurInstance(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function initEffect(event:Event) : void
        {
            super.initEffect(event);
            return;
        }// end function

        override public function onTweenEnd(param1:Object) : void
        {
            setBlurFilter(param1[0], param1[1]);
            super.onTweenEnd(param1);
            return;
        }// end function

        private function setBlurFilter(param1:Number, param2:Number) : void
        {
            var _loc_3:* = target.filters;
            var _loc_4:* = _loc_3.length;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                if (_loc_3[_loc_5] is BlurFilter)
                {
                    _loc_3.splice(_loc_5, 1);
                }
                _loc_5++;
            }
            if (param1 || param2)
            {
                _loc_3.push(new BlurFilter(param1, param2));
            }
            target.filters = _loc_3;
            return;
        }// end function

        override public function play() : void
        {
            super.play();
            if (isNaN(blurXFrom))
            {
                blurXFrom = 4;
            }
            if (isNaN(blurXTo))
            {
                blurXTo = 0;
            }
            if (isNaN(blurYFrom))
            {
                blurYFrom = 4;
            }
            if (isNaN(blurYTo))
            {
                blurYTo = 0;
            }
            tween = createTween(this, [blurXFrom, blurYFrom], [blurXTo, blurYTo], duration);
            return;
        }// end function

        override public function onTweenUpdate(param1:Object) : void
        {
            setBlurFilter(param1[0], param1[1]);
            return;
        }// end function

    }
}
