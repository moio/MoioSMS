package 
{
    import flash.display.*;
    import it.vodafone.rubrica.*;
    import mx.binding.*;
    import mx.core.*;

    public class _it_vodafone_rubrica_RubricaWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
    {

        public function _it_vodafone_rubrica_RubricaWatcherSetupUtil()
        {
            return;
        }// end function

        public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
        {
            param4[0] = new PropertyWatcher("_currentRubricaUserList", {propertyChange:true}, [param3[0]], param2);
            param4[3] = new PropertyWatcher("aggiungi_contatto", {propertyChange:true}, [param3[4], param3[6], param3[5]], param2);
            param4[1] = new PropertyWatcher("_errorText", {propertyChange:true}, [param3[2], param3[8], param3[1]], param2);
            param4[4] = new PropertyWatcher("image1", {propertyChange:true}, [param3[7]], param2);
            param4[0].updateParent(param1);
            param4[3].updateParent(param1);
            param4[1].updateParent(param1);
            param4[4].updateParent(param1);
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            Rubrica.watcherSetupUtil = new _it_vodafone_rubrica_RubricaWatcherSetupUtil;
            return;
        }// end function

    }
}
