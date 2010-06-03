package org.papervision3d.materials.utils
{
    import flash.geom.*;
    import org.papervision3d.core.geom.renderables.*;

    public class RenderRecStorage extends Object
    {
        public var mat:Matrix;
        public var v0:Vertex3DInstance;
        public var v1:Vertex3DInstance;
        public var v2:Vertex3DInstance;

        public function RenderRecStorage()
        {
            this.v0 = new Vertex3DInstance();
            this.v1 = new Vertex3DInstance();
            this.v2 = new Vertex3DInstance();
            this.mat = new Matrix();
            return;
        }// end function

    }
}
