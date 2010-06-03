package mx.effects
{
    import mx.effects.effectClasses.*;

    public class Parallel extends CompositeEffect
    {
        static const VERSION:String = "3.2.0.3958";

        public function Parallel(param1:Object = null)
        {
            super(param1);
            instanceClass = ParallelInstance;
            return;
        }// end function

    }
}
