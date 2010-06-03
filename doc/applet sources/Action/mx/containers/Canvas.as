package mx.containers
{
    import mx.containers.utilityClasses.*;
    import mx.core.*;

    public class Canvas extends Container implements IConstraintLayout
    {
        private var _constraintColumns:Array;
        private var layoutObject:CanvasLayout;
        private var _constraintRows:Array;
        static const VERSION:String = "3.2.0.3958";

        public function Canvas()
        {
            layoutObject = new CanvasLayout();
            _constraintColumns = [];
            _constraintRows = [];
            layoutObject.target = this;
            return;
        }// end function

        public function get constraintColumns() : Array
        {
            return _constraintColumns;
        }// end function

        override function get usePadding() : Boolean
        {
            return false;
        }// end function

        public function set constraintRows(param1:Array) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            if (param1 != _constraintRows)
            {
                _loc_2 = param1.length;
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    ConstraintRow(param1[_loc_3]).container = this;
                    _loc_3++;
                }
                _constraintRows = param1;
                invalidateSize();
                invalidateDisplayList();
            }
            return;
        }// end function

        public function get constraintRows() : Array
        {
            return _constraintRows;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            layoutObject.updateDisplayList(param1, param2);
            return;
        }// end function

        public function set constraintColumns(param1:Array) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            if (param1 != _constraintColumns)
            {
                _loc_2 = param1.length;
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    ConstraintColumn(param1[_loc_3]).container = this;
                    _loc_3++;
                }
                _constraintColumns = param1;
                invalidateSize();
                invalidateDisplayList();
            }
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            layoutObject.measure();
            return;
        }// end function

    }
}
