package com.cheapmall.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.cheapmall.dto.CartDto;
import com.cheapmall.dto.Order_detailDto;
import com.cheapmall.dto.OrdersDto;
import com.cheapmall.dto.ReturnsDto;

public class OrderDao {
	/*
	 * Version 1.0 최초작성자 : 허진무 내용 : 주문 관련 DAO
	 */

	/*
	작성자 : 최우일
	최초작성일 : 2018-04-11
	내용 :
		1. detailToCart(String, int, int, String)
		2. selectCart(String, String)
		3. addCart(String, int)
		4. insertCart(String, int, int, String)
		5. listCart(String)
		6. updateCart(String, String)
		7. deleteCart(String)
		8. selectCartBeforePay(String)
		
	*/
	
	/*
	 * 작성자: 정수연
	 * 최초 작성일: 180411
	 * 담당 메소드: 
	 * 		1) selectOrders(id, startRow, endRow): 해당 회원에 해당하는 주문정보를 받아옵니다.
	 * 		2) detailOrder(id, order_sq): 해당 회원의 특정 주문에 대한 주문상세 정보를 받아옵니다.
	 * 		3) returnOrder(id, sq): 회원의 반품 중 전체반품에 해당하는 부분입니다.
	 * 		4) returnOrder(id, order_sq, detail_sq): 회원의 반품 중 부분반품에 해당하는 부분입니다.
	 * 		
	 * 		최종수정일: 18-04-12
	 * 		5) getOrderId(detail_sq): 각 반품 항목에 따른 주문번호를 가져옵니다.
	 * 		6) getReturnList(String id): 반품 목록을 가져옵니다. 
	 */	
	
	/*
	 * 작성자 : 김기한 최초작성일 : 2018/04/11 
	 * 내용 
	 * 1. khOrderList(String id) : 취소리스트에 뿌릴 주문목록리스트를 가져옴 
	 * 2. khOrderCancle(String[] detail_sq) : 주문을 취소함 
	 * 3. khGetOrder_Sq(String[] detail_sq) : 오더 시퀀스를 가져옴 
	 * 4. khReMakeOrderList(String valueList) : 취소된 상품 이외의 다시 주문을 상품리스트를 생성함
	 * 수정일 : 2018/04/12 
	 * 1. khOrderReInsert(List<HashMap> list) : 다시 주문할 상품리스틀를 주문함
	 * 수정일 : 2018/04/19
	 * return_UsePoint(return_use,id) 추가(취소한 상품들의 포인트를 다시 돌려줌)
	 */
	
	/*
	 * 작성자 : 허진무
	 * 최초작성일 : 20180412
	 * 내용 : 
	 * 	1. userOrder() -> 회원 주문관련 메소드
	 * 	
	 */
	
	/*
	 * 작성자: 정수연
	 * 최초 작성일: 180411
	 * 담당 메소드: 
	 * 		1) selectOrders(id, startRow, endRow): 해당 회원에 해당하는 주문정보를 받아옵니다.
	 * 		2) detailOrder(id, order_sq): 해당 회원의 특정 주문에 대한 주문상세 정보를 받아옵니다.
	 * 		3) returnOrderAll(id, sq): 회원의 반품 중 전체반품에 해당하는 부분입니다.
	 * 		4) returnOrderPart(id, order_sq, detail_sq): 회원의 반품 중 부분반품에 해당하는 부분입니다.
	 * 		
	 * 		최종수정일: 18-04-12
	 * 		5) getOrderId(detail_sq): 각 반품 항목에 따른 주문번호를 가져옵니다.
	 * 		6) getReturnList(String id): 반품 목록을 가져옵니다. 
	 */	
	
	/*
	 * 작성자 : 조안나
	 * 최초 작성일 : 18-04-12
	 * 내용 :
	 * 		1.olSimple(String id) : 간략보기시 나올 주문정보
	 */

	private static OrderDao instance;

	private OrderDao() {
	}

	public static OrderDao getInstance() {
		if (instance == null) {
			instance = new OrderDao();
		}
		return instance;
	}

	private Connection getConnection() {
		Connection conn = null;
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx
					.lookup("java:comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
		} catch (Exception e) {
			// SYSO
			System.out.println("Connection Error");
			System.out.println(e.getMessage());
		}
		return conn;
	}

