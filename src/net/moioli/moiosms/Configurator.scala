package net.moioli.moiosms

import scala.actors.Actor

import java.io.File

import org.apache.commons.io.FileUtils._

import org.ini4j.Ini

case class Get(key:String)
case class Put(key:String, value:String)

case class Got(value:Option[String])

object Configurator extends Actor {
  
  val file = new File(System.getProperty("user.home")+"/.moiosms/config.ini")
  touch(file)
  val ini = new Ini(file)
  ini.put("versioning", "version", "1.0")
  
  /**
   * @see scala.actors.Actor#act()
   */
  override def act(): Unit = {
    while (true) {
      receive {
        case g:Get =>
          val value = ini get (g.key, "main")
          sender ! Got(if (value == null) None else Some(value))
        case p:Put =>
          ini put ("main", p.key, p.value)
          ini store
        case Stop =>
          Console println this + ": stop"
          exit
      }
    }
  }
}