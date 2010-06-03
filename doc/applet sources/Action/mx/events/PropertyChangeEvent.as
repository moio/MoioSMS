package mx.events
{
    import flash.events.*;

    public class PropertyChangeEvent extends Event
    {
        public var newValue:Object;
        public var kind:String;
        public var property:Object;
        public var oldValue:Object;
        public var source:Object;
        static const VERSION:String = "3.2.0.3958";
        public static const PROPERTY_CHANGE:String = "propertyChange";

        public function PropertyChangeEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:String = null, param5:Object = null, param6:Object = null, param7:Object = null, param8:Object = null)
        {
            super(param1, param2, param3);
            this.kind = param4;
            this.property = param5;
            this.oldValue = param6;
            this.newValue = param7;
            this.source = param8;
            return;
        }// end function

        override public function clone() : Event
        {
            return new PropertyChangeEvent(type, bubbles, cancelable, kind, property, oldValue, newValue, source);
        }// end function

        public static function createUpdateEvent(param1:Object, param2:Object, param3:Object, param4:Object) : PropertyChangeEvent
        {
            var _loc_5:* = new PropertyChangeEvent(PROPERTY_CHANGE);
            new PropertyChangeEvent(PROPERTY_CHANGE).kind = PropertyChangeEventKind.UPDATE;
            _loc_5.oldValue = param3;
            _loc_5.newValue = param4;
            _loc_5.source = param1;
            _loc_5.property = param2;
            return _loc_5;
        }// end function

    }
}
