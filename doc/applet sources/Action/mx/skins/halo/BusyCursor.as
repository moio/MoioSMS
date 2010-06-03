package mx.skins.halo
{
    import flash.display.*;
    import flash.events.*;
    import mx.core.*;
    import mx.styles.*;

    public class BusyCursor extends FlexSprite
    {
        private var hourHand:Shape;
        private var minuteHand:Shape;
        static const VERSION:String = "3.2.0.3958";

        public function BusyCursor()
        {
            var _loc_6:Graphics = null;
            var _loc_1:* = StyleManager.getStyleDeclaration("CursorManager");
            var _loc_2:* = _loc_1.getStyle("busyCursorBackground");
            var _loc_3:* = new _loc_2;
            if (_loc_3 is InteractiveObject)
            {
                InteractiveObject(_loc_3).mouseEnabled = false;
            }
            addChild(_loc_3);
            var _loc_4:Number = -0.5;
            var _loc_5:Number = -0.5;
            minuteHand = new FlexShape();
            minuteHand.name = "minuteHand";
            _loc_6 = minuteHand.graphics;
            _loc_6.beginFill(0);
            _loc_6.moveTo(_loc_4, _loc_5);
            _loc_6.lineTo(1 + _loc_4, 0 + _loc_5);
            _loc_6.lineTo(1 + _loc_4, 5 + _loc_5);
            _loc_6.lineTo(0 + _loc_4, 5 + _loc_5);
            _loc_6.lineTo(0 + _loc_4, 0 + _loc_5);
            _loc_6.endFill();
            addChild(minuteHand);
            hourHand = new FlexShape();
            hourHand.name = "hourHand";
            _loc_6 = hourHand.graphics;
            _loc_6.beginFill(0);
            _loc_6.moveTo(_loc_4, _loc_5);
            _loc_6.lineTo(4 + _loc_4, 0 + _loc_5);
            _loc_6.lineTo(4 + _loc_4, 1 + _loc_5);
            _loc_6.lineTo(0 + _loc_4, 1 + _loc_5);
            _loc_6.lineTo(0 + _loc_4, 0 + _loc_5);
            _loc_6.endFill();
            addChild(hourHand);
            addEventListener(Event.ADDED, handleAdded);
            addEventListener(Event.REMOVED, handleRemoved);
            return;
        }// end function

        private function enterFrameHandler(event:Event) : void
        {
            minuteHand.rotation = minuteHand.rotation + 12;
            hourHand.rotation = hourHand.rotation + 1;
            return;
        }// end function

        private function handleAdded(event:Event) : void
        {
            addEventListener(Event.ENTER_FRAME, enterFrameHandler);
            return;
        }// end function

        private function handleRemoved(event:Event) : void
        {
            removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
            return;
        }// end function

    }
}
