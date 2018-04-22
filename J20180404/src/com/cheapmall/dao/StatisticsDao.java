package com.cheapmall.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class StatisticsDao {
	/*
	 * Version 1.0
	 * 최초작성자 : 허진무
	 * 내용 : 통계 관련 DAO
	 */
	
	/*
	작성자 : 최우일
	최초작성일 : 2018-04-20
	내용 :
		1. reviewPerGoods()
		2. usersPerGrade()
		3. saleReturnPeoplePerPriceRange()
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
	
	private void DisConnection(Connection conn, PreparedStatement pstmt, ResultSet rs) throws SQLException{
		if(rs != null) { rs.close(); }
		if(pstmt != null) { pstmt.close(); }
		if(conn != null) { conn.close(); }
	}
	/*작성자	: 최우일
	수정일	: 2018-04-20
	내용		: 품목당 리뷰 갯수, 노출여부 고려 안함 */
	public ArrayList<HashMap> reviewPerGoods() throws SQLException {
		ArrayList<HashMap> list = new ArrayList<HashMap>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select g.cd, g.nm, nvl(r.cnt,0) cnt from "
		+ "(select cd, nm from goods where sysdate between start_dt and end_dt group by cd, nm) g left join "
		+ "(select goods_cd, count(*) cnt from review group by goods_cd) r on g.cd = r.goods_cd "
		+ "order by cd";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				HashMap map = new HashMap();
				map.put("cd", rs.getString(1));
				map.put("nm", rs.getString(2));
				map.put("cnt", rs.getInt(3));
				list.add(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DisConnection(conn, pstmt, rs);
		}
		return list;
	}
	
	/*작성자	: 최우일
	수정일	: 2018-04-20
	내용		: 등급별 사용자 수, 미인증/탈퇴회원 제외 */
	public ArrayList<HashMap> usersPerGrade() throws SQLException {
		ArrayList<HashMap> list = new ArrayList<HashMap>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select nvl(c.cd, 'G') grade, nvl(c.meaning,'계') meaning, sum(nvl(cnt, 0)) cnt from "
				+ "(select grade, count(*) cnt from users where grade <> 'GG' and grade is not null group by grade) u right join "
				+ "(select cd, meaning from code where category = 'G' and used = 'Y' and cd <> 'GG') c on u.grade = c.cd "
				+ "group by rollup(c.cd, c.meaning) "
				+ "having (c.meaning is not null or c.cd is null) "
				+ "order by grade ";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				HashMap map = new HashMap();
				map.put("grade", rs.getString(1));
				map.put("meaning", rs.getString(2));
				map.put("cnt", rs.getInt(3));
				list.add(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DisConnection(conn, pstmt, rs);
		}
		return list;
	}
	
	/*작성자	: 최우일
	수정일	: 2018-04-20
	내용		: 상품 가격대별 판매액, 반품액, 회원수(주문취소제외) */
	public ArrayList<HashMap> saleReturnPeoplePerPriceRange() throws SQLException {
		ArrayList<HashMap> list = new ArrayList<HashMap>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select g.g, nvl(sum(osal.ssum), 0) ssum, nvl(sum(ortn.rsum), 0) rsum, nvl(sum(ocnt.cnt), 0) cnt from "
			+ "(select sq, start_dt, end_dt, "
				+ "case when price < 1 then 'ERROR' "
				+ "when price between 1 and 4999 then '1. 5천원 미만' "
				+ "when price between 5000 and 9999 then '2. 5천원 이상 1만원 미만' "
				+ "when price between 10000 and 19999 then '3. 1만원 이상 2만원 미만' "
				+ "when price between 20000 and 29999 then '4. 2만원 이상 3만원 미만' "
				+ "when price between 30000 and 39999 then '5. 3만원 이상 4만원 미만' "
				+ "when price between 40000 and 49999 then '6. 4만원 이상 5만원 미만' "
				+ "when price between 50000 and 99999 then '7. 5만원 이상 10만원 미만' "
				+ "when price between 100000 and 149999 then '8. 10만원 이상 15만원 미만' "
				+ "when price between 150000 and 199999 then  '9. 15만원 이상 20만원 미만' "
				+ "when price between 200000 and 299999 then  '10.20만원 이상 30만원 미만' "
				+ "else  '11. 30만원 이상' end as g from goods) g left join "
			 
			+ "(select d.goods_sq, sum(d.cnt * d.origin_price) ssum from orders o, order_detail d "
				+ "where o.order_dt between sysdate-30 and sysdate and o.order_cd = 'O4' "
				+ "and o.order_sq = d.order_sq group by d.goods_sq) "
			+ "osal on g.sq = osal.goods_sq left join --판매액 " 
			
			+ "(select d.goods_sq, sum(r.cnt * d.origin_price) rsum from orders o, returns r, order_detail d " 
				+ "where o.order_dt between sysdate-30 and sysdate and o.order_sq = d.order_sq "
				+ "and d.detail_sq = r.detail_sq group by d.goods_sq) "
			+ "ortn on g.sq = ortn.goods_sq left join  --반품액 "
			
			
			+ "(select goods_sq, count(*) cnt from "
				+ "(select d.goods_sq, o.user_id from orders o, order_detail d "
					+ "where order_dt between sysdate-30 and sysdate and o.order_cd <> 'O5' "
					+ "and o.order_sq = d.order_sq group by d.goods_sq, o.user_id) "
			+ "group by goods_sq)"
			+ "ocnt on g.sq = ocnt.goods_sq group by g.g order by g.g; --주문취소 제외 인원수 ";


		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				HashMap map = new HashMap();
				map.put("g", rs.getString(1));
				map.put("ssum", rs.getInt(2));
				map.put("rsum", rs.getInt(3));
				map.put("cnt", rs.getInt(4));
				list.add(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DisConnection(conn, pstmt, rs);
		}
		return list;
	}
}
