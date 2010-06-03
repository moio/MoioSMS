package mx.states
{
    import flash.events.*;
    import flash.utils.*;
    import mx.core.*;

    public class SetEventHandler extends EventDispatcher implements IOverride
    {
        public var handlerFunction:Function;
        public var name:String;
        public var target:EventDispatcher;
        private var oldHandlerFunction:Function;
        static const VERSION:String = "3.2.0.3958";
        private static var installedHandlers:Dictionary;

        public function SetEventHandler(param1:EventDispatcher = null, param2:String = null)
        {
            this.target = param1;
            this.name = param2;
            return;
        }// end function

        public function apply(param1:UIComponent) : void
        {
            var _loc_4:ComponentDescriptor = null;
            var _loc_2:* = target ? (target) : (param1);
            var _loc_3:* = _loc_2 as UIComponent;
            if (!installedHandlers)
            {
                installedHandlers = new Dictionary(true);
            }
            if (installedHandlers[_loc_2] && installedHandlers[_loc_2][name])
            {
                oldHandlerFunction = installedHandlers[_loc_2][name];
                _loc_2.removeEventListener(name, oldHandlerFunction);
            }
            else if (_loc_3 && _loc_3.descriptor)
            {
                _loc_4 = _loc_3.descriptor;
                if (_loc_4.events && _loc_4.events[name])
                {
                    oldHandlerFunction = _loc_3.document[_loc_4.events[name]];
                    _loc_2.removeEventListener(name, oldHandlerFunction);
                }
            }
            if (handlerFunction != null)
            {
                _loc_2.addEventListener(name, handlerFunction, false, 0, true);
                if (installedHandlers[_loc_2] == undefined)
                {
                    installedHandlers[_loc_2] = {};
                }
                installedHandlers[_loc_2][name] = handlerFunction;
            }
            return;
        }// end function

        public function initialize() : void
        {
            return;
        }// end function

        override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            if (param1 == "handler")
            {
                handlerFunction = param2;
            }
            super.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function remove(param1:UIComponent) : void
        {
            var _loc_3:Boolean = false;
            var _loc_4:String = null;
            var _loc_2:* = target ? (target) : (param1);
            if (handlerFunction != null)
            {
                _loc_2.removeEventListener(name, handlerFunction);
            }
            if (oldHandlerFunction != null)
            {
                _loc_2.addEventListener(name, oldHandlerFunction, false, 0, true);
            }
            if (installedHandlers[_loc_2])
            {
                _loc_3 = true;
                delete installedHandlers[_loc_2][name];
                for (_loc_4 in installedHandlers[_loc_2])
                {
                    
                    _loc_3 = false;
                    break;
                }
                if (_loc_3)
                {
                    delete installedHandlers[_loc_2];
                }
            }
            return;
        }// end function

    }
}
