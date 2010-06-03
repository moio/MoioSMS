package org.papervision3d.core.proto
{
    import org.papervision3d.core.math.*;
    import org.papervision3d.materials.*;
    import org.papervision3d.objects.*;
    import org.papervision3d.objects.primitives.*;

    public class LightObject3D extends DisplayObject3D
    {
        public var flipped:Boolean;
        public var lightMatrix:Matrix3D;
        private var _showLight:Boolean;
        private var displaySphere:Sphere;

        public function LightObject3D(param1:Boolean = false, param2:Boolean = false)
        {
            this.lightMatrix = Matrix3D.IDENTITY;
            this.showLight = param1;
            this.flipped = param2;
            return;
        }// end function

        public function get showLight() : Boolean
        {
            return this._showLight;
        }// end function

        public function set showLight(param1:Boolean) : void
        {
            if (this._showLight)
            {
                removeChild(this.displaySphere);
            }
            if (param1)
            {
                this.displaySphere = new Sphere(new WireframeMaterial(16776960), 10, 3, 2);
                addChild(this.displaySphere);
            }
            this._showLight = param1;
            return;
        }// end function

    }
}
