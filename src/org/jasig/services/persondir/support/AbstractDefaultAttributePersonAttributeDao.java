package org.jasig.services.persondir.support;

import java.util.Collections;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jasig.services.persondir.IPersonAttributeDao;

public abstract class AbstractDefaultAttributePersonAttributeDao
  implements IPersonAttributeDao
{
  protected final Log logger = LogFactory.getLog(getClass());

  private String defaultAttribute = "username";

  public final Map getUserAttributes(String uid)
  {
    if (uid == null) {
      throw new IllegalArgumentException("Illegal to invoke getUserAttributes(String) with null argument.");
    }

    Map seed = Collections.singletonMap(getDefaultAttributeName(), uid);
    System.out.println("Created seed map='" + seed + "' for uid='" + uid + "'");
    Map userAttributes = getUserAttributes(seed);
    System.out.println("********************************************");
    for (Object key : userAttributes.keySet()) {
        System.out.println("key = " + key.toString());
        System.out.println("key = " + userAttributes.keySet());
    }
    return userAttributes;
  }

  public final String getDefaultAttributeName()
  {
    return this.defaultAttribute;
  }

  public final void setDefaultAttributeName(String name)
  {
    if (name == null) {
      throw new IllegalArgumentException("The default attribute name may not be null");
    }
    this.defaultAttribute = name;
  }
}