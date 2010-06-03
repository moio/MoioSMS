package mx.binding
{
    import flash.events.*;
    import mx.core.*;

    public class RepeatableBinding extends Binding
    {
        static const VERSION:String = "3.2.0.3958";

        public function RepeatableBinding(param1:Object, param2:Function, param3:Function, param4:String)
        {
            super(param1, param2, param3, param4);
            return;
        }// end function

        public function eventHandler(event:Event) : void
        {
            if (isHandlingEvent)
            {
                return;
            }
            isHandlingEvent = true;
            execute();
            isHandlingEvent = false;
            return;
        }// end function

        override public function execute(param1:Object = null) : void
        {
            var _loc_2:String = null;
            var _loc_3:Array = null;
            if (isExecuting)
            {
                return;
            }
            isExecuting = true;
            if (!param1)
            {
                _loc_2 = destString.substring(0, destString.indexOf("."));
                param1 = document[_loc_2];
            }
            else if (typeof(param1) == "number")
            {
                _loc_2 = destString.substring(0, destString.indexOf("."));
                _loc_3 = document[_loc_2] as Array;
                if (_loc_3)
                {
                    param1 = _loc_3[param1];
                }
                else
                {
                    param1 = null;
                }
            }
            if (param1)
            {
                recursivelyProcessIDArray(param1);
            }
            isExecuting = false;
            return;
        }// end function

        private function recursivelyProcessIDArray(param1:Object) : void
        {
            var array:Array;
            var n:int;
            var i:int;
            var client:IRepeaterClient;
            var o:* = param1;
            if (o is Array)
            {
                array = o as Array;
                n = array.length;
                i;
                while (i < n)
                {
                    
                    recursivelyProcessIDArray(array[i]);
                    i = i++;
                }
            }
            else if (o is IRepeaterClient)
            {
                client = IRepeaterClient(o);
                wrapFunctionCall(this, function () : void
            {
                var _loc_1:* = wrapFunctionCall(this, srcFunc, null, client.instanceIndices, client.repeaterIndices);
                if (BindingManager.debugDestinationStrings[destString])
                {
                    trace("RepeatableBinding: destString = " + destString + ", srcFunc result = " + _loc_1);
                }
                destFunc(_loc_1, client.instanceIndices);
                return;
            }// end function
            , o);
            }
            return;
        }// end function

    }
}
