package mx.events
{
    import flash.events.*;

    public class CollectionEvent extends Event
    {
        public var kind:String;
        public var location:int;
        public var items:Array;
        public var oldLocation:int;
        static const VERSION:String = "3.2.0.3958";
        public static const COLLECTION_CHANGE:String = "collectionChange";

        public function CollectionEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:String = null, param5:int = -1, param6:int = -1, param7:Array = null)
        {
            super(param1, param2, param3);
            this.kind = param4;
            this.location = param5;
            this.oldLocation = param6;
            this.items = param7 ? (param7) : ([]);
            return;
        }// end function

        override public function toString() : String
        {
            return formatToString("CollectionEvent", "kind", "location", "oldLocation", "type", "bubbles", "cancelable", "eventPhase");
        }// end function

        override public function clone() : Event
        {
            return new CollectionEvent(type, bubbles, cancelable, kind, location, oldLocation, items);
        }// end function

    }
}
