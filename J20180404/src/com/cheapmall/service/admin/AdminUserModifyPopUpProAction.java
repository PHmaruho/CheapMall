package com.cheapmall.service.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.MemberDao;
import com.cheapmall.dto.UsersDto;
import com.cheapmall.service.CommandProcess;

public class AdminUserModifyPopUpProAction implements CommandProcess{
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			//HttpSession session = request.getSession(); // 꼭 확인할것!
			String pageNum = request.getParameter("pageNum");
			
			// SYSO
			
			UsersDto usersDto = new UsersDto();
			usersDto.setId(request.getParameter("id"));
			usersDto.setNm(request.getParameter("nm"));
			usersDto.setPw(request.getParameter("pw"));
			usersDto.setZipcode(request.getParameter("zipcode"));
			usersDto.setAddr(request.getParameter("addr"));
			usersDto.setAddr_detail(request.getParameter("addr_detail"));
			usersDto.setEmail(request.getParameter("email"));
			usersDto.setGender(request.getParameter("gender"));
			usersDto.setGrade(request.getParameter("grade"));
			usersDto.setPoint(Integer.parseInt(request.getParameter("point")));
			
			int result = 0;
			MemberDao memberDao = MemberDao.getInstance();
			result = memberDao.adminUpdateUser(usersDto);
			
			request.setAttribute("result", result);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("userId", usersDto.getId());
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("AdminUserModifyPopUpProAction Error");
			e.printStackTrace();
		}
		
		return "adminUserModifyPopUpPro.jsp";
	}
}
