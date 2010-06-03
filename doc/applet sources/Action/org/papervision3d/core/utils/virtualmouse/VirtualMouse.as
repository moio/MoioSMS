package org.papervision3d.core.utils.virtualmouse
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import org.papervision3d.core.log.*;

    public class VirtualMouse extends EventDispatcher
    {
        private var _container:Sprite;
        private var _stage:Stage;
        private var lastDownTarget:DisplayObject;
        private var target:InteractiveObject;
        private var updateMouseDown:Boolean = false;
        private var eventEvent:Class;
        private var _lastEvent:Event;
        private var mouseEventEvent:Class;
        private var location:Point;
        private var delta:int = 0;
        private var disabledEvents:Object;
        private var ignoredInstances:Dictionary;
        private var isLocked:Boolean = false;
        private var lastWithinStage:Boolean = true;
        private var lastLocation:Point;
        private var isDoubleClickEvent:Boolean = false;
        private var lastMouseDown:Boolean = false;
        private var ctrlKey:Boolean = false;
        private var altKey:Boolean = false;
        private var _useNativeEvents:Boolean = false;
        private var shiftKey:Boolean = false;
        public static const UPDATE:String = "update";
        private static var _mouseIsDown:Boolean = false;

        public function VirtualMouse(param1:Stage = null, param2:Sprite = null, param3:Number = 0, param4:Number = 0)
        {
            this.disabledEvents = new Object();
            this.ignoredInstances = new Dictionary(true);
            this.eventEvent = VirtualMouseEvent;
            this.mouseEventEvent = VirtualMouseMouseEvent;
            this.stage = param1;
            this.container = param2;
            this.location = new Point(param3, param4);
            this.lastLocation = this.location.clone();
            addEventListener(UPDATE, this.handleUpdate);
            this.update();
            return;
        }// end function

        public function get mouseIsDown() : Boolean
        {
            return _mouseIsDown;
        }// end function

        public function get container() : Sprite
        {
            return this._container;
        }// end function

        public function exitContainer() : void
        {
            if (!this.container)
            {
                return;
            }
            var _loc_1:* = this.target.globalToLocal(this.location);
            if (!this.disabledEvents[MouseEvent.MOUSE_OUT])
            {
                this._lastEvent = new this.mouseEventEvent(MouseEvent.MOUSE_OUT, true, false, _loc_1.x, _loc_1.y, this.container, this.ctrlKey, this.altKey, this.shiftKey, _mouseIsDown, this.delta);
                this.container.dispatchEvent(new this.mouseEventEvent(MouseEvent.MOUSE_OUT, true, false, _loc_1.x, _loc_1.y, this.container, this.ctrlKey, this.altKey, this.shiftKey, _mouseIsDown, this.delta));
                dispatchEvent(new this.mouseEventEvent(MouseEvent.MOUSE_OUT, true, false, _loc_1.x, _loc_1.y, this.container, this.ctrlKey, this.altKey, this.shiftKey, _mouseIsDown, this.delta));
            }
            if (!this.disabledEvents[MouseEvent.ROLL_OUT])
            {
                this._lastEvent = new this.mouseEventEvent(MouseEvent.ROLL_OUT, false, false, _loc_1.x, _loc_1.y, this.container, this.ctrlKey, this.altKey, this.shiftKey, _mouseIsDown, this.delta);
                this.container.dispatchEvent(new this.mouseEventEvent(MouseEvent.ROLL_OUT, false, false, _loc_1.x, _loc_1.y, this.container, this.ctrlKey, this.altKey, this.shiftKey, _mouseIsDown, this.delta));
                dispatchEvent(new this.mouseEventEvent(MouseEvent.ROLL_OUT, false, false, _loc_1.x, _loc_1.y, this.container, this.ctrlKey, this.altKey, this.shiftKey, _mouseIsDown, this.delta));
            }
            if (this.target != this.container)
            {
                if (!this.disabledEvents[MouseEvent.MOUSE_OUT])
                {
                    this._lastEvent = new this.mouseEventEvent(MouseEvent.MOUSE_OUT, true, false, _loc_1.x, _loc_1.y, this.container, this.ctrlKey, this.altKey, this.shiftKey, _mouseIsDown, this.delta);
                    this.target.dispatchEvent(new this.mouseEventEvent(MouseEvent.MOUSE_OUT, true, false, _loc_1.x, _loc_1.y, this.container, this.ctrlKey, this.altKey, this.shiftKey, _mouseIsDown, this.delta));
                    dispatchEvent(new this.mouseEventEvent(MouseEvent.MOUSE_OUT, true, false, _loc_1.x, _loc_1.y, this.container, this.ctrlKey, this.altKey, this.shiftKey, _mouseIsDown, this.delta));
                }
                if (!this.disabledEvents[MouseEvent.ROLL_OUT])
                {
                    this._lastEvent = new this.mouseEventEvent(MouseEvent.ROLL_OUT, false, false, _loc_1.x, _loc_1.y, this.container, this.ctrlKey, this.altKey, this.shiftKey, _mouseIsDown, this.delta);
                    this.target.dispatchEvent(new this.mouseEventEvent(MouseEvent.ROLL_OUT, false, false, _loc_1.x, _loc_1.y, this.container, this.ctrlKey, this.altKey, this.shiftKey, _mouseIsDown, this.delta));
                    dispatchEvent(new this.mouseEventEvent(MouseEvent.ROLL_OUT, false, false, _loc_1.x, _loc_1.y, this.container, this.ctrlKey, this.altKey, this.shiftKey, _mouseIsDown, this.delta));
                }
            }
            this.target = this._stage;
            return;
        }// end function

        public function release() : void
        {
            this.updateMouseDown = true;
            _mouseIsDown = false;
            if (!this.isLocked)
            {
                this.update();
            }
            return;
        }// end function

        private function keyHandler(event:KeyboardEvent) : void
        {
            this.altKey = event.altKey;
            this.ctrlKey = event.ctrlKey;
            this.shiftKey = event.shiftKey;
            return;
        }// end function

        public function click() : void
        {
            this.press();
            this.release();
            return;
        }// end function

        public function disableEvent(param1:String) : void
        {
            this.disabledEvents[param1] = true;
            return;
        }// end function

        public function set container(param1:Sprite) : void
        {
            this._container = param1;
            return;
        }// end function

        public function get lastEvent() : Event
        {
            return this._lastEvent;
        }// end function

        private function handleUpdate(event:Event) : void
        {
            var _loc_4:InteractiveObject = null;
            var _loc_5:DisplayObject = null;
            var _loc_9:Boolean = false;
            if (!this.container)
            {
                return;
            }
            if (this.container.scrollRect)
            {
                PaperLogger.warning("The container that virtualMouse is trying to test against has a scrollRect defined, and may cause an issue with finding objects under a defined point.  Use MovieMaterial.rect to set a rectangle area instead");
            }
            var _loc_2:* = new Point();
            _loc_2.x = this.container.x;
            _loc_2.y = this.container.y;
            var _loc_10:int = 0;
            this.container.y = 0;
            this.container.x = _loc_10;
            var _loc_3:* = this.container.getObjectsUnderPoint(this.location);
            this.container.x = _loc_2.x;
            this.container.y = _loc_2.y;
            var _loc_6:* = _loc_3.length;
            while (_loc_6--)
            {
                
                _loc_5 = _loc_3[_loc_6];
                while (_loc_5)
                {
                    
                    if (this.ignoredInstances[_loc_5])
                    {
                        _loc_4 = null;
                        break;
                    }
                    if (_loc_4 && _loc_5 is SimpleButton)
                    {
                        _loc_4 = null;
                    }
                    else if (_loc_4 && !DisplayObjectContainer(_loc_5).mouseChildren)
                    {
                        _loc_4 = null;
                    }
                    if (!_loc_4 && _loc_5 is InteractiveObject && InteractiveObject(_loc_5).mouseEnabled)
                    {
                        _loc_4 = InteractiveObject(_loc_5);
                    }
                    _loc_5 = _loc_5.parent;
                }
                if (_loc_4)
                {
                    break;
                }
            }
            if (!_loc_4)
            {
                _loc_4 = this._stage;
            }
            var _loc_7:* = this.target.globalToLocal(this.location);
            var _loc_8:* = _loc_4.globalToLocal(this.location);
            if (this.lastLocation.x != this.location.x || this.lastLocation.y != this.location.y)
            {
                _loc_9 = false;
                if (this.stage)
                {
                    if (this.location.x >= 0 && this.location.y >= 0 && this.location.x <= this.stage.stageWidth)
                    {
                    }
                    _loc_9 = this.location.y <= this.stage.stageHeight;
                }
                if (!_loc_9 && this.lastWithinStage && !this.disabledEvents[Event.MOUSE_LEAVE])
                {
                    this._lastEvent = new this.eventEvent(Event.MOUSE_LEAVE, false, false);
                    this.stage.dispatchEvent(this._lastEvent);
                    dispatchEvent(this._lastEvent);
                }
                if (_loc_9 && !this.disabledEvents[MouseEvent.MOUSE_MOVE])
                {
                    this._lastEvent = new this.mouseEventEvent(MouseEvent.MOUSE_MOVE, true, false, _loc_8.x, _loc_8.y, _loc_4, this.ctrlKey, this.altKey, this.shiftKey, _mouseIsDown, this.delta);
                    _loc_4.dispatchEvent(this._lastEvent);
                    dispatchEvent(this._lastEvent);
                }
                this.lastWithinStage = _loc_9;
            }
            if (_loc_4 != this.target)
            {
                if (!this.disabledEvents[MouseEvent.MOUSE_OUT])
                {
                    this._lastEvent = new this.mouseEventEvent(MouseEvent.MOUSE_OUT, true, false, _loc_7.x, _loc_7.y, _loc_4, this.ctrlKey, this.altKey, this.shiftKey, _mouseIsDown, this.delta);
                    this.target.dispatchEvent(this._lastEvent);
                    dispatchEvent(this._lastEvent);
                }
                if (!this.disabledEvents[MouseEvent.ROLL_OUT])
                {
                    this._lastEvent = new this.mouseEventEvent(MouseEvent.ROLL_OUT, false, false, _loc_7.x, _loc_7.y, _loc_4, this.ctrlKey, this.altKey, this.shiftKey, _mouseIsDown, this.delta);
                    this.target.dispatchEvent(this._lastEvent);
                    dispatchEvent(this._lastEvent);
                }
                if (!this.disabledEvents[MouseEvent.MOUSE_OVER])
                {
                    this._lastEvent = new this.mouseEventEvent(MouseEvent.MOUSE_OVER, true, false, _loc_8.x, _loc_8.y, this.target, this.ctrlKey, this.altKey, this.shiftKey, _mouseIsDown, this.delta);
                    _loc_4.dispatchEvent(this._lastEvent);
                    dispatchEvent(this._lastEvent);
                }
                if (!this.disabledEvents[MouseEvent.ROLL_OVER])
                {
                    this._lastEvent = new this.mouseEventEvent(MouseEvent.ROLL_OVER, false, false, _loc_8.x, _loc_8.y, this.target, this.ctrlKey, this.altKey, this.shiftKey, _mouseIsDown, this.delta);
                    _loc_4.dispatchEvent(this._lastEvent);
                    dispatchEvent(this._lastEvent);
                }
            }
            if (this.updateMouseDown)
            {
                if (_mouseIsDown)
                {
                    if (!this.disabledEvents[MouseEvent.MOUSE_DOWN])
                    {
                        this._lastEvent = new this.mouseEventEvent(MouseEvent.MOUSE_DOWN, true, false, _loc_8.x, _loc_8.y, _loc_4, this.ctrlKey, this.altKey, this.shiftKey, _mouseIsDown, this.delta);
                        _loc_4.dispatchEvent(this._lastEvent);
                        dispatchEvent(this._lastEvent);
                    }
                    this.lastDownTarget = _loc_4;
                    this.updateMouseDown = false;
                }
                else
                {
                    if (!this.disabledEvents[MouseEvent.MOUSE_UP])
                    {
                        this._lastEvent = new this.mouseEventEvent(MouseEvent.MOUSE_UP, true, false, _loc_8.x, _loc_8.y, _loc_4, this.ctrlKey, this.altKey, this.shiftKey, _mouseIsDown, this.delta);
                        _loc_4.dispatchEvent(this._lastEvent);
                        dispatchEvent(this._lastEvent);
                    }
                    if (!this.disabledEvents[MouseEvent.CLICK] && _loc_4 == this.lastDownTarget)
                    {
                        this._lastEvent = new this.mouseEventEvent(MouseEvent.CLICK, true, false, _loc_8.x, _loc_8.y, _loc_4, this.ctrlKey, this.altKey, this.shiftKey, _mouseIsDown, this.delta);
                        _loc_4.dispatchEvent(this._lastEvent);
                        dispatchEvent(this._lastEvent);
                    }
                    this.lastDownTarget = null;
                    this.updateMouseDown = false;
                }
            }
            if (this.isDoubleClickEvent && !this.disabledEvents[MouseEvent.DOUBLE_CLICK] && _loc_4.doubleClickEnabled)
            {
                this._lastEvent = new this.mouseEventEvent(MouseEvent.DOUBLE_CLICK, true, false, _loc_8.x, _loc_8.y, _loc_4, this.ctrlKey, this.altKey, this.shiftKey, _mouseIsDown, this.delta);
                _loc_4.dispatchEvent(this._lastEvent);
                dispatchEvent(this._lastEvent);
            }
            this.lastLocation = this.location.clone();
            this.lastMouseDown = _mouseIsDown;
            this.target = _loc_4;
            return;
        }// end function

        public function getLocation() : Point
        {
            return this.location.clone();
        }// end function

        public function lock() : void
        {
            this.isLocked = true;
            return;
        }// end function

        public function get useNativeEvents() : Boolean
        {
            return this._useNativeEvents;
        }// end function

        public function setLocation(param1, param2 = null) : void
        {
            var _loc_3:Point = null;
            if (param1 is Point)
            {
                _loc_3 = param1 as Point;
                this.location.x = _loc_3.x;
                this.location.y = _loc_3.y;
            }
            else
            {
                this.location.x = Number(param1);
                this.location.y = Number(param2);
            }
            if (!this.isLocked)
            {
                this.update();
            }
            return;
        }// end function

        public function unignore(param1:DisplayObject) : void
        {
            if (param1 in this.ignoredInstances)
            {
                delete this.ignoredInstances[param1];
            }
            return;
        }// end function

        public function doubleClick() : void
        {
            if (this.isLocked)
            {
                this.release();
            }
            else
            {
                this.click();
                this.press();
                this.isDoubleClickEvent = true;
                this.release();
                this.isDoubleClickEvent = false;
            }
            return;
        }// end function

        public function update() : void
        {
            dispatchEvent(new Event(UPDATE, false, false));
            return;
        }// end function

        public function unlock() : void
        {
            this.isLocked = false;
            this.update();
            return;
        }// end function

        public function ignore(param1:DisplayObject) : void
        {
            this.ignoredInstances[param1] = true;
            return;
        }// end function

        public function enableEvent(param1:String) : void
        {
            if (param1 in this.disabledEvents)
            {
                delete this.disabledEvents[param1];
            }
            return;
        }// end function

        public function press() : void
        {
            this.updateMouseDown = true;
            _mouseIsDown = true;
            if (!this.isLocked)
            {
                this.update();
            }
            return;
        }// end function

        public function set useNativeEvents(param1:Boolean) : void
        {
            if (param1 == this._useNativeEvents)
            {
                return;
            }
            this._useNativeEvents = param1;
            if (this._useNativeEvents)
            {
                this.eventEvent = VirtualMouseEvent;
                this.mouseEventEvent = VirtualMouseMouseEvent;
            }
            else
            {
                this.eventEvent = Event;
                this.mouseEventEvent = MouseEvent;
            }
            return;
        }// end function

        public function set x(param1:Number) : void
        {
            this.location.x = param1;
            if (!this.isLocked)
            {
                this.update();
            }
            return;
        }// end function

        public function set y(param1:Number) : void
        {
            this.location.y = param1;
            if (!this.isLocked)
            {
                this.update();
            }
            return;
        }// end function

        public function get y() : Number
        {
            return this.location.y;
        }// end function

        public function set stage(param1:Stage) : void
        {
            var _loc_2:Boolean = false;
            if (this._stage)
            {
                _loc_2 = true;
                this._stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.keyHandler);
                this._stage.removeEventListener(KeyboardEvent.KEY_UP, this.keyHandler);
            }
            else
            {
                _loc_2 = false;
            }
            this._stage = param1;
            if (this._stage)
            {
                this._stage.addEventListener(KeyboardEvent.KEY_DOWN, this.keyHandler);
                this._stage.addEventListener(KeyboardEvent.KEY_UP, this.keyHandler);
                this.target = this._stage;
                if (true)
                {
                    this.update();
                }
            }
            return;
        }// end function

        public function get stage() : Stage
        {
            return this._stage;
        }// end function

        public function get x() : Number
        {
            return this.location.x;
        }// end function

    }
}
