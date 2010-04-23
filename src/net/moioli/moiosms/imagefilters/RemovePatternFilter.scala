package net.moioli.moiosms.imagefilters

import java.io._
import net.moioli.moiosms.imagefilters.Image._

/** Removes a common noise pattern from an image. */
class RemovePatternFilter(pattern:File) extends PixelImageFilter{
  
  val patternImage = read(pattern)
  val MINIMUM_REMOVAL_VALUE = 50
  
  override def pixelFunction(image:Image, x:Int, y:Int):Unit = {
      val originalRgb = unpack(image(x, y))
      val patternRgb = unpack(patternImage(x, y))
      image(x,y) = pack(
        remove(originalRgb._1, patternRgb._1),
        remove(originalRgb._2, patternRgb._2),
        remove(originalRgb._3, patternRgb._3)
      )
  }
  
  def remove(original:Int, pattern:Int):Int={
    if (original>=MINIMUM_REMOVAL_VALUE){
      original + (255 - pattern)
    }
    else{
      original
    }
  }
}
