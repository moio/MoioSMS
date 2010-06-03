package 
{
    import flash.display.*;
    import it.vodafone.*;
    import mx.binding.*;
    import mx.core.*;

    public class _it_vodafone_RssTitleWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
    {

        public function _it_vodafone_RssTitleWatcherSetupUtil()
        {
            return;
        }// end function

        public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
        {
            param4[0] = new PropertyWatcher("testo", {propertyChange:true}, [param3[0]], param2);
            param4[0].updateParent(param1);
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            RssTitle.watcherSetupUtil = new _it_vodafone_RssTitleWatcherSetupUtil;
            return;
        }// end function

    }
}
