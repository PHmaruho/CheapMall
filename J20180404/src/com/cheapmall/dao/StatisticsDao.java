package com.cheapmall.dao;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class StatisticsDao {
	/*
	 * Version 1.0
	 * 최초작성자 : 허진무
	 * 내용 : 통계 관련 DAO
	 */
	
	private static StatisticsDao instance;
	private StatisticsDao() {}
	public static StatisticsDao getInstance() {
		if(instance == null) { instance = new StatisticsDao(); }
		return instance;
	}
	
	private Connection getConnection() {
		Connection conn = null;
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
		}catch(Exception e) { 
			// SYSO
			System.out.println("Connection Error");
			System.out.println(e.getMessage());	
		}
		return conn;
	}
}
