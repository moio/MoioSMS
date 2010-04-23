package net.moioli.moiosms.imagefilters

import java.awt.image._
import java.io._
import javax.imageio._

import org.apache.commons.codec.binary._

/**
 * Wraps a BufferedImage and adds some utility methods.
 */
class Image(val raw: BufferedImage) {
  
  val width = raw getWidth
  val height = raw getHeight
  
  /** Get a pixel in packed format. */
  def apply(x:Int, y:Int):Int = {
    raw getRGB(x, y)
  }

  /** Sets a pixel in packed format. */
  def update(x:Int, y:Int, color:Int):Unit = {
    raw setRGB(x, y, color)
  }
  
  /** Applies a filter. */
  def |(filter:ImageFilter):Image = {
    filter.filter(this)
  }

  /** Applies a splitter. */
  def |(splitter:ImageSplitter):List[Image] = {
    splitter.split(this)
  }
  
  /** Returns a copy of this image. */
  def copy():Image = {
    val copy = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB)
    copy createGraphics() drawImage(raw, 0, 0, width, height, null)
    new Image(copy)
  }
  
  /** Returns a scaled copy of this image. */
  def scaledCopy(scaledWidth:Int, scaledHeight:Int):Image = {
    val scaledCopy = new BufferedImage(scaledWidth, scaledHeight, BufferedImage.TYPE_INT_ARGB)
    scaledCopy.createGraphics().drawImage(
      raw getScaledInstance(scaledWidth, scaledHeight, java.awt.Image.SCALE_FAST),
      0,
      0,
      null
    )
    new Image(scaledCopy)
  }

  /** Returns a portion of this image. */
  def part(x:Int, y:Int, width:Int, height:Int) = {
    new Image(raw getSubimage(x, y, width, height))
  }
  
  /** 9-way flood-fills the area connected to x,y. */
  def floodFill(x:Int, y:Int, color:Int) = {
    applyToConnected(x, y, this(_, _) = color)
  }

  /** Returns the number of connected pixels. */
  def connectedArea(x:Int, y:Int):Int = {
    var result = 0
    applyToConnected(x, y, (x1, y1) => {
      result += 1
    })
    result
  }
  
  /** Applies the specified function to all pixels 9-way connected to x,y. */
  def applyToConnected(x:Int, y:Int, function:(Int, Int) => Unit):Unit = {
    applyToConnected(x, y, function, this(x,y), new Array[Array[Boolean]](width, height))
  }
  
  private def applyToConnected(x:Int, y:Int, function:(Int, Int) => Unit, color:Int, visited:Array[Array[Boolean]]):Unit = {
    if (this(x, y) == color && visited(x)(y) == false){
      function(x, y)
      visited(x)(y) = true
      applyToNeighbors(x, y, applyToConnected(_, _, function, color, visited))
    }
  }

  /** Applies the specified function to 9-way neighbors of x,y. */
  def applyToNeighbors(x:Int, y:Int, function:(Int, Int) => Unit):Unit = {
    if (y>0){//N
      function(x, y-1)
    }
    if (y>0 && x<width-1){//NE
      function(x+1, y-1)
    }
    if (x<width-1){//E
      function(x+1, y)
    }
    if (y<height-1 && x<width-1){//SE
      function(x+1, y+1)
    }
    if (y<height-1){//S
      function(x, y+1)
    }
    if (y<height-1 && x>0){//SW
      function(x-1, y+1)
    }
    if (x>0){//W
      function(x-1, y)
    }
    if (y>0 && x>0){//NW
      function(x-1, y-1)
    }
  }
}

object Image {
  val BLACK = 0xFF000000
  val WHITE = 0xFFFFFFFF
  
  def read(base64String: String) = {
    new Image(ImageIO read new ByteArrayInputStream(new Base64() decode (base64String)))
  }

  def read(file:File):Image = {
    new Image(ImageIO read file)
  }
  
  def write(image:Image, file:File) = {
    ImageIO write (image raw, "png", file)
  }
  
  /** Unpacks a packed color into its RGB components. */
  def unpack(color:Int):(Int, Int, Int) = {
    ((color & 0x00FF0000)>>16,  (color & 0x0000FF00)>>8, color & 0x000000FF)
  }

  /** Packs three RGB components to an packed color. */
  def pack(color:(Int, Int, Int)):Int = {
    0xFF000000 | ((limit(color._1) & 0xFF) << 16) | ((limit(color._2) & 0xFF) << 8) | (limit(color._3) & 0xFF)
  }
  
  private def limit(value:Int):Int = {
    if (value>=0){
      if (value <= 0xFF){
        value
      }
      else{
        0xFF
      }
    }
    else{
      0x00
    }
  }
}
