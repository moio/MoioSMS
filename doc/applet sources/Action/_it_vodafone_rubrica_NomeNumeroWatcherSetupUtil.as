package 
{
    import flash.display.*;
    import it.vodafone.rubrica.*;
    import mx.binding.*;
    import mx.core.*;

    public class _it_vodafone_rubrica_NomeNumeroWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
    {

        public function _it_vodafone_rubrica_NomeNumeroWatcherSetupUtil()
        {
            return;
        }// end function

        public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
        {
            param4[0] = new PropertyWatcher("box_pencil", {propertyChange:true}, [param3[0]], param2);
            param4[1] = new PropertyWatcher("_itemData", {propertyChange:true}, [param3[2], param3[4], param3[1], param3[3]], param2);
            param4[0].updateParent(param1);
            param4[1].updateParent(param1);
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            NomeNumero.watcherSetupUtil = new _it_vodafone_rubrica_NomeNumeroWatcherSetupUtil;
            return;
        }// end function

    }
}
