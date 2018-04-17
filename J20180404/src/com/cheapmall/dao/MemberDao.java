package com.cheapmall.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.json.simple.JSONObject;

import com.cheapmall.dto.AdminDto;
import com.cheapmall.dto.UsersDto;

public class MemberDao {
	/*
	 * Version 1.0
	 * 최초작성자 : 허진무
	 * 내용 : 회원 및 관리자 관련 DAO
	 */
	
	/*
	작성자 : 최우일
	최초작성일 : 2018-04-11
	내용 :
		1. checkIdToFind(String, String)
		2. selectId(String, String)
		3. checkPwToFind(String, String)
		4. updatePw(String, String, String)
		2018-04-13
		5. checkGrade(String)
		6. authGrade(String)
		
	*/
	
	/*
	 * 작성자 : 허진무
	 * 최초작성일 : 20180411
	 * 내용 :
	 * 	1. userGetInfo() -> 유저 정보를 가져옴
	 *	2. usersInfoUpdate() -> 유저 정보를 업데이트
	 *	3. getTotalUserCnt() -> 전체 유저 수
	 *	4. userList() -> 유저 리스트
	 *	5. adminUpdateUser() -> 관리자 정보 업데이트
	 *	6. userLoginCheck() -> 유저 로그인
	 *	 * 수정일 : 20180411
	 * 내용 :
	 * 	1. checkIdAjax() -> 회원가입 시, id 중복검사
	 * 
	 * 수정일 : 20180412
	 * 내용 :
	 *  1. registUser() -> 회원가입
	 */
	
	/*
	 * Version 1.0
	 * 작성자 : 조안나 JAN
	 * 최초작성일자 : 180402
	 * 
	 * 1. check(String id, String pw) 
	 * 2. adminList(search,startRow, endRow)
	 * 3. select()
	 * 4. getCount()
	 * 5. searchCount(String search)
	 * 6. adminInsert(AdminDto dto)
	 * 7. adminUpdate(AdminDto dto)
	 * 8. adminDelete(String id, String pw)
	 * 180415/ 9. searchAdmin(String search, int index)
	 */
	
	/*
	 * 작성자: 정수연
	 * 최초 작성일: 180411
	 * 담당 메소드: 
	 * 		1) removeUser(id, pw): 회원의 id와 pw를 받아와 입력받은 pw와 대조하여 결과값을 return 합니다.
	 * 		2) countUser(): 회원 목록을 만들기 위해 회원 수를 가져오는 클래스 입니다.
	 * 		3) deleteUser(String check): 관리자가 선택한 회원들을 삭제하여 그 결과값을 반환합니다.
	 * 		4) selectUser(search, startRow, endRow): 관리자가  직접 삭제할 회원들을 검색하여 나온 결과 클래스 입니다.
	 * 		5) searchUserCount(grade): 등급에 따라 해당하는 회원 수를 돌려 받습니다.
	 */	
	
	private static MemberDao instance;
	private MemberDao() {}
	public static MemberDao getInstance() {
		if(instance == null) { instance = new MemberDao(); }
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
	수정일	: 2018-04-09
	내용		: ID찾기를 위해 입력한 성명과 이메일주소가 존재하는지 검사 */
	public int checkIdToFind(String nm, String email) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from users where nm=? and email=?";
		int result = 0;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nm);
			pstmt.setString(2, email);
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
	
