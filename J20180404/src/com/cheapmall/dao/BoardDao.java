package com.cheapmall.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.cheapmall.dto.BoardDto;
import com.cheapmall.dto.GoodsDto;
import com.cheapmall.dto.ReviewDto;

public class BoardDao{
	/*
	 * Version 1.0
	 * 최초작성자 : 허진무
	 * 내용 : 게시판 / 리뷰 관련 DAO
	 */
	
	/*
	작성자 : 최우일
	최초작성일 : 2018-04-11
	내용 :
		1. getBoardCount(String)
		2. listNotice(int, int, String)
		3. selectContent(String)
		4. write(BoardDto)
		5. writeAdminNotice(BoardDto)
		6. updateAdminNotice(BoardDto)
		7. deleteAdminNotice(String)
		8. listAdminOther(int, int, String)
		2018-04-12
		9. updateBp(String)
		10. getContent(String)
		2018-04-16
		11. listUserOther(int, int, String)
		
	*/
	
	/*
	 * 작성자 : 허진무
	 * 최초작성일 : 20180411
	 * 내용 :
	 * 	1. getTotalReview() -> 전체리뷰리스트 개수를 가져옴
	 *	2. getReview() -> 전체리뷰리스트 중에 부분만 가져옴
	 *	3. writeReview() -> 리뷰를 작성합니다.
	 */
	
	private static BoardDao instance;
	private BoardDao() {}
	public static BoardDao getInstance() {
		if(instance == null) { instance = new BoardDao(); }
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
	수정일	: 2018-04-10
	내용		: 게시판 페이징을 위해 게시글 종류별 게시글 갯수를 구함 */
	public int getBoardCount(String boardCd) throws SQLException {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		if (boardCd == null) {
			sql = "select count(*) from board where board_cd not in ('B0', 'B4')";
		} else {
			sql = "select count(*) from board where board_cd=?";
		}
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			if (boardCd != null) {
				pstmt.setString(1, boardCd);
			}
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DisConnection(conn, pstmt, rs);
		}
		return result;
	}
	
