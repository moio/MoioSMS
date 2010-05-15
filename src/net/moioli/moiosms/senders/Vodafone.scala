package net.moioli.moiosms.senders

import scala.xml._
import scala.collection.Map

import java.security.MessageDigest
import java.math.BigInteger

import net.moioli.moiosms._
import net.moioli.moiosms.imagefilters.Image._
import net.moioli.moiosms.senders.VodafoneOCR._

object Vodafone extends Sender {

   override def login(params:Map[String, String]):Done = {
    val (acode, aheaders, abody) = Http.post(
      "https://widget.vodafone.it/190/trilogy/jsp/login.do?" + System.currentTimeMillis(),
      Map("username" -> params("Nome utente"), "password" -> params("Password"))
    )
    
    val (code, headers, body) = Http.get(
      "https://widget.vodafone.it/190/trilogy/jsp/utility/checkUser.jsp?token=" + getToken(params("Nome utente"))
    )
    val xml = XML.loadString(body)
    
    if ((xml \\ "logged-in").text equals "true"){
      return Done(true, "connessione avvenuta correttamente")
    }
    else{
      return Done(false, "nome utente o password errati")
    }
  }
   
  def precheck():Unit = {
    Http.get(
      "https://widget.vodafone.it/190/fsms/precheck.do?channel=VODAFONE_DW&" + System.currentTimeMillis
    )
  }

  override def send(receiver:String, text:String):Done = {
    precheck()
    val (code, headers, body) = Http.post(
      "https://widget.vodafone.it/190/fsms/prepare.do?channel=VODAFONE_DW",
      Map("receiverNumber" -> receiver, "message" ->text)
    )
    
    if (body.contains("Servizio non disponibile")){
      val cause = extractNodes(body, "ERRORCODE").head.attribute("v").get.toString
      return Done(false, "messaggio a " + receiver + " non inviato, " +
        (if (cause equals "104"){
          "i messaggi di oggi sono esauriti"
        }
        else{
          "errore non riconosciuto " + cause
       }))
    }
    
    val errorNodes = extractNodes(body, "CODEIMG")
    
    var captchaString = if (errorNodes isEmpty){
      ""
    }
    else{
      val image = read((errorNodes head) child(0) toString)
      decode(image)
    }

    val (code2, headers2, body2) = Http.post(
      "https://widget.vodafone.it/190/fsms/send.do?channel=VODAFONE_DW",
      Map("receiverNumber" -> receiver, "message" ->text, "verifyCode" -> captchaString)
    )
    
    if (body2 contains "inviati correttamente"){
      return Done(true, "messaggio inviato a " + receiver)
    }
    else{
      return Done(false, "messaggio a " + receiver + " non inviato, errore non riconosciuto " + body)
    }
  }

  def extractNodes(xml:String, n:String):NodeSeq = {
    val nodes = XML.loadString(xml)
    (nodes \\ "e").filter(_.attributes("n").head.toString equals n)
  }
  
  def getToken(username:String):String = {
    val md = MessageDigest.getInstance("MD5")
    md.update((username + System.currentTimeMillis()).getBytes())
    return new BigInteger(1,md.digest()).toString(16)
  }
}
