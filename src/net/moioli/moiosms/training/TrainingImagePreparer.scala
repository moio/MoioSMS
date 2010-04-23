package net.moioli.moiosms.training

import java.io._
import java.awt.image._
import javax.imageio._
import net.moioli.moiosms.imagefilters._
import net.moioli.moiosms.imagefilters.Image._

object TrainingImagePreparer {
  def main(args : Array[String]) : Unit = {
    var fileCount = 0
    new File("training").listFiles.filter {
        _.getName.endsWith("jpg")
    }.foreach {
      file => {
        println(file)
        val fileName = file getName
        val outputDir = if (fileCount%2 == 0){
          "letters/"
        }
        else{
          "letters-validation/"
        }
        
        val letters = read(file) |
          new DesaturateFilter() |
          new RemovePatternFilter(new File("data/pattern.png")) |
          new ThresholdFilter(170) |
          new BlurFilter(7) |
          new RemoveSmallBlackAreasFilter(10) |
          new ColorLetterFilter() |
          new LetterSplitter()
        
        for (i <- List.range(0, 5)){
            write(
              letters(i) |
                new DesaturateFilter() |
                new ThresholdFilter(254) |
                new ResizeFilter(15,15),
                new File("training/" + outputDir + fileName(i) + "-" + fileName.slice(0,5) + "n" + (i+1) + ".png")
            )
        }
        
        fileCount += 1
      }
    }
  }
}