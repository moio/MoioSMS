package mx.core
{
    import flash.events.*;
    import mx.containers.*;
    import mx.containers.utilityClasses.*;

    public class LayoutContainer extends Container implements IConstraintLayout
    {
        private var _constraintColumns:Array;
        protected var layoutObject:Layout;
        private var _layout:String = "vertical";
        private var processingCreationQueue:Boolean = false;
        protected var boxLayoutClass:Class;
        private var resizeHandlerAdded:Boolean = false;
        private var preloadObj:Object;
        private var creationQueue:Array;
        private var _constraintRows:Array;
        protected var canvasLayoutClass:Class;
        static const VERSION:String = "3.2.0.3958";
        static var useProgressiveLayout:Boolean = false;

        public function LayoutContainer()
        {
            layoutObject = new BoxLayout();
            canvasLayoutClass = CanvasLayout;
            boxLayoutClass = BoxLayout;
            creationQueue = [];
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
            return layout != ContainerLayout.ABSOLUTE;
        }// end function

        override protected function layoutChrome(param1:Number, param2:Number) : void
        {
            super.layoutChrome(param1, param2);
            if (!doingLayout)
            {
                createBorder();
            }
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

        public function set layout(param1:String) : void
        {
            if (_layout != param1)
            {
                _layout = param1;
                if (layoutObject)
                {
                    layoutObject.target = null;
                }
                if (_layout == ContainerLayout.ABSOLUTE)
                {
                    layoutObject = new canvasLayoutClass();
                }
                else
                {
                    layoutObject = new boxLayoutClass();
                    if (_layout == ContainerLayout.VERTICAL)
                    {
                        BoxLayout(layoutObject).direction = BoxDirection.VERTICAL;
                    }
                    else
                    {
                        BoxLayout(layoutObject).direction = BoxDirection.HORIZONTAL;
                    }
                }
                if (layoutObject)
                {
                    layoutObject.target = this;
                }
                invalidateSize();
                invalidateDisplayList();
                dispatchEvent(new Event("layoutChanged"));
            }
            return;
        }// end function

        public function get constraintRows() : Array
        {
            return _constraintRows;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            layoutObject.measure();
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            layoutObject.updateDisplayList(param1, param2);
            createBorder();
            return;
        }// end function

        public function get layout() : String
        {
            return _layout;
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

    }
}