	private void DisConnection(Connection conn, PreparedStatement pstmt,
			ResultSet rs) throws SQLException {
		if (rs != null) {
			rs.close();
		}
		if (pstmt != null) {
			pstmt.close();
		}
		if (conn != null) {
			conn.close();
		}
	}

	// CWI Part Start
	/*
	 * 작성자 : 최우일 수정일 : 2018-04-04 내용 : 상세페이지서 장바구니 담기를 했을때 실행되는 메소드
	 * selectCart결과에 따라 insert 또는 update를 행함
	 */
	public int detailToCart(String sq, int cnt, int price, String id)
			throws SQLException {
		int result = 0;

		if (selectCart(sq, id) == 1) {
			result = addCart(sq, cnt);
		} else {
			result = insertCart(sq, cnt, price, id);
		}
		return result;
	}

	/*
	 * 작성자 : 최우일 수정일 : 2018-04-04 내용 : 내가 담으려는 상품이 장바구니에 이미 있는지 검사
	 */
	public int selectCart(String sq, String id) throws SQLException {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select cart_sq from cart where goods_sq=? and user_id=?";

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sq);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = 1;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DisConnection(conn, pstmt, rs);
		}
		return result;
	}

	/*
	 * 작성자 : 최우일 수정일 : 2018-04-04 내용 : 담으려는 상품이 이미 존재한다면 수량만 더함
	 */
	public int addCart(String sq, int cnt) throws SQLException {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "update cart set cnt=cnt+? where goods_sq=?";

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cnt);
			pstmt.setString(2, sq);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DisConnection(conn, pstmt, rs);
		}
		return result;
	}

	/*
	 * 작성자 : 최우일 수정일 : 2018-04-04 내용 : 담으려는 상품이 없다면 새롭게 시퀀스를 생성
	 */
	public int insertCart(String sq, int cnt, int price, String id)
			throws SQLException {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "insert into cart values('C' || lpad(cart_sq.nextval,9,'0'), ?, ?, ?, ?, 0)";

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, sq);
			pstmt.setInt(3, cnt);
			pstmt.setInt(4, price);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DisConnection(conn, pstmt, rs);
		}
		return result;
	}

	/*
	 * 작성자 : 최우일 수정일 : 2018-04-04 내용 : 장바구니에 보여줄 상품들의 정보를 리스트<맵>에 담음
	 */
	public ArrayList<HashMap<String, String>> listCart(String id)
			throws SQLException {
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select c.*, g.nm, g.color, cd.meaning, g.gender, g.top_category, g.middle_category, g.path"
				+ " from cart c, goods g, code cd where c.user_id=? and c.goods_sq = g.sq and g.goods_size = cd.cd"
				+ " order by c.cart_sq desc";

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("cart_sq", rs.getString("cart_sq"));
				map.put("goods_sq", rs.getString("goods_sq"));
				map.put("cnt", rs.getString("cnt"));
				map.put("origin_price", rs.getString("origin_price"));
				map.put("dc_price", rs.getString("dc_price"));
				map.put("nm", rs.getString("nm"));
				map.put("color", rs.getString("color"));
				map.put("goods_size", rs.getString("meaning")); // 코드테이블에서 가져왔기에
																// 키와 밸류 다름
				map.put("gender", rs.getString("gender"));
				map.put("top_category", rs.getString("top_category"));
				map.put("middle_category", rs.getString("middle_category"));
				map.put("path", rs.getString("path"));
				list.add(map);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DisConnection(conn, pstmt, rs);
		}
		return list;
	}

	/*
	 * 작성자 : 최우일 수정일 : 2018-04-05 내용 : 장바구니 수정
	 */
	public int updateCart(String cnt, String cart_sq) throws SQLException {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "update cart set cnt=? where cart_sq=?";

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cnt);
			pstmt.setString(2, cart_sq);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DisConnection(conn, pstmt, rs);
		}
		return result;
	}

	/*
	 * 작성자 : 최우일 수정일 : 2018-04-05 내용 : 장바구니 삭제
	 */
	public int deleteCart(String cart_sq) throws SQLException {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "delete cart where cart_sq=?";

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cart_sq);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DisConnection(conn, pstmt, rs);
		}
		return result;
	}

	/*
	 * 작성자 : 최우일 수정일 : 2018-04-05 내용 : 결제로 넘기기 전에 장바구니 정보를 재정리
	 */
	public ArrayList<CartDto> selectCartBeforePay(String id)
			throws SQLException {
		ArrayList<CartDto> list = new ArrayList<CartDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from cart where user_id=?";

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				CartDto cartDto = new CartDto();
				cartDto.setCart_sq(rs.getString("cart_sq"));
				cartDto.setUser_id(id);
				cartDto.setGoods_sq(rs.getString("goods_sq"));
				cartDto.setCnt(rs.getInt("cnt"));
				cartDto.setOrigin_price(rs.getInt("origin_price"));
				cartDto.setDc_price(rs.getInt("dc_price"));
				list.add(cartDto);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DisConnection(conn, pstmt, rs);
		}
		return list;
	}

	// JSY Part Start!
	// 해당 회원에 해당하는 주문정보를 받아옵니다.
