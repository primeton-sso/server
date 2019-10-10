package com.primeton.sso.impl;
import org.springframework.dao.support.DataAccessUtils;
import java.util.Collection;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.sql.DataSource;
import org.jasig.services.persondir.support.MultivaluedPersonAttributeUtils;
import org.jasig.services.persondir.support.jdbc.AbstractJdbcPersonAttributeDao;
import org.jasig.services.persondir.support.jdbc.AbstractPersonAttributeMappingQuery;

public class SingleRowJdbcPersonAttributeDao extends AbstractJdbcPersonAttributeDao
{
  private Map attributeMappings = Collections.EMPTY_MAP;

  private Set userAttributes = Collections.EMPTY_SET;
  private SingleRowPersonAttributeMappingQuery query;

  public SingleRowJdbcPersonAttributeDao(DataSource ds, String sql, List attrList)
  {
    if (ds == null) {
      throw new IllegalArgumentException("DataSource can not be null");
    }
    if (sql == null) {
      throw new IllegalArgumentException("The sql can not be null");
    }

    setQueryAttributes(attrList);
    List queryAttributes = getQueryAttributes();
    this.query = new SingleRowPersonAttributeMappingQuery(ds, sql, queryAttributes, this);
  }

  public Map parseAttributeMapFromResults(List queryResults)
  {
    Map uniqueResult = (Map)DataAccessUtils.uniqueResult(queryResults);

    return uniqueResult;
  }

  protected AbstractPersonAttributeMappingQuery getAttributeQuery()
  {
    return this.query;
  }

  public Set getPossibleUserAttributeNames()
  {
    return this.userAttributes;
  }

  public Map getColumnsToAttributes()
  {
    return this.attributeMappings;
  }

  public void setColumnsToAttributes(Map columnsToAttributesMap)
  {
    if (columnsToAttributesMap == null) {
      throw new IllegalArgumentException("columnsToAttributesMap may not be null");
    }

    this.attributeMappings = MultivaluedPersonAttributeUtils.parseAttributeToAttributeMapping(columnsToAttributesMap);

    if (this.attributeMappings.containsKey("")) {
      throw new IllegalArgumentException("The map from attribute names to attributes must not have any empty keys.");
    }

    Collection userAttributeCol = MultivaluedPersonAttributeUtils.flattenCollection(this.attributeMappings.values());

    this.userAttributes = Collections.unmodifiableSet(new HashSet(userAttributeCol));
  }
}