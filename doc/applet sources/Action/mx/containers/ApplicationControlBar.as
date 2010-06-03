package mx.containers
{
    import flash.events.*;
    import mx.core.*;
    import mx.styles.*;

    public class ApplicationControlBar extends ControlBar
    {
        private var dockChanged:Boolean = false;
        private var _dock:Boolean = false;
        static const VERSION:String = "3.2.0.3958";

        public function ApplicationControlBar()
        {
            return;
        }// end function

        public function set dock(param1:Boolean) : void
        {
            if (_dock != param1)
            {
                _dock = param1;
                dockChanged = true;
                invalidateProperties();
                dispatchEvent(new Event("dockChanged"));
            }
            return;
        }// end function

        public function resetDock(param1:Boolean) : void
        {
            _dock = !param1;
            dock = param1;
            return;
        }// end function

        public function get dock() : Boolean
        {
            return _dock;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (dockChanged)
            {
                dockChanged = false;
                if (parent is Application)
                {
                    Application(parent).dockControlBar(this, _dock);
                }
            }
            return;
        }// end function

        override public function set enabled(param1:Boolean) : void
        {
            var _loc_2:* = blocker;
            super.enabled = param1;
            if (blocker && blocker != _loc_2)
            {
                if (blocker is IStyleClient)
                {
                    IStyleClient(blocker).setStyle("borderStyle", "applicationControlBar");
                }
            }
            return;
        }// end function

    }
}
