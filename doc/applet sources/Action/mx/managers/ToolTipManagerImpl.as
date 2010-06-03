package mx.managers
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.effects.*;
    import mx.events.*;
    import mx.styles.*;
    import mx.validators.*;

    public class ToolTipManagerImpl extends EventDispatcher implements IToolTipManager2
    {
        private var _enabled:Boolean = true;
        private var _showDelay:Number = 500;
        private var _hideEffect:IAbstractEffect;
        var hideTimer:Timer;
        private var _scrubDelay:Number = 100;
        private var _toolTipClass:Class;
        var showTimer:Timer;
        private var sandboxRoot:IEventDispatcher = null;
        var currentText:String;
        private var _currentToolTip:DisplayObject;
        var scrubTimer:Timer;
        var previousTarget:DisplayObject;
        private var _currentTarget:DisplayObject;
        private var systemManager:ISystemManager = null;
        private var _showEffect:IAbstractEffect;
        private var _hideDelay:Number = 10000;
        var initialized:Boolean = false;
        var isError:Boolean;
        static const VERSION:String = "3.2.0.3958";
        private static var instance:IToolTipManager2;

        public function ToolTipManagerImpl()
        {
            _toolTipClass = ToolTip;
            if (instance)
            {
                throw new Error("Instance already exists.");
            }
            this.systemManager = SystemManagerGlobals.topLevelSystemManagers[0] as ISystemManager;
            sandboxRoot = this.systemManager.getSandboxRoot();
            sandboxRoot.addEventListener(InterManagerRequest.TOOLTIP_MANAGER_REQUEST, marshalToolTipManagerHandler, false, 0, true);
            var _loc_1:* = new InterManagerRequest(InterManagerRequest.TOOLTIP_MANAGER_REQUEST);
            _loc_1.name = "update";
            sandboxRoot.dispatchEvent(_loc_1);
            return;
        }// end function

        function systemManager_mouseDownHandler(event:MouseEvent) : void
        {
            reset();
            return;
        }// end function

        public function set showDelay(param1:Number) : void
        {
            _showDelay = param1;
            return;
        }// end function

        function showTimer_timerHandler(event:TimerEvent) : void
        {
            if (currentTarget)
            {
                createTip();
                initializeTip();
                positionTip();
                showTip();
            }
            return;
        }// end function

        function hideEffectEnded() : void
        {
            var _loc_1:ToolTipEvent = null;
            reset();
            if (previousTarget)
            {
                _loc_1 = new ToolTipEvent(ToolTipEvent.TOOL_TIP_END);
                _loc_1.toolTip = currentToolTip;
                previousTarget.dispatchEvent(_loc_1);
            }
            return;
        }// end function

        public function set scrubDelay(param1:Number) : void
        {
            _scrubDelay = param1;
            return;
        }// end function

        public function get currentToolTip() : IToolTip
        {
            return _currentToolTip as IToolTip;
        }// end function

        private function mouseIsOver(param1:DisplayObject) : Boolean
        {
            if (!param1 || !param1.stage)
            {
                return false;
            }
            if (param1.stage.mouseX == 0 && param1.stage.mouseY == 0)
            {
                return false;
            }
            return param1.hitTestPoint(param1.stage.mouseX, param1.stage.mouseY, true);
        }// end function

        function toolTipMouseOutHandler(event:MouseEvent) : void
        {
            checkIfTargetChanged(event.relatedObject);
            return;
        }// end function

        public function get enabled() : Boolean
        {
            return _enabled;
        }// end function

        public function createToolTip(param1:String, param2:Number, param3:Number, param4:String = null, param5:IUIComponent = null) : IToolTip
        {
            var _loc_6:* = new ToolTip();
            var _loc_7:* = param5 ? (param5.systemManager as ISystemManager) : (ApplicationGlobals.application.systemManager as ISystemManager);
            (param5 ? (param5.systemManager as ISystemManager) : (ApplicationGlobals.application.systemManager as ISystemManager)).topLevelSystemManager.addChildToSandboxRoot("toolTipChildren", _loc_6 as DisplayObject);
            if (param4)
            {
                _loc_6.setStyle("styleName", "errorTip");
                _loc_6.setStyle("borderStyle", param4);
            }
            _loc_6.text = param1;
            sizeTip(_loc_6);
            _loc_6.move(param2, param3);
            return _loc_6 as IToolTip;
        }// end function

        function reset() : void
        {
            var _loc_1:ISystemManager = null;
            showTimer.reset();
            hideTimer.reset();
            if (currentToolTip)
            {
                if (showEffect || hideEffect)
                {
                    currentToolTip.removeEventListener(EffectEvent.EFFECT_END, effectEndHandler);
                }
                EffectManager.endEffectsForTarget(currentToolTip);
                _loc_1 = currentToolTip.systemManager as ISystemManager;
                _loc_1.topLevelSystemManager.removeChildFromSandboxRoot("toolTipChildren", currentToolTip as DisplayObject);
                currentToolTip = null;
                scrubTimer.delay = scrubDelay;
                scrubTimer.reset();
                if (scrubDelay > 0)
                {
                    scrubTimer.delay = scrubDelay;
                    scrubTimer.start();
                }
            }
            return;
        }// end function

        public function set currentToolTip(param1:IToolTip) : void
        {
            _currentToolTip = param1 as DisplayObject;
            var _loc_2:* = new InterManagerRequest(InterManagerRequest.TOOLTIP_MANAGER_REQUEST);
            _loc_2.name = "currentToolTip";
            _loc_2.value = param1;
            sandboxRoot.dispatchEvent(_loc_2);
            return;
        }// end function

        public function get toolTipClass() : Class
        {
            return _toolTipClass;
        }// end function

        private function hideImmediately(param1:DisplayObject) : void
        {
            checkIfTargetChanged(null);
            return;
        }// end function

        function showTip() : void
        {
            var _loc_2:ISystemManager = null;
            var _loc_1:* = new ToolTipEvent(ToolTipEvent.TOOL_TIP_SHOW);
            _loc_1.toolTip = currentToolTip;
            currentTarget.dispatchEvent(_loc_1);
            if (isError)
            {
                currentTarget.addEventListener("change", changeHandler);
            }
            else
            {
                _loc_2 = getSystemManager(currentTarget);
                _loc_2.addEventListener(MouseEvent.MOUSE_DOWN, systemManager_mouseDownHandler);
            }
            currentToolTip.visible = true;
            if (!showEffect)
            {
                showEffectEnded();
            }
            return;
        }// end function

        function effectEndHandler(event:EffectEvent) : void
        {
            if (event.effectInstance.effect == showEffect)
            {
                showEffectEnded();
            }
            else if (event.effectInstance.effect == hideEffect)
            {
                hideEffectEnded();
            }
            return;
        }// end function

        public function get hideDelay() : Number
        {
            return _hideDelay;
        }// end function

        public function get currentTarget() : DisplayObject
        {
            return _currentTarget;
        }// end function

        function showEffectEnded() : void
        {
            var _loc_1:ToolTipEvent = null;
            if (hideDelay == 0)
            {
                hideTip();
            }
            else if (hideDelay < Infinity)
            {
                hideTimer.delay = hideDelay;
                hideTimer.start();
            }
            if (currentTarget)
            {
                _loc_1 = new ToolTipEvent(ToolTipEvent.TOOL_TIP_SHOWN);
                _loc_1.toolTip = currentToolTip;
                currentTarget.dispatchEvent(_loc_1);
            }
            return;
        }// end function

        public function get hideEffect() : IAbstractEffect
        {
            return _hideEffect;
        }// end function

        function changeHandler(event:Event) : void
        {
            reset();
            return;
        }// end function

        public function set enabled(param1:Boolean) : void
        {
            _enabled = param1;
            return;
        }// end function

        function errorTipMouseOverHandler(event:MouseEvent) : void
        {
            checkIfTargetChanged(DisplayObject(event.target));
            return;
        }// end function

        public function get showDelay() : Number
        {
            return _showDelay;
        }// end function

        public function get scrubDelay() : Number
        {
            return _scrubDelay;
        }// end function

        public function registerErrorString(param1:DisplayObject, param2:String, param3:String) : void
        {
            if (!param2 && param3)
            {
                param1.addEventListener(MouseEvent.MOUSE_OVER, errorTipMouseOverHandler);
                param1.addEventListener(MouseEvent.MOUSE_OUT, errorTipMouseOutHandler);
                if (mouseIsOver(param1))
                {
                    showImmediately(param1);
                }
            }
            else if (param2 && !param3)
            {
                param1.removeEventListener(MouseEvent.MOUSE_OVER, errorTipMouseOverHandler);
                param1.removeEventListener(MouseEvent.MOUSE_OUT, errorTipMouseOutHandler);
                if (mouseIsOver(param1))
                {
                    hideImmediately(param1);
                }
            }
            return;
        }// end function

        function initialize() : void
        {
            if (!showTimer)
            {
                showTimer = new Timer(0, 1);
                showTimer.addEventListener(TimerEvent.TIMER, showTimer_timerHandler);
            }
            if (!hideTimer)
            {
                hideTimer = new Timer(0, 1);
                hideTimer.addEventListener(TimerEvent.TIMER, hideTimer_timerHandler);
            }
            if (!scrubTimer)
            {
                scrubTimer = new Timer(0, 1);
            }
            initialized = true;
            return;
        }// end function

        public function destroyToolTip(param1:IToolTip) : void
        {
            var _loc_2:* = param1.systemManager as ISystemManager;
            _loc_2.topLevelSystemManager.removeChildFromSandboxRoot("toolTipChildren", DisplayObject(param1));
            return;
        }// end function

        function checkIfTargetChanged(param1:DisplayObject) : void
        {
            if (!enabled)
            {
                return;
            }
            findTarget(param1);
            if (currentTarget != previousTarget)
            {
                targetChanged();
                previousTarget = currentTarget;
            }
            return;
        }// end function

        private function marshalToolTipManagerHandler(event:Event) : void
        {
            var _loc_2:InterManagerRequest = null;
            if (event is InterManagerRequest)
            {
                return;
            }
            var _loc_3:* = event;
            switch(_loc_3.name)
            {
                case "currentToolTip":
                {
                    _currentToolTip = _loc_3.value;
                    break;
                }
                case ToolTipEvent.TOOL_TIP_HIDE:
                {
                    if (_currentToolTip is IToolTip)
                    {
                        hideTip();
                    }
                    break;
                }
                case "update":
                {
                    event.stopImmediatePropagation();
                    _loc_2 = new InterManagerRequest(InterManagerRequest.TOOLTIP_MANAGER_REQUEST);
                    _loc_2.name = "currentToolTip";
                    _loc_2.value = _currentToolTip;
                    sandboxRoot.dispatchEvent(_loc_2);
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function set toolTipClass(param1:Class) : void
        {
            _toolTipClass = param1;
            return;
        }// end function

        private function getGlobalBounds(param1:DisplayObject, param2:DisplayObject) : Rectangle
        {
            var _loc_3:* = new Point(0, 0);
            _loc_3 = param1.localToGlobal(_loc_3);
            _loc_3 = param2.globalToLocal(_loc_3);
            return new Rectangle(_loc_3.x, _loc_3.y, param1.width, param1.height);
        }// end function

        function positionTip() : void
        {
            var _loc_1:Number = NaN;
            var _loc_2:Number = NaN;
            var _loc_5:Rectangle = null;
            var _loc_6:Point = null;
            var _loc_7:IToolTip = null;
            var _loc_8:Number = NaN;
            var _loc_9:Number = NaN;
            var _loc_10:ISystemManager = null;
            var _loc_11:Number = NaN;
            var _loc_12:Number = NaN;
            var _loc_3:* = currentToolTip.screen.width;
            var _loc_4:* = currentToolTip.screen.height;
            if (isError)
            {
                _loc_5 = getGlobalBounds(currentTarget, currentToolTip.root);
                _loc_1 = _loc_5.right + 4;
                if (_loc_1 + currentToolTip.width > _loc_3)
                {
                    _loc_8 = NaN;
                    _loc_9 = NaN;
                    _loc_1 = _loc_5.left - 2;
                    if (_loc_1 + currentToolTip.width + 4 > _loc_3)
                    {
                        _loc_8 = _loc_3 - _loc_1 - 4;
                        _loc_9 = Object(toolTipClass).maxWidth;
                        Object(toolTipClass).maxWidth = _loc_8;
                        if (currentToolTip is IStyleClient)
                        {
                            IStyleClient(currentToolTip).setStyle("borderStyle", "errorTipAbove");
                        }
                        currentToolTip["text"] = currentToolTip["text"];
                        Object(toolTipClass).maxWidth = _loc_9;
                    }
                    else
                    {
                        if (currentToolTip is IStyleClient)
                        {
                            IStyleClient(currentToolTip).setStyle("borderStyle", "errorTipAbove");
                        }
                        currentToolTip["text"] = currentToolTip["text"];
                    }
                    if (currentToolTip.height + 2 < _loc_5.top)
                    {
                        _loc_5.top-- = _loc_5.top - (currentToolTip.height + 2);
                    }
                    else
                    {
                        _loc_5.top-- = _loc_5.bottom + 2;
                        if (!isNaN(_loc_8))
                        {
                            Object(toolTipClass).maxWidth = _loc_8;
                        }
                        if (currentToolTip is IStyleClient)
                        {
                            IStyleClient(currentToolTip).setStyle("borderStyle", "errorTipBelow");
                        }
                        currentToolTip["text"] = currentToolTip["text"];
                        if (!isNaN(_loc_9))
                        {
                            Object(toolTipClass).maxWidth = _loc_9;
                        }
                    }
                }
                sizeTip(currentToolTip);
                _loc_6 = new Point(_loc_1, _loc_5.top--);
                _loc_7 = currentToolTip;
                _loc_1 = _loc_6.x;
                _loc_2 = _loc_6.y;
            }
            else
            {
                _loc_10 = getSystemManager(currentTarget);
                _loc_1 = DisplayObject(_loc_10).mouseX + 11;
                _loc_2 = DisplayObject(_loc_10).mouseY + 22;
                _loc_11 = currentToolTip.width;
                if (_loc_1 + _loc_11 > _loc_3)
                {
                    _loc_1 = _loc_3 - _loc_11;
                }
                _loc_12 = currentToolTip.height;
                if (_loc_2 + _loc_12 > _loc_4)
                {
                    _loc_2 = _loc_4 - _loc_12;
                }
                _loc_6 = new Point(_loc_1, _loc_2);
                _loc_6 = DisplayObject(_loc_10).localToGlobal(_loc_6);
                _loc_6 = DisplayObject(sandboxRoot).globalToLocal(_loc_6);
                _loc_1 = _loc_6.x;
                _loc_2 = _loc_6.y;
            }
            currentToolTip.move(_loc_1, _loc_2);
            return;
        }// end function

        function errorTipMouseOutHandler(event:MouseEvent) : void
        {
            checkIfTargetChanged(event.relatedObject);
            return;
        }// end function

        function findTarget(param1:DisplayObject) : void
        {
            while (param1)
            {
                
                if (param1 is IValidatorListener)
                {
                    currentText = IValidatorListener(param1).errorString;
                    if (currentText != null && currentText != "")
                    {
                        currentTarget = param1;
                        isError = true;
                        return;
                    }
                }
                if (param1 is IToolTipManagerClient)
                {
                    currentText = IToolTipManagerClient(param1).toolTip;
                    if (currentText != null)
                    {
                        currentTarget = param1;
                        isError = false;
                        return;
                    }
                }
                param1 = param1.parent;
            }
            currentText = null;
            currentTarget = null;
            return;
        }// end function

        public function registerToolTip(param1:DisplayObject, param2:String, param3:String) : void
        {
            if (!param2 && param3)
            {
                param1.addEventListener(MouseEvent.MOUSE_OVER, toolTipMouseOverHandler);
                param1.addEventListener(MouseEvent.MOUSE_OUT, toolTipMouseOutHandler);
                if (mouseIsOver(param1))
                {
                    showImmediately(param1);
                }
            }
            else if (param2 && !param3)
            {
                param1.removeEventListener(MouseEvent.MOUSE_OVER, toolTipMouseOverHandler);
                param1.removeEventListener(MouseEvent.MOUSE_OUT, toolTipMouseOutHandler);
                if (mouseIsOver(param1))
                {
                    hideImmediately(param1);
                }
            }
            return;
        }// end function

        private function showImmediately(param1:DisplayObject) : void
        {
            var _loc_2:* = ToolTipManager.showDelay;
            ToolTipManager.showDelay = 0;
            checkIfTargetChanged(param1);
            ToolTipManager.showDelay = _loc_2;
            return;
        }// end function

        public function set hideDelay(param1:Number) : void
        {
            _hideDelay = param1;
            return;
        }// end function

        private function getSystemManager(param1:DisplayObject) : ISystemManager
        {
            return param1 is IUIComponent ? (IUIComponent(param1).systemManager) : (null);
        }// end function

        public function set currentTarget(param1:DisplayObject) : void
        {
            _currentTarget = param1;
            return;
        }// end function

        public function sizeTip(param1:IToolTip) : void
        {
            if (param1 is IInvalidating)
            {
                IInvalidating(param1).validateNow();
            }
            param1.setActualSize(param1.getExplicitOrMeasuredWidth(), param1.getExplicitOrMeasuredHeight());
            return;
        }// end function

        public function set showEffect(param1:IAbstractEffect) : void
        {
            _showEffect = param1 as IAbstractEffect;
            return;
        }// end function

        function targetChanged() : void
        {
            var _loc_1:ToolTipEvent = null;
            var _loc_2:InterManagerRequest = null;
            if (!initialized)
            {
                initialize();
            }
            if (previousTarget && currentToolTip)
            {
                if (currentToolTip is IToolTip)
                {
                    _loc_1 = new ToolTipEvent(ToolTipEvent.TOOL_TIP_HIDE);
                    _loc_1.toolTip = currentToolTip;
                    previousTarget.dispatchEvent(_loc_1);
                }
                else
                {
                    _loc_2 = new InterManagerRequest(InterManagerRequest.TOOLTIP_MANAGER_REQUEST);
                    _loc_2.name = ToolTipEvent.TOOL_TIP_HIDE;
                    sandboxRoot.dispatchEvent(_loc_2);
                }
            }
            reset();
            if (currentTarget)
            {
                if (currentText == "")
                {
                    return;
                }
                _loc_1 = new ToolTipEvent(ToolTipEvent.TOOL_TIP_START);
                currentTarget.dispatchEvent(_loc_1);
                if (showDelay == 0 || scrubTimer.running)
                {
                    createTip();
                    initializeTip();
                    positionTip();
                    showTip();
                }
                else
                {
                    showTimer.delay = showDelay;
                    showTimer.start();
                }
            }
            return;
        }// end function

        public function set hideEffect(param1:IAbstractEffect) : void
        {
            _hideEffect = param1 as IAbstractEffect;
            return;
        }// end function

        function hideTimer_timerHandler(event:TimerEvent) : void
        {
            hideTip();
            return;
        }// end function

        function initializeTip() : void
        {
            if (currentToolTip is IToolTip)
            {
                IToolTip(currentToolTip).text = currentText;
            }
            if (isError && currentToolTip is IStyleClient)
            {
                IStyleClient(currentToolTip).setStyle("styleName", "errorTip");
            }
            sizeTip(currentToolTip);
            if (currentToolTip is IStyleClient)
            {
                if (showEffect)
                {
                    IStyleClient(currentToolTip).setStyle("showEffect", showEffect);
                }
                if (hideEffect)
                {
                    IStyleClient(currentToolTip).setStyle("hideEffect", hideEffect);
                }
            }
            if (showEffect || hideEffect)
            {
                currentToolTip.addEventListener(EffectEvent.EFFECT_END, effectEndHandler);
            }
            return;
        }// end function

        public function get showEffect() : IAbstractEffect
        {
            return _showEffect;
        }// end function

        function toolTipMouseOverHandler(event:MouseEvent) : void
        {
            checkIfTargetChanged(DisplayObject(event.target));
            return;
        }// end function

        function hideTip() : void
        {
            var _loc_1:ToolTipEvent = null;
            var _loc_2:ISystemManager = null;
            if (previousTarget)
            {
                _loc_1 = new ToolTipEvent(ToolTipEvent.TOOL_TIP_HIDE);
                _loc_1.toolTip = currentToolTip;
                previousTarget.dispatchEvent(_loc_1);
            }
            if (currentToolTip)
            {
                currentToolTip.visible = false;
            }
            if (isError)
            {
                if (currentTarget)
                {
                    currentTarget.removeEventListener("change", changeHandler);
                }
            }
            else if (previousTarget)
            {
                _loc_2 = getSystemManager(previousTarget);
                _loc_2.removeEventListener(MouseEvent.MOUSE_DOWN, systemManager_mouseDownHandler);
            }
            if (!hideEffect)
            {
                hideEffectEnded();
            }
            return;
        }// end function

        function createTip() : void
        {
            var _loc_1:* = new ToolTipEvent(ToolTipEvent.TOOL_TIP_CREATE);
            currentTarget.dispatchEvent(_loc_1);
            if (_loc_1.toolTip)
            {
                currentToolTip = _loc_1.toolTip;
            }
            else
            {
                currentToolTip = new toolTipClass();
            }
            currentToolTip.visible = false;
            var _loc_2:* = getSystemManager(currentTarget) as ISystemManager;
            _loc_2.topLevelSystemManager.addChildToSandboxRoot("toolTipChildren", currentToolTip as DisplayObject);
            return;
        }// end function

        public static function getInstance() : IToolTipManager2
        {
            if (!instance)
            {
                instance = new ToolTipManagerImpl;
            }
            return instance;
        }// end function

    }
}
