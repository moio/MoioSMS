package org.papervision3d.core.proto
{
    import flash.events.*;
    import flash.utils.*;
    import org.papervision3d.core.log.*;
    import org.papervision3d.objects.*;

    public class DisplayObjectContainer3D extends EventDispatcher
    {
        protected var _childrenByName:Object;
        public var root:DisplayObjectContainer3D;
        private var _childrenTotal:int;
        protected var _children:Dictionary;

        public function DisplayObjectContainer3D() : void
        {
            this._children = new Dictionary(false);
            this._childrenByName = new Dictionary(true);
            this._childrenTotal = 0;
            return;
        }// end function

        private function findChildByName(param1:String, param2:DisplayObject3D = null) : DisplayObject3D
        {
            var _loc_3:DisplayObject3D = null;
            var _loc_4:DisplayObject3D = null;
            if (!param2)
            {
            }
            param2 = DisplayObject3D(this);
            if (!param2)
            {
                return null;
            }
            if (param2.name == param1)
            {
                return param2;
            }
            for each (_loc_3 in param2.children)
            {
                
                _loc_4 = this.findChildByName(param1, _loc_3);
                if (_loc_4)
                {
                    return _loc_4;
                }
            }
            return null;
        }// end function

        public function getChildByName(param1:String, param2:Boolean = false) : DisplayObject3D
        {
            if (param2)
            {
                return this.findChildByName(param1);
            }
            return this._childrenByName[param1];
        }// end function

        override public function toString() : String
        {
            return this.childrenList();
        }// end function

        public function addChildren(param1:DisplayObject3D) : DisplayObjectContainer3D
        {
            var _loc_2:DisplayObject3D = null;
            for each (_loc_2 in param1.children)
            {
                
                param1.removeChild(_loc_2);
                this.addChild(_loc_2);
            }
            return this;
        }// end function

        public function get numChildren() : int
        {
            return this._childrenTotal;
        }// end function

        public function removeChild(param1:DisplayObject3D) : DisplayObject3D
        {
            if (param1 && this._children[param1])
            {
                delete this._childrenByName[this._children[param1]];
                delete this._children[param1];
                param1.parent = null;
                param1.root = null;
                var _loc_2:String = this;
                _loc_2._childrenTotal = this._childrenTotal--;
                return param1;
            }
            return null;
        }// end function

        public function removeChildByName(param1:String) : DisplayObject3D
        {
            return this.removeChild(this.getChildByName(param1));
        }// end function

        public function addChild(param1:DisplayObject3D, param2:String = null) : DisplayObject3D
        {
            if (param1.parent)
            {
                PaperLogger.error("DisplayObjectContainer.addChild : DisplayObject3D already has a parent, ie is already added to scene.");
            }
            if (!(param2 || param1.name))
            {
            }
            param2 = String(param1.id);
            this._children[param1] = param2;
            this._childrenByName[param2] = param1;
            var _loc_3:String = this;
            _loc_3._childrenTotal = this._childrenTotal++;
            param1.parent = this;
            param1.root = this.root;
            return param1;
        }// end function

        public function childrenList() : String
        {
            var _loc_2:String = null;
            var _loc_1:String = "";
            for (_loc_2 in this._children)
            {
                
                _loc_1 = _loc_1 + (_loc_2 + "\n");
            }
            return _loc_1;
        }// end function

        public function get children() : Object
        {
            return this._childrenByName;
        }// end function

    }
}
