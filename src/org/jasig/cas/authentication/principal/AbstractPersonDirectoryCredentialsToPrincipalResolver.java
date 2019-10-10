package org.jasig.cas.authentication.principal;

import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jasig.cas.util.annotation.NotNull;
import org.jasig.services.persondir.IPersonAttributeDao;
import org.jasig.services.persondir.support.StubPersonAttributeDao;

public abstract class AbstractPersonDirectoryCredentialsToPrincipalResolver
  implements CredentialsToPrincipalResolver
{
  protected final Log log = LogFactory.getLog(getClass());

  @NotNull
  private IPersonAttributeDao attributeRepository = new StubPersonAttributeDao();

  public final Principal resolvePrincipal(Credentials credentials) {
	//  System.out.print("&&&&&&&&&&&&&&&&&&&&&&"+credentials.toString());
    if (this.log.isDebugEnabled()) {
      this.log.debug("Attempting to resolve a principal...");
    }

    String principalId = extractPrincipalId(credentials);

    if (principalId == null) {
      return null;
    }

    if (this.log.isDebugEnabled()) {
      this.log.debug("Creating SimplePrincipal for [" + principalId + "]");
    }

    Map attributes = this.attributeRepository.getUserAttributes(principalId);
    attributes.put("username", "sdhdsjhdhjs");
    Principal pr=  new SimplePrincipal(principalId, attributes);
    
    System.out.println("*****************************AbstractPersonDirectoryCredentialsToPrincipalResolver********************************");
    System.out.println(pr.toString());
    System.out.println("*****************************AbstractPersonDirectoryCredentialsToPrincipalResolver********************************");
    return new SimplePrincipal(principalId, attributes);
  }

  protected abstract String extractPrincipalId(Credentials paramCredentials);

  public final void setAttributeRepository(IPersonAttributeDao attributeRepository)
  {
    this.attributeRepository = attributeRepository;
  }
}