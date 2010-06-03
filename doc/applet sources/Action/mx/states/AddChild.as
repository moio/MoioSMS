package mx.states
{
    import flash.display.*;
    import mx.containers.*;
    import mx.core.*;
    import mx.resources.*;

    public class AddChild extends Object implements IOverride
    {
        var added:Boolean = false;
        var instanceCreated:Boolean = false;
        private var _creationPolicy:String = "auto";
        public var relativeTo:UIComponent;
        public var position:String;
        private var _target:DisplayObject;
        private var _targetFactory:IDeferredInstance;
        private var resourceManager:IResourceManager;
        static const VERSION:String = "3.2.0.3958";

        public function AddChild(param1:UIComponent = null, param2:DisplayObject = null, param3:String = "lastChild")
        {
            resourceManager = ResourceManager.getInstance();
            this.relativeTo = param1;
            this.target = param2;
            this.position = param3;
            return;
        }// end function

        public function remove(param1:UIComponent) : void
        {
            var _loc_2:* = relativeTo ? (relativeTo) : (param1);
            if (!added)
            {
                return;
            }
            switch(position)
            {
                case "before":
                case "after":
                {
                    _loc_2.parent.removeChild(target);
                    break;
                }
                case "firstChild":
                case "lastChild":
                {
                }
                default:
                {
                    if (target is ControlBar && _loc_2 is Panel)
                    {
                        Panel(_loc_2).rawChildren.removeChild(target);
                        Panel(_loc_2).createComponentsFromDescriptors();
                    }
                    else if (target is ApplicationControlBar && ApplicationControlBar(target).dock)
                    {
                        Application(_loc_2).dockControlBar(ApplicationControlBar(target), false);
                        Application(_loc_2).removeChild(target);
                    }
                    else if (_loc_2 == target.parent)
                    {
                        _loc_2.removeChild(target);
                    }
                    break;
                    break;
                }
            }
            added = false;
            return;
        }// end function

        public function initialize() : void
        {
            if (creationPolicy == ContainerCreationPolicy.AUTO)
            {
                createInstance();
            }
            return;
        }// end function

        public function get target() : DisplayObject
        {
            if (!_target && creationPolicy != ContainerCreationPolicy.NONE)
            {
                createInstance();
            }
            return _target;
        }// end function

        public function set creationPolicy(param1:String) : void
        {
            _creationPolicy = param1;
            if (_creationPolicy == ContainerCreationPolicy.ALL)
            {
                createInstance();
            }
            return;
        }// end function

        public function set target(param1:DisplayObject) : void
        {
            _target = param1;
            return;
        }// end function

        public function apply(param1:UIComponent) : void
        {
            var _loc_3:String = null;
            var _loc_2:* = relativeTo ? (relativeTo) : (param1);
            added = false;
            if (!target)
            {
                return;
            }
            if (target.parent)
            {
                _loc_3 = resourceManager.getString("states", "alreadyParented");
                throw new Error(_loc_3);
            }
            switch(position)
            {
                case "before":
                {
                    _loc_2.parent.addChildAt(target, _loc_2.parent.getChildIndex(_loc_2));
                    break;
                }
                case "after":
                {
                    _loc_2.parent.addChildAt(target, _loc_2.parent.getChildIndex(_loc_2) + 1);
                    break;
                }
                case "firstChild":
                {
                    _loc_2.addChildAt(target, 0);
                    break;
                }
                case "lastChild":
                {
                }
                default:
                {
                    _loc_2.addChild(target);
                    if (target is ControlBar && _loc_2 is Panel)
                    {
                        Panel(_loc_2).createComponentsFromDescriptors();
                    }
                    else if (target is ApplicationControlBar && ApplicationControlBar(target).dock && _loc_2 is Application)
                    {
                        ApplicationControlBar(target).resetDock(true);
                    }
                    break;
                    break;
                }
            }
            added = true;
            return;
        }// end function

        public function createInstance() : void
        {
            var _loc_1:Object = null;
            if (!instanceCreated && !_target && targetFactory)
            {
                instanceCreated = true;
                _loc_1 = targetFactory.getInstance();
                if (_loc_1 is DisplayObject)
                {
                    _target = DisplayObject(_loc_1);
                }
            }
            return;
        }// end function

        public function set targetFactory(param1:IDeferredInstance) : void
        {
            _targetFactory = param1;
            if (creationPolicy == ContainerCreationPolicy.ALL)
            {
                createInstance();
            }
            return;
        }// end function

        public function get creationPolicy() : String
        {
            return _creationPolicy;
        }// end function

        public function get targetFactory() : IDeferredInstance
        {
            return _targetFactory;
        }// end function

    }
}
