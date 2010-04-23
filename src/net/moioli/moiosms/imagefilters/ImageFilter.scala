package net.moioli.moiosms.imagefilters

/**
 * Applies some transformation to an input image.
 */
trait ImageFilter {
  def filter(image:Image):Image = {image}
}
