package 
{
    import flash.display.*;
    import it.vodafone.rubrica.*;
    import mx.core.*;

    public class _it_vodafone_rubrica_RubricaListWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
    {

        public function _it_vodafone_rubrica_RubricaListWatcherSetupUtil()
        {
            return;
        }// end function

        public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            RubricaList.watcherSetupUtil = new _it_vodafone_rubrica_RubricaListWatcherSetupUtil;
            return;
        }// end function

    }
}
