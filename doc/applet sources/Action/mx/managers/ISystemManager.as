package mx.managers
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import mx.core.*;

    public interface ISystemManager extends IEventDispatcher, IChildList, IFlexModuleFactory
    {

        public function ISystemManager();

        function set focusPane(param1:Sprite) : void;

        function get toolTipChildren() : IChildList;

        function useSWFBridge() : Boolean;

        function isFontFaceEmbedded(param1:TextFormat) : Boolean;

        function deployMouseShields(param1:Boolean) : void;

        function get rawChildren() : IChildList;

        function get topLevelSystemManager() : ISystemManager;

        function dispatchEventFromSWFBridges(event:Event, param2:IEventDispatcher = null, param3:Boolean = false, param4:Boolean = false) : void;

        function getSandboxRoot() : DisplayObject;

        function get swfBridgeGroup() : ISWFBridgeGroup;

        function removeFocusManager(param1:IFocusManagerContainer) : void;

        function addChildToSandboxRoot(param1:String, param2:DisplayObject) : void;

        function get document() : Object;

        function get focusPane() : Sprite;

        function get loaderInfo() : LoaderInfo;

        function addChildBridge(param1:IEventDispatcher, param2:DisplayObject) : void;

        function getTopLevelRoot() : DisplayObject;

        function removeChildBridge(param1:IEventDispatcher) : void;

        function isDisplayObjectInABridgedApplication(param1:DisplayObject) : Boolean;

        function get popUpChildren() : IChildList;

        function get screen() : Rectangle;

        function removeChildFromSandboxRoot(param1:String, param2:DisplayObject) : void;

        function getDefinitionByName(param1:String) : Object;

        function activate(param1:IFocusManagerContainer) : void;

        function deactivate(param1:IFocusManagerContainer) : void;

        function get cursorChildren() : IChildList;

        function set document(param1:Object) : void;

        function get embeddedFontList() : Object;

        function set numModalWindows(param1:int) : void;

        function isTopLevel() : Boolean;

        function isTopLevelRoot() : Boolean;

        function get numModalWindows() : int;

        function addFocusManager(param1:IFocusManagerContainer) : void;

        function get stage() : Stage;

        function getVisibleApplicationRect(param1:Rectangle = null) : Rectangle;

    }
}
