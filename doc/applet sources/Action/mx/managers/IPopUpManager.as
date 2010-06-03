package mx.managers
{
    import flash.display.*;
    import mx.core.*;

    public interface IPopUpManager
    {

        public function IPopUpManager();

        function createPopUp(param1:DisplayObject, param2:Class, param3:Boolean = false, param4:String = null) : IFlexDisplayObject;

        function centerPopUp(param1:IFlexDisplayObject) : void;

        function removePopUp(param1:IFlexDisplayObject) : void;

        function addPopUp(param1:IFlexDisplayObject, param2:DisplayObject, param3:Boolean = false, param4:String = null) : void;

        function bringToFront(param1:IFlexDisplayObject) : void;

    }
}
