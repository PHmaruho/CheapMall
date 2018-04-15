package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.MemberDao;
import com.cheapmall.dto.UsersDto;
import com.cheapmall.service.CommandProcess;

public class UserRegistProAction implements CommandProcess{
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			String nm = request.getParameter("nm");
			String zipcode = request.getParameter("zipcode") == null ? "" : request.getParameter("zipcode");
			String addr = request.getParameter("addr") == null ? "" : request.getParameter("addr");
			String addr_detail = request.getParameter("addr_detail") == null ? "" : request.getParameter("addr_detail");
			String tel1 = request.getParameter("tel1");
			String tel2 = request.getParameter("tel2");
			String tel3 = request.getParameter("tel3");
			String email = request.getParameter("mail");
			String birth = request.getParameter("birth");
			String gender = request.getParameter("gender");

			String[] tempBirth = birth.split("-");
			birth = tempBirth[0].substring(2, 4) + tempBirth[1] + tempBirth[2];
			
			String tel = tel1 + tel2 + tel3;
			
			UsersDto usersDto = new UsersDto();
			usersDto.setId(id);
			usersDto.setPw(pw);
			usersDto.setNm(nm);
			usersDto.setZipcode(zipcode);
			usersDto.setAddr(addr);
			usersDto.setAddr_detail(addr_detail);
			usersDto.setBirth(birth);
			usersDto.setEmail(email);
			usersDto.setGender(gender);
			usersDto.setTel(tel);
			MemberDao memberDao = MemberDao.getInstance();
			int result = memberDao.registUser(usersDto);
			
			request.setAttribute("result", result);
			request.setAttribute("pageSet", "userRegistPro.jsp");

		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("UserRegistProAction error");
			e.printStackTrace();
		}
		
		return "cheapmall.jsp";
	}
}
