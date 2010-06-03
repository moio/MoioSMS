package 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import mx.core.*;
    import mx.effects.*;
    import mx.events.*;
    import mx.managers.*;

    private class PopUpData extends Object
    {
        public var fade:Effect;
        public var modalTransparencyColor:Number;
        public var exclude:IUIComponent;
        public var isRemoteModalWindow:Boolean;
        public var useExclude:Boolean;
        public var blurTarget:Object;
        public var modalTransparencyDuration:Number;
        public var _mouseWheelOutsideHandler:Function;
        public var excludeRect:Rectangle;
        public var modalTransparency:Number;
        public var blur:Effect;
        public var parent:DisplayObject;
        public var modalTransparencyBlur:Number;
        public var _mouseDownOutsideHandler:Function;
        public var owner:DisplayObject;
        public var topMost:Boolean;
        public var modalMask:Sprite;
        public var modalWindow:DisplayObject;
        public var systemManager:ISystemManager;

        private function PopUpData()
        {
            useExclude = true;
            return;
        }// end function

        public function marshalMouseOutsideHandler(event:Event) : void
        {
            if (!(event is SandboxMouseEvent))
            {
                event = SandboxMouseEvent.marshal(event);
            }
            if (owner)
            {
                owner.dispatchEvent(event);
            }
            return;
        }// end function

        public function mouseDownOutsideHandler(event:MouseEvent) : void
        {
            _mouseDownOutsideHandler(owner, event);
            return;
        }// end function

        public function mouseWheelOutsideHandler(event:MouseEvent) : void
        {
            _mouseWheelOutsideHandler(owner, event);
            return;
        }// end function

        public function resizeHandler(event:Event) : void
        {
            var _loc_2:Rectangle = null;
            if (owner && owner.stage == DisplayObject(event.target).stage || modalWindow && modalWindow.stage == DisplayObject(event.target).stage)
            {
                _loc_2 = systemManager.screen;
                modalWindow.width = _loc_2.width;
                modalWindow.height = _loc_2.height;
                modalWindow.x = _loc_2.x;
                modalWindow.y = _loc_2.y;
                if (modalMask)
                {
                    PopUpManagerImpl.updateModalMask(systemManager, modalWindow, exclude, excludeRect, modalMask);
                }
            }
            return;
        }// end function

    }
}
