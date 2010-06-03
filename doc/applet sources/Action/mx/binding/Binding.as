package mx.binding
{
    import flash.utils.*;
    import mx.collections.errors.*;

    public class Binding extends Object
    {
        var destFunc:Function;
        var srcFunc:Function;
        var destString:String;
        var document:Object;
        private var hasHadValue:Boolean;
        var disabledRequests:Dictionary;
        var isExecuting:Boolean;
        var isHandlingEvent:Boolean;
        public var twoWayCounterpart:Binding;
        private var wrappedFunctionSuccessful:Boolean;
        var _isEnabled:Boolean;
        public var uiComponentWatcher:int;
        private var lastValue:Object;
        static const VERSION:String = "3.2.0.3958";

        public function Binding(param1:Object, param2:Function, param3:Function, param4:String)
        {
            this.document = param1;
            this.srcFunc = param2;
            this.destFunc = param3;
            this.destString = param4;
            _isEnabled = true;
            isExecuting = false;
            isHandlingEvent = false;
            hasHadValue = false;
            uiComponentWatcher = -1;
            BindingManager.addBinding(param1, param4, this);
            return;
        }// end function

        private function registerDisabledExecute(param1:Object) : void
        {
            if (param1 != null)
            {
                disabledRequests = disabledRequests != null ? (disabledRequests) : (new Dictionary(true));
                disabledRequests[param1] = true;
            }
            return;
        }// end function

        protected function wrapFunctionCall(param1:Object, param2:Function, param3:Object = null, ... args) : Object
        {
            var result:Object;
            var thisArg:* = param1;
            var wrappedFunction:* = param2;
            var object:* = param3;
            var args:* = args;
            wrappedFunctionSuccessful = false;
            try
            {
                result = wrappedFunction.apply(thisArg, args);
                wrappedFunctionSuccessful = true;
                return result;
            }
            catch (itemPendingError:ItemPendingError)
            {
                itemPendingError.addResponder(new EvalBindingResponder(this, object));
                if (BindingManager.debugDestinationStrings[destString])
                {
                    trace("Binding: destString = " + destString + ", error = " + itemPendingError);
                }
                ;
            }
            catch (rangeError:RangeError)
            {
                if (BindingManager.debugDestinationStrings[destString])
                {
                    trace("Binding: destString = " + destString + ", error = " + rangeError);
                }
                ;
            }
            catch (error:Error)
            {
                if (error.errorID != 1006 && error.errorID != 1009 && error.errorID != 1010 && error.errorID != 1055 && error.errorID != 1069)
                {
                    throw error;
                }
                else if (BindingManager.debugDestinationStrings[destString])
                {
                    trace("Binding: destString = " + destString + ", error = " + error);
                }
            }
            return null;
        }// end function

        public function watcherFired(param1:Boolean, param2:int) : void
        {
            var commitEvent:* = param1;
            var cloneIndex:* = param2;
            if (isHandlingEvent)
            {
                return;
            }
            isHandlingEvent = true;
            execute(cloneIndex);
            finally
            {
                var _loc_4:* = new catch0;
                throw null;
            }
            finally
            {
                isHandlingEvent = false;
            }
            return;
        }// end function

        private function nodeSeqEqual(param1:XMLList, param2:XMLList) : Boolean
        {
            var _loc_4:uint = 0;
            var _loc_3:* = param1.length();
            if (_loc_3 == param2.length())
            {
                _loc_4 = 0;
                while (_loc_4++ < _loc_3 && param1[_loc_4] === param2[_loc_4])
                {
                    
                }
                return _loc_4 == _loc_3;
            }
            else
            {
                return false;
            }
        }// end function

        function set isEnabled(param1:Boolean) : void
        {
            _isEnabled = param1;
            if (param1)
            {
                processDisabledRequests();
            }
            return;
        }// end function

        private function processDisabledRequests() : void
        {
            var _loc_1:Object = null;
            if (disabledRequests != null)
            {
                for (_loc_1 in disabledRequests)
                {
                    
                    execute(_loc_1);
                }
                disabledRequests = null;
            }
            return;
        }// end function

        public function execute(param1:Object = null) : void
        {
            var o:* = param1;
            if (!isEnabled)
            {
                if (o != null)
                {
                    registerDisabledExecute(o);
                }
                return;
            }
            if (isExecuting || twoWayCounterpart && twoWayCounterpart.isExecuting)
            {
                hasHadValue = true;
                return;
            }
            isExecuting = true;
            wrapFunctionCall(this, innerExecute, o);
            finally
            {
                var _loc_3:* = new catch0;
                throw null;
            }
            finally
            {
                isExecuting = false;
            }
            return;
        }// end function

        function get isEnabled() : Boolean
        {
            return _isEnabled;
        }// end function

        private function innerExecute() : void
        {
            var _loc_1:* = wrapFunctionCall(document, srcFunc);
            if (BindingManager.debugDestinationStrings[destString])
            {
                trace("Binding: destString = " + destString + ", srcFunc result = " + _loc_1);
            }
            if (hasHadValue || wrappedFunctionSuccessful)
            {
                if (lastValue is XML && lastValue.hasComplexContent() && lastValue !== _loc_1 && lastValue is XMLList && lastValue.hasComplexContent() && _loc_1 is XMLList && !nodeSeqEqual(lastValue as XMLList, _loc_1 as XMLList))
                {
                    destFunc.call(document, _loc_1);
                    lastValue = _loc_1;
                    hasHadValue = true;
                }
            }
            return;
        }// end function

    }
}
