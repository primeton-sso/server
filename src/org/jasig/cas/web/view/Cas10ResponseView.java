package org.jasig.cas.web.view;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.jasig.cas.authentication.Authentication;
import org.jasig.cas.authentication.principal.Principal;
import org.jasig.cas.validation.Assertion;

public final class Cas10ResponseView extends AbstractCasView
{
  private boolean successResponse;

  protected void renderMergedOutputModel(Map model, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    Assertion assertion = getAssertionFrom(model);

    if (this.successResponse) {
    	System.out.println("*******************Cas10ResponseView*******************************");
    	Map<String, Object> userAttributes=	((Authentication)assertion.getChainedAuthentications().get(0)).getPrincipal().getAttributes();
    	System.out.println("*******************Cas10ResponseView*******************************");
    	System.out.println("*******************Cas10ResponseView*******************************");
    	 for (Object key : userAttributes.keySet()) {
    	        System.out.println("key = " + key.toString());
    	        System.out.println("key = " + userAttributes.keySet());
    	    }
      response.getWriter().print("yes\n" + ((Authentication)assertion.getChainedAuthentications().get(0)).getPrincipal().getId() + "\n");
    }
    else
    {
      response.getWriter().print("no\n\n");
    }
  }

  public void setSuccessResponse(boolean successResponse) {
    this.successResponse = successResponse;
  }
}