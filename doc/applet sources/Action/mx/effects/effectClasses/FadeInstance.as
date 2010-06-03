package mx.effects.effectClasses
{
    import flash.events.*;
    import mx.core.*;
    import mx.events.*;

    public class FadeInstance extends TweenEffectInstance
    {
        public var alphaFrom:Number;
        private var restoreAlpha:Boolean;
        public var alphaTo:Number;
        private var origAlpha:Number = 1.#QNAN;
        static const VERSION:String = "3.2.0.3958";

        public function FadeInstance(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function initEffect(event:Event) : void
        {
            super.initEffect(event);
            switch(event.type)
            {
                case "childrenCreationComplete":
                case FlexEvent.CREATION_COMPLETE:
                case FlexEvent.SHOW:
                case Event.ADDED:
                case "resizeEnd":
                {
                    if (isNaN(alphaFrom))
                    {
                        alphaFrom = 0;
                    }
                    if (isNaN(alphaTo))
                    {
                        alphaTo = target.alpha;
                    }
                    break;
                }
                case FlexEvent.HIDE:
                case Event.REMOVED:
                case "resizeStart":
                {
                    restoreAlpha = true;
                    if (isNaN(alphaFrom))
                    {
                        alphaFrom = target.alpha;
                    }
                    if (isNaN(alphaTo))
                    {
                        alphaTo = 0;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override public function onTweenEnd(param1:Object) : void
        {
            super.onTweenEnd(param1);
            if (mx_internal::hideOnEffectEnd || restoreAlpha)
            {
                target.alpha = origAlpha;
            }
            return;
        }// end function

        override public function play() : void
        {
            super.play();
            origAlpha = target.alpha;
            var _loc_1:* = propertyChanges;
            if (isNaN(alphaFrom) && isNaN(alphaTo))
            {
                if (_loc_1 && _loc_1.end["alpha"] !== undefined)
                {
                    alphaFrom = origAlpha;
                    alphaTo = _loc_1.end["alpha"];
                }
                else if (_loc_1 && _loc_1.end["visible"] !== undefined)
                {
                    alphaFrom = _loc_1.start["visible"] ? (origAlpha) : (0);
                    alphaTo = _loc_1.end["visible"] ? (origAlpha) : (0);
                }
                else
                {
                    alphaFrom = 0;
                    alphaTo = origAlpha;
                }
            }
            else if (isNaN(alphaFrom))
            {
                alphaFrom = alphaTo == 0 ? (origAlpha) : (0);
            }
            else if (isNaN(alphaTo))
            {
                if (_loc_1 && _loc_1.end["alpha"] !== undefined)
                {
                    alphaTo = _loc_1.end["alpha"];
                }
                else
                {
                    alphaTo = alphaFrom == 0 ? (origAlpha) : (0);
                }
            }
            tween = createTween(this, alphaFrom, alphaTo, duration);
            var _loc_2:* = tween;
            target.alpha = _loc_2.mx_internal::getCurrentValue(0);
            return;
        }// end function

        override public function onTweenUpdate(param1:Object) : void
        {
            target.alpha = param1;
            return;
        }// end function

    }
}
