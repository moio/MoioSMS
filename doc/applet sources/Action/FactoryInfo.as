package 
{
    import flash.system.*;
    import mx.core.*;

    private class FactoryInfo extends Object
    {
        public var bytesTotal:int = 0;
        public var factory:IFlexModuleFactory;
        public var applicationDomain:ApplicationDomain;

        private function FactoryInfo()
        {
            return;
        }// end function

    }
}
