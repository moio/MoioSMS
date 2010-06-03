package mx.effects
{
    import mx.effects.effectClasses.*;

    public class SetPropertyAction extends Effect
    {
        public var value:Object;
        public var name:String;
        static const VERSION:String = "3.2.0.3958";

        public function SetPropertyAction(param1:Object = null)
        {
            super(param1);
            instanceClass = SetPropertyActionInstance;
            return;
        }// end function

        override protected function initInstance(param1:IEffectInstance) : void
        {
            super.initInstance(param1);
            var _loc_2:* = SetPropertyActionInstance(param1);
            _loc_2.name = name;
            _loc_2.value = value;
            return;
        }// end function

        override public function getAffectedProperties() : Array
        {
            return [name];
        }// end function

    }
}
