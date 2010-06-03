package 
{
    import en_US$containers_properties.*;
    import mx.resources.*;

    public class en_US$containers_properties extends ResourceBundle
    {

        public function en_US$containers_properties()
        {
            super("en_US", "containers");
            return;
        }// end function

        override protected function getContent() : Object
        {
            var _loc_1:Object = {noColumnsFound:"No ConstraintColumns found.", noRowsFound:"No ConstraintRows found.", rowNotFound:"ConstraintRow \'{0}\' not found.", columnNotFound:"ConstraintColumn \'{0}\' not found."};
            return _loc_1;
        }// end function

    }
}
