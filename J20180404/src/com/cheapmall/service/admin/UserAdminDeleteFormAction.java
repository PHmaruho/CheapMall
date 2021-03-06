package com.cheapmall.service.admin;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.MemberDao;
import com.cheapmall.dto.UsersDto;
import com.cheapmall.service.CommandProcess;

public class UserAdminDeleteFormAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			
			MemberDao dao=MemberDao.getInstance();
			String search=request.getParameter("search");
			System.out.println("검색 Parameter 완료");
			
			
			int count=0;
			System.out.println("search: "+search);
			if(search==null|| search.length()==0){
				count=dao.countUser();
			}else{
				count=dao.searchUserCount(search);
			}
			
			
			String pageNum=request.getParameter("pageNum");
			if(pageNum==null || pageNum.equals("")){
				pageNum="1";
			}
			
			int currentPage=Integer.parseInt(pageNum);
			int pageSize=3, blockSize=3;
			
			int startRow= (currentPage-1)* pageSize+1;
			int endRow= startRow+pageSize-1;
			int startNum=count-startRow+1;
			List<UsersDto> dto=dao.selectUser(search,startRow,endRow);
			
			int totalPage= (int) Math.ceil((double) count/pageSize); 
			int startPage=(int) (currentPage - 1)/ blockSize * blockSize + 1;
			int endPage= startPage+ blockSize-1;
			if(endPage> totalPage) endPage=totalPage;
			
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
			
			System.out.println("count: "+count);
			System.out.println("currentPage: "+currentPage);
			System.out.println("blockSize: "+blockSize);
			System.out.println("totalPage: "+totalPage);
			System.out.println("startPage: "+startPage);
			System.out.println("endPage: "+endPage);
			System.out.println("pageNum: "+pageNum);
			System.out.println("search: "+search);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return "/admin/userAdminDeleteForm.jsp";
	}

}
