package org.jasig.cas.authentication.principal;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.util.StringUtils;

public final class SimpleWebApplicationServiceImpl extends AbstractWebApplicationService
{
  private static final String CONST_PARAM_SERVICE = "service";
  private static final String CONST_PARAM_TARGET_SERVICE = "targetService";
  private static final String CONST_PARAM_TICKET = "ticket";
  private static final String CONST_PARAM_METHOD = "method";
  private final Response.ResponseType responseType;
  private static final long serialVersionUID = 8334068957483758042L;

  public SimpleWebApplicationServiceImpl(String id)
  {
    this(id, id, null, null);
  }

  private SimpleWebApplicationServiceImpl(String id, String originalUrl, String artifactId, Response.ResponseType responseType)
  {
    super(id, originalUrl, artifactId);
    this.responseType = responseType;
  }

  public static SimpleWebApplicationServiceImpl createServiceFrom(HttpServletRequest request)
  {
    String targetService = request.getParameter("targetService");

    String method = request.getParameter("method");
    String serviceToUse = StringUtils.hasText(targetService) ? targetService : request.getParameter("service");

    if (!StringUtils.hasText(serviceToUse)) {
      return null;
    }

    String id = cleanupUrl(serviceToUse);
    String artifactId = request.getParameter("ticket");

    return new SimpleWebApplicationServiceImpl(id, serviceToUse, artifactId, "POST".equals(method) ? Response.ResponseType.POST : Response.ResponseType.REDIRECT);
  }

  public Response getResponse(String ticketId)
  {
    Map parameters = new HashMap();

    if (StringUtils.hasText(ticketId)) {
      parameters.put("ticket", ticketId);
    }

    if (Response.ResponseType.POST == this.responseType) {
      return Response.getPostResponse(getOriginalUrl(), parameters);
    }
    return Response.getRedirectResponse(getOriginalUrl(), parameters);
  }
}