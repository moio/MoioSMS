package mx.core
{

    public class ClassFactory extends Object implements IFactory
    {
        public var properties:Object = null;
        public var generator:Class;
        static const VERSION:String = "3.2.0.3958";

        public function ClassFactory(param1:Class = null)
        {
            this.generator = param1;
            return;
        }// end function

        public function newInstance()
        {
            var _loc_2:String = null;
            var _loc_1:* = new generator();
            if (properties != null)
            {
                for (_loc_2 in properties)
                {
                    
                    _loc_1[_loc_2] = properties[_loc_2];
                }
            }
            return _loc_1;
        }// end function

    }
}
