package 
{
    import flash.display.*;
    import it.vodafone.*;
    import mx.binding.*;
    import mx.core.*;

    public class _it_vodafone_SmsWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
    {

        public function _it_vodafone_SmsWatcherSetupUtil()
        {
            return;
        }// end function

        public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
        {
            param4[11] = new PropertyWatcher("maxSms", {propertyChange:true}, [param3[19], param3[20]], param2);
            param4[0] = new PropertyWatcher("button1", {propertyChange:true}, [param3[2], param3[4], param3[9], param3[8], param3[7], param3[5], param3[0]], param2);
            param4[4] = new PropertyWatcher("maxChars", {propertyChange:true}, [param3[15], param3[12]], param2);
            param4[7] = new PropertyWatcher("currentChars", {propertyChange:true}, [param3[15]], param2);
            param4[1] = new PropertyWatcher("_errorText", {propertyChange:true}, [param3[6], param3[1], param3[3]], param2);
            param4[11].updateParent(param1);
            param4[0].updateParent(param1);
            param4[4].updateParent(param1);
            param4[7].updateParent(param1);
            param4[1].updateParent(param1);
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            Sms.watcherSetupUtil = new _it_vodafone_SmsWatcherSetupUtil;
            return;
        }// end function

    }
}
