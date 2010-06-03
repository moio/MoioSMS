package 
{
    import mx.managers.*;

    private class CursorQueueItem extends Object
    {
        public var priority:int = 2;
        public var cursorClass:Class = null;
        public var cursorID:int = 0;
        public var x:Number;
        public var y:Number;
        public var systemManager:ISystemManager;
        static const VERSION:String = "3.2.0.3958";

        private function CursorQueueItem()
        {
            return;
        }// end function

    }
}
