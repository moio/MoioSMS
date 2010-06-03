package mx.controls.treeClasses
{
    import flash.utils.*;
    import mx.collections.*;
    import mx.core.*;

    public class DefaultDataDescriptor extends Object implements ITreeDataDescriptor2, IMenuDataDescriptor
    {
        private var ChildCollectionCache:Dictionary;
        static const VERSION:String = "3.2.0.3958";

        public function DefaultDataDescriptor()
        {
            ChildCollectionCache = new Dictionary(true);
            return;
        }// end function

        public function setEnabled(param1:Object, param2:Boolean) : void
        {
            var node:* = param1;
            var value:* = param2;
            if (node is XML)
            {
                node.@enabled = value;
            }
            else if (node is Object)
            {
                try
                {
                    node.enabled = value;
                }
                catch (e:Error)
                {
                }
            }
            return;
        }// end function

        public function removeChildAt(param1:Object, param2:Object, param3:int, param4:Object = null) : Boolean
        {
            var cursor:IViewCursor;
            var children:ICollectionView;
            var parent:* = param1;
            var child:* = param2;
            var index:* = param3;
            var model:* = param4;
            if (!parent)
            {
                try
                {
                    if (index > model.length)
                    {
                        index = model.length;
                    }
                    if (model is IList)
                    {
                        model.removeItemAt(index);
                    }
                    else
                    {
                        cursor = model.createCursor();
                        cursor.seek(CursorBookmark.FIRST, index);
                        cursor.remove();
                    }
                    return true;
                }
                catch (e:Error)
                {
                }
            }
            else
            {
                children = ICollectionView(getChildren(parent, model));
                try
                {
                    if (index > children.length)
                    {
                        index = children.length;
                    }
                    if (children is IList)
                    {
                        IList(children).removeItemAt(index);
                    }
                    else
                    {
                        cursor = children.createCursor();
                        cursor.seek(CursorBookmark.FIRST, index);
                        cursor.remove();
                    }
                    return true;
                }
                catch (e:Error)
                {
                }
            }
            return false;
        }// end function

        public function isToggled(param1:Object) : Boolean
        {
            var toggled:*;
            var node:* = param1;
            if (node is XML)
            {
                toggled = node.@toggled;
                if (toggled[0] == true)
                {
                    return true;
                }
            }
            else if (node is Object)
            {
                try
                {
                    return Boolean(node.toggled);
                }
                catch (e:Error)
                {
                }
            }
            return false;
        }// end function

        public function getHierarchicalCollectionAdaptor(param1:ICollectionView, param2:Function, param3:Object, param4:Object = null) : ICollectionView
        {
            return new HierarchicalCollectionView(param1, this, param2, param3);
        }// end function

        public function addChildAt(param1:Object, param2:Object, param3:int, param4:Object = null) : Boolean
        {
            var cursor:IViewCursor;
            var children:ICollectionView;
            var temp:XMLList;
            var parent:* = param1;
            var newChild:* = param2;
            var index:* = param3;
            var model:* = param4;
            if (!parent)
            {
                try
                {
                    if (index > model.length)
                    {
                        index = model.length;
                    }
                    if (model is IList)
                    {
                        IList(model).addItemAt(newChild, index);
                    }
                    else
                    {
                        cursor = model.createCursor();
                        cursor.seek(CursorBookmark.FIRST, index);
                        cursor.insert(newChild);
                    }
                    return true;
                }
                catch (e:Error)
                {
                }
            }
            else
            {
                children = ICollectionView(getChildren(parent, model));
                if (!children)
                {
                    if (parent is XML)
                    {
                        temp = new XMLList();
                        XML(parent).appendChild(temp);
                        children = new XMLListCollection(parent.children());
                    }
                    else if (parent is Object)
                    {
                        parent.children = new ArrayCollection();
                        children = parent.children;
                    }
                }
                try
                {
                    if (index > children.length)
                    {
                        index = children.length;
                    }
                    if (children is IList)
                    {
                        IList(children).addItemAt(newChild, index);
                    }
                    else
                    {
                        cursor = children.createCursor();
                        cursor.seek(CursorBookmark.FIRST, index);
                        cursor.insert(newChild);
                    }
                    return true;
                }
                catch (e:Error)
                {
                }
            }
            return false;
        }// end function

        public function getData(param1:Object, param2:Object = null) : Object
        {
            return Object(param1);
        }// end function

        public function setToggled(param1:Object, param2:Boolean) : void
        {
            var node:* = param1;
            var value:* = param2;
            if (node is XML)
            {
                node.@toggled = value;
            }
            else if (node is Object)
            {
                try
                {
                    node.toggled = value;
                }
                catch (e:Error)
                {
                }
            }
            return;
        }// end function

        public function getNodeDepth(param1:Object, param2:IViewCursor, param3:Object = null) : int
        {
            if (param1 == param2.current)
            {
                return HierarchicalViewCursor(param2).currentDepth;
            }
            return -1;
        }// end function

        public function getType(param1:Object) : String
        {
            var node:* = param1;
            if (node is XML)
            {
                return String(node.@type);
            }
            if (node is Object)
            {
                try
                {
                    return String(node.type);
                }
                catch (e:Error)
                {
                }
            }
            return "";
        }// end function

        public function getGroupName(param1:Object) : String
        {
            var node:* = param1;
            if (node is XML)
            {
                return node.@groupName;
            }
            if (node is Object)
            {
                try
                {
                    return node.groupName;
                }
                catch (e:Error)
                {
                }
            }
            return "";
        }// end function

        public function getParent(param1:Object, param2:ICollectionView, param3:Object = null) : Object
        {
            return HierarchicalCollectionView(param2).getParentItem(param1);
        }// end function

        public function hasChildren(param1:Object, param2:Object = null) : Boolean
        {
            var node:* = param1;
            var model:* = param2;
            if (node == null)
            {
                return false;
            }
            var children:* = getChildren(node, model);
            try
            {
                if (children.length > 0)
                {
                    return true;
                }
            }
            catch (e:Error)
            {
            }
            return false;
        }// end function

        public function isBranch(param1:Object, param2:Object = null) : Boolean
        {
            var childList:XMLList;
            var branchFlag:XMLList;
            var node:* = param1;
            var model:* = param2;
            if (node == null)
            {
                return false;
            }
            var branch:Boolean;
            if (node is XML)
            {
                childList = node.children();
                branchFlag = node.@isBranch;
                if (branchFlag.length() == 1)
                {
                    if (branchFlag[0] == "true")
                    {
                        branch;
                    }
                }
                else if (childList.length() != 0)
                {
                    branch;
                }
            }
            else if (node is Object)
            {
                try
                {
                    if (node.children != undefined)
                    {
                        branch;
                    }
                }
                catch (e:Error)
                {
                }
            }
            return branch;
        }// end function

        public function getChildren(param1:Object, param2:Object = null) : ICollectionView
        {
            var children:*;
            var childrenCollection:ICollectionView;
            var oldArrayCollection:ArrayCollection;
            var oldXMLCollection:XMLListCollection;
            var p:*;
            var childArray:Array;
            var node:* = param1;
            var model:* = param2;
            if (node == null)
            {
                return null;
            }
            if (node is XML)
            {
                children = node.*;
            }
            else if (node is Object)
            {
                try
                {
                    children = node.children;
                }
                catch (e:Error)
                {
                }
            }
            if (children == undefined && !(children is XMLList))
            {
                return null;
            }
            if (children is ICollectionView)
            {
                childrenCollection = ICollectionView(children);
            }
            else if (children is Array)
            {
                oldArrayCollection = ChildCollectionCache[node];
                if (!oldArrayCollection)
                {
                    childrenCollection = new ArrayCollection(children);
                    ChildCollectionCache[node] = childrenCollection;
                }
                else
                {
                    childrenCollection = oldArrayCollection;
                    mx_internal::dispatchResetEvent = false;
                    ArrayCollection(childrenCollection).source = children;
                }
            }
            else if (children is XMLList)
            {
                oldXMLCollection = ChildCollectionCache[node];
                if (!oldXMLCollection)
                {
                    var _loc_4:int = 0;
                    var _loc_5:* = ChildCollectionCache;
                    while (_loc_5 in _loc_4)
                    {
                        
                        p = _loc_5[_loc_4];
                        if (p === node)
                        {
                            oldXMLCollection = ChildCollectionCache[p];
                            break;
                        }
                    }
                }
                if (!oldXMLCollection)
                {
                    childrenCollection = new XMLListCollection(children);
                    ChildCollectionCache[node] = childrenCollection;
                }
                else
                {
                    childrenCollection = oldXMLCollection;
                    mx_internal::dispatchResetEvent = false;
                    XMLListCollection(childrenCollection).source = children;
                }
            }
            else
            {
                childArray = new Array(children);
                if (childArray != null)
                {
                    childrenCollection = new ArrayCollection(childArray);
                }
            }
            return childrenCollection;
        }// end function

        public function isEnabled(param1:Object) : Boolean
        {
            var enabled:*;
            var node:* = param1;
            if (node is XML)
            {
                enabled = node.@enabled;
                if (enabled[0] == false)
                {
                    return false;
                }
            }
            else if (node is Object)
            {
                try
                {
                    return String(node.enabled) != "false";
                }
                catch (e:Error)
                {
                }
            }
            return true;
        }// end function

    }
}
