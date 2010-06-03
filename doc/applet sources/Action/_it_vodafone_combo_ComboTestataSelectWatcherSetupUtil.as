package 
{
    import flash.display.*;
    import it.vodafone.combo.*;
    import mx.binding.*;
    import mx.core.*;

    public class _it_vodafone_combo_ComboTestataSelectWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
    {

        public function _it_vodafone_combo_ComboTestataSelectWatcherSetupUtil()
        {
            return;
        }// end function

        public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
        {
            param4[0] = new PropertyWatcher("lista", {propertyChange:true}, [param3[0]], param2);
            param4[2] = new PropertyWatcher("rp", {propertyChange:true}, [param3[1]], param2);
            param4[3] = new PropertyWatcher("dataProvider", {collectionChange:true}, [param3[1]], null);
            param4[0].updateParent(param1);
            param4[2].updateParent(param1);
            param4[2].addChild(param4[3]);
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            ComboTestataSelect.watcherSetupUtil = new _it_vodafone_combo_ComboTestataSelectWatcherSetupUtil;
            return;
        }// end function

    }
}
