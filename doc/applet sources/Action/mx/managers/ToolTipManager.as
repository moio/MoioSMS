package mx.managers
{
    import flash.display.*;
    import flash.events.*;
    import mx.core.*;
    import mx.effects.*;

    public class ToolTipManager extends EventDispatcher
    {
        private static var implClassDependency:ToolTipManagerImpl;
        static const VERSION:String = "3.2.0.3958";
        private static var _impl:IToolTipManager2;

        public function ToolTipManager()
        {
            return;
        }// end function

        static function registerToolTip(param1:DisplayObject, param2:String, param3:String) : void
        {
            impl.registerToolTip(param1, param2, param3);
            return;
        }// end function

        public static function get enabled() : Boolean
        {
            return impl.enabled;
        }// end function

        public static function set enabled(param1:Boolean) : void
        {
            impl.enabled = param1;
            return;
        }// end function

        public static function createToolTip(param1:String, param2:Number, param3:Number, param4:String = null, param5:IUIComponent = null) : IToolTip
        {
            return impl.createToolTip(param1, param2, param3, param4, param5);
        }// end function

        public static function set hideDelay(param1:Number) : void
        {
            impl.hideDelay = param1;
            return;
        }// end function

        public static function set showDelay(param1:Number) : void
        {
            impl.showDelay = param1;
            return;
        }// end function

        public static function get showDelay() : Number
        {
            return impl.showDelay;
        }// end function

        public static function destroyToolTip(param1:IToolTip) : void
        {
            return impl.destroyToolTip(param1);
        }// end function

        public static function get scrubDelay() : Number
        {
            return impl.scrubDelay;
        }// end function

        public static function get toolTipClass() : Class
        {
            return impl.toolTipClass;
        }// end function

        static function registerErrorString(param1:DisplayObject, param2:String, param3:String) : void
        {
            impl.registerErrorString(param1, param2, param3);
            return;
        }// end function

        static function sizeTip(param1:IToolTip) : void
        {
            impl.sizeTip(param1);
            return;
        }// end function

        public static function set currentTarget(param1:DisplayObject) : void
        {
            impl.currentTarget = param1;
            return;
        }// end function

        public static function set showEffect(param1:IAbstractEffect) : void
        {
            impl.showEffect = param1;
            return;
        }// end function

        private static function get impl() : IToolTipManager2
        {
            if (!_impl)
            {
                _impl = IToolTipManager2(Singleton.getInstance("mx.managers::IToolTipManager2"));
            }
            return _impl;
        }// end function

        public static function get hideDelay() : Number
        {
            return impl.hideDelay;
        }// end function

        public static function set hideEffect(param1:IAbstractEffect) : void
        {
            impl.hideEffect = param1;
            return;
        }// end function

        public static function set scrubDelay(param1:Number) : void
        {
            impl.scrubDelay = param1;
            return;
        }// end function

        public static function get currentToolTip() : IToolTip
        {
            return impl.currentToolTip;
        }// end function

        public static function set currentToolTip(param1:IToolTip) : void
        {
            impl.currentToolTip = param1;
            return;
        }// end function

        public static function get showEffect() : IAbstractEffect
        {
            return impl.showEffect;
        }// end function

        public static function get currentTarget() : DisplayObject
        {
            return impl.currentTarget;
        }// end function

        public static function get hideEffect() : IAbstractEffect
        {
            return impl.hideEffect;
        }// end function

        public static function set toolTipClass(param1:Class) : void
        {
            impl.toolTipClass = param1;
            return;
        }// end function

    }
}
