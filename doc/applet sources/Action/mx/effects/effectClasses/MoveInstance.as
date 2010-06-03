package mx.effects.effectClasses
{
    import flash.events.*;
    import mx.core.*;
    import mx.effects.*;
    import mx.events.*;
    import mx.styles.*;

    public class MoveInstance extends TweenEffectInstance
    {
        public var xFrom:Number;
        public var yFrom:Number;
        private var left:Object;
        private var forceClipping:Boolean = false;
        public var xTo:Number;
        private var top:Object;
        private var horizontalCenter:Object;
        public var yTo:Number;
        private var oldWidth:Number;
        private var right:Object;
        private var bottom:Object;
        private var oldHeight:Number;
        public var xBy:Number;
        public var yBy:Number;
        private var checkClipping:Boolean = true;
        private var verticalCenter:Object;
        static const VERSION:String = "3.2.0.3958";

        public function MoveInstance(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function initEffect(event:Event) : void
        {
            super.initEffect(event);
            if (event is MoveEvent && event.type == MoveEvent.MOVE)
            {
                if (isNaN(xFrom) && isNaN(xTo) && isNaN(xBy) && isNaN(yFrom) && isNaN(yTo) && isNaN(yBy))
                {
                    xFrom = MoveEvent(event).oldX;
                    xTo = target.x;
                    yFrom = MoveEvent(event).oldY;
                    yTo = target.y;
                }
            }
            return;
        }// end function

        override public function play() : void
        {
            var _loc_2:EdgeMetrics = null;
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_6:Number = NaN;
            var _loc_7:Number = NaN;
            var _loc_8:Number = NaN;
            super.play();
            var _loc_9:* = EffectManager;
            _loc_9.mx_internal::startBitmapEffect(IUIComponent(target));
            if (isNaN(xFrom))
            {
                if (!isNaN(xTo))
                {
                }
                xFrom = !isNaN(xBy) ? (xTo - xBy) : (target.x);
            }
            if (isNaN(xTo))
            {
                if (isNaN(xBy) && propertyChanges && propertyChanges.end["x"] !== undefined)
                {
                    xTo = propertyChanges.end["x"];
                }
                else
                {
                    xTo = !isNaN(xBy) ? (xFrom + xBy) : (target.x);
                }
            }
            if (isNaN(yFrom))
            {
                if (!isNaN(yTo))
                {
                }
                yFrom = !isNaN(yBy) ? (yTo - yBy) : (target.y);
            }
            if (isNaN(yTo))
            {
                if (isNaN(yBy) && propertyChanges && propertyChanges.end["y"] !== undefined)
                {
                    yTo = propertyChanges.end["y"];
                }
                else
                {
                    yTo = !isNaN(yBy) ? (yFrom + yBy) : (target.y);
                }
            }
            tween = createTween(this, [xFrom, yFrom], [xTo, yTo], duration);
            var _loc_1:* = target.parent as Container;
            if (_loc_1)
            {
                _loc_2 = _loc_1.viewMetrics;
                _loc_3 = _loc_2.left;
                _loc_4 = _loc_1.width - _loc_2.right;
                _loc_5 = _loc_2.top;
                _loc_6 = _loc_1.height - _loc_2.bottom;
                if (xFrom < _loc_3 || xTo < _loc_3 || xFrom + target.width > _loc_4 || xTo + target.width > _loc_4 || yFrom < _loc_5 || yTo < _loc_5 || yFrom + target.height > _loc_6 || yTo + target.height > _loc_6)
                {
                    forceClipping = true;
                    mx_internal::forceClipping = true;
                }
            }
            .mx_internal::applyTweenStartValues();
            if (target is IStyleClient)
            {
                left = target.getStyle("left");
                if (left != undefined)
                {
                    target.setStyle("left", undefined);
                }
                right = target.getStyle("right");
                if (right != undefined)
                {
                    target.setStyle("right", undefined);
                }
                top = target.getStyle("top");
                if (top != undefined)
                {
                    target.setStyle("top", undefined);
                }
                bottom = target.getStyle("bottom");
                if (bottom != undefined)
                {
                    target.setStyle("bottom", undefined);
                }
                horizontalCenter = target.getStyle("horizontalCenter");
                if (horizontalCenter != undefined)
                {
                    target.setStyle("horizontalCenter", undefined);
                }
                verticalCenter = target.getStyle("verticalCenter");
                if (verticalCenter != undefined)
                {
                    target.setStyle("verticalCenter", undefined);
                }
                if (left != undefined && right != undefined)
                {
                    _loc_7 = target.width;
                    oldWidth = target.explicitWidth;
                    target.width = _loc_7;
                }
                if (top != undefined && bottom != undefined)
                {
                    _loc_8 = target.height;
                    oldHeight = target.explicitHeight;
                    target.height = _loc_8;
                }
            }
            return;
        }// end function

        override public function onTweenUpdate(param1:Object) : void
        {
            var _loc_2:Container = null;
            var _loc_3:EdgeMetrics = null;
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_6:Number = NaN;
            var _loc_7:Number = NaN;
            EffectManager.suspendEventHandling();
            if (!forceClipping && checkClipping)
            {
                _loc_2 = target.parent as Container;
                if (_loc_2)
                {
                    _loc_3 = _loc_2.viewMetrics;
                    _loc_4 = _loc_3.left;
                    _loc_5 = _loc_2.width - _loc_3.right;
                    _loc_6 = _loc_3.top;
                    _loc_7 = _loc_2.height - _loc_3.bottom;
                    if (param1[0] < _loc_4 || param1[0] + target.width > _loc_5 || param1[1] < _loc_6 || param1[1] + target.height > _loc_7)
                    {
                        forceClipping = true;
                        mx_internal::forceClipping = true;
                    }
                }
            }
            target.move(param1[0], param1[1]);
            EffectManager.resumeEventHandling();
            return;
        }// end function

        override public function onTweenEnd(param1:Object) : void
        {
            var _loc_2:Container = null;
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::endBitmapEffect(IUIComponent(target));
            if (left != undefined)
            {
                target.setStyle("left", left);
            }
            if (right != undefined)
            {
                target.setStyle("right", right);
            }
            if (top != undefined)
            {
                target.setStyle("top", top);
            }
            if (bottom != undefined)
            {
                target.setStyle("bottom", bottom);
            }
            if (horizontalCenter != undefined)
            {
                target.setStyle("horizontalCenter", horizontalCenter);
            }
            if (verticalCenter != undefined)
            {
                target.setStyle("verticalCenter", verticalCenter);
            }
            if (left != undefined && right != undefined)
            {
                target.explicitWidth = oldWidth;
            }
            if (top != undefined && bottom != undefined)
            {
                target.explicitHeight = oldHeight;
            }
            if (forceClipping)
            {
                _loc_2 = target.parent as Container;
                if (_loc_2)
                {
                    forceClipping = false;
                    mx_internal::forceClipping = false;
                }
            }
            checkClipping = false;
            super.onTweenEnd(param1);
            return;
        }// end function

    }
}
