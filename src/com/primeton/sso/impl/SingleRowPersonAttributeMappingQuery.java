package com.primeton.sso.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.sql.DataSource;
import org.apache.commons.logging.Log;
import org.jasig.services.persondir.support.MultivaluedPersonAttributeUtils;
import org.jasig.services.persondir.support.jdbc.AbstractPersonAttributeMappingQuery;

class SingleRowPersonAttributeMappingQuery extends AbstractPersonAttributeMappingQuery
{
  private final SingleRowJdbcPersonAttributeDao parentSingleRowPersonAttributeDao;

  public SingleRowPersonAttributeMappingQuery(DataSource ds, String sql, List queryAttributes, SingleRowJdbcPersonAttributeDao parentSingleRowPersonAttributeDao)
  {
    super(ds, sql, queryAttributes);

    if (parentSingleRowPersonAttributeDao == null) {
      throw new IllegalArgumentException("parentSingleRowPersonAttributeDao may not be null");
    }

    this.parentSingleRowPersonAttributeDao = parentSingleRowPersonAttributeDao;
  }

  protected Object mapRow(ResultSet rs, int rowNum)
    throws SQLException
  {
    Map rowResults = new HashMap();

    Map attributeMappings = this.parentSingleRowPersonAttributeDao.getColumnsToAttributes();
    for (Iterator columnNameItr = attributeMappings.keySet().iterator(); columnNameItr.hasNext(); ) {
      String columnName = (String)columnNameItr.next();

      addMappedAttributes(rs, columnName, rowResults);
    }

    return rowResults;
  }

  private void addMappedAttributes(ResultSet rs, String columnName, Map rowResults)
    throws SQLException
  {
    if ((columnName == null) || (columnName.length() <= 0)) {
      throw new IllegalArgumentException("columnName cannot be null and must have length >= 0");
    }
    String attributeValue = null;
    try
    {
      attributeValue = rs.getString(columnName);
    }
    catch (SQLException sqle) {
      this.logger.error("Was unable to read attribute for column [" + columnName + "]");
      throw sqle;
    }

    Map attributeMappings = this.parentSingleRowPersonAttributeDao.getColumnsToAttributes();
    Set attributeNames = (Set)attributeMappings.get(columnName);

    if (attributeNames == null) {
      if (this.logger.isDebugEnabled()) {
        this.logger.debug("No mapped attribute name for column='" + columnName + "', defaulting to the column name.");
      }

      attributeNames = Collections.singleton(columnName);
    }

    for (Iterator attrNameItr = attributeNames.iterator(); attrNameItr.hasNext(); ) {
      String attributeName = (String)attrNameItr.next();

      if (this.logger.isDebugEnabled()) {
        this.logger.debug("Adding mapped attribute '" + attributeName + "' for source column '" + columnName + "'");
      }

      MultivaluedPersonAttributeUtils.addResult(rowResults, attributeName, attributeValue);
    }
  }
}