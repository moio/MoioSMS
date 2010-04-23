package net.moioli.moiosms.imagefilters

import net.moioli.moiosms.imagefilters.Image._

/**
 * Slightly blurs the thresholded input image by replacing
 * white pixels with black pixels if they have less than
 * minNeighbors neighbors.
 */
class BlurFilter(minNeighbors:Int) extends PixelImageFilter {
  override def pixelFunction(image:Image, x:Int, y:Int):Unit = {
    var neighbors = 0
    image.applyToNeighbors(x, y, (x1, y1) => {
      neighbors += (if(image(x1, y1) == BLACK) 1 else 0)
    })
    
    if(neighbors>=minNeighbors){
      image(x,y) = BLACK
    }
  }
}
