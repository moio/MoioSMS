package mx.core
{

    public class DragSource extends Object
    {
        private var formatHandlers:Object;
        private var dataHolder:Object;
        private var _formats:Array;
        static const VERSION:String = "3.2.0.3958";

        public function DragSource()
        {
            dataHolder = {};
            formatHandlers = {};
            _formats = [];
            return;
        }// end function

        public function hasFormat(param1:String) : Boolean
        {
            var _loc_2:* = _formats.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (_formats[_loc_3] == param1)
                {
                    return true;
                }
                _loc_3++;
            }
            return false;
        }// end function

        public function addData(param1:Object, param2:String) : void
        {
            _formats.push(param2);
            dataHolder[param2] = param1;
            return;
        }// end function

        public function dataForFormat(param1:String) : Object
        {
            var _loc_2:* = dataHolder[param1];
            if (_loc_2)
            {
                return _loc_2;
            }
            if (formatHandlers[param1])
            {
                var _loc_3:* = formatHandlers;
                return _loc_3.formatHandlers[param1]();
            }
            return null;
        }// end function

        public function addHandler(param1:Function, param2:String) : void
        {
            _formats.push(param2);
            formatHandlers[param2] = param1;
            return;
        }// end function

        public function get formats() : Array
        {
            return _formats;
        }// end function

    }
}
