package net.moioli.moiosms.training

import java.io._
import net.moioli.moiosms.imagefilters._
import net.moioli.moiosms.imagefilters.Image._

import org.encog.neural.activation._
import org.encog.neural.networks._
import org.encog.neural.networks.layers._
import org.encog.neural.networks.synapse._
import org.encog.persist.persistors._
import org.encog.parse.tags.read._
import org.encog.neural.data.basic._

object OCRTester {
  def main(args : Array[String]) : Unit = {
    val net = new BasicNetworkPersistor().load(new ReadXML(new FileInputStream("data/letters.eg"))).asInstanceOf[BasicNetwork]
    var i = 0
    var totalOk = 0
    var totalKo = 0
    new File("training").listFiles.filter {
        _.getName.endsWith("jpg")
    }.foreach {
      file => {
        if (i%2 == 1){
          val fileName = file getName()

          val letters = read(file) |
            new DesaturateFilter() |
            new RemovePatternFilter(new File("data/pattern.png")) |
            new ThresholdFilter(170) |
            new BlurFilter(7) |
            new RemoveSmallBlackAreasFilter(10) |
            new ColorLetterFilter() |
            new LetterSplitter()
        
          var decoded = new String()
          for (i <- List.range(0, 5)){
            val letter = letters(i) |
              new DesaturateFilter() |
              new ThresholdFilter(254) |
              new ResizeFilter(15,15)
            
            val rawInputs = List.range(0, letter width).map((x) => {
              List.range(0, letter height).map((y) =>{
                if (letter(x,y) == BLACK) 1.0 else -1.0                               
              })
            }).reduceLeft(_++_)

            val inputs = new BasicNeuralData(rawInputs toArray)
            val outputs = net compute inputs
            
            var max = 0.0
            var imax = 0
            for(i <- List.range(0, 34)){
              val d = outputs.getData(i)
              if (d>max){
                max = d
                imax = i
              }
            }
            decoded += "123456789ABCDEFGHIJKLMNPQRSTUVWXYZ"(imax)
          }

          val original = fileName.slice(0,5)
          print(original + "..." + decoded + " ")
          if (original equals decoded){
            println("OK")
            totalOk +=1
          }  else{
            print("KO, decoded ")
            for(i<-List.range(0,5)){
              if (original(i) != decoded(i)){
                print(decoded(i) + " but it was " + original(i) + " ")
              }
            }
            println()
            totalKo +=1
          }
        }
      i +=1
      }
    }
    
    println(totalOk/(totalOk+totalKo+0.0)*100 + "% success")
  }
}
