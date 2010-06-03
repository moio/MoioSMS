package mx.managers
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import mx.automation.*;
    import mx.core.*;
    import mx.effects.*;
    import mx.events.*;
    import mx.styles.*;
    import mx.utils.*;

    public class PopUpManagerImpl extends Object implements IPopUpManager
    {
        private var popupInfo:Array;
        var modalWindowClass:Class;
        private static var instance:IPopUpManager;
        static const VERSION:String = "3.2.0.3958";

        public function PopUpManagerImpl()
        {
            var _loc_1:* = ISystemManager(SystemManagerGlobals.topLevelSystemManagers[0]);
            _loc_1.addEventListener(SWFBridgeRequest.CREATE_MODAL_WINDOW_REQUEST, createModalWindowRequestHandler, false, 0, true);
            _loc_1.addEventListener(SWFBridgeRequest.SHOW_MODAL_WINDOW_REQUEST, showModalWindowRequest, false, 0, true);
            _loc_1.addEventListener(SWFBridgeRequest.HIDE_MODAL_WINDOW_REQUEST, hideModalWindowRequest, false, 0, true);
            return;
        }// end function

        private function showModalWindow(param1:PopUpData, param2:ISystemManager, param3:Boolean = true) : void
        {
            var _loc_4:* = param1.owner as IStyleClient;
            var _loc_5:Number = 0;
            var _loc_6:Number = 0;
            if (!isNaN(param1.modalTransparencyDuration))
            {
                _loc_5 = param1.modalTransparencyDuration;
            }
            else if (_loc_4)
            {
                _loc_5 = _loc_4.getStyle("modalTransparencyDuration");
                param1.modalTransparencyDuration = _loc_5;
            }
            if (!isNaN(param1.modalTransparency))
            {
                _loc_6 = param1.modalTransparency;
            }
            else if (_loc_4)
            {
                _loc_6 = _loc_4.getStyle("modalTransparency");
                param1.modalTransparency = _loc_6;
            }
            param1.modalWindow.alpha = _loc_6;
            var _loc_7:Number = 0;
            if (!isNaN(param1.modalTransparencyBlur))
            {
                _loc_7 = param1.modalTransparencyBlur;
            }
            else if (_loc_4)
            {
                _loc_7 = _loc_4.getStyle("modalTransparencyBlur");
                param1.modalTransparencyBlur = _loc_7;
            }
            var _loc_8:Number = 16777215;
            if (!isNaN(param1.modalTransparencyColor))
            {
                _loc_8 = param1.modalTransparencyColor;
            }
            else if (_loc_4)
            {
                _loc_8 = _loc_4.getStyle("modalTransparencyColor");
                param1.modalTransparencyColor = _loc_8;
            }
            if (param2 is SystemManagerProxy)
            {
                param2 = SystemManagerProxy(param2).systemManager;
            }
            var _loc_9:* = param2.getSandboxRoot();
            showModalWindowInternal(param1, _loc_5, _loc_6, _loc_8, _loc_7, param2, _loc_9);
            if (param3 && param2.useSWFBridge())
            {
                dispatchModalWindowRequest(SWFBridgeRequest.SHOW_MODAL_WINDOW_REQUEST, param2, _loc_9, param1, true);
            }
            return;
        }// end function

        private function popupShowHandler(event:FlexEvent) : void
        {
            var _loc_2:* = findPopupInfoByOwner(event.target);
            if (_loc_2)
            {
                showModalWindow(_loc_2, getTopLevelSystemManager(_loc_2.parent));
            }
            return;
        }// end function

        public function bringToFront(param1:IFlexDisplayObject) : void
        {
            var _loc_2:PopUpData = null;
            var _loc_3:ISystemManager = null;
            var _loc_4:InterManagerRequest = null;
            if (param1 && param1.parent)
            {
                _loc_2 = findPopupInfoByOwner(param1);
                if (_loc_2)
                {
                    _loc_3 = ISystemManager(param1.parent);
                    if (_loc_3 is SystemManagerProxy)
                    {
                        _loc_4 = new InterManagerRequest(InterManagerRequest.SYSTEM_MANAGER_REQUEST, false, false, "bringToFront", {topMost:_loc_2.topMost, popUp:_loc_3});
                        _loc_3.getSandboxRoot().dispatchEvent(_loc_4);
                    }
                    else if (_loc_2.topMost)
                    {
                        _loc_3.popUpChildren.setChildIndex(DisplayObject(param1), _loc_3.popUpChildren.numChildren--);
                    }
                    else
                    {
                        _loc_3.setChildIndex(DisplayObject(param1), _loc_3.numChildren--);
                    }
                }
            }
            return;
        }// end function

        public function centerPopUp(param1:IFlexDisplayObject) : void
        {
            var _loc_3:ISystemManager = null;
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_6:Number = NaN;
            var _loc_7:Number = NaN;
            var _loc_8:Number = NaN;
            var _loc_9:Number = NaN;
            var _loc_10:Rectangle = null;
            var _loc_11:Rectangle = null;
            var _loc_12:Point = null;
            var _loc_13:Point = null;
            var _loc_14:Boolean = false;
            var _loc_15:DisplayObject = null;
            var _loc_16:InterManagerRequest = null;
            var _loc_17:Point = null;
            if (param1 is IInvalidating)
            {
                IInvalidating(param1).validateNow();
            }
            var _loc_2:* = findPopupInfoByOwner(param1);
            if (_loc_2 && _loc_2.parent)
            {
                _loc_3 = _loc_2.systemManager;
                _loc_12 = new Point();
                _loc_15 = _loc_3.getSandboxRoot();
                if (_loc_3 != _loc_15)
                {
                    _loc_16 = new InterManagerRequest(InterManagerRequest.SYSTEM_MANAGER_REQUEST, false, false, "isTopLevelRoot");
                    _loc_15.dispatchEvent(_loc_16);
                    _loc_14 = Boolean(_loc_16.value);
                }
                else
                {
                    _loc_14 = _loc_3.isTopLevelRoot();
                }
                if (_loc_14)
                {
                    _loc_10 = _loc_3.screen;
                    _loc_6 = _loc_10.width;
                    _loc_7 = _loc_10.height;
                }
                else
                {
                    if (_loc_3 != _loc_15)
                    {
                        _loc_16 = new InterManagerRequest(InterManagerRequest.SYSTEM_MANAGER_REQUEST, false, false, "getVisibleApplicationRect");
                        _loc_15.dispatchEvent(_loc_16);
                        _loc_11 = Rectangle(_loc_16.value);
                    }
                    else
                    {
                        _loc_11 = _loc_3.getVisibleApplicationRect();
                    }
                    _loc_12 = new Point(_loc_11.x, _loc_11.y);
                    _loc_12 = DisplayObject(_loc_3).globalToLocal(_loc_12);
                    _loc_6 = _loc_11.width;
                    _loc_7 = _loc_11.height;
                }
                if (_loc_2.parent is UIComponent)
                {
                    _loc_11 = UIComponent(_loc_2.parent).getVisibleRect();
                    _loc_17 = _loc_2.parent.globalToLocal(_loc_11.topLeft);
                    _loc_12.x = _loc_12.x + _loc_17.x;
                    _loc_12.y = _loc_12.y + _loc_17.y;
                    _loc_8 = _loc_11.width;
                    _loc_9 = _loc_11.height;
                }
                else
                {
                    _loc_8 = _loc_2.parent.width;
                    _loc_9 = _loc_2.parent.height;
                }
                _loc_4 = Math.max(0, (Math.min(_loc_6, _loc_8) - param1.width) / 2);
                _loc_5 = Math.max(0, (Math.min(_loc_7, _loc_9) - param1.height) / 2);
                _loc_13 = new Point(_loc_12.x, _loc_12.y);
                _loc_13 = _loc_2.parent.localToGlobal(_loc_13);
                _loc_13 = param1.parent.globalToLocal(_loc_13);
                param1.move(Math.round(_loc_4) + _loc_13.x, Math.round(_loc_5) + _loc_13.y);
            }
            return;
        }// end function

        private function showModalWindowRequest(event:Event) : void
        {
            var _loc_2:* = SWFBridgeRequest.marshal(event);
            if (event is SWFBridgeRequest)
            {
                _loc_2 = SWFBridgeRequest(event);
            }
            else
            {
                _loc_2 = SWFBridgeRequest.marshal(event);
            }
            var _loc_3:* = getTopLevelSystemManager(DisplayObject(ApplicationGlobals.application));
            var _loc_4:* = _loc_3.getSandboxRoot();
            var _loc_5:* = findHighestRemoteModalPopupInfo();
            findHighestRemoteModalPopupInfo().excludeRect = Rectangle(_loc_2.data);
            _loc_5.modalTransparency = _loc_2.data.transparency;
            _loc_5.modalTransparencyBlur = 0;
            _loc_5.modalTransparencyColor = _loc_2.data.transparencyColor;
            _loc_5.modalTransparencyDuration = _loc_2.data.transparencyDuration;
            if (_loc_5.owner || _loc_5.parent)
            {
                throw new Error();
            }
            showModalWindow(_loc_5, _loc_3);
            return;
        }// end function

        private function hideOwnerHandler(event:FlexEvent) : void
        {
            var _loc_2:* = findPopupInfoByOwner(event.target);
            if (_loc_2)
            {
                removeMouseOutEventListeners(_loc_2);
            }
            return;
        }// end function

        private function fadeOutDestroyEffectEndHandler(event:EffectEvent) : void
        {
            var _loc_4:ISystemManager = null;
            effectEndHandler(event);
            var _loc_2:* = DisplayObject(event.effectInstance.target);
            var _loc_3:* = _loc_2.mask;
            if (_loc_3)
            {
                _loc_2.mask = null;
                _loc_4.popUpChildren.removeChild(_loc_3);
            }
            if (_loc_2.parent is ISystemManager)
            {
                _loc_4 = ISystemManager(_loc_2.parent);
                if (_loc_4.popUpChildren.contains(_loc_2))
                {
                    _loc_4.popUpChildren.removeChild(_loc_2);
                }
                else
                {
                    _loc_4.removeChild(_loc_2);
                }
            }
            else if (_loc_2.parent)
            {
                _loc_2.parent.removeChild(_loc_2);
            }
            return;
        }// end function

        private function createModalWindowRequestHandler(event:Event) : void
        {
            var _loc_2:SWFBridgeRequest = null;
            if (event is SWFBridgeRequest)
            {
                _loc_2 = SWFBridgeRequest(event);
            }
            else
            {
                _loc_2 = SWFBridgeRequest.marshal(event);
            }
            var _loc_3:* = getTopLevelSystemManager(DisplayObject(ApplicationGlobals.application));
            var _loc_4:* = _loc_3.getSandboxRoot();
            var _loc_5:* = new PopUpData();
            new PopUpData().isRemoteModalWindow = true;
            _loc_5.systemManager = _loc_3;
            _loc_5.modalTransparency = _loc_2.data.transparency;
            _loc_5.modalTransparencyBlur = 0;
            _loc_5.modalTransparencyColor = _loc_2.data.transparencyColor;
            _loc_5.modalTransparencyDuration = _loc_2.data.transparencyDuration;
            _loc_5.exclude = _loc_3.swfBridgeGroup.getChildBridgeProvider(_loc_2.requestor) as IUIComponent;
            _loc_5.useExclude = _loc_2.data.useExclude;
            _loc_5.excludeRect = Rectangle(_loc_2.data.excludeRect);
            if (!popupInfo)
            {
                popupInfo = [];
            }
            popupInfo.push(_loc_5);
            createModalWindow(null, _loc_5, _loc_3.popUpChildren, _loc_2.data.show, _loc_3, _loc_4);
            return;
        }// end function

        private function showOwnerHandler(event:FlexEvent) : void
        {
            var _loc_2:* = findPopupInfoByOwner(event.target);
            if (_loc_2)
            {
                addMouseOutEventListeners(_loc_2);
            }
            return;
        }// end function

        private function addMouseOutEventListeners(param1:PopUpData) : void
        {
            var _loc_2:* = param1.systemManager.getSandboxRoot();
            if (param1.modalWindow)
            {
                param1.modalWindow.addEventListener(MouseEvent.MOUSE_DOWN, param1.mouseDownOutsideHandler);
                param1.modalWindow.addEventListener(MouseEvent.MOUSE_WHEEL, param1.mouseWheelOutsideHandler, true);
            }
            else
            {
                _loc_2.addEventListener(MouseEvent.MOUSE_DOWN, param1.mouseDownOutsideHandler);
                _loc_2.addEventListener(MouseEvent.MOUSE_WHEEL, param1.mouseWheelOutsideHandler, true);
            }
            _loc_2.addEventListener(SandboxMouseEvent.MOUSE_DOWN_SOMEWHERE, param1.marshalMouseOutsideHandler);
            _loc_2.addEventListener(SandboxMouseEvent.MOUSE_WHEEL_SOMEWHERE, param1.marshalMouseOutsideHandler, true);
            return;
        }// end function

        private function fadeInEffectEndHandler(event:EffectEvent) : void
        {
            var _loc_4:PopUpData = null;
            effectEndHandler(event);
            var _loc_2:* = popupInfo.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = popupInfo[_loc_3];
                if (_loc_4.owner && _loc_4.modalWindow == event.effectInstance.target)
                {
                    IUIComponent(_loc_4.owner).setVisible(true, true);
                    break;
                }
                _loc_3++;
            }
            return;
        }// end function

        private function hideModalWindowRequest(event:Event) : void
        {
            var _loc_2:SWFBridgeRequest = null;
            if (event is SWFBridgeRequest)
            {
                _loc_2 = SWFBridgeRequest(event);
            }
            else
            {
                _loc_2 = SWFBridgeRequest.marshal(event);
            }
            var _loc_3:* = getTopLevelSystemManager(DisplayObject(ApplicationGlobals.application));
            var _loc_4:* = _loc_3.getSandboxRoot();
            var _loc_5:* = findHighestRemoteModalPopupInfo();
            if (!findHighestRemoteModalPopupInfo() || _loc_5.owner || _loc_5.parent)
            {
                throw new Error();
            }
            hideModalWindow(_loc_5, _loc_2.data.remove);
            if (_loc_2.data.remove)
            {
                popupInfo.splice(popupInfo.indexOf(_loc_5), 1);
                var _loc_6:* = _loc_3;
                _loc_6.numModalWindows = _loc_3.numModalWindows--;
            }
            return;
        }// end function

        private function getTopLevelSystemManager(param1:DisplayObject) : ISystemManager
        {
            var _loc_2:DisplayObjectContainer = null;
            var _loc_3:ISystemManager = null;
            if (param1.parent is SystemManagerProxy)
            {
                _loc_2 = DisplayObjectContainer(SystemManagerProxy(param1.parent).systemManager);
            }
            else if (param1 is IUIComponent && IUIComponent(param1).systemManager is SystemManagerProxy)
            {
                _loc_2 = DisplayObjectContainer(SystemManagerProxy(IUIComponent(param1).systemManager).systemManager);
            }
            else
            {
                _loc_2 = DisplayObjectContainer(param1.root);
            }
            if (!_loc_2 || _loc_2 is Stage && param1 is IUIComponent)
            {
                _loc_2 = DisplayObjectContainer(IUIComponent(param1).systemManager);
            }
            if (_loc_2 is ISystemManager)
            {
                _loc_3 = ISystemManager(_loc_2);
                if (!_loc_3.isTopLevel())
                {
                    _loc_3 = _loc_3.topLevelSystemManager;
                }
            }
            return _loc_3;
        }// end function

        private function hideModalWindow(param1:PopUpData, param2:Boolean = false) : void
        {
            var _loc_6:Fade = null;
            var _loc_7:Number = NaN;
            var _loc_8:Blur = null;
            var _loc_9:DisplayObject = null;
            var _loc_10:SWFBridgeRequest = null;
            var _loc_11:IEventDispatcher = null;
            var _loc_12:IEventDispatcher = null;
            var _loc_13:InterManagerRequest = null;
            if (param2 && param1.exclude)
            {
                param1.exclude.removeEventListener(Event.RESIZE, param1.resizeHandler);
                param1.exclude.removeEventListener(MoveEvent.MOVE, param1.resizeHandler);
            }
            var _loc_3:* = param1.owner as IStyleClient;
            var _loc_4:Number = 0;
            if (_loc_3)
            {
                _loc_4 = _loc_3.getStyle("modalTransparencyDuration");
            }
            endEffects(param1);
            if (_loc_4)
            {
                _loc_6 = new Fade(param1.modalWindow);
                _loc_6.alphaFrom = param1.modalWindow.alpha;
                _loc_6.alphaTo = 0;
                _loc_6.duration = _loc_4;
                _loc_6.addEventListener(EffectEvent.EFFECT_END, param2 ? (fadeOutDestroyEffectEndHandler) : (fadeOutCloseEffectEndHandler));
                param1.modalWindow.visible = true;
                param1.fade = _loc_6;
                _loc_6.play();
                _loc_7 = _loc_3.getStyle("modalTransparencyBlur");
                if (_loc_7)
                {
                    _loc_8 = new Blur(param1.blurTarget);
                    var _loc_14:* = _loc_7;
                    _loc_8.blurYFrom = _loc_7;
                    new Blur(param1.blurTarget).blurXFrom = _loc_14;
                    var _loc_14:int = 0;
                    _loc_8.blurYTo = 0;
                    _loc_8.blurXTo = _loc_14;
                    _loc_8.duration = _loc_4;
                    _loc_8.addEventListener(EffectEvent.EFFECT_END, effectEndHandler);
                    param1.blur = _loc_8;
                    _loc_8.play();
                }
            }
            else
            {
                param1.modalWindow.visible = false;
            }
            var _loc_5:* = ISystemManager(ApplicationGlobals.application.systemManager);
            if (ISystemManager(ApplicationGlobals.application.systemManager).useSWFBridge())
            {
                _loc_9 = _loc_5.getSandboxRoot();
                if (!param1.isRemoteModalWindow && _loc_5 != _loc_9)
                {
                    _loc_13 = new InterManagerRequest(InterManagerRequest.SYSTEM_MANAGER_REQUEST, false, false, "isTopLevelRoot");
                    _loc_9.dispatchEvent(_loc_13);
                    if (Boolean(_loc_13.value))
                    {
                        return;
                    }
                }
                if (!param1.isRemoteModalWindow)
                {
                }
                _loc_10 = new SWFBridgeRequest(SWFBridgeRequest.HIDE_MODAL_WINDOW_REQUEST, false, false, null, {skip:_loc_5 != _loc_9, show:false, remove:param2});
                _loc_11 = _loc_5.swfBridgeGroup.parentBridge;
                _loc_10.requestor = _loc_11;
                _loc_11.dispatchEvent(_loc_10);
            }
            return;
        }// end function

        private function popupHideHandler(event:FlexEvent) : void
        {
            var _loc_2:* = findPopupInfoByOwner(event.target);
            if (_loc_2)
            {
                hideModalWindow(_loc_2);
            }
            return;
        }// end function

        private function showModalWindowInternal(param1:PopUpData, param2:Number, param3:Number, param4:Number, param5:Number, param6:ISystemManager, param7:DisplayObject) : void
        {
            var _loc_8:Fade = null;
            var _loc_9:Number = NaN;
            var _loc_10:Object = null;
            var _loc_11:Blur = null;
            var _loc_12:InterManagerRequest = null;
            endEffects(param1);
            if (param2)
            {
                _loc_8 = new Fade(param1.modalWindow);
                _loc_8.alphaFrom = 0;
                _loc_8.alphaTo = param3;
                _loc_8.duration = param2;
                _loc_8.addEventListener(EffectEvent.EFFECT_END, fadeInEffectEndHandler);
                param1.modalWindow.alpha = 0;
                param1.modalWindow.visible = true;
                param1.fade = _loc_8;
                if (param1.owner)
                {
                    IUIComponent(param1.owner).setVisible(false, true);
                }
                _loc_8.play();
                _loc_9 = param5;
                if (_loc_9)
                {
                    if (param6 != param7)
                    {
                        _loc_12 = new InterManagerRequest(InterManagerRequest.SYSTEM_MANAGER_REQUEST, false, false, "application", _loc_10);
                        param7.dispatchEvent(_loc_12);
                        param1.blurTarget = _loc_12.value;
                    }
                    else
                    {
                        param1.blurTarget = ApplicationGlobals.application;
                    }
                    _loc_11 = new Blur(param1.blurTarget);
                    var _loc_13:int = 0;
                    _loc_11.blurYFrom = 0;
                    new Blur(param1.blurTarget).blurXFrom = _loc_13;
                    var _loc_13:* = _loc_9;
                    _loc_11.blurYTo = _loc_9;
                    _loc_11.blurXTo = _loc_13;
                    _loc_11.duration = param2;
                    _loc_11.addEventListener(EffectEvent.EFFECT_END, effectEndHandler);
                    param1.blur = _loc_11;
                    _loc_11.play();
                }
            }
            else
            {
                if (param1.owner)
                {
                    IUIComponent(param1.owner).setVisible(true, true);
                }
                param1.modalWindow.visible = true;
            }
            return;
        }// end function

        private function effectEndHandler(event:EffectEvent) : void
        {
            var _loc_4:PopUpData = null;
            var _loc_5:IEffect = null;
            var _loc_2:* = popupInfo.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = popupInfo[_loc_3];
                _loc_5 = event.effectInstance.effect;
                if (_loc_5 == _loc_4.fade)
                {
                    _loc_4.fade = null;
                }
                else if (_loc_5 == _loc_4.blur)
                {
                    _loc_4.blur = null;
                }
                _loc_3++;
            }
            return;
        }// end function

        private function createModalWindow(param1:DisplayObject, param2:PopUpData, param3:IChildList, param4:Boolean, param5:ISystemManager, param6:DisplayObject) : void
        {
            var _loc_7:IFlexDisplayObject = null;
            var _loc_10:Sprite = null;
            var _loc_11:SystemManagerProxy = null;
            var _loc_12:ISystemManager = null;
            _loc_7 = IFlexDisplayObject(param2.owner);
            var _loc_8:* = _loc_7 as IStyleClient;
            var _loc_9:Number = 0;
            if (modalWindowClass)
            {
                _loc_10 = new modalWindowClass();
            }
            else
            {
                _loc_10 = new FlexSprite();
                _loc_10.name = "modalWindow";
            }
            if (!param5 && param1)
            {
                param5 = IUIComponent(param1).systemManager;
            }
            if (param5 is SystemManagerProxy)
            {
                _loc_11 = SystemManagerProxy(param5);
                _loc_12 = _loc_11.systemManager;
            }
            else
            {
                _loc_12 = param5;
            }
            var _loc_16:* = _loc_12;
            _loc_16.numModalWindows = _loc_12.numModalWindows++;
            if (_loc_7)
            {
                param3.addChildAt(_loc_10, param3.getChildIndex(DisplayObject(_loc_7)));
            }
            else
            {
                param3.addChild(_loc_10);
            }
            if (_loc_7 is IAutomationObject)
            {
                IAutomationObject(_loc_7).showInAutomationHierarchy = true;
            }
            if (!isNaN(param2.modalTransparency))
            {
                _loc_10.alpha = param2.modalTransparency;
            }
            else if (_loc_8)
            {
                _loc_10.alpha = _loc_8.getStyle("modalTransparency");
            }
            else
            {
                _loc_10.alpha = 0;
            }
            param2.modalTransparency = _loc_10.alpha;
            _loc_10.tabEnabled = false;
            var _loc_13:* = _loc_12.screen;
            var _loc_14:* = _loc_10.graphics;
            var _loc_15:Number = 16777215;
            if (!isNaN(param2.modalTransparencyColor))
            {
                _loc_15 = param2.modalTransparencyColor;
            }
            else if (_loc_8)
            {
                _loc_15 = _loc_8.getStyle("modalTransparencyColor");
                param2.modalTransparencyColor = _loc_15;
            }
            _loc_14.clear();
            _loc_14.beginFill(_loc_15, 100);
            _loc_14.drawRect(_loc_13.x, _loc_13.y, _loc_13.width, _loc_13.height);
            _loc_14.endFill();
            param2.modalWindow = _loc_10;
            if (param2.exclude)
            {
                param2.modalMask = new Sprite();
                updateModalMask(_loc_12, _loc_10, param2.useExclude ? (param2.exclude) : (null), param2.excludeRect, param2.modalMask);
                _loc_10.mask = param2.modalMask;
                param3.addChild(param2.modalMask);
                param2.exclude.addEventListener(Event.RESIZE, param2.resizeHandler);
                param2.exclude.addEventListener(MoveEvent.MOVE, param2.resizeHandler);
            }
            param2._mouseDownOutsideHandler = dispatchMouseDownOutsideEvent;
            param2._mouseWheelOutsideHandler = dispatchMouseWheelOutsideEvent;
            _loc_12.addEventListener(Event.RESIZE, param2.resizeHandler);
            if (_loc_7)
            {
                _loc_7.addEventListener(FlexEvent.SHOW, popupShowHandler);
                _loc_7.addEventListener(FlexEvent.HIDE, popupHideHandler);
            }
            if (param4)
            {
                showModalWindow(param2, param5, false);
            }
            else
            {
                _loc_7.visible = param4;
            }
            if (_loc_12.useSWFBridge())
            {
                if (_loc_8)
                {
                    param2.modalTransparencyDuration = _loc_8.getStyle("modalTransparencyDuration");
                    param2.modalTransparencyBlur = _loc_8.getStyle("modalTransparencyBlur");
                }
                dispatchModalWindowRequest(SWFBridgeRequest.CREATE_MODAL_WINDOW_REQUEST, _loc_12, param6, param2, param4);
            }
            return;
        }// end function

        private function findPopupInfoByOwner(param1:Object) : PopUpData
        {
            var _loc_4:PopUpData = null;
            var _loc_2:* = popupInfo.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = popupInfo[_loc_3];
                if (_loc_4.owner == param1)
                {
                    return _loc_4;
                }
                _loc_3++;
            }
            return null;
        }// end function

        private function popupRemovedHandler(event:Event) : void
        {
            var _loc_4:PopUpData = null;
            var _loc_5:DisplayObject = null;
            var _loc_6:DisplayObject = null;
            var _loc_7:DisplayObject = null;
            var _loc_8:ISystemManager = null;
            var _loc_9:ISystemManager = null;
            var _loc_10:IEventDispatcher = null;
            var _loc_11:SWFBridgeRequest = null;
            var _loc_2:* = popupInfo.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = popupInfo[_loc_3];
                _loc_5 = _loc_4.owner;
                if (_loc_5 == event.target)
                {
                    _loc_6 = _loc_4.parent;
                    _loc_7 = _loc_4.modalWindow;
                    _loc_8 = _loc_4.systemManager;
                    if (_loc_8 is SystemManagerProxy)
                    {
                        _loc_9 = SystemManagerProxy(_loc_8).systemManager;
                    }
                    else
                    {
                        _loc_9 = _loc_8;
                    }
                    if (!_loc_8.isTopLevel())
                    {
                        _loc_8 = _loc_8.topLevelSystemManager;
                    }
                    if (_loc_5 is IUIComponent)
                    {
                        IUIComponent(_loc_5).isPopUp = false;
                    }
                    if (_loc_5 is IFocusManagerContainer)
                    {
                        _loc_8.removeFocusManager(IFocusManagerContainer(_loc_5));
                    }
                    _loc_5.removeEventListener(Event.REMOVED, popupRemovedHandler);
                    if (_loc_8 is SystemManagerProxy)
                    {
                        _loc_10 = _loc_9.swfBridgeGroup.parentBridge;
                        _loc_11 = new SWFBridgeRequest(SWFBridgeRequest.REMOVE_POP_UP_REQUEST, false, false, _loc_10, {window:DisplayObject(_loc_8), parent:_loc_4.parent, modal:_loc_4.modalWindow != null});
                        _loc_9.getSandboxRoot().dispatchEvent(_loc_11);
                    }
                    else if (_loc_8.useSWFBridge())
                    {
                        _loc_11 = new SWFBridgeRequest(SWFBridgeRequest.REMOVE_POP_UP_PLACE_HOLDER_REQUEST, false, false, null, {window:DisplayObject(_loc_5)});
                        _loc_11.requestor = _loc_8.swfBridgeGroup.parentBridge;
                        _loc_11.data.placeHolderId = NameUtil.displayObjectToString(DisplayObject(_loc_5));
                        _loc_8.dispatchEvent(_loc_11);
                    }
                    if (_loc_4.owner)
                    {
                        _loc_4.owner.removeEventListener(FlexEvent.SHOW, showOwnerHandler);
                        _loc_4.owner.removeEventListener(FlexEvent.HIDE, hideOwnerHandler);
                    }
                    removeMouseOutEventListeners(_loc_4);
                    if (_loc_7)
                    {
                        _loc_9.removeEventListener(Event.RESIZE, _loc_4.resizeHandler);
                        _loc_5.removeEventListener(FlexEvent.SHOW, popupShowHandler);
                        _loc_5.removeEventListener(FlexEvent.HIDE, popupHideHandler);
                        hideModalWindow(_loc_4, true);
                        var _loc_12:* = _loc_9;
                        _loc_12.numModalWindows = _loc_9.numModalWindows--;
                    }
                    popupInfo.splice(_loc_3, 1);
                    break;
                }
                _loc_3++;
            }
            return;
        }// end function

        private function fadeOutCloseEffectEndHandler(event:EffectEvent) : void
        {
            effectEndHandler(event);
            DisplayObject(event.effectInstance.target).visible = false;
            return;
        }// end function

        private function endEffects(param1:PopUpData) : void
        {
            if (param1.fade)
            {
                param1.fade.end();
                param1.fade = null;
            }
            if (param1.blur)
            {
                param1.blur.end();
                param1.blur = null;
            }
            return;
        }// end function

        public function removePopUp(param1:IFlexDisplayObject) : void
        {
            var _loc_2:PopUpData = null;
            var _loc_3:ISystemManager = null;
            var _loc_4:IUIComponent = null;
            if (param1 && param1.parent)
            {
                _loc_2 = findPopupInfoByOwner(param1);
                if (_loc_2)
                {
                    _loc_3 = _loc_2.systemManager;
                    if (!_loc_3)
                    {
                        _loc_4 = param1 as IUIComponent;
                        if (_loc_4)
                        {
                            _loc_3 = ISystemManager(_loc_4.systemManager);
                        }
                        else
                        {
                            return;
                        }
                    }
                    if (_loc_2.topMost)
                    {
                        _loc_3.popUpChildren.removeChild(DisplayObject(param1));
                    }
                    else
                    {
                        _loc_3.removeChild(DisplayObject(param1));
                    }
                }
            }
            return;
        }// end function

        public function addPopUp(param1:IFlexDisplayObject, param2:DisplayObject, param3:Boolean = false, param4:String = null) : void
        {
            var _loc_7:IChildList = null;
            var _loc_8:Boolean = false;
            var _loc_5:* = param1.visible;
            if (param2 is IUIComponent && param1 is IUIComponent && IUIComponent(param1).document == null)
            {
                IUIComponent(param1).document = IUIComponent(param2).document;
            }
            if (param2 is IUIComponent && IUIComponent(param2).document is IFlexModule && param1 is UIComponent && UIComponent(param1).moduleFactory == null)
            {
                UIComponent(param1).moduleFactory = IFlexModule(IUIComponent(param2).document).moduleFactory;
            }
            var _loc_6:* = getTopLevelSystemManager(param2);
            if (!getTopLevelSystemManager(param2))
            {
                _loc_6 = ISystemManager(SystemManagerGlobals.topLevelSystemManagers[0]);
                if (_loc_6.getSandboxRoot() != param2)
                {
                    return;
                }
            }
            var _loc_9:* = _loc_6;
            var _loc_10:* = _loc_6.getSandboxRoot();
            var _loc_11:SWFBridgeRequest = null;
            if (_loc_6.useSWFBridge())
            {
                if (_loc_10 != _loc_6)
                {
                    _loc_9 = new SystemManagerProxy(_loc_6);
                    _loc_11 = new SWFBridgeRequest(SWFBridgeRequest.ADD_POP_UP_REQUEST, false, false, _loc_6.swfBridgeGroup.parentBridge, {window:DisplayObject(_loc_9), parent:param2, modal:param3, childList:param4});
                    _loc_10.dispatchEvent(_loc_11);
                }
                else
                {
                    _loc_9 = _loc_6;
                }
            }
            if (param1 is IUIComponent)
            {
                IUIComponent(param1).isPopUp = true;
            }
            if (!param4 || param4 == PopUpManagerChildList.PARENT)
            {
                _loc_8 = _loc_9.popUpChildren.contains(param2);
            }
            else
            {
                _loc_8 = param4 == PopUpManagerChildList.POPUP;
            }
            _loc_7 = _loc_8 ? (_loc_9.popUpChildren) : (_loc_9);
            _loc_7.addChild(DisplayObject(param1));
            param1.visible = false;
            if (!popupInfo)
            {
                popupInfo = [];
            }
            var _loc_12:* = new PopUpData();
            new PopUpData().owner = DisplayObject(param1);
            _loc_12.topMost = _loc_8;
            _loc_12.systemManager = _loc_9;
            popupInfo.push(_loc_12);
            if (param1 is IFocusManagerContainer)
            {
                if (IFocusManagerContainer(param1).focusManager)
                {
                    _loc_9.addFocusManager(IFocusManagerContainer(param1));
                }
                else
                {
                    IFocusManagerContainer(param1).focusManager = new FocusManager(IFocusManagerContainer(param1), true);
                }
            }
            if (!_loc_6.isTopLevelRoot() && _loc_10 && _loc_6 == _loc_10)
            {
                _loc_11 = new SWFBridgeRequest(SWFBridgeRequest.ADD_POP_UP_PLACE_HOLDER_REQUEST, false, false, null, {window:DisplayObject(param1)});
                _loc_11.requestor = _loc_6.swfBridgeGroup.parentBridge;
                _loc_11.data.placeHolderId = NameUtil.displayObjectToString(DisplayObject(param1));
                _loc_6.dispatchEvent(_loc_11);
            }
            if (param1 is IAutomationObject)
            {
                IAutomationObject(param1).showInAutomationHierarchy = true;
            }
            if (param1 is ILayoutManagerClient)
            {
                UIComponentGlobals.layoutManager.validateClient(ILayoutManagerClient(param1), true);
            }
            _loc_12.parent = param2;
            if (param1 is IUIComponent)
            {
                IUIComponent(param1).setActualSize(IUIComponent(param1).getExplicitOrMeasuredWidth(), IUIComponent(param1).getExplicitOrMeasuredHeight());
            }
            if (param3)
            {
                createModalWindow(param2, _loc_12, _loc_7, _loc_5, _loc_9, _loc_10);
            }
            else
            {
                _loc_12._mouseDownOutsideHandler = nonmodalMouseDownOutsideHandler;
                _loc_12._mouseWheelOutsideHandler = nonmodalMouseWheelOutsideHandler;
                param1.visible = _loc_5;
            }
            _loc_12.owner.addEventListener(FlexEvent.SHOW, showOwnerHandler);
            _loc_12.owner.addEventListener(FlexEvent.HIDE, hideOwnerHandler);
            addMouseOutEventListeners(_loc_12);
            param1.addEventListener(Event.REMOVED, popupRemovedHandler);
            if (param1 is IFocusManagerContainer && _loc_5)
            {
                if (!(_loc_9 is SystemManagerProxy) && _loc_9.useSWFBridge())
                {
                    SystemManager(_loc_9).dispatchActivatedWindowEvent(DisplayObject(param1));
                }
                else
                {
                    _loc_9.activate(IFocusManagerContainer(param1));
                }
            }
            return;
        }// end function

        private function dispatchModalWindowRequest(param1:String, param2:ISystemManager, param3:DisplayObject, param4:PopUpData, param5:Boolean) : void
        {
            var _loc_8:InterManagerRequest = null;
            if (!param4.isRemoteModalWindow && param2 != param3)
            {
                _loc_8 = new InterManagerRequest(InterManagerRequest.SYSTEM_MANAGER_REQUEST, false, false, "isTopLevelRoot");
                param3.dispatchEvent(_loc_8);
                if (Boolean(_loc_8.value))
                {
                    return;
                }
            }
            if (!param4.isRemoteModalWindow)
            {
            }
            var _loc_6:* = new SWFBridgeRequest(param1, false, false, null, {skip:param2 != param3, useExclude:param4.useExclude, show:param5, remove:false, transparencyDuration:param4.modalTransparencyDuration, transparency:param4.modalTransparency, transparencyColor:param4.modalTransparencyColor, transparencyBlur:param4.modalTransparencyBlur});
            var _loc_7:* = param2.swfBridgeGroup.parentBridge;
            _loc_6.requestor = _loc_7;
            _loc_7.dispatchEvent(_loc_6);
            return;
        }// end function

        public function createPopUp(param1:DisplayObject, param2:Class, param3:Boolean = false, param4:String = null) : IFlexDisplayObject
        {
            var _loc_5:* = new param2;
            addPopUp(_loc_5, param1, param3, param4);
            return _loc_5;
        }// end function

        private function removeMouseOutEventListeners(param1:PopUpData) : void
        {
            var _loc_2:* = param1.systemManager.getSandboxRoot();
            if (param1.modalWindow)
            {
                param1.modalWindow.removeEventListener(MouseEvent.MOUSE_DOWN, param1.mouseDownOutsideHandler);
                param1.modalWindow.removeEventListener(MouseEvent.MOUSE_WHEEL, param1.mouseWheelOutsideHandler, true);
            }
            else
            {
                _loc_2.removeEventListener(MouseEvent.MOUSE_DOWN, param1.mouseDownOutsideHandler);
                _loc_2.removeEventListener(MouseEvent.MOUSE_WHEEL, param1.mouseWheelOutsideHandler, true);
            }
            _loc_2.removeEventListener(SandboxMouseEvent.MOUSE_DOWN_SOMEWHERE, param1.marshalMouseOutsideHandler);
            _loc_2.removeEventListener(SandboxMouseEvent.MOUSE_WHEEL_SOMEWHERE, param1.marshalMouseOutsideHandler, true);
            return;
        }// end function

        private function findHighestRemoteModalPopupInfo() : PopUpData
        {
            var _loc_3:PopUpData = null;
            while (_loc_2-- >= 0)
            {
                
                _loc_3 = popupInfo[popupInfo.length--];
                if (_loc_3.isRemoteModalWindow)
                {
                    return _loc_3;
                }
            }
            return null;
        }// end function

        private static function nonmodalMouseWheelOutsideHandler(param1:DisplayObject, param2:MouseEvent) : void
        {
            if (param1.hitTestPoint(param2.stageX, param2.stageY, true))
            {
            }
            else
            {
                if (param1 is IUIComponent)
                {
                    if (IUIComponent(param1).owns(DisplayObject(param2.target)))
                    {
                        return;
                    }
                }
                dispatchMouseWheelOutsideEvent(param1, param2);
            }
            return;
        }// end function

        private static function dispatchMouseWheelOutsideEvent(param1:DisplayObject, param2:MouseEvent) : void
        {
            if (!param1)
            {
                return;
            }
            var _loc_3:* = new FlexMouseEvent(FlexMouseEvent.MOUSE_WHEEL_OUTSIDE);
            var _loc_4:* = param1.globalToLocal(new Point(param2.stageX, param2.stageY));
            _loc_3.localX = _loc_4.x;
            _loc_3.localY = _loc_4.y;
            _loc_3.buttonDown = param2.buttonDown;
            _loc_3.shiftKey = param2.shiftKey;
            _loc_3.altKey = param2.altKey;
            _loc_3.ctrlKey = param2.ctrlKey;
            _loc_3.delta = param2.delta;
            _loc_3.relatedObject = InteractiveObject(param2.target);
            param1.dispatchEvent(_loc_3);
            return;
        }// end function

        static function updateModalMask(param1:ISystemManager, param2:DisplayObject, param3:IUIComponent, param4:Rectangle, param5:Sprite) : void
        {
            var _loc_7:Rectangle = null;
            var _loc_8:Point = null;
            var _loc_9:Rectangle = null;
            var _loc_6:* = param2.getBounds(DisplayObject(param1));
            if (param3 is ISWFLoader)
            {
                _loc_7 = ISWFLoader(param3).mx.core:ISWFLoader::getVisibleApplicationRect();
                _loc_8 = new Point(_loc_7.x, _loc_7.y);
                _loc_8 = DisplayObject(param1).globalToLocal(_loc_8);
                _loc_7.x = _loc_8.x;
                _loc_7.y = _loc_8.y;
            }
            else if (!param3)
            {
                _loc_7 = _loc_6.clone();
            }
            else
            {
                _loc_7 = DisplayObject(param3).getBounds(DisplayObject(param1));
            }
            if (param4)
            {
                _loc_8 = new Point(param4.x, param4.y);
                _loc_8 = DisplayObject(param1).globalToLocal(_loc_8);
                _loc_9 = new Rectangle(_loc_8.x, _loc_8.y, param4.width, param4.height);
                _loc_7 = _loc_7.intersection(_loc_9);
            }
            param5.graphics.clear();
            param5.graphics.beginFill(0);
            if (_loc_7.y > _loc_6.y)
            {
                param5.graphics.drawRect(_loc_6.x, _loc_6.y, _loc_6.width, _loc_7.y - _loc_6.y);
            }
            if (_loc_6.x < _loc_7.x)
            {
                param5.graphics.drawRect(_loc_6.x, _loc_7.y, _loc_7.x - _loc_6.x, _loc_7.height);
            }
            if (_loc_6.x + _loc_6.width > _loc_7.x + _loc_7.width)
            {
                param5.graphics.drawRect(_loc_7.x + _loc_7.width, _loc_7.y, _loc_6.x + _loc_6.width - _loc_7.x - _loc_7.width, _loc_7.height);
            }
            if (_loc_7.y + _loc_7.height < _loc_6.y + _loc_6.height)
            {
                param5.graphics.drawRect(_loc_6.x, _loc_7.y + _loc_7.height, _loc_6.width, _loc_6.y + _loc_6.height - _loc_7.y - _loc_7.height);
            }
            param5.graphics.endFill();
            return;
        }// end function

        private static function dispatchMouseDownOutsideEvent(param1:DisplayObject, param2:MouseEvent) : void
        {
            if (!param1)
            {
                return;
            }
            var _loc_3:* = new FlexMouseEvent(FlexMouseEvent.MOUSE_DOWN_OUTSIDE);
            var _loc_4:* = param1.globalToLocal(new Point(param2.stageX, param2.stageY));
            _loc_3.localX = _loc_4.x;
            _loc_3.localY = _loc_4.y;
            _loc_3.buttonDown = param2.buttonDown;
            _loc_3.shiftKey = param2.shiftKey;
            _loc_3.altKey = param2.altKey;
            _loc_3.ctrlKey = param2.ctrlKey;
            _loc_3.delta = param2.delta;
            _loc_3.relatedObject = InteractiveObject(param2.target);
            param1.dispatchEvent(_loc_3);
            return;
        }// end function

        public static function getInstance() : IPopUpManager
        {
            if (!instance)
            {
                instance = new PopUpManagerImpl;
            }
            return instance;
        }// end function

        private static function nonmodalMouseDownOutsideHandler(param1:DisplayObject, param2:MouseEvent) : void
        {
            if (param1.hitTestPoint(param2.stageX, param2.stageY, true))
            {
            }
            else
            {
                if (param1 is IUIComponent)
                {
                    if (IUIComponent(param1).owns(DisplayObject(param2.target)))
                    {
                        return;
                    }
                }
                dispatchMouseDownOutsideEvent(param1, param2);
            }
            return;
        }// end function

    }
}
