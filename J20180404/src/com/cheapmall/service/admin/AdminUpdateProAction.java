package com.cheapmall.service.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.MemberDao;
import com.cheapmall.dto.AdminDto;
import com.cheapmall.service.CommandProcess;

public class AdminUpdateProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		try {
			request.setCharacterEncoding("utf-8");
			String pageNum = request.getParameter("pageNum");
			AdminDto dto = new AdminDto();
			dto.setPw(request.getParameter("pw"));
			dto.setNm(request.getParameter("nm"));
			dto.setDept(request.getParameter("dept"));
			dto.setPosition(request.getParameter("position"));
			dto.setTel(request.getParameter("tel"));
			dto.setEmail(request.getParameter("email"));
			dto.setPath(request.getParameter("path"));
			
			MemberDao md = MemberDao.getInstance();
			int result = md.adminUpdate(dto);
			
			request.setAttribute("result", result);
			request.setAttribute("pageNum", pageNum);
		}catch(Exception e) { System.out.println(e.getMessage()); }
		
		return "adminUpdatePro.jsp";
	}

}
