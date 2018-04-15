package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.MemberDao;
import com.cheapmall.dto.UsersDto;
import com.cheapmall.service.CommandProcess;

public class UserModifyFormAction implements CommandProcess{
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			// session 을 나중에 받아와서 해당 정보를 Dto에 저장하여서 Request로 넘겨줄 예정
			// String id = session.getAttribute("id");
			HttpSession session = request.getSession();
			String id = session.getAttribute("id").toString();
			
			UsersDto usersDto = new UsersDto();
			MemberDao memberDao = MemberDao.getInstance();
			usersDto = memberDao.userGetInfo(id);
			
			request.setAttribute("usersDto", usersDto);
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("###UserModifyFormAction Error");
			e.printStackTrace();
		}
		request.setAttribute("pageSet", "/mall/userModifyForm.jsp");
		return "/mall/cheapmall.jsp";
	}
}
