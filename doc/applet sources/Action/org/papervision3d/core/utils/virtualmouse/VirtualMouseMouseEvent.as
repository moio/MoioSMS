package org.papervision3d.core.utils.virtualmouse
{
    import flash.display.*;
    import flash.events.*;

    public class VirtualMouseMouseEvent extends MouseEvent implements IVirtualMouseEvent
    {

        public function VirtualMouseMouseEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Number = 1.#QNAN, param5:Number = 1.#QNAN, param6:InteractiveObject = null, param7:Boolean = false, param8:Boolean = false, param9:Boolean = false, param10:Boolean = false, param11:int = 0)
        {
            super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
            return;
        }// end function

    }
}
