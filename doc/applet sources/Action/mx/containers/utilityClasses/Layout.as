package mx.containers.utilityClasses
{
    import mx.core.*;
    import mx.resources.*;

    public class Layout extends Object
    {
        private var _target:Container;
        protected var resourceManager:IResourceManager;
        static const VERSION:String = "3.2.0.3958";

        public function Layout()
        {
            resourceManager = ResourceManager.getInstance();
            return;
        }// end function

        public function get target() : Container
        {
            return _target;
        }// end function

        public function set target(param1:Container) : void
        {
            _target = param1;
            return;
        }// end function

        public function measure() : void
        {
            return;
        }// end function

        public function updateDisplayList(param1:Number, param2:Number) : void
        {
            return;
        }// end function

    }
}
