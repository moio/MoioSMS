package org.papervision3d.materials.special
{
    import flash.display.*;
    import org.papervision3d.core.geom.renderables.*;
    import org.papervision3d.core.log.*;
    import org.papervision3d.core.proto.*;
    import org.papervision3d.core.render.data.*;

    public class ParticleMaterial extends MaterialObject3D implements IParticleDrawer
    {
        public var shape:int;
        public static var SHAPE_SQUARE:int = 0;
        public static var SHAPE_CIRCLE:int = 1;

        public function ParticleMaterial(param1:Number, param2:Number, param3:int = 0)
        {
            this.shape = param3;
            this.fillAlpha = param2;
            this.fillColor = param1;
            return;
        }// end function

        public function drawParticle(param1:Particle, param2:Graphics, param3:RenderSessionData) : void
        {
            param2.beginFill(fillColor, fillAlpha);
            var _loc_4:* = param1.renderRect;
            if (this.shape == SHAPE_SQUARE)
            {
                param2.drawRect(_loc_4.x, _loc_4.y, _loc_4.width, _loc_4.height);
            }
            else if (this.shape == SHAPE_CIRCLE)
            {
                param2.drawCircle(_loc_4.x + _loc_4.width / 2, _loc_4.y + _loc_4.width / 2, _loc_4.width / 2);
            }
            else
            {
                PaperLogger.warning("Particle material has no valid shape - Must be ParticleMaterial.SHAPE_SQUARE or ParticleMaterial.SHAPE_CIRCLE");
            }
            param2.endFill();
            var _loc_5:* = param3.renderStatistics;
            _loc_5.particles = param3.renderStatistics.particles++;
            return;
        }// end function

        public function updateRenderRect(param1:Particle) : void
        {
            var _loc_2:* = param1.renderRect;
            if (param1.size == 0)
            {
                _loc_2.width = 1;
                _loc_2.height = 1;
            }
            else
            {
                _loc_2.width = param1.renderScale * param1.size;
                _loc_2.height = param1.renderScale * param1.size;
            }
            _loc_2.x = param1.vertex3D.vertex3DInstance.x - _loc_2.width / 2;
            _loc_2.y = param1.vertex3D.vertex3DInstance.y - _loc_2.width / 2;
            return;
        }// end function

    }
}
