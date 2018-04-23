package com.cheapmall.service.admin;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.MemberDao;
import com.cheapmall.dto.UsersDto;
import com.cheapmall.service.CommandProcess;

public class UserAdminListAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			HttpSession session = request.getSession();
			String auth =session.getAttribute("auth") == null ? null : session.getAttribute("auth").toString();
			
			if(auth == null) {
				session.invalidate();
				return "Admin.jsp";
			}
			MemberDao dao=MemberDao.getInstance();
			String search=request.getParameter("search")==null? "All":request.getParameter("search");
			int count=0;
				if (search.equals("브론즈")) search="G0";
				if (search.equals("실버")) search="G1";
				if (search.equals("골드")) search="G2";
				if (search.equals("플라티넘")) search="G3";
				if (search.equals("다이아")) search="G4";
				if (search.equals("VIP")) search="G5";
				if (search.equals("탈퇴")) search="GG";
			if(search==null|| search.length()==0||search.equals("All")){
				
				count=dao.countUser();
			}else{
				count=dao.searchUserCount(search);
			}
			
			String pageNum=request.getParameter("pageNum");
			if(pageNum==null || pageNum.equals("")){
				pageNum="1";
			}
			
			int currentPage=Integer.parseInt(pageNum);
			int pageSize=10, blockSize=10;
			int startRow= ((currentPage-1)* pageSize)+1;
			int endRow= startRow+pageSize-1;
			int startNum=count-startRow+1;
			
			List<UsersDto> dto=dao.selectUser(search,startRow,endRow);
			
			int totalPage= (int) Math.ceil((double) count/pageSize); 
			int startPage=(int) (currentPage - 1)/ blockSize * blockSize + 1;
			int endPage= startPage+ blockSize-1;
			if(endPage> totalPage) endPage=totalPage;
			
			System.out.println("dto.size: "+dto.size());
			request.setAttribute("dto", dto);
			request.setAttribute("count", count);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("blockSize", blockSize);
			request.setAttribute("startNum", startNum);
			request.setAttribute("totalPage", totalPage);
			request.setAttribute("startPage",startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("search", search);
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return "userAdminList.jsp";
	}

}
