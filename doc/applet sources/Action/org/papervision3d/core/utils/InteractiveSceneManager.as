package org.papervision3d.core.utils
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import org.papervision3d.core.geom.renderables.*;
    import org.papervision3d.core.proto.*;
    import org.papervision3d.core.render.data.*;
    import org.papervision3d.core.utils.virtualmouse.*;
    import org.papervision3d.events.*;
    import org.papervision3d.materials.*;
    import org.papervision3d.objects.*;
    import org.papervision3d.view.*;

    public class InteractiveSceneManager extends EventDispatcher
    {
        public var currentMaterial:MaterialObject3D;
        public var container:Sprite;
        public var currentMousePos:Point;
        public var debug:Boolean = false;
        public var mouse3D:Mouse3D;
        public var enableOverOut:Boolean = true;
        public var currentDisplayObject3D:DisplayObject3D;
        public var _viewportRendered:Boolean = false;
        public var virtualMouse:VirtualMouse;
        public var lastMousePos:Point;
        public var viewport:Viewport3D;
        public var renderHitData:RenderHitData;
        public var currentMouseDO3D:DisplayObject3D = null;
        public static var MOUSE_IS_DOWN:Boolean = false;

        public function InteractiveSceneManager(param1:Viewport3D)
        {
            this.virtualMouse = new VirtualMouse();
            this.mouse3D = new Mouse3D();
            this.currentMousePos = new Point();
            this.lastMousePos = new Point();
            this.viewport = param1;
            this.container = param1.containerSprite;
            this.init();
            return;
        }// end function

        protected function handleMouseClick(event:MouseEvent) : void
        {
            if (event is IVirtualMouseEvent)
            {
                return;
            }
            if (this.renderHitData && this.renderHitData.hasHit)
            {
                this.dispatchObjectEvent(InteractiveScene3DEvent.OBJECT_CLICK, this.currentDisplayObject3D);
            }
            return;
        }// end function

        protected function handleEnterFrame(event:Event) : void
        {
            var _loc_3:MovieMaterial = null;
            this.currentMousePos.x = this.container.mouseX;
            this.currentMousePos.y = this.container.mouseY;
            var _loc_2:* = !this.currentMousePos.equals(this.lastMousePos);
            if (_loc_2 || this._viewportRendered)
            {
                this.updateRenderHitData();
                this._viewportRendered = false;
                if (event is IVirtualMouseEvent)
                {
                    return;
                }
                if (this.virtualMouse && this.renderHitData)
                {
                    _loc_3 = this.currentMaterial as MovieMaterial;
                    if (_loc_3)
                    {
                        this.virtualMouse.container = _loc_3.movie as Sprite;
                    }
                    if (this.virtualMouse.container)
                    {
                        this.virtualMouse.setLocation(this.renderHitData.u, this.renderHitData.v);
                    }
                    if (Mouse3D.enabled && this.renderHitData && this.renderHitData.hasHit)
                    {
                        this.mouse3D.updatePosition(this.renderHitData);
                    }
                    this.dispatchObjectEvent(InteractiveScene3DEvent.OBJECT_MOVE, this.currentDisplayObject3D);
                }
                else if (this.renderHitData && this.renderHitData.hasHit)
                {
                    this.dispatchObjectEvent(InteractiveScene3DEvent.OBJECT_MOVE, this.currentDisplayObject3D);
                }
            }
            this.lastMousePos.x = this.currentMousePos.x;
            this.lastMousePos.y = this.currentMousePos.y;
            return;
        }// end function

        public function updateAfterRender() : void
        {
            this._viewportRendered = true;
            return;
        }// end function

        public function initListeners() : void
        {
            if (this.viewport.interactive)
            {
                this.container.addEventListener(MouseEvent.MOUSE_DOWN, this.handleMousePress, false, 0, true);
                this.container.addEventListener(MouseEvent.MOUSE_UP, this.handleMouseRelease, false, 0, true);
                this.container.addEventListener(MouseEvent.CLICK, this.handleMouseClick, false, 0, true);
                this.container.addEventListener(MouseEvent.DOUBLE_CLICK, this.handleMouseDoubleClick, false, 0, true);
                this.container.stage.addEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            }
            return;
        }// end function

        protected function initVirtualMouse() : void
        {
            this.virtualMouse.stage = this.container.stage;
            this.virtualMouse.container = this.container;
            return;
        }// end function

        protected function handleMouseOver(param1:DisplayObject3D) : void
        {
            this.dispatchObjectEvent(InteractiveScene3DEvent.OBJECT_OVER, param1);
            return;
        }// end function

        protected function resolveRenderHitData() : void
        {
            this.renderHitData = this.viewport.hitTestPoint2D(this.currentMousePos) as RenderHitData;
            return;
        }// end function

        public function updateRenderHitData() : void
        {
            this.resolveRenderHitData();
            this.currentDisplayObject3D = this.renderHitData.displayObject3D;
            this.currentMaterial = this.renderHitData.material;
            this.manageOverOut();
            return;
        }// end function

        protected function dispatchObjectEvent(param1:String, param2:DisplayObject3D) : void
        {
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            var _loc_5:InteractiveScene3DEvent = null;
            if (this.renderHitData && this.renderHitData.hasHit)
            {
                _loc_3 = this.renderHitData.u ? (this.renderHitData.u) : (0);
                _loc_4 = this.renderHitData.v ? (this.renderHitData.v) : (0);
                _loc_5 = new InteractiveScene3DEvent(param1, param2, this.container, this.renderHitData.renderable as Triangle3D, _loc_3, _loc_4, this.renderHitData);
                _loc_5.renderHitData = this.renderHitData;
                dispatchEvent(_loc_5);
                param2.dispatchEvent(_loc_5);
            }
            else
            {
                dispatchEvent(new InteractiveScene3DEvent(param1, param2, this.container));
                if (param2)
                {
                    param2.dispatchEvent(new InteractiveScene3DEvent(param1, param2, this.container));
                }
            }
            return;
        }// end function

        protected function handleMouseDoubleClick(event:MouseEvent) : void
        {
            if (event is IVirtualMouseEvent)
            {
                return;
            }
            if (this.renderHitData && this.renderHitData.hasHit)
            {
                this.dispatchObjectEvent(InteractiveScene3DEvent.OBJECT_DOUBLE_CLICK, this.currentDisplayObject3D);
            }
            return;
        }// end function

        protected function handleMouseRelease(event:MouseEvent) : void
        {
            if (event is IVirtualMouseEvent)
            {
                return;
            }
            MOUSE_IS_DOWN = false;
            if (this.virtualMouse)
            {
                this.virtualMouse.release();
            }
            if (Mouse3D.enabled && this.renderHitData && this.renderHitData.renderable != null)
            {
                this.mouse3D.updatePosition(this.renderHitData);
            }
            if (this.renderHitData && this.renderHitData.hasHit)
            {
                this.dispatchObjectEvent(InteractiveScene3DEvent.OBJECT_RELEASE, this.currentDisplayObject3D);
            }
            return;
        }// end function

        protected function handleAddedToStage(event:Event) : void
        {
            this.initVirtualMouse();
            this.initListeners();
            return;
        }// end function

        protected function handleMouseOut(param1:DisplayObject3D) : void
        {
            var _loc_2:MovieMaterial = null;
            if (param1)
            {
                _loc_2 = param1.material as MovieMaterial;
                if (_loc_2)
                {
                    this.virtualMouse.exitContainer();
                }
            }
            this.dispatchObjectEvent(InteractiveScene3DEvent.OBJECT_OUT, param1);
            return;
        }// end function

        protected function manageOverOut() : void
        {
            if (!this.enableOverOut)
            {
                return;
            }
            if (this.renderHitData && this.renderHitData.hasHit)
            {
                if (!this.currentMouseDO3D && this.currentDisplayObject3D)
                {
                    this.handleMouseOver(this.currentDisplayObject3D);
                    this.currentMouseDO3D = this.currentDisplayObject3D;
                }
                else if (this.currentMouseDO3D && this.currentMouseDO3D != this.currentDisplayObject3D)
                {
                    this.handleMouseOut(this.currentMouseDO3D);
                    this.handleMouseOver(this.currentDisplayObject3D);
                    this.currentMouseDO3D = this.currentDisplayObject3D;
                }
            }
            else if (this.currentMouseDO3D != null)
            {
                this.handleMouseOut(this.currentMouseDO3D);
                this.currentMouseDO3D = null;
            }
            return;
        }// end function

        public function destroy() : void
        {
            this.viewport = null;
            this.renderHitData = null;
            this.currentDisplayObject3D = null;
            this.currentMaterial = null;
            this.currentMouseDO3D = null;
            this.container.removeEventListener(MouseEvent.MOUSE_DOWN, this.handleMousePress);
            this.container.removeEventListener(MouseEvent.MOUSE_UP, this.handleMouseRelease);
            this.container.removeEventListener(MouseEvent.CLICK, this.handleMouseClick);
            this.container.removeEventListener(MouseEvent.DOUBLE_CLICK, this.handleMouseDoubleClick);
            if (this.container.stage)
            {
                this.container.stage.removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            }
            this.container = null;
            return;
        }// end function

        public function init() : void
        {
            if (this.container)
            {
                if (this.container.stage)
                {
                    this.initVirtualMouse();
                    this.initListeners();
                }
                else
                {
                    this.container.addEventListener(Event.ADDED_TO_STAGE, this.handleAddedToStage);
                }
            }
            return;
        }// end function

        protected function handleMousePress(event:MouseEvent) : void
        {
            if (event is IVirtualMouseEvent)
            {
                return;
            }
            MOUSE_IS_DOWN = true;
            if (this.virtualMouse)
            {
                this.virtualMouse.press();
            }
            if (Mouse3D.enabled && this.renderHitData && this.renderHitData.renderable != null)
            {
                this.mouse3D.updatePosition(this.renderHitData);
            }
            if (this.renderHitData && this.renderHitData.hasHit)
            {
                this.dispatchObjectEvent(InteractiveScene3DEvent.OBJECT_PRESS, this.currentDisplayObject3D);
            }
            return;
        }// end function

    }
}
