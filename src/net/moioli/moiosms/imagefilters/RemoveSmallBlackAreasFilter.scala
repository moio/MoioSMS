package net.moioli.moiosms.imagefilters

import net.moioli.moiosms.imagefilters.Image._

/**
 * Removes black connected portions of the binary input image with areas below
 * the minArea threshold.
 */
class RemoveSmallBlackAreasFilter(minArea:Int) extends PixelImageFilter {
  override def pixelFunction(image:Image, x:Int, y:Int):Unit = {
    if (image(x,y) == BLACK && image.connectedArea(x, y) < minArea){
        image.floodFill(x, y, WHITE)
    }
  }
}
