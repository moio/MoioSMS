package mx.effects
{
    import flash.events.*;
    import flash.utils.*;
    import mx.core.*;
    import mx.effects.effectClasses.*;
    import mx.events.*;

    public class EffectInstance extends EventDispatcher implements IEffectInstance
    {
        private var _hideFocusRing:Boolean;
        private var delayStartTime:Number = 0;
        var stopRepeat:Boolean = false;
        private var playCount:int = 0;
        private var _repeatCount:int = 0;
        private var _suspendBackgroundProcessing:Boolean = false;
        var delayTimer:Timer;
        private var _triggerEvent:Event;
        private var _effectTargetHost:IEffectTargetHost;
        var parentCompositeEffectInstance:EffectInstance;
        var durationExplicitlySet:Boolean = false;
        private var _effect:IEffect;
        private var _target:Object;
        var hideOnEffectEnd:Boolean = false;
        private var _startDelay:int = 0;
        private var delayElapsedTime:Number = 0;
        private var _repeatDelay:int = 0;
        private var _propertyChanges:PropertyChanges;
        private var _duration:Number = 500;
        private var _playReversed:Boolean;
        static const VERSION:String = "3.2.0.3958";

        public function EffectInstance(param1:Object)
        {
            this.target = param1;
            return;
        }// end function

        public function get playheadTime() : Number
        {
            return Math.max(playCount--, 0) * duration + Math.max(playCount - 2, 0) * repeatDelay + (playReversed ? (0) : (startDelay));
        }// end function

        public function get hideFocusRing() : Boolean
        {
            return _hideFocusRing;
        }// end function

        public function stop() : void
        {
            if (delayTimer)
            {
                delayTimer.reset();
            }
            stopRepeat = true;
            finishEffect();
            return;
        }// end function

        public function finishEffect() : void
        {
            playCount = 0;
            dispatchEvent(new EffectEvent(EffectEvent.EFFECT_END, false, false, this));
            if (target)
            {
                target.dispatchEvent(new EffectEvent(EffectEvent.EFFECT_END, false, false, this));
            }
            if (target is UIComponent)
            {
                UIComponent(target).effectFinished(this);
            }
            EffectManager.effectFinished(this);
            return;
        }// end function

        public function set hideFocusRing(param1:Boolean) : void
        {
            _hideFocusRing = param1;
            return;
        }// end function

        public function finishRepeat() : void
        {
            if (!stopRepeat && playCount != 0 && playCount < repeatCount || repeatCount == 0)
            {
                if (repeatDelay > 0)
                {
                    delayTimer = new Timer(repeatDelay, 1);
                    delayStartTime = getTimer();
                    delayTimer.addEventListener(TimerEvent.TIMER, delayTimerHandler);
                    delayTimer.start();
                }
                else
                {
                    play();
                }
            }
            else
            {
                finishEffect();
            }
            return;
        }// end function

        function get playReversed() : Boolean
        {
            return _playReversed;
        }// end function

        public function set effect(param1:IEffect) : void
        {
            _effect = param1;
            return;
        }// end function

        public function get className() : String
        {
            var _loc_1:* = getQualifiedClassName(this);
            var _loc_2:* = _loc_1.indexOf("::");
            if (_loc_2 != -1)
            {
                _loc_1 = _loc_1.substr(_loc_2 + 2);
            }
            return _loc_1;
        }// end function

        public function set duration(param1:Number) : void
        {
            durationExplicitlySet = true;
            _duration = param1;
            return;
        }// end function

        function set playReversed(param1:Boolean) : void
        {
            _playReversed = param1;
            return;
        }// end function

        public function resume() : void
        {
            if (delayTimer && !delayTimer.running && !isNaN(delayElapsedTime))
            {
                delayTimer.delay = !playReversed ? (delayTimer.delay - delayElapsedTime) : (delayElapsedTime);
                delayTimer.start();
            }
            return;
        }// end function

        public function get propertyChanges() : PropertyChanges
        {
            return _propertyChanges;
        }// end function

        public function set target(param1:Object) : void
        {
            _target = param1;
            return;
        }// end function

        public function get repeatCount() : int
        {
            return _repeatCount;
        }// end function

        function playWithNoDuration() : void
        {
            duration = 0;
            repeatCount = 1;
            repeatDelay = 0;
            startDelay = 0;
            startEffect();
            return;
        }// end function

        public function get startDelay() : int
        {
            return _startDelay;
        }// end function

        function get actualDuration() : Number
        {
            var _loc_1:* = NaN;
            if (repeatCount > 0)
            {
                _loc_1 = duration * repeatCount + (repeatDelay * repeatCount)-- + startDelay;
            }
            return _loc_1;
        }// end function

        public function play() : void
        {
            playCount++;
            dispatchEvent(new EffectEvent(EffectEvent.EFFECT_START, false, false, this));
            if (target)
            {
                target.dispatchEvent(new EffectEvent(EffectEvent.EFFECT_START, false, false, this));
            }
            return;
        }// end function

        public function get suspendBackgroundProcessing() : Boolean
        {
            return _suspendBackgroundProcessing;
        }// end function

        public function get effectTargetHost() : IEffectTargetHost
        {
            return _effectTargetHost;
        }// end function

        public function set repeatDelay(param1:int) : void
        {
            _repeatDelay = param1;
            return;
        }// end function

        public function set propertyChanges(param1:PropertyChanges) : void
        {
            _propertyChanges = param1;
            return;
        }// end function

        function eventHandler(event:Event) : void
        {
            if (event.type == FlexEvent.SHOW && hideOnEffectEnd == true)
            {
                hideOnEffectEnd = false;
                event.target.removeEventListener(FlexEvent.SHOW, eventHandler);
            }
            return;
        }// end function

        public function set repeatCount(param1:int) : void
        {
            _repeatCount = param1;
            return;
        }// end function

        private function delayTimerHandler(event:TimerEvent) : void
        {
            delayTimer.reset();
            delayStartTime = NaN;
            delayElapsedTime = NaN;
            play();
            return;
        }// end function

        public function set suspendBackgroundProcessing(param1:Boolean) : void
        {
            _suspendBackgroundProcessing = param1;
            return;
        }// end function

        public function set triggerEvent(event:Event) : void
        {
            _triggerEvent = event;
            return;
        }// end function

        public function set startDelay(param1:int) : void
        {
            _startDelay = param1;
            return;
        }// end function

        public function get effect() : IEffect
        {
            return _effect;
        }// end function

        public function set effectTargetHost(param1:IEffectTargetHost) : void
        {
            _effectTargetHost = param1;
            return;
        }// end function

        public function get target() : Object
        {
            return _target;
        }// end function

        public function startEffect() : void
        {
            EffectManager.effectStarted(this);
            if (target is UIComponent)
            {
                UIComponent(target).effectStarted(this);
            }
            if (startDelay > 0 && !playReversed)
            {
                delayTimer = new Timer(startDelay, 1);
                delayStartTime = getTimer();
                delayTimer.addEventListener(TimerEvent.TIMER, delayTimerHandler);
                delayTimer.start();
            }
            else
            {
                play();
            }
            return;
        }// end function

        public function get repeatDelay() : int
        {
            return _repeatDelay;
        }// end function

        public function get duration() : Number
        {
            if (!durationExplicitlySet && parentCompositeEffectInstance)
            {
                return parentCompositeEffectInstance.duration;
            }
            return _duration;
        }// end function

        public function initEffect(event:Event) : void
        {
            triggerEvent = event;
            switch(event.type)
            {
                case "resizeStart":
                case "resizeEnd":
                {
                    if (!durationExplicitlySet)
                    {
                        duration = 250;
                    }
                    break;
                }
                case FlexEvent.HIDE:
                {
                    target.setVisible(true, true);
                    hideOnEffectEnd = true;
                    target.addEventListener(FlexEvent.SHOW, eventHandler);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function get triggerEvent() : Event
        {
            return _triggerEvent;
        }// end function

        public function end() : void
        {
            if (delayTimer)
            {
                delayTimer.reset();
            }
            stopRepeat = true;
            finishEffect();
            return;
        }// end function

        public function reverse() : void
        {
            if (repeatCount > 0)
            {
                playCount = repeatCount - playCount + 1;
            }
            return;
        }// end function

        public function pause() : void
        {
            if (delayTimer && delayTimer.running && !isNaN(delayStartTime))
            {
                delayTimer.stop();
                delayElapsedTime = getTimer() - delayStartTime;
            }
            return;
        }// end function

    }
}
