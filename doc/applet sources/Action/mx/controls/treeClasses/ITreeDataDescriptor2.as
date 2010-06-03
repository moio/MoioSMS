package mx.controls.treeClasses
{
    import mx.collections.*;

    public interface ITreeDataDescriptor2 extends ITreeDataDescriptor
    {

        public function ITreeDataDescriptor2();

        function getHierarchicalCollectionAdaptor(param1:ICollectionView, param2:Function, param3:Object, param4:Object = null) : ICollectionView;

        function getNodeDepth(param1:Object, param2:IViewCursor, param3:Object = null) : int;

        function getParent(param1:Object, param2:ICollectionView, param3:Object = null) : Object;

    }
}
