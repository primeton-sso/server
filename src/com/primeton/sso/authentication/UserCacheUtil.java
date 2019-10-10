package com.primeton.sso.authentication;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Timer;

public class UserCacheUtil {

	private UserCacheConfig userCacheConfig = null;
	
	private IUserCache userCache=null;

	public void loadUserInfo() {

		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;

		try {
			conn = userCacheConfig.getDatasource().getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(userCacheConfig.getSql());
			while (rs.next()) {
				userCache.setUser(rs.getString(1), rs.getString(2));
			}
			stmt.close();
		} catch (Throwable ex) {
			System.err.println("[sso-server][loadUserInfo][sql:"
					+ userCacheConfig.getSql() + "]" + ex.getMessage());
			ex.printStackTrace();

		} finally {
			try {
				if(stmt!=null)
				stmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if(conn!=null)
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
	}

	public void updateUserInfo() {
		//System.out.println("Password update!");
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			//System.out.println("doUpdate:" + System.currentTimeMillis() );
			conn = userCacheConfig.getDatasource().getConnection();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			//stmt.execute("lock table sso_user_update in share mode");
			
			rs = stmt
					.executeQuery("select USERNAME,PASSWORD,OP,TIME from SSO_USER_UPDATE order by TIME DESC");

			while (rs.next()) {
				//System.out.println("update " + rs.getString(1));
				String op = rs.getString(3);
				String time = rs.getString(4);
				if (op.equals("update")) {
					// System.out.println("update " + rs.getString(1));
					userCache.setUser(rs.getString(1), rs.getString(2));
				} else {
					// System.out.println("remove " + rs.getString(1));
					userCache.removeUser(rs.getString(1));
				}
				if (time!=null){
					stmt.execute("delete from SSO_USER_UPDATE where USERNAME='"+rs.getString(1)+"' and TIME<='"+time+"'");
					
				}
			}
			
			conn.commit();
		} catch (Throwable e) {
			System.err.println("[sso-server][updateUserInfo]" + e.getMessage());
			e.printStackTrace();
		} finally {
			try {
				if (stmt!=null)
				stmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if (conn != null)
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
	}

	public void startUpdateTask() {
		Timer timer = new Timer(false);
		timer.schedule(new UserUpdateTask(this), 1000, userCacheConfig
				.getInterval());

	}

	public UserCacheConfig getUserCacheConfig() {
		return userCacheConfig;
	}

	public void setUserCacheConfig(UserCacheConfig userCacheConfig) {
		this.userCacheConfig = userCacheConfig;
	}

	public IUserCache getUserCache() {
		return userCache;
	}

	public void setUserCache(IUserCache userCache) {
		this.userCache = userCache;
	}

}
