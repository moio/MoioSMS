package net.moioli.moiosms.senders

import java.io._

import org.encog.neural.activation._
import org.encog.neural.networks._
import org.encog.neural.networks.layers._
import org.encog.neural.networks.synapse._
import org.encog.persist.persistors._
import org.encog.parse.tags.read._
import org.encog.neural.data.basic._

import net.moioli.moiosms.imagefilters._
import net.moioli.moiosms.imagefilters.Image._

object VodafoneOCR {
  def decode(image:Image):String = {
    
    val net = new BasicNetworkPersistor().load(new ReadXML(new FileInputStream("data/letters.eg"))).asInstanceOf[BasicNetwork]

    val letters = (image |
      new DesaturateFilter() |
      new RemovePatternFilter(new File("data/pattern.png")) |
      new ThresholdFilter(170) |
      new BlurFilter(7) |
      new RemoveSmallBlackAreasFilter(10) |
      new ColorLetterFilter() |
      new LetterSplitter()
    ).map( _ |
      new DesaturateFilter() | 
      new ThresholdFilter(254) | 
      new ResizeFilter(15,15)
    )
    
    letters.map(letter => {
      val inputs = imageToInputs(letter)
      val outputs = (net compute inputs) getData
      
      val maxScore = outputs.reduceLeft(_ max _)
      
      "123456789ABCDEFGHIJKLMNPQRSTUVWXYZ"(outputs indexOf maxScore) toString
    }).reduceLeft(_+_)
  }
  
  def imageToInputs(image:Image) = {
    new BasicNeuralData(
      List.range(0, image width).map((x) => {
        List.range(0, image height).map((y) =>{
          if (image(x,y) == BLACK) 1.0 else -1.0                               
        })
      }).reduceLeft(_++_).toArray
    )
  }
}
