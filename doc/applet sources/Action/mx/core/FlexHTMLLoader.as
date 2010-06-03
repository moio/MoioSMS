package mx.core
{
    import flash.html.*;
    import mx.utils.*;

    public class FlexHTMLLoader extends HTMLLoader implements IFocusManagerComplexComponent
    {
        private var _focusEnabled:Boolean = true;
        private var _mouseFocusEnabled:Boolean = true;
        static const VERSION:String = "3.2.0.3958";

        public function FlexHTMLLoader()
        {
            try
            {
                name = NameUtil.createUniqueName(this);
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        override public function toString() : String
        {
            return NameUtil.displayObjectToString(this);
        }// end function

        public function get focusEnabled() : Boolean
        {
            return _focusEnabled;
        }// end function

        public function assignFocus(param1:String) : void
        {
            stage.assignFocus(this, param1);
            return;
        }// end function

        public function get mouseFocusEnabled() : Boolean
        {
            return _mouseFocusEnabled;
        }// end function

        public function set focusEnabled(param1:Boolean) : void
        {
            _focusEnabled = param1;
            return;
        }// end function

        public function drawFocus(param1:Boolean) : void
        {
            return;
        }// end function

        public function setFocus() : void
        {
            stage.focus = this;
            return;
        }// end function

        public function set mouseFocusEnabled(param1:Boolean) : void
        {
            _mouseFocusEnabled = param1;
            return;
        }// end function

    }
}