	/*작성자	: 최우일
	수정일	: 2018-04-09
	내용		: checkIdToFind와 거의 일치하는 메소드지만 보안을 위해서 구분해서 사용 */
	public String selectId(String nm, String email) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select id from users where nm=? and email=?";
		String id = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nm);
			pstmt.setString(2, email);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				id = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DisConnection(conn, pstmt, rs);
		}
		
		return id;
	}
	
	/*작성자	: 최우일
	수정일	: 2018-04-09
	내용		: PW찾기를 위해 입력한 ID와 이메일주소가 존재하는지 검사 */
	public int checkPwToFind(String id, String email) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from users where id=? and email=?";
		int result = 0;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, email);
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
	
	/*작성자	: 최우일
	수정일	: 2018-04-09
	내용		: 입력된 ID와 이메일에 일치하는 PW 재설정 
	 			2018-04-16
	 			비밀번호 변경일 수정 추가*/
	public int updatePw(String id, String email, String pw) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "update users set pw=? where id=? and email=? and pw_dt=sysdate";
		int result = 0;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pw);
			pstmt.setString(2, id);
			pstmt.setString(3, email);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DisConnection(conn, pstmt, rs);
		}
		
		return result;
	}
	/*작성자	: 최우일
	수정일	: 2018-04-13
	내용		: grade가 없다면 미인증회원으로 간주하고 이메일 출력 */
	public String checkGrade(String id) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select email from users where id=? and grade is null";
		String email = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				email = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DisConnection(conn, pstmt, rs);
		}
		
		return email;
	}
	/*작성자	: 최우일
	수정일	: 2018-04-13
	내용		: 이메일인증을 받았다면 grade 업데이트 */
	public int authGrade(String id) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "update users set grade='G0' where id=? and grade is null";
		int result = 0;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DisConnection(conn, pstmt, rs);
		}
		
		return result;
	}
	// HJM Start!!!
	public UsersDto userGetInfo(String id) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		UsersDto usersDto = null;
		String sql = "SELECT * FROM users WHERE id=?";
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				usersDto = new UsersDto();
				usersDto.setId(rs.getString(1));
				usersDto.setPw(rs.getString(2));
				usersDto.setNm(rs.getString(3));
				usersDto.setBirth(rs.getString(4));
				usersDto.setTel(rs.getString(5));
				usersDto.setZipcode(rs.getString(6));
				usersDto.setAddr(rs.getString(7));
				usersDto.setAddr_detail(rs.getString(8));
				usersDto.setEmail(rs.getString(9));
				usersDto.setGender(rs.getString(10));
				usersDto.setGrade(rs.getString(11));
				usersDto.setPoint(rs.getInt(12));
				usersDto.setReg_dt(rs.getDate(13));
				usersDto.setPw_dt(rs.getDate(14));
			}
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("####userGetInfo DAO Error");
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, rs);
		}
		
		return usersDto;
	}
	public int usersInfoUpdate(UsersDto usersDto)  throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		
		String sql = "UPDATE users "
				+ " SET "
				+ " 	nm=?, birth=?, tel=?, zipcode=?, addr=?, addr_detail=? "
				+ " WHERE id=?";
		int result = 0;
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, usersDto.getNm());
			ps.setString(2, usersDto.getBirth());
			ps.setString(3, usersDto.getTel());
			ps.setString(4, usersDto.getZipcode());
			ps.setString(5, usersDto.getAddr());
			ps.setString(6, usersDto.getAddr_detail());
			ps.setString(7, usersDto.getId());
			
			result = ps.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("userInfoUpdate Error");
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, null);
		}
		
		return result;
	}
	public int getTotalUserCnt() throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = "select count(*) from users";
		int totalCnt = 0;
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				totalCnt = rs.getInt(1);
			}
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("getTotalUserCnt Error");
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, rs);
		}
		
		return totalCnt;
	}
	public List<UsersDto> userList(int startRow, int endRow) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = 
				  " select * "
				+ "	from "
				+ "		( "
				+ "			select rownum rn , a.* "
				+ "			from "
				+ " 			("
				+ "				select * "
				+ "				from users "
				+ "				order by reg_dt desc) a ) "
				+ " where rn between ? and ?";
		List<UsersDto> list = new ArrayList<>();
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, startRow);
			ps.setInt(2, endRow);
			
			rs = ps.executeQuery();
			while(rs.next()) {
				UsersDto usersDto = new UsersDto();
				usersDto.setId(rs.getString(2));
				//usersDto.setPw(rs.getString(3));
				usersDto.setNm(rs.getString(4));
				usersDto.setBirth(rs.getString(5));
				usersDto.setTel(rs.getString(6));
				//usersDto.setZipcode(rs.getString(7));
				//usersDto.setAddr(rs.getString(8));
				//usersDto.setAddr_detail(rs.getString(9));
				usersDto.setEmail(rs.getString(10));
				usersDto.setGender(rs.getString(11));
				usersDto.setGrade(rs.getString(12));
				//usersDto.setPoint(rs.getInt(13));
				usersDto.setReg_dt(rs.getDate(14));
				usersDto.setPw_dt(rs.getDate(15));
				list.add(usersDto);
			}
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("userList Error");
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, rs);
		}
		
		return list;
	}
	public int adminUpdateUser(UsersDto usersDto) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		
		int result = 0;
		String sql = "UPDATE users "
					+ " SET "
					+ "		nm=?, pw=?, zipcode=?, addr=?, addr_detail=?,"
					+ " 	email=?, gender=?, grade=?, point=? "
					+ "WHERE id=?";
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, usersDto.getNm());
			ps.setString(2, usersDto.getPw());
			ps.setString(3, usersDto.getZipcode());
			ps.setString(4, usersDto.getAddr());
			ps.setString(5, usersDto.getAddr_detail());;
			ps.setString(6, usersDto.getEmail());
			ps.setString(7, usersDto.getGender());
			ps.setString(8, usersDto.getGrade());
			ps.setInt(9, usersDto.getPoint());
			ps.setString(10, usersDto.getId());
			
			result = ps.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("adminUpdateUser Error");
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, null);
		}
		
		return result;
	}
	
	public JSONObject checkIdAjax(String id) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		JSONObject json = new JSONObject();
		String sql = "SELECT id FROM users WHERE id = ?";
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			json.put("result", "no");
			if(rs.next()) {
				json.replace("result", "no", "yes");
			}
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("checkIdAjax Error");
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, rs);
		}
		
		return json;
	}
	
	public int registUser(UsersDto usersDto) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		int result = 0;
		String sql = "INSERT INTO users "
				+ " VALUES(?,?,?,?,?,?,?,?,?,?,'G0',0,SYSDATE,SYSDATE)";
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, usersDto.getId());
			ps.setString(2, usersDto.getPw());
			ps.setString(3, usersDto.getNm());
			ps.setString(4, usersDto.getBirth());
			ps.setString(5, usersDto.getTel());
			ps.setString(6, usersDto.getZipcode());
			ps.setString(7, usersDto.getAddr());
			ps.setString(8, usersDto.getAddr_detail());
			ps.setString(9, usersDto.getEmail());
			ps.setString(10, usersDto.getGender());
			
			result = ps.executeUpdate();
			
			if(result != 0) {
				result = 1;
			}
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("registUser Error");
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, rs);
		}
		
		return result;
	}
	
	public int userPwModify(String id, String pw) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		
		int result = 0;
		String sql = "UPDATE users"
				+ " SET pw = ?"
				+ " WHERE id = ?";
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, pw);
			ps.setString(2, id);
			result = ps.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("userPwModify Error");
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, null);
		}
		
		return result;
	}
	
	// KMH Part
	public int userLoginCheck(String id, String pw) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		int result = 0;
		String sql = "SELECT pw FROM users WHERE id=?";
	
		// 비밀번호가 일치하는 경우는 제외하는 이유!
		// 보안상 비밀번호가 틀렸다고하면 해커 or 악의적인 사용자들이 계속해서 시도한다.!!
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			if(rs.next()) {
				if(pw.equals(rs.getString(1))) {
					result = 1;
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("userLoginCheck Error");
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, rs);
		}
		
		return result;
	}
	
	//JAN Part Start
	/* 로그인시 ID, PW 확인 후 권한 비교*/
	public String check(String id, String pw) throws SQLException {
		String result = "no";
		Connection conn = null;
		PreparedStatement ps = null; ResultSet rs = null;
		String sql  = "select pw, auth from ADMIN where id=?"; 
		try { 
			conn  = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
	
			rs = ps.executeQuery();
			if (rs.next()) {
				String dbPasswd = rs.getString(1);
				String dbAuth = rs.getString(2);
				
				if (dbPasswd.equals(pw)) result = dbAuth;
				else result = "no";
				
			} else   result = "no";
			
		} catch(Exception e) { System.out.println(e.getMessage());
		} finally {
			DisConnection(conn, ps, rs);
		}
		return result;
	}
	/* 관리자관리에서 관리자목록 뿌려주고 검색기능시 이름으로 검색 가능*/
	public List<AdminDto> adminList(int startRow, int endRow)
			throws SQLException {
		List<AdminDto> adminList = new ArrayList<AdminDto>();

		Connection conn = null;
		String sql = "select * from admin";
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				AdminDto dto = new AdminDto();
				dto.setId(rs.getString("id"));
				dto.setPw(rs.getString("pw"));
				dto.setNm(rs.getString("nm"));
				dto.setDept(rs.getString("dept"));
				dto.setPosition(rs.getString("position"));
				dto.setEmp_no(rs.getString("emp_no"));
				dto.setAuth(rs.getString("auth"));
				dto.setTel(rs.getString("tel"));
				dto.setEmail(rs.getString("email"));
				dto.setPath(rs.getString("path"));
				adminList.add(dto);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			DisConnection(conn, ps, rs);
		}
		return adminList;
	}
	/* 수정할 관리자정보 선택*/
	public AdminDto select(String id) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		AdminDto select = null;
		String sql = "select * from admin where id=?";
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();

			if (rs.next()) {
				select = new AdminDto();
				select.setId(rs.getString("id"));
				select.setPw(rs.getString("Pw"));
				select.setNm(rs.getString("Nm"));
				select.setDept(rs.getString("Dept"));
				select.setPosition(rs.getString("Position"));
				select.setEmp_no(rs.getString("Emp_no"));
				select.setAuth(rs.getString("Auth"));
				select.setTel(rs.getString("Tel"));
				select.setEmail(rs.getString("Email"));
				select.setPath(rs.getString("Path"));
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			DisConnection(conn, ps, rs);
		}
		return select;
	}
	/*AdminFormAction - search == null 기본인원 출력*/
	public int getCount() throws SQLException {
		Connection conn = null;
		String sql = "select count(*) from admin";
		PreparedStatement ps = null;
		ResultSet rs = null;
		int count = 0;
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if (rs.next()) 
				count = rs.getInt(1);
		}catch (Exception e) { System.out.println(e.getMessage());
		}finally {
			DisConnection(conn, ps, rs);
		}
		return count;
	}
	/*search 에 값이 있을경우 검색한 인원만 출력*/
	public int searchCount(String search) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int count = 0;
		try {
			conn=getConnection();
			String sql = "select * from admin where nm=? ";
			ps=conn.prepareStatement(sql);
			ps.setString(1, search);
			rs=ps.executeQuery();
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch(Exception e) {
				e.printStackTrace();
			} finally {
				DisConnection(conn, ps, rs);
			}
		return count;
	}
	/*관리자 신규등록*/
	public int adminInsert(AdminDto dto) throws SQLException {
		int result = 0;
		Connection conn = null;
		String sql = "Insert Into admin Values(?,?,?,?,?,?,?,?,?,?)";
		PreparedStatement ps = null;
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getId());
			ps.setString(2, dto.getPw());
			ps.setString(3, dto.getNm());
			ps.setString(4, dto.getDept());
			ps.setString(5, dto.getPosition());
			ps.setString(6, dto.getEmp_no());
			ps.setString(7, dto.getAuth());
			ps.setString(8, dto.getTel());
			ps.setString(9, dto.getEmail());
			ps.setString(10, dto.getPath());
	
			result = ps.executeUpdate();
			
		} catch (Exception e) { System.out.println(e.getMessage());
	} finally {
		if(ps!=null) ps.close();
		if(conn!=null) conn.close();
	}
		return result;
	}
	/*관리자 정보 수정*/
	public int adminUpdate(AdminDto dto) throws SQLException {
		int result = 0;
		Connection conn = null;
		String sql = "update admin set pw=?, nm=?,dept=?, position=?,auth=?,tel=?,email=? where id=?";
		PreparedStatement ps = null;
		try {
			conn=getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getPw());
			ps.setString(2, dto.getNm());
			ps.setString(3, dto.getDept());
			ps.setString(4, dto.getPosition());
			ps.setString(5, dto.getAuth());
			ps.setString(6, dto.getTel());
			ps.setString(7, dto.getEmail());
			ps.setString(8, dto.getId());
	
			result=ps.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if(ps!=null) ps.close();
			if(conn != null) conn.close();
		}
		return result;
	}
	/*관리자 삭제*/
	public int adminDelete(String id) throws SQLException {
		int result = 0;
		System.out.println(id);
		Connection conn = null;
		PreparedStatement ps = null;

		String sql = "Delete From admin Where id=?";

		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			result = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		}
		return result;
	}
	
	// JSY Part Start!
	// 회원의 id와 pw를 받아와 입력받은 pw와 대조하여 결과값을 return 합니다.
	public int removeUser(String id, String pw) throws SQLException {
		Connection conn=null;
		PreparedStatement ps=null;
		int result=0;
		ResultSet rs=null;
		String sql="";
		
		try {
			conn=getConnection();
			
			sql="select pwd from users where id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1,id);
			
			rs=ps.executeQuery();
			
			if(rs.next()){
				String dbPw=rs.getString(1);
				ps.close();
				
				if(dbPw.equals(pw)){
					sql="delete * from users where pwd=?";
					ps=conn.prepareStatement(sql);
					ps.executeUpdate();
				}else result=0;
				
				
			}else result=-1;
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			DisConnection(conn, ps, rs);
		}
		return result;
		
	}
	// 회원 목록을 만들기 위해 회원 수를 가져오는 클래스 입니다.
	public int countUser() throws SQLException {
		int count=0;
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		try {
			conn= getConnection();
			
			String sql="select count(*) from users";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			
			if(rs.next()){
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DisConnection(conn, ps, rs);
		}
	
		
		return count;
	}
	// 관리자가 선택한 회원들을 삭제하여 그 결과값을 반환합니다.
	public int deleteUser(String check) throws SQLException {
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		int result=0;
		
		
		String sql="delete from users where id=?";
		
		try {
			conn=getConnection();
			ps=conn.prepareStatement(sql);
			ps.setString(1, check);
			result=ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			DisConnection(conn, ps, rs);
		}
		
		return result;
	}
	// 관리자가 직접 삭제할 회원들을 검색하여 나온 결과 클래스 입니다.
	public List<UsersDto> selectUser(String search, int startRow, int endRow) throws SQLException {
		List<UsersDto> list=new ArrayList<UsersDto>();
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		try {
			conn=getConnection();
	
			String sql1 // grade X
			="select * from (select rownum rn, users.* from (select * from users) users) where rn between ? and ?";
			
			String sql2 // grade O
			="select * from (select rownum rn, users.* from (select * from users where grade=?) users) where rn between ? and ?";
			
			if(search==null || search.length()==0){
				ps=conn.prepareStatement(sql1);
				ps.setInt(1, startRow);
				ps.setInt(2, endRow);
			}
			else {
				ps=conn.prepareStatement(sql2);
				ps.setString(1,search);
				ps.setInt(2, startRow);
				ps.setInt(3,endRow);
			}
			rs=ps.executeQuery();
			
			while(rs.next()){
				UsersDto dto=new UsersDto();
				dto.setId(rs.getString("id"));
				dto.setPw(rs.getString("pw"));
				dto.setNm(rs.getString("nm"));
				dto.setBirth(rs.getString("birth"));
				dto.setTel(rs.getString("tel"));
				dto.setZipcode(rs.getString("zipcode"));
				dto.setAddr(rs.getString("addr"));
				dto.setAddr_detail(rs.getString("addr_detail"));
				dto.setEmail(rs.getString("email"));
				dto.setGender(rs.getString("gender"));
				dto.setGrade(rs.getString("grade"));
				dto.setPoint(rs.getInt("point"));
				dto.setReg_dt(rs.getDate("reg_dt"));
				dto.setPw_dt(rs.getDate("pw_dt"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			DisConnection(conn, ps, rs);
		}
		
		return list;
	}
	// 등급에 따라 해당하는 회원 수를 돌려 받습니다.
	public int searchUserCount(String grade) throws SQLException {
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		int count=0;
		
		try {
			conn=getConnection();
			
			String sql
			="select count(*) from users where grade=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, grade);
			rs=ps.executeQuery();
			
			if(rs.next()){
				count=rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			DisConnection(conn, ps, rs);
		}
		return count;
	}
	
	//조건별로 검색가능
	public ArrayList<AdminDto> searchAdmin(String how,String search) throws SQLException {
		ArrayList<AdminDto> list = new ArrayList<AdminDto>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			String sql1 = "select * from admin where nm like ? order by nm asc";
			String sql2 = "select * from admin where auth like ? order by nm asc";
			String sql3 = "select  * from admin where dept like ? order by nm asc";
			
			if(how.equals("1")) {       // 이름
				ps=conn.prepareStatement(sql1);
			}else if(how.equals("2")) { // 권한
				ps=conn.prepareStatement(sql2);
			}else {                    // 부서
				ps=conn.prepareStatement(sql3);
			}
			String setSearch = "%"+search+"%";
			ps.setString(1, setSearch);
			rs=ps.executeQuery();
			while(rs.next()) {
				AdminDto dto = new AdminDto();
				dto.setId(rs.getString("id"));
				dto.setPw(rs.getString("pw"));
				dto.setNm(rs.getString("nm"));
				System.out.println("searchAdmin nm->"+rs.getString("nm"));				
				System.out.println("searchAdmin dept->"+rs.getString("dept"));
				
				dto.setDept(rs.getString("dept"));
				dto.setPosition(rs.getString("position"));
				dto.setEmp_no(rs.getString("emp_no"));
				dto.setAuth(rs.getString("auth"));
				dto.setTel(rs.getString("tel"));
				dto.setEmail(rs.getString("email"));
				dto.setPath(rs.getString("path"));
				list.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			DisConnection(conn, ps, rs);
		}
		return list;
	}
}
