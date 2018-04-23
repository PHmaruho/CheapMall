package com.cheapmall.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.cheapmall.dto.PopupDto;

public class EtcDao {
	/*
	 * Version 1.0
	 * 최초작성자 : 허진무
	 * 내용 : 메뉴, 검색 등 관련 DAO
	 */
	
	/*
	 * 작성자 : 허진무
	 * 최초작성일 : 20180411
	 * 내용 :
	 * 	1. searchTagGet() -> 검색어를 가져옴(ajax)
	 *	2. searchKeyword() / getKeyword() -> 검색어를 검색
	 *	3. registKeyword() -> 검색어 등록
	 */
	
/*	
	 * 작성자 : 최우일
	 * 최초작성일 : 2018-04-12
	 * 내용 :
	 * 	1. checkReport(String)
	 *  2. insertReport(String, int)
	 */
	
	private static EtcDao instance;
	private EtcDao() {}
	public static EtcDao getInstance() {
		if(instance == null) { instance = new EtcDao(); }
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
	private void DisConnection(Connection conn, PreparedStatement ps, ResultSet rs) throws SQLException{
		if(rs != null) { rs.close(); }
		if(ps != null) { ps.close(); }
		if(conn != null) { conn.close(); }
	}
	
	// HJM - KeyWord Start!
	public JSONObject searchTagGet(String keyword) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = "SELECT tag" + 
					" FROM search" + 
					" WHERE full_tag LIKE FN_GET_DIV_KO_CHAR(?) || '%' " + 
					" order by tag asc";
		JSONArray array = new JSONArray();
		JSONObject json = new JSONObject();
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, keyword);
			rs = ps.executeQuery();
			json.put("result", "no");
			if(rs.next()) {
				do {
					array.add(rs.getString(1));
				} while(rs.next());
				json.put("keywords", array);
				json.replace("result", "no", "yes");
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("searchTagGet Error");
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, rs);
		}
		
		return json;
	}
	public int searchKeyword(String keyword) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = "SELECT * FROM search where tag LIKE ?";
		int result = 0;
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, keyword);
			rs = ps.executeQuery();
			if(rs.next()) {
				result = 1;
			}
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("searchKeyword Error");
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, rs);
		}
		
		return result;
	}
	public int registKeyword(String keyword, String transKeyword) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		
		String sql = "INSERT INTO search "
				+ "	VALUES(?,?,0)";
		int result = 0;
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, keyword);
			ps.setString(2, transKeyword);
			result = ps.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("registKeyword Error");
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, null);
		}
		
		return result;
	}
	public JSONObject getKeyword(String keyword) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = "SELECT * FROM search WHERE tag LIKE ?";
		JSONObject jsonObject = new JSONObject();
		JSONArray jsonList = new JSONArray();
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, keyword);
			rs = ps.executeQuery();
			if(rs.next()) {
				jsonObject.put("tag", rs.getString(1));
				jsonObject.put("tag2", rs.getString(2));
			}
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("getKeyword Error");
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, rs);
		}
		
		return jsonObject;
	}
	public JSONObject deleteKeyword(String[] deleteList) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		
		String sql = "DELETE FROM search WHERE tag = ?";
		JSONObject jsonObject = new JSONObject();
		int result = 0;
		try {
			conn = getConnection();
			for(String str : deleteList) {
				ps = conn.prepareStatement(sql);
				ps.setString(1, str);
				result = ps.executeUpdate();
				ps.close();
			}
			if(result == 1) {
				jsonObject.put("result", "yes");
			} else {
				jsonObject.put("result", "no");
			}
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("deleteKeyword Error");
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, null);
		}
		
		return jsonObject;
	}
	// 검색어 수정
	public JSONObject modifyKeyword(String origin, String keyword, String trans) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		
		JSONObject json = new JSONObject();
		int result = 0;
		String sql = "UPDATE search "
				+ " SET tag = ?, full_tag = ?"
				+ " WHERE tag = ?";
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, keyword);
			ps.setString(2, trans);
			ps.setString(3, origin);
			result = ps.executeUpdate();
			if(result == 1) {
				json.put("value", "yes");
			} else {
				json.put("value", "no");
			}
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("modifyKeyword Error");
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, null);
		}
		
		return json;
	}
	
	public int keywordCntUp(String keyword) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		
		int result = 0;
		String sql = "UPDATE search "
				+ " SET cnt = cnt + 1 "
				+ " WHERE tag LIKE ?";
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, keyword);
			result = ps.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			DisConnection(conn, ps, null);
		}
		
		return result;
	}
	
	// CWI Part Start
	
	/*작성자	: 최우일
	수정일	: 2018-04-12
	내용		: 해당 일자 기준 이미 제재를 당한 사용자인지 검사 후 제재 종료일 반환 */
	public Date checkReport(String user_id) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Date check = null;
		String sql = "select dt + days from report where user_id=? and sysdate between dt and dt + days";
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, user_id);
			rs = ps.executeQuery();
			if(rs.next()) {
				check = rs.getDate(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, rs);
		}
		
		return check;
	}
	
	/*작성자	: 최우일
	수정일	: 2018-04-12
	내용		: checkReport에서 반환되지 않았다면 새롭게 생성 */
	public int insertReport(String user_id, int days) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int result = 0;
		String sql = "insert into report values(?,sysdate,?)";
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, user_id);
			ps.setInt(2, days);
			result = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, rs);
		}
		
		return result;
	}
	
	/*
	 * 작성자 : 정수연
	 * 최초작성일 : 2018-04-17
	 * 내용 :
	 * 	1. getPopupMain() 메인팝업에 관한 정보를 가져옵니다.
	 *	2. getPopupSub() 서브 팝업에 관한 정보를 가져옵니다.
	 *	3. getPopupInfo(sq) 팝업 수정을 위한 DTO 정보를 가져옵니다.
	 *  4. modifyPopup(dto) 팝업을 수정합니다
	 *  5. insertPopup(dto, start_dt,end_dt): 팝업을 새로 등록합니다.
	 *  6. getPopupUrl(): 팝업 주소를 가져옵니다.
	 */
	// JSY part Start!
	// 메인팝업에 관한 정보를 가져옵니다.
	public List<PopupDto> getPopupMain() throws SQLException {
		
		List<PopupDto> list=new ArrayList<PopupDto>();
		
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		String sql="select * from popup where sq not like '%S%' order by sq asc";
		try {
			conn=getConnection();
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			
			while(rs.next()){
				PopupDto dto=new PopupDto();
				dto.setSq(rs.getString("sq"));
				dto.setUrl(rs.getString("url"));
				dto.setNm(rs.getString("nm"));
				dto.setStart_dt(rs.getDate("start_dt"));
				dto.setEnd_dt(rs.getDate("end_dt"));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DisConnection(conn, ps, rs);
		}
		return list;
	}
	
	// 서브 팝업에 관한 정보를 가져옵니다.
	public List<PopupDto> getPopupSub() throws SQLException {
		
		List<PopupDto> list=new ArrayList<PopupDto>();
		
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		String sql="select * from popup where sq like '%S%' order by sq asc";
		try {
			conn=getConnection();
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			
			while(rs.next()){
				PopupDto dto=new PopupDto();
				dto.setSq(rs.getString("sq"));
				dto.setUrl(rs.getString("url"));
				dto.setNm(rs.getString("nm"));
				dto.setStart_dt(rs.getDate("start_dt"));
				dto.setEnd_dt(rs.getDate("end_dt"));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DisConnection(conn, ps, rs);
		}
		return list;
	}

	// 팝업 수정을 위한 DTO 정보를 가져옵니다.
	public PopupDto getPopupInfo(String sq) throws SQLException {
		
		PopupDto dto=new PopupDto();
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		String sql="select * from popup where sq=?";
		try {
			conn=getConnection();
			ps=conn.prepareStatement(sql);
			ps.setString(1, sq);
			rs=ps.executeQuery();
			
			if(rs.next()){
				dto.setSq(rs.getString("sq"));
				dto.setUrl(rs.getString("url"));
				dto.setNm(rs.getString("nm"));
				dto.setStart_dt(rs.getDate("start_dt"));
				dto.setEnd_dt(rs.getDate("end_dt"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DisConnection(conn, ps, rs);
		}
		
		return dto;
	}
	
	// 팝업을 수정합니다
	public int modifyPopup(PopupDto dto) throws SQLException {
		
		int result=0;
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		String sql="update popup set nm=?, start_dt=?, end_dt=?,url=? where sq=?";
		try {
			conn=getConnection();
			ps=conn.prepareStatement(sql);
			ps.setString(1, dto.getNm());
			ps.setDate(2, new java.sql.Date(dto.getStart_dt().getTime()));
			ps.setDate(3, new java.sql.Date(dto.getEnd_dt().getTime()));
			ps.setString(4,dto.getUrl());
			ps.setString(5, dto.getSq());
			result=ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DisConnection(conn, ps, rs);
		}
		return result;
	}
	
	
	// 팝업을 등록합니다.
	public int insertPopup(PopupDto dto, String start_dt, String end_dt) throws SQLException {
		
		int result=0;
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		String sql="{ call insertPopup(?,?,?,?,?)}";
	
		try {
			conn=getConnection();
			ps=conn.prepareStatement(sql);
			ps.setString(1, dto.getSq());
			ps.setString(2,dto.getUrl());
			ps.setString(3, dto.getNm());
			ps.setString(4, start_dt);
			ps.setString(5, end_dt);
			result=ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DisConnection(conn, ps, rs);
		}
		return result;
	}
	// 팝업 주소를 가져옵니다.
	public List<String> getPopupUrl() throws SQLException {
		
		List<String> urlL=new ArrayList<>();
		
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		String sql="select url from popup where sysdate<end_dt and start_dt<sysdate";
	
		try {
			conn=getConnection();
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			
			while(rs.next()){
				String dbUrl=rs.getString("url");
				urlL.add(dbUrl);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			DisConnection(conn, ps, rs);
		}
		return urlL;
	}
}
