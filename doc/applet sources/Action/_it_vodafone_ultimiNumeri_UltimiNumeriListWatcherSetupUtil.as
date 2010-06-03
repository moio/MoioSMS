package 
{
    import flash.display.*;
    import it.vodafone.ultimiNumeri.*;
    import mx.core.*;

    public class _it_vodafone_ultimiNumeri_UltimiNumeriListWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
    {

        public function _it_vodafone_ultimiNumeri_UltimiNumeriListWatcherSetupUtil()
        {
            return;
        }// end function

        public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            UltimiNumeriList.watcherSetupUtil = new _it_vodafone_ultimiNumeri_UltimiNumeriListWatcherSetupUtil;
            return;
        }// end function

    }
}
