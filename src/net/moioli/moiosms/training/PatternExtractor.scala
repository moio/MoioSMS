package net.moioli.moiosms.training

import java.awt.image._
import javax.imageio._
import java.io._

object PatternExtractor {
  def main(args : Array[String]) : Unit = {
    val images = new File("training").listFiles.filter {
        _.getName.endsWith("jpg")
    }.map(image => {ImageIO.read(image)})
    
    val width = 150
    val height = 25
    val result = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB)

    val t = 100
    
    List.range(0, width).map(x =>{
      List.range(0, height).map (y =>{
        val histogram = List.range(t, 255).map(c =>{
          images.map(i =>{
            if (value(i.getRGB(x,y)) == c) 1 else 0
          }).reduceLeft(_+_)
        })
        val likelyColor = histogram.indexOf(histogram.reduceLeft(max(_,_)))+t
        result.setRGB(x,y, rgb(likelyColor))
      })
    })

    ImageIO.write(
      result,
      "png",
      new File("data/pattern.png")
    )
  }

def value(rgb:Int):Int = {
  (((rgb & 0x00FF0000)>>16) + ((rgb & 0x0000FF00)>>8) + (rgb & 0x000000FF))/3
}
def rgb(value:Int):Int = {
  (value << 16) | (value << 8) | value
}

def max(a:Int, b:Int) = {
  if (a>b) a else b 
}

}

