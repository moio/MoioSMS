package 
{
    import mx.effects.*;

    private class EffectNode extends Object
    {
        public var factory:Effect;
        public var instance:EffectInstance;

        private function EffectNode(param1:Effect, param2:EffectInstance)
        {
            this.factory = param1;
            this.instance = param2;
            return;
        }// end function

    }
}
