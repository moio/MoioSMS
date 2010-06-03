package net.moioli.moiosms

import scala.actors.Actor
import scala.actors.Actor._

import net.moioli.moiosms.senders._

case class Stop()

object Main {
  def main(args : Array[String]) : Unit = {
    
    Configurator.start
    GUI.start
    
    SenderList().foreach(sender => {
      sender start
      
      var params = Map.empty[String, String]
      sender.paramKeys.foreach(key => {
        Configurator !? Get(sender.name + " " + key) match {
          case Got(Some(value)) => params += ((key, value))
          case Got(None) => GUI ! Configure
        }
      })
      
      if (params nonEmpty){
        sender !? Login(params) match {
          case d:Done => GUI ! Message((sender name) + ": " + d.reason)
        }
      }
      else{
        GUI ! Message("Il sito " + (sender name) + " non è configurato, usa la funzione Siti... dal menù per inserire il nome utente e la password.")
      }
    })
  }
}
