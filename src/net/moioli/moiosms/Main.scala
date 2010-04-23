package net.moioli.moiosms

import scala.actors.Actor
import scala.actors.Actor._
import net.moioli.moiosms.senders._

case class Stop()

object Main {
  def main(args : Array[String]) : Unit = {
    UserInterface.start
    Vodafone.start
    Configurator.start

    val params = scala.collection.mutable.Map[String, String]()
    Vodafone.paramKeys.foreach(key => {
      Configurator !? Get("Vodafone "+ key) match {
        case Got(Some(value)) => params(key) = value
        case Got(None) =>
          println(key + ":")
          val value = Console.readLine()
          Configurator ! Put(key, value)
          params(key) = value
      }
    })
    
    Vodafone ! Login(params)

    println("Numero:")
    val receiver = Console.readLine()
    println("Testo:")
    val text = Console.readLine()
    
    Vodafone ! Send(receiver, text)
    Vodafone ! Stop     
  }
}

object UserInterface extends Actor {
  /**
   * @see scala.actors.Actor#act()
   */
  override def act(): Unit = {

    while (true) {
      receive {
        case d:Done =>
          Console println d
        case Stop =>
          Console println this + ": stop"
          exit
      }
    }
  }
}