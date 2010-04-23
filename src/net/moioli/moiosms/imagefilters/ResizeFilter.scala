package net.moioli.moiosms.imagefilters

/** Resizes an input image. */
class ResizeFilter(width:Int, height:Int) extends ImageFilter{
  override def filter(image:Image):Image = {
    image scaledCopy(width, height)
  }
}
