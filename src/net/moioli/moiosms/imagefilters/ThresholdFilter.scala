package net.moioli.moiosms.imagefilters

import net.moioli.moiosms.imagefilters.Image._

/** Thresholds an image to black and white. */
class ThresholdFilter(threshold:Int) extends PixelImageFilter{
  override def pixelFunction(image:Image, x:Int, y:Int):Unit = {
    image(x,y) = (if (unpack(image(x,y))._1>threshold) WHITE else BLACK)
  }
}
