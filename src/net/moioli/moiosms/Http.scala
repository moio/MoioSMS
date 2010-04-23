package net.moioli.moiosms

import scala.collection.Map

import java.util.LinkedList
import java.net.URI
import java.io.File

import org.apache.commons.io._
import org.apache.http._
import org.apache.http.client.entity._
import org.apache.http.client.methods._
import org.apache.http.client.params._
import org.apache.http.client.utils._
import org.apache.http.cookie._
import org.apache.http.impl.client._
import org.apache.http.impl.cookie._
import org.apache.http.message._
import org.apache.http.params._
import org.apache.http.protocol._

object Http {
  
  // init client, add method to follow redirects and force to always accept cookies
  private val client = new DefaultHttpClient {
    def executeFollowingRedirects(request:HttpUriRequest):HttpResponse = {
      var result = execute(request)
      while(result.getStatusLine().getStatusCode() == 302){
        val oldURI = request.getURI()
        val location = result.getFirstHeader("Location").getValue()
        var uri = if (new URI(location).isAbsolute()){
          location
        }
        else{
          URIUtils.rewriteURI(new URI(new File(oldURI.getPath).getParent + "/" + location), new HttpHost(oldURI.getHost(), oldURI.getPort(), oldURI.getScheme())).toString
        }
        result.getEntity().consumeContent()
        result = execute(new HttpGet(uri))
      }
      return result
    }
  }
  client.getCookieSpecs().register("easy", new CookieSpecFactory{
    override def newInstance(params:HttpParams):CookieSpec = {
      return new BrowserCompatSpec{
        override def validate(cookie:Cookie, origin:CookieOrigin):Unit = {}
      }
    }
  })
  client.getParams().setParameter(ClientPNames.COOKIE_POLICY, "easy")

  /**
   * Make an HTTP GET request.
   * 
   * @param url the URL
   * @return (code, headers, body)
   */
  def get(url:String):(Int, Map[String, String], String) = {
    val get = new HttpGet(url)

    val response = client.executeFollowingRedirects(get)
    
    return process(response)
  }

  /**
   * Make an HTTP POST request.
   * 
   * @param url the URL
   * @param params the key-value POST map
   * @return (code, headers, body)
   */
  def post(url:String, params:Map[String, String]):(Int, Map[String, String], String) = {
    val post = new HttpPost(url)
    
    val postParams = new LinkedList[NameValuePair]
    params.foreach{
      pair => postParams add new BasicNameValuePair(pair._1, pair._2)
    }
    post setEntity new UrlEncodedFormEntity(postParams, HTTP.UTF_8)
    
    val response = client.executeFollowingRedirects(post)
    
    return process(response)
  }
  
  private def process(response:HttpResponse):(Int, Map[String, String], String) = {
    val resultCode = response.getStatusLine().getStatusCode()
    var resultMap = Map[String, String]()
    response.getAllHeaders().foreach{
      header => resultMap = resultMap + {(header.getName(), header.getValue())}
    }
    val resultContent = IOUtils.toString(response.getEntity().getContent())
    
    response.getEntity().consumeContent()
    return (resultCode, resultMap, resultContent)
  }
}
