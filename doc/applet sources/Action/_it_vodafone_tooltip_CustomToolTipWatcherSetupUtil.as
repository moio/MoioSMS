package 
{
    import flash.display.*;
    import it.vodafone.tooltip.*;
    import mx.core.*;

    public class _it_vodafone_tooltip_CustomToolTipWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
    {

        public function _it_vodafone_tooltip_CustomToolTipWatcherSetupUtil()
        {
            return;
        }// end function

        public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            CustomToolTip.watcherSetupUtil = new _it_vodafone_tooltip_CustomToolTipWatcherSetupUtil;
            return;
        }// end function

    }
}
