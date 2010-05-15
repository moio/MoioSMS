package net.moioli.moiosms.senders

import scala.actors.Actor
import scala.actors.Actor._
import scala.collection.Map

import java.net.UnknownHostException

import net.moioli.moiosms._

// messages handled by a Sender
case class Login(params:Map[String, String])
case class Send(receiver:String, message:String)

// messages produced by a Sender
case class Done(success:Boolean, reason:String)

/**
 * An Actor that can send messages.
 * 
 * Defines a very basic interface to send messages and exposes it through an Actor
 * for concurrent use.
 */
trait Sender extends Actor {
  
  /**
   * List of parameters needed to login with this Sender,
   * can be overridden by subclasses.
   */
  val paramKeys:List[String] = List("Nome utente", "Password")
  
  /**
   * Authenticates a user to the sender.
   * 
   * @param a mapping between paramKeys elements and their values
   * @return a "done" message
   */
  protected def login(params:Map[String, String]):Done
  
  /**
   * Sends an SMS.
   * 
   * @return a "done" message
   */
  protected def send(receiver:String, text:String):Done
  
  
  /**
   * Returns the sender name.
   * 
   * @return a name
   */
  def name():String = {
    ((this getClass) getSimpleName) replace("$","")
  }
  
  /**
   * @see scala.actors.Actor#act()
   */
  override def act(): Unit = {
    while (true) {
      try{
        receive {
          case l:Login =>
            sender ! login(l.params) 
          case s:Send =>
            sender ! send(s.receiver, s.message) 
        }
      }
      catch{
        case e: UnknownHostException => sender ! Done(false, "Impossibile connettersi a: " + e.getMessage + ". Internet funziona?")
      }
    }
  }
}

/**
 * Returns all known senders.
 */
object SenderList {
  /**
   * Returns a list with all the known senders.
   * 
   * @return a name
   */
  def apply():List[Sender] = {
    List(Vodafone)
  }
}
