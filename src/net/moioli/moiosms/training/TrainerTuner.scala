package net.moioli.moiosms.training

import org.encog.neural.activation._
import org.encog.neural.data._
import org.encog.neural.data.basic._
import org.encog.neural.networks._
import org.encog.neural.networks.layers._
import org.encog.neural.networks.training._
import org.encog.neural.networks.training.propagation.resilient._
import org.encog.neural.data.csv._
import org.encog.util.logging.Logging._
import java.io._

object TrainerTuner {
  def main(args : Array[String]) : Unit = {
   
    val trainingSet = new CSVNeuralDataSet("training/letters.csv", 225, 34, false)
    val validationSet = new CSVNeuralDataSet("training/letters-validation.csv", 225, 34, false)
    
    stopConsoleLogging
    var min = (1.0,0,0.0)
    for (nodes <- List.range(65, 80)){
      for (err <- List.range(10, 12).map(i => {i/1000.0})){
        val network = new BasicNetwork()
        network addLayer new BasicLayer(new ActivationSigmoid(), false, 225)
        network addLayer new BasicLayer(new ActivationSigmoid(), true, nodes)
        network addLayer new BasicLayer(new ActivationSigmoid(), false, 34)
        network getStructure() finalizeStructure()
        network reset
        val train = new ResilientPropagation(network, trainingSet, ResilientPropagation.DEFAULT_ZERO_TOLERANCE, ResilientPropagation.DEFAULT_INITIAL_UPDATE, ResilientPropagation.DEFAULT_MAX_STEP)
        
        do {
          train.iteration();
        } while(train.getError > err)
        
        val out = network.calculateError(validationSet)
        if (out<min._1){
          min = (out, nodes, err)
        }
        println ((nodes + " " + err + " " + out).replace(".", ","))
      }
    }
    println ("min was: " + (min._2 + " " + min._3 + " " + min._1))
  }
}
