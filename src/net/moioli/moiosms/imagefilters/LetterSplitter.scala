package net.moioli.moiosms.imagefilters

/** Splits an image produced by ColorLetterFilter. */
class LetterSplitter extends ImageSplitter{
  
  override def split(image:Image):List[Image] = {
    new ColorLetterFilter().colors.map(color => {
      val bb = boundingBox(image, color)
      image part (bb._1, bb._2, bb._3, bb._4)
    })
  }
  
  def boundingBox(image:Image, color:Int):(Int, Int, Int, Int) = {
    val width = image width
    val height = image height
      
    var x1 = width
    var y1 = height
    var x2= -1
    var y2 = -1
    
    for(x <- List.range(0, width)){
      for(y <- List.range(0, height)){
        if (image(x,y) == color){
          if (x<x1){
            x1 = x
          }
          if (y<y1){
            y1 = y
          }
          if (x>x2){
            x2 = x
          }
          if (y>y2){
            y2 = y
          }
        }
      }
    }
    
    (x1, y1, x2-x1+1, y2-y1+1)
  }
}
