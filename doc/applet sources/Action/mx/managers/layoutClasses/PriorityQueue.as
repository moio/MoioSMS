package mx.managers.layoutClasses
{
    import flash.display.*;
    import mx.core.*;
    import mx.managers.*;

    public class PriorityQueue extends Object
    {
        private var maxPriority:int = -1;
        private var arrayOfArrays:Array;
        private var minPriority:int = 0;
        static const VERSION:String = "3.2.0.3958";

        public function PriorityQueue()
        {
            arrayOfArrays = [];
            return;
        }// end function

        public function addObject(param1:Object, param2:int) : void
        {
            if (!arrayOfArrays[param2])
            {
                arrayOfArrays[param2] = [];
            }
            arrayOfArrays[param2].push(param1);
            if (maxPriority < minPriority)
            {
                var _loc_3:* = param2;
                maxPriority = param2;
                minPriority = _loc_3;
            }
            else
            {
                if (param2 < minPriority)
                {
                    minPriority = param2;
                }
                if (param2 > maxPriority)
                {
                    maxPriority = param2;
                }
            }
            return;
        }// end function

        public function removeSmallest() : Object
        {
            var _loc_1:Object = null;
            if (minPriority <= maxPriority)
            {
                while (!arrayOfArrays[minPriority] || arrayOfArrays[minPriority].length == 0)
                {
                    
                    minPriority++;
                    if (minPriority > maxPriority)
                    {
                        return null;
                    }
                }
                _loc_1 = arrayOfArrays[minPriority].shift();
                while (!arrayOfArrays[minPriority] || arrayOfArrays[minPriority].length == 0)
                {
                    
                    minPriority++;
                    if (minPriority > maxPriority)
                    {
                        break;
                    }
                }
            }
            return _loc_1;
        }// end function

        public function removeLargestChild(param1:ILayoutManagerClient) : Object
        {
            var _loc_5:int = 0;
            var _loc_2:Object = null;
            var _loc_3:* = maxPriority;
            var _loc_4:* = param1.nestLevel;
            while (_loc_4 <= _loc_3)
            {
                
                if (arrayOfArrays[_loc_3] && arrayOfArrays[_loc_3].length > 0)
                {
                    _loc_5 = 0;
                    while (_loc_5 < arrayOfArrays[_loc_3].length)
                    {
                        
                        if (contains(DisplayObject(param1), arrayOfArrays[_loc_3][_loc_5]))
                        {
                            _loc_2 = arrayOfArrays[_loc_3][_loc_5];
                            arrayOfArrays[_loc_3].splice(_loc_5, 1);
                            return _loc_2;
                        }
                        _loc_5++;
                    }
                    continue;
                }
                if (_loc_3-- == maxPriority)
                {
                    maxPriority--;
                }
                if (_loc_3-- < _loc_4)
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function isEmpty() : Boolean
        {
            return minPriority > maxPriority;
        }// end function

        public function removeLargest() : Object
        {
            var _loc_1:Object = null;
            if (minPriority <= maxPriority)
            {
                while (!arrayOfArrays[maxPriority] || arrayOfArrays[maxPriority].length == 0)
                {
                    
                    maxPriority--;
                    if (maxPriority < minPriority)
                    {
                        return null;
                    }
                }
                _loc_1 = arrayOfArrays[maxPriority].shift();
                while (!arrayOfArrays[maxPriority] || arrayOfArrays[maxPriority].length == 0)
                {
                    
                    maxPriority--;
                    if (maxPriority < minPriority)
                    {
                        break;
                    }
                }
            }
            return _loc_1;
        }// end function

        public function removeSmallestChild(param1:ILayoutManagerClient) : Object
        {
            var _loc_4:int = 0;
            var _loc_2:Object = null;
            var _loc_3:* = param1.nestLevel;
            while (_loc_3 <= maxPriority)
            {
                
                if (arrayOfArrays[_loc_3] && arrayOfArrays[_loc_3].length > 0)
                {
                    _loc_4 = 0;
                    while (_loc_4 < arrayOfArrays[_loc_3].length)
                    {
                        
                        if (contains(DisplayObject(param1), arrayOfArrays[_loc_3][_loc_4]))
                        {
                            _loc_2 = arrayOfArrays[_loc_3][_loc_4];
                            arrayOfArrays[_loc_3].splice(_loc_4, 1);
                            return _loc_2;
                        }
                        _loc_4++;
                    }
                    _loc_3++;
                    continue;
                }
                if (_loc_3 == minPriority)
                {
                    minPriority++;
                }
                _loc_3++;
                if (_loc_3 > maxPriority)
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function removeAll() : void
        {
            arrayOfArrays.splice(0);
            minPriority = 0;
            maxPriority = -1;
            return;
        }// end function

        private function contains(param1:DisplayObject, param2:DisplayObject) : Boolean
        {
            var _loc_3:IChildList = null;
            if (param1 is IRawChildrenContainer)
            {
                _loc_3 = IRawChildrenContainer(param1).rawChildren;
                return _loc_3.contains(param2);
            }
            if (param1 is DisplayObjectContainer)
            {
                return DisplayObjectContainer(param1).contains(param2);
            }
            return param1 == param2;
        }// end function

    }
}
