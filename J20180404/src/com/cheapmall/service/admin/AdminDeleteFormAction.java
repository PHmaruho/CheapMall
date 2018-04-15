package com.cheapmall.service.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.MemberDao;
import com.cheapmall.dto.AdminDto;
import com.cheapmall.service.CommandProcess;

public class AdminDeleteFormAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		try {
			String pageNum = request.getParameter("pageNum");
			
			MemberDao md = MemberDao.getInstance();
			AdminDto dto = md.select();
				request.setAttribute("pageNum", pageNum);
				request.setAttribute("dto", dto);
			
		}catch (Exception e) { System.out.println(e.getMessage()); }
		
		
		return "adminDeleteForm.jsp";
	}

}
