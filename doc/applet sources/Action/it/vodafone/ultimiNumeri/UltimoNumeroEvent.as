package it.vodafone.ultimiNumeri
{
    import flash.events.*;

    public class UltimoNumeroEvent extends Event
    {
        public var fromKeyboard:Boolean;
        public var message:String;
        public var data:UltimoNumeroElement;
        public static const EDIT_EVENT:String = "ultimi_numeri_edit_event";
        public static const DELETE_EVENT:String = "ultimi_numeri_delete_event";
        public static const SELECT_ELEMENT:String = "ultimi_numeri_select_element";
        public static const ADD_EVENT:String = "ultimi_numeri_add_event";

        public function UltimoNumeroEvent(param1:String, param2:String = "", param3:UltimoNumeroElement = null, param4:Boolean = false)
        {
            super(param1, true);
            this.message = param2;
            this.data = param3;
            this.fromKeyboard = param4;
            return;
        }// end function

    }
}
