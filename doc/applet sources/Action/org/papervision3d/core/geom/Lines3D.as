package org.papervision3d.core.geom
{
    import org.papervision3d.core.geom.renderables.*;
    import org.papervision3d.core.log.*;
    import org.papervision3d.core.render.data.*;
    import org.papervision3d.core.render.draw.*;
    import org.papervision3d.materials.special.*;
    import org.papervision3d.objects.*;

    public class Lines3D extends Vertices3D
    {
        private var _material:ILineDrawer;
        public var lines:Array;

        public function Lines3D(param1:LineMaterial = null, param2:String = null)
        {
            super(null, param2);
            if (!param1)
            {
                this.material = new LineMaterial();
            }
            else
            {
                this.material = param1;
            }
            this.init();
            return;
        }// end function

        private function init() : void
        {
            this.lines = new Array();
            return;
        }// end function

        public function removeAllLines() : void
        {
            while (this.lines.length > 0)
            {
                
                this.removeLine(this.lines[0]);
            }
            return;
        }// end function

        public function addLine(param1:Line3D) : void
        {
            this.lines.push(param1);
            param1.instance = this;
            if (geometry.vertices.indexOf(param1.v0) == -1)
            {
                geometry.vertices.push(param1.v0);
            }
            if (geometry.vertices.indexOf(param1.v1) == -1)
            {
                geometry.vertices.push(param1.v1);
            }
            if (param1.cV)
            {
                if (geometry.vertices.indexOf(param1.cV) == -1)
                {
                    geometry.vertices.push(param1.cV);
                }
            }
            return;
        }// end function

        public function addNewSegmentedLine(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : Array
        {
            var _loc_13:Line3D = null;
            var _loc_15:Vertex3D = null;
            var _loc_9:* = (param6 - param3) / param2;
            var _loc_10:* = (param7 - param4) / param2;
            var _loc_11:* = (param8 - param5) / param2;
            var _loc_12:* = new Array();
            var _loc_14:* = new Vertex3D(param3, param4, param5);
            var _loc_16:Number = 0;
            while (_loc_16++ <= param2)
            {
                
                _loc_15 = new Vertex3D(param3 + _loc_9 * _loc_16, param4 + _loc_10 * _loc_16, param5 + _loc_11 * _loc_16);
                _loc_13 = new Line3D(this, material as LineMaterial, param1, _loc_14, _loc_15);
                this.addLine(_loc_13);
                _loc_12.push(_loc_13);
                _loc_14 = _loc_15;
            }
            return _loc_12;
        }// end function

        public function removeLine(param1:Line3D) : void
        {
            var _loc_2:* = this.lines.indexOf(param1);
            if (_loc_2 > -1)
            {
                this.lines.splice(_loc_2, 1);
            }
            else
            {
                PaperLogger.warning("Papervision3D Lines3D.removeLine : WARNING removal of non-existant line attempted. ");
            }
            return;
        }// end function

        override public function project(param1:DisplayObject3D, param2:RenderSessionData) : Number
        {
            var _loc_3:Line3D = null;
            var _loc_4:Number = NaN;
            var _loc_5:RenderLine = null;
            super.project(param1, param2);
            for each (_loc_3 in this.lines)
            {
                
                if (param2.viewPort.lineCuller.testLine(_loc_3))
                {
                    _loc_5 = _loc_3.renderCommand;
                    _loc_5.renderer = _loc_3.material;
                    _loc_5.size = _loc_3.size;
                    var _loc_8:* = (_loc_3.v0.vertex3DInstance.z + _loc_3.v1.vertex3DInstance.z) / 2;
                    _loc_5.screenZ = (_loc_3.v0.vertex3DInstance.z + _loc_3.v1.vertex3DInstance.z) / 2;
                    _loc_4 = _loc_4 + _loc_8;
                    _loc_5.v0 = _loc_3.v0.vertex3DInstance;
                    _loc_5.v1 = _loc_3.v1.vertex3DInstance;
                    param2.renderer.addToRenderList(_loc_5);
                }
            }
            return _loc_4 / (this.lines.length + 1);
        }// end function

        public function addNewLine(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : Line3D
        {
            var _loc_8:* = new Line3D(this, material as LineMaterial, param1, new Vertex3D(param2, param3, param4), new Vertex3D(param5, param6, param7));
            this.addLine(_loc_8);
            return _loc_8;
        }// end function

    }
}
