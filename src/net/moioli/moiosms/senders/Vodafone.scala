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
    Http.post(
      "https://widget.vodafone.it/190/trilogy/jsp/login.do?" + System.currentTimeMillis(),
      Map("username" -> params("Nome utente"), "password" -> params("Password"))
    )
    
    val (code, headers, body) = Http.get(
      "https://widget.vodafone.it/190/trilogy/jsp/utility/checkUser.jsp?token=" + getToken(params("Nome utente"))
    )
    val xml = XML.loadString(body)
    
    if ((xml \\ "logged-in").text equals "true"){
      precheck()
      return Done(true, "Vodafone: autenticato correttamente")
    }
    else{
      return Done(false, "Vodafone: nome utente o password errati")
    }
  }
   
  def precheck():Unit = {
    Http.get(
      "https://widget.vodafone.it/190/fsms/precheck.do?channel=VODAFONE_DW&" + System.currentTimeMillis
    )
  }

  override def send(receiver:String, text:String):Done = {
    val captchaString = getCaptchaString(receiver, text)
      
    val (code, headers, body) = Http.post(
      "https://widget.vodafone.it/190/fsms/send.do?channel=VODAFONE_DW",
      Map("receiverNumber" -> receiver, "message" ->text, "verifyCode" -> captchaString)
    )

    return Done(true, "Vodafone: " + body)
  }

  def getCaptchaString(receiverNumber:String, message:String):String = {
    val (code, headers, body) = Http.post(
      "https://widget.vodafone.it/190/fsms/prepare.do?channel=VODAFONE_DW",
      Map("receiverNumber" -> receiverNumber, "message" ->message)
    )
    
    if (body.contains("Servizio non disponibile")){
      
    }
    
    val xml = XML.loadString(body)
    
    val node = (xml \\ "e").filter(_.attributes.value equals "CODEIMG") 
    val image = read(node(0) child(0) toString)
    
    return decode(image)
  }
  
  def getToken(username:String):String = {
    val md = MessageDigest.getInstance("MD5")
    md.update((username + System.currentTimeMillis()).getBytes())
    return new BigInteger(1,md.digest()).toString(16)
  }
}
