package com.ktdsuniversity.edu.goodgag.utils.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public abstract class AbstractDaoSupport<T> {

	private final String URL = "jdbc:oracle:thin:@localhost:1521:XE";
	private final String userName = "BBS";
	private final String password = "BBS1234";
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private void loadJdbcDriver() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	private void createConnection() throws SQLException {
		conn = DriverManager.getConnection(URL, userName, password);
	}
	
	private void closeAll() {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {}
		}
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {}
		}
	}
	
	public List<T> select(String query, ParamMapper<T> pm, ResultMapper<T> rm) {
		loadJdbcDriver();
		try {
			createConnection();
			pstmt = conn.prepareStatement(query);
			if (pm != null) {
				pm.map(pstmt);
			}
			rs = pstmt.executeQuery();
			List<T> result = new ArrayList<>();
			while (rs.next()) {
				result.add(rm.map(rs));
			}
			return result;
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			closeAll();
		}
		
		return new ArrayList<>();
	}
	
	public T selectOne(String query, ParamMapper<T> pm, ResultMapper<T> rm) {
		loadJdbcDriver();
		try {
			createConnection();
			pstmt = conn.prepareStatement(query);
			if (pm != null) {
				pm.map(pstmt);
			}
			rs = pstmt.executeQuery();
			T t = null;
			if (rs.next()) {
				t = rm.map(rs);
			}
			return t;
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			closeAll();
		}
		
		return null;
	}
	
	public int update(String query, ParamMapper<T> pm) {
		loadJdbcDriver();
		try {
			createConnection();
			pstmt = conn.prepareStatement(query);
			if (pm != null) {
				pm.map(pstmt);
			}
			return pstmt.executeUpdate();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			closeAll();
		}
		
		return 0;
	}
	
	public int insert(String query, ParamMapper<T> pm) {
		return update(query, pm);
	}
	
	public int delete(String query, ParamMapper<T> pm) {
		return update(query, pm);
	}
	
	public static interface ParamMapper<T> {
		public T map(PreparedStatement pstmt);
	}
	
	public static interface ResultMapper<T> {
		public T map(ResultSet rs);
	}
}
