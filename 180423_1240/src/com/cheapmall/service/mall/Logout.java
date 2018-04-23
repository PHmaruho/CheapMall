package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.service.CommandProcess;

public class Logout implements CommandProcess{
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			HttpSession session = request.getSession();
			session.invalidate();
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("Logout Error");
			e.printStackTrace();
		}
		
		return "cheapmall.jsp";
	}
}
