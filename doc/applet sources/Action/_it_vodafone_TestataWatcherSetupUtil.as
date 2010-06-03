package 
{
    import flash.display.*;
    import it.vodafone.*;
    import mx.binding.*;
    import mx.core.*;

    public class _it_vodafone_TestataWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
    {

        public function _it_vodafone_TestataWatcherSetupUtil()
        {
            return;
        }// end function

        public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
        {
            param4[3] = new PropertyWatcher("_msisdnList", {propertyChange:true}, [param3[2]], param2);
            param4[4] = new PropertyWatcher("ldr", {propertyChange:true}, [param3[3]], param2);
            param4[2] = new PropertyWatcher("displayNameColor", {propertyChange:true}, [param3[1]], param2);
            param4[1] = new PropertyWatcher("displayName", {propertyChange:true}, [param3[0]], param2);
            param4[3].updateParent(param1);
            param4[4].updateParent(param1);
            param4[2].updateParent(param1);
            param4[1].updateParent(param1);
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            Testata.watcherSetupUtil = new _it_vodafone_TestataWatcherSetupUtil;
            return;
        }// end function

    }
}
