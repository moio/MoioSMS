package mx.core
{

    public class SpriteAsset extends FlexSprite implements IFlexAsset, IFlexDisplayObject, IBorder
    {
        private var _measuredHeight:Number;
        private var _measuredWidth:Number;
        static const VERSION:String = "3.2.0.3958";

        public function SpriteAsset()
        {
            _measuredWidth = width;
            _measuredHeight = height;
            return;
        }// end function

        public function get measuredWidth() : Number
        {
            return _measuredWidth;
        }// end function

        public function get measuredHeight() : Number
        {
            return _measuredHeight;
        }// end function

        public function setActualSize(param1:Number, param2:Number) : void
        {
            width = param1;
            height = param2;
            return;
        }// end function

        public function move(param1:Number, param2:Number) : void
        {
            this.x = param1;
            this.y = param2;
            return;
        }// end function

        public function get borderMetrics() : EdgeMetrics
        {
            if (scale9Grid == null)
            {
                return EdgeMetrics.EMPTY;
            }
            return new EdgeMetrics(scale9Grid.left, scale9Grid.top, Math.ceil(measuredWidth - scale9Grid.right), Math.ceil(measuredHeight - scale9Grid.bottom));
        }// end function

    }
}
