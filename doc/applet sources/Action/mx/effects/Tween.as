package mx.effects
{
    import flash.events.*;
    import flash.utils.*;
    import mx.core.*;
    import mx.events.*;

    public class Tween extends EventDispatcher
    {
        private var started:Boolean = false;
        private var previousUpdateTime:Number;
        public var duration:Number = 3000;
        private var id:int;
        private var arrayMode:Boolean;
        private var _isPlaying:Boolean = true;
        private var startValue:Object;
        public var listener:Object;
        private var userEquation:Function;
        var needToLayout:Boolean = false;
        private var updateFunction:Function;
        private var _doSeek:Boolean = false;
        var startTime:Number;
        private var endFunction:Function;
        private var endValue:Object;
        private var _doReverse:Boolean = false;
        private var _playheadTime:Number = 0;
        private var _invertValues:Boolean = false;
        private var maxDelay:Number = 87.5;
        private static var timer:Timer = null;
        private static var interval:Number = 10;
        static var activeTweens:Array = [];
        static var intervalTime:Number = 1.#QNAN;
        static const VERSION:String = "3.2.0.3958";

        public function Tween(param1:Object, param2:Object, param3:Object, param4:Number = -1, param5:Number = -1, param6:Function = null, param7:Function = null)
        {
            userEquation = defaultEasingFunction;
            if (!param1)
            {
                return;
            }
            if (param2 is Array)
            {
                arrayMode = true;
            }
            this.listener = param1;
            this.startValue = param2;
            this.endValue = param3;
            if (!isNaN(param4) && param4 != -1)
            {
                this.duration = param4;
            }
            if (!isNaN(param5) && param5 != -1)
            {
                maxDelay = 1000 / param5;
            }
            this.updateFunction = param6;
            this.endFunction = param7;
            if (param4 == 0)
            {
                id = -1;
                endTween();
            }
            else
            {
                Tween.addTween(this);
            }
            return;
        }// end function

        function get playheadTime() : Number
        {
            return _playheadTime;
        }// end function

        public function stop() : void
        {
            if (id >= 0)
            {
                Tween.removeTweenAt(id);
            }
            return;
        }// end function

        function get playReversed() : Boolean
        {
            return _invertValues;
        }// end function

        function set playReversed(param1:Boolean) : void
        {
            _invertValues = param1;
            return;
        }// end function

        public function resume() : void
        {
            _isPlaying = true;
            startTime = intervalTime - _playheadTime;
            if (_doReverse)
            {
                reverse();
                _doReverse = false;
            }
            return;
        }// end function

        public function setTweenHandlers(param1:Function, param2:Function) : void
        {
            this.updateFunction = param1;
            this.endFunction = param2;
            return;
        }// end function

        private function defaultEasingFunction(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            return param3 / 2 * (Math.sin(Math.PI * (param1 / param4 - 0.5)) + 1) + param2;
        }// end function

        public function set easingFunction(param1:Function) : void
        {
            userEquation = param1;
            return;
        }// end function

        public function endTween() : void
        {
            var _loc_1:* = new TweenEvent(TweenEvent.TWEEN_END);
            var _loc_2:* = getCurrentValue(duration);
            _loc_1.value = _loc_2;
            dispatchEvent(_loc_1);
            if (endFunction != null)
            {
                endFunction(_loc_2);
            }
            else
            {
                listener.onTweenEnd(_loc_2);
            }
            if (id >= 0)
            {
                Tween.removeTweenAt(id);
            }
            return;
        }// end function

        public function reverse() : void
        {
            if (_isPlaying)
            {
                _doReverse = false;
                seek(duration - _playheadTime);
                _invertValues = !_invertValues;
            }
            else
            {
                _doReverse = !_doReverse;
            }
            return;
        }// end function

        function getCurrentValue(param1:Number) : Object
        {
            var _loc_2:Array = null;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            if (duration == 0)
            {
                return endValue;
            }
            if (_invertValues)
            {
                param1 = duration - param1;
            }
            if (arrayMode)
            {
                _loc_2 = [];
                _loc_3 = startValue.length;
                _loc_4 = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    _loc_2[_loc_4] = userEquation(param1, startValue[_loc_4], endValue[_loc_4] - startValue[_loc_4], duration);
                    _loc_4++;
                }
                return _loc_2;
            }
            else
            {
                return userEquation(param1, startValue, Number(endValue) - Number(startValue), duration);
            }
        }// end function

        function doInterval() : Boolean
        {
            var _loc_2:Number = NaN;
            var _loc_3:Object = null;
            var _loc_4:TweenEvent = null;
            var _loc_5:TweenEvent = null;
            var _loc_1:Boolean = false;
            previousUpdateTime = intervalTime;
            if (_isPlaying || _doSeek)
            {
                _loc_2 = intervalTime - startTime;
                _playheadTime = _loc_2;
                _loc_3 = getCurrentValue(_loc_2);
                if (_loc_2 >= duration && !_doSeek)
                {
                    endTween();
                    _loc_1 = true;
                }
                else
                {
                    if (!started)
                    {
                        _loc_5 = new TweenEvent(TweenEvent.TWEEN_START);
                        dispatchEvent(_loc_5);
                        started = true;
                    }
                    _loc_4 = new TweenEvent(TweenEvent.TWEEN_UPDATE);
                    _loc_4.value = _loc_3;
                    dispatchEvent(_loc_4);
                    if (updateFunction != null)
                    {
                        updateFunction(_loc_3);
                    }
                    else
                    {
                        listener.onTweenUpdate(_loc_3);
                    }
                }
                _doSeek = false;
            }
            return _loc_1;
        }// end function

        public function pause() : void
        {
            _isPlaying = false;
            return;
        }// end function

        public function seek(param1:Number) : void
        {
            var _loc_2:* = intervalTime;
            previousUpdateTime = _loc_2;
            startTime = _loc_2 - param1;
            _doSeek = true;
            return;
        }// end function

        static function removeTween(param1:Tween) : void
        {
            removeTweenAt(param1.id);
            return;
        }// end function

        private static function addTween(param1:Tween) : void
        {
            param1.id = activeTweens.length;
            activeTweens.push(param1);
            if (!timer)
            {
                timer = new Timer(interval);
                timer.addEventListener(TimerEvent.TIMER, timerHandler);
                timer.start();
            }
            else
            {
                timer.start();
            }
            if (isNaN(intervalTime))
            {
                intervalTime = getTimer();
            }
            var _loc_2:* = intervalTime;
            param1.previousUpdateTime = intervalTime;
            param1.startTime = _loc_2;
            return;
        }// end function

        private static function timerHandler(event:TimerEvent) : void
        {
            var _loc_6:Tween = null;
            var _loc_2:Boolean = false;
            var _loc_3:* = intervalTime;
            intervalTime = getTimer();
            var _loc_4:* = activeTweens.length;
            var _loc_5:* = activeTweens.length;
            while (_loc_5-- >= 0)
            {
                
                _loc_6 = this.this(activeTweens[_loc_5]);
                if (_loc_6)
                {
                    _loc_6.needToLayout = false;
                    _loc_6.doInterval();
                    if (_loc_6.needToLayout)
                    {
                        _loc_2 = true;
                    }
                }
            }
            if (_loc_2)
            {
                UIComponentGlobals.layoutManager.validateNow();
            }
            event.updateAfterEvent();
            return;
        }// end function

        private static function removeTweenAt(param1:int) : void
        {
            var _loc_4:Tween = null;
            if (param1 >= activeTweens.length || param1 < 0)
            {
                return;
            }
            activeTweens.splice(param1, 1);
            var _loc_2:* = activeTweens.length;
            var _loc_3:* = param1;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = this.this(activeTweens[_loc_3]);
                var _loc_5:* = _loc_4;
                _loc_5.id = _loc_4.id--;
                _loc_3++;
            }
            if (_loc_2 == 0)
            {
                intervalTime = NaN;
                timer.reset();
            }
            return;
        }// end function

    }
}
