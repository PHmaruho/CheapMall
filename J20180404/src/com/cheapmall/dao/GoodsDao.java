package com.cheapmall.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.cheapmall.dto.CartDto;
import com.cheapmall.dto.CodeDto;
import com.cheapmall.dto.GoodsDto;

public class GoodsDao {
	/*
	 * Version 1.0
	 * 최초작성자 : 허진무
	 * 내용 : 상품 관련 DAO
	 */
	
	/*
	작성자 : 최우일
	최초작성일 : 2018-04-11
	내용 :
		1. listMain(String, String, String)
		2. listGoodsColor(String)
		3. listGoodsSize(String, String)
		4. selectGoodsDetail(String)
		5. selectGoodsPath(String, String)
		6. selectSqBeforeCart(String, String, String)
		
	*/
	
	/*
	 * 작성자 : 허진무
	 * 최초작성일 : 20180411
	 * 내용 :
	 * 	1. goodsGetPicPath() -> 상품리스트Map
	 *	2. getGoods() -> 상품 단일 품목을 조회
	 */
	
	/*
	 * 작성자: 정수연
	 * 최초 작성일: 180411
	 * 담당 메소드: 
	 * 		1) updateDisplay(): 종료일이 지나면 노출[ display ]를 N으로 바꾸는 클래스입니다.
	 * 		2) selectGoods(sq): 상품sq에 해당하는 정보를 가져오는 클래스입니다.
	 * 		3) updateGoods(Goods dto): 상품을 수정한 후 그 정보를 저장하는 클래스입니다.
	 * 		4) updateGoods(id, display): 상품의 노출도 만을 변경시키는 클래스입니다.
	 * 		5) selectGoods(category,search, startRow, endRow): 상품을 검색 조건과 검색값에 대한 결과 상품항목들을 가져오는 클래스입니다.
	 * 		6) selectGoods(startRow,endRow): 전체 상품에 대한 정보를 가져오는 클래스입니다.
	 */	
	
	/*
	 * 작성자 : 김기한 
	 * 최초작성일 : 2018/04/11
	 * 내용 
	 * 1. getCodeTotalCnt() : 코드의 총 갯수를 가져옴
	 * 2. codeList(startRow,endRow) : 코드 화면 리스트에 뿌릴 리스트만 가져옴
	 * 3. insertCode(CodeDto codeDto) : 코드를 등록함
	 * 4. selectCode(String code) : 수정할 코드의 정보를 가져옴
	 * 5. changeCode(CodeDto codeDto) : 코드를 수정함
	 * 6. checkCode(String code) : 이미 존재하는 코드인지 확인함
	 * 7. insertAdminGoods(GoodsDto gt) : 상품을 등록함
	 * 8. createGoodsCode(gender,top_category,middle_category) : 상품코드를 생성함
	 * 9. goodsAdminGetSq() : 상품 시퀀스를 가져옴(사진명이 시퀀스와 같기 때문에 사진명을 가져오는기능) 
 	 * 수정일 : 2018/04/16
	 * 내용 : admin 부분에 판매상품 리스트만 뿌리는 함수 추가
	 * 1. List<GoodsDto> selectDisplayGoods(startRow,endRow) : 판매상품 리스트를 구하는 함수
	 */
	
