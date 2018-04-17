package com.cheapmall.service.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.MemberDao;
import com.cheapmall.dto.AdminDto;
import com.cheapmall.dto.UsersDto;
import com.cheapmall.service.CommandProcess;

public class AdminUpdateFormAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		try {
			String id = request.getParameter("id");
			String pageNum = request.getParameter("pageNum");
			
			MemberDao md = MemberDao.getInstance();
			AdminDto adminDto = new AdminDto();
			
			adminDto = md.select(id);
			
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("adminDto", adminDto);
		
		}catch(Exception e) { 
			System.out.println(e.getMessage()); 
			
		}
		
		return "adminUpdateForm.jsp";
	}

}
