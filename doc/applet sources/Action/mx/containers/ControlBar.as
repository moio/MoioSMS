package mx.containers
{
    import mx.core.*;

    public class ControlBar extends Box
    {
        static const VERSION:String = "3.2.0.3958";

        public function ControlBar()
        {
            direction = BoxDirection.HORIZONTAL;
            return;
        }// end function

        override public function set verticalScrollPolicy(param1:String) : void
        {
            return;
        }// end function

        override public function set horizontalScrollPolicy(param1:String) : void
        {
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            if (contentPane)
            {
                contentPane.opaqueBackground = null;
            }
            return;
        }// end function

        override public function set enabled(param1:Boolean) : void
        {
            if (param1 != super.enabled)
            {
                super.enabled = param1;
                alpha = param1 ? (1) : (0.4);
            }
            return;
        }// end function

        override public function get horizontalScrollPolicy() : String
        {
            return ScrollPolicy.OFF;
        }// end function

        override public function invalidateSize() : void
        {
            super.invalidateSize();
            if (parent)
            {
                Container(parent).invalidateViewMetricsAndPadding();
            }
            return;
        }// end function

        override public function get verticalScrollPolicy() : String
        {
            return ScrollPolicy.OFF;
        }// end function

        override public function set includeInLayout(param1:Boolean) : void
        {
            var _loc_2:Container = null;
            if (includeInLayout != param1)
            {
                super.includeInLayout = param1;
                _loc_2 = parent as Container;
                if (_loc_2)
                {
                    _loc_2.invalidateViewMetricsAndPadding();
                }
            }
            return;
        }// end function

    }
}
