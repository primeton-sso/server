package org.jasig.cas.authentication.principal;

import java.net.URLEncoder;
import java.util.Map;
import java.util.Map.Entry;

public final class Response
{
  private final ResponseType responseType;
  private final String url;
  private final Map<String, String> attributes;

  protected Response(ResponseType responseType, String url, Map<String, String> attributes)
  {
    this.responseType = responseType;
    this.url = url;
    this.attributes = attributes;
  }

  public static Response getPostResponse(String url, Map<String, String> attributes)
  {
    return new Response(ResponseType.POST, url, attributes);
  }

  public static Response getRedirectResponse(String url, Map<String, String> parameters)
  {
    StringBuilder builder = new StringBuilder(parameters.size() * 40 + 100);

    boolean isFirst = true;
    
    ///
    
    parameters.put("name", "zhangsan");
    builder.append(url);
    System.out.println("****************************URL**********************************");
    System.out.println(url);
    System.out.println("****************************URL**********************************");
    for (Map.Entry entry : parameters.entrySet()) {
    	
      if (entry.getValue() != null) {
    	  System.out.println("key:"+entry+"\t"+"value"+entry.getValue());
        if (isFirst) {
          builder.append(url.contains("?") ? "&" : "?");
          isFirst = false;
        } else {
          builder.append("&");
        }
        builder.append((String)entry.getKey());
        builder.append("=");
        try
        {
          builder.append(URLEncoder.encode((String)entry.getValue(), "UTF-8"));
        } catch (Exception e) {
          builder.append((String)entry.getValue());
        }
      }
    }

    return new Response(ResponseType.REDIRECT, builder.toString(), parameters);
  }

  public Map<String, String> getAttributes() {
    return this.attributes;
  }

  public ResponseType getResponseType() {
    return this.responseType;
  }

  public String getUrl() {
    return this.url;
  }

  public static enum ResponseType
  {
    POST, REDIRECT;
  }
}