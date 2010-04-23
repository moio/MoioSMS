package net.moioli.moiosms.imagefilters

/** A filter that applies a function to all the pixels in an image. */
trait PixelImageFilter extends CopyImageFilter{
  def pixelFunction(image:Image, x:Int, y:Int):Unit

  override def filter(input:Image, output:Image):Unit = {
    for (x <- List.range(0, input width)){
      for (y <- List.range(0, input height)){
        pixelFunction(output, x, y)
      }
    }
  }
}
