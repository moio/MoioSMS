package net.moioli.moiosms.imagefilters

/** Produces a set of images from an input image. */
trait ImageSplitter {
  def split(image:Image):List[Image]
}
