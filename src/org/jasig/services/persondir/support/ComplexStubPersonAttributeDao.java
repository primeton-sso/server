package org.jasig.services.persondir.support;

import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

public class ComplexStubPersonAttributeDao extends AbstractDefaultAttributePersonAttributeDao
{
  private Map backingMap = Collections.EMPTY_MAP;

  private Set possibleUserAttributeNames = Collections.EMPTY_SET;

  public ComplexStubPersonAttributeDao()
  {
  }

  public ComplexStubPersonAttributeDao(Map backingMap)
  {
    setBackingMap(backingMap);
  }

  public Map getBackingMap()
  {
    return this.backingMap;
  }

  public void setBackingMap(Map backingMap)
  {
    if (backingMap == null) {
      this.backingMap = Collections.EMPTY_MAP;
      this.possibleUserAttributeNames = Collections.EMPTY_SET;
    }
    else {
      this.backingMap = Collections.unmodifiableMap(new HashMap(backingMap));
      initializePossibleAttributeNames();
    }
  }

  public Set getPossibleUserAttributeNames()
  {
    return this.possibleUserAttributeNames;
  }

  public Map getUserAttributes(Map seed)
  {
    if (seed == null) {
      throw new IllegalArgumentException("Illegal to invoke getUserAttributes(Map) with a null argument.");
    }

    String defaultAttrName = getDefaultAttributeName();
    String seedValue = (String)seed.get(defaultAttrName);
    return (Map)this.backingMap.get(seedValue);
  }

  private void initializePossibleAttributeNames()
  {
    Set possibleAttribNames = new HashSet();
    
    for (Iterator iter = this.backingMap.values().iterator(); iter.hasNext(); ) {
      Map attributeMapForSomeUser = (Map)iter.next();
      System.out.println("attributeMapForSomeUser.keySet():"+attributeMapForSomeUser.keySet()+"");
      possibleAttribNames.addAll(attributeMapForSomeUser.keySet());
    }

    this.possibleUserAttributeNames = Collections.unmodifiableSet(possibleAttribNames);
  }
}