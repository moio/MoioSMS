package org.papervision3d.events
{
    import flash.events.*;
    import org.papervision3d.core.render.data.*;

    public class RendererEvent extends Event
    {
        public var renderSessionData:RenderSessionData;
        public static const PROJECTION_DONE:String = "projectionDone";
        public static const RENDER_DONE:String = "renderDone";

        public function RendererEvent(param1:String, param2:RenderSessionData)
        {
            super(param1);
            this.renderSessionData = param2;
            return;
        }// end function

        public function clear() : void
        {
            this.renderSessionData = null;
            return;
        }// end function

        override public function clone() : Event
        {
            return new RendererEvent(type, this.renderSessionData);
        }// end function

    }
}