	private static GoodsDao instance;
	private GoodsDao() {}
	public static GoodsDao getInstance() {
		if(instance == null) { instance = new GoodsDao(); }
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
	
	// CWI Part Start
	/*작성자	: 최우일
	수정일	: 2018-04-02
	내용		: 선택한 메뉴를 받아와서 상품 리스트를 검색*/
	public ArrayList<GoodsDto> listMain(String gender, String top_category, String middle_category) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String str1 = "select g2.cd, g1.nm, g1.price, g2.path, g1.stock, g1.top_category, g1.middle_category from "
				+ " (select cd, nm, price, sum(stock) stock , top_category, middle_category "
						+ " from goods where (sysdate between start_dt and end_dt)"
					+ " and display='Y' and (gender=? or gender='U') ";
		String str2 = "";
		if (!top_category.equals("ALL")) {
			str2 = "and top_category=? and middle_category=? ";
		} 
		String str3 = " group by cd, nm, price, top_category, middle_category) g1, "
				+ " (select cd, min(path) path from goods where (sysdate between start_dt and end_dt)"
				+ " and display='Y' group by cd) g2 where g1.cd=g2.cd";
		String sql = str1 + str2 + str3;
		ArrayList<GoodsDto> list = new ArrayList<GoodsDto>();
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, gender);
			if (!top_category.equals("ALL")) {
				pstmt.setString(2, top_category);
				pstmt.setString(3, middle_category);
			} 
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				GoodsDto goodsDto = new GoodsDto();
				goodsDto.setCd(rs.getString(1));
				goodsDto.setNm(rs.getString(2));
				goodsDto.setPrice(rs.getInt(3));
				goodsDto.setPath(rs.getString(4));
				goodsDto.setStock(rs.getInt(5));
				goodsDto.setTop_category(rs.getString(6));
				goodsDto.setMiddle_category(rs.getString(7));
				list.add(goodsDto);
			}
		} catch (Exception e) {
			e.getMessage();
		} finally {
			DisConnection(conn, pstmt, rs);
		}
		return list;
	}
	
	/*작성자	: 최우일
	수정일	: 2018-04-02
	내용		: 상품 상세 페이지에서 해당 상품의 사용하는 색상과 그 재고량을 검색*/
	public ArrayList<GoodsDto> listGoodsColor(String cd) throws SQLException {
		ArrayList<GoodsDto> list = new ArrayList<GoodsDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select color, sum(stock) from goods where (sysdate between start_dt and end_dt) and cd=?"
				+ "	and display='Y' group by color";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cd);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				GoodsDto goodsDto = new GoodsDto();
				goodsDto.setColor(rs.getString(1));
				goodsDto.setStock(rs.getInt(2));
				list.add(goodsDto);
			}
		} catch (Exception e) {
			e.getMessage();
		} finally {
			DisConnection(conn, pstmt, rs);
		}
		return list;
	}
	
	/*작성자	: 최우일
	수정일	: 2018-04-02
	내용		: 상세 페이지에서 색상 선택시 해당하는 사이즈와 재고 검색*/
	public ArrayList<GoodsDto> listGoodsSize(String cd, String color) throws SQLException {
		ArrayList<GoodsDto> list = new ArrayList<GoodsDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select goods.goods_size, goods.stock, code.meaning from goods goods, code code where (sysdate between start_dt and end_dt)"
				+ " and goods.cd=? and color=? and display='Y' and code.cd = goods.goods_size and code.USED='Y'";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cd);
			pstmt.setString(2, color);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				GoodsDto goodsDto = new GoodsDto();
				goodsDto.setGoods_size(rs.getString(1));
				goodsDto.setStock(rs.getInt(2));
				goodsDto.setNm(rs.getString(3));	// 본래 상품명칭이 들어가야 하나 사이즈의 의미를 넣음
				list.add(goodsDto);
			}
		} catch (Exception e) {
			e.getMessage();
		} finally {
			DisConnection(conn, pstmt, rs);
		}
		return list;
	}
	
	/*작성자	: 최우일
	수정일	: 2018-04-03
	내용		: 상세 페이지에서 해당 상품의 기본 정보인 상품명, 가격등 검색*/
	public GoodsDto selectGoodsDetail(String cd) throws SQLException {
		GoodsDto goodsDto = new GoodsDto();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select nm, price from goods where (sysdate between start_dt and end_dt)"
				+ " and cd=? and display='Y'";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cd);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				goodsDto.setNm(rs.getString(1));
				goodsDto.setPrice(rs.getInt(2));
			}
		} catch (Exception e) {
			e.getMessage();
		} finally {
			DisConnection(conn, pstmt, rs);
		}
		return goodsDto;
	}
	
	/*작성자	: 최우일
	수정일	: 2018-04-03
	내용		: 상세 페이지에서 해당 상품의 코드와 색상을 조건으로 사진경로 검색*/
	public GoodsDto selectGoodsPath(String cd, String color) throws SQLException {
		GoodsDto goodsDto = new GoodsDto();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select gender, top_category, middle_category, path from goods where (sysdate between start_dt and end_dt)"
				+ " and cd=? and color=? and display='Y'";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cd);
			pstmt.setString(2, color);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				goodsDto.setGender(rs.getString(1));
				goodsDto.setTop_category(rs.getString(2));
				goodsDto.setMiddle_category(rs.getString(3));
				goodsDto.setPath(rs.getString(4));
			}
		} catch (Exception e) {
			e.getMessage();
		} finally {
			DisConnection(conn, pstmt, rs);
		}
		return goodsDto;
	}
	
	/*작성자	: 최우일
	수정일	: 2018-04-04
	내용		: 제품상세에서 장바구니로 데이터를 보내기 전 코드, 색상, 사이즈를 조건으로 상품 시퀀스를 검색*/
	public String selectSqBeforeCart(String cd, String color, String size) throws SQLException {
		String sq = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select sq from goods where (sysdate between start_dt and end_dt)"
				+ " and cd=? and color=? and goods_size=? and display='Y'";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cd);
			pstmt.setString(2, color);
			pstmt.setString(3, size);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				sq = rs.getString(1);
			}
		} catch (Exception e) {
			e.getMessage();
		} finally {
			DisConnection(conn, pstmt, rs);
		}
		return sq;
	}
	
	// HJM Start!!!
	public List<Map<String, Object>> goodsGetPicPath(ArrayList<CartDto> list) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = "SELECT g.*, c.meaning FROM goods g, code c "
				+ " WHERE sq=? AND g.goods_size = c.cd AND c.used='Y'";
		Map<String, Object> goods = null;
		List<Map<String, Object>> orders = new ArrayList<>();
		try {
			conn = getConnection();
			// OrderDetailDto의 Goods_sq를 이용하여 goods테이블의 각 상품의 path경로를 구한다.
			for (CartDto dto : list) {
				ps = conn.prepareStatement(sql);
				ps.setString(1, dto.getGoods_sq());
				rs = ps.executeQuery();
				if(rs.next()) {
					goods = new HashMap<>();
					goods.put("goods_sq", rs.getString(1));
					goods.put("goods_cd", rs.getString(2));
					goods.put("nm", rs.getString(3));
					goods.put("cnt", dto.getCnt());
					goods.put("origin_price", rs.getInt(6));
					goods.put("gender", rs.getString(7));
					goods.put("top_category", rs.getString(8));
					goods.put("middle_category", rs.getString(9));
					goods.put("color", rs.getString(10));
					goods.put("goods_size", rs.getString(11));
					goods.put("dc_price", dto.getDc_price());
					goods.put("path", rs.getString(12));
					goods.put("size_meaning", rs.getString(15));
					orders.add(goods);
				}
				rs.close();
				ps.close();
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO 
			System.out.println("goodsGetPicPath Error");
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, rs);
		}
		
		return orders;
	}
	
	
	public GoodsDto getGoods(String goods_sq) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		GoodsDto goodsDto = new GoodsDto();
		String sql = "SELECT g.*, c.meaning FROM goods g, code c "
				+ " WHERE sq=? AND g.goods_size = c.cd AND c.used='Y'";
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, goods_sq);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				goodsDto.setCd(rs.getString(2));
				goodsDto.setNm(rs.getString(3));
				goodsDto.setGender(rs.getString(7));
				goodsDto.setTop_category(rs.getString(8));
				goodsDto.setMiddle_category(rs.getString(9));
				rs.getString(10);
				if(!rs.wasNull()) {
					goodsDto.setColor(rs.getString(10));					
				} else {
					goodsDto.setColor("");
				}
				rs.getString(11);
				if(!rs.wasNull()) {
					goodsDto.setGoods_size(rs.getString(15));
				} else {
					goodsDto.setGoods_size("");
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("getGoods Error");
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, rs);
		}
		
		return goodsDto;
	}
	// 검색결과 list
	public ArrayList<GoodsDto> searchResultList(String keyword) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		ArrayList<GoodsDto> list = new ArrayList<>();
		String sql = "SELECT g1.*, path" + 
				"	FROM (SELECT cd, nm, gender, top_category, middle_category, price, SUM(stock) stock" + 
				"     	  FROM goods " + 
				"     	  WHERE nm LIKE '%'|| ? ||'%' " + 
				"        	AND (SYSDATE BETWEEN start_dt AND end_dt) " + 
				"        	AND display = 'Y' " + 
				"       	AND path IS NOT NULL " + 
				"    	  GROUP BY cd, nm, gender, top_category, middle_category, price) g1, " + 
				"   	  (SELECT cd, MIN(path) path " + 
				"    	   FROM goods " + 
				"   	   WHERE nm LIKE '%'|| ? ||'%' " + 
				"    	    AND display = 'Y' " + 
				"   	   GROUP BY cd) g2 " + 
				"	WHERE g1.cd = g2.cd";
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, keyword);
			ps.setString(2, keyword);
			rs = ps.executeQuery();
			if(rs.next()) {
				do {
					GoodsDto goodsDto = new GoodsDto();
					goodsDto.setCd(rs.getString(1));
					goodsDto.setNm(rs.getString(2));
					goodsDto.setGender(rs.getString(3));
					goodsDto.setTop_category(rs.getString(4));
					goodsDto.setMiddle_category(rs.getString(5));
					goodsDto.setPrice(rs.getInt(6));
					goodsDto.setStock(rs.getInt(7));
					goodsDto.setPath(rs.getString(8));
					list.add(goodsDto);
				} while(rs.next());
			} else {
				new SQLException();
			}
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("searchResultList Error");
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, rs);
		}
		return list;
	}
	
	// JSY Part Start!
	// 종료일이 지나면 노출[ display ]를 N으로 바꾸는 클래스입니다.
	public int updateDisplay() throws SQLException {
	
		int result = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs=null;
		String sql = "update goods set display=? where end_dt<sysDate";
		try {
			conn = getConnection();
			ps=conn.prepareStatement(sql);
			ps.setString(1,"N");
			result = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DisConnection(conn,ps,rs);
		}
		return result;
	}
	// 상품sq에 해당하는 정보를 가져오는 클래스입니다.
	public GoodsDto selectGoods(String sq) throws SQLException {
		System.out.println("selectGoods Dao ok");
		GoodsDto dto = new GoodsDto();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
	
		try {
	
				conn = getConnection();
				String sql = "select * from goods where sq=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, sq);
				rs = ps.executeQuery();
	
				if (rs.next()) {
					dto.setSq(rs.getString("sq"));
					dto.setCd(rs.getString("cd"));
					dto.setNm(rs.getString("nm"));
					dto.setStart_dt(rs.getDate("start_dt"));
					dto.setPrice(rs.getInt("price"));
					dto.setGender(rs.getString("gender"));
					dto.setEnd_dt(rs.getDate("end_dt"));
					dto.setTop_category(rs.getString("top_category"));
					dto.setMiddle_category(rs.getString("middle_category"));
					dto.setColor(rs.getString("color"));
					dto.setGoods_size(rs.getString("goods_size"));
					dto.setPath(rs.getString("path"));
					dto.setStock(rs.getInt("stock"));
					dto.setDisplay(rs.getString("display"));
					System.out.println(rs.getString("sq"));
				}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			DisConnection(conn,ps,rs);
		}
	
		return dto;
	}
	// 상품을 수정한 후 그 정보를 저장하는 클래스입니다.
	public int updateGoods(GoodsDto dto) throws SQLException {
		
		int result=0;
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		
		try {
			String sql="";
				sql="select display from goods where sq=?";
				conn=getConnection();
				ps=conn.prepareStatement(sql);
				ps.setString(1,dto.getSq());
				rs=ps.executeQuery();
				
				if(rs.next()){
					String dis=rs.getString("display");
					if(dis.equals("Y")) result=0;
					else result=1;
				}
				System.out.println("result: "+result);
			if(result!=0){
				rs.close();
				ps.close();
				conn.close();
				//	1	2			3		4		5		6
				sql="update goods set nm=?,start_dt=?,end_dt=?,price=?,gender=?,top_category=?"
						+ ",middle_category=?,color=?,goods_size=?,path=?,stock=?,display=? where sq=?";
				// 7			8			9		10		11		12			13
			conn=getConnection();
			ps=conn.prepareStatement(sql);
			ps.setString(1,dto.getNm());
			ps.setDate(2, new java.sql.Date(dto.getStart_dt().getTime()));
			ps.setDate(3, new java.sql.Date(dto.getEnd_dt().getTime()));
			ps.setInt(4,dto.getPrice());
			ps.setString(5,dto.getGender());
			ps.setString(6,dto.getTop_category());
			ps.setString(7,dto.getMiddle_category());
			ps.setString(8, dto.getColor());
			ps.setString(9,dto.getGoods_size());
			ps.setString(10,dto.getSq());
			ps.setInt(11,dto.getStock());
			ps.setString(12, dto.getDisplay());
			ps.setString(13, dto.getSq());
			result=ps.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			DisConnection(conn, ps, rs);
		}
	
		return result;
	}
	//상품의 노출도 만을 변경시키는 클래스입니다.
	public int updateDisplay(String id, String display) throws SQLException {
		
		int result=0;
		
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		String sql="";
		System.out.println("updateGoods dao ok");
		
		sql="update goods set display=?,start_dt=sysdate,end_dt=add_months(sysdate,1) where sq=?";
		try {
			conn=getConnection();
			ps=conn.prepareStatement(sql);
			ps.setString(1, display);
			ps.setString(2, id);
			result=ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DisConnection(conn, ps, rs);
		}
		
		return result;
		
		}
	// 상품을 검색 조건과 검색값에 대한 결과 상품항목들을 가져오는 클래스입니다.
	public List<GoodsDto> searchGoods(String category,String search, int startRow, int endRow) throws SQLException {
		List<GoodsDto> list=new ArrayList<GoodsDto>();
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		String sql="";
		String cat=category;
		
		
		try {
			conn=getConnection();
			
		
			if(startRow==0||endRow==0){
				
				sql="select * from (select rownum rn, goods.* from (select * from goods where "+cat+"=?) goods)";
				System.out.println("sql: "+sql);
				ps=conn.prepareStatement(sql);
				ps.setString(1, search);
				rs=ps.executeQuery();
			}else{
				sql="select * from (select rownum rn, goods.* from (select * from goods where "+cat+"=?) goods) where rn between ? and ?";
				System.out.println("sql: "+sql);
				ps=conn.prepareStatement(sql);
				ps.setString(1, search);
				ps.setInt(2,startRow);
				ps.setInt(3,endRow);
				rs=ps.executeQuery();
				
			}
			
			while(rs.next()){
				GoodsDto dto = new GoodsDto();
				dto.setSq(rs.getString("sq"));
				dto.setCd(rs.getString("cd"));
				dto.setNm(rs.getString("nm"));
				dto.setStart_dt(rs.getDate("start_dt"));
				dto.setEnd_dt(rs.getDate("end_dt"));
				dto.setPrice(rs.getInt("price"));
				dto.setGender(rs.getString("gender"));
				dto.setTop_category(rs.getString("top_category"));
				dto.setMiddle_category(rs.getString("middle_category"));
				dto.setColor(rs.getString("color"));
				dto.setGoods_size(rs.getString("goods_size"));
				dto.setPath(rs.getString("path"));
				dto.setStock(rs.getInt("stock"));
				dto.setDisplay(rs.getString("display"));
				System.out.println("dto: "+rs.getString("sq"));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DisConnection(conn, ps, rs);
		}
		
		return list;
	}
	// 전체 상품에 대한 정보를 가져오는 클래스입니다.
	public List<GoodsDto> selectGoods(int startRow,int endRow) throws SQLException {
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		String sql="";
		List<GoodsDto> list=new ArrayList<GoodsDto>();
		try {
			conn=getConnection();
			
			
			if(startRow==0||endRow==0){
				sql="select * from (select rownum rn, goods.* from (select * from goods) goods)";
				ps=conn.prepareStatement(sql);
				rs=ps.executeQuery();
			}else{
				sql="select * from (select rownum rn, goods.* from (select * from goods) goods) where rn between ? and ?";
				ps=conn.prepareStatement(sql);
				ps.setInt(1, startRow);
				ps.setInt(2, endRow);
				rs=ps.executeQuery();
			}
			
			while(rs.next()){
				GoodsDto dto = new GoodsDto();
				dto.setSq(rs.getString("sq"));
				dto.setCd(rs.getString("cd"));
				dto.setNm(rs.getString("nm"));
				dto.setStart_dt(rs.getDate("start_dt"));
				dto.setEnd_dt(rs.getDate("end_dt"));
				dto.setPrice(rs.getInt("price"));
				dto.setGender(rs.getString("gender"));
				dto.setTop_category(rs.getString("top_category"));
				dto.setMiddle_category(rs.getString("middle_category"));
				dto.setColor(rs.getString("color"));
				dto.setGoods_size(rs.getString("goods_size"));
				dto.setPath(rs.getString("path"));
				dto.setStock(rs.getInt("stock"));
				dto.setDisplay(rs.getString("display"));
				
				list.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			DisConnection(conn, ps, rs);
		}
		return list;
	}
	
	//-------------------------------kkh start------------------------------------------------
	public int getCodeTotalCnt() {
		int result = 0;
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "select count(*) from code";
		Statement stmt = null;
		conn = getConnection();
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
	
		} finally {
			try {
				DisConnection(conn, ps, rs);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	
		return result;
	}
	public List<CodeDto> codeList(int startRow, int endRow) throws SQLException {
		List<CodeDto> list = new ArrayList<CodeDto>();// try 안에 있으면 try의 지역변수가
														// 되는듯
		ResultSet rs = null;
		Connection conn = null;
		String sql = "select * from (select rownum rn,a.* from(select * from code) a ) WHERE rn between ? and ?";
		PreparedStatement ps = null;
		conn = getConnection();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, startRow);
			ps.setInt(2, endRow);
			rs = ps.executeQuery();
			while (rs.next()) {
				CodeDto board = new CodeDto();
				board.setCd(rs.getString(2));
				board.setCategory(rs.getString(3));
				board.setMeaning(rs.getString(4));
				board.setUsed(rs.getString(5));
				list.add(board);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		} finally {
			DisConnection(conn, ps, rs);
		}
		return list;
	
	}
	public int insertCode(CodeDto codeDto) {
		int result = 0;
		ResultSet rs = null;
		String sql = "insert into code values(?,?,?,?)";
		PreparedStatement ps = null;
		Connection conn = null;
		conn = getConnection();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, codeDto.getCd());
			ps.setString(2, codeDto.getCategory());
			ps.setString(3, codeDto.getMeaning());
			ps.setString(4, "" + codeDto.getUsed());
			result = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				DisConnection(conn, ps, rs);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	
		return result;
	}
	public CodeDto selectCode(String code) {
		ResultSet rs = null;
		CodeDto codeDto = new CodeDto();
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "select * from code where cd=?";
		conn = getConnection();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, code);
			rs = ps.executeQuery();
			if (rs.next()) {
				codeDto.setCd(rs.getString("cd"));
				codeDto.setCategory(rs.getString("category"));
				codeDto.setMeaning(rs.getString("meaning"));
				codeDto.setUsed(rs.getString("used"));
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				DisConnection(conn, ps, rs);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	
		return codeDto;
	}
	public int changeCode(CodeDto codeDto) {
		ResultSet rs = null;
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "update code set category=?,meaning=?,used=? where cd=?";
		int result = 0;
		System.out.println("체인지코드 codeDto.getCd() : " + codeDto.getCategory() + "  " + codeDto.getMeaning());
		conn = getConnection();
	
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, codeDto.getCategory());
			ps.setString(2, codeDto.getMeaning());
			ps.setString(3, "" + codeDto.getUsed());
			ps.setString(4, codeDto.getCd());
			result = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				DisConnection(conn, ps, rs);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		System.out.println("result : " + result);
		return result;
	}
	public int checkCode(String code) {
		System.out.println("코드길이는 : " + code.length());
		int result = 0;
		if (code.length() == 0) {
			result = 1;
		}
		ResultSet rs = null;
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "select cd from code where cd=?";
		conn = getConnection();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, code);
			rs = ps.executeQuery();
			if (rs.next()) {
				result = 1;
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				DisConnection(conn, ps, rs);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	public int insertAdminGoods(GoodsDto gt) throws SQLException {
		System.out.println(gt.getDisplay());
		int result = 0;
		ResultSet rs = null;
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "insert into goods (sq,cd,nm,start_dt,end_dt,price,gender,top_category,middle_category,color,goods_size,path,stock,display) "
				+ "values ('G' || lpad(goods_sq.nextval, 9, '0'),?,?,?,?,?,?,?,?,?,?,'G' || lpad(goods_sq.CURRVAL, 9, '0'),?,?)";
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, gt.getCd());
			ps.setString(2, gt.getNm());
			ps.setDate(3, new java.sql.Date(gt.getStart_dt().getTime()));
			ps.setDate(4, new java.sql.Date(gt.getEnd_dt().getTime()));
			ps.setInt(5, gt.getPrice());
			ps.setString(6, gt.getGender());
			ps.setString(7, String.valueOf(gt.getTop_category()));
			ps.setString(8, gt.getMiddle_category());
			ps.setString(9, gt.getColor());
			ps.setString(10, gt.getGoods_size());
			ps.setInt(11, gt.getStock());
			ps.setString(12, String.valueOf(gt.getDisplay()));
			result = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("goodsdao,insertAdminGoods에서 에러");
			System.out.println(e.getMessage());
		} finally {
			DisConnection(conn, ps, rs);
		}
		return result;
	}
	public String createGoodsCode(String gender, String top_category, String middle_category) throws SQLException {
		int num = 0;
		String result = "";
		ResultSet rs = null;
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "select count(*) from goods where gender=? and top_category=? and middle_category=?";
		String sql2 = "select LPAD(?,7,0) from dual";
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, gender);
			ps.setString(2, top_category);
			ps.setString(3, middle_category);
			rs = ps.executeQuery();
			if (rs.next()) {
				num = rs.getInt(1) + 1;
				ps.close();
				rs.close();
				ps = conn.prepareStatement(sql2);
				ps.setInt(1, num);
				rs = ps.executeQuery();
				if (rs.next()) {
					result = middle_category + rs.getString(1);
				}
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			DisConnection(conn, ps, rs);
		}
		return result;
	}
	public String goodsAdminGetSq() throws SQLException {
		String result = "";
		int i = 1;
		ResultSet rs = null;
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "select max(sq) from goods where 1=?";
		conn = getConnection();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, i);
			rs = ps.executeQuery();
			if (rs.next()) {
				result = rs.getString(1);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			DisConnection(conn, ps, rs);
		}
		return result;
	}
	
	public List<GoodsDto> selectDisplayGoods(int startRow,int endRow) throws SQLException {
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		String sql="";
		List<GoodsDto> list=new ArrayList<GoodsDto>();
		try {
			conn=getConnection();
			
			
			if(startRow==0||endRow==0){
				sql="select * from (select rownum rn, goods.* from (select * from goods where display='Y') goods)";
				ps=conn.prepareStatement(sql);
				rs=ps.executeQuery();
			}else{
				sql="select * from (select rownum rn, goods.* from (select * from goods where display='Y') goods) where rn between ? and ?";
				ps=conn.prepareStatement(sql);
				ps.setInt(1, startRow);
				ps.setInt(2, endRow);
				rs=ps.executeQuery();
			}
			
			while(rs.next()){
				GoodsDto dto = new GoodsDto();
				dto.setSq(rs.getString("sq"));
				dto.setCd(rs.getString("cd"));
				dto.setNm(rs.getString("nm"));
				dto.setStart_dt(rs.getDate("start_dt"));
				dto.setEnd_dt(rs.getDate("end_dt"));
				dto.setPrice(rs.getInt("price"));
				dto.setGender(rs.getString("gender"));
				dto.setTop_category(rs.getString("top_category"));
				dto.setMiddle_category(rs.getString("middle_category"));
				dto.setColor(rs.getString("color"));
				dto.setGoods_size(rs.getString("goods_size"));
				dto.setPath(rs.getString("path"));
				dto.setStock(rs.getInt("stock"));
				dto.setDisplay(rs.getString("display"));
				
				list.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		DisConnection(conn, ps, rs);
		System.out.println("size: "+list.size());
		return list;
	}
}
