package mx.collections
{
    import flash.utils.*;

    public class ArrayCollection extends ListCollectionView implements IExternalizable
    {
        static const VERSION:String = "3.2.0.3958";

        public function ArrayCollection(param1:Array = null)
        {
            this.source = param1;
            return;
        }// end function

        public function set source(param1:Array) : void
        {
            list = new ArrayList(param1);
            return;
        }// end function

        public function readExternal(param1:IDataInput) : void
        {
            if (list is IExternalizable)
            {
                IExternalizable(list).readExternal(param1);
            }
            else
            {
                source = param1.readObject() as Array;
            }
            return;
        }// end function

        public function writeExternal(param1:IDataOutput) : void
        {
            if (list is IExternalizable)
            {
                IExternalizable(list).writeExternal(param1);
            }
            else
            {
                param1.writeObject(source);
            }
            return;
        }// end function

        public function get source() : Array
        {
            if (list && list is ArrayList)
            {
                return ArrayList(list).source;
            }
            return null;
        }// end function

    }
}
