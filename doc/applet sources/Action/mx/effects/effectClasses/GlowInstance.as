package mx.effects.effectClasses
{
    import flash.events.*;
    import flash.filters.*;
    import mx.core.*;
    import mx.styles.*;

    public class GlowInstance extends TweenEffectInstance
    {
        public var strength:Number;
        public var inner:Boolean;
        public var blurXFrom:Number;
        public var blurYFrom:Number;
        public var color:uint = 4.29497e+009;
        public var alphaFrom:Number;
        public var blurYTo:Number;
        public var blurXTo:Number;
        public var alphaTo:Number;
        public var knockout:Boolean;
        static const VERSION:String = "3.2.0.3958";

        public function GlowInstance(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function initEffect(event:Event) : void
        {
            super.initEffect(event);
            return;
        }// end function

        override public function play() : void
        {
            super.play();
            if (isNaN(alphaFrom))
            {
                alphaFrom = 1;
            }
            if (isNaN(alphaTo))
            {
                alphaTo = 0;
            }
            if (isNaN(blurXFrom))
            {
                blurXFrom = 5;
            }
            if (isNaN(blurXTo))
            {
                blurXTo = 0;
            }
            if (isNaN(blurYFrom))
            {
                blurYFrom = 5;
            }
            if (isNaN(blurYTo))
            {
                blurYTo = 0;
            }
            if (color == StyleManager.NOT_A_COLOR)
            {
                color = Application.application.getStyle("themeColor");
            }
            if (isNaN(strength))
            {
                strength = 2;
            }
            tween = createTween(this, [color, alphaFrom, blurXFrom, blurYFrom], [color, alphaTo, blurXTo, blurYTo], duration);
            return;
        }// end function

        private function setGlowFilter(param1:uint, param2:Number, param3:Number, param4:Number) : void
        {
            var _loc_5:* = target.filters;
            var _loc_6:* = target.filters.length;
            var _loc_7:int = 0;
            while (_loc_7 < _loc_6)
            {
                
                if (_loc_5[_loc_7] is GlowFilter)
                {
                    _loc_5.splice(_loc_7, 1);
                }
                _loc_7++;
            }
            if (param3 || param4 || param2)
            {
                _loc_5.push(new GlowFilter(param1, param2, param3, param4, strength, 1, inner, knockout));
            }
            target.filters = _loc_5;
            return;
        }// end function

        override public function onTweenEnd(param1:Object) : void
        {
            setGlowFilter(param1[0], param1[1], param1[2], param1[3]);
            super.onTweenEnd(param1);
            return;
        }// end function

        override public function onTweenUpdate(param1:Object) : void
        {
            setGlowFilter(param1[0], param1[1], param1[2], param1[3]);
            return;
        }// end function

    }
}
