package 
{
    import flash.display.*;
    import it.vodafone.*;
    import mx.binding.*;
    import mx.core.*;

    public class _it_vodafone_InfocontoWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
    {

        public function _it_vodafone_InfocontoWatcherSetupUtil()
        {
            return;
        }// end function

        public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
        {
            param4[2] = new PropertyWatcher("textarea1", {propertyChange:true}, [param3[2]], param2);
            param4[5] = new PropertyWatcher("button1", {propertyChange:true}, [param3[6], param3[7], param3[5]], param2);
            param4[1] = new PropertyWatcher("label2", {propertyChange:true}, [param3[1]], param2);
            param4[6] = new PropertyWatcher("_testo", {propertyChange:true}, [param3[8]], param2);
            param4[8] = new PropertyWatcher("_ora", {propertyChange:true}, [param3[10]], param2);
            param4[7] = new PropertyWatcher("_titolo", {propertyChange:true}, [param3[9]], param2);
            param4[3] = new PropertyWatcher("canvas1", {propertyChange:true}, [param3[3]], param2);
            param4[0] = new PropertyWatcher("label1", {propertyChange:true}, [param3[0]], param2);
            param4[4] = new PropertyWatcher("_testoEsteso", {propertyChange:true}, [param3[4]], param2);
            param4[2].updateParent(param1);
            param4[5].updateParent(param1);
            param4[1].updateParent(param1);
            param4[6].updateParent(param1);
            param4[8].updateParent(param1);
            param4[7].updateParent(param1);
            param4[3].updateParent(param1);
            param4[0].updateParent(param1);
            param4[4].updateParent(param1);
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            Infoconto.watcherSetupUtil = new _it_vodafone_InfocontoWatcherSetupUtil;
            return;
        }// end function

    }
}
