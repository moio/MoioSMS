package mx.skins
{
    import flash.geom.*;
    import mx.core.*;
    import mx.styles.*;
    import mx.utils.*;

    public class ProgrammaticSkin extends FlexShape implements IFlexDisplayObject, IInvalidating, ILayoutManagerClient, ISimpleStyleClient, IProgrammaticSkin
    {
        private var _initialized:Boolean = false;
        private var _height:Number;
        private var invalidateDisplayListFlag:Boolean = false;
        private var _styleName:IStyleClient;
        private var _nestLevel:int = 0;
        private var _processedDescriptors:Boolean = false;
        private var _updateCompletePendingFlag:Boolean = true;
        private var _width:Number;
        static const VERSION:String = "3.2.0.3958";
        private static var tempMatrix:Matrix = new Matrix();

        public function ProgrammaticSkin()
        {
            _width = measuredWidth;
            _height = measuredHeight;
            return;
        }// end function

        public function getStyle(param1:String)
        {
            return _styleName ? (_styleName.getStyle(param1)) : (null);
        }// end function

        protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            return;
        }// end function

        public function get nestLevel() : int
        {
            return _nestLevel;
        }// end function

        public function set nestLevel(param1:int) : void
        {
            _nestLevel = param1;
            invalidateDisplayList();
            return;
        }// end function

        override public function get height() : Number
        {
            return _height;
        }// end function

        public function get updateCompletePendingFlag() : Boolean
        {
            return _updateCompletePendingFlag;
        }// end function

        protected function verticalGradientMatrix(param1:Number, param2:Number, param3:Number, param4:Number) : Matrix
        {
            return rotatedGradientMatrix(param1, param2, param3, param4, 90);
        }// end function

        public function validateSize(param1:Boolean = false) : void
        {
            return;
        }// end function

        public function invalidateDisplayList() : void
        {
            if (!invalidateDisplayListFlag && nestLevel > 0)
            {
                invalidateDisplayListFlag = true;
                UIComponentGlobals.layoutManager.invalidateDisplayList(this);
            }
            return;
        }// end function

        public function set updateCompletePendingFlag(param1:Boolean) : void
        {
            _updateCompletePendingFlag = param1;
            return;
        }// end function

        protected function horizontalGradientMatrix(param1:Number, param2:Number, param3:Number, param4:Number) : Matrix
        {
            return rotatedGradientMatrix(param1, param2, param3, param4, 0);
        }// end function

        override public function set height(param1:Number) : void
        {
            _height = param1;
            invalidateDisplayList();
            return;
        }// end function

        public function set processedDescriptors(param1:Boolean) : void
        {
            _processedDescriptors = param1;
            return;
        }// end function

        public function validateDisplayList() : void
        {
            invalidateDisplayListFlag = false;
            updateDisplayList(width, height);
            return;
        }// end function

        public function get measuredWidth() : Number
        {
            return 0;
        }// end function

        override public function set width(param1:Number) : void
        {
            _width = param1;
            invalidateDisplayList();
            return;
        }// end function

        public function get measuredHeight() : Number
        {
            return 0;
        }// end function

        public function set initialized(param1:Boolean) : void
        {
            _initialized = param1;
            return;
        }// end function

        protected function drawRoundRect(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object = null, param6:Object = null, param7:Object = null, param8:Matrix = null, param9:String = "linear", param10:Array = null, param11:Object = null) : void
        {
            var _loc_13:Number = NaN;
            var _loc_14:Array = null;
            var _loc_15:Object = null;
            var _loc_12:* = graphics;
            if (param3 == 0 || param4 == 0)
            {
                return;
            }
            if (param6 !== null)
            {
                if (param6 is uint)
                {
                    _loc_12.beginFill(uint(param6), Number(param7));
                }
                else if (param6 is Array)
                {
                    _loc_14 = param7 is Array ? (param7 as Array) : ([param7, param7]);
                    if (!param10)
                    {
                        param10 = [0, 255];
                    }
                    _loc_12.beginGradientFill(param9, param6 as Array, _loc_14, param10, param8);
                }
            }
            if (!param5)
            {
                _loc_12.drawRect(param1, param2, param3, param4);
            }
            else if (param5 is Number)
            {
                _loc_13 = Number(param5) * 2;
                _loc_12.drawRoundRect(param1, param2, param3, param4, _loc_13, _loc_13);
            }
            else
            {
                GraphicsUtil.drawRoundRectComplex(_loc_12, param1, param2, param3, param4, param5.tl, param5.tr, param5.bl, param5.br);
            }
            if (param11)
            {
                _loc_15 = param11.r;
                if (_loc_15 is Number)
                {
                    _loc_13 = Number(_loc_15) * 2;
                    _loc_12.drawRoundRect(param11.x, param11.y, param11.w, param11.h, _loc_13, _loc_13);
                }
                else
                {
                    GraphicsUtil.drawRoundRectComplex(_loc_12, param11.x, param11.y, param11.w, param11.h, _loc_15.tl, _loc_15.tr, _loc_15.bl, _loc_15.br);
                }
            }
            if (param6 !== null)
            {
                _loc_12.endFill();
            }
            return;
        }// end function

        public function get processedDescriptors() : Boolean
        {
            return _processedDescriptors;
        }// end function

        public function set styleName(param1:Object) : void
        {
            if (_styleName != param1)
            {
                _styleName = param1 as IStyleClient;
                invalidateDisplayList();
            }
            return;
        }// end function

        public function setActualSize(param1:Number, param2:Number) : void
        {
            var _loc_3:Boolean = false;
            if (_width != param1)
            {
                _width = param1;
                _loc_3 = true;
            }
            if (_height != param2)
            {
                _height = param2;
                _loc_3 = true;
            }
            if (_loc_3)
            {
                invalidateDisplayList();
            }
            return;
        }// end function

        public function styleChanged(param1:String) : void
        {
            invalidateDisplayList();
            return;
        }// end function

        override public function get width() : Number
        {
            return _width;
        }// end function

        public function invalidateProperties() : void
        {
            return;
        }// end function

        public function get initialized() : Boolean
        {
            return _initialized;
        }// end function

        protected function rotatedGradientMatrix(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Matrix
        {
            tempMatrix.createGradientBox(param3, param4, param5 * Math.PI / 180, param1, param2);
            return tempMatrix;
        }// end function

        public function move(param1:Number, param2:Number) : void
        {
            this.x = param1;
            this.y = param2;
            return;
        }// end function

        public function get styleName() : Object
        {
            return _styleName;
        }// end function

        public function validateNow() : void
        {
            if (invalidateDisplayListFlag)
            {
                validateDisplayList();
            }
            return;
        }// end function

        public function invalidateSize() : void
        {
            return;
        }// end function

        public function validateProperties() : void
        {
            return;
        }// end function

    }
}
