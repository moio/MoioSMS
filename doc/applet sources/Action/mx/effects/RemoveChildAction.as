package mx.effects
{
    import mx.effects.effectClasses.*;

    public class RemoveChildAction extends Effect
    {
        static const VERSION:String = "3.2.0.3958";
        private static var AFFECTED_PROPERTIES:Array = ["parent", "index"];

        public function RemoveChildAction(param1:Object = null)
        {
            super(param1);
            instanceClass = RemoveChildActionInstance;
            return;
        }// end function

        override public function getAffectedProperties() : Array
        {
            return AFFECTED_PROPERTIES;
        }// end function

        override protected function getValueFromTarget(param1:Object, param2:String)
        {
            if (param2 == "index")
            {
                return param1.parent ? (param1.parent.getChildIndex(param1)) : (0);
            }
            return super.getValueFromTarget(param1, param2);
        }// end function

        override function applyStartValues(param1:Array, param2:Array) : void
        {
            if (param1)
            {
                param1.sort(propChangesSortHandler);
            }
            super.applyStartValues(param1, param2);
            return;
        }// end function

        private function propChangesSortHandler(param1:PropertyChanges, param2:PropertyChanges) : Number
        {
            if (param1.start.index > param2.start.index)
            {
                return 1;
            }
            if (param1.start.index < param2.start.index)
            {
                return -1;
            }
            return 0;
        }// end function

        override protected function applyValueToTarget(param1:Object, param2:String, param3, param4:Object) : void
        {
            if (param2 == "parent" && param1.parent == null && param3)
            {
                param3.addChildAt(param1, Math.min(param4.index, param3.numChildren));
            }
            return;
        }// end function

    }
}
