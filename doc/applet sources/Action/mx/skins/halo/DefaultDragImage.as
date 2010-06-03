package mx.skins.halo
{
    import mx.core.*;

    public class DefaultDragImage extends SpriteAsset implements IFlexDisplayObject
    {
        static const VERSION:String = "3.2.0.3958";

        public function DefaultDragImage()
        {
            draw(10, 10);
            return;
        }// end function

        override public function get measuredWidth() : Number
        {
            return 10;
        }// end function

        override public function move(param1:Number, param2:Number) : void
        {
            this.x = param1;
            this.y = param2;
            return;
        }// end function

        override public function get measuredHeight() : Number
        {
            return 10;
        }// end function

        override public function setActualSize(param1:Number, param2:Number) : void
        {
            draw(param1, param2);
            return;
        }// end function

        private function draw(param1:Number, param2:Number) : void
        {
            var _loc_3:* = graphics;
            _loc_3.clear();
            _loc_3.beginFill(15658734);
            _loc_3.lineStyle(1, 8433818);
            _loc_3.drawRect(0, 0, param1, param2);
            _loc_3.endFill();
            return;
        }// end function

    }
}
