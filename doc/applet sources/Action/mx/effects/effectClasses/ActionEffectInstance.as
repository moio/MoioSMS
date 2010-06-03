package mx.effects.effectClasses
{
    import mx.core.*;
    import mx.effects.*;

    public class ActionEffectInstance extends EffectInstance
    {
        protected var playedAction:Boolean = false;
        private var _startValue:Object;
        static const VERSION:String = "3.2.0.3958";

        public function ActionEffectInstance(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function play() : void
        {
            super.play();
            if (!mx_internal::playReversed)
            {
                _startValue = saveStartValue();
            }
            playedAction = true;
            return;
        }// end function

        protected function getStartValue()
        {
            return _startValue;
        }// end function

        override public function end() : void
        {
            if (!playedAction)
            {
                play();
            }
            super.end();
            return;
        }// end function

        protected function saveStartValue()
        {
            return;
        }// end function

    }
}
