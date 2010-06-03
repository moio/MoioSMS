package 
{
    import flash.display.*;
    import mx.binding.*;
    import mx.core.*;

    public class _mainWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
    {

        public function _mainWatcherSetupUtil()
        {
            return;
        }// end function

        public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
        {
            param4[12] = new PropertyWatcher("msisdnList", {propertyChange:true}, [param3[13]], param2);
            param4[33] = new PropertyWatcher("rss_title_2_tx", {propertyChange:true}, [param3[38]], param2);
            param4[20] = new PropertyWatcher("rss_title_1_sl", {propertyChange:true}, [param3[24]], param2);
            param4[7] = new PropertyWatcher("_rememberMe", {propertyChange:true}, [param3[19], param3[7]], param2);
            param4[4] = new PropertyWatcher("_password", {propertyChange:true}, [param3[4]], param2);
            param4[35] = new PropertyWatcher("rss_title_4_tx", {propertyChange:true}, [param3[42]], param2);
            param4[24] = new PropertyWatcher("rss_title_2_visible", {propertyChange:true}, [param3[28], param3[39]], param2);
            param4[13] = new PropertyWatcher("ldr", {propertyChange:true}, [param3[15], param3[14]], param2);
            param4[9] = new PropertyWatcher("appVersion", {propertyChange:true}, [param3[45], param3[9]], param2);
            param4[34] = new PropertyWatcher("rss_title_3_tx", {propertyChange:true}, [param3[40]], param2);
            param4[11] = new PropertyWatcher("selectedMsisdn", {propertyChange:true}, [param3[12]], param2);
            param4[16] = new PropertyWatcher("loginSlave", {propertyChange:true}, [param3[20]], param2);
            param4[18] = new PropertyWatcher("_autostart", {propertyChange:true}, [param3[22]], param2);
            param4[2] = new PropertyWatcher("_username", {propertyChange:true}, [param3[2]], param2);
            param4[0] = new PropertyWatcher("windowCanvas", {propertyChange:true}, [param3[18], param3[46], param3[10], param3[0]], param2);
            param4[40] = new PropertyWatcher("wcanvas", {propertyChange:true}, [param3[58], param3[53], param3[56], param3[54]], param2);
            param4[5] = new PropertyWatcher("_hidePass", {propertyChange:true}, [param3[5]], param2);
            param4[29] = new PropertyWatcher("rss_title_4_sl", {propertyChange:true}, [param3[33]], param2);
            param4[39] = new PropertyWatcher("globalCanvas", {propertyChange:true}, [param3[62], param3[51], param3[60], param3[61], param3[50], param3[52], param3[49], param3[59]], param2);
            param4[32] = new PropertyWatcher("rss_title_1_tx", {propertyChange:true}, [param3[36]], param2);
            param4[23] = new PropertyWatcher("rss_title_2_sl", {propertyChange:true}, [param3[27]], param2);
            param4[26] = new PropertyWatcher("rss_title_3_sl", {propertyChange:true}, [param3[30]], param2);
            param4[42] = new PropertyWatcher("wcanvasTerms", {propertyChange:true}, [param3[57], param3[56]], param2);
            param4[30] = new PropertyWatcher("rss_title_4_visible", {propertyChange:true}, [param3[34], param3[43]], param2);
            param4[41] = new PropertyWatcher("wcanvas_console", {propertyChange:true}, [param3[53], param3[55]], param2);
            param4[27] = new PropertyWatcher("rss_title_3_visible", {propertyChange:true}, [param3[41], param3[31]], param2);
            param4[21] = new PropertyWatcher("rss_title_1_visible", {propertyChange:true}, [param3[37], param3[25]], param2);
            param4[10] = new PropertyWatcher("displayName", {propertyChange:true}, [param3[11]], param2);
            param4[12].updateParent(param1);
            param4[33].updateParent(param1);
            param4[20].updateParent(param1);
            param4[7].updateParent(param1);
            param4[4].updateParent(param1);
            param4[35].updateParent(param1);
            param4[24].updateParent(param1);
            param4[13].updateParent(param1);
            param4[9].updateParent(param1);
            param4[34].updateParent(param1);
            param4[11].updateParent(param1);
            param4[16].updateParent(param1);
            param4[18].updateParent(param1);
            param4[2].updateParent(param1);
            param4[0].updateParent(param1);
            param4[40].updateParent(param1);
            param4[5].updateParent(param1);
            param4[29].updateParent(param1);
            param4[39].updateParent(param1);
            param4[32].updateParent(param1);
            param4[23].updateParent(param1);
            param4[26].updateParent(param1);
            param4[42].updateParent(param1);
            param4[30].updateParent(param1);
            param4[41].updateParent(param1);
            param4[27].updateParent(param1);
            param4[21].updateParent(param1);
            param4[10].updateParent(param1);
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            main.watcherSetupUtil = new _mainWatcherSetupUtil;
            return;
        }// end function

    }
}
