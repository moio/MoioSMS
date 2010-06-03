package mx.managers
{
    import flash.events.*;
    import mx.core.*;
    import mx.managers.dragClasses.*;

    public class DragManager extends Object
    {
        private static var implClassDependency:DragManagerImpl;
        private static var _impl:IDragManager;
        public static const MOVE:String = "move";
        public static const COPY:String = "copy";
        static const VERSION:String = "3.2.0.3958";
        public static const LINK:String = "link";
        public static const NONE:String = "none";

        public function DragManager()
        {
            return;
        }// end function

        private static function get impl() : IDragManager
        {
            if (!_impl)
            {
                _impl = IDragManager(Singleton.getInstance("mx.managers::IDragManager"));
            }
            return _impl;
        }// end function

        static function get dragProxy() : DragProxy
        {
            return Object(impl).dragProxy;
        }// end function

        public static function showFeedback(param1:String) : void
        {
            impl.showFeedback(param1);
            return;
        }// end function

        public static function acceptDragDrop(param1:IUIComponent) : void
        {
            impl.acceptDragDrop(param1);
            return;
        }// end function

        public static function doDrag(param1:IUIComponent, param2:DragSource, param3:MouseEvent, param4:IFlexDisplayObject = null, param5:Number = 0, param6:Number = 0, param7:Number = 0.5, param8:Boolean = true) : void
        {
            impl.doDrag(param1, param2, param3, param4, param5, param6, param7, param8);
            return;
        }// end function

        static function endDrag() : void
        {
            impl.endDrag();
            return;
        }// end function

        public static function get isDragging() : Boolean
        {
            return impl.isDragging;
        }// end function

        public static function getFeedback() : String
        {
            return impl.getFeedback();
        }// end function

    }
}
