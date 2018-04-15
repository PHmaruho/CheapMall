package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.MemberDao;
import com.cheapmall.dto.UsersDto;
import com.cheapmall.service.CommandProcess;

public class UserModifyProAction implements CommandProcess{
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
			usersDto.setId(id);
			usersDto.setNm(request.getParameter("nm"));
			usersDto.setBirth(request.getParameter("birth"));
			usersDto.setTel(request.getParameter("tel") + request.getParameter("tel1")
							 + request.getParameter("tel2"));
			usersDto.setZipcode(request.getParameter("zipcode"));
			usersDto.setAddr(request.getParameter("addr"));
			usersDto.setAddr_detail(request.getParameter("addr_detail"));
			
			MemberDao memberDao = MemberDao.getInstance();
			
			int result = memberDao.usersInfoUpdate(usersDto);
			
			request.setAttribute("result", result);
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			
			System.out.println("UserModifyProAction Error");
			e.printStackTrace();
		}
		request.setAttribute("pageSet", "/mall/userModifyProform.jsp");
		return "/mall/cheapmall.jsp";
	}
}
