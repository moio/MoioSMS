package 
{
    import flash.display.*;
    import it.vodafone.*;
    import mx.core.*;

    public class _it_vodafone_SkinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
    {

        public function _it_vodafone_SkinWatcherSetupUtil()
        {
            return;
        }// end function

        public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            Skin.watcherSetupUtil = new _it_vodafone_SkinWatcherSetupUtil;
            return;
        }// end function

    }
}
