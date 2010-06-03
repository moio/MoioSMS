package mx.effects
{
    import flash.events.*;
    import flash.utils.*;
    import mx.core.*;
    import mx.effects.effectClasses.*;
    import mx.events.*;
    import mx.managers.*;

    public class Effect extends EventDispatcher implements IEffect
    {
        private var _perElementOffset:Number = 0;
        private var _hideFocusRing:Boolean = false;
        private var _customFilter:EffectTargetFilter;
        public var repeatCount:int = 1;
        public var suspendBackgroundProcessing:Boolean = false;
        public var startDelay:int = 0;
        private var _relevantProperties:Array;
        private var _callValidateNow:Boolean = false;
        var applyActualDimensions:Boolean = true;
        private var _filter:String;
        private var _triggerEvent:Event;
        private var _effectTargetHost:IEffectTargetHost;
        var durationExplicitlySet:Boolean = false;
        public var repeatDelay:int = 0;
        private var _targets:Array;
        var propertyChangesArray:Array;
        var filterObject:EffectTargetFilter;
        protected var endValuesCaptured:Boolean = false;
        public var instanceClass:Class;
        private var _duration:Number = 500;
        private var isPaused:Boolean = false;
        private var _relevantStyles:Array;
        private var _instances:Array;
        static const VERSION:String = "3.2.0.3958";

        public function Effect(param1:Object = null)
        {
            _instances = [];
            instanceClass = IEffectInstance;
            _relevantStyles = [];
            _targets = [];
            this.target = param1;
            return;
        }// end function

        public function get targets() : Array
        {
            return _targets;
        }// end function

        public function set targets(param1:Array) : void
        {
            var _loc_2:* = param1.length;
            while (_loc_3-- > 0)
            {
                
                if (param1[_loc_2--] == null)
                {
                    param1.splice(_loc_3, 1);
                }
            }
            _targets = param1;
            return;
        }// end function

        public function set hideFocusRing(param1:Boolean) : void
        {
            _hideFocusRing = param1;
            return;
        }// end function

        public function get hideFocusRing() : Boolean
        {
            return _hideFocusRing;
        }// end function

        public function stop() : void
        {
            var _loc_3:IEffectInstance = null;
            var _loc_1:* = _instances.length;
            var _loc_2:* = _loc_1;
            while (_loc_2-- >= 0)
            {
                
                _loc_3 = IEffectInstance(_instances[_loc_2]);
                if (_loc_3)
                {
                    _loc_3.stop();
                }
            }
            return;
        }// end function

        public function captureStartValues() : void
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            if (targets.length > 0)
            {
                propertyChangesArray = [];
                _callValidateNow = true;
                _loc_1 = targets.length;
                _loc_2 = 0;
                while (_loc_2 < _loc_1)
                {
                    
                    propertyChangesArray.push(new PropertyChanges(targets[_loc_2]));
                    _loc_2++;
                }
                propertyChangesArray = captureValues(propertyChangesArray, true);
            }
            endValuesCaptured = false;
            return;
        }// end function

        function captureValues(param1:Array, param2:Boolean) : Array
        {
            var _loc_4:Object = null;
            var _loc_5:Object = null;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            var _loc_3:* = !filterObject ? (relevantProperties) : (mergeArrays(relevantProperties, filterObject.filterProperties));
            if (_loc_3 && _loc_3.length > 0)
            {
                _loc_6 = param1.length;
                _loc_7 = 0;
                while (_loc_7 < _loc_6)
                {
                    
                    _loc_5 = param1[_loc_7].target;
                    _loc_4 = param2 ? (param1[_loc_7].start) : (param1[_loc_7].end);
                    _loc_8 = _loc_3.length;
                    _loc_9 = 0;
                    while (_loc_9 < _loc_8)
                    {
                        
                        _loc_4[_loc_3[_loc_9]] = getValueFromTarget(_loc_5, _loc_3[_loc_9]);
                        _loc_9++;
                    }
                    _loc_7++;
                }
            }
            var _loc_10:* = !filterObject ? (relevantStyles) : (mergeArrays(relevantStyles, filterObject.filterStyles));
            if (!filterObject ? (relevantStyles) : (mergeArrays(relevantStyles, filterObject.filterStyles)) && _loc_10.length > 0)
            {
                _loc_6 = param1.length;
                _loc_7 = 0;
                while (_loc_7 < _loc_6)
                {
                    
                    _loc_5 = param1[_loc_7].target;
                    _loc_4 = param2 ? (param1[_loc_7].start) : (param1[_loc_7].end);
                    _loc_8 = _loc_10.length;
                    _loc_9 = 0;
                    while (_loc_9 < _loc_8)
                    {
                        
                        _loc_4[_loc_10[_loc_9]] = _loc_5.getStyle(_loc_10[_loc_9]);
                        _loc_9++;
                    }
                    _loc_7++;
                }
            }
            return param1;
        }// end function

        protected function getValueFromTarget(param1:Object, param2:String)
        {
            if (param2 in param1)
            {
                return param1[param2];
            }
            return undefined;
        }// end function

        public function set target(param1:Object) : void
        {
            _targets.splice(0);
            if (param1)
            {
                _targets[0] = param1;
            }
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

        public function set perElementOffset(param1:Number) : void
        {
            _perElementOffset = param1;
            return;
        }// end function

        public function resume() : void
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            if (isPlaying && isPaused)
            {
                isPaused = false;
                _loc_1 = _instances.length;
                _loc_2 = 0;
                while (_loc_2 < _loc_1)
                {
                    
                    IEffectInstance(_instances[_loc_2]).resume();
                    _loc_2++;
                }
            }
            return;
        }// end function

        public function set duration(param1:Number) : void
        {
            durationExplicitlySet = true;
            _duration = param1;
            return;
        }// end function

        public function play(param1:Array = null, param2:Boolean = false) : Array
        {
            var _loc_6:IEffectInstance = null;
            if (param1 == null && propertyChangesArray != null)
            {
                if (_callValidateNow)
                {
                    LayoutManager.getInstance().validateNow();
                }
                if (!endValuesCaptured)
                {
                    propertyChangesArray = captureValues(propertyChangesArray, false);
                }
                propertyChangesArray = stripUnchangedValues(propertyChangesArray);
                applyStartValues(propertyChangesArray, this.targets);
            }
            var _loc_3:* = createInstances(param1);
            var _loc_4:* = _loc_3.length;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_6 = IEffectInstance(_loc_3[_loc_5]);
                Object(_loc_6).playReversed = param2;
                _loc_6.startEffect();
                _loc_5++;
            }
            return _loc_3;
        }// end function

        public function captureEndValues() : void
        {
            propertyChangesArray = captureValues(propertyChangesArray, false);
            endValuesCaptured = true;
            return;
        }// end function

        protected function filterInstance(param1:Array, param2:Object) : Boolean
        {
            if (filterObject)
            {
                return filterObject.filterInstance(param1, effectTargetHost, param2);
            }
            return true;
        }// end function

        public function get customFilter() : EffectTargetFilter
        {
            return _customFilter;
        }// end function

        public function get effectTargetHost() : IEffectTargetHost
        {
            return _effectTargetHost;
        }// end function

        public function set relevantProperties(param1:Array) : void
        {
            _relevantProperties = param1;
            return;
        }// end function

        public function captureMoreStartValues(param1:Array) : void
        {
            var _loc_2:Array = null;
            var _loc_3:int = 0;
            if (param1.length > 0)
            {
                _loc_2 = [];
                _loc_3 = 0;
                while (_loc_3 < param1.length)
                {
                    
                    _loc_2.push(new PropertyChanges(param1[_loc_3]));
                    _loc_3++;
                }
                _loc_2 = captureValues(_loc_2, true);
                propertyChangesArray = propertyChangesArray.concat(_loc_2);
            }
            return;
        }// end function

        public function deleteInstance(param1:IEffectInstance) : void
        {
            EventDispatcher(param1).removeEventListener(EffectEvent.EFFECT_START, effectStartHandler);
            EventDispatcher(param1).removeEventListener(EffectEvent.EFFECT_END, effectEndHandler);
            var _loc_2:* = _instances.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (_instances[_loc_3] === param1)
                {
                    _instances.splice(_loc_3, 1);
                }
                _loc_3++;
            }
            return;
        }// end function

        public function get filter() : String
        {
            return _filter;
        }// end function

        public function set triggerEvent(event:Event) : void
        {
            _triggerEvent = event;
            return;
        }// end function

        public function get target() : Object
        {
            if (_targets.length > 0)
            {
                return _targets[0];
            }
            return null;
        }// end function

        public function get duration() : Number
        {
            return _duration;
        }// end function

        public function set customFilter(param1:EffectTargetFilter) : void
        {
            _customFilter = param1;
            filterObject = param1;
            return;
        }// end function

        public function get perElementOffset() : Number
        {
            return _perElementOffset;
        }// end function

        public function set effectTargetHost(param1:IEffectTargetHost) : void
        {
            _effectTargetHost = param1;
            return;
        }// end function

        public function get isPlaying() : Boolean
        {
            if (_instances)
            {
            }
            return _instances.length > 0;
        }// end function

        protected function effectEndHandler(event:EffectEvent) : void
        {
            var _loc_2:* = IEffectInstance(event.effectInstance);
            deleteInstance(_loc_2);
            dispatchEvent(event);
            return;
        }// end function

        public function get relevantProperties() : Array
        {
            if (_relevantProperties)
            {
                return _relevantProperties;
            }
            return getAffectedProperties();
        }// end function

        public function createInstance(param1:Object = null) : IEffectInstance
        {
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            if (!param1)
            {
                param1 = this.target;
            }
            var _loc_2:IEffectInstance = null;
            var _loc_3:PropertyChanges = null;
            var _loc_4:Boolean = true;
            var _loc_5:Boolean = false;
            if (propertyChangesArray)
            {
                _loc_5 = true;
                _loc_4 = filterInstance(propertyChangesArray, param1);
            }
            if (_loc_4)
            {
                _loc_2 = IEffectInstance(new instanceClass(param1));
                initInstance(_loc_2);
                if (_loc_5)
                {
                    _loc_6 = propertyChangesArray.length;
                    _loc_7 = 0;
                    while (_loc_7 < _loc_6)
                    {
                        
                        if (propertyChangesArray[_loc_7].target == param1)
                        {
                            _loc_2.propertyChanges = propertyChangesArray[_loc_7];
                        }
                        _loc_7++;
                    }
                }
                EventDispatcher(_loc_2).addEventListener(EffectEvent.EFFECT_START, effectStartHandler);
                EventDispatcher(_loc_2).addEventListener(EffectEvent.EFFECT_END, effectEndHandler);
                _instances.push(_loc_2);
                if (triggerEvent)
                {
                    _loc_2.initEffect(triggerEvent);
                }
            }
            return _loc_2;
        }// end function

        protected function effectStartHandler(event:EffectEvent) : void
        {
            dispatchEvent(event);
            return;
        }// end function

        public function getAffectedProperties() : Array
        {
            return [];
        }// end function

        public function set relevantStyles(param1:Array) : void
        {
            _relevantStyles = param1;
            return;
        }// end function

        public function get triggerEvent() : Event
        {
            return _triggerEvent;
        }// end function

        protected function applyValueToTarget(param1:Object, param2:String, param3, param4:Object) : void
        {
            var target:* = param1;
            var property:* = param2;
            var value:* = param3;
            var props:* = param4;
            if (property in target)
            {
                try
                {
                    if (applyActualDimensions && target is IFlexDisplayObject && property == "height")
                    {
                        target.setActualSize(target.width, value);
                    }
                    else if (applyActualDimensions && target is IFlexDisplayObject && property == "width")
                    {
                        target.setActualSize(value, target.height);
                    }
                    else
                    {
                        target[property] = value;
                    }
                }
                catch (e:Error)
                {
                }
            }
            return;
        }// end function

        protected function initInstance(param1:IEffectInstance) : void
        {
            param1.duration = duration;
            Object(param1).durationExplicitlySet = durationExplicitlySet;
            param1.effect = this;
            param1.effectTargetHost = effectTargetHost;
            param1.hideFocusRing = hideFocusRing;
            param1.repeatCount = repeatCount;
            param1.repeatDelay = repeatDelay;
            param1.startDelay = startDelay;
            param1.suspendBackgroundProcessing = suspendBackgroundProcessing;
            return;
        }// end function

        function applyStartValues(param1:Array, param2:Array) : void
        {
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:Object = null;
            var _loc_9:Boolean = false;
            var _loc_3:* = relevantProperties;
            var _loc_4:* = param1.length;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_8 = param1[_loc_5].target;
                _loc_9 = false;
                _loc_6 = param2.length;
                _loc_7 = 0;
                while (_loc_7 < _loc_6)
                {
                    
                    if (param2[_loc_7] == _loc_8)
                    {
                        _loc_9 = filterInstance(param1, _loc_8);
                        break;
                    }
                    _loc_7++;
                }
                if (_loc_9)
                {
                    _loc_6 = _loc_3.length;
                    _loc_7 = 0;
                    while (_loc_7 < _loc_6)
                    {
                        
                        if (_loc_3[_loc_7] in param1[_loc_5].start && _loc_3[_loc_7] in _loc_8)
                        {
                            applyValueToTarget(_loc_8, _loc_3[_loc_7], param1[_loc_5].start[_loc_3[_loc_7]], param1[_loc_5].start);
                        }
                        _loc_7++;
                    }
                    _loc_6 = relevantStyles.length;
                    _loc_7 = 0;
                    while (_loc_7 < _loc_6)
                    {
                        
                        if (relevantStyles[_loc_7] in param1[_loc_5].start)
                        {
                            _loc_8.setStyle(relevantStyles[_loc_7], param1[_loc_5].start[relevantStyles[_loc_7]]);
                        }
                        _loc_7++;
                    }
                }
                _loc_5++;
            }
            return;
        }// end function

        public function end(param1:IEffectInstance = null) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            var _loc_4:IEffectInstance = null;
            if (param1)
            {
                param1.end();
            }
            else
            {
                _loc_2 = _instances.length;
                _loc_3 = _loc_2;
                while (_loc_3-- >= 0)
                {
                    
                    _loc_4 = IEffectInstance(_instances[_loc_3]);
                    if (_loc_4)
                    {
                        _loc_4.end();
                    }
                }
            }
            return;
        }// end function

        public function get relevantStyles() : Array
        {
            return _relevantStyles;
        }// end function

        public function createInstances(param1:Array = null) : Array
        {
            var _loc_6:IEffectInstance = null;
            if (!param1)
            {
                param1 = this.targets;
            }
            var _loc_2:Array = [];
            var _loc_3:* = param1.length;
            var _loc_4:Number = 0;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_6 = createInstance(param1[_loc_5]);
                if (_loc_6)
                {
                    _loc_6.startDelay = _loc_6.startDelay + _loc_4;
                    _loc_4 = _loc_4 + perElementOffset;
                    _loc_2.push(_loc_6);
                }
                _loc_5++;
            }
            triggerEvent = null;
            return _loc_2;
        }// end function

        public function pause() : void
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            if (isPlaying && !isPaused)
            {
                isPaused = true;
                _loc_1 = _instances.length;
                _loc_2 = 0;
                while (_loc_2 < _loc_1)
                {
                    
                    IEffectInstance(_instances[_loc_2]).pause();
                    _loc_2++;
                }
            }
            return;
        }// end function

        public function set filter(param1:String) : void
        {
            if (!customFilter)
            {
                _filter = param1;
                switch(param1)
                {
                    case "add":
                    case "remove":
                    {
                        filterObject = new AddRemoveEffectTargetFilter();
                        AddRemoveEffectTargetFilter(filterObject).add = param1 == "add";
                        break;
                    }
                    case "hide":
                    case "show":
                    {
                        filterObject = new HideShowEffectTargetFilter();
                        HideShowEffectTargetFilter(filterObject).show = param1 == "show";
                        break;
                    }
                    case "move":
                    {
                        filterObject = new EffectTargetFilter();
                        filterObject.filterProperties = ["x", "y"];
                        break;
                    }
                    case "resize":
                    {
                        filterObject = new EffectTargetFilter();
                        filterObject.filterProperties = ["width", "height"];
                        break;
                    }
                    case "addItem":
                    {
                        filterObject = new EffectTargetFilter();
                        filterObject.requiredSemantics = {added:true};
                        break;
                    }
                    case "removeItem":
                    {
                        filterObject = new EffectTargetFilter();
                        filterObject.requiredSemantics = {removed:true};
                        break;
                    }
                    case "replacedItem":
                    {
                        filterObject = new EffectTargetFilter();
                        filterObject.requiredSemantics = {replaced:true};
                        break;
                    }
                    case "replacementItem":
                    {
                        filterObject = new EffectTargetFilter();
                        filterObject.requiredSemantics = {replacement:true};
                        break;
                    }
                    default:
                    {
                        filterObject = null;
                        break;
                        break;
                    }
                }
            }
            return;
        }// end function

        public function reverse() : void
        {
            var _loc_1:int = 0;
            var _loc_2:int = 0;
            if (isPlaying)
            {
                _loc_1 = _instances.length;
                _loc_2 = 0;
                while (_loc_2 < _loc_1)
                {
                    
                    IEffectInstance(_instances[_loc_2]).reverse();
                    _loc_2++;
                }
            }
            return;
        }// end function

        private static function mergeArrays(param1:Array, param2:Array) : Array
        {
            var _loc_3:int = 0;
            var _loc_4:Boolean = false;
            var _loc_5:int = 0;
            if (param2)
            {
                _loc_3 = 0;
                while (_loc_3 < param2.length)
                {
                    
                    _loc_4 = true;
                    _loc_5 = 0;
                    while (_loc_5 < param1.length)
                    {
                        
                        if (param1[_loc_5] == param2[_loc_3])
                        {
                            _loc_4 = false;
                            break;
                        }
                        _loc_5++;
                    }
                    if (_loc_4)
                    {
                        param1.push(param2[_loc_3]);
                    }
                    _loc_3++;
                }
            }
            return param1;
        }// end function

        private static function stripUnchangedValues(param1:Array) : Array
        {
            var _loc_3:Object = null;
            var _loc_2:int = 0;
            while (_loc_2 < param1.length)
            {
                
                for (_loc_3 in param1[_loc_2].start)
                {
                    
                    if (param1[_loc_2].start[_loc_3] == param1[_loc_2].end[_loc_3] || typeof(param1[_loc_2].start[_loc_3]) == "number" && typeof(param1[_loc_2].end[_loc_3]) == "number" && isNaN(param1[_loc_2].start[_loc_3]) && isNaN(param1[_loc_2].end[_loc_3]))
                    {
                        delete param1[_loc_2].start[_loc_3];
                        delete param1[_loc_2].end[_loc_3];
                    }
                }
                _loc_2++;
            }
            return param1;
        }// end function

    }
}
