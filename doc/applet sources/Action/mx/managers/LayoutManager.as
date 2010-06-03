package mx.managers
{
    import flash.events.*;
    import mx.core.*;
    import mx.events.*;
    import mx.managers.layoutClasses.*;

    public class LayoutManager extends EventDispatcher implements ILayoutManager
    {
        private var invalidateClientPropertiesFlag:Boolean = false;
        private var invalidateDisplayListQueue:PriorityQueue;
        private var updateCompleteQueue:PriorityQueue;
        private var invalidateDisplayListFlag:Boolean = false;
        private var invalidateClientSizeFlag:Boolean = false;
        private var invalidateSizeQueue:PriorityQueue;
        private var originalFrameRate:Number;
        private var invalidatePropertiesFlag:Boolean = false;
        private var invalidatePropertiesQueue:PriorityQueue;
        private var invalidateSizeFlag:Boolean = false;
        private var callLaterPending:Boolean = false;
        private var _usePhasedInstantiation:Boolean = false;
        private var callLaterObject:UIComponent;
        private var targetLevel:int = 2.14748e+009;
        static const VERSION:String = "3.2.0.3958";
        private static var instance:LayoutManager;

        public function LayoutManager()
        {
            updateCompleteQueue = new PriorityQueue();
            invalidatePropertiesQueue = new PriorityQueue();
            invalidateSizeQueue = new PriorityQueue();
            invalidateDisplayListQueue = new PriorityQueue();
            return;
        }// end function

        public function set usePhasedInstantiation(param1:Boolean) : void
        {
            var sm:ISystemManager;
            var stage:Stage;
            var value:* = param1;
            if (_usePhasedInstantiation != value)
            {
                _usePhasedInstantiation = value;
                try
                {
                    sm = SystemManagerGlobals.topLevelSystemManagers[0];
                    stage = SystemManagerGlobals.topLevelSystemManagers[0].stage;
                    if (stage)
                    {
                        if (value)
                        {
                            originalFrameRate = stage.frameRate;
                            stage.frameRate = 1000;
                        }
                        else
                        {
                            stage.frameRate = originalFrameRate;
                        }
                    }
                }
                catch (e:SecurityError)
                {
                }
            }
            return;
        }// end function

        private function waitAFrame() : void
        {
            callLaterObject.callLater(doPhasedInstantiation);
            return;
        }// end function

        public function validateClient(param1:ILayoutManagerClient, param2:Boolean = false) : void
        {
            var _loc_3:ILayoutManagerClient = null;
            var _loc_4:int = 0;
            var _loc_5:Boolean = false;
            var _loc_6:* = targetLevel;
            if (targetLevel == int.MAX_VALUE)
            {
                targetLevel = param1.nestLevel;
            }
            while (!_loc_5)
            {
                
                _loc_5 = true;
                _loc_3 = ILayoutManagerClient(invalidatePropertiesQueue.removeSmallestChild(param1));
                while (_loc_3)
                {
                    
                    _loc_3.validateProperties();
                    if (!_loc_3.updateCompletePendingFlag)
                    {
                        updateCompleteQueue.addObject(_loc_3, _loc_3.nestLevel);
                        _loc_3.updateCompletePendingFlag = true;
                    }
                    _loc_3 = ILayoutManagerClient(invalidatePropertiesQueue.removeSmallestChild(param1));
                }
                if (invalidatePropertiesQueue.isEmpty())
                {
                    invalidatePropertiesFlag = false;
                    invalidateClientPropertiesFlag = false;
                }
                _loc_3 = ILayoutManagerClient(invalidateSizeQueue.removeLargestChild(param1));
                while (_loc_3)
                {
                    
                    _loc_3.validateSize();
                    if (!_loc_3.updateCompletePendingFlag)
                    {
                        updateCompleteQueue.addObject(_loc_3, _loc_3.nestLevel);
                        _loc_3.updateCompletePendingFlag = true;
                    }
                    if (invalidateClientPropertiesFlag)
                    {
                        _loc_3 = ILayoutManagerClient(invalidatePropertiesQueue.removeSmallestChild(param1));
                        if (_loc_3)
                        {
                            invalidatePropertiesQueue.addObject(_loc_3, _loc_3.nestLevel);
                            _loc_5 = false;
                            break;
                        }
                    }
                    _loc_3 = ILayoutManagerClient(invalidateSizeQueue.removeLargestChild(param1));
                }
                if (invalidateSizeQueue.isEmpty())
                {
                    invalidateSizeFlag = false;
                    invalidateClientSizeFlag = false;
                }
                if (!param2)
                {
                    _loc_3 = ILayoutManagerClient(invalidateDisplayListQueue.removeSmallestChild(param1));
                    while (_loc_3)
                    {
                        
                        _loc_3.validateDisplayList();
                        if (!_loc_3.updateCompletePendingFlag)
                        {
                            updateCompleteQueue.addObject(_loc_3, _loc_3.nestLevel);
                            _loc_3.updateCompletePendingFlag = true;
                        }
                        if (invalidateClientPropertiesFlag)
                        {
                            _loc_3 = ILayoutManagerClient(invalidatePropertiesQueue.removeSmallestChild(param1));
                            if (_loc_3)
                            {
                                invalidatePropertiesQueue.addObject(_loc_3, _loc_3.nestLevel);
                                _loc_5 = false;
                                break;
                            }
                        }
                        if (invalidateClientSizeFlag)
                        {
                            _loc_3 = ILayoutManagerClient(invalidateSizeQueue.removeLargestChild(param1));
                            if (_loc_3)
                            {
                                invalidateSizeQueue.addObject(_loc_3, _loc_3.nestLevel);
                                _loc_5 = false;
                                break;
                            }
                        }
                        _loc_3 = ILayoutManagerClient(invalidateDisplayListQueue.removeSmallestChild(param1));
                    }
                    if (invalidateDisplayListQueue.isEmpty())
                    {
                        invalidateDisplayListFlag = false;
                    }
                }
            }
            if (_loc_6 == int.MAX_VALUE)
            {
                targetLevel = int.MAX_VALUE;
                if (!param2)
                {
                    _loc_3 = ILayoutManagerClient(updateCompleteQueue.removeLargestChild(param1));
                    while (_loc_3)
                    {
                        
                        if (!_loc_3.initialized)
                        {
                            _loc_3.initialized = true;
                        }
                        _loc_3.dispatchEvent(new FlexEvent(FlexEvent.UPDATE_COMPLETE));
                        _loc_3.updateCompletePendingFlag = false;
                        _loc_3 = ILayoutManagerClient(updateCompleteQueue.removeLargestChild(param1));
                    }
                }
            }
            return;
        }// end function

        private function validateProperties() : void
        {
            var _loc_1:* = ILayoutManagerClient(invalidatePropertiesQueue.removeSmallest());
            while (_loc_1)
            {
                
                _loc_1.validateProperties();
                if (!_loc_1.updateCompletePendingFlag)
                {
                    updateCompleteQueue.addObject(_loc_1, _loc_1.nestLevel);
                    _loc_1.updateCompletePendingFlag = true;
                }
                _loc_1 = ILayoutManagerClient(invalidatePropertiesQueue.removeSmallest());
            }
            if (invalidatePropertiesQueue.isEmpty())
            {
                invalidatePropertiesFlag = false;
            }
            return;
        }// end function

        public function invalidateProperties(param1:ILayoutManagerClient) : void
        {
            if (!invalidatePropertiesFlag && ApplicationGlobals.application.systemManager)
            {
                invalidatePropertiesFlag = true;
                if (!callLaterPending)
                {
                    if (!callLaterObject)
                    {
                        callLaterObject = new UIComponent();
                        callLaterObject.systemManager = ApplicationGlobals.application.systemManager;
                        callLaterObject.callLater(waitAFrame);
                    }
                    else
                    {
                        callLaterObject.callLater(doPhasedInstantiation);
                    }
                    callLaterPending = true;
                }
            }
            if (targetLevel <= param1.nestLevel)
            {
                invalidateClientPropertiesFlag = true;
            }
            invalidatePropertiesQueue.addObject(param1, param1.nestLevel);
            return;
        }// end function

        public function invalidateDisplayList(param1:ILayoutManagerClient) : void
        {
            if (!invalidateDisplayListFlag && ApplicationGlobals.application.systemManager)
            {
                invalidateDisplayListFlag = true;
                if (!callLaterPending)
                {
                    if (!callLaterObject)
                    {
                        callLaterObject = new UIComponent();
                        callLaterObject.systemManager = ApplicationGlobals.application.systemManager;
                        callLaterObject.callLater(waitAFrame);
                    }
                    else
                    {
                        callLaterObject.callLater(doPhasedInstantiation);
                    }
                    callLaterPending = true;
                }
            }
            else if (!invalidateDisplayListFlag && !ApplicationGlobals.application.systemManager)
            {
            }
            invalidateDisplayListQueue.addObject(param1, param1.nestLevel);
            return;
        }// end function

        private function validateDisplayList() : void
        {
            var _loc_1:* = ILayoutManagerClient(invalidateDisplayListQueue.removeSmallest());
            while (_loc_1)
            {
                
                _loc_1.validateDisplayList();
                if (!_loc_1.updateCompletePendingFlag)
                {
                    updateCompleteQueue.addObject(_loc_1, _loc_1.nestLevel);
                    _loc_1.updateCompletePendingFlag = true;
                }
                _loc_1 = ILayoutManagerClient(invalidateDisplayListQueue.removeSmallest());
            }
            if (invalidateDisplayListQueue.isEmpty())
            {
                invalidateDisplayListFlag = false;
            }
            return;
        }// end function

        public function validateNow() : void
        {
            var _loc_1:int = 0;
            if (!usePhasedInstantiation)
            {
                _loc_1 = 0;
                while (callLaterPending && _loc_1++ < 100)
                {
                    
                    doPhasedInstantiation();
                }
            }
            return;
        }// end function

        private function validateSize() : void
        {
            var _loc_1:* = ILayoutManagerClient(invalidateSizeQueue.removeLargest());
            while (_loc_1)
            {
                
                _loc_1.validateSize();
                if (!_loc_1.updateCompletePendingFlag)
                {
                    updateCompleteQueue.addObject(_loc_1, _loc_1.nestLevel);
                    _loc_1.updateCompletePendingFlag = true;
                }
                _loc_1 = ILayoutManagerClient(invalidateSizeQueue.removeLargest());
            }
            if (invalidateSizeQueue.isEmpty())
            {
                invalidateSizeFlag = false;
            }
            return;
        }// end function

        private function doPhasedInstantiation() : void
        {
            var _loc_1:ILayoutManagerClient = null;
            if (usePhasedInstantiation)
            {
                if (invalidatePropertiesFlag)
                {
                    validateProperties();
                    ApplicationGlobals.application.dispatchEvent(new Event("validatePropertiesComplete"));
                }
                else if (invalidateSizeFlag)
                {
                    validateSize();
                    ApplicationGlobals.application.dispatchEvent(new Event("validateSizeComplete"));
                }
                else if (invalidateDisplayListFlag)
                {
                    validateDisplayList();
                    ApplicationGlobals.application.dispatchEvent(new Event("validateDisplayListComplete"));
                }
            }
            else
            {
                if (invalidatePropertiesFlag)
                {
                    validateProperties();
                }
                if (invalidateSizeFlag)
                {
                    validateSize();
                }
                if (invalidateDisplayListFlag)
                {
                    validateDisplayList();
                }
            }
            if (invalidatePropertiesFlag || invalidateSizeFlag || invalidateDisplayListFlag)
            {
                callLaterObject.callLater(doPhasedInstantiation);
            }
            else
            {
                usePhasedInstantiation = false;
                callLaterPending = false;
                _loc_1 = ILayoutManagerClient(updateCompleteQueue.removeLargest());
                while (_loc_1)
                {
                    
                    if (!_loc_1.initialized && _loc_1.processedDescriptors)
                    {
                        _loc_1.initialized = true;
                    }
                    _loc_1.dispatchEvent(new FlexEvent(FlexEvent.UPDATE_COMPLETE));
                    _loc_1.updateCompletePendingFlag = false;
                    _loc_1 = ILayoutManagerClient(updateCompleteQueue.removeLargest());
                }
                dispatchEvent(new FlexEvent(FlexEvent.UPDATE_COMPLETE));
            }
            return;
        }// end function

        public function isInvalid() : Boolean
        {
            if (!(invalidatePropertiesFlag || invalidateSizeFlag))
            {
            }
            return invalidateDisplayListFlag;
        }// end function

        public function get usePhasedInstantiation() : Boolean
        {
            return _usePhasedInstantiation;
        }// end function

        public function invalidateSize(param1:ILayoutManagerClient) : void
        {
            if (!invalidateSizeFlag && ApplicationGlobals.application.systemManager)
            {
                invalidateSizeFlag = true;
                if (!callLaterPending)
                {
                    if (!callLaterObject)
                    {
                        callLaterObject = new UIComponent();
                        callLaterObject.systemManager = ApplicationGlobals.application.systemManager;
                        callLaterObject.callLater(waitAFrame);
                    }
                    else
                    {
                        callLaterObject.callLater(doPhasedInstantiation);
                    }
                    callLaterPending = true;
                }
            }
            if (targetLevel <= param1.nestLevel)
            {
                invalidateClientSizeFlag = true;
            }
            invalidateSizeQueue.addObject(param1, param1.nestLevel);
            return;
        }// end function

        public static function getInstance() : LayoutManager
        {
            if (!instance)
            {
                instance = new LayoutManager;
            }
            return instance;
        }// end function

    }
}
