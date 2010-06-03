package org.papervision3d.view.layer
{
    import org.papervision3d.objects.*;
    import org.papervision3d.view.*;

    public class ViewportBaseLayer extends ViewportLayer
    {

        public function ViewportBaseLayer(param1:Viewport3D)
        {
            super(param1, null);
            return;
        }// end function

        override public function getChildLayer(param1:DisplayObject3D, param2:Boolean = true, param3:Boolean = false) : ViewportLayer
        {
            if (layers[param1])
            {
                return layers[param1];
            }
            if (param2 || param1.useOwnContainer)
            {
                return getChildLayerFor(param1, param3);
            }
            return this;
        }// end function

        override public function updateBeforeRender() : void
        {
            clear();
            while (_loc_1-- >= 0)
            {
                
                if (childLayers[childLayers.length--].dynamicLayer)
                {
                    removeLayerAt(_loc_1);
                }
            }
            super.updateBeforeRender();
            return;
        }// end function

    }
}
