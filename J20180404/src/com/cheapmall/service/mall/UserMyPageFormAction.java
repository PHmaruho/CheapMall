package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.service.CommandProcess;

public class UserMyPageFormAction implements CommandProcess{
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			// session 을 나중에 받아와서 해당 정보를 Dto에 저장하여서 Request로 넘겨줄 예정
			// HttpSession session = request.getSession();
			HttpSession session = request.getSession();
			String id = (String) session.getAttribute("id");
			if(id == null) {
				request.setAttribute("warning", "notLogin");
				return "cheapmall.jsp";
			}
			//String id = "asdf";
			
			request.setAttribute("id", id);
			request.setAttribute("pageSet", "userMyPageForm.jsp");
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return "cheapmall.jsp";
	}
}
