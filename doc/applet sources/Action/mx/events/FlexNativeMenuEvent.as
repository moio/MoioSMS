package mx.events
{
    import flash.display.*;
    import flash.events.*;

    public class FlexNativeMenuEvent extends Event
    {
        public var index:int;
        public var label:String;
        public var nativeMenuItem:NativeMenuItem;
        public var item:Object;
        public var nativeMenu:NativeMenu;
        static const VERSION:String = "3.2.0.3958";
        public static const ITEM_CLICK:String = "itemClick";
        public static const MENU_SHOW:String = "menuShow";

        public function FlexNativeMenuEvent(param1:String, param2:Boolean = false, param3:Boolean = true, param4:NativeMenu = null, param5:NativeMenuItem = null, param6:Object = null, param7:String = null, param8:int = -1)
        {
            super(param1, param2, param3);
            this.nativeMenu = param4;
            this.nativeMenuItem = param5;
            this.item = param6;
            this.label = param7;
            this.index = param8;
            return;
        }// end function

        override public function clone() : Event
        {
            return new FlexNativeMenuEvent(type, bubbles, cancelable, nativeMenu, nativeMenuItem);
        }// end function

    }
}
