package net.moioli.moiosms.imagefilters

/**
 * An image filter that alters a copy of the input image.
 */
trait CopyImageFilter extends ImageFilter{
    
  def filter(input:Image, output:Image):Unit

  override def filter(image:Image):Image = {
    val result = image copy;
    filter(image, result)
    return result
  }
}
