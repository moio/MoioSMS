package net.moioli.moiosms.imagefilters

import net.moioli.moiosms.imagefilters.Image._

/**
 * Recognizes five connected black areas (letters)
 * and colors them.
 */
class ColorLetterFilter extends CopyImageFilter {
  val RED = 0xFFFF0000
  val GREEN = 0xFF00FF00
  val BLUE = 0xFF0000FF
  val YELLOW = 0xFFFFFF00
  val MAGENTA = 0xFFFF00FF
  
  val colors = List(RED, GREEN, BLUE, YELLOW, MAGENTA)
  
  override def filter(input:Image, output:Image):Unit = {
    val height = input height
    var letter = 0
    for (x <- List.range(0, input width)){
      for (y <- List(height/3, height/2, height*2/3)){
        if (output(x, y) == BLACK && letter < 5){
          output.floodFill(x, y, colors(letter))
          letter += 1
        }
      }
    }
  }
}
