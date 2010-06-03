package it.vodafone.rubrica
{
    import flash.events.*;

    public class RubricaElementEvent extends Event
    {
        public var oldData:RubricaElement;
        public var message:String;
        public var fromKeyboard:Boolean;
        public var data:RubricaElement;
        public static const ERROR_EDIT:String = "errore_edit";
        public static const DELETE_EVENT_EDIT:String = "delete_event_edit";
        public static const EDIT_EVENT:String = "edit_event";
        public static const CURRENT_ITEM:String = "current_item";
        public static const DELETE_EVENT:String = "delete_event";
        public static const ERROR_INSERT:String = "errore_insert";
        public static const CREATED_ITEM:String = "created_item";
        public static const ADD_EVENT_EDIT:String = "add_event_edit";
        public static const SELECT_ELEMENT:String = "select_element";
        public static const ADD_EVENT:String = "add_event";

        public function RubricaElementEvent(param1:String, param2:String = "", param3:RubricaElement = null, param4:RubricaElement = null, param5 = false)
        {
            trace("RubricaElementEvent, name: " + param1);
            super(param1, true);
            this.message = param2;
            this.data = param3;
            this.oldData = param4;
            this.fromKeyboard = param5;
            return;
        }// end function

    }
}
