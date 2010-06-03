package mx.managers.systemClasses
{
    import flash.display.*;
    import flash.events.*;

    public class StageEventProxy extends Object
    {
        private var listener:Function;

        public function StageEventProxy(param1:Function)
        {
            this.listener = param1;
            return;
        }// end function

        public function stageListener(event:Event) : void
        {
            if (event.target is Stage)
            {
                listener(event);
            }
            return;
        }// end function

    }
}
