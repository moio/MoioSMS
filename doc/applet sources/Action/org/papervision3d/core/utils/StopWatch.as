package org.papervision3d.core.utils
{
    import flash.events.*;
    import flash.utils.*;

    public class StopWatch extends EventDispatcher
    {
        private var startTime:int;
        private var elapsedTime:int;
        private var isRunning:Boolean;
        private var stopTime:int;

        public function StopWatch()
        {
            return;
        }// end function

        public function start() : void
        {
            if (!this.isRunning)
            {
                this.startTime = getTimer();
                this.isRunning = true;
            }
            return;
        }// end function

        public function stop() : int
        {
            if (this.isRunning)
            {
                this.stopTime = getTimer();
                this.elapsedTime = this.stopTime - this.startTime;
                this.isRunning = false;
                return this.elapsedTime;
            }
            return 0;
        }// end function

        public function reset() : void
        {
            this.isRunning = false;
            return;
        }// end function

    }
}
