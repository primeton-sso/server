package com.primeton.sso.authentication;

import javax.sql.DataSource;

public class UserCacheConfig {

	private DataSource datasource = null;

	private String sql = null;

	private int interval;



	public int getInterval() {
		return interval;
	}

	public void setInterval(int interval) {
		this.interval = interval;
	}

	public String getSql() {
		return sql;
	}

	public void setSql(String sql) {
		this.sql = sql;
	}

	public DataSource getDatasource() {
		return datasource;
	}

	public void setDatasource(DataSource datasource) {
		this.datasource = datasource;
	}



}
