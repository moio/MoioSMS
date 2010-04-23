package net.moioli.moiosms.imagefilters

import net.moioli.moiosms.imagefilters.Image._

/**
 * Produces a grayscale version of the input image.
 */
class DesaturateFilter extends PixelImageFilter{
  override def pixelFunction(image:Image, x:Int, y:Int):Unit = {
    val rgb = unpack(image(x,y))
    val mean = (rgb._1 + rgb._2 + rgb._3) / 3
    image(x, y) = pack((mean, mean, mean))
  }
}
