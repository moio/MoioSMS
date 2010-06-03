package mx.managers.systemClasses
{
    import flash.events.*;

    public class PlaceholderData extends Object
    {
        public var bridge:IEventDispatcher;
        public var data:Object;
        public var id:String;

        public function PlaceholderData(param1:String, param2:IEventDispatcher, param3:Object)
        {
            this.id = param1;
            this.bridge = param2;
            this.data = param3;
            return;
        }// end function

    }
}
