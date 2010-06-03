package mx.core
{
    import flash.events.*;
    import flash.utils.*;
    import mx.managers.*;

    public class SWFBridgeGroup extends Object implements ISWFBridgeGroup
    {
        private var _parentBridge:IEventDispatcher;
        private var _childBridges:Dictionary;
        private var _groupOwner:ISystemManager;
        static const VERSION:String = "3.2.0.3958";

        public function SWFBridgeGroup(param1:ISystemManager)
        {
            _groupOwner = param1;
            return;
        }// end function

        public function getChildBridgeProvider(param1:IEventDispatcher) : ISWFBridgeProvider
        {
            if (!_childBridges)
            {
                return null;
            }
            return ISWFBridgeProvider(_childBridges[param1]);
        }// end function

        public function removeChildBridge(param1:IEventDispatcher) : void
        {
            var _loc_2:Object = null;
            if (!_childBridges || !param1)
            {
                return;
            }
            for (_loc_2 in _childBridges)
            {
                
                if (_loc_2 == param1)
                {
                    delete _childBridges[_loc_2];
                }
            }
            return;
        }// end function

        public function get parentBridge() : IEventDispatcher
        {
            return _parentBridge;
        }// end function

        public function containsBridge(param1:IEventDispatcher) : Boolean
        {
            var _loc_2:Object = null;
            if (parentBridge && parentBridge == param1)
            {
                return true;
            }
            for (_loc_2 in _childBridges)
            {
                
                if (param1 == _loc_2)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function set parentBridge(param1:IEventDispatcher) : void
        {
            _parentBridge = param1;
            return;
        }// end function

        public function addChildBridge(param1:IEventDispatcher, param2:ISWFBridgeProvider) : void
        {
            if (!_childBridges)
            {
                _childBridges = new Dictionary();
            }
            _childBridges[param1] = param2;
            return;
        }// end function

        public function getChildBridges() : Array
        {
            var _loc_2:Object = null;
            var _loc_1:Array = [];
            for (_loc_2 in _childBridges)
            {
                
                _loc_1.push(_loc_2);
            }
            return _loc_1;
        }// end function

    }
}
