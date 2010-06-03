package org.papervision3d.objects
{
    import org.papervision3d.*;
    import org.papervision3d.core.data.*;
    import org.papervision3d.core.log.*;
    import org.papervision3d.core.material.*;
    import org.papervision3d.core.math.*;
    import org.papervision3d.core.proto.*;
    import org.papervision3d.core.render.data.*;
    import org.papervision3d.materials.shaders.*;
    import org.papervision3d.materials.utils.*;
    import org.papervision3d.view.*;
    import org.papervision3d.view.layer.*;

    public class DisplayObject3D extends DisplayObjectContainer3D
    {
        public var extra:Object;
        public var frustumTestMethod:int = 0;
        private var _rot:Quaternion;
        public var id:int;
        private var _rotationY:Number;
        private var _rotationZ:Number;
        public var cullTest:Number = 0;
        public var materials:MaterialsList;
        public var meshSort:uint = 1;
        private var _rotationX:Number;
        private var _qYaw:Quaternion;
        private var _xAxis:Number3D;
        private var _zAxis:Number3D;
        private var _scaleDirty:Boolean = false;
        private var _autoCalcScreenCoords:Boolean = false;
        private var _tempScale:Number3D;
        private var _numClones:uint = 0;
        public var alpha:Number = 1;
        public var useClipping:Boolean = true;
        public var screen:Number3D;
        private var _scaleX:Number;
        private var _scaleY:Number;
        private var _scaleZ:Number;
        public var geometry:GeometryObject3D;
        private var _qPitch:Quaternion;
        public var visible:Boolean;
        protected var _userData:UserData;
        public var screenZ:Number;
        public var container:ViewportLayer;
        protected var _useOwnContainer:Boolean = false;
        public var transform:Matrix3D;
        private var _material:MaterialObject3D;
        private var _position:Number3D;
        public var name:String;
        protected var _scene:SceneObject3D = null;
        private var _qRoll:Quaternion;
        private var _localRotationZ:Number = 0;
        public var culled:Boolean;
        public var world:Matrix3D;
        public var blendMode:String = "normal";
        private var _localRotationX:Number = 0;
        private var _localRotationY:Number = 0;
        public var view:Matrix3D;
        public var parent:DisplayObjectContainer3D;
        private var _target:Number3D;
        public var faces:Array;
        private var _yAxis:Number3D;
        public var flipLightDirection:Boolean = false;
        private var _rotation:Number3D;
        protected var _transformDirty:Boolean = false;
        protected var _sorted:Array;
        private var _rotationDirty:Boolean = false;
        public var parentContainer:DisplayObject3D;
        public var testQuad:Boolean = true;
        public var filters:Array;
        private static var entry_count:uint = 0;
        private static var _newID:int = 0;
        public static const MESH_SORT_CENTER:uint = 1;
        private static const LEFT:Number3D = new Number3D(-1, 0, 0);
        public static const MESH_SORT_CLOSE:uint = 3;
        private static var _tempMatrix:Matrix3D = Matrix3D.IDENTITY;
        public static var sortedArray:Array = new Array();
        private static const BACKWARD:Number3D = new Number3D(0, 0, -1);
        private static const FORWARD:Number3D = new Number3D(0, 0, 1);
        public static const MESH_SORT_FAR:uint = 2;
        private static const DOWN:Number3D = new Number3D(0, -1, 0);
        public static var faceLevelMode:Boolean;
        private static var _tempQuat:Quaternion = new Quaternion();
        private static const UP:Number3D = new Number3D(0, 1, 0);
        private static var toRADIANS:Number = 0.0174533;
        private static var toDEGREES:Number = 57.2958;
        private static const RIGHT:Number3D = new Number3D(1, 0, 0);

        public function DisplayObject3D(param1:String = null, param2:GeometryObject3D = null) : void
        {
            this.faces = new Array();
            this.filters = [];
            this.screen = new Number3D();
            this._position = Number3D.ZERO;
            this._target = Number3D.ZERO;
            this._zAxis = Number3D.ZERO;
            this._xAxis = Number3D.ZERO;
            this._yAxis = Number3D.ZERO;
            this._rotation = Number3D.ZERO;
            this._rot = new Quaternion();
            this._qPitch = new Quaternion();
            this._qYaw = new Quaternion();
            this._qRoll = new Quaternion();
            if (param1 != null)
            {
                PaperLogger.info("DisplayObject3D: " + param1);
            }
            this.culled = false;
            this.transform = Matrix3D.IDENTITY;
            this.world = Matrix3D.IDENTITY;
            this.view = Matrix3D.IDENTITY;
            this.x = 0;
            this.y = 0;
            this.z = 0;
            this.rotationX = 0;
            this.rotationY = 0;
            this.rotationZ = 0;
            var _loc_4:int = 0;
            this._localRotationZ = 0;
            var _loc_4:* = _loc_4;
            this._localRotationY = _loc_4;
            this._localRotationX = _loc_4;
            var _loc_3:* = Papervision3D.usePERCENT ? (100) : (1);
            this.scaleX = _loc_3;
            this.scaleY = _loc_3;
            this.scaleZ = _loc_3;
            this._tempScale = new Number3D();
            this.visible = true;
            this.id = _newID++;
            if (!param1)
            {
            }
            this.name = String(this.id);
            this._numClones = 0;
            if (param2)
            {
                this.addGeometry(param2);
            }
            return;
        }// end function

        public function set localRotationX(param1:Number) : void
        {
            param1 = Papervision3D.useDEGREES ? (param1 * toRADIANS) : (param1);
            if (this._transformDirty)
            {
                this.updateTransform();
            }
            this._qPitch.setFromAxisAngle(this.transform.n11, this.transform.n21, this.transform.n31, this._localRotationX - param1);
            this.transform.calculateMultiply3x3(this._qPitch.matrix, this.transform);
            this._localRotationX = param1;
            this._rotationDirty = true;
            return;
        }// end function

        public function set y(param1:Number) : void
        {
            this.transform.n24 = param1;
            return;
        }// end function

        public function set z(param1:Number) : void
        {
            this.transform.n34 = param1;
            return;
        }// end function

        override public function addChild(param1:DisplayObject3D, param2:String = null) : DisplayObject3D
        {
            param1 = super.addChild(param1, param2);
            if (param1.scene == null)
            {
                param1.scene = this.scene;
            }
            if (this.useOwnContainer)
            {
                param1.parentContainer = this;
            }
            return param1;
        }// end function

        public function setChildMaterialByName(param1:String, param2:MaterialObject3D) : void
        {
            this.setChildMaterial(getChildByName(param1, true), param2);
            return;
        }// end function

        public function moveDown(param1:Number) : void
        {
            this.translate(param1, DOWN);
            return;
        }// end function

        public function project(param1:DisplayObject3D, param2:RenderSessionData) : Number
        {
            var _loc_5:DisplayObject3D = null;
            if (this._transformDirty)
            {
                this.updateTransform();
            }
            this.world.calculateMultiply(param1.world, this.transform);
            if (param2.camera.culler)
            {
                if (param2.camera === this)
                {
                    this.culled = true;
                }
                else
                {
                    this.culled = param2.camera.culler.testObject(this) < 0;
                }
                if (this.culled)
                {
                    var _loc_6:* = param2.renderStatistics;
                    _loc_6.culledObjects = param2.renderStatistics.culledObjects++;
                    return 0;
                }
            }
            else
            {
                this.culled = false;
            }
            if (param1 !== param2.camera)
            {
                if (param2.camera.useProjectionMatrix)
                {
                    this.view.calculateMultiply4x4(param1.view, this.transform);
                }
                else
                {
                    this.view.calculateMultiply(param1.view, this.transform);
                }
            }
            else if (param2.camera.useProjectionMatrix)
            {
                this.view.calculateMultiply4x4(param2.camera.eye, this.transform);
            }
            else
            {
                this.view.calculateMultiply(param2.camera.eye, this.transform);
            }
            if (this._autoCalcScreenCoords)
            {
                this.calculateScreenCoords(param2.camera);
            }
            var _loc_3:Number = 0;
            var _loc_4:Number = 0;
            for each (_loc_5 in this._childrenByName)
            {
                
                if (_loc_5.visible)
                {
                    _loc_3 = _loc_3 + _loc_5.project(this, param2);
                }
            }
            var _loc_6:* = _loc_3 / _loc_4++;
            this.screenZ = _loc_3 / _loc_4++;
            return _loc_6;
        }// end function

        public function set scene(param1:SceneObject3D) : void
        {
            var _loc_2:DisplayObject3D = null;
            this._scene = param1;
            for each (_loc_2 in this._childrenByName)
            {
                
                if (_loc_2.scene == null)
                {
                    _loc_2.scene = this._scene;
                }
            }
            return;
        }// end function

        public function setChildMaterial(param1:DisplayObject3D, param2:MaterialObject3D, param3:MaterialObject3D = null) : void
        {
            var _loc_4:Triangle3D = null;
            if (!param1)
            {
                return;
            }
            if (!param3 || param1.material === param3)
            {
                param1.material = param2;
            }
            if (param1.geometry && param1.geometry.faces)
            {
                for each (_loc_4 in param1.geometry.faces)
                {
                    
                    if (!param3 || _loc_4.material === param3)
                    {
                        _loc_4.material = param2;
                    }
                }
            }
            return;
        }// end function

        public function get position() : Number3D
        {
            this._position.reset(this.x, this.y, this.z);
            return this._position;
        }// end function

        public function get userData() : UserData
        {
            return this._userData;
        }// end function

        public function get material() : MaterialObject3D
        {
            return this._material;
        }// end function

        public function set userData(param1:UserData) : void
        {
            this._userData = param1;
            return;
        }// end function

        public function set rotationX(param1:Number) : void
        {
            this._rotationX = Papervision3D.useDEGREES ? (param1 * toRADIANS) : (param1);
            this._transformDirty = true;
            return;
        }// end function

        public function calculateScreenCoords(param1:CameraObject3D) : void
        {
            var _loc_2:Number = NaN;
            var _loc_3:Number = NaN;
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_6:Number = NaN;
            var _loc_7:Number = NaN;
            var _loc_8:Number = NaN;
            if (param1.useProjectionMatrix)
            {
                _loc_2 = 0;
                _loc_3 = 0;
                _loc_4 = 0;
                _loc_5 = _loc_2 * this.view.n41 + _loc_3 * this.view.n42 + _loc_4 * this.view.n43 + this.view.n44;
                _loc_6 = param1.viewport.width / 2;
                _loc_7 = param1.viewport.height / 2;
                this.screen.x = (_loc_2 * this.view.n11 + _loc_3 * this.view.n12 + _loc_4 * this.view.n13 + this.view.n14) / _loc_5;
                this.screen.y = (_loc_2 * this.view.n21 + _loc_3 * this.view.n22 + _loc_4 * this.view.n23 + this.view.n24) / _loc_5;
                this.screen.z = _loc_2 * this.view.n31 + _loc_3 * this.view.n32 + _loc_4 * this.view.n33 + this.view.n34;
                this.screen.x = this.screen.x * _loc_6;
                this.screen.y = this.screen.y * _loc_7;
            }
            else
            {
                _loc_8 = param1.focus * param1.zoom / (param1.focus + this.view.n34);
                this.screen.x = this.view.n14 * _loc_8;
                this.screen.y = this.view.n24 * _loc_8;
                this.screen.z = this.view.n34;
            }
            return;
        }// end function

        public function lookAt(param1:DisplayObject3D, param2:Number3D = null) : void
        {
            var _loc_3:DisplayObject3D = null;
            var _loc_4:Matrix3D = null;
            if (this is CameraObject3D)
            {
                this._position.reset(this.x, this.y, this.z);
            }
            else
            {
                _loc_3 = this.parent as DisplayObject3D;
                if (_loc_3)
                {
                    this.world.calculateMultiply(_loc_3.world, this.transform);
                }
                else
                {
                    this.world.copy(this.transform);
                }
                this._position.reset(this.world.n14, this.world.n24, this.world.n34);
            }
            if (param1 is CameraObject3D)
            {
                this._target.reset(param1.x, param1.y, param1.z);
            }
            else
            {
                _loc_3 = param1.parent as DisplayObject3D;
                if (_loc_3)
                {
                    param1.world.calculateMultiply(_loc_3.world, param1.transform);
                }
                else
                {
                    param1.world.copy(param1.transform);
                }
                this._target.reset(param1.world.n14, param1.world.n24, param1.world.n34);
            }
            this._zAxis.copyFrom(this._target);
            this._zAxis.minusEq(this._position);
            this._zAxis.normalize();
            if (this._zAxis.modulo > 0.1)
            {
                if (!param2)
                {
                }
                this._xAxis = Number3D.cross(this._zAxis, UP, this._xAxis);
                this._xAxis.normalize();
                this._yAxis = Number3D.cross(this._zAxis, this._xAxis, this._yAxis);
                this._yAxis.normalize();
                _loc_4 = this.transform;
                _loc_4.n11 = this._xAxis.x * this._scaleX;
                _loc_4.n21 = this._xAxis.y * this._scaleX;
                _loc_4.n31 = this._xAxis.z * this._scaleX;
                _loc_4.n12 = (-this._yAxis.x) * this._scaleY;
                _loc_4.n22 = (-this._yAxis.y) * this._scaleY;
                _loc_4.n32 = (-this._yAxis.z) * this._scaleY;
                _loc_4.n13 = this._zAxis.x * this._scaleZ;
                _loc_4.n23 = this._zAxis.y * this._scaleZ;
                _loc_4.n33 = this._zAxis.z * this._scaleZ;
                var _loc_5:int = 0;
                this._localRotationZ = 0;
                var _loc_5:* = _loc_5;
                this._localRotationY = _loc_5;
                this._localRotationX = _loc_5;
                this._transformDirty = false;
                this._rotationDirty = true;
            }
            else
            {
                PaperLogger.error("lookAt error");
            }
            return;
        }// end function

        public function set rotationZ(param1:Number) : void
        {
            this._rotationZ = Papervision3D.useDEGREES ? (param1 * toRADIANS) : (param1);
            this._transformDirty = true;
            return;
        }// end function

        public function pitch(param1:Number) : void
        {
            param1 = Papervision3D.useDEGREES ? (param1 * toRADIANS) : (param1);
            if (this._transformDirty)
            {
                this.updateTransform();
            }
            this._qPitch.setFromAxisAngle(this.transform.n11, this.transform.n21, this.transform.n31, param1);
            this.transform.calculateMultiply3x3(this._qPitch.matrix, this.transform);
            this._localRotationX = this._localRotationX + param1;
            this._rotationDirty = true;
            return;
        }// end function

        protected function setParentContainer(param1:DisplayObject3D, param2:Boolean = true) : void
        {
            var _loc_3:DisplayObject3D = null;
            if (param2 && param1 != this)
            {
                this.parentContainer = param1;
            }
            for each (_loc_3 in children)
            {
                
                _loc_3.setParentContainer(param1, param2);
            }
            return;
        }// end function

        public function set rotationY(param1:Number) : void
        {
            this._rotationY = Papervision3D.useDEGREES ? (param1 * toRADIANS) : (param1);
            this._transformDirty = true;
            return;
        }// end function

        public function addGeometry(param1:GeometryObject3D = null) : void
        {
            if (param1)
            {
                this.geometry = param1;
            }
            return;
        }// end function

        public function get sceneX() : Number
        {
            return this.world.n14;
        }// end function

        public function get scaleX() : Number
        {
            if (Papervision3D.usePERCENT)
            {
                return this._scaleX * 100;
            }
            return this._scaleX;
        }// end function

        public function get scaleY() : Number
        {
            if (Papervision3D.usePERCENT)
            {
                return this._scaleY * 100;
            }
            return this._scaleY;
        }// end function

        public function get scaleZ() : Number
        {
            if (Papervision3D.usePERCENT)
            {
                return this._scaleZ * 100;
            }
            return this._scaleZ;
        }// end function

        public function get scale() : Number
        {
            if (this._scaleX == this._scaleY && this._scaleX == this._scaleZ)
            {
                if (Papervision3D.usePERCENT)
                {
                    return this._scaleX * 100;
                }
                return this._scaleX;
            }
            else
            {
                return NaN;
            }
        }// end function

        public function set position(param1:Number3D) : void
        {
            this.x = param1.x;
            this.y = param1.y;
            this.z = param1.z;
            return;
        }// end function

        public function moveUp(param1:Number) : void
        {
            this.translate(param1, UP);
            return;
        }// end function

        public function get sceneZ() : Number
        {
            return this.world.n34;
        }// end function

        public function get sceneY() : Number
        {
            return this.world.n24;
        }// end function

        public function distanceTo(param1:DisplayObject3D) : Number
        {
            var _loc_2:* = this.x - param1.x;
            var _loc_3:* = this.y - param1.y;
            var _loc_4:* = this.z - param1.z;
            return Math.sqrt(_loc_2 * _loc_2 + _loc_3 * _loc_3 + _loc_4 * _loc_4);
        }// end function

        private function updateMaterials(param1:DisplayObject3D, param2:MaterialObject3D, param3:MaterialObject3D) : void
        {
            var _loc_4:DisplayObject3D = null;
            var _loc_5:Triangle3D = null;
            param2.unregisterObject(param1);
            if (param3 is AbstractLightShadeMaterial || param3 is ShadedMaterial)
            {
                param3.registerObject(param1);
            }
            if (param1.material === param2)
            {
                param1.material = param3;
            }
            if (param1.geometry && param1.geometry.faces && param1.geometry.faces.length)
            {
                for each (_loc_5 in param1.geometry.faces)
                {
                    
                    if (_loc_5.material === param2)
                    {
                        _loc_5.material = param3;
                    }
                }
            }
            for each (_loc_4 in param1.children)
            {
                
                this.updateMaterials(_loc_4, param2, param3);
            }
            return;
        }// end function

        public function clone() : DisplayObject3D
        {
            var _loc_3:DisplayObject3D = null;
            var _loc_4:String = this;
            _loc_4._numClones = this._numClones++;
            var _loc_1:* = this.name + "_" + this._numClones++;
            var _loc_2:* = new DisplayObject3D(_loc_1);
            if (this.material)
            {
                _loc_2.material = this.material;
            }
            if (this.materials)
            {
                _loc_2.materials = this.materials.clone();
            }
            if (this.geometry)
            {
                _loc_2.geometry = this.geometry.clone(_loc_2);
                _loc_2.geometry.ready = true;
            }
            _loc_2.copyTransform(this.transform);
            for each (_loc_3 in this.children)
            {
                
                _loc_2.addChild(_loc_3.clone());
            }
            return _loc_2;
        }// end function

        public function set material(param1:MaterialObject3D) : void
        {
            if (this._material)
            {
                this._material.unregisterObject(this);
            }
            this._material = param1;
            if (this._material)
            {
                this._material.registerObject(this);
            }
            return;
        }// end function

        private function updateRotation() : void
        {
            this._tempScale.x = Papervision3D.usePERCENT ? (this._scaleX * 100) : (this._scaleX);
            this._tempScale.y = Papervision3D.usePERCENT ? (this._scaleY * 100) : (this._scaleY);
            this._tempScale.z = Papervision3D.usePERCENT ? (this._scaleZ * 100) : (this._scaleZ);
            this._rotation = Matrix3D.matrix2euler(this.transform, this._rotation, this._tempScale);
            this._rotationX = this._rotation.x * toRADIANS;
            this._rotationY = this._rotation.y * toRADIANS;
            this._rotationZ = this._rotation.z * toRADIANS;
            this._rotationDirty = false;
            return;
        }// end function

        public function hitTestObject(param1:DisplayObject3D, param2:Number = 1) : Boolean
        {
            var _loc_3:* = this.x - param1.x;
            var _loc_4:* = this.y - param1.y;
            var _loc_5:* = this.z - param1.z;
            var _loc_6:* = _loc_3 * _loc_3 + _loc_4 * _loc_4 + _loc_5 * _loc_5;
            var _loc_7:* = this.geometry ? (this.geometry.boundingSphere.maxDistance) : (0);
            var _loc_8:* = param1.geometry ? (param1.geometry.boundingSphere.maxDistance) : (0);
            _loc_7 = _loc_7 * param2;
            return _loc_7 + _loc_8 > _loc_6;
        }// end function

        public function translate(param1:Number, param2:Number3D) : void
        {
            var _loc_3:* = param2.clone();
            if (this._transformDirty)
            {
                this.updateTransform();
            }
            Matrix3D.rotateAxis(this.transform, _loc_3);
            this.x = this.x + param1 * _loc_3.x;
            this.y = this.y + param1 * _loc_3.y;
            this.z = this.z + param1 * _loc_3.z;
            return;
        }// end function

        public function get localRotationZ() : Number
        {
            return Papervision3D.useDEGREES ? (this._localRotationZ * toDEGREES) : (this._localRotationZ);
        }// end function

        public function get localRotationY() : Number
        {
            return Papervision3D.useDEGREES ? (this._localRotationY * toDEGREES) : (this._localRotationY);
        }// end function

        public function get z() : Number
        {
            return this.transform.n34;
        }// end function

        public function get localRotationX() : Number
        {
            return Papervision3D.useDEGREES ? (this._localRotationX * toDEGREES) : (this._localRotationX);
        }// end function

        public function get x() : Number
        {
            return this.transform.n14;
        }// end function

        public function get y() : Number
        {
            return this.transform.n24;
        }// end function

        public function moveLeft(param1:Number) : void
        {
            this.translate(param1, LEFT);
            return;
        }// end function

        public function replaceMaterialByName(param1:MaterialObject3D, param2:String) : void
        {
            if (!this.materials)
            {
                return;
            }
            var _loc_3:* = this.materials.getMaterialByName(param2);
            if (!_loc_3)
            {
                return;
            }
            if (this.material === _loc_3)
            {
                this.material = param1;
            }
            _loc_3 = this.materials.removeMaterial(_loc_3);
            param1 = this.materials.addMaterial(param1, param2);
            this.updateMaterials(this, _loc_3, param1);
            return;
        }// end function

        public function get scene() : SceneObject3D
        {
            return this._scene;
        }// end function

        public function set useOwnContainer(param1:Boolean) : void
        {
            this._useOwnContainer = param1;
            this.setParentContainer(this, true);
            return;
        }// end function

        public function getMaterialByName(param1:String) : MaterialObject3D
        {
            var _loc_3:DisplayObject3D = null;
            var _loc_2:* = this.materials ? (this.materials.getMaterialByName(param1)) : (null);
            if (_loc_2)
            {
                return _loc_2;
            }
            for each (_loc_3 in this._childrenByName)
            {
                
                _loc_2 = _loc_3.getMaterialByName(param1);
                if (_loc_2)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function copyTransform(param1) : void
        {
            var _loc_4:DisplayObject3D = null;
            if (param1 is DisplayObject3D)
            {
                _loc_4 = DisplayObject3D(param1);
                if (_loc_4._transformDirty)
                {
                    _loc_4.updateTransform();
                }
            }
            var _loc_2:* = this.transform;
            var _loc_3:* = param1 is DisplayObject3D ? (param1.transform) : (param1);
            _loc_2.n11 = _loc_3.n11;
            _loc_2.n12 = _loc_3.n12;
            _loc_2.n13 = _loc_3.n13;
            _loc_2.n14 = _loc_3.n14;
            _loc_2.n21 = _loc_3.n21;
            _loc_2.n22 = _loc_3.n22;
            _loc_2.n23 = _loc_3.n23;
            _loc_2.n24 = _loc_3.n24;
            _loc_2.n31 = _loc_3.n31;
            _loc_2.n32 = _loc_3.n32;
            _loc_2.n33 = _loc_3.n33;
            _loc_2.n34 = _loc_3.n34;
            this._transformDirty = false;
            this._rotationDirty = true;
            return;
        }// end function

        public function get rotationY() : Number
        {
            if (this._rotationDirty)
            {
                this.updateRotation();
            }
            return Papervision3D.useDEGREES ? (this._rotationY * toDEGREES) : (this._rotationY);
        }// end function

        public function get rotationZ() : Number
        {
            if (this._rotationDirty)
            {
                this.updateRotation();
            }
            return Papervision3D.useDEGREES ? (this._rotationZ * toDEGREES) : (this._rotationZ);
        }// end function

        public function set scaleY(param1:Number) : void
        {
            if (Papervision3D.usePERCENT)
            {
                this._scaleY = param1 / 100;
            }
            else
            {
                this._scaleY = param1;
            }
            this._transformDirty = true;
            return;
        }// end function

        public function roll(param1:Number) : void
        {
            param1 = Papervision3D.useDEGREES ? (param1 * toRADIANS) : (param1);
            if (this._transformDirty)
            {
                this.updateTransform();
            }
            this._qRoll.setFromAxisAngle(this.transform.n13, this.transform.n23, this.transform.n33, param1);
            this.transform.calculateMultiply3x3(this._qRoll.matrix, this.transform);
            this._localRotationZ = this._localRotationZ + param1;
            this._rotationDirty = true;
            return;
        }// end function

        public function set scaleZ(param1:Number) : void
        {
            if (Papervision3D.usePERCENT)
            {
                this._scaleZ = param1 / 100;
            }
            else
            {
                this._scaleZ = param1;
            }
            this._transformDirty = true;
            return;
        }// end function

        public function get rotationX() : Number
        {
            if (this._rotationDirty)
            {
                this.updateRotation();
            }
            return Papervision3D.useDEGREES ? (this._rotationX * toDEGREES) : (this._rotationX);
        }// end function

        public function set scale(param1:Number) : void
        {
            if (Papervision3D.usePERCENT)
            {
                param1 = param1 / 100;
            }
            var _loc_2:* = param1;
            this._scaleZ = param1;
            var _loc_2:* = _loc_2;
            this._scaleY = _loc_2;
            this._scaleX = _loc_2;
            this._transformDirty = true;
            return;
        }// end function

        public function get autoCalcScreenCoords() : Boolean
        {
            return this._autoCalcScreenCoords;
        }// end function

        public function yaw(param1:Number) : void
        {
            param1 = Papervision3D.useDEGREES ? (param1 * toRADIANS) : (param1);
            if (this._transformDirty)
            {
                this.updateTransform();
            }
            this._qYaw.setFromAxisAngle(this.transform.n12, this.transform.n22, this.transform.n32, param1);
            this.transform.calculateMultiply3x3(this._qYaw.matrix, this.transform);
            this._localRotationY = this._localRotationY + param1;
            this._rotationDirty = true;
            return;
        }// end function

        public function set scaleX(param1:Number) : void
        {
            if (Papervision3D.usePERCENT)
            {
                this._scaleX = param1 / 100;
            }
            else
            {
                this._scaleX = param1;
            }
            this._transformDirty = true;
            return;
        }// end function

        public function createViewportLayer(param1:Viewport3D, param2:Boolean = true) : ViewportLayer
        {
            var _loc_3:* = param1.getChildLayer(this, true);
            if (param2)
            {
                this.addChildrenToLayer(this, _loc_3);
            }
            return _loc_3;
        }// end function

        override public function toString() : String
        {
            return this.name + ": x:" + Math.round(this.x) + " y:" + Math.round(this.y) + " z:" + Math.round(this.z);
        }// end function

        public function moveForward(param1:Number) : void
        {
            this.translate(param1, FORWARD);
            return;
        }// end function

        public function addChildrenToLayer(param1:DisplayObject3D, param2:ViewportLayer) : void
        {
            var _loc_3:DisplayObject3D = null;
            for each (_loc_3 in param1.children)
            {
                
                param2.addDisplayObject3D(_loc_3);
                _loc_3.addChildrenToLayer(_loc_3, param2);
            }
            return;
        }// end function

        public function copyPosition(param1) : void
        {
            var _loc_2:* = this.transform;
            var _loc_3:* = param1 is DisplayObject3D ? (param1.transform) : (param1);
            _loc_2.n14 = _loc_3.n14;
            _loc_2.n24 = _loc_3.n24;
            _loc_2.n34 = _loc_3.n34;
            return;
        }// end function

        public function get useOwnContainer() : Boolean
        {
            return this._useOwnContainer;
        }// end function

        public function updateTransform() : void
        {
            this._rot.setFromEuler(this._rotationY, this._rotationZ, this._rotationX);
            this.transform.copy3x3(this._rot.matrix);
            _tempMatrix.reset();
            _tempMatrix.n11 = this._scaleX;
            _tempMatrix.n22 = this._scaleY;
            _tempMatrix.n33 = this._scaleZ;
            this.transform.calculateMultiply(this.transform, _tempMatrix);
            this._transformDirty = false;
            return;
        }// end function

        public function hitTestPoint(param1:Number, param2:Number, param3:Number) : Boolean
        {
            var _loc_4:* = this.x - param1;
            var _loc_5:* = this.y - param2;
            var _loc_6:* = this.z - param3;
            var _loc_7:* = _loc_4 * _loc_4 + _loc_5 * _loc_5 + _loc_6 * _loc_6;
            var _loc_8:* = this.geometry ? (this.geometry.boundingSphere.maxDistance) : (0);
            return (this.geometry ? (this.geometry.boundingSphere.maxDistance) : (0)) > _loc_7;
        }// end function

        public function moveBackward(param1:Number) : void
        {
            this.translate(param1, BACKWARD);
            return;
        }// end function

        public function set localRotationY(param1:Number) : void
        {
            param1 = Papervision3D.useDEGREES ? (param1 * toRADIANS) : (param1);
            if (this._transformDirty)
            {
                this.updateTransform();
            }
            this._qYaw.setFromAxisAngle(this.transform.n12, this.transform.n22, this.transform.n32, this._localRotationY - param1);
            this.transform.calculateMultiply3x3(this._qYaw.matrix, this.transform);
            this._localRotationY = param1;
            this._rotationDirty = true;
            return;
        }// end function

        public function set localRotationZ(param1:Number) : void
        {
            param1 = Papervision3D.useDEGREES ? (param1 * toRADIANS) : (param1);
            if (this._transformDirty)
            {
                this.updateTransform();
            }
            this._qRoll.setFromAxisAngle(this.transform.n13, this.transform.n23, this.transform.n33, this._localRotationZ - param1);
            this.transform.calculateMultiply3x3(this._qRoll.matrix, this.transform);
            this._localRotationZ = param1;
            this._rotationDirty = true;
            return;
        }// end function

        public function moveRight(param1:Number) : void
        {
            this.translate(param1, RIGHT);
            return;
        }// end function

        public function set x(param1:Number) : void
        {
            this.transform.n14 = param1;
            return;
        }// end function

        public function materialsList() : String
        {
            var _loc_2:String = null;
            var _loc_3:DisplayObject3D = null;
            var _loc_1:String = "";
            for (_loc_2 in this.materials)
            {
                
                _loc_1 = _loc_1 + (_loc_2 + "\n");
            }
            for each (_loc_3 in this._childrenByName)
            {
                
                for (_loc_2 in _loc_3.materials.materialsByName)
                {
                    
                    _loc_1 = _loc_1 + ("+ " + _loc_2 + "\n");
                }
            }
            return _loc_1;
        }// end function

        public function set autoCalcScreenCoords(param1:Boolean) : void
        {
            this._autoCalcScreenCoords = param1;
            return;
        }// end function

        public static function get ZERO() : DisplayObject3D
        {
            return new DisplayObject3D;
        }// end function

    }
}
