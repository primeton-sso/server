package org.jasig.services.persondir.support;

import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.apache.commons.logging.Log;
import org.jasig.services.persondir.IPersonAttributeDao;
import org.jasig.services.persondir.support.merger.IAttributeMerger;
import org.jasig.services.persondir.support.merger.MultivaluedAttributeMerger;

public abstract class AbstractAggregatingDefaultQueryPersonAttributeDao extends AbstractDefaultAttributePersonAttributeDao
{
  protected List personAttributeDaos;
  protected IAttributeMerger attrMerger = new MultivaluedAttributeMerger();

  protected boolean recoverExceptions = true;

  public final Map getUserAttributes(Map seed)
  {
    if (seed == null) {
      throw new IllegalArgumentException("The query seed Map cannot be null.");
    }
    if (this.personAttributeDaos == null) {
      throw new IllegalStateException("No IPersonAttributeDaos have been specified.");
    }

    Map resultAttributes = null;

    boolean isFirstQuery = true;

    for (Iterator iter = this.personAttributeDaos.iterator(); iter.hasNext(); ) {
      IPersonAttributeDao currentlyConsidering = (IPersonAttributeDao)iter.next();

      Map currentAttributes = new HashMap();
      try {
        if (this.logger.isDebugEnabled()) {
          this.logger.debug("Getting attributes for seed='" + seed + "', isFirstQuery=" + isFirstQuery + ", currentlyConsidering='" + currentlyConsidering + "', resultAttributes='" + resultAttributes + "'");
        }
        currentAttributes = getAttributesFromDao(seed, isFirstQuery, currentlyConsidering, resultAttributes);
        isFirstQuery = false;
      }
      catch (RuntimeException rte) {
        if (this.recoverExceptions) {
          this.logger.warn("Recovering From Exception thrown by '" + currentlyConsidering + "'", rte);
        }
        else {
          this.logger.error("Failing From Exception thrown by '" + currentlyConsidering + "'", rte);
          throw rte;
        }
      }

      if (resultAttributes == null)
      {
        resultAttributes = currentAttributes;
      }
      else if (currentAttributes != null)
      {
        resultAttributes = this.attrMerger.mergeAttributes(resultAttributes, currentAttributes);
      }
    }

    return resultAttributes;
  }

  protected abstract Map getAttributesFromDao(Map paramMap1, boolean paramBoolean, IPersonAttributeDao paramIPersonAttributeDao, Map paramMap2);

  public Set getPossibleUserAttributeNames()
  {
    Set attrNames = new HashSet();

    for (Iterator iter = this.personAttributeDaos.iterator(); iter.hasNext(); ) {
      IPersonAttributeDao currentDao = (IPersonAttributeDao)iter.next();

      Set currentDaoAttrNames = null;
      try {
        if (this.logger.isDebugEnabled()) {
          this.logger.debug("Getting possible attribute names from '" + currentDao + "'");
        }
        currentDaoAttrNames = currentDao.getPossibleUserAttributeNames();
      }
      catch (RuntimeException rte) {
        if (this.recoverExceptions) {
          this.logger.warn("Recovering From Exception thrown by '" + currentDao + "'", rte);
        }
        else {
          this.logger.error("Failing From Exception thrown by '" + currentDao + "'", rte);
          throw rte;
        }
      }

      if (currentDaoAttrNames != null) {
        attrNames.addAll(currentDaoAttrNames);
      }
    }
    return Collections.unmodifiableSet(attrNames);
  }

  public IAttributeMerger getMerger()
  {
    return this.attrMerger;
  }

  public void setMerger(IAttributeMerger merger)
  {
    if (merger == null) {
      throw new IllegalArgumentException("The merger cannot be null");
    }
    this.attrMerger = merger;
  }

  public List getPersonAttributeDaos()
  {
    return this.personAttributeDaos;
  }

  public void setPersonAttributeDaos(List daos)
  {
    if (daos == null) {
      throw new IllegalArgumentException("The dao list cannot be null");
    }
    this.personAttributeDaos = Collections.unmodifiableList(daos);
  }

  public boolean isRecoverExceptions()
  {
    return this.recoverExceptions;
  }

  public void setRecoverExceptions(boolean recover)
  {
    this.recoverExceptions = recover;
  }
}