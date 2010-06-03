package mx.containers.utilityClasses
{
    import flash.events.*;
    import mx.core.*;

    public class ConstraintRow extends EventDispatcher implements IMXMLObject
    {
        private var _container:IInvalidating;
        var _height:Number;
        private var _explicitMinHeight:Number;
        private var _y:Number;
        private var _percentHeight:Number;
        private var _explicitMaxHeight:Number;
        var contentSize:Boolean = false;
        private var _explicitHeight:Number;
        private var _id:String;
        static const VERSION:String = "3.2.0.3958";

        public function ConstraintRow()
        {
            return;
        }// end function

        public function get container() : IInvalidating
        {
            return _container;
        }// end function

        public function set container(param1:IInvalidating) : void
        {
            _container = param1;
            return;
        }// end function

        public function set y(param1:Number) : void
        {
            if (param1 != _y)
            {
                _y = param1;
                dispatchEvent(new Event("yChanged"));
            }
            return;
        }// end function

        public function set height(param1:Number) : void
        {
            if (explicitHeight != param1)
            {
                explicitHeight = param1;
                if (_height != param1)
                {
                    _height = param1;
                    if (container)
                    {
                        container.invalidateSize();
                        container.invalidateDisplayList();
                    }
                    dispatchEvent(new Event("heightChanged"));
                }
            }
            return;
        }// end function

        public function set maxHeight(param1:Number) : void
        {
            if (_explicitMaxHeight != param1)
            {
                _explicitMaxHeight = param1;
                if (container)
                {
                    container.invalidateSize();
                    container.invalidateDisplayList();
                }
                dispatchEvent(new Event("maxHeightChanged"));
            }
            return;
        }// end function

        public function setActualHeight(param1:Number) : void
        {
            if (_height != param1)
            {
                _height = param1;
                dispatchEvent(new Event("heightChanged"));
            }
            return;
        }// end function

        public function get minHeight() : Number
        {
            return _explicitMinHeight;
        }// end function

        public function get id() : String
        {
            return _id;
        }// end function

        public function set percentHeight(param1:Number) : void
        {
            if (_percentHeight == param1)
            {
                return;
            }
            if (!isNaN(param1))
            {
                _explicitHeight = NaN;
            }
            _percentHeight = param1;
            if (container)
            {
                container.invalidateSize();
                container.invalidateDisplayList();
            }
            return;
        }// end function

        public function initialized(param1:Object, param2:String) : void
        {
            this.id = param2;
            if (!this.height && !this.percentHeight)
            {
                contentSize = true;
            }
            return;
        }// end function

        public function get percentHeight() : Number
        {
            return _percentHeight;
        }// end function

        public function get height() : Number
        {
            return _height;
        }// end function

        public function get maxHeight() : Number
        {
            return _explicitMaxHeight;
        }// end function

        public function set minHeight(param1:Number) : void
        {
            if (_explicitMinHeight != param1)
            {
                _explicitMinHeight = param1;
                if (container)
                {
                    container.invalidateSize();
                    container.invalidateDisplayList();
                }
                dispatchEvent(new Event("minHeightChanged"));
            }
            return;
        }// end function

        public function set id(param1:String) : void
        {
            _id = param1;
            return;
        }// end function

        public function get y() : Number
        {
            return _y;
        }// end function

        public function get explicitHeight() : Number
        {
            return _explicitHeight;
        }// end function

        public function set explicitHeight(param1:Number) : void
        {
            if (_explicitHeight == param1)
            {
                return;
            }
            if (!isNaN(param1))
            {
                _percentHeight = NaN;
            }
            _explicitHeight = param1;
            if (container)
            {
                container.invalidateSize();
                container.invalidateDisplayList();
            }
            dispatchEvent(new Event("explicitHeightChanged"));
            return;
        }// end function

    }
}