	/*작성자	: 최우일
	수정일	: 2018-04-10
	내용		: 공지사항 리스트 */
	public List<BoardDto> listNotice(int startRow, int endRow) throws SQLException {
		List<BoardDto> list = new ArrayList<BoardDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select board_sq, subject, user_id, write_dt from(select a.*, rownum rn from "
				+ " (select * from board where board_cd='B0' order by board_sq desc) a) where rn between ? and ? "
				+ " order by board_sq desc";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				BoardDto boardDto = new BoardDto();
				boardDto.setBoard_sq(rs.getString(1));
				boardDto.setSubject(rs.getString(2));
				boardDto.setUser_id(rs.getString(3));
				boardDto.setWrite_dt(rs.getDate(4));
				list.add(boardDto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DisConnection(conn, pstmt, rs);
		}
		
		return list;
	}
	
	/*작성자	: 최우일
	수정일	: 2018-04-10
	내용		: 다용도로 쓰기 위해 모든 정보를 DTO에 담음 */
	public BoardDto selectContent(String board_sq) throws SQLException {
		BoardDto boardDto = new BoardDto();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from board where board_sq=?";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board_sq);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				boardDto.setBoard_sq(board_sq);
				boardDto.setUser_id(rs.getString(2));
				boardDto.setWrite_dt(rs.getDate(3));
				boardDto.setSubject(rs.getString(4));
				boardDto.setContent(rs.getString(5));
				boardDto.setObject(rs.getString(6));
				boardDto.setBoard_cd(rs.getString(7));
				boardDto.setBoard_p_cd(rs.getString(8));
				boardDto.setIp(rs.getString(9));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DisConnection(conn, pstmt, rs);
		}
		
		return boardDto;
	}
	/*작성자	: 최우일
	수정일	: 2018-04-10
	내용		: 문의/건의/신고 작성 */
	public int write(BoardDto boardDto)	throws SQLException {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "insert into board values('B' || lpad(board_sq.nextval, 9, '0'),?,sysdate,"
				+ "?,?,?,?,?,?)";
		String object = null;
		
		if (!boardDto.getObject().equals("")) {
			object = boardDto.getObject();
		}
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, boardDto.getUser_id());
			pstmt.setString(2, boardDto.getSubject());
			pstmt.setString(3, boardDto.getContent());
			pstmt.setString(4, object);
			pstmt.setString(5, boardDto.getBoard_cd());
			pstmt.setString(6, boardDto.getBoard_p_cd());
			pstmt.setString(7, boardDto.getIp());
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DisConnection(conn, pstmt, rs);
		}
		
		return result;
	}
	
	/*작성자	: 최우일
	수정일	: 2018-04-10
	내용		: 관리자 공지사항 작성 */
	public int writeAdminNotice(BoardDto boardDto) throws SQLException {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "insert into board values('B' || lpad(board_sq.nextval, 9, '0'),'관리자',sysdate,"
				+ "?,?,null,'B0','BP3',?)";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, boardDto.getSubject());
			pstmt.setString(2, boardDto.getContent());
			pstmt.setString(3, boardDto.getIp());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DisConnection(conn, pstmt, rs);
		}
		
		return result;
	}
	
	/*작성자	: 최우일
	수정일	: 2018-04-10
	내용		: 관리자 공지사항 수정 */
	public int updateAdminNotice(BoardDto boardDto) throws SQLException {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "update board set subject=?, content=?, ip=? where board_sq=?";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, boardDto.getSubject());
			pstmt.setString(2, boardDto.getContent());
			pstmt.setString(3, boardDto.getIp());
			pstmt.setString(4, boardDto.getBoard_sq());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DisConnection(conn, pstmt, rs);
		}
		
		return result;
	}
	
	/*작성자	: 최우일
	수정일	: 2018-04-12
	내용		: 문의/건의/신고 에 필요한 리스트내용 맵에 담음 */
	public List<HashMap> listAdminOther(int startRow, int endRow, String board_cd, String bp) throws SQLException {
		List<HashMap> list = new ArrayList<HashMap>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql1 = "select board_sq, subject, user_id, write_dt, meaning from(select a.*, rownum rn from "
				+ " (select * from board where board_cd=? order by board_sq desc) a), code where (rn between ? and ?) "
				+ " and board_p_cd = cd and used='Y' order by board_sq desc";
		String sql2 = "select board_sq, subject, user_id, write_dt, meaning from(select a.*, rownum rn from "
				+ " (select * from board where board_cd=? order by board_sq desc) a), code where (rn between ? and ?) "
				+ " and board_p_cd=? and board_p_cd = cd and used='Y' order by board_sq desc";
		
		try {
			conn = getConnection();
			
			if (bp.equals("all")) {
				pstmt = conn.prepareStatement(sql1);
				pstmt.setString(1, board_cd);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			} else {
				pstmt = conn.prepareStatement(sql2);
				pstmt.setString(1, board_cd);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
				pstmt.setString(4, bp);
			}
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				HashMap map = new HashMap();
				map.put("board_sq", rs.getString(1));
				map.put("subject", rs.getString(2));
				map.put("user_id", rs.getString(3));
				map.put("write_dt", rs.getDate(4));
				map.put("meaning", rs.getString(5));
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
	수정일	: 2018-04-10
	내용		: 관리자 공지사항 삭제 */
	public int deleteAdminNotice(String board_sq) throws SQLException {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "delete from board where board_sq=?";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board_sq);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DisConnection(conn, pstmt, rs);
		}
		
		return result;
	}
	/*작성자	: 최우일
	수정일	: 2018-04-12
	내용		: 글 진행상태 변경 */
	public int updateBp(String board_sq, String bp) throws SQLException {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		if (bp.equals("BP1")) {
			sql = "update board set board_p_cd=? where board_sq=? and board_p_cd='BP0'";
		} else if (bp.equals("BP2")) {
			sql = "update board set board_p_cd=? where board_sq=? and board_p_cd='BP1'";
		} else if (bp.equals("BP3")) {
			sql = "update board set board_p_cd=? where board_sq=? and board_p_cd='BP1'";
		}
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bp);
			pstmt.setString(2, board_sq);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DisConnection(conn, pstmt, rs);
		}
		return result;
	}
	/*작성자	: 최우일
	수정일	: 2018-04-12
	내용		: 답글이 달린 글인 경우 답글 출력 */
	public String getContent(String board_sq) throws SQLException {
		String content = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select content from board where board_cd='B4' and object=?";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board_sq);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				content = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DisConnection(conn, pstmt, rs);
		}
		return content;
	}
	// HJM Part Start!
	public int getTotalReview(String goods_cd, String reviewType) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		int totCnt = 0;
		String sql = null;
		if(reviewType.equals("photo")) {
			sql = "SELECT count(goods_cd) FROM review WHERE goods_cd LIKE ? AND path IS NOT NULL";
		} else if(reviewType.equals("simple")) {
			sql = "SELECT count(goods_cd) FROM review WHERE goods_cd LIKE ? AND path IS NULL";
		}
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, goods_cd);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				totCnt = rs.getInt(1);
			}
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("getTotalReview Error");
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, rs);
		}
		
		return totCnt;
	}
	public JSONObject getReview(String goods_cd, String reviewType, int startRow, int endRow) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		JSONObject json = new JSONObject();
		JSONArray list = new JSONArray();
		
		String sql = " select * "
				+ "	from "
				+ "		( "
				+ "			select rownum rn , a.* "
				+ "			from "
				+ " 			("
				+ "				select * "
				+ "				from review "
				+ "				order by sq desc) a ) "
				+ " where rn between ? and ? "
				+ " AND goods_cd LIKE ? ";
		
		if(reviewType.equals("photo")) {
			sql += " AND path IS NOT NULL";
		} else if(reviewType.equals("simple")) {
			sql += " AND path IS NULL";
		}
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, startRow);
			ps.setInt(2, endRow);
			ps.setString(3, goods_cd);
			rs = ps.executeQuery();
			if(rs.next()) {
				do {
					JSONObject board = new JSONObject();
					board.put("sq", rs.getString(2));
					board.put("user_id", rs.getString(3));
					board.put("write_dt", rs.getDate(4)+"");
					board.put("content", rs.getString(5));
					board.put("cnt", rs.getInt(6));
					board.put("up", rs.getInt(7));
					board.put("down", rs.getInt(8));
					board.put("star", rs.getInt(9));
					board.put("goods_cd", rs.getString(10));
					//board.put("ip", rs.getString(11));
					if(reviewType.equals("photo")) {
						board.put("path", rs.getString(12));
					}
					list.add(board);
				}while(rs.next());
				json.put("review", list);
			} else {
				json.put("result", "no");
			}
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("getReview Error");
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, rs);
		}
		
		return json;
	}
	public int writeReview(ReviewDto reviewDto) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		
		String sql = "INSERT INTO review"
				+ "	VALUES('R' || LPAD(review_sq.nextval, 9, '0'), ?, sysdate, ?, 0, 0, 0, ?, ?, ?, ?)";
		int result = 0;
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, reviewDto.getUser_id());
			ps.setString(2, reviewDto.getContent());
			ps.setInt(3, reviewDto.getStar());
			ps.setString(4, reviewDto.getGoods_cd());
			ps.setString(5, reviewDto.getIp());
			if(reviewDto.getPath().equals("")) {
				ps.setString(6, null);
			} else {
				ps.setString(6, reviewDto.getPath());
			}
			result = ps.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("writeReview error");
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, null);
		}
		
		return result;
	}
	
	/*작성자	: 최우일
	수정일	: 2018-04-16
	내용		: 일반사용자 건의 리스트 */
	public List<HashMap> listUserOther(int startRow, int endRow, String id) throws SQLException {
		List<HashMap> list = new ArrayList<HashMap>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select board_sq, subject, write_dt, meaning from(select a.*, rownum rn from "
				+ " (select * from board where board_cd not in ('B0', 'B4') and user_id=? order by board_sq desc) a), "
				+ "code where (rn between ? and ?) and board_p_cd = cd and used='Y' order by board_sq desc";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				HashMap map = new HashMap();
				map.put("board_sq", rs.getString(1));
				map.put("subject", rs.getString(2));
				map.put("write_dt", rs.getDate(3));
				map.put("meaning", rs.getString(4));
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
