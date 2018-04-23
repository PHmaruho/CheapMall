package com.cheapmall.service.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.MemberDao;
import com.cheapmall.dto.AdminDto;
import com.cheapmall.service.CommandProcess;

public class AdminUpdateProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		try {
			HttpSession session = request.getSession();
			String auth =session.getAttribute("auth") == null ? null : session.getAttribute("auth").toString();
			
			if(auth == null) {
				session.invalidate();
				return "Admin.jsp";
			}
		//	String pageNum = request.getParameter("pageNum");

			AdminDto adminDto = new AdminDto();
			adminDto.setId(request.getParameter("id"));
			adminDto.setPw(request.getParameter("pw"));
			adminDto.setNm(request.getParameter("nm"));
			adminDto.setDept(request.getParameter("dept"));
			adminDto.setPosition(request.getParameter("position"));
			adminDto.setAuth(request.getParameter("auth"));
			adminDto.setTel(request.getParameter("tel"));
			adminDto.setEmail(request.getParameter("email"));
			adminDto.setPath(request.getParameter("path"));
			
			int result = 0;
			MemberDao md = MemberDao.getInstance();
			result = md.adminUpdate(adminDto);
			
			request.setAttribute("result", result);
	//		request.setAttribute("pageNum", pageNum);
	//		request.setAttribute("id", adminDto.getId());
			
		}catch(Exception e) { System.out.println(e.getMessage()); }
		
		return "adminUpdatePro.jsp";
	}

}
