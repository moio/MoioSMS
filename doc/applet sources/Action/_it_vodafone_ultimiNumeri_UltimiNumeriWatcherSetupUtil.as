package 
{
    import flash.display.*;
    import it.vodafone.ultimiNumeri.*;
    import mx.binding.*;
    import mx.core.*;

    public class _it_vodafone_ultimiNumeri_UltimiNumeriWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
    {

        public function _it_vodafone_ultimiNumeri_UltimiNumeriWatcherSetupUtil()
        {
            return;
        }// end function

        public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
        {
            param4[0] = new PropertyWatcher("_currentUltimiNumeriUserList", {propertyChange:true}, [param3[0]], param2);
            param4[1] = new PropertyWatcher("_errorText", {propertyChange:true}, [param3[1]], param2);
            param4[0].updateParent(param1);
            param4[1].updateParent(param1);
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            UltimiNumeri.watcherSetupUtil = new _it_vodafone_ultimiNumeri_UltimiNumeriWatcherSetupUtil;
            return;
        }// end function

    }
}
