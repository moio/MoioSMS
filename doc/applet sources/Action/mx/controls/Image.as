package mx.controls
{
    import flash.display.*;
    import flash.events.*;
    import mx.controls.listClasses.*;
    import mx.events.*;

    public class Image extends SWFLoader implements IDataRenderer, IDropInListItemRenderer, IListItemRenderer
    {
        private var _listData:BaseListData;
        private var sourceSet:Boolean;
        private var _data:Object;
        private var settingBrokenImage:Boolean;
        private var makeContentVisible:Boolean = false;
        static const VERSION:String = "3.2.0.3958";

        public function Image()
        {
            tabChildren = false;
            tabEnabled = true;
            showInAutomationHierarchy = true;
            return;
        }// end function

        override function contentLoaderInfo_completeEventHandler(event:Event) : void
        {
            var _loc_2:* = DisplayObject(event.target.loader);
            super.contentLoaderInfo_completeEventHandler(event);
            _loc_2.visible = false;
            makeContentVisible = true;
            invalidateDisplayList();
            return;
        }// end function

        public function get listData() : BaseListData
        {
            return _listData;
        }// end function

        public function set listData(param1:BaseListData) : void
        {
            _listData = param1;
            return;
        }// end function

        public function get data() : Object
        {
            return _data;
        }// end function

        public function set data(param1:Object) : void
        {
            _data = param1;
            if (!sourceSet)
            {
                source = listData ? (listData.label) : (data);
                sourceSet = false;
            }
            dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
            return;
        }// end function

        override public function invalidateSize() : void
        {
            if (data && settingBrokenImage)
            {
                return;
            }
            super.invalidateSize();
            return;
        }// end function

        override public function set source(param1:Object) : void
        {
            settingBrokenImage = param1 == getStyle("brokenImageSkin");
            sourceSet = !settingBrokenImage;
            super.source = param1;
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            if (makeContentVisible && contentHolder)
            {
                contentHolder.visible = true;
                makeContentVisible = false;
            }
            return;
        }// end function

    }
}
