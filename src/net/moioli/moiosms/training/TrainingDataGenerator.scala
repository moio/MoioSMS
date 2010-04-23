package net.moioli.moiosms.training

import java.io._
import net.moioli.moiosms.imagefilters.Image._

/**
 * Takes images in training/letters and generates training data
 * (letters.csv) and validation data (letters-validation.csv).
 */
object TrainingDataGenerator {

  def main(args : Array[String]) : Unit = {
    val trainingSet = new File("training/letters").listFiles.filter {
        _.getName.endsWith("png")
    }
    generateLetterTrainingData(new FileOutputStream("training/letters.csv"), trainingSet)

    val validationSet = new File("training/letters-validation").listFiles.filter {
        _.getName.endsWith("png")
    }
    generateLetterTrainingData(new FileOutputStream("training/letters-validation.csv"), validationSet)
  }
  
  def generateLetterTrainingData(trainingOutput:FileOutputStream, trainingSet:Array[File]):Unit = {
    var i = 0
    trainingSet.foreach {
      f => {
        val image = read(f)
        val inputs = List.range(0, image width).map((x) => {
          List.range(0, image height).map((y) =>{
            if (image(x,y) == BLACK) 1.0 else -1.0                               
          })
        }).reduceLeft(_++_)
        val ideals = "123456789ABCDEFGHIJKLMNPQRSTUVWXYZ" map (l =>{
          if (l == f.getName()(0)) 1.0 else 0.0 
        })
        writeData(inputs ++ ideals, trainingOutput)
        i+=1
      }
    }
  }

  def writeData(data:List[Double], file:FileOutputStream):Unit = {
      data.foreach(datum => {
        file.write((datum + ",") getBytes)
      })
      file write ("\n" getBytes)
  }
}
