package com.primeton.sso.impl;

import org.jasig.cas.adaptors.jdbc.AbstractJdbcUsernamePasswordAuthenticationHandler;
import org.jasig.cas.authentication.handler.AuthenticationException;
import org.jasig.cas.authentication.principal.UsernamePasswordCredentials;
import org.jasig.cas.util.annotation.NotNull;
import org.springframework.dao.IncorrectResultSizeDataAccessException;
public final class QueryDatabaseAuthenticationHandlerServer extends AbstractJdbcUsernamePasswordAuthenticationHandler
{
  @NotNull
  private String sql;

  protected final boolean authenticateUsernamePasswordInternal(UsernamePasswordCredentials credentials)
    throws AuthenticationException
  {
    String username = credentials.getUsername();
    String password = credentials.getPassword();
    String encryptedPassword = getPasswordEncoder().encode(password);
    try
    {
      String dbPassword = (String)getJdbcTemplate().queryForObject(this.sql, String.class, new Object[] { username });
      return dbPassword.equals(encryptedPassword);
    } catch (IncorrectResultSizeDataAccessException e) {
    }
    return false;
  }

  public void setSql(String sql)
  {
    this.sql = sql;
  }
}