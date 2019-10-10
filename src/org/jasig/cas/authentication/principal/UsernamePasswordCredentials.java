package org.jasig.cas.authentication.principal;

public class UsernamePasswordCredentials
  implements Credentials
{
  private static final long serialVersionUID = -8343864967200862794L;
  private String username;
  private String password;
  private String userRole; 
  public String getUserRole() {
	return userRole;
}

public void setUserRole(String userRole) {
	this.userRole = userRole;
}

public final String getPassword()
  {
    return this.password;
  }

  public final void setPassword(String password)
  {
    this.password = password;
  }

  public final String getUsername()
  {
    return this.username;
  }

  public final void setUsername(String userName)
  {
    this.username = userName;
  }

  public String toString() {
    return this.username;
  }

  public boolean equals(Object obj) {
    if ((obj == null) || (!obj.getClass().equals(getClass()))) {
      return false;
    }

    UsernamePasswordCredentials c = (UsernamePasswordCredentials)obj;

    return (this.username.equals(c.getUsername())) && (this.password.equals(c.getPassword()));
  }

  public int hashCode()
  {
    return this.username.hashCode() ^ this.password.hashCode();
  }
}