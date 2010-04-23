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
  val paramKeys = List("Nome utente", "Password")
  
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
   * @see scala.actors.Actor#act()
   */
  override def act(): Unit = {
    while (true) {
      try{
        receive {
          case l:Login =>
            UserInterface ! login(l.params) 
          case s:Send =>
            UserInterface ! send(s.receiver, s.message) 
          case Stop =>
            Console println this + ": stop"
            exit
        }
      }
      catch{
        case e: UnknownHostException => UserInterface ! Done(false, "Impossibile connettersi a: " + e.getMessage + ". Internet funziona?")
      }
    }
  }
}
