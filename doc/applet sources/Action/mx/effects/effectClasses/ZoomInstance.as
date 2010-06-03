package mx.effects.effectClasses
{
    import flash.events.*;
    import mx.effects.*;
    import mx.events.*;

    public class ZoomInstance extends TweenEffectInstance
    {
        private var newY:Number;
        public var originY:Number;
        private var origX:Number;
        private var origY:Number;
        public var originX:Number;
        private var origPercentHeight:Number;
        public var zoomWidthFrom:Number;
        public var zoomWidthTo:Number;
        private var newX:Number;
        public var captureRollEvents:Boolean;
        private var origPercentWidth:Number;
        public var zoomHeightFrom:Number;
        private var origScaleX:Number;
        public var zoomHeightTo:Number;
        private var origScaleY:Number;
        private var scaledOriginX:Number;
        private var scaledOriginY:Number;
        private var show:Boolean = true;
        private var _mouseHasMoved:Boolean = false;
        static const VERSION:String = "3.2.0.3958";

        public function ZoomInstance(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function finishEffect() : void
        {
            if (captureRollEvents)
            {
                target.removeEventListener(MouseEvent.ROLL_OVER, mouseEventHandler, false);
                target.removeEventListener(MouseEvent.ROLL_OUT, mouseEventHandler, false);
                target.removeEventListener(MouseEvent.MOUSE_MOVE, mouseEventHandler, false);
            }
            super.finishEffect();
            return;
        }// end function

        private function getScaleFromWidth(param1:Number) : Number
        {
            return param1 / (target.width / Math.abs(target.scaleX));
        }// end function

        override public function initEffect(event:Event) : void
        {
            super.initEffect(event);
            if (event.type == FlexEvent.HIDE || event.type == Event.REMOVED)
            {
                show = false;
            }
            return;
        }// end function

        private function getScaleFromHeight(param1:Number) : Number
        {
            return param1 / (target.height / Math.abs(target.scaleY));
        }// end function

        private function applyPropertyChanges() : void
        {
            var _loc_2:Boolean = false;
            var _loc_3:Boolean = false;
            var _loc_1:* = propertyChanges;
            if (_loc_1)
            {
                _loc_2 = false;
                _loc_3 = false;
                if (_loc_1.end["scaleX"] !== undefined)
                {
                    zoomWidthFrom = isNaN(zoomWidthFrom) ? (target.scaleX) : (zoomWidthFrom);
                    zoomWidthTo = isNaN(zoomWidthTo) ? (_loc_1.end["scaleX"]) : (zoomWidthTo);
                    _loc_3 = true;
                }
                if (_loc_1.end["scaleY"] !== undefined)
                {
                    zoomHeightFrom = isNaN(zoomHeightFrom) ? (target.scaleY) : (zoomHeightFrom);
                    zoomHeightTo = isNaN(zoomHeightTo) ? (_loc_1.end["scaleY"]) : (zoomHeightTo);
                    _loc_3 = true;
                }
                if (_loc_3)
                {
                    return;
                }
                if (_loc_1.end["width"] !== undefined)
                {
                    zoomWidthFrom = isNaN(zoomWidthFrom) ? (getScaleFromWidth(target.width)) : (zoomWidthFrom);
                    zoomWidthTo = isNaN(zoomWidthTo) ? (getScaleFromWidth(_loc_1.end["width"])) : (zoomWidthTo);
                    _loc_2 = true;
                }
                if (_loc_1.end["height"] !== undefined)
                {
                    zoomHeightFrom = isNaN(zoomHeightFrom) ? (getScaleFromHeight(target.height)) : (zoomHeightFrom);
                    zoomHeightTo = isNaN(zoomHeightTo) ? (getScaleFromHeight(_loc_1.end["height"])) : (zoomHeightTo);
                    _loc_2 = true;
                }
                if (_loc_2)
                {
                    return;
                }
                if (_loc_1.end["visible"] !== undefined)
                {
                    show = _loc_1.end["visible"];
                }
            }
            return;
        }// end function

        private function mouseEventHandler(event:MouseEvent) : void
        {
            if (event.type == MouseEvent.MOUSE_MOVE)
            {
                _mouseHasMoved = true;
            }
            else if (event.type == MouseEvent.ROLL_OUT || event.type == MouseEvent.ROLL_OVER)
            {
                if (!_mouseHasMoved)
                {
                    event.stopImmediatePropagation();
                }
                _mouseHasMoved = false;
            }
            return;
        }// end function

        override public function play() : void
        {
            super.play();
            applyPropertyChanges();
            if (isNaN(zoomWidthFrom) && isNaN(zoomWidthTo) && isNaN(zoomHeightFrom) && isNaN(zoomHeightTo))
            {
                if (show)
                {
                    var _loc_1:int = 0;
                    zoomHeightFrom = 0;
                    zoomWidthFrom = _loc_1;
                    zoomWidthTo = target.scaleX;
                    zoomHeightTo = target.scaleY;
                }
                else
                {
                    zoomWidthFrom = target.scaleX;
                    zoomHeightFrom = target.scaleY;
                    var _loc_1:int = 0;
                    zoomHeightTo = 0;
                    zoomWidthTo = _loc_1;
                }
            }
            else
            {
                if (isNaN(zoomWidthFrom) && isNaN(zoomWidthTo))
                {
                    var _loc_1:* = target.scaleX;
                    zoomWidthTo = target.scaleX;
                    zoomWidthFrom = _loc_1;
                }
                else
                {
                    if (isNaN(zoomHeightFrom) && isNaN(zoomHeightTo))
                    {
                        var _loc_1:* = target.scaleY;
                        zoomHeightTo = target.scaleY;
                        zoomHeightFrom = _loc_1;
                    }
                }
                if (isNaN(zoomWidthFrom))
                {
                    zoomWidthFrom = target.scaleX;
                }
                else if (isNaN(zoomWidthTo))
                {
                    zoomWidthTo = zoomWidthFrom == 1 ? (0) : (1);
                }
                if (isNaN(zoomHeightFrom))
                {
                    zoomHeightFrom = target.scaleY;
                }
                else if (isNaN(zoomHeightTo))
                {
                    zoomHeightTo = zoomHeightFrom == 1 ? (0) : (1);
                }
            }
            if (zoomWidthFrom < 0.01)
            {
                zoomWidthFrom = 0.01;
            }
            if (zoomWidthTo < 0.01)
            {
                zoomWidthTo = 0.01;
            }
            if (zoomHeightFrom < 0.01)
            {
                zoomHeightFrom = 0.01;
            }
            if (zoomHeightTo < 0.01)
            {
                zoomHeightTo = 0.01;
            }
            origScaleX = target.scaleX;
            origScaleY = target.scaleY;
            var _loc_1:* = target.x;
            origX = target.x;
            newX = _loc_1;
            var _loc_1:* = target.y;
            origY = target.y;
            newY = _loc_1;
            if (isNaN(originX))
            {
                scaledOriginX = target.width / 2;
            }
            else
            {
                scaledOriginX = originX * origScaleX;
            }
            if (isNaN(originY))
            {
                scaledOriginY = target.height / 2;
            }
            else
            {
                scaledOriginY = originY * origScaleY;
            }
            scaledOriginX = Number(scaledOriginX.toFixed(1));
            scaledOriginY = Number(scaledOriginY.toFixed(1));
            origPercentWidth = target.percentWidth;
            if (!isNaN(origPercentWidth))
            {
                target.width = target.width;
            }
            origPercentHeight = target.percentHeight;
            if (!isNaN(origPercentHeight))
            {
                target.height = target.height;
            }
            tween = createTween(this, [zoomWidthFrom, zoomHeightFrom], [zoomWidthTo, zoomHeightTo], duration);
            if (captureRollEvents)
            {
                target.addEventListener(MouseEvent.ROLL_OVER, mouseEventHandler, false);
                target.addEventListener(MouseEvent.ROLL_OUT, mouseEventHandler, false);
                target.addEventListener(MouseEvent.MOUSE_MOVE, mouseEventHandler, false);
            }
            return;
        }// end function

        override public function onTweenEnd(param1:Object) : void
        {
            var _loc_2:Number = NaN;
            var _loc_3:Number = NaN;
            if (!isNaN(origPercentWidth))
            {
                _loc_2 = target.width;
                target.percentWidth = origPercentWidth;
                if (target.parent && target.parent.autoLayout == false)
                {
                    target._width = _loc_2;
                }
            }
            if (!isNaN(origPercentHeight))
            {
                _loc_3 = target.height;
                target.percentHeight = origPercentHeight;
                if (target.parent && target.parent.autoLayout == false)
                {
                    target._height = _loc_3;
                }
            }
            super.onTweenEnd(param1);
            if (hideOnEffectEnd)
            {
                EffectManager.suspendEventHandling();
                target.scaleX = origScaleX;
                target.scaleY = origScaleY;
                target.move(origX, origY);
                EffectManager.resumeEventHandling();
            }
            return;
        }// end function

        override public function onTweenUpdate(param1:Object) : void
        {
            EffectManager.suspendEventHandling();
            if (Math.abs(newX - target.x) > 0.1)
            {
                origX = origX + (Number(target.x.toFixed(1)) - newX);
            }
            if (Math.abs(newY - target.y) > 0.1)
            {
                origY = origY + (Number(target.y.toFixed(1)) - newY);
            }
            target.scaleX = param1[0];
            target.scaleY = param1[1];
            var _loc_2:* = param1[0] / origScaleX;
            var _loc_3:* = param1[1] / origScaleY;
            var _loc_4:* = scaledOriginX * _loc_2;
            var _loc_5:* = scaledOriginY * _loc_3;
            newX = scaledOriginX - _loc_4 + origX;
            newY = scaledOriginY - _loc_5 + origY;
            newX = Number(newX.toFixed(1));
            newY = Number(newY.toFixed(1));
            target.move(newX, newY);
            if (tween)
            {
                tween.needToLayout = true;
            }
            else
            {
                needToLayout = true;
            }
            EffectManager.resumeEventHandling();
            return;
        }// end function

    }
}
