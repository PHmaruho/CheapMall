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

import org.json.simple.JSONObject;

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
		2018-04-22
		4. dynamicQuery(String[], String[])
	*/
	
	/*
	 * 작성자 : 허진무
	 * 최초작성일 : 2018-04-22
	 * 
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
		String sql = "select nvl(g.g,'00. 계') g, nvl(sum(osal.ssum), 0) ssum, nvl(sum(ortn.rsum), 0) rsum, nvl(sum(ocnt.cnt), 0) cnt from "
			+ "(select sq, start_dt, end_dt, "
				+ "case when price < 1 then '10. ERROR' "
				+ "when price between 1 and 4999 then '01. 5천원 미만' "
				+ "when price between 5000 and 9999 then '02. 5천원 이상 1만원 미만' "
				+ "when price between 10000 and 19999 then '03. 1만원 이상 2만원 미만' "
				+ "when price between 20000 and 29999 then '04. 2만원 이상 3만원 미만' "
				+ "when price between 30000 and 39999 then '05. 3만원 이상 4만원 미만' "
				+ "when price between 40000 and 49999 then '06. 4만원 이상 5만원 미만' "
				+ "when price between 50000 and 99999 then '07. 5만원 이상 10만원 미만' "
				+ "when price between 100000 and 199999 then '08. 10만원 이상 20만원 미만' "
				+ "else  '09. 20만원 이상' end as g from goods) g left join "
			 
			+ "(select d.goods_sq, sum(d.cnt * d.origin_price) ssum from orders o, order_detail d "
				+ "where o.order_dt between sysdate-30 and sysdate and o.order_cd between 'O0' and 'O4' "
				+ "and o.order_sq = d.order_sq group by d.goods_sq) "
			+ "osal on g.sq = osal.goods_sq left join " 
			
			+ "(select d.goods_sq, sum(r.cnt * d.origin_price) rsum from orders o, returns r, order_detail d " 
				+ "where o.order_dt between sysdate-30 and sysdate and o.order_sq = d.order_sq "
				+ "and d.detail_sq = r.detail_sq group by d.goods_sq) "
			+ "ortn on g.sq = ortn.goods_sq left join "
			
			
			+ "(select goods_sq, count(*) cnt from "
				+ "(select d.goods_sq, o.user_id from orders o, order_detail d "
					+ "where order_dt between sysdate-30 and sysdate and o.order_cd <> 'O5' "
					+ "and o.order_sq = d.order_sq group by d.goods_sq, o.user_id) "
			+ "group by goods_sq)"
			+ "ocnt on g.sq = ocnt.goods_sq group by rollup(g.g) order by nvl(g.g,'00. 계') ";


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
	
	/*작성자	: 최우일
	수정일	: 2018-04-22
	내용		: 사용자의 선택에 따라 달라지는 동적 쿼리 : 주소지별, 등급별, 연령별, 성별 회원수, 매출액, 반품액 */
	public ArrayList<HashMap> dynamicQuery(String[] columnType, String[] resultType) throws SQLException {
		ArrayList<HashMap> list = new ArrayList<HashMap>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String select = "";
		String groupBy = "";
		String orderBy = "";
		String sql = null;
		for (String str : columnType) {
			if (str.equals("cAddr")) {
				select += ", u.addr";
				groupBy += ", u.addr";
				orderBy += ", u.addr";
			} else if (str.equals("cGrade")) {
				select += ", u.meaning grade";
				groupBy += ", u.grade, u.meaning";
				orderBy += ", u.grade";
			} else if (str.equals("cGender")) {
				select += ", u.gender";
				groupBy += ", u.gender";
				orderBy += ", u.gender";
			} else {
				select += ", u.year";
				groupBy += ", u.year";
				orderBy += ", u.year";
			}
		}
		
		for (String str : resultType) {
			if (str.equals("rCnt")) {
				select += ", count(*) cnt";
			} else if (str.equals("rSsum")) {
				select += ", nvl(sum(ssum), 0) ssum";
			} else {
				select += ", nvl(sum(rsum), 0) rsum";
			}
		}
		
		select = select.replaceFirst(",", "");
		groupBy = groupBy.replaceFirst(",", "");
		orderBy = orderBy.replaceFirst(",", "");
		
		sql = 
				"select "+ select +" from ( "
					+ "select nvl(addr, '미입력') addr, meaning, gender, "
					+ "case when substr(birth, 5, 4) >= to_char(sysdate, 'mmdd') "
					+ "then to_char(sysdate, 'yyyy') - substr(birth, 1, 4) - 1 || '세' "
					+ "else to_char(sysdate, 'yyyy') - substr(birth, 1, 4) || '세' end as year, user_id, grade "
					+ "from ( "
						+ "select "
						+ "case when instr(u.addr, '구 ') = 0 "
						+ "then "
							+ "case when instr(u.addr, '군 ') = 0 "
							+ "then substr(u.addr, 1, instr(u.addr, '시 ')) "
							+ "else substr(u.addr, 1, instr(u.addr, '군 ')) end "
						+ "else substr(u.addr, 1, instr(u.addr, '구 ')) end as addr, "
						+ "c1.meaning, decode(gender,'M','남','F','녀') gender, "
						+ "case when substr(birth, 1, 2) >= 20 "
						+ "then '19' || substr(birth, 1, 6) "
						+ "else '20' || substr(birth, 1, 6) end as birth,  u.id user_id, u.grade "
						+ "from users u, code c1 where grade is not null and grade <> 'GG' and u.grade = c1.cd))u left join ( "

					+ "select user_id, sum(origin_price) ssum from orders "
					+ "where order_cd between 'O0' and 'O4' group by user_id) o on u.user_id = o.user_id left join ( "

					+ "select o.user_id, sum(d.origin_price * r.cnt) rsum from orders o, order_detail d, returns r "
					+ "where o.order_sq = d.order_sq and d.detail_sq = r.detail_sq group by o.user_id) r on  u.user_id = r.user_id "
				+ " group by " + groupBy
				+ " order by " + orderBy;

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				HashMap map = new HashMap();
				int index = 1;
				
				for (String str : columnType) {
					if (str.equals("cAddr")) {
						map.put("addr", rs.getString(index));
					} else if (str.equals("cGrade")) {
						map.put("grade", rs.getString(index));
					} else if (str.equals("cGender")) {
						map.put("gender", rs.getString(index));
					} else {
						map.put("year", rs.getString(index));
					}
					index++;
				}
				
				for (String str : resultType) {
					if (str.equals("rCnt")) {
						map.put("cnt", rs.getInt(index));
					} else if (str.equals("rSsum")) {
						map.put("ssum", rs.getInt(index));
					} else {
						map.put("rsum", rs.getInt(index));
					}
					index++;
				}
				
				list.add(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DisConnection(conn, pstmt, rs);
		}
		return list;
	}
	// HJM Start!!!
	// 지난 2주간 판매량 추이(액수)
	public JSONObject statis1() throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		JSONObject object = new JSONObject();
		JSONObject object1 = new JSONObject();
		String sql = "select a.orders, nvl(sum(b.cnt),0)" + 
					" from " + 
					"    (SELECT to_char(TRUNC(SYSDATE - ROWNUM+1), 'YY-MM-DD') orders" + 
					"      FROM DUAL CONNECT BY ROWNUM <= 15) A" + 
					"    left join" + 
					"    (select to_char(order_dt, 'YY-MM-DD') orders, o.origin_price cnt" + 
					"     from orders o " + 
					"     where " + 
					"        o.ORDER_DT between sysdate-14 and sysdate " + 
					"        and o.order_cd = 'O4') B" + 
					"    on a.orders = b.orders" + 
					" group by a.orders" + 
					" order by a.orders asc";
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) {
				object.put("result", "yes");
				do {
					object1.put(rs.getString(1), rs.getInt(2));
				} while(rs.next());
				object.put("data", object1);
			} else {
				object.put("result", "no");
			}
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("statis1 Error");
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, rs);
		}
		
		return object;
	}
	
	// 전체회원수 대비 실제 활동 회원의 통계(원형)
	public JSONObject statis2() throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = "SELECT realUser.cnt, allUsers.cnt" + 
				"	 FROM" + 
				"    (SELECT COUNT(*) cnt" + 
				"     FROM users" + 
				"     WHERE grade IS NOT NULL AND grade != 'GG') allUsers," + 
				"    (SELECT COUNT(*) cnt" + 
				"     FROM" + 
				"        ( SELECT id" + 
				"          FROM users" + 
				"          WHERE GRADE IS NOT NULL AND grade != 'GG') allUser," + 
				"        ( SELECT user_id" + 
				"          FROM orders" + 
				"          WHERE order_cd = 'O4'" + 
				"            AND order_dt BETWEEN SYSDATE - 30 AND SYSDATE) activeUser" + 
				"	WHERE allUser.id = activeUser.user_id) realUser";
		JSONObject object = new JSONObject();
		JSONObject object1 = new JSONObject();
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) {
				object.put("result", "yes");
				object1.put("실제구매사용자", rs.getInt(1));
				object1.put("전체사용자", rs.getInt(2));
				object.put("data", object1);
			} else {
				object.put("result", "no");
			}
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("statis2 Error");
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, rs);
		}
		
		return object;
	}
	
	// 회원들의 총 포인트와 사용 포인트율
	public JSONObject statis3() throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = "SELECT A.allPoint usepoint, B.usedPoint+A.allPoint allpoint" + 
				"	FROM (" + 
				"        SELECT SUM(point) allPoint" + 
				"        FROM users" + 
				"        WHERE grade IS NOT NULL AND grade != 'GG') a , " + 
				"    (" + 
				"        SELECT SUM(use_point) usedPoint" + 
				"        FROM orders" + 
				"        WHERE use_point != 0" + 
				"          AND order_dt BETWEEN SYSDATE -14 AND SYSDATE) b";
		JSONObject object = new JSONObject();
		JSONObject object1 = new JSONObject();
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				object.put("result", "yes");
				object1.put("실제사용Point", rs.getInt(1));
				object1.put("전체Point", rs.getInt(2));
				object.put("data", object1);
			} else {
				object.put("result", "no");
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("statis3 Error");
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, rs);
		}
		
		return object;
	}
	
	// 가입자 수의 변화(2주간)
	public JSONObject statis4() throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = "SELECT a.dates, nvl(sum(b.cnt), 0) users" + 
				"	FROM (" + 
				"        SELECT TO_CHAR(TRUNC(SYSDATE - ROWNUM+1), 'YY-MM-DD') dates" + 
				"        FROM DUAL CONNECT BY ROWNUM <=15 ) A" + 
				"    LEFT JOIN" + 
				"    	(  " + 
				"        SELECT REG_DT dates, COUNT(ID) cnt" + 
				"        FROM USERS" + 
				"        WHERE grade = 'G0'" + 
				"          AND reg_dt BETWEEN SYSDATE - 14 AND SYSDATE" + 
				"        GROUP BY reg_dt" + 
				"        order by reg_dt) B" + 
				"    on a.dates = b.dates" + 
				"	group by a.dates" + 
				"	order by a.dates";
		JSONObject object = new JSONObject();
		JSONObject object1 = new JSONObject();
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) {
				object.put("result", "yes");
				do {
					object1.put(rs.getString(1), rs.getInt(2));
					object.put("data", object1);
				} while(rs.next());
			} else {
				object.put("result", "no");
			}
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("statis3 Error");
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, rs);
		}
		
		return object;
	}
}
