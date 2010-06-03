package 
{
    import flash.display.*;
    import it.vodafone.*;
    import mx.binding.*;
    import mx.core.*;

    public class _it_vodafone_LoadingWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
    {

        public function _it_vodafone_LoadingWatcherSetupUtil()
        {
            return;
        }// end function

        public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
        {
            param4[3] = new PropertyWatcher("button1", {propertyChange:true}, [param3[8]], param2);
            param4[2] = new PropertyWatcher("text2", {propertyChange:true}, [param3[3], param3[7]], param2);
            param4[1] = new PropertyWatcher("testoErrore", {propertyChange:true}, [param3[1], param3[5]], param2);
            param4[0] = new PropertyWatcher("canvas1", {propertyChange:true}, [param3[2], param3[4], param3[9], param3[11], param3[6], param3[0]], param2);
            param4[4] = new PropertyWatcher("text1", {propertyChange:true}, [param3[10]], param2);
            param4[3].updateParent(param1);
            param4[2].updateParent(param1);
            param4[1].updateParent(param1);
            param4[0].updateParent(param1);
            param4[4].updateParent(param1);
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            Loading.watcherSetupUtil = new _it_vodafone_LoadingWatcherSetupUtil;
            return;
        }// end function

    }
}
