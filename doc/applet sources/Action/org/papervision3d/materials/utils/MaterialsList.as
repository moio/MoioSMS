package org.papervision3d.materials.utils
{
    import flash.utils.*;
    import org.papervision3d.core.proto.*;

    public class MaterialsList extends Object
    {
        protected var _materials:Dictionary;
        public var materialsByName:Dictionary;
        private var _materialsTotal:int;

        public function MaterialsList(param1 = null) : void
        {
            var _loc_2:String = null;
            var _loc_3:String = null;
            this.materialsByName = new Dictionary(true);
            this._materials = new Dictionary(false);
            this._materialsTotal = 0;
            if (param1)
            {
                if (param1 is Array)
                {
                    for (_loc_2 in param1)
                    {
                        
                        this.addMaterial(param1[_loc_2]);
                    }
                }
                else if (param1 is Object)
                {
                    for (_loc_3 in param1)
                    {
                        
                        this.addMaterial(param1[_loc_3], _loc_3);
                    }
                }
            }
            return;
        }// end function

        public function get numMaterials() : int
        {
            return this._materialsTotal;
        }// end function

        public function addMaterial(param1:MaterialObject3D, param2:String = null) : MaterialObject3D
        {
            if (!(param2 || param1.name))
            {
            }
            param2 = String(param1.id);
            this._materials[param1] = param2;
            this.materialsByName[param2] = param1;
            var _loc_3:String = this;
            _loc_3._materialsTotal = this._materialsTotal++;
            return param1;
        }// end function

        public function removeMaterial(param1:MaterialObject3D) : MaterialObject3D
        {
            if (this._materials[param1])
            {
                delete this.materialsByName[this._materials[param1]];
                delete this._materials[param1];
                var _loc_2:String = this;
                _loc_2._materialsTotal = this._materialsTotal--;
            }
            return param1;
        }// end function

        public function toString() : String
        {
            var _loc_2:MaterialObject3D = null;
            var _loc_1:String = "";
            for each (_loc_2 in this.materialsByName)
            {
                
                _loc_1 = _loc_1 + (this._materials[_loc_2] + "\n");
            }
            return _loc_1;
        }// end function

        public function removeMaterialByName(param1:String) : MaterialObject3D
        {
            return this.removeMaterial(this.getMaterialByName(param1));
        }// end function

        public function clone() : MaterialsList
        {
            var _loc_2:MaterialObject3D = null;
            var _loc_1:* = new MaterialsList();
            for each (_loc_2 in this.materialsByName)
            {
                
                _loc_1.addMaterial(_loc_2.clone(), this._materials[_loc_2]);
            }
            return _loc_1;
        }// end function

        public function getMaterialByName(param1:String) : MaterialObject3D
        {
            return this.materialsByName[param1] ? (this.materialsByName[param1]) : (this.materialsByName["all"]);
        }// end function

    }
}
