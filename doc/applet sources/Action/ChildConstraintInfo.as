package 
{

    private class ChildConstraintInfo extends Object
    {
        public var baseline:Number;
        public var left:Number;
        public var baselineBoundary:String;
        public var leftBoundary:String;
        public var hcBoundary:String;
        public var top:Number;
        public var right:Number;
        public var topBoundary:String;
        public var rightBoundary:String;
        public var bottom:Number;
        public var vc:Number;
        public var bottomBoundary:String;
        public var vcBoundary:String;
        public var hc:Number;

        private function ChildConstraintInfo(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:String = null, param9:String = null, param10:String = null, param11:String = null, param12:String = null, param13:String = null, param14:String = null) : void
        {
            this.left = param1;
            this.right = param2;
            this.hc = param3;
            this.top = param4;
            this.bottom = param5;
            this.vc = param6;
            this.baseline = param7;
            this.leftBoundary = param8;
            this.rightBoundary = param9;
            this.hcBoundary = param10;
            this.topBoundary = param11;
            this.bottomBoundary = param12;
            this.vcBoundary = param13;
            this.baselineBoundary = param14;
            return;
        }// end function

    }
}
