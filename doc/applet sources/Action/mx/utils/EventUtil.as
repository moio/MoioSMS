package mx.utils
{
    import flash.events.*;
    import mx.events.*;

    public class EventUtil extends Object
    {
        static const VERSION:String = "3.2.0.3958";
        private static var _sandboxEventMap:Object;
        private static var _mouseEventMap:Object;

        public function EventUtil()
        {
            return;
        }// end function

        public static function get sandboxMouseEventMap() : Object
        {
            if (!_sandboxEventMap)
            {
                _sandboxEventMap = {};
                _sandboxEventMap[SandboxMouseEvent.CLICK_SOMEWHERE] = MouseEvent.CLICK;
                _sandboxEventMap[SandboxMouseEvent.DOUBLE_CLICK_SOMEWHERE] = MouseEvent.DOUBLE_CLICK;
                _sandboxEventMap[SandboxMouseEvent.MOUSE_DOWN_SOMEWHERE] = MouseEvent.MOUSE_DOWN;
                _sandboxEventMap[SandboxMouseEvent.MOUSE_MOVE_SOMEWHERE] = MouseEvent.MOUSE_MOVE;
                _sandboxEventMap[SandboxMouseEvent.MOUSE_UP_SOMEWHERE] = MouseEvent.MOUSE_UP;
                _sandboxEventMap[SandboxMouseEvent.MOUSE_WHEEL_SOMEWHERE] = MouseEvent.MOUSE_WHEEL;
            }
            return _sandboxEventMap;
        }// end function

        public static function get mouseEventMap() : Object
        {
            if (!_mouseEventMap)
            {
                _mouseEventMap = {};
                _mouseEventMap[MouseEvent.CLICK] = SandboxMouseEvent.CLICK_SOMEWHERE;
                _mouseEventMap[MouseEvent.DOUBLE_CLICK] = SandboxMouseEvent.DOUBLE_CLICK_SOMEWHERE;
                _mouseEventMap[MouseEvent.MOUSE_DOWN] = SandboxMouseEvent.MOUSE_DOWN_SOMEWHERE;
                _mouseEventMap[MouseEvent.MOUSE_MOVE] = SandboxMouseEvent.MOUSE_MOVE_SOMEWHERE;
                _mouseEventMap[MouseEvent.MOUSE_UP] = SandboxMouseEvent.MOUSE_UP_SOMEWHERE;
                _mouseEventMap[MouseEvent.MOUSE_WHEEL] = SandboxMouseEvent.MOUSE_WHEEL_SOMEWHERE;
            }
            return _mouseEventMap;
        }// end function

    }
}
