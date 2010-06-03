package mx.containers.utilityClasses
{
    import flash.events.*;
    import mx.core.*;

    public class ConstraintColumn extends EventDispatcher implements IMXMLObject
    {
        private var _container:IInvalidating;
        private var _explicitMinWidth:Number;
        var _width:Number;
        var contentSize:Boolean = false;
        private var _percentWidth:Number;
        private var _explicitWidth:Number;
        private var _explicitMaxWidth:Number;
        private var _x:Number;
        private var _id:String;
        static const VERSION:String = "3.2.0.3958";

        public function ConstraintColumn()
        {
            return;
        }// end function

        public function get container() : IInvalidating
        {
            return _container;
        }// end function

        public function get width() : Number
        {
            return _width;
        }// end function

        public function get percentWidth() : Number
        {
            return _percentWidth;
        }// end function

        public function set container(param1:IInvalidating) : void
        {
            _container = param1;
            return;
        }// end function

        public function set maxWidth(param1:Number) : void
        {
            if (_explicitMaxWidth != param1)
            {
                _explicitMaxWidth = param1;
                if (container)
                {
                    container.invalidateSize();
                    container.invalidateDisplayList();
                }
                dispatchEvent(new Event("maxWidthChanged"));
            }
            return;
        }// end function

        public function set width(param1:Number) : void
        {
            if (explicitWidth != param1)
            {
                explicitWidth = param1;
                if (_width != param1)
                {
                    _width = param1;
                    if (container)
                    {
                        container.invalidateSize();
                        container.invalidateDisplayList();
                    }
                    dispatchEvent(new Event("widthChanged"));
                }
            }
            return;
        }// end function

        public function get maxWidth() : Number
        {
            return _explicitMaxWidth;
        }// end function

        public function get minWidth() : Number
        {
            return _explicitMinWidth;
        }// end function

        public function get id() : String
        {
            return _id;
        }// end function

        public function initialized(param1:Object, param2:String) : void
        {
            this.id = param2;
            if (!this.width && !this.percentWidth)
            {
                contentSize = true;
            }
            return;
        }// end function

        public function set explicitWidth(param1:Number) : void
        {
            if (_explicitWidth == param1)
            {
                return;
            }
            if (!isNaN(param1))
            {
                _percentWidth = NaN;
            }
            _explicitWidth = param1;
            if (container)
            {
                container.invalidateSize();
                container.invalidateDisplayList();
            }
            dispatchEvent(new Event("explicitWidthChanged"));
            return;
        }// end function

        public function setActualWidth(param1:Number) : void
        {
            if (_width != param1)
            {
                _width = param1;
                dispatchEvent(new Event("widthChanged"));
            }
            return;
        }// end function

        public function set minWidth(param1:Number) : void
        {
            if (_explicitMinWidth != param1)
            {
                _explicitMinWidth = param1;
                if (container)
                {
                    container.invalidateSize();
                    container.invalidateDisplayList();
                }
                dispatchEvent(new Event("minWidthChanged"));
            }
            return;
        }// end function

        public function set percentWidth(param1:Number) : void
        {
            if (_percentWidth == param1)
            {
                return;
            }
            if (!isNaN(param1))
            {
                _explicitWidth = NaN;
            }
            _percentWidth = param1;
            if (container)
            {
                container.invalidateSize();
                container.invalidateDisplayList();
            }
            dispatchEvent(new Event("percentWidthChanged"));
            return;
        }// end function

        public function set x(param1:Number) : void
        {
            if (param1 != _x)
            {
                _x = param1;
                dispatchEvent(new Event("xChanged"));
            }
            return;
        }// end function

        public function get explicitWidth() : Number
        {
            return _explicitWidth;
        }// end function

        public function set id(param1:String) : void
        {
            _id = param1;
            return;
        }// end function

        public function get x() : Number
        {
            return _x;
        }// end function

    }
}
