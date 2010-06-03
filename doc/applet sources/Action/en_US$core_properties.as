package 
{
    import en_US$core_properties.*;
    import mx.resources.*;

    public class en_US$core_properties extends ResourceBundle
    {

        public function en_US$core_properties()
        {
            super("en_US", "core");
            return;
        }// end function

        override protected function getContent() : Object
        {
            var _loc_1:Object = {multipleChildSets_ClassAndInstance:"Multiple sets of visual children have been specified for this component (component definition and component instance).", truncationIndicator:"...", notExecuting:"Repeater is not executing.", versionAlreadyRead:"Compatibility version has already been read.", multipleChildSets_ClassAndSubclass:"Multiple sets of visual children have been specified for this component (base component definition and derived component definition).", viewSource:"View Source", badFile:"File does not exist.", stateUndefined:"Undefined state \'{0}\'.", versionAlreadySet:"Compatibility version has already been set."};
            return _loc_1;
        }// end function

    }
}
