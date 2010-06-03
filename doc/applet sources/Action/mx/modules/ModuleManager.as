package mx.modules
{
    import mx.core.*;

    public class ModuleManager extends Object
    {
        static const VERSION:String = "3.2.0.3958";

        public function ModuleManager()
        {
            return;
        }// end function

        public static function getModule(param1:String) : IModuleInfo
        {
            return getSingleton().getModule(param1);
        }// end function

        private static function getSingleton() : Object
        {
            if (!ModuleManagerGlobals.managerSingleton)
            {
                ModuleManagerGlobals.managerSingleton = new ModuleManagerImpl();
            }
            return ModuleManagerGlobals.managerSingleton;
        }// end function

        public static function getAssociatedFactory(param1:Object) : IFlexModuleFactory
        {
            return getSingleton().getAssociatedFactory(param1);
        }// end function

    }
}
