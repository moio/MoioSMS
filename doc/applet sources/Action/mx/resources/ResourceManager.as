package mx.resources
{
    import mx.core.*;

    public class ResourceManager extends Object
    {
        private static var implClassDependency:ResourceManagerImpl;
        private static var instance:IResourceManager;
        static const VERSION:String = "3.2.0.3958";

        public function ResourceManager()
        {
            return;
        }// end function

        public static function getInstance() : IResourceManager
        {
            if (!instance)
            {
                try
                {
                    instance = IResourceManager(Singleton.getInstance("mx.resources::IResourceManager"));
                }
                catch (e:Error)
                {
                    instance = new ResourceManagerImpl();
                }
            }
            return instance;
        }// end function

    }
}
