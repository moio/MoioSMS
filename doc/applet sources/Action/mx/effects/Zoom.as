package mx.effects
{
    import mx.effects.effectClasses.*;

    public class Zoom extends TweenEffect
    {
        public var zoomHeightFrom:Number;
        public var zoomWidthTo:Number;
        public var originX:Number;
        public var zoomHeightTo:Number;
        public var originY:Number;
        public var captureRollEvents:Boolean;
        public var zoomWidthFrom:Number;
        static const VERSION:String = "3.2.0.3958";
        private static var AFFECTED_PROPERTIES:Array = ["scaleX", "scaleY", "x", "y", "width", "height"];

        public function Zoom(param1:Object = null)
        {
            super(param1);
            instanceClass = ZoomInstance;
            applyActualDimensions = false;
            relevantProperties = ["scaleX", "scaleY", "width", "height", "visible"];
            return;
        }// end function

        override protected function initInstance(param1:IEffectInstance) : void
        {
            var _loc_2:ZoomInstance = null;
            super.initInstance(param1);
            _loc_2 = ZoomInstance(param1);
            _loc_2.zoomWidthFrom = zoomWidthFrom;
            _loc_2.zoomWidthTo = zoomWidthTo;
            _loc_2.zoomHeightFrom = zoomHeightFrom;
            _loc_2.zoomHeightTo = zoomHeightTo;
            _loc_2.originX = originX;
            _loc_2.originY = originY;
            _loc_2.captureRollEvents = captureRollEvents;
            return;
        }// end function

        override public function getAffectedProperties() : Array
        {
            return AFFECTED_PROPERTIES;
        }// end function

    }
}