public List<HashMap> selectOrders(String id, String order_sq) throws SQLException {
		
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		List<HashMap> list=new ArrayList<HashMap>();
		
		String sql="";
		
		
		try {
			conn=getConnection();
			
			sql="select a1.*, b1.cnt, b1.origin_price, b1.meaning, b1.order_dt,b1.pay_method"
				+ ",b1.use_point,b1.delivery_fee,b1.addr,b1.addr_detail from"
				+ " (select order_sq, g.nm, g.gender, g.top_category, g.middle_category, g.path from "
				+ "(select d.order_sq, min(d.goods_sq) sq from orders o, order_detail d where user_id=?"// ?
				+ "and d.order_sq=? group by d.order_sq order by order_sq)a, goods g where a.sq = g.sq) a1"//?
				+ ",(select o.pay_method,o.use_point,o.delivery_fee,o.addr,o.addr_detail,d.order_sq, o.origin_price"
				+ ", c.meaning, o.order_dt, sum(d.cnt) cnt from orders o, order_detail d, code c where user_id=?"//?
				+ " and d.order_sq=? and o.order_cd = c.cd and o.order_sq=d.order_sq"
				+ " group by o.pay_method,o.use_point,o.delivery_fee,o.addr"//?
				+ ",o.addr_detail,d.order_sq, o.origin_price, c.meaning, o.order_dt) b1 where a1.order_sq = b1.order_sq"
				+ " order by a1.order_sq desc";
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, order_sq);
			ps.setString(3, id);
			ps.setString(4, order_sq);
			rs=ps.executeQuery();
			if(rs.next()){
				HashMap map=new HashMap();
				map.put("order_sq", rs.getString("order_sq"));
				map.put("nm", rs.getString("nm"));
				map.put("gender", rs.getString("gender"));
				map.put("top_category", rs.getString("top_category"));
				map.put("middle_category", rs.getString("middle_category"));
				map.put("path", rs.getString("path"));
				map.put("cnt", rs.getString("cnt"));
				map.put("origin_price", rs.getString("origin_price"));
				map.put("meaning", rs.getString("meaning"));
				map.put("order_dt", rs.getString("order_dt"));
				map.put("pay_method",rs.getString("pay_method"));
				map.put("use_point",rs.getString("use_point"));
				map.put("delivery_fee",rs.getString("delivery_fee"));
				map.put("addr",rs.getString("addr"));
				map.put("addr_detail",rs.getString("addr_detail"));
				list.add(map);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DisConnection(conn, ps, rs);
		}
		return list;
	}
	
	//해당 회원의 특정 주문에 대한 주문상세 정보를 받아옵니다.
	public List<HashMap> detailOrder(String order_sq) throws SQLException {
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		List<HashMap> detailList=new ArrayList<HashMap>();
		String sql="";
		System.out.println("detailOrder ok");
		try {
			conn=getConnection();
			
				sql="select d.*,g.nm, g.gender, g.top_category, g.middle_category, g.path from order_detail d, goods g"
						+ " where order_sq=? and d.goods_sq = g.sq";
				ps=conn.prepareStatement(sql);
				ps.setString(1, order_sq);
				rs=ps.executeQuery();
				System.out.println("rs ok");
			while(rs.next()){
				System.out.println("rs next ok");
				HashMap map=new HashMap();
				map.put("detail_sq",rs.getString("detail_sq"));
				map.put("nm",rs.getString("nm"));
				map.put("order_sq",rs.getString("order_sq"));
				map.put("goods_sq",rs.getString("goods_sq"));
				map.put("origin_price",rs.getInt("origin_price"));
				map.put("dc_price",rs.getInt("dc_price"));
				map.put("cnt",rs.getInt("cnt"));
				map.put("gender",rs.getString("gender"));
				map.put("top_category",rs.getString("top_category"));
				map.put("middle_category",rs.getString("middle_category"));
				map.put("path",rs.getString("path"));
				detailList.add(map);
				System.out.println("rs detail_sq: "+rs.getString("detail_sq"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DisConnection(conn, ps, rs);
		}
		return detailList;
		
	}
	
	// 회원의 반품 중 전체반품에 해당하는 부분입니다.
	public int returnOrderAll(String id, String sq) throws SQLException {
		
		int result=0;
		Connection conn=null;
		PreparedStatement ps=null;
		CallableStatement cs=null;
		ResultSet rs=null;
		String sql="";
		
		try {
			conn=getConnection();
			sql="{call returnorderall.selectOrder(?,?)}";
			cs=conn.prepareCall(sql);
			cs.setString(1,id);
			cs.setString(2,sq);
			result=cs.executeUpdate();
			/*
				if(result>0){
					cs.close();
					sql="{call returnorderall.updatePoint(?)}";
					cs=conn.prepareCall(sql);
					cs.setString(1,id);
					result=cs.executeUpdate();
				}else result=0;
			*/
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DisConnection(conn, ps, rs);
			if(cs!=null) cs.close();
		}
		return result;
	}
	
	
	// 회원의 반품 중 부분반품에 해당하는 부분입니다.
		public int returnOrderPart(String id, String order_sq, String[] detail_sq) throws SQLException {
			int result=0;
			Connection conn=null;
			CallableStatement cs=null;
			PreparedStatement ps=null;
			ResultSet rs=null;
			ArrayList<String> list=new ArrayList<>();
			int sumD=0;
			int sumO=0;
			int sumP=0;
			int count=0;
			System.out.println("id: "+id);
			System.out.println("반품 order_sq: "+order_sq);
			try {
				conn=getConnection();
				System.out.println("부분 1번째 프로시저 들어감");
				String sql="{call returnOrderPart.selectOrder(?,?)}";
				cs=conn.prepareCall(sql);
				cs.setString(1,id);
				cs.setString(2,order_sq);
				result=cs.executeUpdate();
				cs.close();
				
				if(result>0){ // 1번째 프로시저
					System.out.println("부분 1번째 sum: 들어감");
					sql="select sum(origin_price*cnt),sum((origin_price-dc_price)*cnt), detail_sq "
							+ "from order_detail where detail_sq not in (?";
					
						for(int i=0;i<detail_sq.length-1;i++){
							sql+=",?";
						}
					sql+=") and order_sq=? group by detail_sq";
					ps=conn.prepareStatement(sql);
					
						for(int i=0;i<detail_sq.length;i++){
							ps.setString(i+1,detail_sq[i]);
						}
					ps.setString(detail_sq.length+1, order_sq);
					rs=ps.executeQuery();
					while(rs.next()){
						sumO+=rs.getInt(1);// 갯수*원가
						sumP+=rs.getInt(2);// 갯수*할인가
						/*dsArr[count]=Integer.toString(rs.getInt(2));*/
						list.add(rs.getString(3));
						count++;
					}
					System.out.println("sql: "+sql);
					System.out.println("sumO: "+sumO);
					System.out.println("sumP: "+sumP);
					if (result>0){// 부분 1번째 sum
						System.out.println("부분 2번째 프로시저 들어감");
						if (rs!=null) rs.close();
						if (ps!=null) ps.close();
						
						sql="{call returnOrderPart.insertOrder(?,?,?,?)}";
						cs=conn.prepareCall(sql);
						cs.setString(1,id);
						cs.setString(2,order_sq);
						cs.setInt(3, sumO);
						cs.setInt(4, sumP);
						result=cs.executeUpdate();
						
						if(result>0){// 부분 2번째 프로시저 값
							
							if(rs!=null) rs.close();
							if(cs!=null) cs.close();
							for(int i=0;i< list.size();i++){
								System.out.println("insert 할 list order_sq: "+list.get(i));
							}
							System.out.println("부분 3번째 프로시저 들어감");
							for(int i=0;i< list.size();i++){
								System.out.println("length: "+list.get(i));
								sql="{call returnOrderPart.updateOrderDetail(?,?)}";
								cs=conn.prepareCall(sql);
								cs.setString(1,id);
								cs.setString(2, list.get(i) );
								result=cs.executeUpdate();
								if(cs!=null) cs.close();
							} // for 문
						}else result=0; // // 부분 2번째 프로시저 값
					}else result=0;// 부분 1번째 sum sql
				}else result=0;// 부분 1번째 프로시저 값
			} catch (SQLException e) {
				e.printStackTrace();
			}finally{
				DisConnection(conn, ps, rs);
				if(cs!=null) cs.close();
			}
			return result;
		}
	
	// 반품 목록을 가져옵니다.
	public List<ReturnsDto> getReturnList(String id) throws SQLException {
		List<ReturnsDto> list=new ArrayList<ReturnsDto>();
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		String sql="select * from returns where user_id=?";
		
		try {
			conn=getConnection();
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			rs=ps.executeQuery();
			
			while(rs.next()){
				ReturnsDto dto=new ReturnsDto();
				dto.setReturn_sq(rs.getString("return_sq"));
				dto.setUser_id(id);
				dto.setDetail_sq(rs.getString("detail_sq"));
				dto.setCnt(rs.getInt("cnt"));
				dto.setReturn_cd(rs.getString("return_cd"));
				dto.setDelivery_fee(rs.getInt("delivery_fee"));
				dto.setReturn_dt(rs.getDate("return_dt"));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DisConnection(conn, ps, rs);
		}
		
		return list;
	}
	
	// 각 반품 항목에 따른 주문번호를 가져옵니다.
	public List<String> getOrderId(String detail_sq) throws SQLException {
		List<String> list=new ArrayList<String>();
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		String sql="select order_sq from order_detail where detail_sq=?";
		
		try {
			conn=getConnection();
			ps=conn.prepareStatement(sql);
			ps.setString(1, detail_sq);
			rs=ps.executeQuery();
			
			while(rs.next()){
				list.add(rs.getString("order_sq"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DisConnection(conn, ps, rs);
		}
		return list;
	}

	// ----------------------------------KKH
	// Start---------------------------------------------
	// 취소 리스트에 뿌릴 주문된 리스트들을 가져옵니다
	public List<HashMap> khOrderList(String id) throws SQLException {
		List<HashMap> list = new ArrayList<HashMap>();
		ResultSet rs = null;
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "select a.*,goods.* from goods inner join (select o.ORDER_SQ, o.ORDER_DT, o.ORDER_CD, "
				+ " d.CNT, d.ORIGIN_PRICE, d.DC_PRICE, d.GOODS_SQ, d.detail_sq "
				+ " from orders o inner join order_detail d on o.order_sq = d.ORDER_SQ where user_id=? and "
				+ " (o.order_cd = 'O0' or o.order_cd = 'O1')) a on goods.sq = a.goods_sq order by a.ORDER_SQ";
		conn = getConnection();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			while (rs.next()) {
				HashMap map = new HashMap();
				map.put("order_sq", rs.getString("order_sq"));
				map.put("order_dt", rs.getString("order_dt"));
				map.put("goods_sq", rs.getString("goods_sq"));
				map.put("cnt", rs.getString("cnt"));
				map.put("origin_price", rs.getString("origin_price"));
				map.put("dc_price", rs.getString("dc_price"));
				map.put("order_cd", rs.getString("order_cd"));
				map.put("gender", rs.getString("gender"));
				map.put("top_category", rs.getString("top_category"));
				map.put("middle_category", rs.getString("middle_category"));
				map.put("nm", rs.getString("nm"));
				map.put("detail_sq", rs.getString("detail_sq"));
				list.add(map);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			DisConnection(conn, ps, rs);
		}
		return list;
	}

	// 취소 리스트에서 선택한 상품들의 주문을 취소합니다
	public int khOrderCancle(String[] detail_sq) throws SQLException {
		ResultSet rs = null;
		PreparedStatement ps = null;
		Connection conn = null;
		HashSet<String> set = new HashSet<String>();
		String sql = "select order_sq from order_detail where detail_sq=?";
		String sql1 = "update orders set order_cd='O5' where order_sq=?";
		int result = 0;
		conn = getConnection();
		try {
			for (String num : detail_sq) {
				ps = conn.prepareStatement(sql);
				ps.setString(1, num);
				rs = ps.executeQuery();
				if (rs.next()) {
					set.add(rs.getString(1));
				}
				rs.close();
				ps.close();
			}
			for (String num : set) {
				ps = conn.prepareStatement(sql1);
				ps.setString(1, num);
				result = ps.executeUpdate();
				rs.close();
				ps.close();
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			DisConnection(conn, ps, rs);
		}
		return result;
	}

	// 취소한 상품들의 order_sq(시퀀스)를 중복없이 가져옵니다
	public HashSet<String> khGetOrder_Sq(String[] detail_sq)
			throws SQLException {
		HashSet<String> set = new HashSet<String>();
		ResultSet rs = null;
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "select order_sq from order_detail where detail_sq=?";
		conn = getConnection();
		try {
			for (int i = 0; i < detail_sq.length; i++) {
				ps = conn.prepareStatement(sql);
				ps.setString(1, detail_sq[i]);
				rs = ps.executeQuery();
				if (rs.next()) {
					set.add(rs.getString(1));
				}
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			DisConnection(conn, ps, rs);
		}
		return set;
	}

	// 취소한 상품을 제외하고 다시 주문을 합니다
	public List<HashMap> khReMakeOrderList(String valueList)
			throws SQLException {
		List<HashMap> list = new ArrayList<HashMap>();
		ResultSet rs = null;
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "select d.*,o.user_id,o.pay_method,o.delivery_fee,o.addr,o.addr_detail,o.order_dt,o.use_point from orders o inner join order_detail d on o.order_sq = d.order_sq and o.ORDER_SQ=?";
		conn = getConnection();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, valueList);
			rs = ps.executeQuery();
			while (rs.next()) {
				HashMap map = new HashMap();
				map.put("user_id", rs.getString("user_id"));
				map.put("pay_method", rs.getString("pay_method"));
				map.put("delivery_fee", rs.getInt("delivery_fee"));
				map.put("addr", rs.getString("addr"));
				map.put("addr_detail", rs.getString("addr_detail"));
				map.put("order_dt", rs.getDate("order_dt"));
				map.put("use_point", rs.getInt("use_point"));
				map.put("detail_sq", rs.getString("detail_sq"));
				map.put("order_sq", rs.getString("order_sq"));
				map.put("goods_sq", rs.getString("goods_sq"));
				map.put("origin_price", rs.getInt("origin_price"));
				map.put("dc_price", rs.getInt("dc_price"));
				map.put("cnt", rs.getInt("cnt"));
				list.add(map);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			DisConnection(conn, ps, rs);
		}
		return list;
	}

	// 취소된 상품을 제외한 상품들을 주문에 다시 추가합니다
	public int khOrderReInsert(List<HashMap> list, OrdersDto orderDto)
			throws SQLException {
		int result = 0;
		int result2 = 0;
		ResultSet rs = null;
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "insert into orders values('O' || lpad(order_sq.nextval, 9, '0'),?,?,?,?,?,?,?,?,?,?)";
		String sql2 = "insert into order_detail values('D' || lpad(order_detail_sq.nextval, 9, '0'),'O' || lpad(order_sq.currval, 9, '0'),?,?,?,?)";
		conn = getConnection();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, orderDto.getUser_id());
			ps.setInt(2, orderDto.getOrigin_price());
			ps.setInt(3, orderDto.getDc_price());
			ps.setString(4, orderDto.getPay_method());
			ps.setInt(5, orderDto.getUse_point());
			ps.setInt(6, orderDto.getDelivery_fee());
			ps.setString(7, orderDto.getAddr());
			ps.setString(8, orderDto.getAddr_detail());
			ps.setString(9, orderDto.getOrder_cd());
			ps.setDate(10, new java.sql.Date(orderDto.getOrder_dt().getTime()));
			result = ps.executeUpdate();
			if (result > 0) {
				ps.close();
				for (int i = 0; i < list.size(); i++) {
					HashMap map = new HashMap();
					map = list.get(i);
					ps = conn.prepareStatement(sql2);
					ps.setString(1, "" + map.get("goods_sq"));
					ps.setInt(2, Integer.parseInt("" + map.get("origin_price")));
					ps.setInt(3, Integer.parseInt("" + map.get("dc_price")));
					ps.setInt(4, Integer.parseInt("" + map.get("cnt")));
					result2 = ps.executeUpdate();
				}
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			DisConnection(conn, ps, rs);
		}
		return result2;
	}
	
	// HJM Start!!
	public int userOrder(String[] goods_sq, int[] origin_price, int[] dc_price, int[] cnt, String[] cart_sq, OrdersDto ordersDto, int usedPoint) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		int result = 0;
		String sql = "INSERT INTO orders "
				+ " VALUES('O' || LPAD(ORDER_SQ.NEXTVAL, 9, '0'), "
				+ " ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE) ";
		
		try {
			// Orders Table에 Order_sq 생성
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, ordersDto.getUser_id());
			ps.setInt(2, ordersDto.getOrigin_price());
			ps.setInt(3, ordersDto.getDc_price());
			ps.setString(4, ordersDto.getPay_method());
			ps.setInt(5, usedPoint);
			ps.setInt(6, ordersDto.getDelivery_fee());
			ps.setString(7, ordersDto.getAddr());
			ps.setString(8, ordersDto.getAddr_detail());
			ps.setString(9, "O0");
			
			result = ps.executeUpdate();
			ps.close();
			
			// 완료 시, package를 불러서 order_detail Table 에 주문된 정보를 보낸다.
			if(result == 1) {
				for (int i = 0; i < cnt.length; i++) {
					sql = "Insert INTO ORDER_DETAIL "
							+ " VALUES('D' || LPAD(order_detail_sq.nextval, 9, '0'), "
							+ "		   (SELECT MAX(order_sq) FROM orders WHERE user_id=?), ?, ?, ?, ?)";
					ps = conn.prepareStatement(sql);
					ps.setString(1, ordersDto.getUser_id());
					ps.setString(2, goods_sq[i]);
					ps.setInt(3, origin_price[i]);
					ps.setInt(4, dc_price[i]);
					ps.setInt(5, cnt[i]);
					result = ps.executeUpdate();
					if(result != 1) {
						new SQLException();
					}
					ps.close();
				}
				if(result == 1) {
					sql = "Update goods "
							+ " SET stock = stock - ? "
							+ " WHERE sq = ?";
					for(int i = 0 ; i < cnt.length ; i++) {
						ps = conn.prepareStatement(sql);
						ps.setInt(1, cnt[i]);
						ps.setString(2, goods_sq[i]);
						result = ps.executeUpdate();
						if(result != 1) {
							new SQLException();
						}
						ps.close();
					}
					
				}
				// Cart에서 주문 한 것이면 cart리스트 삭제
				if(result == 1 && cart_sq != null) {
					sql = "DELETE FROM cart "
							+ " WHERE cart_sq = ?";
					for(int i=0 ; i < cart_sq.length ; i++) {
						ps = conn.prepareStatement(sql);
						ps.setString(1, cart_sq[i]);
						result = ps.executeUpdate();
						if(result != 1) {
							new SQLException();
						}
						ps.close();
					}
				}
				
				// 포인트 사용
				if(result == 1 && usedPoint !=0) {
					sql = "UPDATE users "
							+ " SET point = point - ?"
							+ " WHERE id = ?";
					ps = conn.prepareStatement(sql);
					ps.setInt(1, usedPoint);
					ps.setString(2, ordersDto.getUser_id());
					result = ps.executeUpdate();
					if(result != 1) {
						new SQLException();
					}
					ps.close();
				}
				
				// 구매가 성공되면 회원의 포인트를 증가시기키고, 구매건수로 봐서 등급을 조정시킨다.
				if(result == 1) {
					// 나중에 프로시저로 만들면 좋을 것
					sql = "UPDATE users " + 
							" SET point = point+" + 
							"        (CASE " + 
							"            WHEN grade = 'G0' " + 
							"                THEN ROUND(( ? *0.02), 0) " + 
							"            WHEN grade = 'G1' " + 
							"                THEN ROUND(( ? *0.03), 0) " + 
							"            WHEN grade = 'G2' " + 
							"                THEN ROUND(( ? *0.04), 0) " + 
							"            WHEN grade = 'G3' " + 
							"                THEN ROUND(( ? *0.07), 0) " + 
							"            WHEN grade = 'G4' " + 
							"                THEN ROUND(( ? *0.09), 0) " + 
							"            WHEN grade = 'G5' " + 
							"                THEN ROUND(( ? *0.10), 0) " + 
							"        END)," + 
							"    grade = " + 
							"        (CASE " + 
							"            WHEN 100 < (SELECT COUNT(order_sq) " + 
							"                       FROM orders " + 
							"                       WHERE user_id = ? AND order_cd='O4') " + 
							"                THEN 'G5' " + 
							"            WHEN 80 < (SELECT COUNT(order_sq) " + 
							"                       FROM orders " + 
							"                       WHERE user_id = ? AND order_cd='O4') " + 
							"                THEN 'G4' " + 
							"            WHEN 50 < (SELECT COUNT(order_sq) " + 
							"                       FROM orders " + 
							"                       WHERE user_id = ? AND order_cd='O4') " + 
							"                THEN 'G3' " + 
							"            WHEN 30 < (SELECT COUNT(order_sq) " + 
							"                       FROM orders " + 
							"                       WHERE user_id = ? AND order_cd='O4') " + 
							"                THEN 'G2' " + 
							"            WHEN 20 < (SELECT COUNT(order_sq) " + 
							"                       FROM orders " + 
							"                       WHERE user_id = ? AND order_cd='O4') " + 
							"                THEN 'G1' " + 
							"            ELSE " + 
							"                'G0' " + 
							"            END) " + 
							" WHERE id = ?";
					ps = conn.prepareStatement(sql);
					ps.setInt(1, (ordersDto.getOrigin_price()));
					ps.setInt(2, (ordersDto.getOrigin_price()));
					ps.setInt(3, (ordersDto.getOrigin_price()));
					ps.setInt(4, (ordersDto.getOrigin_price()));
					ps.setInt(5, (ordersDto.getOrigin_price()));
					ps.setInt(6, (ordersDto.getOrigin_price()));
					ps.setString(7, ordersDto.getUser_id());
					ps.setString(8, ordersDto.getUser_id());
					ps.setString(9, ordersDto.getUser_id());
					ps.setString(10, ordersDto.getUser_id());
					ps.setString(11, ordersDto.getUser_id());
					ps.setString(12, ordersDto.getUser_id());
					
					result = ps.executeUpdate();
					if(result != 1) {
						new SQLException();
					}
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("userOrder Error");
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, rs);
		}
		
		return result;
	}
	
	//JAN
	/* 간략보기시 나올 주문내역 */
	/* 간략보기시 나올 주문내역 */
	public List<HashMap> olSimple(String id) throws SQLException {
		List<HashMap> list = new ArrayList<HashMap>();
		ResultSet rs = null;
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = 
				"select a1.*, b1.cnt, b1.origin_price, b1.meaning, b1.order_dt "
				+ "from(select order_sq, g.nm, g.gender, g.top_category, g.middle_category, g.path from "
				+ "(select d.order_sq, min(d.goods_sq) sq from orders o, order_detail d where user_id=?"
				+ " and o.order_sq = d.order_sq group by d.order_sq order by order_sq)"
				+ " a, goods g where a.sq = g.sq) a1,(select d.order_sq, o.origin_price, c.meaning, o.order_dt, sum(d.cnt) cnt "
				+ "from orders o, order_detail d, code c where user_id=?"
				+ " and o.order_sq = d.order_sq and o.order_cd = c.cd group by d.order_sq, o.origin_price, c.meaning, o.order_dt)"
				+ " b1 where a1.order_sq = b1.order_sq order by a1.order_sq desc";
		conn = getConnection();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, id);
			
			rs = ps.executeQuery();
			while (rs.next()) {
				HashMap map = new HashMap();
				map.put("order_sq", rs.getString("order_sq"));
				map.put("nm", rs.getString("nm"));
				map.put("gender", rs.getString("gender"));
				map.put("top_category", rs.getString("top_category"));
				map.put("middle_category", rs.getString("middle_category"));
				map.put("path", rs.getString("path"));
				map.put("cnt", rs.getString("cnt"));
				map.put("origin_price", rs.getString("origin_price"));
				map.put("order_cd", rs.getString("meaning"));
				map.put("order_dt", rs.getString("order_dt"));
				list.add(map);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			DisConnection(conn, ps, rs);
		}
		return list;
	}
	
	public void return_UsePoint(int return_use, String id) throws SQLException {
		System.out.println("리턴유즈" + return_use);
		int result = 0;
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		String sql = "update users set point=point+? where id=?";
		conn = getConnection();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, return_use);
			ps.setString(2, id);
			result = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, rs);
		}
	}
}
