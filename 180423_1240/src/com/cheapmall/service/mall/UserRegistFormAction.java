package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.service.CommandProcess;

public class UserRegistFormAction implements CommandProcess{
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			HttpSession session = request.getSession();
			String id = session.getAttribute("id") == null ? null: session.getAttribute("id").toString();
			
			if(id != null) {
				return "cheapmall.jsp";
			} else {
				request.setAttribute("pageSet", "userRegistForm.jsp");
			}
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("UserRegistFormAction Error");
			e.printStackTrace();
		}
		//return null;
		return "cheapmall.jsp";
	}
}
