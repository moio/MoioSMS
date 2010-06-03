package mx.collections
{

    public interface IViewCursor extends IEventDispatcher
    {

        public function IViewCursor();

        function get current() : Object;

        function moveNext() : Boolean;

        function get view() : ICollectionView;

        function movePrevious() : Boolean;

        function remove() : Object;

        function findLast(param1:Object) : Boolean;

        function get beforeFirst() : Boolean;

        function get afterLast() : Boolean;

        function findAny(param1:Object) : Boolean;

        function get bookmark() : CursorBookmark;

        function findFirst(param1:Object) : Boolean;

        function seek(param1:CursorBookmark, param2:int = 0, param3:int = 0) : void;

        function insert(param1:Object) : void;

    }
}
