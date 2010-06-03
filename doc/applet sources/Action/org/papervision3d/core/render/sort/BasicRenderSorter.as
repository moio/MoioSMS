package org.papervision3d.core.render.sort
{

    public class BasicRenderSorter extends Object implements IRenderSorter
    {

        public function BasicRenderSorter()
        {
            return;
        }// end function

        public function sort(param1:Array) : void
        {
            param1.sortOn("screenZ", Array.NUMERIC);
            return;
        }// end function

    }
}
