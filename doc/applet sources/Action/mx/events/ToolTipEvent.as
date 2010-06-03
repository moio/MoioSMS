package mx.events
{
    import flash.events.*;
    import mx.core.*;

    public class ToolTipEvent extends Event
    {
        public var toolTip:IToolTip;
        public static const TOOL_TIP_SHOWN:String = "toolTipShown";
        public static const TOOL_TIP_CREATE:String = "toolTipCreate";
        public static const TOOL_TIP_SHOW:String = "toolTipShow";
        public static const TOOL_TIP_HIDE:String = "toolTipHide";
        public static const TOOL_TIP_END:String = "toolTipEnd";
        static const VERSION:String = "3.2.0.3958";
        public static const TOOL_TIP_START:String = "toolTipStart";

        public function ToolTipEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:IToolTip = null)
        {
            super(param1, param2, param3);
            this.toolTip = param4;
            return;
        }// end function

        override public function clone() : Event
        {
            return new ToolTipEvent(type, bubbles, cancelable, toolTip);
        }// end function

    }
}
