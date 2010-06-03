package mx.effects
{
    import mx.effects.effectClasses.*;

    public class Pause extends TweenEffect
    {
        static const VERSION:String = "3.2.0.3958";

        public function Pause(param1:Object = null)
        {
            super(param1);
            instanceClass = PauseInstance;
            return;
        }// end function

        override public function createInstances(param1:Array = null) : Array
        {
            var _loc_2:* = createInstance();
            return _loc_2 ? ([_loc_2]) : ([]);
        }// end function

    }
}
