package mx.controls
{
    import flash.display.*;
    import flash.events.*;
    import mx.containers.*;
    import mx.controls.alertClasses.*;
    import mx.core.*;
    import mx.events.*;
    import mx.managers.*;
    import mx.resources.*;

    public class Alert extends Panel
    {
        var alertForm:AlertForm;
        public var defaultButtonFlag:uint = 4;
        public var text:String = "";
        public var buttonFlags:uint = 4;
        public var iconClass:Class;
        public static const NONMODAL:uint = 32768;
        static var createAccessibilityImplementation:Function;
        private static var cancelLabelOverride:String;
        private static var _resourceManager:IResourceManager;
        public static var buttonHeight:Number = 22;
        private static var noLabelOverride:String;
        private static var _yesLabel:String;
        private static var yesLabelOverride:String;
        public static var buttonWidth:Number = FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0 ? (60) : (65);
        static const VERSION:String = "3.2.0.3958";
        private static var _okLabel:String;
        public static const NO:uint = 2;
        public static const YES:uint = 1;
        private static var initialized:Boolean = false;
        private static var _cancelLabel:String;
        public static const OK:uint = 4;
        private static var okLabelOverride:String;
        private static var _noLabel:String;
        public static const CANCEL:uint = 8;

        public function Alert()
        {
            title = "";
            return;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            var _loc_2:String = null;
            super.styleChanged(param1);
            if (param1 == "messageStyleName")
            {
                _loc_2 = getStyle("messageStyleName");
                styleName = _loc_2;
            }
            if (alertForm)
            {
                alertForm.styleChanged(param1);
            }
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            var _loc_1:* = viewMetrics;
            measuredWidth = Math.max(measuredWidth, alertForm.getExplicitOrMeasuredWidth() + _loc_1.left + _loc_1.right);
            measuredHeight = alertForm.getExplicitOrMeasuredHeight() + _loc_1.top + _loc_1.bottom;
            return;
        }// end function

        override protected function resourcesChanged() : void
        {
            super.resourcesChanged();
            static_resourcesChanged();
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = viewMetrics;
            alertForm.setActualSize(param1 - _loc_3.left - _loc_3.right - getStyle("paddingLeft") - getStyle("paddingRight"), param2 - _loc_3.top - _loc_3.bottom - getStyle("paddingTop") - getStyle("paddingBottom"));
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            var _loc_1:* = getStyle("messageStyleName");
            if (_loc_1)
            {
                styleName = _loc_1;
            }
            if (!alertForm)
            {
                alertForm = new AlertForm();
                alertForm.styleName = this;
                addChild(alertForm);
            }
            return;
        }// end function

        override protected function initializeAccessibility() : void
        {
            if (Alert.createAccessibilityImplementation != null)
            {
                Alert.createAccessibilityImplementation(this);
            }
            return;
        }// end function

        private static function initialize() : void
        {
            if (!initialized)
            {
                resourceManager.addEventListener(Event.CHANGE, static_resourceManager_changeHandler, false, 0, true);
                static_resourcesChanged();
                initialized = true;
            }
            return;
        }// end function

        private static function static_resourcesChanged() : void
        {
            cancelLabel = cancelLabelOverride;
            noLabel = noLabelOverride;
            okLabel = okLabelOverride;
            yesLabel = yesLabelOverride;
            return;
        }// end function

        public static function get cancelLabel() : String
        {
            initialize();
            return _cancelLabel;
        }// end function

        public static function set yesLabel(param1:String) : void
        {
            yesLabelOverride = param1;
            _yesLabel = param1 != null ? (param1) : (resourceManager.getString("controls", "yesLabel"));
            return;
        }// end function

        private static function static_creationCompleteHandler(event:FlexEvent) : void
        {
            if (event.target is IFlexDisplayObject && event.eventPhase == EventPhase.AT_TARGET)
            {
                event.target.removeEventListener(FlexEvent.CREATION_COMPLETE, static_creationCompleteHandler);
                PopUpManager.centerPopUp(IFlexDisplayObject(event.target));
            }
            return;
        }// end function

        public static function get noLabel() : String
        {
            initialize();
            return _noLabel;
        }// end function

        public static function set cancelLabel(param1:String) : void
        {
            cancelLabelOverride = param1;
            _cancelLabel = param1 != null ? (param1) : (resourceManager.getString("controls", "cancelLabel"));
            return;
        }// end function

        private static function get resourceManager() : IResourceManager
        {
            if (!_resourceManager)
            {
                _resourceManager = ResourceManager.getInstance();
            }
            return _resourceManager;
        }// end function

        public static function get yesLabel() : String
        {
            initialize();
            return _yesLabel;
        }// end function

        public static function set noLabel(param1:String) : void
        {
            noLabelOverride = param1;
            _noLabel = param1 != null ? (param1) : (resourceManager.getString("controls", "noLabel"));
            return;
        }// end function

        private static function static_resourceManager_changeHandler(event:Event) : void
        {
            static_resourcesChanged();
            return;
        }// end function

        public static function set okLabel(param1:String) : void
        {
            okLabelOverride = param1;
            _okLabel = param1 != null ? (param1) : (resourceManager.getString("controls", "okLabel"));
            return;
        }// end function

        public static function get okLabel() : String
        {
            initialize();
            return _okLabel;
        }// end function

        public static function show(param1:String = "", param2:String = "", param3:uint = 4, param4:Sprite = null, param5:Function = null, param6:Class = null, param7:uint = 4) : Alert
        {
            var _loc_10:ISystemManager = null;
            var _loc_8:* = param3 & Alert.NONMODAL ? (false) : (true);
            if (!param4)
            {
                _loc_10 = ISystemManager(Application.application.systemManager);
                if (_loc_10.useSWFBridge())
                {
                    param4 = Sprite(_loc_10.getSandboxRoot());
                }
                else
                {
                    param4 = Sprite(Application.application);
                }
            }
            var _loc_9:* = new Alert;
            if (param3 & Alert.OK || param3 & Alert.CANCEL || param3 & Alert.YES || param3 & Alert.NO)
            {
                _loc_9.buttonFlags = param3;
            }
            if (param7 == Alert.OK || param7 == Alert.CANCEL || param7 == Alert.YES || param7 == Alert.NO)
            {
                _loc_9.defaultButtonFlag = param7;
            }
            _loc_9.text = param1;
            _loc_9.title = param2;
            _loc_9.iconClass = param6;
            if (param5 != null)
            {
                _loc_9.addEventListener(CloseEvent.CLOSE, param5);
            }
            if (param4 is UIComponent)
            {
                _loc_9.moduleFactory = UIComponent(param4).moduleFactory;
            }
            PopUpManager.addPopUp(_loc_9, param4, _loc_8);
            _loc_9.setActualSize(_loc_9.getExplicitOrMeasuredWidth(), _loc_9.getExplicitOrMeasuredHeight());
            _loc_9.addEventListener(FlexEvent.CREATION_COMPLETE, static_creationCompleteHandler);
            return _loc_9;
        }// end function

    }
}
