package mx.effects.effectClasses
{
    import mx.effects.*;

    public class HideShowEffectTargetFilter extends EffectTargetFilter
    {
        public var show:Boolean = true;
        static const VERSION:String = "3.2.0.3958";

        public function HideShowEffectTargetFilter()
        {
            filterProperties = ["visible"];
            return;
        }// end function

        override protected function defaultFilterFunction(param1:Array, param2:Object) : Boolean
        {
            var _loc_5:PropertyChanges = null;
            var _loc_3:* = param1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = param1[_loc_4];
                if (_loc_5.target == param2)
                {
                    return _loc_5.end["visible"] == show;
                }
                _loc_4++;
            }
            return false;
        }// end function

    }
}
