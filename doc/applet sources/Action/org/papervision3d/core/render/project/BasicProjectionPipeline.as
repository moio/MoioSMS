package org.papervision3d.core.render.project
{
    import org.papervision3d.core.render.data.*;
    import org.papervision3d.objects.*;

    public class BasicProjectionPipeline extends ProjectionPipeline
    {

        public function BasicProjectionPipeline()
        {
            this.init();
            return;
        }// end function

        protected function init() : void
        {
            return;
        }// end function

        override public function project(param1:RenderSessionData) : void
        {
            var _loc_3:DisplayObject3D = null;
            var _loc_5:Number = NaN;
            param1.camera.transformView();
            var _loc_2:* = param1.renderObjects;
            var _loc_4:* = _loc_2.length;
            if (param1.camera.useProjectionMatrix)
            {
                for each (_loc_3 in _loc_2)
                {
                    
                    if (_loc_3.visible)
                    {
                        if (param1.viewPort.viewportObjectFilter)
                        {
                            _loc_5 = param1.viewPort.viewportObjectFilter.testObject(_loc_3);
                            if (_loc_5)
                            {
                                this.projectObject(_loc_3, param1, _loc_5);
                            }
                            else
                            {
                                var _loc_8:* = param1.renderStatistics;
                                _loc_8.filteredObjects = param1.renderStatistics.filteredObjects++;
                            }
                            continue;
                        }
                        this.projectObject(_loc_3, param1, 1);
                    }
                }
            }
            else
            {
                for each (_loc_3 in _loc_2)
                {
                    
                    if (_loc_3.visible)
                    {
                        if (param1.viewPort.viewportObjectFilter)
                        {
                            _loc_5 = param1.viewPort.viewportObjectFilter.testObject(_loc_3);
                            if (_loc_5)
                            {
                                this.projectObject(_loc_3, param1, _loc_5);
                            }
                            else
                            {
                                var _loc_8:* = param1.renderStatistics;
                                _loc_8.filteredObjects = param1.renderStatistics.filteredObjects++;
                            }
                            continue;
                        }
                        this.projectObject(_loc_3, param1, 1);
                    }
                }
            }
            return;
        }// end function

        protected function projectObject(param1:DisplayObject3D, param2:RenderSessionData, param3:Number) : void
        {
            param1.cullTest = param3;
            if (param1.parent)
            {
                param1.project(param1.parent as DisplayObject3D, param2);
            }
            else
            {
                param1.project(param2.camera, param2);
            }
            return;
        }// end function

    }
}
