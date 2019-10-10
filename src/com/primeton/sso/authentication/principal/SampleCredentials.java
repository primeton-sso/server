package com.primeton.sso.authentication.principal;

import org.jasig.cas.authentication.principal.Credentials;

public class SampleCredentials implements Credentials {

    /** Unique ID for serialization. */
    private static final long serialVersionUID = -8343864967200862794L;

    /** The username. */
    private String username;

    /** The password. */
    private String password;

    /** The orgid. */
    private String orgid;
    
    /**
     * @return Returns the orgid.
     */
    public final String getOrgid() {
        return this.orgid;
    }

    /**
     * @param orgid The orgid to set.
     */
    public final void setOrgid(final String orgid) {
        this.orgid = orgid;
    }

    /**
     * @return Returns the password.
     */
    public final String getPassword() {
        return this.password;
    }

    /**
     * @param password The password to set.
     */
    public final void setPassword(final String password) {
        this.password = password;
    }

    /**
     * @return Returns the userName.
     */
    public final String getUsername() {
        return this.username;
    }

    /**
     * @param userName The userName to set.
     */
    public final void setUsername(final String userName) {
        this.username = userName;
    }

    public String toString() {
        return this.username;
    }

    public boolean equals(final Object obj) {
        if (obj == null || !obj.getClass().equals(this.getClass())) {
            return false;
        }

        final SampleCredentials c = (SampleCredentials) obj;

        return this.username.equals(c.getUsername())
            && this.password.equals(c.getPassword())
            && this.orgid.equals(c.getOrgid());
    }

    public int hashCode() {
        return this.username.hashCode() ^ this.password.hashCode();
    }
}
