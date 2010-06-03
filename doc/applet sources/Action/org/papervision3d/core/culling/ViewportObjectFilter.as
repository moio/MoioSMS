package org.papervision3d.core.culling
{
    import flash.utils.*;
    import org.papervision3d.objects.*;

    public class ViewportObjectFilter extends Object implements IObjectCuller
    {
        protected var _mode:int;
        protected var objects:Dictionary;

        public function ViewportObjectFilter(param1:int) : void
        {
            this.mode = param1;
            this.init();
            return;
        }// end function

        public function addObject(param1:DisplayObject3D) : void
        {
            this.objects[param1] = param1;
            return;
        }// end function

        public function get mode() : int
        {
            return this._mode;
        }// end function

        public function set mode(param1:int) : void
        {
            this._mode = param1;
            return;
        }// end function

        public function removeObject(param1:DisplayObject3D) : void
        {
            delete this.objects[param1];
            return;
        }// end function

        private function init() : void
        {
            this.objects = new Dictionary(true);
            return;
        }// end function

        public function testObject(param1:DisplayObject3D) : int
        {
            if (this.objects[param1])
            {
                if (this._mode == ViewportObjectFilterMode.INCLUSIVE)
                {
                    return 1;
                }
                if (this._mode == ViewportObjectFilterMode.EXCLUSIVE)
                {
                    return 0;
                }
            }
            else
            {
                if (this._mode == ViewportObjectFilterMode.INCLUSIVE)
                {
                    return 0;
                }
                if (this._mode == ViewportObjectFilterMode.EXCLUSIVE)
                {
                    return 1;
                }
            }
            return 0;
        }// end function

        public function destroy() : void
        {
            this.objects = null;
            return;
        }// end function

    }
}
