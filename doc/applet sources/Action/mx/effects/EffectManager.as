package mx.effects
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import mx.core.*;
    import mx.events.*;
    import mx.resources.*;

    public class EffectManager extends EventDispatcher
    {
        private static var _resourceManager:IResourceManager;
        private static var effects:Dictionary = new Dictionary(true);
        static var effectsPlaying:Array = [];
        private static var targetsInfo:Array = [];
        static const VERSION:String = "3.2.0.3958";
        private static var effectTriggersForEvent:Object = {};
        static var lastEffectCreated:Effect;
        private static var eventHandlingSuspendCount:Number = 0;
        private static var eventsForEffectTriggers:Object = {};

        public function EffectManager()
        {
            return;
        }// end function

        public static function suspendEventHandling() : void
        {
            eventHandlingSuspendCount++;
            return;
        }// end function

        static function registerEffectTrigger(param1:String, param2:String) : void
        {
            var _loc_3:Number = NaN;
            if (param1 != "")
            {
                if (param2 == "")
                {
                    _loc_3 = param1.length;
                    if (_loc_3 > 6 && param1.substring(_loc_3 - 6) == "Effect")
                    {
                        param2 = param1.substring(0, _loc_3 - 6);
                    }
                }
                if (param2 != "")
                {
                    effectTriggersForEvent[param2] = param1;
                    eventsForEffectTriggers[param1] = param2;
                }
            }
            return;
        }// end function

        private static function removedEffectHandler(param1:DisplayObject, param2:DisplayObjectContainer, param3:int, param4:Event) : void
        {
            suspendEventHandling();
            param2.addChildAt(param1, param3);
            resumeEventHandling();
            createAndPlayEffect(param4, param1);
            return;
        }// end function

        private static function createAndPlayEffect(event:Event, param2:Object) : void
        {
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_9:String = null;
            var _loc_10:String = null;
            var _loc_11:Array = null;
            var _loc_12:Array = null;
            var _loc_13:Array = null;
            var _loc_14:Array = null;
            var _loc_15:EffectInstance = null;
            var _loc_3:* = createEffectForType(param2, event.type);
            if (!_loc_3)
            {
                return;
            }
            if (_loc_3 is Zoom && event.type == MoveEvent.MOVE)
            {
                _loc_9 = resourceManager.getString("effects", "incorrectTrigger");
                throw new Error(_loc_9);
            }
            if (param2.initialized == false)
            {
                _loc_10 = event.type;
                if (_loc_10 == MoveEvent.MOVE || _loc_10 == ResizeEvent.RESIZE || _loc_10 == FlexEvent.SHOW || _loc_10 == FlexEvent.HIDE || _loc_10 == Event.CHANGE)
                {
                    _loc_3 = null;
                    return;
                }
            }
            if (_loc_3.target is IUIComponent)
            {
                _loc_11 = IUIComponent(_loc_3.target).tweeningProperties;
                if (_loc_11 && _loc_11.length > 0)
                {
                    _loc_12 = _loc_3.getAffectedProperties();
                    _loc_4 = _loc_11.length;
                    _loc_6 = _loc_12.length;
                    _loc_5 = 0;
                    while (_loc_5 < _loc_4)
                    {
                        
                        _loc_7 = 0;
                        while (_loc_7 < _loc_6)
                        {
                            
                            if (_loc_11[_loc_5] == _loc_12[_loc_7])
                            {
                                _loc_3 = null;
                                return;
                            }
                            _loc_7++;
                        }
                        _loc_5++;
                    }
                }
            }
            if (_loc_3.target is UIComponent && UIComponent(_loc_3.target).isEffectStarted)
            {
                _loc_13 = _loc_3.getAffectedProperties();
                _loc_5 = 0;
                while (_loc_5 < _loc_13.length)
                {
                    
                    _loc_14 = _loc_3.target.getEffectsForProperty(_loc_13[_loc_5]);
                    if (_loc_14.length > 0)
                    {
                        if (event.type == ResizeEvent.RESIZE)
                        {
                            return;
                        }
                        _loc_7 = 0;
                        while (_loc_7 < _loc_14.length)
                        {
                            
                            _loc_15 = _loc_14[_loc_7];
                            if (event.type == FlexEvent.SHOW && _loc_15.hideOnEffectEnd)
                            {
                                _loc_15.target.removeEventListener(FlexEvent.SHOW, _loc_15.eventHandler);
                                _loc_15.hideOnEffectEnd = false;
                            }
                            _loc_15.end();
                            _loc_7++;
                        }
                    }
                    _loc_5++;
                }
            }
            _loc_3.triggerEvent = event;
            _loc_3.addEventListener(EffectEvent.EFFECT_END, EffectManager.effectEndHandler);
            lastEffectCreated = _loc_3;
            var _loc_8:* = _loc_3.play();
            _loc_4 = _loc_3.play().length;
            _loc_5 = 0;
            while (_loc_5 < _loc_4)
            {
                
                effectsPlaying.push(new EffectNode(_loc_3, _loc_8[_loc_5]));
                _loc_5++;
            }
            if (_loc_3.suspendBackgroundProcessing)
            {
                UIComponent.suspendBackgroundProcessing();
            }
            return;
        }// end function

        public static function endEffectsForTarget(param1:IUIComponent) : void
        {
            var _loc_4:EffectInstance = null;
            var _loc_2:* = effectsPlaying.length;
            while (_loc_3-- >= 0)
            {
                
                _loc_4 = effectsPlaying[_loc_2--].instance;
                if (_loc_4.target == param1)
                {
                    _loc_4.end();
                }
            }
            return;
        }// end function

        private static function cacheOrUncacheTargetAsBitmap(param1:IUIComponent, param2:Boolean = true, param3:Boolean = true) : void
        {
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:Object = null;
            _loc_4 = targetsInfo.length;
            _loc_5 = 0;
            while (_loc_5 < _loc_4)
            {
                
                if (targetsInfo[_loc_5].target == param1)
                {
                    _loc_6 = targetsInfo[_loc_5];
                    break;
                }
                _loc_5++;
            }
            if (!_loc_6)
            {
                _loc_6 = {target:param1, bitmapEffectsCount:0, vectorEffectsCount:0};
                targetsInfo.push(_loc_6);
            }
            if (param2)
            {
                if (param3)
                {
                    var _loc_7:* = _loc_6;
                    _loc_7.bitmapEffectsCount = _loc_6.bitmapEffectsCount++;
                    if (_loc_6.vectorEffectsCount == 0 && param1 is IDeferredInstantiationUIComponent)
                    {
                        IDeferredInstantiationUIComponent(param1).cacheHeuristic = true;
                    }
                }
                else
                {
                    var _loc_7:* = _loc_6;
                    _loc_7.vectorEffectsCount = _loc_6.vectorEffectsCount++;
                    if (_loc_6.vectorEffectsCount++ == 0 && param1 is IDeferredInstantiationUIComponent && IDeferredInstantiationUIComponent(param1).cachePolicy == UIComponentCachePolicy.AUTO)
                    {
                        param1.cacheAsBitmap = false;
                    }
                }
            }
            else
            {
                if (param3)
                {
                    if (_loc_6.bitmapEffectsCount != 0)
                    {
                        var _loc_7:* = _loc_6;
                        _loc_7.bitmapEffectsCount = _loc_6.bitmapEffectsCount--;
                    }
                    if (param1 is IDeferredInstantiationUIComponent)
                    {
                        IDeferredInstantiationUIComponent(param1).cacheHeuristic = false;
                    }
                }
                else if (_loc_6.vectorEffectsCount != 0)
                {
                    var _loc_7:* = _loc_6;
                    _loc_7.vectorEffectsCount = --_loc_6.vectorEffectsCount;
                    if (--_loc_6.vectorEffectsCount == 0 && _loc_6.bitmapEffectsCount != 0)
                    {
                        _loc_4 = _loc_6.bitmapEffectsCount;
                        _loc_5 = 0;
                        while (_loc_5 < _loc_4)
                        {
                            
                            if (param1 is IDeferredInstantiationUIComponent)
                            {
                                IDeferredInstantiationUIComponent(param1).cacheHeuristic = true;
                            }
                            _loc_5++;
                        }
                    }
                }
                if (_loc_6.bitmapEffectsCount == 0 && _loc_6.vectorEffectsCount == 0)
                {
                    _loc_4 = targetsInfo.length;
                    _loc_5 = 0;
                    while (_loc_5 < _loc_4)
                    {
                        
                        if (targetsInfo[_loc_5].target == param1)
                        {
                            targetsInfo.splice(_loc_5, 1);
                            break;
                        }
                        _loc_5++;
                    }
                }
            }
            return;
        }// end function

        static function eventHandler(event:Event) : void
        {
            var _loc_2:FocusEvent = null;
            var _loc_3:DisplayObject = null;
            var _loc_4:int = 0;
            var _loc_5:DisplayObjectContainer = null;
            var _loc_6:int = 0;
            if (!(event.currentTarget is IFlexDisplayObject))
            {
                return;
            }
            if (eventHandlingSuspendCount > 0)
            {
                return;
            }
            if (event is FocusEvent && event.type == FocusEvent.FOCUS_OUT || event.type == FocusEvent.FOCUS_IN)
            {
                _loc_2 = FocusEvent(event);
                if (_loc_2.relatedObject && _loc_2.currentTarget.contains(_loc_2.relatedObject) || _loc_2.currentTarget == _loc_2.relatedObject)
                {
                    return;
                }
            }
            if (event.type == Event.ADDED || event.type == Event.REMOVED && event.target != event.currentTarget)
            {
                return;
            }
            if (event.type == Event.REMOVED)
            {
                if (event.target is UIComponent)
                {
                    if (UIComponent(event.target).initialized == false)
                    {
                        return;
                    }
                    if (UIComponent(event.target).isEffectStarted)
                    {
                        _loc_4 = 0;
                        while (_loc_4 < UIComponent(event.target)._effectsStarted.length)
                        {
                            
                            if (UIComponent(event.target)._effectsStarted[_loc_4].triggerEvent.type == Event.REMOVED)
                            {
                                return;
                            }
                            _loc_4++;
                        }
                    }
                }
                _loc_3 = event.target as DisplayObject;
                if (_loc_3 != null)
                {
                    _loc_5 = _loc_3.parent as DisplayObjectContainer;
                    if (_loc_5 != null)
                    {
                        _loc_6 = _loc_5.getChildIndex(_loc_3);
                        if (_loc_6 >= 0)
                        {
                            if (_loc_3 is UIComponent)
                            {
                                UIComponent(_loc_3).callLater(removedEffectHandler, [_loc_3, _loc_5, _loc_6, event]);
                            }
                        }
                    }
                }
            }
            else
            {
                createAndPlayEffect(event, event.currentTarget);
            }
            return;
        }// end function

        static function endBitmapEffect(param1:IUIComponent) : void
        {
            cacheOrUncacheTargetAsBitmap(param1, false, true);
            return;
        }// end function

        private static function animateSameProperty(param1:Effect, param2:Effect, param3:EffectInstance) : Boolean
        {
            var _loc_4:Array = null;
            var _loc_5:Array = null;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            if (param1.target == param3.target)
            {
                _loc_4 = param1.getAffectedProperties();
                _loc_5 = param2.getAffectedProperties();
                _loc_6 = _loc_4.length;
                _loc_7 = _loc_5.length;
                _loc_8 = 0;
                while (_loc_8 < _loc_6)
                {
                    
                    _loc_9 = 0;
                    while (_loc_9 < _loc_7)
                    {
                        
                        if (_loc_4[_loc_8] == _loc_5[_loc_9])
                        {
                            return true;
                        }
                        _loc_9++;
                    }
                    _loc_8++;
                }
            }
            return false;
        }// end function

        static function effectFinished(param1:EffectInstance) : void
        {
            delete effects[param1];
            return;
        }// end function

        static function effectsInEffect() : Boolean
        {
            var _loc_1:* = undefined;
            for (_loc_1 in effects)
            {
                
                return true;
            }
            return false;
        }// end function

        static function effectEndHandler(event:EffectEvent) : void
        {
            var _loc_5:DisplayObject = null;
            var _loc_6:DisplayObjectContainer = null;
            var _loc_2:* = event.effectInstance;
            var _loc_3:* = effectsPlaying.length;
            while (_loc_4-- >= 0)
            {
                
                if (effectsPlaying[_loc_3--].instance == _loc_2)
                {
                    effectsPlaying.splice(_loc_4, 1);
                    break;
                }
            }
            if (Object(_loc_2).hideOnEffectEnd == true)
            {
                _loc_2.target.removeEventListener(FlexEvent.SHOW, Object(_loc_2).eventHandler);
                _loc_2.target.setVisible(false, true);
            }
            if (_loc_2.triggerEvent && _loc_2.triggerEvent.type == Event.REMOVED)
            {
                _loc_5 = _loc_2.target as DisplayObject;
                if (_loc_5 != null)
                {
                    _loc_6 = _loc_5.parent as DisplayObjectContainer;
                    if (_loc_6 != null)
                    {
                        suspendEventHandling();
                        _loc_6.removeChild(_loc_5);
                        resumeEventHandling();
                    }
                }
            }
            if (_loc_2.suspendBackgroundProcessing)
            {
                UIComponent.resumeBackgroundProcessing();
            }
            return;
        }// end function

        static function startBitmapEffect(param1:IUIComponent) : void
        {
            cacheOrUncacheTargetAsBitmap(param1, true, true);
            return;
        }// end function

        static function setStyle(param1:String, param2) : void
        {
            var _loc_3:* = eventsForEffectTriggers[param1];
            if (_loc_3 != null && _loc_3 != "")
            {
                param2.addEventListener(_loc_3, EffectManager.eventHandler, false, EventPriority.EFFECT);
            }
            return;
        }// end function

        static function getEventForEffectTrigger(param1:String) : String
        {
            var effectTrigger:* = param1;
            if (eventsForEffectTriggers)
            {
                try
                {
                    return eventsForEffectTriggers[effectTrigger];
                }
                catch (e:Error)
                {
                    return "";
                }
            }
            return "";
        }// end function

        static function createEffectForType(param1:Object, param2:String) : Effect
        {
            var cls:Class;
            var effectObj:Effect;
            var doc:Object;
            var target:* = param1;
            var type:* = param2;
            var trigger:* = effectTriggersForEvent[type];
            if (trigger == "")
            {
                trigger = type + "Effect";
            }
            var value:* = target.getStyle(trigger);
            if (!value)
            {
                return null;
            }
            if (value is Class)
            {
                cls = Class(value);
                return new cls(target);
            }
            try
            {
                if (value is String)
                {
                    doc = target.parentDocument;
                    if (!doc)
                    {
                        doc = ApplicationGlobals.application;
                    }
                    effectObj = doc[value];
                }
                else if (value is Effect)
                {
                    effectObj = Effect(value);
                }
                if (effectObj)
                {
                    effectObj.target = target;
                    return effectObj;
                }
            }
            catch (e:Error)
            {
            }
            var effectClass:* = Class(target.systemManager.getDefinitionByName("mx.effects." + value));
            if (effectClass)
            {
                return new effectClass(target);
            }
            return null;
        }// end function

        static function effectStarted(param1:EffectInstance) : void
        {
            effects[param1] = 1;
            return;
        }// end function

        public static function resumeEventHandling() : void
        {
            eventHandlingSuspendCount--;
            return;
        }// end function

        static function startVectorEffect(param1:IUIComponent) : void
        {
            cacheOrUncacheTargetAsBitmap(param1, true, false);
            return;
        }// end function

        static function endVectorEffect(param1:IUIComponent) : void
        {
            cacheOrUncacheTargetAsBitmap(param1, false, false);
            return;
        }// end function

        private static function get resourceManager() : IResourceManager
        {
            if (!_resourceManager)
            {
                _resourceManager = ResourceManager.getInstance();
            }
            return _resourceManager;
        }// end function

    }
}
