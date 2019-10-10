package com.primeton.sso.impl;

import java.util.Collections;
import java.util.Map;
import java.util.Set;
import org.jasig.services.persondir.IPersonAttributeDao;

public class StubPersonAttributeDaoImpl
  implements IPersonAttributeDao
{
  private Map backingMap = null;

  public StubPersonAttributeDaoImpl() {
  }

  public StubPersonAttributeDaoImpl(Map backingMap) {
    setBackingMap(backingMap);
  }

  public Set getPossibleUserAttributeNames() {
    if (this.backingMap == null) {
      return Collections.EMPTY_SET;
    }

    return Collections.unmodifiableSet(this.backingMap.keySet());
  }

  public Map getUserAttributes(Map seed) {
    if (seed == null) {
      throw new IllegalArgumentException("Illegal to invoke getUserAttributes(Map) with a null argument.");
    }
    return this.backingMap;
  }
 
  public Map getUserAttributes(String uid) {
	  System.out.println("**************************"+uid+"*******************************");
    if (uid == null) {
      throw new IllegalArgumentException("Illegal to invoke getUserAttributes(String) with a null argument.");
    }
    return this.backingMap;
  }

  public Map getBackingMap()
  {
    return this.backingMap;
  }

  public void setBackingMap(Map backingMap)
  {
    this.backingMap = backingMap;
  }
}