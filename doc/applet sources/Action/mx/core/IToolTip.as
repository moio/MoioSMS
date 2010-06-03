package mx.core
{
    import flash.geom.*;

    public interface IToolTip extends IUIComponent
    {

        public function IToolTip();

        function set text(param1:String) : void;

        function get screen() : Rectangle;

        function get text() : String;

    }
}
