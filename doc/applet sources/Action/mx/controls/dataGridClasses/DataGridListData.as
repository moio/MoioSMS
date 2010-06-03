package mx.controls.dataGridClasses
{
    import mx.controls.listClasses.*;
    import mx.core.*;

    public class DataGridListData extends BaseListData
    {
        public var dataField:String;
        static const VERSION:String = "3.2.0.3958";

        public function DataGridListData(param1:String, param2:String, param3:int, param4:String, param5:IUIComponent, param6:int = 0)
        {
            super(param1, param4, param5, param6, param3);
            this.dataField = param2;
            return;
        }// end function

    }
}
