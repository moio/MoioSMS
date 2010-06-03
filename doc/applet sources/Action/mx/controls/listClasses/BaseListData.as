package mx.controls.listClasses
{
    import mx.core.*;

    public class BaseListData extends Object
    {
        private var _uid:String;
        public var owner:IUIComponent;
        public var label:String;
        public var rowIndex:int;
        public var columnIndex:int;
        static const VERSION:String = "3.2.0.3958";

        public function BaseListData(param1:String, param2:String, param3:IUIComponent, param4:int = 0, param5:int = 0)
        {
            this.label = param1;
            this.uid = param2;
            this.owner = param3;
            this.rowIndex = param4;
            this.columnIndex = param5;
            return;
        }// end function

        public function set uid(param1:String) : void
        {
            _uid = param1;
            return;
        }// end function

        public function get uid() : String
        {
            return _uid;
        }// end function

    }
}
