package com.ktdsuniversity.edu.goodgag.utils.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public abstract class AbstractDaoPoolSupport {

	private final String URL = "jdbc:oracle:thin:@localhost:1521:XE";
	private final String userName = "BBS";
	private final String password = "BBS1234";
	
	private List<Connection> connectionPool;
	private int poolSize;
	
	public AbstractDaoPoolSupport() {
		this(5);
	}
	
	public AbstractDaoPoolSupport(int poolSize) {
		loadJdbcDriver();
		connectionPool = new ArrayList<>();
		this.poolSize = poolSize;
	}
	
	private void loadJdbcDriver() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	
	private Connection getConnection() {
		if (connectionPool.size() == this.poolSize) {
			throw new RuntimeException("모든 Conneciton이 사용 중입니다.");
		}
		
		try {
			Connection conn = DriverManager.getConnection(URL, userName, password);
			connectionPool.add(conn);
			return conn;
		} catch (SQLException e) {
			throw new RuntimeException(e.getMessage(), e);
		}
	}
	
	private void closeAll(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		if (conn != null) {
			try {
				conn.close();
				connectionPool.remove(conn);
			} catch (SQLException e) {}
		}
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {}
		}
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {}
		}
	}
	
	public <T> List<T> select(String query, ParamMapper pm, ResultMapper<T> rm) {
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			if (pm != null) {
				pm.map(pstmt);
			}
			rs = pstmt.executeQuery();
			List<T> t = new ArrayList<>();
			while (rs.next()) {
				t.add((T) rm.map(rs));
			}
			return (List<T>) t;
		}
		catch (SQLException sqle) {
			sqle.printStackTrace();
		}
		finally {
			closeAll(connection, pstmt, rs);
		}
		
		return null;
	}
	
	public <T> T selectOne(String query, ParamMapper pm, ResultMapper<T> rm) {
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			if (pm != null) {
				pm.map(pstmt);
			}
			rs = pstmt.executeQuery();
			T t = null;
			if (rs.next()) {
				t = rm.map(rs);
			}
			return (T) t;
		}
		catch (SQLException sqle) {
			sqle.printStackTrace();
		}
		finally {
			closeAll(connection, pstmt, rs);
		}
		
		return null;
	}
	
	public int update(String query, ParamMapper pm) {
		Connection connection = null;
		PreparedStatement pstmt = null;
		
		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			if (pm != null) {
				pm.map(pstmt);
			}
			return pstmt.executeUpdate();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			closeAll(connection, pstmt, null);
		}
		
		return 0;
	}
	
	public int insert(String query, ParamMapper pm) {
		return update(query, pm);
	}
	
	public int delete(String query, ParamMapper pm) {
		return update(query, pm);
	}
	
	@FunctionalInterface
	public static interface ParamMapper {
		public void map(PreparedStatement pstmt) throws SQLException;
	}
	
	@FunctionalInterface
	public static interface ResultMapper<T> {
		public T map(ResultSet rs) throws SQLException;
	}
}
