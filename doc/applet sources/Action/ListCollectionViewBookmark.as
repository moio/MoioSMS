package 
{
    import mx.collections.*;

    private class ListCollectionViewBookmark extends CursorBookmark
    {
        var viewRevision:int;
        var index:int;
        var view:ListCollectionView;

        private function ListCollectionViewBookmark(param1:Object, param2:ListCollectionView, param3:int, param4:int)
        {
            super(param1);
            this.view = param2;
            this.viewRevision = param3;
            this.index = param4;
            return;
        }// end function

        override public function getViewIndex() : int
        {
            return view.getBookmarkIndex(this);
        }// end function

    }
}
