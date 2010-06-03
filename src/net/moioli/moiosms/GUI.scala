package net.moioli.moiosms

import scala.collection.mutable.HashMap

import scala.actors.Actor
import scala.actors.Actor._

import java.awt._
import java.awt.event._

import net.moioli.moiosms.swing._
import net.moioli.moiosms.senders._

case class Configure()
case class Message(string:String)
case class SendMessage(sender:String, destination:String, message:String)

object GUI extends Actor {
  
  System setProperty("apple.laf.useScreenMenuBar", "true")

  val senderNameList = SenderList().map(sender => sender name)
  val senderNameMap = Map.empty ++ (SenderList().map(sender => {(sender name, sender)}))
  
  val configurationFrame = new ConfigurationFrame(
    Array(SenderList().map(sender => {
      new ConfigurationPanel(
        sender name,
        Array(sender.paramKeys.map(key=>{new ConfigurationPairPanel(key)}) :_*)
      ){
        override def getConfigurationText(sender:String, key:String):String = {
          Configurator !? Get(sender + " " + key) match {
            case Got(Some(value)) =>
              value
            case Got(None) =>
              return ""
          }
        }
      }
    }) :_*)
  ){
    override def save(map:java.util.Map[String, java.util.Map[String,String]]){
      val i = map.keySet.iterator
      while(i hasNext){
        val sender = i next
        val params = map get(sender)
        val j = params.keySet.iterator
        val scalaParams = new HashMap[String,String]()
        while (j hasNext){
          val key = j next
          val value = params get(key)
          scalaParams += key -> value
          Configurator ! Put(sender + " " + key, value)
        }
        senderNameMap(sender) ! Login(scalaParams)
      }
    }
  }

  val mainFrame = new MainFrame(Array(senderNameList :_*), configurationFrame){
    override def sendMessage(){
      GUI ! SendMessage(selectedSender, destinationTextField.getText(), messageTextArea.getText())
    }
  }
  
  /**
   * @see scala.actors.Actor#act()
   */
  override def act(): Unit = {
    
    EventQueue.invokeLater(new Runnable() {
      override def run() {
          mainFrame.setVisible(true);
      }
    })

    while (true) {
      receive {
        case d:Done =>
          val senderName = sender toString()
          EventQueue.invokeLater(new Runnable() {
            override def run() {
                mainFrame.logTextArea.setText(mainFrame.logTextArea.getText() + senderName + ": " + (d reason) + "\n")
            }
          })
        case c:Configure =>
          EventQueue.invokeLater(new Runnable() {
            override def run() {
                configurationFrame.setVisible(true);
            }
          })
        case m:Message =>
          EventQueue.invokeLater(new Runnable() {
            override def run() {
                mainFrame.logTextArea.setText(mainFrame.logTextArea.getText() + m.string + "\n")
            }
          })
        case s:SendMessage =>
          senderNameMap(s sender) ! Send(s destination, s message)
        case Stop =>
          Console println this + ": stop"
          exit
      }
    }
  }
}