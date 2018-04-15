package com.cheapmall.service.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.MemberDao;
import com.cheapmall.dto.UsersDto;
import com.cheapmall.service.CommandProcess;

public class AdminUserModifyPopUpAction implements CommandProcess{
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			//HttpSession session = request.getSession(); // 꼭 확인할것!
			String userId = request.getParameter("id");
			String pageNum = request.getParameter("pageNum");
			
			MemberDao memberDao = MemberDao.getInstance();
			UsersDto usersDto = new UsersDto();
			
			usersDto = memberDao.userGetInfo(userId);
			
			request.setAttribute("usersDto", usersDto);
			request.setAttribute("pageNum", pageNum);
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("AdminUserModifyPopUpAction Error");
			e.printStackTrace();
		}
		
		return "/admin/adminUserModifyPopUp.jsp";
	}
}
