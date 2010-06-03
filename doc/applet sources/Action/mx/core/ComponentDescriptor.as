package mx.core
{

    public class ComponentDescriptor extends Object
    {
        public var events:Object;
        public var type:Class;
        public var document:Object;
        private var _properties:Object;
        public var propertiesFactory:Function;
        public var id:String;
        static const VERSION:String = "3.2.0.3958";

        public function ComponentDescriptor(param1:Object)
        {
            var _loc_2:String = null;
            for (_loc_2 in param1)
            {
                
                this[_loc_2] = param1[_loc_2];
            }
            return;
        }// end function

        public function toString() : String
        {
            return "ComponentDescriptor_" + id;
        }// end function

        public function invalidateProperties() : void
        {
            _properties = null;
            return;
        }// end function

        public function get properties() : Object
        {
            var _loc_1:Array = null;
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            if (_properties)
            {
                return _properties;
            }
            if (propertiesFactory != null)
            {
                _properties = propertiesFactory.call(document);
            }
            if (_properties)
            {
                _loc_1 = _properties.childDescriptors;
                if (_loc_1)
                {
                    _loc_2 = _loc_1.length;
                    _loc_3 = 0;
                    while (_loc_3 < _loc_2)
                    {
                        
                        _loc_1[_loc_3].document = document;
                        _loc_3++;
                    }
                }
            }
            else
            {
                _properties = {};
            }
            return _properties;
        }// end function

    }
}
