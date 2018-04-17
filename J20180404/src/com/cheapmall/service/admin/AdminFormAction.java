package com.cheapmall.service.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.MemberDao;
import com.cheapmall.dto.AdminDto;
import com.cheapmall.service.CommandProcess;

public class AdminFormAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		
		try {
			MemberDao md = MemberDao.getInstance();
			String search=request.getParameter("search");

			int count=0;	
			count=md.getCount();
			
			String pageNum = request.getParameter("pageNum");
			if(pageNum ==null || pageNum.equals("")) { pageNum="1"; } 
			int currentPage = Integer.parseInt(pageNum);
			int pageSize = 10,blockSize = 10; 
			int startRow = (currentPage -1) * pageSize + 1; 
			int endRow = startRow + pageSize - 1; 
			int startNum = count - startRow + 1; 			
			List<AdminDto> admin = md.adminList(startRow, endRow);

			int totalPage = (int)Math.ceil((double)count/pageSize);
			int startPage = (int)(currentPage-1)/blockSize*blockSize+1;
			int endPage = startPage + blockSize -1;
			if(endPage>totalPage) endPage = totalPage;
			
			request.setAttribute("adminList", admin);
			request.setAttribute("count", count);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("blockSize", blockSize);
			request.setAttribute("startNum", startNum);
			request.setAttribute("totalPage", totalPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("search", search);

			
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		return "adminForm.jsp";
		
	}

}
