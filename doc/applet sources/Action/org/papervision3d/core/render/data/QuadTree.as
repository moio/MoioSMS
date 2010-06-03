package org.papervision3d.core.render.data
{
    import flash.display.*;
    import org.papervision3d.core.clipping.draw.*;
    import org.papervision3d.core.render.command.*;
    import org.papervision3d.objects.*;

    final public class QuadTree extends Object
    {
        private var _root:QuadTreeNode;
        private var _rect:RectangleClipping;
        private var _result:Array;
        private var _maxlevel:uint = 4;
        private var _maxX:Number;
        private var _maxY:Number;
        private var _child:RenderableListItem;
        private var _children:Array;
        private var _minX:Number;
        private var _minY:Number;
        private var i:int;
        private var _clip:Clipping;
        private var _center:Array;
        private var _except:DisplayObject3D;

        public function QuadTree()
        {
            return;
        }// end function

        public function get maxLevel() : uint
        {
            return this._maxlevel;
        }// end function

        public function remove(param1:RenderableListItem) : void
        {
            this._center = param1.quadrant.center;
            this._center.splice(this._center.indexOf(param1), 1);
            return;
        }// end function

        public function set maxLevel(param1:uint) : void
        {
            this._maxlevel = param1;
            if (this._root)
            {
                this._root.maxlevel = this._maxlevel;
            }
            return;
        }// end function

        public function getOverlaps(param1:RenderableListItem, param2:DisplayObject3D = null) : Array
        {
            this._result = [];
            this._minX = param1.minX;
            this._minY = param1.minY;
            this._maxX = param1.maxX;
            this._maxY = param1.maxY;
            this._except = param2;
            this.getList(param1.quadrant);
            this.getParent(param1.quadrant);
            return this._result;
        }// end function

        public function get clip() : Clipping
        {
            return this._clip;
        }// end function

        public function render(param1:RenderSessionData, param2:Graphics) : void
        {
            this._root.render(-Infinity, param1, param2);
            return;
        }// end function

        public function list() : Array
        {
            this._result = [];
            this._minX = -1000000;
            this._minY = -1000000;
            this._maxX = 1000000;
            this._maxY = 1000000;
            this._except = null;
            this.getList(this._root);
            return this._result;
        }// end function

        public function getRoot() : QuadTreeNode
        {
            return this._root;
        }// end function

        private function getList(param1:QuadTreeNode) : void
        {
            if (!param1)
            {
                return;
            }
            if (param1.onlysourceFlag && this._except == param1.onlysource)
            {
                return;
            }
            if (this._minX < param1.xdiv)
            {
                if (param1.lefttopFlag && this._minY < param1.ydiv)
                {
                    this.getList(param1.lefttop);
                }
                if (param1.leftbottomFlag && this._maxY > param1.ydiv)
                {
                    this.getList(param1.leftbottom);
                }
            }
            if (this._maxX > param1.xdiv)
            {
                if (param1.righttopFlag && this._minY < param1.ydiv)
                {
                    this.getList(param1.righttop);
                }
                if (param1.rightbottomFlag && this._maxY > param1.ydiv)
                {
                    this.getList(param1.rightbottom);
                }
            }
            this._children = param1.center;
            if (this._children != null)
            {
                this.i = this._children.length;
                do
                {
                    
                    this._child = this._children[this.i];
                    if (this._except == null || this._child.instance != this._except && this._child.maxX > this._minX && this._child.minX < this._maxX && this._child.maxY > this._minY && this._child.minY < this._maxY)
                    {
                        this._result.push(this._child);
                    }
                    var _loc_2:String = this;
                    _loc_2.i = this.i--;
                }while (this.i--)
            }
            return;
        }// end function

        private function getParent(param1:QuadTreeNode = null) : void
        {
            if (!param1)
            {
                return;
            }
            param1 = param1.parent;
            if (param1 == null || param1.onlysourceFlag && this._except == param1.onlysource)
            {
                return;
            }
            this._children = param1.center;
            if (this._children != null)
            {
                this.i = this._children.length;
                do
                {
                    
                    this._child = this._children[this.i];
                    if (this._except == null || this._child.instance != this._except && this._child.maxX > this._minX && this._child.minX < this._maxX && this._child.maxY > this._minY && this._child.minY < this._maxY)
                    {
                        this._result.push(this._child);
                    }
                    var _loc_2:String = this;
                    _loc_2.i = this.i--;
                }while (this.i--)
            }
            this.getParent(param1);
            return;
        }// end function

        public function add(param1:RenderableListItem) : void
        {
            if (this._clip.check(param1))
            {
                this._root.push(param1);
            }
            return;
        }// end function

        public function set clip(param1:Clipping) : void
        {
            this._clip = param1;
            this._rect = this._clip.asRectangleClipping();
            if (!this._root)
            {
                this._root = new QuadTreeNode((this._rect.minX + this._rect.maxX) / 2, (this._rect.minY + this._rect.maxY) / 2, this._rect.maxX - this._rect.minX, this._rect.maxY - this._rect.minY, 0, null, this._maxlevel);
            }
            else
            {
                this._root.reset((this._rect.minX + this._rect.maxX) / 2, (this._rect.minY + this._rect.maxY) / 2, this._rect.maxX - this._rect.minX, this._rect.maxY - this._rect.minY, this._maxlevel);
            }
            return;
        }// end function

    }
}
